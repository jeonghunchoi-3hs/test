package com.ivucenter.cloud.batch.metering.nutanix;

import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.apache.commons.lang.time.DateFormatUtils;
import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.batch.item.ItemWriter;

import com.google.gson.JsonArray;
import com.ivucenter.cloud.api.nutanix.NutanixObject;
import com.ivucenter.cloud.api.nutanix.NutanixUtils;
import com.ivucenter.cloud.batch.entity.BatchBssProductOsVO;
import com.ivucenter.cloud.batch.entity.BatchOssDiskVO;
import com.ivucenter.cloud.batch.entity.BatchOssFlavorVO;
import com.ivucenter.cloud.batch.entity.BatchOssNetworkVO;
import com.ivucenter.cloud.batch.entity.BatchOssPortVO;
import com.ivucenter.cloud.batch.entity.BatchOssProjectVO;
import com.ivucenter.cloud.batch.entity.BatchOssVmNetworkVO;
import com.ivucenter.cloud.batch.entity.BatchOssVmVO;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;
import com.ivucenter.cloud.portal.req.product.CustomReqProductVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class SyncOpenStackAvailWriter implements ItemWriter<CustomOssCloudVO> {


	private final String selectProjectById 	= "com.ivucenter.cloud.batch.metering.BatchMeteringDAO.selectProjectById";
	private final String selectVmById 	= "com.ivucenter.cloud.batch.metering.BatchMeteringDAO.selectVmById";
	private final String insertOssVm 		= "com.ivucenter.cloud.batch.metering.BatchMeteringDAO.insertOssVm";
	private final String insertOssPort 		= "com.ivucenter.cloud.batch.metering.BatchMeteringDAO.insertOssPort";
	private final String insertOssVmNetwork 		= "com.ivucenter.cloud.batch.metering.BatchMeteringDAO.insertOssVmNetwork";
	private final String getOssDiskCheck 		= "com.ivucenter.cloud.batch.metering.BatchMeteringDAO.getOssDiskCheck";
	private final String selectOssFlavor 		= "com.ivucenter.cloud.batch.metering.BatchMeteringDAO.selectOssFlavor";
	private final String selectOssZoneNetwork 		= "com.ivucenter.cloud.batch.metering.BatchMeteringDAO.selectOssZoneNetwork";
	private final String insertOssDiskNutanix 		= "com.ivucenter.cloud.batch.metering.BatchMeteringDAO.insertOssDiskNutanix";
	private final String selectBssProductOs 		= "com.ivucenter.cloud.batch.metering.BatchMeteringDAO.selectBssProductOs";
	private final String updateOssDiskToDiskGb 		= "com.ivucenter.cloud.batch.metering.BatchMeteringDAO.updateOssDiskToDiskGb";
	
	
	
	
	
    @Setter
	private SqlSessionFactory sqlSessionFactory;

	private SqlSessionTemplate sqlSessionTemplate;

	@Override
	public void write(List<? extends CustomOssCloudVO> items) throws Exception {
		this.sqlSessionTemplate = new SqlSessionTemplate(sqlSessionFactory, ExecutorType.SIMPLE);


	    for (CustomOssCloudVO cloudVo : items) {
	    	
	    	if(cloudVo.getCloudType().equals("nutanix")) {
	    		
	    		
	
			NutanixObject apps = NutanixUtils.getAppList(cloudVo);
			for (NutanixObject nutanixObject : apps.getApps()) {
				log.info("name : " + nutanixObject.getObject("metadata").getValue("name"));
				log.info("uuid : " + nutanixObject.getObject("metadata").getValue("uuid"));
				log.info("project_id : " + nutanixObject.getObject("metadata").getObject("project_reference").getValue("uuid"));
				log.info("image_id : " + nutanixObject.getObject("status").getObject("resources").getObject("app_blueprint_reference").getValue("name"));
				
				log.info("host_name : " + nutanixObject.getObject("status").getValue("name"));
				
				
				String host_name = nutanixObject.getObject("status").getValue("name").toString();

				
				
				
				String image_name_temp = nutanixObject.getObject("status").getObject("resources").getObject("app_blueprint_reference").getValue("name").toString();
	    		String image_name =  image_name_temp.substring(0 , image_name_temp.length()-9);           

				
	        	BatchOssProjectVO batchOssProjectVO = new BatchOssProjectVO();

	        	batchOssProjectVO.setProjectId((String)nutanixObject.getObject("metadata").getObject("project_reference").getValue("uuid"));
	        	BatchOssProjectVO project = this.sqlSessionTemplate.selectOne(selectProjectById, batchOssProjectVO);
	        	
	        	//포탈에 프로젝트가 등록되어 있다면
	        	if (project != null) { 	

	        		NutanixObject app = NutanixUtils.getApp(cloudVo, (String)nutanixObject.getObject("metadata").getValue("uuid"));
					log.info("app---vm_name : "+app.getVmName());
					log.info("app---vm_uuid : "+app.getVmUuid());
					
					
					BatchOssVmVO batchOssVmVO = new BatchOssVmVO();
					batchOssVmVO.setVmUuid(app.getVmUuid());
					BatchOssVmVO vm = this.sqlSessionTemplate.selectOne(selectVmById, batchOssVmVO);
					
					
					
					BatchBssProductOsVO batchBssProductOsVO = new BatchBssProductOsVO();
					
					
					batchBssProductOsVO.setCloudId(cloudVo.getCloudId());
					
					
					
					
					String[] image_name_split = image_name.split("__");
					image_name = image_name_split[0];
					
					batchBssProductOsVO.setVmImageName(image_name);
					
					
					BatchBssProductOsVO bssProductOs = this.sqlSessionTemplate.selectOne(selectBssProductOs, batchBssProductOsVO);
					
					
					NutanixObject vmdetail = NutanixUtils.getVmDetail(cloudVo, app.getVmUuid());
					String host_uuid = (String) vmdetail.getValue("host_uuid");
					
					
			      	String fixed_ips = (String) vmdetail.getArray("vm_nics", null).get(0).getValue("ip_address");
			      	String network_uuid = (String) vmdetail.getArray("vm_nics", null).get(0).getValue("network_uuid");
			      	String mac_address = (String) vmdetail.getArray("vm_nics", null).get(0).getValue("mac_address");
			      	
					
					BatchOssNetworkVO batchOssNetworkVO = new BatchOssNetworkVO();
			      	batchOssNetworkVO.setNetworkId(network_uuid);
			      	BatchOssNetworkVO zoneNetwork = this.sqlSessionTemplate.selectOne(selectOssZoneNetwork, batchOssNetworkVO);					
					

			     	//포탈에 가상서버 등록 여부
		        	if (vm == null && bssProductOs != null) { 	
			      	
			      	JsonArray variables = vmdetail.getJson().getAsJsonArray("vm_nics").get(0).getAsJsonObject().getAsJsonArray("ip_addresses");
						for (int i = 0; i < variables.size(); i++) {
							String temp_ip = variables.get(i).toString().replaceAll("\\\"", "");
							if(!fixed_ips.equals(temp_ip)) {
								fixed_ips = temp_ip;
								 break;
							}
						}
			      	
			      	int memory_mb = (int) vmdetail.getValue("memory_mb");
			      	int num_cores_per_vcpu = (int) vmdetail.getValue("num_cores_per_vcpu");
			      	int num_vcpus = (int) vmdetail.getValue("num_vcpus");
	
			      	int mem_gb = memory_mb / 1024;
			      	int vcpus = num_vcpus * num_cores_per_vcpu;
			      	
			      	
			      	BatchOssFlavorVO batchOssFlavorVO = new BatchOssFlavorVO();
			      	
			      	batchOssFlavorVO.setCloudId(cloudVo.getCloudId());
			      	batchOssFlavorVO.setRamMb(memory_mb);
			      	batchOssFlavorVO.setVcpus(vcpus);
			      	
					BatchOssFlavorVO flavor = this.sqlSessionTemplate.selectOne(selectOssFlavor, batchOssFlavorVO);

			      	
			      	// vm insert
			      	log.info("vm------vm_uuid : "+app.getVmUuid());
			      	log.info("vm------project_id : "+nutanixObject.getObject("metadata").getObject("project_reference").getValue("uuid"));
			      	log.info("vm------hostname : "+app.getVmName());
			      	log.info("vm------hostname_alias : "+app.getVmName());
			      	log.info("vm------flaver_id 조회해서 가져오기");
			      	
			      	log.info("vm------vcpus");
			      	log.info("vm------mem_gb");
			      	log.info("vm------disk_gb");
			      	
			      	log.info("vm------image_id");
			      	log.info("vm------host_uuid : "+vmdetail.getValue("host_uuid"));
					log.info("vm------fixed_ips : "+vmdetail.getArray("vm_nics", null).get(0).getValue("ip_address"));
					log.info("vm------power_state : "+vmdetail.getValue("power_state"));
					
					
					BatchOssVmVO insertVm = new BatchOssVmVO();
					insertVm.setVmUuid( app.getVmUuid());
					insertVm.setProjectId(nutanixObject.getObject("metadata").getObject("project_reference").getValue("uuid").toString());
					insertVm.setHostname(host_name);
					insertVm.setHostnameAlias(host_name);
					insertVm.setFlavorId(flavor.getFlavorId());
					insertVm.setVcpus(vcpus);
					insertVm.setMemGb(mem_gb);
					// 아래 oss_disk insert 할때 update
					insertVm.setDiskGb(0);
					insertVm.setVolumeType(zoneNetwork.getVolumeType());
					insertVm.setAzName(zoneNetwork.getZoneName());
					insertVm.setOsProductSeq(bssProductOs.getProductSeq());
					insertVm.setImageId(bssProductOs.getVmImageId());
					insertVm.setDescription(null);
					insertVm.setCreateDatetime( new Date());
					insertVm.setExpireDatetime(null);
					insertVm.setDeleteDatetime(null);
					insertVm.setRegDatetime( new Date());
					insertVm.setRegUserId("SYNC_NT_BATCH");
					insertVm.setModDatetime(null);
					insertVm.setModUserId(null);
					insertVm.setDelFlag("N");
					insertVm.setHourlyFlag("N");					
					insertVm.setHostUuid(host_uuid);
					
					this.sqlSessionTemplate.insert(insertOssVm, insertVm);
					

					
					// OSS_PORT 정보저장
					BatchOssPortVO port = new BatchOssPortVO();
					String uuid = UUID.randomUUID().toString();
					port.setPortId(uuid);
					port.setPortName(fixed_ips);
					port.setFixedIps(fixed_ips);
					port.setDeviceId(app.getVmUuid());
					port.setMacAddress(mac_address);
					port.setProjectId(nutanixObject.getObject("metadata").getObject("project_reference").getValue("uuid").toString());
					port.setNetworkId(network_uuid);
					port.setRegUserId("SYNC_NT_BATCH");
					port.setRegDatetime( new Date());

					
					
					 this.sqlSessionTemplate.insert(insertOssPort, port);
					
					BatchOssVmNetworkVO vmNetwork = new BatchOssVmNetworkVO();
					vmNetwork.setVmUuid(app.getVmUuid());

					vmNetwork.setNetworkId(network_uuid);
					vmNetwork.setRegUserId("SYNC_NT_BATCH");
					vmNetwork.setRegDatetime(DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss"));
					
					
					 this.sqlSessionTemplate.insert(insertOssVmNetwork, vmNetwork);

		        	}
					
		        	
					BatchOssVmVO vmCheckUseDiskInsert = this.sqlSessionTemplate.selectOne(selectVmById, batchOssVmVO);

		        	if (vmCheckUseDiskInsert != null ) { 	


					List<NutanixObject> vmDiskList = vmdetail.getVDisks();

						for (NutanixObject nutanix : vmDiskList) {
							CustomReqProductVO res = new CustomReqProductVO();
							
							boolean is_cdrom =   (boolean) nutanix.getValue("is_cdrom");
	
							String vmdisk_uuid  = (String) nutanix.getObject("disk_address").getValue("vmdisk_uuid");
							
							CustomReqProductVO customReqProductVO = new CustomReqProductVO();
							customReqProductVO.setVmdiskUuid(vmdisk_uuid);
							
							res = this.sqlSessionTemplate.selectOne(getOssDiskCheck, customReqProductVO);
							
							if(res == null && is_cdrom == false) {
							
							
							String device_uuid = (String) nutanix.getObject("disk_address").getValue("device_uuid");
							long disk_size = (long) nutanix.getValue("size");
							String device_bus = (String) nutanix.getObject("disk_address").getValue("device_bus");
							int device_index = (int) nutanix.getObject("disk_address").getValue("device_index");
							String storage_container_uuid = (String) nutanix.getValue("storage_container_uuid");
	
							long diskGb = disk_size/1024/1024/1024;
							
							BatchOssDiskVO req = new BatchOssDiskVO();								
								req.setDiskId(vmdisk_uuid);
								req.setVmUuid(app.getVmUuid());
								req.setDeviceUuid(device_uuid);
								req.setStorageContainerUuid(storage_container_uuid);
								req.setProjectId(nutanixObject.getObject("metadata").getObject("project_reference").getValue("uuid").toString());
								req.setSizeGb((int)diskGb);
								
								if(device_bus.equals("scsi") && device_index == 0) {
									req.setDiskAlias(host_name+ "-OS");
									
									this.sqlSessionTemplate.update(updateOssDiskToDiskGb, req);
								}else {
									req.setDiskAlias(host_name+ "-"+device_index);
								}
							
								req.setRegUserId("SYNC_NT_BATCH");
								req.setRegDatetime(new Date());
								req.setCreateDatetime(new Date());
								req.setVolumeType(zoneNetwork.getVolumeType());
								
								   this.sqlSessionTemplate.insert(insertOssDiskNutanix, req);
								
						}
					}

				}
			}

		}

	}

}
}

}
