package com.ivucenter.cloud.portal.oss.disk;

import java.util.LinkedList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;
import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.api.openstack.interfaces.AbstractFactory;
import com.ivucenter.cloud.api.openstack.interfaces.ServerIF;
import com.ivucenter.cloud.api.openstack.interfaces.VolumeIF;
import com.ivucenter.cloud.api.openstack.object.Volume;
import com.ivucenter.cloud.api.openstack.object.VolumeAttachment;
import com.ivucenter.cloud.api.vRealize.interfaces.vraAbstractFactory;
import com.ivucenter.cloud.api.vRealize.interfaces.vraDiskIF;
import com.ivucenter.cloud.api.vRealize.interfaces.vraServerIF;
import com.ivucenter.cloud.api.vRealize.object.vraAttachDisk;
import com.ivucenter.cloud.api.vRealize.object.vraBlockDevice;
import com.ivucenter.cloud.api.vRealize.object.vraContent;
import com.ivucenter.cloud.api.vRealize.object.vraJsonObject;
import com.ivucenter.cloud.api.vRealize.object.vraServer;
import com.ivucenter.cloud.api.vmware.interfaces.VmDiskIF;
import com.ivucenter.cloud.api.vmware.object.VmDisks;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;
import com.ivucenter.cloud.portal.cmm.cloud.OssCloudService;
import com.ivucenter.cloud.portal.oss.vm.CustomOssVmVO;
import com.ivucenter.cloud.portal.oss.vm.OssVmDAO;
import com.ivucenter.cloud.portal.req.product.CustomReqProductVO;

import lombok.extern.slf4j.Slf4j;


/**
 * @author 박진우
 */
@Slf4j
@Service
public class OssDiskService{

	@Autowired
	private OssDiskDAO dao;

	@Autowired
	private OssVmDAO ossVmDao;

	@Autowired
	private OssCloudService ossCloudService;

	public String list(CustomOssDiskVO req) {

		Assert.notNull(req.getProjectBoxId(), "");
		Assert.notNull(req.getProjectName(), "");

		List<CustomOssDiskVO> lists = dao.list(req);
		int recordsTotal = dao.listTot(req).size();
		int recordsFiltered = recordsTotal;
		List<CustomOssDiskVO> list = new LinkedList<CustomOssDiskVO>();
		String sError = "";

		try {
			for (CustomOssDiskVO vo : lists) {
				CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo(vo.getCloudId());
			if(cloudVo.getCloudType().equals("openstack")) {

				VolumeIF volumeIF = AbstractFactory.getVolumeIF(req.getProjectName(),cloudVo);
				List<Volume> volumelists = volumeIF.getVolumes();

					for (Volume obj : volumelists) {
						if(obj.getId().equals(vo.getDiskId())){
							vo.setDiskName(obj.getName());
							vo.setSize(obj.getSize().toString());
							vo.setStatus(obj.getStatus());
							vo.setVolumeType(obj.getVolume_type());
							vo.setCloudType(vo.getCloudType());
							for(VolumeAttachment attach : obj.getAttachments()){
								vo.setAttachments(attach.getDevice());
								vo.setVmUuid(attach.getServer_id());
								CustomOssVmVO vmVo = new CustomOssVmVO();
								vmVo.setVmUuid(attach.getServer_id());
								vmVo = ossVmDao.detail(vmVo);
								if(vmVo != null){
									vo.setHostname(vmVo.getHostname());
									vo.setHostnameAlias(vmVo.getHostnameAlias());
								}
								break;
							}
							vo.setAvailabilityZone(obj.getAvailability_zone());
							vo.setBootable(obj.getBootable());
							vo.setEncrypted(obj.getEncrypted().toString());
							break;
						}
					}
					list.add(vo);

		} else if(cloudVo.getCloudType().equals("vmware")) {
			vraDiskIF diskIF = vraAbstractFactory.getDiskIF(cloudVo);
			vraBlockDevice block = diskIF.getBlockDevice("");
			List<vraBlockDevice> blockLists = block.getContent();
				for (vraBlockDevice obj : blockLists) {
					if(obj.getId().equals(vo.getDiskId())){
						vo.setCloudType(vo.getCloudType());
						vo.setDiskName(obj.getCapacityInGB());
						vo.setStatus(obj.getStatus());
						vo.setVolumeType(obj.getType());
						CustomOssVmVO vmVo = new CustomOssVmVO();
						vmVo.setVmUuid(vo.getVmUuid());
						vmVo = ossVmDao.detail(vmVo);
						if(vmVo != null){
							vo.setHostname(vmVo.getHostname());
							vo.setHostnameAlias(vmVo.getHostnameAlias());
						}
						if(obj.getName().equals("boot-disk")) {
							vo.setBootable("true");
						} else {
							vo.setBootable("false");
						}
						vo.setAvailabilityZone(obj.getExternalZoneId());
						break;
					}
				}
			list.add(vo);
		}else if(cloudVo.getCloudType().equals("openshift")) {
 			list.add(vo);
		}else if(cloudVo.getCloudType().equals("nutanix")) {
			list.add(vo);
		}
	}

	} catch (NotConnectGatewayException|NotSupportGatewayException|InvaildOpenStackException e) {
		log.error(e.getMessage());
		sError = e.getMessage();
	} catch (Exception e) {
	   	log.error(e.getMessage());
	   	sError = e.getMessage();
	}

	   try {
	      JsonObject jsonResponse = new JsonObject();
	      Gson gson = new Gson();

	      jsonResponse.addProperty("draw", req.getDraw());
	      jsonResponse.addProperty("error", sError);
	      jsonResponse.addProperty("recordsTotal", recordsTotal);
	      jsonResponse.addProperty("recordsFiltered", recordsFiltered);
	      jsonResponse.add("data", gson.toJsonTree(list));

	      return jsonResponse.toString();
	  } catch (JsonIOException e) {
	  	log.error(e.getMessage());
	  }
		return "";
   }

	public CustomOssDiskVO detail(CustomOssDiskVO req) {
		Assert.notNull(req.getCloudId(), "");
		Assert.notNull(req.getProjectName(), "");
		Assert.notNull(req.getDiskId(), "");

		CustomOssDiskVO res = dao.detail(req);
		CustomReqProductVO diskReq = new CustomReqProductVO();

		String[] splitDiskId = req.getDiskId().split("-");

		diskReq.setDiskId(splitDiskId[0]);
		diskReq.setVmUuid(req.getVmUuid());

		try {
			CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo(req.getCloudId());

			if(cloudVo.getCloudType().equals("openstack")) {

				VolumeIF volumeIF = AbstractFactory.getVolumeIF(req.getProjectName(),cloudVo);
				Volume obj = volumeIF.getVolume(req.getDiskId());


				res.setDiskName(obj.getName());
				res.setSize(obj.getSize().toString());
				res.setStatus(obj.getStatus());
				res.setVolumeType(obj.getVolume_type());
				for(VolumeAttachment attach : obj.getAttachments()){
					res.setAttachments(attach.getDevice());
					CustomOssVmVO vmVo = new CustomOssVmVO();
					vmVo.setVmUuid(attach.getServer_id());
					vmVo = ossVmDao.detail(vmVo);
					if(vmVo != null){
						res.setHostname(vmVo.getHostname());
						res.setHostnameAlias(vmVo.getHostnameAlias());
					}
					break;
				}
				res.setAvailabilityZone(obj.getAvailability_zone());
				res.setBootable(obj.getBootable());
				res.setEncrypted(obj.getEncrypted().toString());

			}else if (cloudVo.getCloudType().equals("vmware")) {

				VmDiskIF vmDiskIF = AbstractFactory.getDiskVmware(diskReq, cloudVo);
				VmDisks diskInfo = vmDiskIF.getDisk();
				String[] info = diskInfo.getValue().getBacking().getVmdkFile().split(" ");
				String vmdkFileDatastore =  info[0];
			    String vmdkFileLink = info[1];
				res.setVmdkFileDatastore(vmdkFileDatastore);
				res.setVmdkFileLink(vmdkFileLink);

			}


		} catch (NotConnectGatewayException|NotSupportGatewayException|InvaildOpenStackException e) {
			log.error(e.getMessage());
			res.setErrorMsg(e.getMessage());
	    } catch (Exception e) {
	    	log.error(e.getMessage());
	    	res.setErrorMsg(e.getMessage());
		}
	    return res;
	}


	public CustomOssDiskVO detach(CustomOssDiskVO req) {

		Assert.notNull(req.getCloudId(), "");
		Assert.notNull(req.getProjectName(), "");
		Assert.notNull(req.getDiskId(), "");

		try {
			CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo(req.getCloudId());
			if(cloudVo.getCloudType().equals("openstack")) {
				ServerIF serverIF = AbstractFactory.getServerIF(req.getProjectName(),cloudVo);
				serverIF.detachVolumeAttachments(req.getVmUuid(), req.getDiskId());
				req.setErrorMsg("1");
			} else if(cloudVo.getCloudType().equals("vmware")) {
				vraServerIF vraServerIF = vraAbstractFactory.getServerIF(cloudVo);
				vraDiskIF diskIF = vraAbstractFactory.getDiskIF(cloudVo);
				vraServer depInfo = vraServerIF.getDepInfo(req.getVmUuid());
				List<vraContent> contents = depInfo.getContent();
				for(vraContent content : contents) {
					if(content.getType().equals("Cloud.vSphere.Machine")) {
						vraAttachDisk VraAttachDisk = new vraAttachDisk();
						vraJsonObject res2 = diskIF.detachDisk(req.getDiskId(),content.getId());
						vraJsonObject blockTracker2 = diskIF.blockTracker(res2.getId());
						while(!blockTracker2.getStatus().equals("FINISHED")) {
							blockTracker2 = diskIF.blockTracker(res2.getId());
							Thread.sleep(1500);
						}
						if(!blockTracker2.getMessage().equals("success")) {
							req.setErrorMsg(blockTracker2.getMessage());
						} else {
							req.setErrorMsg("1");
						}
					}
				}
			}
		} catch (NotConnectGatewayException|NotSupportGatewayException|InvaildOpenStackException e) {
			log.error(e.getMessage());
			req.setErrorMsg(e.getMessage());
		} catch (Exception e) {
	    	log.error(e.getMessage());
	    	req.setErrorMsg(e.getMessage());
		}

		return req;
	}

	public CustomOssDiskVO attach(CustomOssDiskVO req) {
		Assert.notNull(req.getCloudId(), "");
		Assert.notNull(req.getProjectName(), "");
		Assert.notNull(req.getDiskId(), "");

		try {
			CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo(req.getCloudId());
			if(cloudVo.getCloudType().equals("openstack")) {
				ServerIF serverIF = AbstractFactory.getServerIF(req.getProjectName(),cloudVo);
				serverIF.attachVolumeAttachments(req.getVmUuid(), req.getDiskId());
				req.setErrorMsg("1");
			} else if(cloudVo.getCloudType().equals("vmware")) {
				vraServerIF vraServerIF = vraAbstractFactory.getServerIF(cloudVo);
				vraDiskIF diskIF = vraAbstractFactory.getDiskIF(cloudVo);
				vraServer depInfo = vraServerIF.getDepInfo(req.getVmUuid());
				List<vraContent> contents = depInfo.getContent();
				for(vraContent content : contents) {
					if(content.getType().equals("Cloud.vSphere.Machine")) {
						vraAttachDisk VraAttachDisk = new vraAttachDisk();
						VraAttachDisk.setBlockDeviceId(req.getDiskId());
						vraJsonObject res2 = diskIF.attachDisk(VraAttachDisk,content.getId());
						vraJsonObject blockTracker2 = diskIF.blockTracker(res2.getId());
						while(!blockTracker2.getStatus().equals("FINISHED")) {
							blockTracker2 = diskIF.blockTracker(res2.getId());
							Thread.sleep(1500);
						}
						if(!blockTracker2.getMessage().equals("success")) {
							req.setErrorMsg(blockTracker2.getMessage());
						} else {
							req.setErrorMsg("1");
						}
					}
				}
			}

		} catch (NotConnectGatewayException|NotSupportGatewayException|InvaildOpenStackException e) {
			log.error(e.getMessage());
			req.setErrorMsg(e.getMessage());
	    } catch (Exception e) {
	    	log.error(e.getMessage());
	    	req.setErrorMsg(e.getMessage());
		}

		return req;
	}

	public String updateAlias(CustomOssDiskVO req) {
		return dao.updateAlias(req);
	}

	public String catalogueList(CustomOssDiskVO req) {

		Assert.notNull(req.getProjectBoxId(), "");

		List<CustomOssDiskVO> lists = dao.list(req);
		int recordsTotal = dao.listTot(req).size();
		int recordsFiltered = recordsTotal;

	    try {
	        JsonObject jsonResponse = new JsonObject();
	        Gson gson = new Gson();

	        jsonResponse.addProperty("draw", req.getDraw());
	        jsonResponse.addProperty("recordsTotal", recordsTotal);
	        jsonResponse.addProperty("recordsFiltered", recordsFiltered);
	        jsonResponse.add("data", gson.toJsonTree(lists));

	        return jsonResponse.toString();
	    } catch (JsonIOException e) {
	    	log.error(e.getMessage());
	    }
		return "";
	}

	public List<CustomOssDiskVO> excel(CustomOssDiskVO req) {
		Assert.notNull(req.getProjectBoxId(), "");
		Assert.notNull(req.getProjectName(), "");

		List<CustomOssDiskVO> lists = dao.list(req);
		int recordsTotal = dao.listTot(req).size();
		int recordsFiltered = recordsTotal;
		List<CustomOssDiskVO> list = new LinkedList<CustomOssDiskVO>();
		String sError = "";

		try {
			for (CustomOssDiskVO vo : lists) {
				CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo(vo.getCloudId());
			if(cloudVo.getCloudType().equals("openstack")) {

				VolumeIF volumeIF = AbstractFactory.getVolumeIF(req.getProjectName(),cloudVo);
				List<Volume> volumelists = volumeIF.getVolumes();

					for (Volume obj : volumelists) {
						if(obj.getId().equals(vo.getDiskId())){
							vo.setDiskName(obj.getName());
							vo.setSize(obj.getSize().toString());
							vo.setStatus(obj.getStatus());
							vo.setVolumeType(obj.getVolume_type());
							vo.setCloudType(vo.getCloudType());
							for(VolumeAttachment attach : obj.getAttachments()){
								vo.setAttachments(attach.getDevice());
								vo.setVmUuid(attach.getServer_id());
								CustomOssVmVO vmVo = new CustomOssVmVO();
								vmVo.setVmUuid(attach.getServer_id());
								vmVo = ossVmDao.detail(vmVo);
								if(vmVo != null){
									vo.setHostname(vmVo.getHostname());
									vo.setHostnameAlias(vmVo.getHostnameAlias());
								}
								break;
							}
							vo.setAvailabilityZone(obj.getAvailability_zone());
							vo.setBootable(obj.getBootable());
							vo.setEncrypted(obj.getEncrypted().toString());
							break;
						}
					}
					list.add(vo);

		} else if(cloudVo.getCloudType().equals("vmware")) {
			vraDiskIF diskIF = vraAbstractFactory.getDiskIF(cloudVo);
			vraBlockDevice block = diskIF.getBlockDevice("");
			List<vraBlockDevice> blockLists = block.getContent();
				for (vraBlockDevice obj : blockLists) {
					if(obj.getId().equals(vo.getDiskId())){
						vo.setCloudType(vo.getCloudType());
						vo.setDiskName(obj.getCapacityInGB());
						vo.setStatus(obj.getStatus());
						vo.setVolumeType(obj.getType());
						CustomOssVmVO vmVo = new CustomOssVmVO();
						vmVo.setVmUuid(vo.getVmUuid());
						vmVo = ossVmDao.detail(vmVo);
						if(vmVo != null){
							vo.setHostname(vmVo.getHostname());
							vo.setHostnameAlias(vmVo.getHostnameAlias());
						}
						if(obj.getName().equals("boot-disk")) {
							vo.setBootable("true");
						} else {
							vo.setBootable("false");
						}
						vo.setAvailabilityZone(obj.getExternalZoneId());
						break;
					}
				}
			list.add(vo);
			}
		}



		} catch (NotConnectGatewayException|NotSupportGatewayException|InvaildOpenStackException e) {
			log.error(e.getMessage());
			sError = e.getMessage();
	    } catch (Exception e) {
	    	log.error(e.getMessage());
	    	sError = e.getMessage();
		}
		return list;
	}

	public String snapshotDiskList(CustomOssDiskVO req) {

		Assert.notNull(req.getProjectId(), "");

		List<CustomOssDiskVO> lists = dao.snapshotDiskList(req);
		int recordsTotal = dao.snapshotDiskListTot(req).size();
		int recordsFiltered = recordsTotal;

	    try {
	        JsonObject jsonResponse = new JsonObject();
	        Gson gson = new Gson();

	        jsonResponse.addProperty("draw", req.getDraw());
	        jsonResponse.addProperty("recordsTotal", recordsTotal);
	        jsonResponse.addProperty("recordsFiltered", recordsFiltered);
	        jsonResponse.add("data", gson.toJsonTree(lists));

	        return jsonResponse.toString();
	    } catch (JsonIOException e) {
	    	log.error(e.getMessage());
	    }
		return "";
	}

}
