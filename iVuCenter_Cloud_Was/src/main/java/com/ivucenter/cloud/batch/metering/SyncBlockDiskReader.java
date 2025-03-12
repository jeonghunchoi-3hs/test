package com.ivucenter.cloud.batch.metering;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.batch.item.ItemReader;
import org.springframework.batch.item.NonTransientResourceException;
import org.springframework.batch.item.ParseException;
import org.springframework.batch.item.UnexpectedInputException;
import org.springframework.beans.factory.annotation.Autowired;

import com.ivucenter.cloud.api.AbstractFactory;
import com.ivucenter.cloud.api.openstack.interfaces.ProjectIF;
import com.ivucenter.cloud.api.openstack.interfaces.VolumeIF;
import com.ivucenter.cloud.api.openstack.object.Project;
import com.ivucenter.cloud.api.openstack.object.Volume;
import com.ivucenter.cloud.api.openstack.object.VolumeAttachment;
import com.ivucenter.cloud.api.openstack.object.VolumeImageMetadata;
import com.ivucenter.cloud.api.vRealize.interfaces.vraAbstractFactory;
import com.ivucenter.cloud.api.vRealize.interfaces.vraDiskIF;
import com.ivucenter.cloud.api.vRealize.interfaces.vraServerIF;
import com.ivucenter.cloud.api.vRealize.object.vraContent;
import com.ivucenter.cloud.api.vRealize.object.vraDiskContent;
import com.ivucenter.cloud.api.vRealize.object.vraServer;
import com.ivucenter.cloud.batch.entity.BatchOssDiskVO;
import com.ivucenter.cloud.batch.entity.BatchOssProjectVO;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;
import com.ivucenter.cloud.portal.cmm.cloud.OssCloudService;
import com.ivucenter.cloud.portal.util.DateUtils;

//@Slf4j
public class SyncBlockDiskReader implements ItemReader<BatchOssDiskVO> {

	private List<BatchOssDiskVO> volumeList = null;	

	@Autowired
	private OssCloudService ossCloudService;

	@Override
	public BatchOssDiskVO read() throws Exception, UnexpectedInputException, ParseException, NonTransientResourceException {

		initialize();

		if (this.volumeList.isEmpty()) {
			this.volumeList = null;
			return null;
		}

		return volumeList.remove(0);
	}

	private void initialize() throws Exception {

		if(null != this.volumeList) { return ; }
		this.volumeList = new ArrayList<>();

		List<CustomOssCloudVO> cloudlists = ossCloudService.getCloudList();
		for (CustomOssCloudVO cloudVo : cloudlists) {

			if(cloudVo.getCloudType().equals("openstack")) {
					Map<String, String> projectMap = new HashMap<String, String>();
					
					ProjectIF projectIf = AbstractFactory.getProject(cloudVo);
			        List<Project> projects = projectIf.getProjects();
			        for (Project project : projects) {
			        	BatchOssProjectVO paramProjectVO = new BatchOssProjectVO();
			        	paramProjectVO.setProjectId(project.getId());
		
			        	if(!project.getName().equals("demo") && !project.getName().equals("service") && !project.getName().equals("services")) {
			        		projectMap.put(project.getId(), project.getName());
			        		//  정희철 추가 - volume 정보 가져오기 로직 수정
			        		VolumeIF volumeIf = AbstractFactory.getVolumeIF(project.getName(), cloudVo);
		                	List<Volume> Volumes = volumeIf.getVolumes();
		                	for (Volume volume : Volumes) {
		                		BatchOssDiskVO diskVO = new BatchOssDiskVO();
		            			diskVO.setDiskId(volume.getId());
		            			diskVO.setDiskAlias(volume.getName());
		            			diskVO.setProjectId(project.getId());
		            			diskVO.setSizeGb(volume.getSize());
		            			diskVO.setCloudId(cloudVo.getCloudId());
		            			diskVO.setCloudType(cloudVo.getCloudType());
		            			diskVO.setVolumeType(volume.getVolume_type());
		
		            			if (volume.getCreated_at() != null && !"".equals(volume.getCreated_at())) {
		            				diskVO.setCreateDatetime(DateUtils.convertStringToDate(volume.getCreated_at(), "Asia/Seoul", "yyyy-MM-dd'T'HH:mm:ss"));
		            				diskVO.setRegDatetime(DateUtils.convertStringToDate(volume.getCreated_at(), "Asia/Seoul", "yyyy-MM-dd'T'HH:mm:ss"));
		            			}
		
		        				List<VolumeAttachment> volumeAttachments = volume.getAttachments();
		        				if (volumeAttachments != null && volumeAttachments.size() > 0  ) {
		        					diskVO.setVmUuid(volumeAttachments.get(0).getServer_id());
		        					diskVO.setDevice(volumeAttachments.get(0).getDevice());
		        				}
		
		        				VolumeImageMetadata volumeImageMetadata = volume.getVolume_image_metadata();
		        				if (volumeImageMetadata != null ) {
		        					diskVO.setImageId(volumeImageMetadata.getImage_id());
		        				}
		
		        				this.volumeList.add(diskVO);
		                	} // end of volumeList
		                }
			        } // end of projectList
				} else if(cloudVo.getCloudType().equals("vmware")) {
					vraServerIF serverIF = vraAbstractFactory.getServerIF(cloudVo);
					vraDiskIF diskIF = vraAbstractFactory.getDiskIF(cloudVo);
					List<vraContent> serverList = serverIF.getServers("").getContent();
					for(vraContent server : serverList) {
						vraServer depInfo = serverIF.getDepInfo(server.getId());
						List<vraContent> contents = depInfo.getContent();
						for(vraContent content : contents) {
							if(content.getType().equals("Cloud.vSphere.Machine") && content.getState().equals("OK")) {
								List<vraDiskContent> diskList = diskIF.getDiskInfo(content.getId()).getContent();
								for(vraDiskContent disk : diskList) {
									if(disk.getType().equals("HDD")) {
										BatchOssDiskVO diskVO = new BatchOssDiskVO();
										diskVO.setCloudId(cloudVo.getCloudId());
				            			diskVO.setCloudType(cloudVo.getCloudType());
										diskVO.setDiskId(disk.getId());
				            			diskVO.setDiskAlias(disk.getName());
				            			diskVO.setProjectId(disk.getProjectId());
				            			diskVO.setSizeGb(Integer.parseInt(disk.getCapacityInGB()));
				            			diskVO.setVolumeType(disk.getType());
				            			diskVO.setVmUuid(server.getId());
				            			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
				            			Date date = format.parse(disk.getCreatedAt());
				            			diskVO.setCreateDatetime(date);
			            				diskVO.setRegDatetime(date);
			            				diskVO.setVmUuid(server.getId());
			        					diskVO.setDevice("");
			        					diskVO.setImageId("");
			        					this.volumeList.add(diskVO);
									}
								}
								
							}
						}
					}
				}// end of cloudList
			}
	}

		// volume 정보 가져오기
//		CustomIF customIf = AbstractFactory.getCustomIF();
//		List<CustomVolume> customVolumes = null;
//
//		customVolumes = customIf.getAllVolumes();
//
//		for (CustomVolume customVolume : customVolumes) {
//			BatchOssDiskVO diskVO = new BatchOssDiskVO();
//
//			diskVO.setDiskId(customVolume.getVolume_id());
//			diskVO.setDiskAlias(customVolume.getDisplay_name());
//			diskVO.setProjectId(customVolume.getProject_id());
//			if ("attached".equals(customVolume.getAttach_status()) ) {
//				String projectName = projectMap.get(customVolume.getProject_id());
//				VolumeIF volumeIf = AbstractFactory.getVolumeIF(projectName);
//				Volume volume = null;
//
//				volume = volumeIf.getVolume(customVolume.getVolume_id());
//				if (volume != null ) {
//					List<VolumeAttachment> volumeAttachments = volume.getAttachments();
//					if (volumeAttachments != null && volumeAttachments.size() > 0  ) {
//						diskVO.setVmUuid(volumeAttachments.get(0).getServer_id());
//					}
//				}
//			}
//			diskVO.setSizeGb(Integer.parseInt(customVolume.getSize()));
//			if (customVolume.getCreated_at() != null && !"".equals(customVolume.getCreated_at()))
//					diskVO.setCreateDatetime(DateUtils.convertUtcToDate(customVolume.getCreated_at()));
//			if (customVolume.getDeleted_at() != null && !"".equals(customVolume.getDeleted_at()))
//					diskVO.setDeleteDatetime(DateUtils.convertUtcToDate(customVolume.getDeleted_at()));
//			diskVO.setApiDeletedStatus(customVolume.getDeleted());
//
//			logger.debug(diskVO.toString());
//
//			this.volumeList.add(diskVO);
//		}
}
