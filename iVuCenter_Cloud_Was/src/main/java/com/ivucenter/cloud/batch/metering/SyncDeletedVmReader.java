package com.ivucenter.cloud.batch.metering;

import java.util.ArrayList;
import java.util.List;

import org.springframework.batch.item.ItemReader;
import org.springframework.batch.item.NonTransientResourceException;
import org.springframework.batch.item.ParseException;
import org.springframework.batch.item.UnexpectedInputException;
import org.springframework.beans.factory.annotation.Autowired;

import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.api.openstack.interfaces.AbstractFactory;
import com.ivucenter.cloud.api.openstack.interfaces.ServerIF;
import com.ivucenter.cloud.api.openstack.object.Flavor;
import com.ivucenter.cloud.api.openstack.object.Server;
import com.ivucenter.cloud.api.vRealize.interfaces.vraAbstractFactory;
import com.ivucenter.cloud.api.vRealize.interfaces.vraServerIF;
import com.ivucenter.cloud.api.vRealize.object.vraContent;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;
import com.ivucenter.cloud.portal.cmm.cloud.OssCloudService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class SyncDeletedVmReader implements ItemReader<Server> {

	private List<Server> serverList = null;
	

	@Autowired
	private OssCloudService ossCloudService;

	@Override
	public Server read() throws Exception, UnexpectedInputException, ParseException, NonTransientResourceException {
		
		initialize();
		
		if (this.serverList.isEmpty()) {
			this.serverList = null;
			return null;
		}

		return this.serverList.remove(0);
	}

	private void initialize() throws Exception {
		

		if(null != this.serverList) { return; }
		this.serverList = new ArrayList<>();
		
		List<CustomOssCloudVO> lists = ossCloudService.getCloudList();
	        
		for (CustomOssCloudVO cloudVo : lists) {
			
			if(cloudVo.getCloudType().equals("openstack")) {
				String projectName = "admin";
				// server 정보 가져오기
				ServerIF apiIF = AbstractFactory.getServerIF(projectName , cloudVo);
				try {
					List<Server> addServer = apiIF.getAllServers("&status=DELETED"); 
					serverList.addAll(apiIF.getAllServers("&status=DELETED"));
				} catch (InvaildOpenStackException | NotSupportGatewayException | NotConnectGatewayException e) {
					log.info(e.getMessage());
				}
			} else if(cloudVo.getCloudType().equals("vmware")){
				vraServerIF serverIF = vraAbstractFactory.getServerIF(cloudVo);
				List<vraContent> serverList = serverIF.deleteServer().getContent();
				for(vraContent server : serverList) {
					Server addServer = new Server();
					Flavor flavor = new Flavor();
					addServer.setId(server.getId());
					addServer.setName(server.getName());
					addServer.setTenant_id(server.getProjectId());
					addServer.setCreated(server.getCreatedAt());
					addServer.setUpdated(server.getLastUpdatedAt());
					flavor.setId(server.getInputs().getFlavor());
					addServer.setFlavor(flavor);
					this.serverList.add(addServer);
				}
			}
	    }
	}
}
