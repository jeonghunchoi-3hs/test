package com.ivucenter.cloud.portal.oss.persistentvolume;

import java.util.LinkedList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;
import com.ivucenter.cloud.api.openshift.object.OpsApiOptionService;
import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.api.openstack.interfaces.AbstractFactory;
import com.ivucenter.cloud.api.openstack.interfaces.VolumeIF;
import com.ivucenter.cloud.api.openstack.object.Volume;
import com.ivucenter.cloud.api.openstack.object.VolumeAttachment;
import com.ivucenter.cloud.api.vRealize.interfaces.vraAbstractFactory;
import com.ivucenter.cloud.api.vRealize.interfaces.vraDiskIF;
import com.ivucenter.cloud.api.vRealize.object.vraBlockDevice;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;
import com.ivucenter.cloud.portal.cmm.cloud.OssCloudService;
import com.ivucenter.cloud.portal.oss.vm.CustomOssVmVO;
import com.ivucenter.cloud.portal.oss.vm.OssVmDAO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class OssPvService {

	@Autowired
	private OssPvDAO dao;

	@Autowired
	private OssVmDAO ossVmDao;

	@Autowired
	private OssCloudService ossCloudService;

	@Autowired
	private OpsApiOptionService opsApiOptionService;

	public String list(CustomOssPvVO req) {

		Assert.notNull(req.getProjectBoxId(), "");
		Assert.notNull(req.getProjectName(), "");

		List<CustomOssPvVO> lists = dao.list(req);
		int recordsTotal = dao.listTot(req).size();
		int recordsFiltered = recordsTotal;
		List<CustomOssPvVO> list = new LinkedList<CustomOssPvVO>();
		String sError = "";

		try {
			for (CustomOssPvVO vo : lists) {
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

    public String nasList(CustomOssPvVO req) {
        Assert.notNull(req.getProjectBoxId(), "ProjectBoxId is required.");
        Assert.notNull(req.getProjectName(), "ProjectName is required.");

        List<CustomOssPvVO> lists = dao.nasList(req);
        int recordsTotal = dao.nasListTot(req).size();
        int recordsFiltered = recordsTotal;

        try {
            // JSON 응답 생성
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

    public String pvDetachList(CustomOssPvVO req) {
    	Assert.notNull(req.getProjectId(), "");
    	Assert.notNull(req.getProjectName(), "");

    	List<CustomOssPvVO> lists = dao.pvDetachList(req);
    	int recordsTotal = dao.pvDetachListTot(req).size();
    	int recordsFiltered = recordsTotal;

    	try {
    		// JSON 응답 생성
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

	public CustomOssPvVO attach(CustomOssPvVO req) {
	    Assert.notNull(req.getCloudId(), "");
	    Assert.notNull(req.getProjectName(), "");
	    Assert.notNull(req.getPvcName(), "");
	    Assert.notNull(req.getMountPath(), "");

	    try {
	        CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo(req.getCloudId());

	        if(cloudVo.getCloudType().equals("openshift")) {
//	            String namespace = req.getProjectName().toLowerCase();
	            String namespace = req.getAppNameSpace().toLowerCase();
	            String deploymentConfigName = req.getAppName();
	            String pvcName = req.getPvcName();
	            String mountPath = req.getMountPath();

	            opsApiOptionService.attachPVCToDeploymentConfig(namespace, deploymentConfigName, pvcName, mountPath, cloudVo);

	            req.setConnectStatus("PVC_MOUNT");
	            dao.insertOssNasApp(req);
	            dao.pvcStatusUpdate(req); // connect_status update
	            dao.pvcPathUpdate(req); // connect_status update
	            dao.updateAppPvc(req);


	            req.setErrorMsg("1");
	        }

	    } catch (NotConnectGatewayException | NotSupportGatewayException | InvaildOpenStackException e) {
	        log.error(e.getMessage());
	        req.setErrorMsg(e.getMessage());
	    } catch (Exception e) {
	        log.error(e.getMessage());
	        req.setErrorMsg(e.getMessage());
	    }

	    return req;
	}

	public CustomOssPvVO detach(CustomOssPvVO req) {

	    Assert.notNull(req.getCloudId(), "");
	    Assert.notNull(req.getProjectName(), "");
	    Assert.notNull(req.getPvcName(), "");
	    Assert.notNull(req.getAppName(), "");
	    Assert.notNull(req.getAppNameSpace(), "");

	    try {
	        CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo(req.getCloudId());

	        opsApiOptionService.detachPVCFromDeploymentConfig(req.getAppNameSpace().toLowerCase(), req.getAppName(), req.getPvcName(), cloudVo);

	        System.out.println("PVC " + req.getPvcName() + " detached from DeploymentConfig " + req.getDeploymentConfigName());

	        req.setConnectStatus("PVC_UNMOUNT");
	        req.setMountPath(null);
	        req.setDelFlag("Y");
	        req.setErrorMsg("1");

	        dao.pvcStatusUpdate(req); // connect_status update
	        dao.deleteNasApp(req); // connect_status update
	        dao.updateAppPvc(req);

	    } catch (NotConnectGatewayException | NotSupportGatewayException | InvaildOpenStackException e) {
	        log.error(e.getMessage());
	        req.setErrorMsg(e.getMessage());
	    } catch (Exception e) {
	        log.error(e.getMessage());
	        req.setErrorMsg(e.getMessage());
	    }

	    return req;
	}

	public String pvcStatusUpdate(CustomOssPvVO req) {
		return dao.pvcStatusUpdate(req);
	}

	public String pvcPathUpdate(CustomOssPvVO req) {
		return dao.pvcPathUpdate(req);
	}

	public List<CustomOssPvVO> excel(CustomOssPvVO req) {
		Assert.notNull(req.getProjectBoxId(), "");
		Assert.notNull(req.getProjectName(), "");

        List<CustomOssPvVO> lists = dao.nasList(req);
        int recordsTotal = dao.nasListTot(req).size();
        int recordsFiltered = recordsTotal;

        try {
            // JSON 응답 생성
            JsonObject jsonResponse = new JsonObject();
            Gson gson = new Gson();
            jsonResponse.addProperty("draw", req.getDraw());
            jsonResponse.addProperty("recordsTotal", recordsTotal);
            jsonResponse.addProperty("recordsFiltered", recordsFiltered);
            jsonResponse.add("data", gson.toJsonTree(lists));
        } catch (JsonIOException e) {
            log.error(e.getMessage());
        }
        return lists;
    }

}
