package com.ivucenter.cloud.batch.metering;

import java.util.ArrayList;
import java.util.List;

import org.springframework.batch.item.ItemReader;
import org.springframework.batch.item.NonTransientResourceException;
import org.springframework.batch.item.ParseException;
import org.springframework.batch.item.UnexpectedInputException;
import org.springframework.beans.factory.annotation.Autowired;

import com.ivucenter.cloud.api.AbstractFactory;
import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.api.openstack.interfaces.ServerIF;
import com.ivucenter.cloud.api.openstack.object.Server;
import com.ivucenter.cloud.api.vRealize.interfaces.vraAbstractFactory;
import com.ivucenter.cloud.api.vRealize.interfaces.vraDiskIF;
import com.ivucenter.cloud.api.vRealize.interfaces.vraServerIF;
import com.ivucenter.cloud.api.vRealize.object.vraDiskContent;
import com.ivucenter.cloud.api.vRealize.object.vraMachine;
import com.ivucenter.cloud.api.vRealize.object.vraServer;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;
import com.ivucenter.cloud.portal.cmm.cloud.OssCloudService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class SyncAlivedVmReader implements ItemReader<Server> {

	private List<Server> serverList = null;

	@Autowired
	private OssCloudService ossCloudService;

	@Override
	public Server read() throws Exception, UnexpectedInputException, ParseException, NonTransientResourceException {

		initialize();

		if(this.serverList.isEmpty()) {
			this.serverList = null;
			return null;
		}

		return this.serverList.remove(0);
	}

	private void initialize() throws NotConnectGatewayException, InvaildOpenStackException, NotSupportGatewayException {

		if(null != this.serverList ) { return ; }
		this.serverList = new ArrayList<>();

		List<CustomOssCloudVO> lists = ossCloudService.getCloudList();
        for (CustomOssCloudVO cloudVo : lists) {

        	if(cloudVo.getCloudType().equals("openstack")) {
        		try {
        			// 강성범 대리님 admin 프로젝트가 아닌 다른프로젝트 동기화
        			String projectName = "admin";       // 변경위치 	
        			ServerIF apiIF = AbstractFactory.getServerIF(projectName, cloudVo);	// server 정보 가져오기    		
        			List<Server> getList = apiIF.getAllServers(""); // openstack의 vm 정보 수집
        			getList.forEach(value -> {
        				Server srv = (Server) value;
        				log.debug("get Cloud VMs Info : {} {}", srv.getName(), srv.getHostId());
        			});
        			this.serverList.addAll(getList);
        		} catch (InvaildOpenStackException | NotSupportGatewayException | NotConnectGatewayException e) {
        			log.info(e.getMessage()); 
        		}
        	}
        	else if(cloudVo.getCloudType().equals("vmware")) {
        		try {
        			vraServerIF serverIF = vraAbstractFactory.getServerIF(cloudVo);
        			vraDiskIF diskIF = vraAbstractFactory.getDiskIF(cloudVo);
        			List<vraMachine> machines = serverIF.getMachines().getContent();
        			for(vraMachine machine : machines) {
        				if(machine.getProjectId() != null && machine.getDeploymentId() != null) {
        					vraServer vraServer = serverIF.getServer(machine.getDeploymentId());
        					Server server = new Server();
        					server.setId(machine.getDeploymentId());
        					server.setImageId(vraServer.getCatalogItemId());
        					server.setFlavorId(vraServer.getInputs().getFlavor());
        					server.setTenant_id(machine.getProjectId());
        					server.setName(machine.getName());
        					server.setCreated(machine.getCreatedAt());
        					
        					server.setMemory(Integer.toString(machine.getCustomProperties().getMemoryInMB() / 1024));
        					List<vraDiskContent> diskList = diskIF.getDiskInfo(machine.getId()).getContent();
        					server.setvCpu(Integer.toString(machine.getCustomProperties().getCpuCount()));
							for(vraDiskContent disk : diskList) {
								if(disk.getType().equals("HDD")) {
									server.setDisk(server.getDisk() + Integer.parseInt(disk.getCapacityInGB()));
								}
							}
							this.serverList.add(server);
        				}
        				
        			}
        		} catch (InvaildOpenStackException | NotSupportGatewayException | NotConnectGatewayException e) {
        			
        		}
        	}
        }
	}
}
