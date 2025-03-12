package com.ivucenter.cloud.portal.oss.application;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;
import com.ivucenter.cloud.api.openshift.object.OpsApiOptionService;
import com.ivucenter.cloud.portal.cmm.cloud.OssCloudService;
import com.ivucenter.cloud.portal.login.UserSession;
import com.ivucenter.cloud.portal.oss.service.CustomOssServiceVO;
import com.ivucenter.cloud.portal.req.catalogue.CustomReqCatalogueVO;
import com.ivucenter.cloud.portal.req.catalogue.CustomReqOrderVO;
import com.ivucenter.cloud.portal.req.product.CustomReqProductVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class OssAppService {

	@Autowired
	private OssAppDAO dao;

	@Autowired
	private OssCloudService ossCloudService;

	@Autowired
	OpsApiOptionService opsApiOptionService;

	public CustomOssAppVO returnVoInfo( CustomOssAppVO req) {
		CustomOssAppVO returnVo = new CustomOssAppVO();
		try {

			log.debug("ToStringReq");
			log.debug(req.toString());
			returnVo = dao.returnVoInfo( req);
		}catch (Exception e) {
			throw e;
		}
		return returnVo;
	}

	public String list(CustomOssAppVO req)  {
		Assert.notNull(req.getProjectBoxId(), "");
		Assert.notNull(req.getProjectName(), "");
		List<CustomOssAppVO> lists = dao.projectList(req);
		int recordsTotal = dao.projectListTot(req).size();
		int recordsFiltered = recordsTotal;

//		List<CustomOssAppVO> list = new LinkedList<CustomOssAppVO>();
		List<HashMap<String, Object>> list = new LinkedList<HashMap<String, Object>>();
		for(CustomOssAppVO vo : lists) {
			if(vo.getCloudType().equals("openshift")) {
//				    if(size == 0) {
//				    	ServiceList getServiceList = opsApiOptionService.getServiceList(cloudVo, vo.getAppNameSpace());
//						RouteList getRouteList = opsApiOptionService.getRouteList(cloudVo, vo.getAppNameSpace());
//						BuildList getBuildList = opsApiOptionService.getBuildList(cloudVo, vo.getAppNameSpace());
//						DeploymentConfigList getConfigList = opsApiOptionService.getDeploymentConfigList(cloudVo, vo.getAppNameSpace());
//						services = getServiceList.getItems().size();
//				        routes = getRouteList.getItems().size();
//				        builds = getBuildList.getItems().size();
//				        configs = getConfigList.getItems().size();
//				    }
//
//				    DeploymentConfig res = opsApiOptionService.getDeploymentConfig(cloudVo, vo.getAppNameSpace(), vo.getAppName());
//					volumes += res.getSpec().getTemplate().getSpec().getVolumes().size();
//					pods += res.getSpec().getReplicas();
//					Route route = opsApiOptionService.getRoute(cloudVo, vo.getAppNameSpace(), vo.getAppName());
//					ServicePort servicePort = opsApiOptionService.getServicePort( cloudVo, vo.getAppNameSpace(), vo.getAppName(), 0);

				HashMap<String, Object> map = new HashMap<>();
				map.put("cloudName", vo.getCloudName());
				map.put("appName", vo.getAppName());
				map.put("appNameSpace", vo.getAppNameSpace());
				map.put("appAlias", vo.getAppAlias());
				map.put("appUid", vo.getAppUid());
				map.put("templateName", vo.getTemplateName());
				map.put("cloudId", vo.getCloudId());
				map.put("projectId", vo.getProjectId());
				map.put("templateProductSeq", vo.getTemplateProductSeq());
				map.put("templateCatalogSeq", vo.getTemplateCatalogSeq());
				map.put("regDatetime", vo.getRegDatetime());
//				map.put("projectId", vo.getProjectId());
				map.put("osProductSeq", vo.getOsProductSeq());
				map.put("createDatetime", vo.getCreateDatetime());
				map.put("pod", vo.getPod());
				map.put("cpuLimit", vo.getCpuLimit());
				map.put("memLimit", vo.getMemLimit());
				map.put("cpuReq", vo.getCpuReq());
				map.put("memReq", vo.getMemReq());
				map.put("scaleOutName", vo.getScaleOutName());
				map.put("state", "정상(빌드중)");
				if( !"N".equals(vo.getDelFlag())) {
					map.put("state", "삭제됨");
				}
				list.add(map);
			}
		}

		String sError = "";
        CustomOssAppVO total = dao.appResouceTotal(req);
		try {
	        JsonObject jsonResponse = new JsonObject();
	        Gson gson = new Gson();
	        jsonResponse.addProperty("draw", req.getDraw());
	        jsonResponse.addProperty("error", sError);
	        jsonResponse.addProperty("recordsTotal", recordsTotal);
	        jsonResponse.addProperty("recordsFiltered", recordsFiltered);
	        jsonResponse.add("resourceTotal", gson.toJsonTree(total));
	        jsonResponse.add("data", gson.toJsonTree(list));
	        return jsonResponse.toString();
	    } catch (JsonIOException e) {
	    	log.error(e.getMessage());
	    }
		return "";

	}


	public String pvAppList(CustomOssAppVO req)  {
		Assert.notNull(req.getProjectId(), "");
		Assert.notNull(req.getProjectName(), "");
		List<CustomOssAppVO> lists = dao.pvAppList(req);
		int recordsTotal = dao.pvAppListTot(req).size();
		int recordsFiltered = recordsTotal;

//		List<CustomOssAppVO> list = new LinkedList<CustomOssAppVO>();
		List<HashMap<String, Object>> list = new LinkedList<HashMap<String, Object>>();
		for(CustomOssAppVO vo : lists) {

				HashMap<String, Object> map = new HashMap<>();
				map.put("cloudName", vo.getCloudName());
				map.put("appName", vo.getAppName());
				map.put("appNameSpace", vo.getAppNameSpace());
				map.put("appAlias", vo.getAppAlias());
				map.put("appUid", vo.getAppUid());
				map.put("pvcName", vo.getPvcName());
				map.put("pvName", vo.getPvName());
				map.put("templateName", vo.getTemplateName());
				map.put("cloudId", vo.getCloudId());
				map.put("projectId", vo.getProjectId());
				map.put("templateProductSeq", vo.getTemplateProductSeq());
				map.put("templateCatalogSeq", vo.getTemplateCatalogSeq());
				map.put("regDatetime", vo.getRegDatetime());
//				map.put("projectId", vo.getProjectId());
				map.put("osProductSeq", vo.getOsProductSeq());
				map.put("createDatetime", vo.getCreateDatetime());
				map.put("pod", vo.getPod());
				map.put("cpuLimit", vo.getCpuLimit());
				map.put("memLimit", vo.getMemLimit());
				map.put("cpuReq", vo.getCpuReq());
				map.put("memReq", vo.getMemReq());
				map.put("scaleOutName", vo.getScaleOutName());
				map.put("state", "정상(빌드중)");
				if( !"N".equals(vo.getDelFlag())) {
					map.put("state", "삭제됨");
				}
				list.add(map);
		}

		String sError = "";
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

	public String catalogueApplist(CustomOssAppVO req) {
		Assert.notNull(req.getProjectBoxId(), "");
		Assert.notNull(req.getProjectName(), "");
		List<CustomOssAppVO> lists = dao.appList(req);
		int recordsTotal = dao.appListTot(req).size();
		int recordsFiltered = recordsTotal;

		List<HashMap<String, Object>> list = new LinkedList<HashMap<String, Object>>();
		for(CustomOssAppVO vo : lists) {
			if(vo.getCloudType().equals("openshift")) {

				HashMap<String, Object> map = new HashMap<>();
				map.put("cloudName", vo.getCloudName());
				map.put("appName", vo.getAppName());
				map.put("appNameSpace", vo.getAppNameSpace());
				map.put("appAlias", vo.getAppAlias());
				map.put("appUid", vo.getAppUid());
				map.put("templateName", vo.getTemplateName());
				map.put("cloudId", vo.getCloudId());
				map.put("projectId", vo.getProjectId());
				map.put("templateProductSeq", vo.getTemplateProductSeq());
				map.put("templateCatalogSeq", vo.getTemplateCatalogSeq());
				map.put("regDatetime", vo.getRegDatetime());
//				map.put("projectId", vo.getProjectId());
				map.put("osProductSeq", vo.getOsProductSeq());
				map.put("createDatetime", vo.getCreateDatetime());
				map.put("pod", vo.getPod());
				map.put("cpuLimit", vo.getCpuLimit());
				map.put("memLimit", vo.getMemLimit());
				map.put("cpuReq", vo.getCpuReq());
				map.put("memReq", vo.getMemReq());
				map.put("scaleOutName", vo.getScaleOutName());
				map.put("state", "정상(빌드중)");
				if( !"N".equals(vo.getDelFlag())) {
					map.put("state", "삭제됨");
				}
				list.add(map);
			}
		}

		String sError = "";
        CustomOssAppVO total = dao.appResouceTotal(req);
		try {
	        JsonObject jsonResponse = new JsonObject();
	        Gson gson = new Gson();
	        jsonResponse.addProperty("draw", req.getDraw());
	        jsonResponse.addProperty("error", sError);
	        jsonResponse.addProperty("recordsTotal", recordsTotal);
	        jsonResponse.addProperty("recordsFiltered", recordsFiltered);
	        jsonResponse.add("resourceTotal", gson.toJsonTree(total));
	        jsonResponse.add("data", gson.toJsonTree(list));
	        return jsonResponse.toString();
	    } catch (JsonIOException e) {
	    	log.error(e.getMessage());
	    }
		return "";
	}

	public String detail(CustomOssAppVO req)  {
//		Assert.notNull(req.getProjectBoxId(), "");
//		Assert.notNull(req.getProjectName(), "");
		CustomOssAppVO detail = dao.appDetail(req);

		String sError = "";
//        CustomOssAppVO total = dao.appResouceTotal(req);
		try {
	        JsonObject jsonResponse = new JsonObject();
	        Gson gson = new Gson();
	        jsonResponse.addProperty("draw", req.getDraw());
	        jsonResponse.addProperty("error", sError);
//	        jsonResponse.addProperty("recordsTotal", recordsTotal);
//	        jsonResponse.addProperty("recordsFiltered", recordsFiltered);
//	        jsonResponse.add("resourceTotal", gson.toJsonTree(total));
	        jsonResponse.add("data", gson.toJsonTree(detail));
	        return jsonResponse.toString();
	    } catch (JsonIOException e) {
	    	log.error(e.getMessage());
	    }
		return "";
	}

	public String projectEnvList(CustomReqProductVO req) {
		UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		req.setUserId(userSession.getUsername());

		List<CustomReqProductVO> lists = dao.projectEnvList(req);
		int recordsTotal = dao.projectEnvListTotCnt(req);
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

	public List<CustomReqProductVO> envViewExcel(CustomReqProductVO req) {
		List<CustomReqProductVO> res = dao.envViewExcel(req);
		return res;
	}

	public CustomReqProductVO mbrEnvDetailInfo(CustomReqProductVO req) {
		CustomReqProductVO res = dao.mbrEnvDetailInfo(req);
		return res;
	}

	public List<CustomReqProductVO> mbrEnvUserList(String cicdProjectId) {
		return dao.mbrEnvUserList(cicdProjectId);
	}

	// CICD 파이프라인 목록 조회
	public String mbrDevCicdPipelineList(CustomReqProductVO req) {
		UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		req.setUserId(userSession.getUsername());

		List<CustomReqProductVO> lists = dao.mbrDevCicdPipelineList(req);
		int recordsTotal = dao.mbrDevCicdPipelineListTotCnt(req);
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

	// CICD 파이프라인 목록 조회
	public String mbrPrdCicdPipelineList(CustomReqProductVO req) {
		UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		req.setUserId(userSession.getUsername());

		List<CustomReqProductVO> lists = dao.mbrPrdCicdPipelineList(req);
		int recordsTotal = dao.mbrPrdCicdPipelineListTotCnt(req);
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

	public String mbrPrdList(CustomReqProductVO req) {
		UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		req.setUserId(userSession.getUsername());

		List<CustomReqProductVO> lists = dao.mbrPrdList(req);
		int recordsTotal = dao.mbrPrdListTotCnt(req);
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


	public List<CustomOssAppVO> viewExcel(CustomOssAppVO req)  {
		return dao.projectList(req);
	}

	public CustomOssAppVO ossAppByAppUid(CustomOssAppVO req) {
		return dao.ossAppByAppUid(req);
	}

	public CustomOssAppVO getDetailOssApp(CustomOssAppVO req) {
		return dao.getDetailOssApp(req);
	}

	public String insertAutoscaler(CustomOssAppVO req) {
		return dao.insertAutoscaler(req)+"";
	}

	public String insertScaleOut(CustomOssAppVO req) {
		return dao.insertScaleOut(req)+"";
	}

	public CustomOssAppVO scaleOutDetail(CustomOssAppVO req) {
		return dao.scaleOutDetail(req);
	}

	public String scaleOutUpdate(CustomOssAppVO req) {
		return dao.scaleOutUpdate(req)+"";
	}

	public int devAppIdChk(CustomReqProductVO req){
		return dao.devAppIdChk(req);
	}

	public int devUsersNameCheck(CustomReqProductVO req){
		return dao.devUsersNameCheck(req);
	}

	public int devUsersMailCheck(CustomReqProductVO req){
		return dao.devUsersMailCheck(req);
	}

	public CustomReqProductVO getPrdPipeLineDetail(CustomReqProductVO req) {
		return dao.getPrdPipeLineDetail(req);
	}

	public CustomReqProductVO getPrdPipeLineVersion(CustomReqProductVO req) {
		return dao.getPrdPipeLineVersion(req);
	}

	public CustomReqProductVO getDevPipeLineDetail(CustomReqProductVO req) {
		return dao.getDevPipeLineDetail(req);
	}

	public CustomReqProductVO getDevPipeLineVersion(CustomReqProductVO req) {
		return dao.getDevPipeLineVersion(req);
	}

	public CustomReqProductVO detailBssOrderProductEnv(CustomReqProductVO req) {
		return dao.detailBssOrderProductEnv(req);
	}

	public CustomReqProductVO cicdProjectUserInfo(CustomReqProductVO req) {
		return dao.cicdProjectUserInfo(req);
	}
	public CustomReqProductVO cicdGourpProjectInfo(CustomReqProductVO req) {
		return dao.cicdGourpProjectInfo(req);
	}


}
