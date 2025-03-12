package com.ivucenter.cloud.portal.oss.filestorage;

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
public class OssFsService {

	@Autowired
	private OssFsDAO dao;

	@Autowired
	private OssVmDAO ossVmDao;

	@Autowired
	private OssCloudService ossCloudService;

	@Autowired
	private OpsApiOptionService opsApiOptionService;

//	@Autowired
//	private ServerIF serverIF;

	public String list(CustomOssFsVO req) {

		Assert.notNull(req.getProjectBoxId(), "");
		Assert.notNull(req.getProjectName(), "");

		List<CustomOssFsVO> lists = dao.list(req);
		int recordsTotal = dao.listTot(req).size();
		int recordsFiltered = recordsTotal;
		List<CustomOssFsVO> list = new LinkedList<CustomOssFsVO>();
		String sError = "";

		try {
			for (CustomOssFsVO vo : lists) {
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

    public String fsList(CustomOssFsVO req) {
        Assert.notNull(req.getProjectBoxId(), "ProjectBoxId is required.");
        Assert.notNull(req.getProjectName(), "ProjectName is required.");

        List<CustomOssFsVO> lists = dao.fsList(req);
        int recordsTotal = dao.fsListTot(req).size();
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

    public String pvDetachList(CustomOssFsVO req) {
    	Assert.notNull(req.getProjectId(), "");
    	Assert.notNull(req.getProjectName(), "");

    	List<CustomOssFsVO> lists = dao.pvDetachList(req);
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

	public CustomOssFsVO attach(CustomOssFsVO req) {
	    Assert.notNull(req.getCloudId(), "");
	    Assert.notNull(req.getProjectName(), "");
	    Assert.notNull(req.getVmUuid(), "");
	    Assert.notNull(req.getDefaultNetworkId(), "");

	    try {
	        CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo(req.getCloudId());

//	            String namespace = req.getProjectName().toLowerCase();
	            String namespace = req.getAppNameSpace().toLowerCase();
	            String deploymentConfigName = req.getAppName();
	            String pvcName = req.getPvcName();
	            String mountPath = req.getMountPath();

	            opsApiOptionService.attachPVCToDeploymentConfig(namespace, deploymentConfigName, pvcName, mountPath, cloudVo);

//	        	ServerIF serverIf =  AbstractFactory.getServerIF(req.getProjectName(), cloudVo);

//	        	serverIf.attachPortAttachment(req.getVmUuid(), req.getDefaultNetworkId());

	            req.setErrorMsg("1");

	    } catch (NotConnectGatewayException | NotSupportGatewayException | InvaildOpenStackException e) {
	        log.error(e.getMessage());
	        req.setErrorMsg(e.getMessage());
	    } catch (Exception e) {
	        log.error(e.getMessage());
	        req.setErrorMsg(e.getMessage());
	    }

	    return req;
	}

	public CustomOssFsVO detach(CustomOssFsVO req) {

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

	public String pvcStatusUpdate(CustomOssFsVO req) {
		return dao.pvcStatusUpdate(req);
	}

	public String pvcPathUpdate(CustomOssFsVO req) {
		return dao.pvcPathUpdate(req);
	}

	public List<CustomOssFsVO> excel(CustomOssFsVO req) {
		Assert.notNull(req.getProjectBoxId(), "");
		Assert.notNull(req.getProjectName(), "");

        List<CustomOssFsVO> lists = dao.fsList(req);
        int recordsTotal = dao.fsListTot(req).size();
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
