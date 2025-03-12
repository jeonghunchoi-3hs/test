package com.ivucenter.cloud.batch.metering;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.batch.item.ItemWriter;
import org.springframework.beans.factory.annotation.Autowired;

import com.ivucenter.cloud.api.openstack.connector.OpenStackRestConnector;
import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.api.openstack.interfaces.AbstractFactory;
import com.ivucenter.cloud.api.openstack.interfaces.FlavorIF;
import com.ivucenter.cloud.api.openstack.interfaces.ProjectIF;
import com.ivucenter.cloud.api.openstack.interfaces.VolumeIF;
import com.ivucenter.cloud.api.openstack.object.Address;
import com.ivucenter.cloud.api.openstack.object.Flavor;
import com.ivucenter.cloud.api.openstack.object.Project;
import com.ivucenter.cloud.api.openstack.object.Server;
import com.ivucenter.cloud.api.openstack.object.Volume;
import com.ivucenter.cloud.api.openstack.object.VolumnAttached;
import com.ivucenter.cloud.api.vRealize.interfaces.vraAbstractFactory;
import com.ivucenter.cloud.api.vRealize.interfaces.vraServerIF;
import com.ivucenter.cloud.api.vRealize.object.vraContent;
import com.ivucenter.cloud.api.vRealize.object.vraNetworks;
import com.ivucenter.cloud.api.vRealize.object.vraServer;
import com.ivucenter.cloud.batch.entity.BatchOssNetworkVO;
import com.ivucenter.cloud.batch.entity.BatchOssProjectVO;
import com.ivucenter.cloud.batch.entity.BatchOssVmNetworkVO;
import com.ivucenter.cloud.batch.entity.BatchOssVmVO;
import com.ivucenter.cloud.portal.bss.productOs.CustomBssProductOsVO;
import com.ivucenter.cloud.portal.bss.productOs.MngBssProductOsService;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;
import com.ivucenter.cloud.portal.cmm.cloud.OssCloudService;
import com.ivucenter.cloud.portal.util.DateUtils;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class SyncAlivedVmWriter implements ItemWriter<Server> {

    private static final Logger logger = LoggerFactory.getLogger(SyncAlivedVmWriter.class);


	private final String selectProjectById 	= "com.ivucenter.cloud.batch.metering.BatchMeteringDAO.selectProjectById";
	private final String selectVmById 		= "com.ivucenter.cloud.batch.metering.BatchMeteringDAO.selectVmById";
	private final String insertOssVm 		= "com.ivucenter.cloud.batch.metering.BatchMeteringDAO.insertOssVm";
	private final String updateOssVm 		= "com.ivucenter.cloud.batch.metering.BatchMeteringDAO.updateOssVm";
	private final String selectOssNetworkByName = "com.ivucenter.cloud.batch.metering.BatchMeteringDAO.selectOssNetworkByName";
	private final String selectOssVmNetwork = "com.ivucenter.cloud.batch.metering.BatchMeteringDAO.selectOssVmNetwork";
	private final String insertOssVmNetwork = "com.ivucenter.cloud.batch.metering.BatchMeteringDAO.insertOssVmNetwork";

    @Setter
	private SqlSessionFactory sqlSessionFactory;

    @Setter
	private Map<String, Object> parameterValues;

	private SqlSessionTemplate sqlSessionTemplate;

	@Autowired
	private OssCloudService ossCloudService;

	@Autowired
	private MngBssProductOsService mngBssProductOsService;



	class InCloudList {
    	private List<CustomOssCloudVO> list = null;
    	public void setCloudList(List<CustomOssCloudVO> inList) { this.list = inList; }
    	public CustomOssCloudVO getCloudVo(String cloudId) {
    		for(CustomOssCloudVO vo : this.list) {
    			if(vo.getCloudId().equals(cloudId)) { return vo; }
    		}
			return null;
    	}
    }
    private InCloudList inCloudList = null;

	@Override
	public void write(List<? extends Server> items) throws Exception {

		this.inCloudList = new InCloudList();
		this.inCloudList.setCloudList(ossCloudService.getCloudList());

		this.sqlSessionTemplate = new SqlSessionTemplate(sqlSessionFactory, ExecutorType.BATCH);

        for (Server item : items) {
        	//프로젝트가 존재하는 서버들에 대해 관리하도록 한다.
        	BatchOssProjectVO paramProjectVO = new BatchOssProjectVO();
			String projectId = item.getTenant_id();
        	paramProjectVO.setProjectId(projectId);
        	BatchOssProjectVO project = this.sqlSessionTemplate.selectOne(selectProjectById, paramProjectVO);

        	if (project != null) { 	//해당 서버의 프로젝트가 등록되어 있다면
        		//가상서버 정보 등록
        		CustomOssCloudVO cloudVo = this.inCloudList.getCloudVo(project.getCloudId());
        		setOssVm(item, cloudVo);

        		//가상서버 네트워크 정보 등록 및 수정
        		if(cloudVo.getCloudType().equals("openstack")) {
        			setVmNetworks(item,cloudVo);
        		}
        		if(cloudVo.getCloudType().equals("vmware")) {
        			setVraVmNetworks(item,cloudVo);
        		}
        	} else {
            	log.debug("[SKIPPED (PROJECT NOT FOUND)] " + item.toString());
        	}
        }
	}

	/***************************************************
	 * setOssVm : 가상서버 정보를 등록한다.
	 * @param server
	 * @throws Exception
	 ***************************************************/
	private void setOssVm(Server server, CustomOssCloudVO cloudVo) throws Exception {
    	String serverId = server.getId();
    	String serverName = server.getName();
		String projectId = server.getTenant_id();
		String imageId = "";
		String productSeq = "";
		String azName = server.getOS_EXT_AZ_availability_zone();

		String flavorId = "";
		Date createdDatetime = null;	//created=2017-06-08T10:26:52Z
		Date deletedDatetime = null;

		////////////////////////////////////
		///// flavor 정보 가져오기
		////////////////////////////////////
		int vcpus = 0;
		int memGb = 0;
		int diskGb = 0;
		String osProductSeq = "";


		if(cloudVo.getCloudType().equals("openstack")) {
			createdDatetime = DateUtils.convertUtcToDate(server.getCreated());
			FlavorIF flavorIf = AbstractFactory.getFlavorIF(cloudVo);
			Flavor flavor = null;
			try {
				flavor = flavorIf.getFlavor(server.getFlavor().getId());
			} catch (InvaildOpenStackException | NotSupportGatewayException | NotConnectGatewayException e) {
				log.error(e.getMessage());
			}

			if (flavor != null) {
				flavorId = flavor.getId();
				vcpus = flavor.getVcpus();
				memGb = flavor.getRam()/1024;
				//diskGb = flavor.getDisk();
			}

			List<VolumnAttached> volAttacedList = server.getOs_extended_volumes_volumes_attached();

			for (VolumnAttached volAttach : volAttacedList) {
				String volumeId = volAttach.getId(); //id='7c2554b9-4a62-47e3-85e7-d0c474c5720c'

				ProjectIF projectIF = AbstractFactory.getProject(cloudVo);
				Project volProject = projectIF.getProject(projectId);
				String volProjectName = volProject.getName();

				VolumeIF volumeIF = AbstractFactory.getVolumeIF(volProjectName, cloudVo);
				Volume obj = volumeIF.getVolume(volumeId);


				if( obj.getVolume_image_metadata() != null) {
					osProductSeq = obj.getVolume_image_metadata().getImage_id();
					imageId = obj.getVolume_image_metadata().getImage_id();
				}

				if (obj.getBootable().equals("true")){
					diskGb = obj.getSize();
				}
			}
		} else if(cloudVo.getCloudType().equals("vmware")) {
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			createdDatetime = format.parse(server.getCreated());

			vcpus = Integer.parseInt(server.getvCpu());
			memGb = Integer.parseInt(server.getMemory());
			imageId = server.getImageId();
			flavorId = server.getFlavorId();
		}

		//////////////////////////////////
		/////가상서버 정보 등록 및 수정
		//////////////////////////////////
		if( imageId != null) {
			CustomBssProductOsVO paramBean = new CustomBssProductOsVO();
			paramBean.setVmImageId( imageId);
			CustomBssProductOsVO returnBean = mngBssProductOsService.productSeqReturn( paramBean);

			if( returnBean != null && returnBean.getProductSeq() != null) {
				productSeq = returnBean.getProductSeq();
			}

		}

		BatchOssVmVO paramVmVO = new BatchOssVmVO();
		paramVmVO.setVmUuid(serverId);
		BatchOssVmVO selectVm = this.sqlSessionTemplate.selectOne(selectVmById, paramVmVO);
		if (selectVm == null) {	// 서버가 기존에 존재하지 않다면
			insertVm(serverId
					, serverName
					, projectId
					, vcpus
					, memGb
					, diskGb
					, createdDatetime
					, deletedDatetime
					, flavorId
					, imageId
					, productSeq
					, azName
					);
		} else {
    		//기존에 서버가 존재한다면 생성일자를 등록되어 있지 않다면 변경한다.
    		if (selectVm.getDeleteDatetime() == null) {
    			updateVm(selectVm
    					, serverName
    					, projectId
    					, vcpus
    					, memGb
    					, diskGb
    					, createdDatetime
    					, deletedDatetime
    					, flavorId
    					, imageId
    					, productSeq
    					, azName
    					);
    		}
		}
	}

	/***************************************************
	 * insertVm : 가상서버를 신규로 등록한다.
	 ***************************************************/
	private void insertVm(String serverId
			, String serverName
			, String projectId
			, int vcpus
			, int memGb
			, int diskGb
			, Date createdDatetime
			, Date deletedDatetime
			, String flavorId
			, String imageId
			, String productSeq
			, String azName
			) {
		//기존에 서버가 존재하지 않다면 신규로 등록한다.
		BatchOssVmVO insertVm = new BatchOssVmVO();
		insertVm.setVmUuid( serverId);
		insertVm.setProjectId( projectId);
		insertVm.setHostname( serverName);
		insertVm.setHostnameAlias( serverName);
		insertVm.setVcpus( vcpus);
		insertVm.setMemGb( memGb);
		insertVm.setDiskGb( diskGb);
		insertVm.setVmProductSeq( null);
		insertVm.setOsProductSeq( productSeq);
		insertVm.setDescription( null);
		insertVm.setCreateDatetime( createdDatetime);
		insertVm.setExpireDatetime( deletedDatetime);
		insertVm.setDeleteDatetime( deletedDatetime);
		insertVm.setRegDatetime( new Date());
		insertVm.setRegUserId( "SYNC_BATCH");
		insertVm.setModDatetime( null);
		insertVm.setModUserId( null);
		insertVm.setDelFlag( "N");
		insertVm.setHourlyFlag( "N");
		insertVm.setFlavorId( flavorId);
		insertVm.setImageId( imageId);
		insertVm.setAzName( azName);

		this.sqlSessionTemplate.insert(insertOssVm, insertVm);
	}


	/***************************************************
	 * updateVm : 가상서버 정보를 수정한다.
	 ***************************************************/
	private void updateVm(BatchOssVmVO selectVm
			, String serverName, String projectId
			, int vcpus
			, int memGb
			, int diskGb
			, Date createdDatetime
			, Date deletedDatetime
			, String flavorId
			, String imageId
			, String productSeq
			, String azName
			) {
		BatchOssVmVO updateVm = selectVm;

		if (selectVm.getCreateDatetime() == null) updateVm.setCreateDatetime(createdDatetime);

		updateVm.setHostname( serverName);
		updateVm.setProjectId( projectId);
		updateVm.setVcpus( vcpus);
		updateVm.setMemGb( memGb);
		updateVm.setDiskGb( diskGb);
		updateVm.setFlavorId( flavorId);
		updateVm.setImageId( imageId);
		updateVm.setOsProductSeq( productSeq);

		this.sqlSessionTemplate.update(updateOssVm, updateVm);
	}


	/***************************************************
	 * setVmNetworks : 가상서버의 네트워크 정보를 맵핑한다.
	 ***************************************************/
	private void setVmNetworks(Server server,CustomOssCloudVO cloudVo) {
    	String serverId = server.getId();
		String projectId = server.getTenant_id();
		Map<String, List<Address>> addressMap = server.getAddresses();

		for (Map.Entry<String, List<Address>> entry : addressMap.entrySet()) {
			String networkName = entry.getKey();

			BatchOssNetworkVO paramNetworkVO = new BatchOssNetworkVO();
			paramNetworkVO.setProjectId(projectId);
			paramNetworkVO.setNetworkName(networkName);
			BatchOssNetworkVO selectNetworkVO = this.sqlSessionTemplate.selectOne(selectOssNetworkByName, paramNetworkVO);
			if (selectNetworkVO != null) {	//해당 프로젝트에서 네트워크가 존재한다면
				String networkId = selectNetworkVO.getNetworkId();
				BatchOssVmNetworkVO paramVmNetworkVO = new BatchOssVmNetworkVO();
				paramVmNetworkVO.setNetworkId(networkId);
				paramVmNetworkVO.setVmUuid(serverId);

				BatchOssVmNetworkVO selectVmNetworkVO = this.sqlSessionTemplate.selectOne(selectOssVmNetwork, paramVmNetworkVO);
				if (selectVmNetworkVO == null) {
					BatchOssVmNetworkVO insertVmNetworkVO = paramVmNetworkVO;

					this.sqlSessionTemplate.insert(insertOssVmNetwork, insertVmNetworkVO);
				}
			}
		}
	}

	private void setVraVmNetworks(Server server,CustomOssCloudVO cloudVo) {
		vraServerIF vraServerIF = vraAbstractFactory.getServerIF(cloudVo);
    	String serverId = server.getId();
		String projectId = server.getTenant_id();

		BatchOssNetworkVO paramNetworkVO = new BatchOssNetworkVO();
		paramNetworkVO.setProjectId(projectId);
		vraServer depInfo;
		try {
			depInfo = vraServerIF.getDepInfo(serverId);
			List<vraContent> contents = depInfo.getContent();
			for(vraContent content : contents) {
				if(content.getType().equals("Cloud.vSphere.Machine")) {
					List<vraNetworks> networkList = content.getProperties().getNetworks();
					BatchOssVmNetworkVO paramVmNetworkVO = new BatchOssVmNetworkVO();
					for(vraNetworks network : networkList) {
						String portId = network.getName();
						String networkAry[] = network.getId().split("/");
						String networkId = networkAry[3];
						if(!network.getName().equals("OA-Backup")) {
							paramNetworkVO.setNetworkName(portId);
							paramVmNetworkVO.setNetworkId(portId);
							paramVmNetworkVO.setVmUuid(serverId);
							paramVmNetworkVO.setPortNetworkId(networkId);
						}
						if(network.getName().equals("OA-Backup")) {
							paramVmNetworkVO.setBackupNetworkId(portId);
							paramVmNetworkVO.setPortBackupNetworkId(networkId);
						}
					}
					BatchOssVmNetworkVO selectVmNetworkVO = this.sqlSessionTemplate.selectOne(selectOssVmNetwork, paramVmNetworkVO);
					if (selectVmNetworkVO == null) {
						BatchOssVmNetworkVO insertVmNetworkVO = paramVmNetworkVO;
						this.sqlSessionTemplate.insert(insertOssVmNetwork, insertVmNetworkVO);
					}
				}
			}
		} catch (NotConnectGatewayException | NotSupportGatewayException | InvaildOpenStackException e) {
			logger.error("setVraVmNetworks Exception");
		}
	}
}
