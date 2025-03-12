package com.ivucenter.cloud.portal.oss.project;

import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateFormatUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;
import com.ivucenter.cloud.api.common.batch.BatchProcessor;
import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.api.openstack.interfaces.AbstractFactory;
import com.ivucenter.cloud.api.openstack.interfaces.ProjectIF;
import com.ivucenter.cloud.api.openstack.object.Project;
import com.ivucenter.cloud.api.vRealize.object.vraProjectObject;
import com.ivucenter.cloud.batch.entity.BatchOssProjectVO;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;
import com.ivucenter.cloud.portal.cmm.cloud.OssCloudService;
import com.ivucenter.cloud.portal.login.UserSession;
import com.ivucenter.cloud.portal.req.customer.CustomReqCustomerVO;
import com.ivucenter.cloud.portal.req.project.ReqProjectService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class OssProjectService{

    private static final Logger logger = LoggerFactory.getLogger(OssProjectService.class);

	@Autowired
	private OssProjectDAO dao;

	@Autowired
	private OssCloudService ossCloudService;

	@Autowired
	private ReqProjectService reqProjectService;

	@Autowired
	private OssProjectService service;

//	@Autowired	private OssNetworkDAO ossNetworkDAO;
//	@Autowired	private AlarmsTemplateService alarmsTemplateService;

	public String list(CustomOssProjectVO req) {
    	List<CustomOssProjectVO> lists = dao.list(req);
    	int recordsTotal = dao.listTotCnt(req);
    	int recordsFiltered = recordsTotal;

    	for(CustomOssProjectVO vo : lists) {
    		vo.setManagerTelEx(vo.getManagerTelDec());
    		vo.setManagerPhone(vo.getManagerPhoneDec());
    	}

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


	public String mbrList(CustomOssProjectVO req) {
		UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		req.setUserId(userSession.getUsername());

		List<CustomOssProjectVO> lists = dao.mbrList(req);
    	int recordsTotal = dao.mbrListTotCnt(req);
    	int recordsFiltered = recordsTotal;

    	for(CustomOssProjectVO vo : lists) {
    		vo.setManagerTelEx(vo.getManagerTelDec());
    		vo.setManagerPhone(vo.getManagerPhoneDec());
    	}

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

	public String mbrAppList(CustomOssProjectVO req) {
		UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		req.setUserId(userSession.getUsername());

		List<CustomOssProjectVO> lists = dao.mbrAppList(req);
		int recordsTotal = dao.mbrAppListTotCnt(req);
		int recordsFiltered = recordsTotal;

		for(CustomOssProjectVO vo : lists) {
			vo.setManagerTelEx(vo.getManagerTelDec());
			vo.setManagerPhone(vo.getManagerPhoneDec());
		}

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

	public String mbrNasAppList(CustomOssProjectVO req) {
		UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		req.setUserId(userSession.getUsername());

		List<CustomOssProjectVO> lists = dao.mbrNasAppList(req);
		int recordsTotal = dao.mbrNasAppListTotCnt(req);
		int recordsFiltered = recordsTotal;

		for(CustomOssProjectVO vo : lists) {
			vo.setManagerTelEx(vo.getManagerTelDec());
			vo.setManagerPhone(vo.getManagerPhoneDec());
		}

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

	public String mbrFsList(CustomOssProjectVO req) {
		UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		req.setUserId(userSession.getUsername());

		List<CustomOssProjectVO> lists = dao.mbrFsList(req);
		int recordsTotal = dao.mbrFsListTotCnt(req);
		int recordsFiltered = recordsTotal;

		for(CustomOssProjectVO vo : lists) {
			vo.setManagerTelEx(vo.getManagerTelDec());
			vo.setManagerPhone(vo.getManagerPhoneDec());
		}

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

	public List<CustomOssProjectVO> serviceExcel(CustomOssProjectVO req) {
		req.setLength(0);
		return dao.projectServiceList(req);
	}

	public String projectServiceList(CustomOssProjectVO req) {
    	List<CustomOssProjectVO> lists = dao.projectServiceList(req);
    	int recordsTotal = dao.projectServiceListTotalCnt(req);
    	int recordsFiltered = recordsTotal;

//    	List<CustomOssProjectVO> list = new LinkedList<>();
    	for(CustomOssProjectVO vo : lists) {
    		vo.setManagerTelEx(vo.getManagerTelDec());
    		vo.setManagerPhone(vo.getManagerPhoneDec());
    	}

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


	public String mbrProjectServiceList(CustomOssProjectVO req) {
    	List<CustomOssProjectVO> lists = dao.mbrProjectServiceList(req);
    	int recordsTotal = dao.mbrProjectServiceListTotal(req);
    	int recordsFiltered = recordsTotal;

//    	List<CustomOssProjectVO> list = new LinkedList<>();
    	for(CustomOssProjectVO vo : lists) {
    		vo.setManagerTelEx(vo.getManagerTelDec());
    		vo.setManagerPhone(vo.getManagerPhoneDec());
    	}

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

	public CustomOssProjectVO boxDetail(CustomOssProjectVO req) {
		Assert.notNull(req.getProjectBoxId(), "");
		return dao.boxDetail(req);
	}

	public CustomOssProjectVO detail(CustomOssProjectVO req) {
		Assert.notNull(req.getProjectId(), "");
		return dao.detail(req);
	}

	public CustomOssProjectVO projectVmInfo(CustomOssProjectVO req) {
		return dao.projectVmInfo(req);
	}
	public CustomOssProjectVO projectServiceInfo(CustomOssProjectVO req) {
		Assert.notNull(req.getProjectId(), "");
		return dao.projectServiceInfo(req);
	}

	public CustomOssProjectVO projectNasInfo(CustomOssProjectVO req) {
		return dao.projectNasInfo(req);
	}

	public String delete(CustomOssProjectVO req) {
		Assert.notNull(req.getProjectId(), "");
		return dao.delete(req)+"";
	}

//	public void createNetworkAndSubnet(CustomOssProjectVO req){
//			List<CustomOssProjectVO> lists = dao.findByReqProjectNetwork(req.getReqProjectSeq());
//			OssNetworkService ossnetworkservice = new OssNetworkService();
//			OssSubnetService ossSubnetService = new OssSubnetService();
//
//			String sNetName = "";
//			String sNetAlias = "";
//			String sSubnetName = "";
//			for(CustomOssProjectVO list : lists){
//				sNetName = req.getProjectName().toLowerCase()+list.getNetworkName().toLowerCase();
//				sNetAlias = req.getProjectAlias()+list.getNetworkAlias();
//
//				// log.debug("[NETWORK] ProjectId=" + req.getProjectId()
//				// 			+ ", ProjectName="+ req.getProjectName()
//				// 			+ ", NetworkName=" + sNetName
//				// 			+ ", NetworkAlias=" + sNetAlias
//				// 			+ ", GatewayIp=" + list.getGateway()
//				// 		);
//				CustomOssNetworkVO vo = new CustomOssNetworkVO();
//				vo.setProjectId(req.getProjectId());
//				vo.setProjectName(req.getProjectName());
//				vo.setNetworkName(sNetName);
//				vo.setNetworkAlias(sNetAlias);
////				vo.setAdminStateUp(true);
//				vo.setRegUserId(req.getRegUserId());
////				Network obj1 = ossnetworkservice.actInsert(vo);
//
////				vo.setNetworkId(obj1.getId());
//				vo.setNetworkName(sNetName);
//				vo.setNetworkAlias(sNetAlias);
//				ossNetworkDAO.insert(vo);
//
//				// log.debug("[SUBNET] ProjectName=" + req.getProjectName()
//				// 			+ ", NetworkId="+ obj1.getId()
//				// 			+ ", SubnetName=" + list.getSubnetName().toLowerCase()
//				// 			+ ", Cidr=" + list.getIpAddr()
//				// 			+ ", GatewayIp=" + list.getGateway()
//				// 		);
//				sSubnetName = req.getProjectName().toLowerCase()+list.getSubnetName().toLowerCase();
//				CustomOssSubnetVO vo1 = new CustomOssSubnetVO();
//				vo1.setProjectName(req.getProjectName());
////				vo1.setNetworkId(obj1.getId());
//				vo1.setSubnetName(sSubnetName);
//				vo1.setCidr(list.getIpAddr());
//				vo1.setIpVersion(4);
//				vo1.setGatewayIp(list.getGateway());
//				vo1.setGatewayIpBak("");
//				vo1.setEnableDhcp(true);
//				vo1.setDnsNameservers("");
//				vo1.setAllocationPools("");
//				vo1.setHostRoutes("");
//				ossSubnetService.insert(vo1);
//			}
//	}

	public String insertManager(CustomReqCustomerVO vo) throws NotSupportGatewayException {
		// project create
		String sRet = dao.insertManager(vo)+"";
		JsonObject jsonResponse = new JsonObject();
		jsonResponse.addProperty("error", sRet);

		return jsonResponse.toString();
	}

	public String insert(CustomOssProjectVO req) {
		Assert.notNull(req.getCloudId(), "");
		Assert.notNull(req.getProjectName(), "");
		String res = "";
		try {

			CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo(req.getCloudId());
			// project create
			if(cloudVo.getCloudType().equals("openstack")) {
				Project project = BatchProcessor.createProject(req.getProjectName(), null, cloudVo);
				req.setProjectId(project.getId());
				String sRet = dao.insert(req)+"";
				JsonObject jsonResponse = new JsonObject();
				jsonResponse.addProperty("error", sRet);
				jsonResponse.addProperty("projectId", project.getId());
				jsonResponse.addProperty("projectName", req.getProjectName());
			} else if(cloudVo.getCloudType().equals("vmware")) {
				vraProjectObject project = BatchProcessor.vRaCreateProject(req.getProjectName(), null, cloudVo);
				req.setProjectId(project.getId());
				String sRet = dao.insert(req)+"";
				JsonObject jsonResponse = new JsonObject();
				jsonResponse.addProperty("error", sRet);
				jsonResponse.addProperty("projectId", project.getId());
				jsonResponse.addProperty("projectName", req.getProjectName());
			}

		} catch (NotConnectGatewayException | NotSupportGatewayException | InvaildOpenStackException e) {
			log.error(e.getMessage());
		}
		return res;
	}




	public String update(CustomOssProjectVO req){
		Assert.notNull(req.getCloudId(), "");
		try {

			String sRet="";

			CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo(req.getCloudId());

			ProjectIF projectIf = AbstractFactory.getProject(cloudVo);
			Project project = new Project();
			if( (StringUtils.isNotEmpty(req.getProjectName())) && !(req.getProjectNameOrg().equals(req.getProjectName())) ){
				project.setName(req.getProjectName());
				project.setId(req.getProjectId());
				project = projectIf.updateProject(project);
			}

			sRet = dao.update(req)+"";
			JsonObject jsonResponse = new JsonObject();
			jsonResponse.addProperty("error", sRet);
			jsonResponse.addProperty("projectId", req.getProjectId());
			jsonResponse.addProperty("projectName", req.getProjectName());

			return jsonResponse.toString();
		} catch (NotConnectGatewayException | NotSupportGatewayException | InvaildOpenStackException e) {
			log.error(e.getMessage());
		}
		return "";
	}

	public String insertProvisioning(CustomOssProjectVO req) {
		req.setProvisioningSeq(DateFormatUtils.format(new Date(), "yyyyMMdd")+UUID.randomUUID());
		String sRet = dao.insertProvisioning(req)+"";
		JsonObject jsonResponse = new JsonObject();
		jsonResponse.addProperty("error", sRet);
		return jsonResponse.toString();

	}

	public int projectNameChk(CustomOssProjectVO req){
		return dao.projectNameChk(req);
	}

	public int projectNameNextChk(CustomOssProjectVO req){
		return dao.projectNameNextChk(req);
	}


	public int projectBoxIdChk(CustomOssProjectVO req){
		return dao.projectBoxIdChk(req);
	}



//	public String servicelist(CustomOssProjectVO req) {
//    	List<CustomOssProjectVO> lists = dao.servicelist(req);
//	    int recordsTotal = lists.size();
//	    int recordsFiltered = recordsTotal;
//
//	    try {
//	        JsonObject jsonResponse = new JsonObject();
//	        Gson gson = new Gson();
//
//	        jsonResponse.addProperty("draw", req.getDraw());
//	        jsonResponse.addProperty("recordsTotal", recordsTotal);
//	        jsonResponse.addProperty("recordsFiltered", recordsFiltered);
//	        jsonResponse.add("data", gson.toJsonTree(lists));
//
//	        return jsonResponse.toString();
//	    } catch (JsonIOException e) {
//	        logger.error("JSON 처리 중 오류 발생");
//	    }
//		return "";
//	}

	public List<CustomOssProjectVO> excel(CustomOssProjectVO req) {
		req.setLength(0);
		return dao.list(req);
	}
	public List<CustomOssProjectVO> mbrExcel(CustomOssProjectVO req) {
		req.setLength(0);
		return dao.mbrList(req);
	}
	public List<CustomOssProjectVO> mbrServiceExcel(CustomOssProjectVO req) {
		req.setLength(0);
		return dao.mbrProjectServiceList(req);
	}
	public List<CustomOssProjectVO> mbrPvExcel(CustomOssProjectVO req) {
		req.setLength(0);
		return dao.mbrNasAppList(req);
	}
	public BatchOssProjectVO selectProjectById(BatchOssProjectVO req) {
		return dao.selectProjectById(req);
	}

	public CustomOssProjectVO getOssProjectName(CustomOssProjectVO req) {
		return dao.getOssProjectName(req);
	}

	public CustomOssProjectVO getOssProjectIdByCloudId(CustomOssProjectVO req) {
		return dao.getOssProjectIdByCloudId(req);
	}

}
