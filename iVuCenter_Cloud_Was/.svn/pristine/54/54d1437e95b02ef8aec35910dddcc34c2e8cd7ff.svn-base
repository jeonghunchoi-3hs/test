package com.ivucenter.cloud.portal.application.req;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.time.DateFormatUtils;
import org.codehaus.jettison.json.JSONException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.JsonElement;
import com.ivucenter.cloud.api.common.utils.SystemCalculatorInfo;
import com.ivucenter.cloud.api.gitlab.GitlabObject;
import com.ivucenter.cloud.api.gitlab.GitlabUtils;
import com.ivucenter.cloud.api.openshift.connector.OpenShiftClientManager;
import com.ivucenter.cloud.api.openshift.object.OpsApiOptionService;
import com.ivucenter.cloud.portal.alarms.template.AlarmsTemplateService;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;
import com.ivucenter.cloud.portal.cmm.cloud.OssCloudService;
import com.ivucenter.cloud.portal.cmm.code.CmmCodeService;
import com.ivucenter.cloud.portal.cmm.code.CustomCmmCodeVO;
import com.ivucenter.cloud.portal.cmm.user.CmmUserService;
import com.ivucenter.cloud.portal.cmm.user.CustomCmmUserVO;
import com.ivucenter.cloud.portal.login.UserSession;
import com.ivucenter.cloud.portal.oss.application.CustomOssAppVO;
import com.ivucenter.cloud.portal.oss.application.OssAppService;
import com.ivucenter.cloud.portal.oss.project.CustomOssProjectVO;
import com.ivucenter.cloud.portal.oss.project.OssProjectService;
import com.ivucenter.cloud.portal.req.catalogue.CustomReqCatalogueVO;
import com.ivucenter.cloud.portal.req.catalogue.CustomReqOrderVO;
import com.ivucenter.cloud.portal.req.catalogue.ReqCatalogueService;
import com.ivucenter.cloud.portal.req.customer.CustomReqCustomerVO;
import com.ivucenter.cloud.portal.req.product.CustomReqProductVO;
import com.ivucenter.cloud.portal.req.product.ReqProductDAO;
import com.ivucenter.cloud.portal.req.product.ReqProductService;
import com.ivucenter.cloud.portal.util.CodeUtil;

import io.fabric8.kubernetes.api.model.ObjectMeta;
import io.fabric8.kubernetes.api.model.PodList;
import io.fabric8.kubernetes.api.model.ServiceList;
import io.fabric8.openshift.api.model.BuildList;
import io.fabric8.openshift.api.model.BuildRequest;
import io.fabric8.openshift.api.model.DeploymentConfig;
import io.fabric8.openshift.api.model.RouteList;
import io.fabric8.openshift.api.model.Template;
import io.fabric8.openshift.client.OpenShiftClient;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value = "/mbr/application/req")
public class mbrReqAppController {

    private static final Logger logger = LoggerFactory.getLogger(mbrReqAppController.class);

	@Autowired
	private ReqCatalogueService reqCatalogueService;

	@Autowired
	private CmmUserService cmmUserService;

	@Autowired
	private OssCloudService ossCloudService;

	@Autowired
	private AlarmsTemplateService alarmsTemplateService;

	@Autowired
	private ReqProductService reqProductService;

	@Autowired
	private OpsApiOptionService opsApiOptionService;

	@Autowired
	private OssAppService ossAppService;

	@Autowired
	private OssProjectService ossProjectservice;

	@Autowired
	private CmmCodeService cmmCodeService;

	@Resource(name="reqProductDAO")
	private ReqProductDAO reqProductDAO;


	@RequestMapping(value = "/", params = "!type")
	@Secured({ "ROLE_CUSTOM_USER" })
	public String mbrApplicationList(HttpServletRequest request, Model model) {
//		CustomReqCatalogueVO customCatalogVO = new CustomReqCatalogueVO();
//		customCatalogVO.setApplyDate(DateFormatUtils.format(new Date(), "yyyy-MM-dd"));
//		customCatalogVO.setEnableRecommandFlag("N"); // 모든상품 보여주기 && Display Falg = N
//		customCatalogVO.setConditionCategory(Arrays.asList("CATACATE_APP")); // 기본상품(VM) Category에 해당하는것
//
//		List<CustomReqCatalogueVO> getCatalogueList = reqCatalogueService.getCatalogueAppList(customCatalogVO);
//
//		model.addAttribute("getCatalogueList", getCatalogueList);
		return "mbr/application/req/reqApplication_List";
	}

	@RequestMapping(value = "/containerList")
	public ResponseEntity<Object> getVmList(Model model) {
		log.info("containerList");
		CustomReqCatalogueVO customCatalogVO = new CustomReqCatalogueVO();
		customCatalogVO.setApplyDate(DateFormatUtils.format(new Date(), "yyyy-MM-dd"));
//		customCatalogVO.setConditionCategory(Arrays.asList("CATACATE_APP", "CATACATE_VM")); // 기본상품(VM) Category에 해당하는것
		customCatalogVO.setConditionCategory(Arrays.asList("CATACATE_APP")); // 기본상품(VM) Category에 해당하는것

		List<CustomReqCatalogueVO> getContainerList = reqCatalogueService.getContainerList(customCatalogVO);
		model.addAttribute("getContainerList", getContainerList);

		return new ResponseEntity<Object>(getContainerList, HttpStatus.OK);
	}

	@RequestMapping(value = "/terminalList")
	public ResponseEntity<Object> getTreminalList(Model model) {
		CustomReqCatalogueVO customCatalogVO = new CustomReqCatalogueVO();
		customCatalogVO.setApplyDate(DateFormatUtils.format(new Date(), "yyyy-MM-dd"));
		customCatalogVO.setConditionCategory(Arrays.asList("CATACATE_VM")); // 기본상품(VM) Category에 해당하는것

		List<CustomReqCatalogueVO> getContainerList = reqCatalogueService.getContainerList(customCatalogVO);
		model.addAttribute("getContainerList", getContainerList);

		return new ResponseEntity<Object>(getContainerList, HttpStatus.OK);
	}


	@RequestMapping(value = "/write")
	@Secured({ "ROLE_CUSTOM_ADMIN", "ROLE_CUSTOM_USER" })
	public String mbrApplicationWrite(HttpServletRequest request, Model model, CustomOssAppVO req) throws JSONException {

		model.addAttribute("imageType", req.getImageType());
		model.addAttribute("cloudType", req.getCloudType());
		model.addAttribute("cloudId", req.getCloudId());

		String productSeq = req.getProductSeq();
		UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();

		model.addAttribute("apprvPass", userSession.getApprvPass());
//		model.addAttribute("userLevelCode", userSession.getLevelCode());
		model.addAttribute("customerId", userSession.getCustomerId());

		CustomCmmUserVO cmmUserInfo = new CustomCmmUserVO();
		cmmUserInfo.setUserId(request.getUserPrincipal().getName());
		cmmUserInfo = cmmUserService.userInfoDetail(cmmUserInfo);
		model.addAttribute("userLevelCode", cmmUserInfo.getUserLevelCode());

		CustomReqCatalogueVO projectvo = new CustomReqCatalogueVO();
		projectvo.setApplyDate(DateFormatUtils.format(new Date(), "yyyy-MM-dd"));
		projectvo.setProductSeq(productSeq);

		CustomReqCatalogueVO getSelectContainer = reqCatalogueService.getSelectContainer(projectvo);
		model.addAttribute("getCatalogueSelectApp", getSelectContainer);

		List<CustomOssCloudVO> cloudList = ossCloudService.getCloudList();
		model.addAttribute("cloudList", cloudList);

//		Template template = opsApiOptionService.getTemplate(cloudVo, getCatalogueSelectApp.getTemplateName(),getCatalogueSelectApp.getTemplateNameSpace());
//		model.addAttribute("parameters", template.getParameters());

		return "mbr/application/req/reqApplication_Write";
	}

	// 개발환경 배포 리스트 페이지
	@RequestMapping(value = "/catalogueDevList")
	@Secured({ "ROLE_CUSTOM_USER" })
	public String mbrDevList(HttpServletRequest request, Model model) {
		String cicdProjectId = request.getParameter("cicdProjectId");
		model.addAttribute("cicdProjectId", cicdProjectId);
		String cicdUrl = request.getParameter("cicdUrl");
		model.addAttribute("cicdUrl", cicdUrl);
		String vmType = request.getParameter("instanceType");
		model.addAttribute("instanceType", vmType);
		return "mbr/application/req/catalogueDevList";
	}

	// 배포현황(개발) 리스트 페이지
	@RequestMapping(value = "/reqDevDeployList")
	@Secured({ "ROLE_CUSTOM_USER" })
	public String mbrReqDevDeployList(HttpServletRequest request, Model model) {

		return "mbr/application/req/reqDevDeployList";
	}

	// 배포현황(개발) 리스트 페이지
	@RequestMapping(value = "/reqPrdDeployList")
	@Secured({ "ROLE_CUSTOM_USER" })
	public String mbrReqPrdDeployList(HttpServletRequest request, Model model) {

		return "mbr/application/req/reqPrdDeployList";
	}

	// 개발환경신청 페이지 함수
	@RequestMapping(value = "/catalogueDevEnv")
	@Secured({ "ROLE_CUSTOM_ADMIN", "ROLE_CUSTOM_USER" })
	public String mbrDevImportList(HttpServletRequest request, Model model, CustomOssAppVO req) throws JSONException {

		model.addAttribute("imageType", req.getImageType());
		model.addAttribute("cloudType", req.getCloudType());
//		model.addAttribute("cloudId", req.getCloudId());

		String productSeq = req.getProductSeq();
		UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();

		model.addAttribute("apprvPass", userSession.getApprvPass());
//		model.addAttribute("userLevelCode", userSession.getLevelCode());
		model.addAttribute("customerId", userSession.getCustomerId());

		CustomCmmUserVO cmmUserInfo = new CustomCmmUserVO();
		cmmUserInfo.setUserId(request.getUserPrincipal().getName());
		cmmUserInfo = cmmUserService.userInfoDetail(cmmUserInfo);
		model.addAttribute("userLevelCode", cmmUserInfo.getUserLevelCode());

		CustomReqCatalogueVO projectvo = new CustomReqCatalogueVO();
		projectvo.setApplyDate(DateFormatUtils.format(new Date(), "yyyy-MM-dd"));
		projectvo.setProductSeq(productSeq);

		CustomReqCatalogueVO getSelectContainer = reqCatalogueService.getSelectContainer(projectvo);
		model.addAttribute("getCatalogueSelectApp", getSelectContainer);

		List<CustomOssCloudVO> cloudList = ossCloudService.getCloudList();
		model.addAttribute("cloudList", cloudList);

		List<CustomCmmCodeVO> getVisibilityCode = cmmCodeService.getCmmCode("ENV_VISIBILITY");
		model.addAttribute("getVisibilityCode", getVisibilityCode);

		List<CustomCmmCodeVO> getAccessLevelCode = cmmCodeService.getCmmCode("ENV_ACCESS_LEVEL");
		ObjectMapper mapper = new ObjectMapper();
		try {
			model.addAttribute("getAccessLevelCode", mapper.writeValueAsString(getAccessLevelCode));
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "mbr/application/req/catalogueDevEnv";
	}

	// 운영배포 페이지 이동함수
	@RequestMapping(value = "/cataloguePrdExport")
	@Secured({ "ROLE_CUSTOM_ADMIN", "ROLE_CUSTOM_USER" })
	public String mbrPrdExportList(HttpServletRequest request, Model model, CustomOssAppVO req) throws JSONException {
		// pipeline ID 조회
		CustomReqProductVO customReqProductVO = new CustomReqProductVO();
		String cicdProjectId = request.getParameter("cicdProjectId");
		customReqProductVO.setCicdProjectId(cicdProjectId);
		String pipelineId = request.getParameter("pipelineId");
		customReqProductVO.setPipelineId(pipelineId);
//		String appUid = request.getParameter("appUid");
		CustomReqProductVO prdPipeLine = ossAppService.getPrdPipeLineDetail(customReqProductVO);
		model.addAttribute("prdPipeLine", prdPipeLine);
		log.info("appVersion {}", prdPipeLine.getEnvApplicationVersion());
//		CustomOssAppVO res = ossAppService.ossAppByAppUid(customOssAppVO);

		model.addAttribute("imageType", prdPipeLine.getImageType());
		model.addAttribute("cloudType", prdPipeLine.getCloudType());
		model.addAttribute("cloudId", prdPipeLine.getCloudId());

		String productSeq = prdPipeLine.getTemplateProductSeq(); // bss_product_app 상품 번호 동일 함.
		UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();

		model.addAttribute("apprvPass", userSession.getApprvPass());
		model.addAttribute("customerId", userSession.getCustomerId());
		model.addAttribute("username", userSession.getUsername());

		CustomCmmUserVO cmmUserInfo = new CustomCmmUserVO();
		cmmUserInfo.setUserId(request.getUserPrincipal().getName());
		cmmUserInfo = cmmUserService.userInfoDetail(cmmUserInfo);
		model.addAttribute("userLevelCode", cmmUserInfo.getUserLevelCode());

		CustomReqCatalogueVO projectvo = new CustomReqCatalogueVO();
		projectvo.setApplyDate(DateFormatUtils.format(new Date(), "yyyy-MM-dd"));
		projectvo.setProductSeq(productSeq);

		CustomReqCatalogueVO getSelectContainer = reqCatalogueService.getSelectContainer(projectvo);
		model.addAttribute("getCatalogueSelectApp", getSelectContainer);

		List<CustomOssCloudVO> cloudList = ossCloudService.getCloudList();
		model.addAttribute("cloudList", cloudList);

		List<CustomCmmCodeVO> getVisibilityCode = cmmCodeService.getCmmCode("ENV_VISIBILITY");
		model.addAttribute("getVisibilityCode", getVisibilityCode);

		List<CustomCmmCodeVO> getDomainUrlTypeCode = cmmCodeService.getCmmCode("DOMAIN_URL_TYPE");
		model.addAttribute("getDomainUrlTypeCode", getDomainUrlTypeCode);

		model.addAttribute("projectBoxId", request.getParameter("projectBoxId"));

		return "mbr/application/req/cataloguePrdExport";
	}

	// 개발배포 페이지 이동함수
	@RequestMapping(value = "/catalogueDevExport")
	@Secured({ "ROLE_CUSTOM_ADMIN", "ROLE_CUSTOM_USER" })
	public String mbrDevExportList(HttpServletRequest request, Model model, CustomOssAppVO req) throws JSONException {

//		String cicdProjectId = request.getParameter("cicdProjectId");
//		model.addAttribute("cicdProjectId", cicdProjectId);

//		String cicdUrl = request.getParameter("cicdUrl");
//		model.addAttribute("cicdUrl", cicdUrl);

		model.addAttribute("imageType", req.getImageType());
		model.addAttribute("cloudType", req.getCloudType());
		model.addAttribute("cloudId", req.getCloudId());

		String productSeq = req.getProductSeq();
		UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();

		model.addAttribute("apprvPass", userSession.getApprvPass());
		model.addAttribute("customerId", userSession.getCustomerId());
		model.addAttribute("username", userSession.getUsername());

		CustomCmmUserVO cmmUserInfo = new CustomCmmUserVO();
		cmmUserInfo.setUserId(request.getUserPrincipal().getName());
		cmmUserInfo = cmmUserService.userInfoDetail(cmmUserInfo);
		model.addAttribute("userLevelCode", cmmUserInfo.getUserLevelCode());

		CustomReqCatalogueVO projectvo = new CustomReqCatalogueVO();
		projectvo.setApplyDate(DateFormatUtils.format(new Date(), "yyyy-MM-dd"));
		projectvo.setProductSeq(productSeq);

		CustomReqCatalogueVO getSelectContainer = reqCatalogueService.getSelectContainer(projectvo);
		model.addAttribute("getCatalogueSelectApp", getSelectContainer);

		List<CustomOssCloudVO> cloudList = ossCloudService.getCloudList();
		model.addAttribute("cloudList", cloudList);

		List<CustomCmmCodeVO> getVisibilityCode = cmmCodeService.getCmmCode("ENV_VISIBILITY");
		model.addAttribute("getVisibilityCode", getVisibilityCode);

		List<CustomCmmCodeVO> getDomainUrlTypeCode = cmmCodeService.getCmmCode("DOMAIN_URL_TYPE");
		model.addAttribute("getDomainUrlTypeCode", getDomainUrlTypeCode);

		return "mbr/application/req/catalogueDevExport";
	}

	// 개발배포 페이지 이동함수
	@RequestMapping(value = "/catalogueDevExportDetail")
	@Secured({ "ROLE_CUSTOM_ADMIN", "ROLE_CUSTOM_USER" })
	public String mbrDevExportDetail(HttpServletRequest request, Model model, CustomOssAppVO req) throws JSONException {
		// pipeline ID 조회
		CustomReqProductVO customReqProductVO = new CustomReqProductVO();
		String cicdProjectId = request.getParameter("cicdProjectId");
		String pipelineId = request.getParameter("pipelineId");
		String appName = request.getParameter("appName");
		customReqProductVO.setCicdProjectId(cicdProjectId);
		customReqProductVO.setPipelineId(pipelineId);
		CustomReqProductVO devPipeLine = ossAppService.getDevPipeLineDetail(customReqProductVO);
		model.addAttribute("devPipeLine", devPipeLine);
		System.out.println(devPipeLine.getEnvApplicationVersion());

		customReqProductVO.setAppName(appName);
		CustomReqProductVO devPipeLineVersion = ossAppService.getDevPipeLineVersion(customReqProductVO);
		String afterVersion = devPipeLineVersion.getAfterVersion();
		model.addAttribute("afterVersion", afterVersion);

		model.addAttribute("imageType", devPipeLine.getImageType());
		model.addAttribute("cloudType", devPipeLine.getCloudType());
		model.addAttribute("cloudId", devPipeLine.getCloudId());

		String productSeq = devPipeLine.getTemplateProductSeq(); // bss_product_app 상품 번호 동일 함.
		UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();

		model.addAttribute("apprvPass", userSession.getApprvPass());
		model.addAttribute("customerId", userSession.getCustomerId());
		model.addAttribute("username", userSession.getUsername());

		CustomCmmUserVO cmmUserInfo = new CustomCmmUserVO();
		cmmUserInfo.setUserId(request.getUserPrincipal().getName());
		cmmUserInfo = cmmUserService.userInfoDetail(cmmUserInfo);
		model.addAttribute("userLevelCode", cmmUserInfo.getUserLevelCode());

		CustomReqCatalogueVO projectvo = new CustomReqCatalogueVO();
		projectvo.setApplyDate(DateFormatUtils.format(new Date(), "yyyy-MM-dd"));
		projectvo.setProductSeq(productSeq);

		CustomReqCatalogueVO getSelectContainer = reqCatalogueService.getSelectContainer(projectvo);
		model.addAttribute("getCatalogueSelectApp", getSelectContainer);

		List<CustomOssCloudVO> cloudList = ossCloudService.getCloudList();
		model.addAttribute("cloudList", cloudList);

		List<CustomCmmCodeVO> getVisibilityCode = cmmCodeService.getCmmCode("ENV_VISIBILITY");
		model.addAttribute("getVisibilityCode", getVisibilityCode);

		model.addAttribute("projectBoxId", request.getParameter("projectBoxId"));

		return "mbr/application/req/catalogueDevExportDetail";
	}

	// 개발배포 페이지 이동함수
	@RequestMapping(value = "/cataloguePrdExportDetail")
	@Secured({ "ROLE_CUSTOM_ADMIN", "ROLE_CUSTOM_USER" })
	public String mbrPrdExportDetail(HttpServletRequest request, Model model, CustomOssAppVO req) throws JSONException {

		// pipeline ID 조회
		CustomReqProductVO customReqProductVO = new CustomReqProductVO();
		String cicdProjectId = request.getParameter("cicdProjectId");
		String pipelineId = request.getParameter("pipelineId");
		String orderProductSeq = request.getParameter("orderProductSeq");
		String appName = request.getParameter("appName");

//		String appUid = request.getParameter("appUid");
		customReqProductVO.setCicdProjectId(cicdProjectId);
		customReqProductVO.setPipelineId(pipelineId);
		customReqProductVO.setOrderProductSeq(orderProductSeq);

		CustomReqProductVO prdPipeLine = ossAppService.getPrdPipeLineDetail(customReqProductVO);
		model.addAttribute("prdPipeLine", prdPipeLine);
		log.info("prd Export Detail >>  {}",prdPipeLine.getFlavorId());
		log.info("appVersion {}",prdPipeLine.getEnvApplicationVersion());
		if(orderProductSeq != null && !orderProductSeq.equals("")) {
			customReqProductVO.setAppName(appName);
			CustomReqProductVO getPrdPipeLineVersion = ossAppService.getPrdPipeLineVersion(customReqProductVO);
			String afterVersion = getPrdPipeLineVersion.getAfterVersion();
			model.addAttribute("afterVersion", afterVersion);
		}

//		CustomOssAppVO res = ossAppService.ossAppByAppUid(customOssAppVO);

		model.addAttribute("imageType", prdPipeLine.getImageType());
		model.addAttribute("cloudType", prdPipeLine.getCloudType());
		model.addAttribute("cloudId", prdPipeLine.getCloudId());

		String productSeq = prdPipeLine.getTemplateProductSeq(); // bss_product_app 상품 번호 동일 함.
		UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();

		model.addAttribute("apprvPass", userSession.getApprvPass());
		model.addAttribute("customerId", userSession.getCustomerId());
		model.addAttribute("username", userSession.getUsername());

		CustomCmmUserVO cmmUserInfo = new CustomCmmUserVO();
		cmmUserInfo.setUserId(request.getUserPrincipal().getName());
		cmmUserInfo = cmmUserService.userInfoDetail(cmmUserInfo);
		model.addAttribute("userLevelCode", cmmUserInfo.getUserLevelCode());

		CustomReqCatalogueVO projectvo = new CustomReqCatalogueVO();
		projectvo.setApplyDate(DateFormatUtils.format(new Date(), "yyyy-MM-dd"));
		projectvo.setProductSeq(productSeq);

		CustomReqCatalogueVO getSelectContainer = reqCatalogueService.getSelectContainer(projectvo);
		model.addAttribute("getCatalogueSelectApp", getSelectContainer);

		List<CustomOssCloudVO> cloudList = ossCloudService.getCloudList();
		model.addAttribute("cloudList", cloudList);

		List<CustomCmmCodeVO> getVisibilityCode = cmmCodeService.getCmmCode("ENV_VISIBILITY");
		model.addAttribute("getVisibilityCode", getVisibilityCode);

		model.addAttribute("projectBoxId", request.getParameter("projectBoxId"));

		return "mbr/application/req/cataloguePrdExportDetail";
	}

	@RequestMapping(value = "/applyCationParamReturn", method = { RequestMethod.GET, RequestMethod.POST })
	@Secured({ "ROLE_CUSTOM_ADMIN", "ROLE_CUSTOM_USER" })
	public ResponseEntity applyCationParamReturn(HttpServletRequest request, Model model) throws JSONException {
		String searchKey = request.getParameter("searchKey");
		String searchValue = request.getParameter("searchValue");
		String cloudId = request.getParameter("cloudId");
		CustomReqCatalogueVO projectvo = new CustomReqCatalogueVO();
		projectvo.setSearchKey(searchKey);
		projectvo.setSearchValue(searchValue);
		projectvo.setRegUserId(request.getUserPrincipal().getName());
		projectvo.setCloudId(cloudId);
		List<CustomReqCatalogueVO> getProjectList = reqCatalogueService.getProjectList(projectvo);
		for (int i = 0; i < getProjectList.size(); i++) {
			String lowProjectName = getProjectList.get(i).getProjectName().toLowerCase();
			getProjectList.get(i).setLowProjectName(lowProjectName);
		}

		HashMap<String, Object> map = new HashMap<>();
		map.put("userId", request.getUserPrincipal().getName());
		map.put("getProjectList", getProjectList);
		// model.addAttribute("searchKey", searchKey);
		map.put("searchValue", searchValue);
		return new ResponseEntity<Object>(map, HttpStatus.OK);
	}

	@RequestMapping(value = "/detail")
	public String mbrApplicationDetail(ModelMap model, CustomOssAppVO req) {

		model.addAttribute("appUuid", req.getAppUid());
		model.addAttribute("projectId", req.getProjectId());
		model.addAttribute("cloudId", req.getCloudId());

		return "mbr/application/req/reqApplication_Detail";
	}

	// 어플리케이션 조회부분
	@RequestMapping(value = "/appliycationInfo", method = { RequestMethod.GET, RequestMethod.POST })
	public ResponseEntity<Object> MbrAdminUserAddList(HttpServletRequest request, Model model) {

		Map rt_param = new HashMap();
		try {
			String productSeq = request.getParameter("productSeq");

			CustomCmmUserVO cmmUserInfo = new CustomCmmUserVO();
			cmmUserInfo.setUserId(request.getUserPrincipal().getName()); cmmUserInfo =
			cmmUserService.userInfoDetail(cmmUserInfo);
			rt_param.put("userLevelCode", cmmUserInfo.getUserLevelCode());

			Date nowdate = new Date(); SimpleDateFormat dateFormat = new
			SimpleDateFormat("yyyy-MM-dd"); String applyDate =
			dateFormat.format(nowdate);

			CustomReqCatalogueVO projectvo = new CustomReqCatalogueVO();
			projectvo.setApplyDate(applyDate); projectvo.setProductSeq(productSeq);

			CustomReqCatalogueVO getCatalogueSelectApp =
			reqCatalogueService.getCatalogueSelectApp(projectvo);
			projectvo.setVmImageType(getCatalogueSelectApp.getVmImageType());
			rt_param.put("getCatalogueSelectApp", getCatalogueSelectApp);

			CustomOssCloudVO cloudVo =
			ossCloudService.getCloudInfo(getCatalogueSelectApp.getCloudId());
			Template template = opsApiOptionService.getTemplate(cloudVo,getCatalogueSelectApp.getTemplateName() , getCatalogueSelectApp.getTemplateNameSpace());
			rt_param.put("parameters", template.getParameters());

		}catch (Exception e) {
            logger.error("MbrAdminUserAddList Exception");
		}
		return new ResponseEntity<Object>(rt_param, HttpStatus.OK);
	}

	@RequestMapping(value = "/getGitlabContextDirList", method = RequestMethod.GET)
	public ResponseEntity<Object> getGitlabContextDirList(HttpServletRequest request) {

		SystemCalculatorInfo systemCalculatorInfo = new SystemCalculatorInfo();

		String cicdProjectId = request.getParameter("cicdProjectId");
		String branch = "staging";
		GitlabObject obj;
		List<HashMap<String, Object>> contextDirList = new ArrayList<>();

		try {
			obj = GitlabUtils.getGitlabContextDir(systemCalculatorInfo, cicdProjectId, branch);

			for(JsonElement jsonElement : obj.getJsonArray()) {

				if(jsonElement.getAsJsonObject().get("type").getAsString().equals("tree")) {
					HashMap<String, Object> contextDir = new HashMap<>();
					contextDir.put("dirName", jsonElement.getAsJsonObject().get("name").getAsString());
					contextDirList.add(contextDir);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ResponseEntity<Object>(contextDirList, HttpStatus.OK);
	}

	@RequestMapping(value = "/projectPopList", method = RequestMethod.GET)
	public ResponseEntity<Object> getprojectPopList(HttpServletRequest request) {

		String searchKey = request.getParameter("searchKey");
		String searchValue = request.getParameter("searchValue");
		String cloudId = request.getParameter("cloudId");
		CustomReqCatalogueVO projectvo = new CustomReqCatalogueVO();
		projectvo.setSearchKey(searchKey);
		projectvo.setSearchValue(searchValue);
		projectvo.setRegUserId(request.getUserPrincipal().getName());
		projectvo.setCloudId(cloudId);
		List<CustomReqCatalogueVO> getProjectList = reqCatalogueService.getProjectList(projectvo);
		for (int i = 0; i < getProjectList.size(); i++) {
			String lowProjectName = getProjectList.get(i).getProjectName().toLowerCase();
			getProjectList.get(i).setLowProjectName(lowProjectName);
		}

		HashMap<String, Object> map = new HashMap<>();
		map.put("userId", request.getUserPrincipal().getName());
		map.put("getProjectList", getProjectList);
		// model.addAttribute("searchKey", searchKey);
		map.put("searchValue", searchValue);
		return new ResponseEntity<Object>(map, HttpStatus.OK);
	}

	@RequestMapping(value = "/devEnvPopList", method = RequestMethod.GET)
	public ResponseEntity<Object> devEnvPopList(HttpServletRequest request) {

		String searchKey = request.getParameter("searchKey");
		String searchValue = request.getParameter("searchValue");
		String cloudId = request.getParameter("cloudId");
		CustomReqCatalogueVO projectvo = new CustomReqCatalogueVO();
		projectvo.setSearchKey(searchKey);
		projectvo.setSearchValue(searchValue);
		projectvo.setRegUserId(request.getUserPrincipal().getName());
		projectvo.setCloudId(cloudId);
		List<CustomReqCatalogueVO> getDevEnvList = reqCatalogueService.getDevEnvList(projectvo);
		for (int i = 0; i < getDevEnvList.size(); i++) {
			String lowProjectName = getDevEnvList.get(i).getProjectName().toLowerCase();
			getDevEnvList.get(i).setLowProjectName(lowProjectName);
		}

		HashMap<String, Object> map = new HashMap<>();
		map.put("userId", request.getUserPrincipal().getName());
		map.put("getDevEnvList", getDevEnvList);
		// model.addAttribute("searchKey", searchKey);
		map.put("searchValue", searchValue);
		return new ResponseEntity<Object>(map, HttpStatus.OK);
	}

	@RequestMapping(value = "/catalogueApp", params = "type=noworder")
	public ResponseEntity<Object> catalogueApp(HttpServletRequest request, Model model, CustomReqOrderVO ordervo) {
		String res = "1";

		try {
			ordervo.setOrderUserId(request.getUserPrincipal().getName());
			model.addAttribute("ordervo", ordervo);

			String orderProductSeq = DateFormatUtils.format(new Date(), "yyyyMMddHHmmss");
			String orderNo = orderProductSeq;

			ordervo.setOrderProductSeq(orderProductSeq);
			ordervo.setOrderNo(orderNo);
			ordervo.setProductCategory("PRODCATE_APP");
			ordervo.setHourlyFlag("N");
//			ordervo.setProjectId(ordervo.getProjectBoxId());
			ordervo.setPodCnt(ordervo.getAppCnt());

			ordervo.setRequestType("REQTYPE_NEW");

			ordervo.setPodCnt(Integer.parseInt(request.getParameter("podCount"))); // POD 수
			ordervo.setVolume(Integer.parseInt(request.getParameter("pvcVolume"))); // PVC volume

			ordervo.setOsProductSeq(request.getParameter("osProductSeq")); //
			ordervo.setImageId(request.getParameter("imageId")); // Template 명
			ordervo.setPvcYn(request.getParameter("onPvcFlagNm")); // PV 사용여부
			ordervo.setDescription(request.getParameter("etcNm")); // 기타사항
			ordervo.setAppAlias(request.getParameter("appName")); // 컨테이너 alias

			String tmpApprovalStepList = request.getParameter("approvalStepListString");
			ordervo.setApprovalStepList(tmpApprovalStepList);

			String orderSummary = "";

			String setOrder = reqCatalogueService.setOrder(ordervo);
//			String projectId = reqCatalogueService.detailProjectId2(ordervo);

			// project id 를 주문정보에서 뺌. (환경 신청은 BOX ID)
			// 기존로직에서는 사용되어야함.
			ordervo.setEnvType(CodeUtil.DEV_ENV_TYPE_CODE_ID);
			String projectId = reqCatalogueService.detailProjectId(ordervo);
			ordervo.setProjectId(projectId);

			// 주문정보 저장
			reqCatalogueService.setOrderProduct(ordervo);
			reqCatalogueService.setOrderProductApp(ordervo);

			// 1차 승인 예정자
			String currentUserIdReview = "";
			String hiddenUserIdReview = request.getParameter("hiddenUserIdReview");
			// 2차 승인 예정자
			String hiddenUserIdApprove = request.getParameter("hiddenUserIdApprove");
			// 2020.05.25(장중일) - 신규 결재라인 등록 부분
			// 지정된 결재자 정보
			List<Map<String, Object>> stepList = ordervo.getApprovalStepList();
			// 결재라인 정보
			List<CustomReqCustomerVO> getApprovalModelSteplist = reqCatalogueService.getApprovalModelSteplist2();

			int tmpStep = 0;
			boolean tmpStartFlag = false;
			if (ordervo.getSelectApprv().equals("Y") && ordervo.getApprvPass().equals("Y")) {
				for (CustomReqCustomerVO customerVO : getApprovalModelSteplist) {
					UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication()
							.getPrincipal();
					CustomReqCustomerVO paramStepInfo = new CustomReqCustomerVO();
					paramStepInfo.setRequestSeq(ordervo.getOrderNo());
					paramStepInfo.setStepId(customerVO.getStepId());
					paramStepInfo.setModelId(customerVO.getModelId());
					paramStepInfo.setStepName(customerVO.getStepName());
					paramStepInfo.setStepLevel(customerVO.getStepLevel());
					paramStepInfo.setLeftStepId(customerVO.getLeftStepId());
					paramStepInfo.setRightStepId(customerVO.getRightStepId());

					if (tmpStep < 5) {
						paramStepInfo.setApprvUserId(userSession.getUsername());
						paramStepInfo.setApprvUserName(userSession.getNickname());
						paramStepInfo.setApprvScheduleUserId(userSession.getUsername());
						paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_COMPLETED);
					} else {
						if (tmpStep == 5) {
							paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_UNASSIGNED);
						} else {
							paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_WAITING);
						}
					}
					tmpStep++;
					reqCatalogueService.setSrApprovalStepinsert2(paramStepInfo);

					if (tmpStep < 3) {
						tmpStep++;
					}
				}
			} else {
				for (CustomReqCustomerVO customerVO : getApprovalModelSteplist) {
					HashMap<String, Object> stepInfo = (HashMap<String, Object>) stepList.get(tmpStep);

					CustomReqCustomerVO paramStepInfo = new CustomReqCustomerVO();
					paramStepInfo.setRequestSeq(ordervo.getOrderNo());
					paramStepInfo.setStepId(customerVO.getStepId());
					paramStepInfo.setModelId(customerVO.getModelId());
					paramStepInfo.setStepName(customerVO.getStepName());
					paramStepInfo.setStepLevel(customerVO.getStepLevel());
					paramStepInfo.setLeftStepId(customerVO.getLeftStepId());
					paramStepInfo.setRightStepId(customerVO.getRightStepId());

					if (paramStepInfo.getStepLevel().equals("1")) {
						if (stepInfo.get("userId").equals("") || stepInfo.get("userId") == null) {
							tmpStartFlag = true;
							paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_COMPLETED);
						} else {
							paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_PROCESSING);
							paramStepInfo.setApprvScheduleUserId((String)stepInfo.get("userId"));
							hiddenUserIdReview = (String)stepInfo.get("userId");
							currentUserIdReview = (String)stepInfo.get("userId");
						}

					} else if (paramStepInfo.getStepLevel().equals("2")) {
						if (tmpStartFlag) {
							paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_PROCESSING);
							paramStepInfo.setApprvScheduleUserId((String)stepInfo.get("userId"));
						} else {
							paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_WAITING);
							paramStepInfo.setApprvScheduleUserId((String)stepInfo.get("userId"));
							hiddenUserIdReview = (String)stepInfo.get("userId");
						}

					} else if (paramStepInfo.getStepLevel().equals("3")) {
						paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_WAITING);
						paramStepInfo.setApprvScheduleUserId((String)stepInfo.get("userId"));

					} else if (paramStepInfo.getStepLevel().equals("4")) {
						paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_WAITING);
						paramStepInfo.setApprvScheduleUserId((String)stepInfo.get("userId"));

					} else {
						paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_WAITING);
					}
					reqCatalogueService.setSrApprovalStepinsert2(paramStepInfo);

					if (tmpStep < 3) {
						tmpStep++;
					}
				}
				CustomReqProductVO reqProductVo = reqProductService.orderUserInfo(ordervo.getOrderNo());
				Map<String, String> keywordMap = new HashMap<>();
				keywordMap.put("[[신청자명]]", reqProductVo.getUserName());
				keywordMap.put("[[서버명]]", orderSummary);
				keywordMap.put("[[URL]]",
						"http://k-cloud.kepco.co.kr/mbr/req/catalogue/bssOrderApproveView?orderNo=" + ordervo.getOrderNo());

				keywordMap.put("[[LURL]]", "http://k-cloud.kepco.co.kr/mbr");

				// 신청자에게 알림
				alarmsTemplateService.alarms(30, ordervo.getOrderUserId(), keywordMap);
				// 결재자에게 요청
				alarmsTemplateService.alarms(33, currentUserIdReview, keywordMap);
				// 한전 연계 시스템 전송
				Map<String, String> alarmkepcoMap = new HashMap<>();
				alarmkepcoMap.put("gbn", "30");
				alarmkepcoMap.put("requestSeq", ordervo.getOrderNo());
				alarmkepcoMap.put("regUserId", ordervo.getOrderUserId()); // 자원 신청자
				alarmkepcoMap.put("apprvNextUserId", currentUserIdReview); // 다음 결재자
				alarmkepcoMap.put("url",
						"http://k-cloud.kepco.co.kr/mbr/req/catalogue/bssOrderApproveView?orderNo=" + orderNo);
				alarmsTemplateService.alarmsKepco(alarmkepcoMap);
			}

			res = setOrder;
		}catch (Exception e) {
            logger.error("catalogueApp Exception");
		}

		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	// 개발환경신청 함수
	@RequestMapping(value = "/catalogueEnv", params = "type=noworder")
	public ResponseEntity<Object> catalogueEnv(HttpServletRequest request, Model model, CustomReqOrderVO ordervo) {
//		String res = "1";
//
//		UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
//
//		String orderProductSeq = DateFormatUtils.format(new Date(), "yyyyMMddHHmmss");
//		ordervo.setDevUserList(ordervo.getDevUserListString());
//		// 개발자 라인 등록 start
////		String devUserStepList = request.getParameter("devUserListString");
//
////		devUserListString
////		ordervo.getDevUserList();
//		try {
//			for(Map<String, Object> map : ordervo.getDevUserList()) {
//				CustomReqOrderVO devUser = new CustomReqOrderVO();
//				devUser.setOrderProductSeq(orderProductSeq); // 각 개발자의 주문 시퀀스 설정
//				devUser.setEnvUserEmail(devUser.getEnc(map.get("envUserEmail").toString()));
//				devUser.setEnvUserPassword(devUser.getEnc(map.get("envUserPassword").toString()));
////				devUser.setRegUserId(map.get("RegUserId").toString());
//				devUser.setRegUserId(userSession.getUsername());
//
//				reqCatalogueService.setDevUserInsert(devUser); // 개발자 정보 삽입
//			}
//		}catch (Exception e) {
//			e.printStackTrace();
//		}

		String res = "1";

		UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();

		String orderProductSeq = DateFormatUtils.format(new Date(), "yyyyMMddHHmmss");
		// 개발자 라인 등록 start
		String devUserStepList = request.getParameter("devUserListString");
		ObjectMapper mapper = new ObjectMapper();
		try {
			CustomReqOrderVO[] devUsers = mapper.readValue(devUserStepList, CustomReqOrderVO[].class);
			// 각 개발자 정보를 Service로 전달하여 삽입
			for (CustomReqOrderVO devUser : devUsers) {
				devUser.setOrderProductSeq(orderProductSeq); // 각 개발자의 주문 시퀀스 설정
				devUser.setEnvUserEmail(devUser.getEnvUserEmailEnc());
				devUser.setEnvUserPassword(devUser.getEnvUserPasswordEnc());
				devUser.setRegUserId(userSession.getUsername());

				reqCatalogueService.setDevUserInsert(devUser); // 개발자 정보 삽입
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		// 개발자 라인 등록 end
		try {
			ordervo.setOrderUserId(request.getUserPrincipal().getName());
			model.addAttribute("ordervo", ordervo);

			String orderNo = orderProductSeq;

			ordervo.setOrderProductSeq(orderProductSeq);
			ordervo.setOrderNo(orderNo);
			ordervo.setProductCategory("PRODCATE_ENV");
			ordervo.setHourlyFlag("N");
			ordervo.setPodCnt(ordervo.getAppCnt());

			ordervo.setRequestType("REQTYPE_NEW");

			ordervo.setPodCnt(Integer.parseInt(request.getParameter("podCount"))); // POD 수
			ordervo.setVolume(Integer.parseInt(request.getParameter("pvcVolume"))); // PVC volume

//			ordervo.setOsProductSeq(request.getParameter("osProductSeq"));
			ordervo.setProductSeq(request.getParameter("productSeq"));
			ordervo.setCatalogSeq(request.getParameter("catalogSeq"));
			ordervo.setImageId(request.getParameter("imageId")); // Template 명
			ordervo.setPvcYn(request.getParameter("onPvcFlagNm")); // PV 사용여부
			ordervo.setDescription(request.getParameter("description")); // 기타사항
//			ordervo.setEnvName(request.getParameter("envName"));
			ordervo.setEnvAlias(request.getParameter("envAlias"));

			String tmpApprovalStepList = request.getParameter("approvalStepListString");
			ordervo.setApprovalStepList(tmpApprovalStepList);

			String orderSummary = "";

			String setOrder = reqCatalogueService.setOrder(ordervo);
//			String projectId = reqCatalogueService.detailProjectId(ordervo);
//			ordervo.setProjectId(projectId);

			// 주문정보 저장
			reqCatalogueService.setOrderProduct(ordervo);
			reqCatalogueService.setOrderProductEnv(ordervo);

			// 1차 승인 예정자
			String currentUserIdReview = "";
			String hiddenUserIdReview = request.getParameter("hiddenUserIdReview");
			// 2차 승인 예정자
			String hiddenUserIdApprove = request.getParameter("hiddenUserIdApprove");
			// 2020.05.25(장중일) - 신규 결재라인 등록 부분
			// 지정된 결재자 정보
			List<Map<String, Object>> stepList = ordervo.getApprovalStepList();
			// 결재라인 정보
			List<CustomReqCustomerVO> getApprovalModelSteplist = reqCatalogueService.getApprovalModelSteplist2();

			int tmpStep = 0;
			boolean tmpStartFlag = false;
			if (ordervo.getSelectApprv().equals("Y") && ordervo.getApprvPass().equals("Y")) {
				for (CustomReqCustomerVO customerVO : getApprovalModelSteplist) {
					CustomReqCustomerVO paramStepInfo = new CustomReqCustomerVO();
					paramStepInfo.setRequestSeq(ordervo.getOrderNo());
					paramStepInfo.setStepId(customerVO.getStepId());
					paramStepInfo.setModelId(customerVO.getModelId());
					paramStepInfo.setStepName(customerVO.getStepName());
					paramStepInfo.setStepLevel(customerVO.getStepLevel());
					paramStepInfo.setLeftStepId(customerVO.getLeftStepId());
					paramStepInfo.setRightStepId(customerVO.getRightStepId());

					if (tmpStep < 5) {
						paramStepInfo.setApprvUserId(userSession.getUsername());
						paramStepInfo.setApprvUserName(userSession.getNickname());
						paramStepInfo.setApprvScheduleUserId(userSession.getUsername());
						paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_COMPLETED);
					} else {
						if (tmpStep == 5) {
							paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_UNASSIGNED);
						} else {
							paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_WAITING);
						}
					}
					tmpStep++;
					reqCatalogueService.setSrApprovalStepinsert2(paramStepInfo);

					if (tmpStep < 3) {
						tmpStep++;
					}
				}
			} else {
				for (CustomReqCustomerVO customerVO : getApprovalModelSteplist) {
					HashMap<String, Object> stepInfo = (HashMap<String, Object>) stepList.get(tmpStep);

					CustomReqCustomerVO paramStepInfo = new CustomReqCustomerVO();
					paramStepInfo.setRequestSeq(ordervo.getOrderNo());
					paramStepInfo.setStepId(customerVO.getStepId());
					paramStepInfo.setModelId(customerVO.getModelId());
					paramStepInfo.setStepName(customerVO.getStepName());
					paramStepInfo.setStepLevel(customerVO.getStepLevel());
					paramStepInfo.setLeftStepId(customerVO.getLeftStepId());
					paramStepInfo.setRightStepId(customerVO.getRightStepId());

					if (paramStepInfo.getStepLevel().equals("1")) {
						if (stepInfo.get("userId").equals("") || stepInfo.get("userId") == null) {
							tmpStartFlag = true;
							paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_COMPLETED);
						} else {
							paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_PROCESSING);
							paramStepInfo.setApprvScheduleUserId((String)stepInfo.get("userId"));
							hiddenUserIdReview = (String)stepInfo.get("userId");
							currentUserIdReview = (String)stepInfo.get("userId");
						}

					} else if (paramStepInfo.getStepLevel().equals("2")) {
						if (tmpStartFlag) {
							paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_PROCESSING);
							paramStepInfo.setApprvScheduleUserId((String)stepInfo.get("userId"));
						} else {
							paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_WAITING);
							paramStepInfo.setApprvScheduleUserId((String)stepInfo.get("userId"));
							hiddenUserIdReview = (String)stepInfo.get("userId");
						}

					} else if (paramStepInfo.getStepLevel().equals("3")) {
						paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_WAITING);
						paramStepInfo.setApprvScheduleUserId((String)stepInfo.get("userId"));

					} else if (paramStepInfo.getStepLevel().equals("4")) {
						paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_WAITING);
						paramStepInfo.setApprvScheduleUserId((String)stepInfo.get("userId"));

					} else {
						paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_WAITING);
					}
					reqCatalogueService.setSrApprovalStepinsert2(paramStepInfo);

					if (tmpStep < 3) {
						tmpStep++;
					}
				}
				CustomReqProductVO reqProductVo = reqProductService.orderUserInfo(ordervo.getOrderNo());
				Map<String, String> keywordMap = new HashMap<>();
				keywordMap.put("[[신청자명]]", reqProductVo.getUserName());
				keywordMap.put("[[서버명]]", orderSummary);
				keywordMap.put("[[URL]]",
						"http://k-cloud.kepco.co.kr/mbr/req/catalogue/bssOrderApproveView?orderNo=" + ordervo.getOrderNo());

				keywordMap.put("[[LURL]]", "http://k-cloud.kepco.co.kr/mbr");

				// 신청자에게 알림
				alarmsTemplateService.alarms(30, ordervo.getOrderUserId(), keywordMap);
				// 결재자에게 요청
				alarmsTemplateService.alarms(33, currentUserIdReview, keywordMap);
				// 한전 연계 시스템 전송
				Map<String, String> alarmkepcoMap = new HashMap<>();
				alarmkepcoMap.put("gbn", "30");
				alarmkepcoMap.put("requestSeq", ordervo.getOrderNo());
				alarmkepcoMap.put("regUserId", ordervo.getOrderUserId()); // 자원 신청자
				alarmkepcoMap.put("apprvNextUserId", currentUserIdReview); // 다음 결재자
				alarmkepcoMap.put("url",
						"http://k-cloud.kepco.co.kr/mbr/req/catalogue/bssOrderApproveView?orderNo=" + orderNo);
				alarmsTemplateService.alarmsKepco(alarmkepcoMap);
			}
			res = setOrder;
		}catch (Exception e) {
//			logger.error("catalogueApp Exception");
			e.printStackTrace();
		}

		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	// 개발 재배포 함수
	@RequestMapping(value = "/reqDevRedeployment")
	public ResponseEntity<Object> reqRedeploymentDev(HttpServletRequest request, Model model, CustomReqOrderVO ordervo) {
		String res = "1";

		// 주문번호 생성
		String orderProductSeq = DateFormatUtils.format(new Date(), "yyyyMMddHHmmss");
		ordervo.setOrderUserId(request.getUserPrincipal().getName());
		model.addAttribute("ordervo", ordervo);

		String orderNo = orderProductSeq;

		ordervo.setOrderProductSeq(orderProductSeq);
		ordervo.setOrderNo(orderNo);
		ordervo.setProductCategory("PRODCATE_APP");
		ordervo.setHourlyFlag("N");
		ordervo.setPodCnt(ordervo.getAppCnt());
		ordervo.setRequestType("REQTYPE_NEW");

		// CICD 배포 신청 TYPE
		ordervo.setCicdRequestType(CodeUtil.CMM_CODE_CICD_REQTYPE_REDEPLOY);
		ordervo.setPodCnt(Integer.parseInt(request.getParameter("podCount"))); // POD 수

		String appVersion = request.getParameter("h_envApplicationVersion");
		if(!appVersion.equals("") && appVersion != null) {
			appVersion = "v"+(Integer.parseInt(appVersion.replaceAll("[^0-9]", ""))+1);
		}
		ordervo.setAppVersion(appVersion);
		log.info("Appversion {}", ordervo.getAppVersion());

		// Application 상세 정보
		ordervo.setCicdProjectId(request.getParameter("h_cicdProjectId"));
		ordervo.setFlavorId(request.getParameter("appFlavorId"));
		ordervo.setEnvName(request.getParameter("h_envName"));
		//		String orderSummary = "";
		String setOrder = reqCatalogueService.setOrder(ordervo);
		//		String projectId = reqCatalogueService.detailProjectId(ordervo);
		// 개발환경 ID 가져오기
		//		ordervo.setProjectId(projectId);
		String gitRepo = request.getParameter("gitRepository");
		ordervo.setGitRepository(gitRepo.substring(0, gitRepo.indexOf(".git")))  ;

		// 주문정보 저장
		reqCatalogueService.setOrderProduct(ordervo);
		reqCatalogueService.setOrderProductApp(ordervo);

		UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		model.addAttribute("apprvPass", userSession.getApprvPass());

		String tmpApprovalStepList = request.getParameter("approvalStepListString");
		ordervo.setApprovalStepList(tmpApprovalStepList);

		// 결재라인 complete 상태값으로 저장
		List<CustomReqCustomerVO> getApprovalModelSteplist = reqCatalogueService.getApprovalModelSteplist2();
		for (CustomReqCustomerVO customerVO : getApprovalModelSteplist) {
			CustomReqCustomerVO paramStepInfo = new CustomReqCustomerVO();
			paramStepInfo.setRequestSeq(ordervo.getOrderNo());
			paramStepInfo.setStepId(customerVO.getStepId());
			paramStepInfo.setModelId(customerVO.getModelId());
			paramStepInfo.setStepName(customerVO.getStepName());
			paramStepInfo.setStepLevel(customerVO.getStepLevel());
			paramStepInfo.setLeftStepId(customerVO.getLeftStepId());
			paramStepInfo.setRightStepId(customerVO.getRightStepId());
			paramStepInfo.setApprvUserId(userSession.getUsername());
			paramStepInfo.setApprvUserName(userSession.getNickname());
			paramStepInfo.setApprvScheduleUserId(userSession.getUsername());
			paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_COMPLETED);
			reqCatalogueService.setSrApprovalStepinsert2(paramStepInfo);
		}
		// provisioning 저장
		CustomReqProductVO resEnv = new CustomReqProductVO();
		resEnv = reqProductDAO.detailBssOrderProductApp(orderProductSeq);

		resEnv.setOrderUserId(userSession.getUsername());
		resEnv.setProvisioningSeq(DateFormatUtils.format(new Date(), "yyyyMMdd") + UUID.randomUUID());
		resEnv.setProvisioningStatus(CodeUtil.CMM_CODE_PROVISIONING_READY);
		resEnv.setRequestType("REQTYPE_DEV");
		resEnv.setOrderProductSeq(orderProductSeq);
		resEnv.setProductCategory(CodeUtil.CMM_CODE_PRODCATE_ENV);
		CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo(resEnv.getCloudId());
		resEnv.setCloudType(cloudVo.getCloudType());
		reqProductDAO.insertProvisioningQueue(resEnv);

		res = setOrder;
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	// 개발배포 함수
	@RequestMapping(value = "/catalogueEnvExport", params = "type=noworder")
	public ResponseEntity<Object> catalogueEnvExport(HttpServletRequest request, Model model, CustomReqOrderVO ordervo) {
		String res = "1";

		String orderProductSeq = DateFormatUtils.format(new Date(), "yyyyMMddHHmmss");
		ordervo.setOrderUserId(request.getUserPrincipal().getName());
		model.addAttribute("ordervo", ordervo);

		String orderNo = orderProductSeq;

		ordervo.setOrderProductSeq(orderProductSeq);
		ordervo.setOrderNo(orderNo);
		ordervo.setProductCategory("PRODCATE_APP");
		ordervo.setHourlyFlag("N");
		ordervo.setPodCnt(ordervo.getAppCnt());

		ordervo.setRequestType("REQTYPE_NEW");

		ordervo.setPodCnt(Integer.parseInt(request.getParameter("podCount"))); // POD 수
		ordervo.setVolume(Integer.parseInt(request.getParameter("pvcVolume"))); // PVC volume

		ordervo.setOsProductSeq(request.getParameter("osProductSeq"));
		ordervo.setImageId(request.getParameter("imageId")); // Template 명
		ordervo.setPvcYn(request.getParameter("onPvcFlagNm")); // PV 사용여부
		ordervo.setDescription(request.getParameter("etcNm")); // 기타사항
		ordervo.setEnvAlias(request.getParameter("envName"));
		ordervo.setCicdProjectId(request.getParameter("cicdProjectId"));
		ordervo.setGitRepository(request.getParameter("gitRepository"));
		ordervo.setExportType(request.getParameter("exportType"));
		ordervo.setDomainUrl(request.getParameter("domainUrl") +"."+ request.getParameter("domain")); // 도메인 주소

//		String orderSummary = "";

		String setOrder = reqCatalogueService.setOrder(ordervo);
		String projectId = reqCatalogueService.detailProjectId(ordervo);
		ordervo.setProjectId(projectId);

		// CICD 배포 신청 TYPE
		ordervo.setCicdRequestType(CodeUtil.CMM_CODE_CICD_REQTYPE_NEW_DEPLOY);
//		ordervo.setEnvApplicationVersion("v1");
		ordervo.setAppVersion("v1");
		ordervo.setFlavorId(request.getParameter("appFlavorId"));
		ordervo.setGitReference("staging");

		// 주문정보 저장
		reqCatalogueService.setOrderProduct(ordervo);
		reqCatalogueService.setOrderProductApp(ordervo);

		UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		model.addAttribute("apprvPass", userSession.getApprvPass());


		String tmpApprovalStepList = request.getParameter("approvalStepListString");
		ordervo.setApprovalStepList(tmpApprovalStepList);

		// 결재라인 complete 상태값으로 저장
		List<CustomReqCustomerVO> getApprovalModelSteplist = reqCatalogueService.getApprovalModelSteplist2();
		for (CustomReqCustomerVO customerVO : getApprovalModelSteplist) {
			CustomReqCustomerVO paramStepInfo = new CustomReqCustomerVO();
			paramStepInfo.setRequestSeq(ordervo.getOrderNo());
			paramStepInfo.setStepId(customerVO.getStepId());
			paramStepInfo.setModelId(customerVO.getModelId());
			paramStepInfo.setStepName(customerVO.getStepName());
			paramStepInfo.setStepLevel(customerVO.getStepLevel());
			paramStepInfo.setLeftStepId(customerVO.getLeftStepId());
			paramStepInfo.setRightStepId(customerVO.getRightStepId());
			paramStepInfo.setApprvUserId(userSession.getUsername());
			paramStepInfo.setApprvUserName(userSession.getNickname());
			paramStepInfo.setApprvScheduleUserId(userSession.getUsername());
			paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_COMPLETED);
			reqCatalogueService.setSrApprovalStepinsert2(paramStepInfo);
		}

		// provisioning 저장
		CustomReqProductVO resEnv = new CustomReqProductVO();
		resEnv = reqProductDAO.detailBssOrderProductApp(orderProductSeq);
	    resEnv.setOrderUserId(userSession.getUsername());
	    resEnv.setProvisioningSeq(DateFormatUtils.format(new Date(), "yyyyMMdd") + UUID.randomUUID());
	    resEnv.setProvisioningStatus(CodeUtil.CMM_CODE_PROVISIONING_READY);
	    resEnv.setRequestType("REQTYPE_DEV");
	    resEnv.setOrderProductSeq(orderProductSeq);
	    resEnv.setProductCategory(CodeUtil.CMM_CODE_PRODCATE_ENV);
	    CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo(resEnv.getCloudId());
	    resEnv.setCloudType(cloudVo.getCloudType());
	    reqProductDAO.insertProvisioningQueue(resEnv);

		res = setOrder;
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	// 운영배포 함수
	@RequestMapping(value = "/cataloguePrd", params = "type=noworder")
	public ResponseEntity<Object> cataloguePrdExport(HttpServletRequest request, Model model, CustomReqOrderVO ordervo) {
		String res = "1";

		try {
			ordervo.setOrderUserId(request.getUserPrincipal().getName());
			model.addAttribute("ordervo", ordervo);

			String orderProductSeq = DateFormatUtils.format(new Date(), "yyyyMMddHHmmss");
			String orderNo = orderProductSeq;

			ordervo.setOrderProductSeq(orderProductSeq);
			ordervo.setOrderNo(orderNo);
			ordervo.setProductCategory("PRODCATE_APP");
			ordervo.setHourlyFlag("N");
			ordervo.setPodCnt(ordervo.getAppCnt());

			ordervo.setRequestType("REQTYPE_NEW");

			ordervo.setPodCnt(Integer.parseInt(request.getParameter("podCount"))); // POD 수
			ordervo.setVolume(Integer.parseInt(request.getParameter("pvcVolume"))); // PVC volume

			ordervo.setOsProductSeq(request.getParameter("osProductSeq"));
			ordervo.setImageId(request.getParameter("imageId"));
			ordervo.setPvcYn(request.getParameter("onPvcFlagNm")); 	 // PV 사용여부
			ordervo.setDescription(request.getParameter("etcNm")); 		 // 기타사항
			ordervo.setAppAlias(request.getParameter("appName")); 		 // 컨테이너 alias
			ordervo.setDomainUrl(request.getParameter("domainUrl")+"."+request.getParameter("domain"));  // 도메인 주소
			ordervo.setAppVersion(request.getParameter("h_envApplicationVersion"));  // 도메인 주소

			ordervo.setEnvAlias(request.getParameter("envName"));
			ordervo.setCicdProjectId(request.getParameter("cicdProjectId"));

			String gitRepo = request.getParameter("gitRepository");
			ordervo.setGitRepository(gitRepo.substring(0, gitRepo.indexOf(".git")));
//			ordervo.setGitRepository(request.getParameter("gitRepository"));
			ordervo.setExportType(request.getParameter("exportType"));

			String tmpApprovalStepList = request.getParameter("approvalStepListString");
			ordervo.setApprovalStepList(tmpApprovalStepList);

			String orderSummary = "";

			String setOrder = reqCatalogueService.setOrder(ordervo);
//			String projectId = reqCatalogueService.detailProjectId(ordervo);
//			ordervo.setProjectId(projectId);

			// CICD 배포 신청 TYPE
			ordervo.setCicdRequestType(CodeUtil.CMM_CODE_CICD_REQTYPE_NEW_DEPLOY);
//			ordervo.setEnvApplicationVersion("v1");
//			ordervo.setAppVersion("v1");
			ordervo.setFlavorId(request.getParameter("appFlavorId"));
			ordervo.setGitReference("production");

			// 주문정보 저장
			reqCatalogueService.setOrderProduct(ordervo);
			reqCatalogueService.setOrderProductApp(ordervo);

			// 1차 승인 예정자
			String currentUserIdReview = "";
			String hiddenUserIdReview = request.getParameter("hiddenUserIdReview");
			// 2차 승인 예정자
			String hiddenUserIdApprove = request.getParameter("hiddenUserIdApprove");
			// 2020.05.25(장중일) - 신규 결재라인 등록 부분
			// 지정된 결재자 정보
			List<Map<String, Object>> stepList = ordervo.getApprovalStepList();
			// 결재라인 정보
			List<CustomReqCustomerVO> getApprovalModelSteplist = reqCatalogueService.getApprovalModelSteplist2();

			int tmpStep = 0;
			boolean tmpStartFlag = false;
			if (ordervo.getSelectApprv().equals("Y") && ordervo.getApprvPass().equals("Y")) {
				for (CustomReqCustomerVO customerVO : getApprovalModelSteplist) {
					UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication()
							.getPrincipal();
					CustomReqCustomerVO paramStepInfo = new CustomReqCustomerVO();
					paramStepInfo.setRequestSeq(ordervo.getOrderNo());
					paramStepInfo.setStepId(customerVO.getStepId());
					paramStepInfo.setModelId(customerVO.getModelId());
					paramStepInfo.setStepName(customerVO.getStepName());
					paramStepInfo.setStepLevel(customerVO.getStepLevel());
					paramStepInfo.setLeftStepId(customerVO.getLeftStepId());
					paramStepInfo.setRightStepId(customerVO.getRightStepId());

					if (tmpStep < 5) {
						paramStepInfo.setApprvUserId(userSession.getUsername());
						paramStepInfo.setApprvUserName(userSession.getNickname());
						paramStepInfo.setApprvScheduleUserId(userSession.getUsername());
						paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_COMPLETED);
					} else {
						if (tmpStep == 5) {
							paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_UNASSIGNED);
						} else {
							paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_WAITING);
						}
					}
					tmpStep++;
					reqCatalogueService.setSrApprovalStepinsert2(paramStepInfo);

					if (tmpStep < 3) {
						tmpStep++;
					}
				}
			} else {
				for (CustomReqCustomerVO customerVO : getApprovalModelSteplist) {
					HashMap<String, Object> stepInfo = (HashMap<String, Object>) stepList.get(tmpStep);

					CustomReqCustomerVO paramStepInfo = new CustomReqCustomerVO();
					paramStepInfo.setRequestSeq(ordervo.getOrderNo());
					paramStepInfo.setStepId(customerVO.getStepId());
					paramStepInfo.setModelId(customerVO.getModelId());
					paramStepInfo.setStepName(customerVO.getStepName());
					paramStepInfo.setStepLevel(customerVO.getStepLevel());
					paramStepInfo.setLeftStepId(customerVO.getLeftStepId());
					paramStepInfo.setRightStepId(customerVO.getRightStepId());

					if (paramStepInfo.getStepLevel().equals("1")) {
						if (stepInfo.get("userId").equals("") || stepInfo.get("userId") == null) {
							tmpStartFlag = true;
							paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_COMPLETED);
						} else {
							paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_PROCESSING);
							paramStepInfo.setApprvScheduleUserId((String)stepInfo.get("userId"));
							hiddenUserIdReview = (String)stepInfo.get("userId");
							currentUserIdReview = (String)stepInfo.get("userId");
						}

					} else if (paramStepInfo.getStepLevel().equals("2")) {
						if (tmpStartFlag) {
							paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_PROCESSING);
							paramStepInfo.setApprvScheduleUserId((String)stepInfo.get("userId"));
						} else {
							paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_WAITING);
							paramStepInfo.setApprvScheduleUserId((String)stepInfo.get("userId"));
							hiddenUserIdReview = (String)stepInfo.get("userId");
						}

					} else if (paramStepInfo.getStepLevel().equals("3")) {
						paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_WAITING);
						paramStepInfo.setApprvScheduleUserId((String)stepInfo.get("userId"));

					} else if (paramStepInfo.getStepLevel().equals("4")) {
						paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_WAITING);
						paramStepInfo.setApprvScheduleUserId((String)stepInfo.get("userId"));

					} else {
						paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_WAITING);
					}
					reqCatalogueService.setSrApprovalStepinsert2(paramStepInfo);

					if (tmpStep < 3) {
						tmpStep++;
					}
				}
				CustomReqProductVO reqProductVo = reqProductService.orderUserInfo(ordervo.getOrderNo());
				Map<String, String> keywordMap = new HashMap<>();
				keywordMap.put("[[신청자명]]", reqProductVo.getUserName());
				keywordMap.put("[[서버명]]", orderSummary);
				keywordMap.put("[[URL]]",
						"http://k-cloud.kepco.co.kr/mbr/req/catalogue/bssOrderApproveView?orderNo=" + ordervo.getOrderNo());

				keywordMap.put("[[LURL]]", "http://k-cloud.kepco.co.kr/mbr");

				// 신청자에게 알림
				alarmsTemplateService.alarms(30, ordervo.getOrderUserId(), keywordMap);
				// 결재자에게 요청
				alarmsTemplateService.alarms(33, currentUserIdReview, keywordMap);
				// 한전 연계 시스템 전송
				Map<String, String> alarmkepcoMap = new HashMap<>();
				alarmkepcoMap.put("gbn", "30");
				alarmkepcoMap.put("requestSeq", ordervo.getOrderNo());
				alarmkepcoMap.put("regUserId", ordervo.getOrderUserId()); // 자원 신청자
				alarmkepcoMap.put("apprvNextUserId", currentUserIdReview); // 다음 결재자
				alarmkepcoMap.put("url",
						"http://k-cloud.kepco.co.kr/mbr/req/catalogue/bssOrderApproveView?orderNo=" + orderNo);
				alarmsTemplateService.alarmsKepco(alarmkepcoMap);
			}

			res = setOrder;
		}catch (Exception e) {
	        logger.error("catalogueApp Exception");
		}

		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	// 운영 재배포 함수
	@RequestMapping(value = "/reqProdRedeployment")
	public ResponseEntity<Object> reqProdRedeployment(HttpServletRequest request, Model model, CustomReqOrderVO ordervo) {
		String res = "1";

		try {
			ordervo.setOrderUserId(request.getUserPrincipal().getName());
			model.addAttribute("ordervo", ordervo);

			String orderProductSeq = DateFormatUtils.format(new Date(), "yyyyMMddHHmmss");
			String orderNo = orderProductSeq;

			ordervo.setOrderProductSeq(orderProductSeq);
			ordervo.setOrderNo(orderNo);
			ordervo.setProductCategory("PRODCATE_APP");
			ordervo.setHourlyFlag("N");
			ordervo.setPodCnt(ordervo.getAppCnt());
			ordervo.setRequestType("REQTYPE_NEW");

			// CICD 배포 신청 TYPE
			ordervo.setCicdRequestType(CodeUtil.CMM_CODE_CICD_REQTYPE_REDEPLOY);

			String appVersion = request.getParameter("h_envApplicationVersion");
//			if(!appVersion.equals("") && appVersion != null) {
//				appVersion = "v"+(Integer.parseInt(appVersion.replaceAll("[^0-9]", ""))+1);
//			}
			ordervo.setAppVersion(appVersion);
			log.info("Appversion {}", ordervo.getAppVersion());

			// Application 상세 정보
			ordervo.setCicdProjectId(request.getParameter("h_cicdProjectId"));
			ordervo.setFlavorId(request.getParameter("appFlavorId"));

			log.info("Flavor ID : {}", ordervo.getFlavorId());
			log.info("Cicd Project ID : {}", ordervo.getCicdProjectId());
			log.info("Env Nama ID : {}", ordervo.getEnvName());

			// 입력 POD 개수, 어플리케이션 명, 도메인 주소, 컨테이너 사양
			ordervo.setPodCnt(Integer.parseInt(request.getParameter("podCount"))); // POD 수

			String gitRepo = request.getParameter("gitRepository");
			ordervo.setGitRepository(gitRepo.substring(0, gitRepo.indexOf(".git")));

//			ordervo.setVolume(Integer.parseInt(request.getParameter("pvcVolume"))); // PVC volume

//			ordervo.setOsProductSeq(request.getParameter("osProductSeq"));
//			ordervo.setImageId(request.getParameter("imageId"));
//			ordervo.setPvcYn(request.getParameter("onPvcFlagNm")); // PV 사용여부
//			ordervo.setDescription(request.getParameter("etcNm")); // 기타사항
//			ordervo.setAppAlias(request.getParameter("appName")); // 컨테이너 alias
//			ordervo.setDomainUrl(request.getParameter("domainUrl")); // 도메인 주소

			String orderSummary = "";

			String setOrder = reqCatalogueService.setOrder(ordervo);
//			String projectId = reqCatalogueService.detailProjectId(ordervo);
//			ordervo.setProjectId(projectId);

			// 주문정보 저장
			reqCatalogueService.setOrderProduct(ordervo);
			reqCatalogueService.setOrderProductApp(ordervo);

			String tmpApprovalStepList = request.getParameter("approvalStepListString");
			ordervo.setApprovalStepList(tmpApprovalStepList);

			// 1차 승인 예정자
			String currentUserIdReview = "";
			String hiddenUserIdReview = request.getParameter("hiddenUserIdReview");
			// 2차 승인 예정자
			String hiddenUserIdApprove = request.getParameter("hiddenUserIdApprove");
			// 2020.05.25(장중일) - 신규 결재라인 등록 부분
			// 지정된 결재자 정보
			List<Map<String, Object>> stepList = ordervo.getApprovalStepList();
			// 결재라인 정보
			List<CustomReqCustomerVO> getApprovalModelSteplist = reqCatalogueService.getApprovalModelSteplist2();

			int tmpStep = 0;
			boolean tmpStartFlag = false;
			if (ordervo.getSelectApprv().equals("Y") && ordervo.getApprvPass().equals("Y")) {
				for (CustomReqCustomerVO customerVO : getApprovalModelSteplist) {
					UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication()
							.getPrincipal();
					CustomReqCustomerVO paramStepInfo = new CustomReqCustomerVO();
					paramStepInfo.setRequestSeq(ordervo.getOrderNo());
					paramStepInfo.setStepId(customerVO.getStepId());
					paramStepInfo.setModelId(customerVO.getModelId());
					paramStepInfo.setStepName(customerVO.getStepName());
					paramStepInfo.setStepLevel(customerVO.getStepLevel());
					paramStepInfo.setLeftStepId(customerVO.getLeftStepId());
					paramStepInfo.setRightStepId(customerVO.getRightStepId());

					if (tmpStep < 5) {
						paramStepInfo.setApprvUserId(userSession.getUsername());
						paramStepInfo.setApprvUserName(userSession.getNickname());
						paramStepInfo.setApprvScheduleUserId(userSession.getUsername());
						paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_COMPLETED);
					} else {
						if (tmpStep == 5) {
							paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_UNASSIGNED);
						} else {
							paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_WAITING);
						}
					}
					tmpStep++;
					reqCatalogueService.setSrApprovalStepinsert2(paramStepInfo);

					if (tmpStep < 3) {
						tmpStep++;
					}
				}
			} else {
				for (CustomReqCustomerVO customerVO : getApprovalModelSteplist) {
					HashMap<String, Object> stepInfo = (HashMap<String, Object>) stepList.get(tmpStep);

					CustomReqCustomerVO paramStepInfo = new CustomReqCustomerVO();
					paramStepInfo.setRequestSeq(ordervo.getOrderNo());
					paramStepInfo.setStepId(customerVO.getStepId());
					paramStepInfo.setModelId(customerVO.getModelId());
					paramStepInfo.setStepName(customerVO.getStepName());
					paramStepInfo.setStepLevel(customerVO.getStepLevel());
					paramStepInfo.setLeftStepId(customerVO.getLeftStepId());
					paramStepInfo.setRightStepId(customerVO.getRightStepId());

					if (paramStepInfo.getStepLevel().equals("1")) {
						if (stepInfo.get("userId").equals("") || stepInfo.get("userId") == null) {
							tmpStartFlag = true;
							paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_COMPLETED);
						} else {
							paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_PROCESSING);
							paramStepInfo.setApprvScheduleUserId((String)stepInfo.get("userId"));
							hiddenUserIdReview = (String)stepInfo.get("userId");
							currentUserIdReview = (String)stepInfo.get("userId");
						}

					} else if (paramStepInfo.getStepLevel().equals("2")) {
						if (tmpStartFlag) {
							paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_PROCESSING);
							paramStepInfo.setApprvScheduleUserId((String)stepInfo.get("userId"));
						} else {
							paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_WAITING);
							paramStepInfo.setApprvScheduleUserId((String)stepInfo.get("userId"));
							hiddenUserIdReview = (String)stepInfo.get("userId");
						}

					} else if (paramStepInfo.getStepLevel().equals("3")) {
						paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_WAITING);
						paramStepInfo.setApprvScheduleUserId((String)stepInfo.get("userId"));

					} else if (paramStepInfo.getStepLevel().equals("4")) {
						paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_WAITING);
						paramStepInfo.setApprvScheduleUserId((String)stepInfo.get("userId"));

					} else {
						paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_WAITING);
					}
					reqCatalogueService.setSrApprovalStepinsert2(paramStepInfo);

					if (tmpStep < 3) {
						tmpStep++;
					}
				}
				CustomReqProductVO reqProductVo = reqProductService.orderUserInfo(ordervo.getOrderNo());
				Map<String, String> keywordMap = new HashMap<>();
				keywordMap.put("[[신청자명]]", reqProductVo.getUserName());
				keywordMap.put("[[서버명]]", orderSummary);
				keywordMap.put("[[URL]]",
						"http://k-cloud.kepco.co.kr/mbr/req/catalogue/bssOrderApproveView?orderNo=" + ordervo.getOrderNo());

				keywordMap.put("[[LURL]]", "http://k-cloud.kepco.co.kr/mbr");

				// 신청자에게 알림
				alarmsTemplateService.alarms(30, ordervo.getOrderUserId(), keywordMap);
				// 결재자에게 요청
				alarmsTemplateService.alarms(33, currentUserIdReview, keywordMap);
				// 한전 연계 시스템 전송
				Map<String, String> alarmkepcoMap = new HashMap<>();
				alarmkepcoMap.put("gbn", "30");
				alarmkepcoMap.put("requestSeq", ordervo.getOrderNo());
				alarmkepcoMap.put("regUserId", ordervo.getOrderUserId()); // 자원 신청자
				alarmkepcoMap.put("apprvNextUserId", currentUserIdReview); // 다음 결재자
				alarmkepcoMap.put("url",
						"http://k-cloud.kepco.co.kr/mbr/req/catalogue/bssOrderApproveView?orderNo=" + orderNo);
				alarmsTemplateService.alarmsKepco(alarmkepcoMap);
			}

			res = setOrder;
		}catch (Exception e) {
			logger.error("catalogueApp Exception");
		}

		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}


	@RequestMapping(value = "/getProjectAppInfo", method = { RequestMethod.GET, RequestMethod.POST })
	public ResponseEntity<Object> getProjectAppInfo(CustomOssAppVO req, Model model) {


		CustomOssAppVO customOssAppVO = new CustomOssAppVO();
		customOssAppVO.setAppUid(req.getAppUid());

		CustomOssAppVO res = ossAppService.ossAppByAppUid(customOssAppVO);
		CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo(req.getCloudId());
	    DeploymentConfig getDeploymentConfig = opsApiOptionService.getDeploymentConfig(cloudVo, res.getAppNameSpace(), res.getAppName());

		List<Entry<String, String>> list_entries = new ArrayList<Entry<String, String>>(getDeploymentConfig.getMetadata().getLabels().entrySet());

		StringBuffer subnetAllocationPoolStr = new StringBuffer();
		int i = 0;
		for(Entry<String, String> entry : list_entries) {
			if(i > 0) {
				subnetAllocationPoolStr.append(",");
			}
		    if(entry.getValue().equals("")) {
				subnetAllocationPoolStr.append(entry.getKey().toString().replace("=", ""));
			}else {
				subnetAllocationPoolStr.append(entry.getKey() + "=" + entry.getValue());
			}
		  i++;
		}

		res.setLabel(subnetAllocationPoolStr.toString());

		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	@RequestMapping(value = "/getPodList", method = { RequestMethod.GET, RequestMethod.POST })
	public ResponseEntity<Object> getPodList(CustomOssProjectVO req) {
		CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo(req.getCloudId());

		CustomOssProjectVO ossProjectDetail = ossProjectservice.detail(req);

		PodList res = opsApiOptionService.getPodListByDeploymentconfigName(cloudVo, ossProjectDetail.getProjectName());
		HashMap<String, Object> map = new HashMap<>();
		map.put("podList", res);
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	@RequestMapping(value = "/getBuildList", method = { RequestMethod.GET, RequestMethod.POST })
	public ResponseEntity<Object> getBuildList(CustomOssProjectVO req) {
		CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo(req.getCloudId());

		CustomOssProjectVO ossProjectDetail = ossProjectservice.detail(req);

		BuildList res = opsApiOptionService.getBuildList(cloudVo, ossProjectDetail.getProjectName());
		HashMap<String, Object> map = new HashMap<>();
		map.put("buildList", res);
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	@RequestMapping(value = "/getServiceList", method = { RequestMethod.GET, RequestMethod.POST })
	public ResponseEntity<Object> getServiceList(CustomOssProjectVO req) {
		CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo(req.getCloudId());

		CustomOssProjectVO ossProjectDetail = ossProjectservice.detail(req);

		ServiceList res = opsApiOptionService.getServiceList(cloudVo, ossProjectDetail.getProjectName());
		HashMap<String, Object> map = new HashMap<>();
		map.put("serviceList", res);
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	@RequestMapping(value = "/getRouteList", method = { RequestMethod.GET, RequestMethod.POST })
	public ResponseEntity<Object> getRouteList(CustomOssProjectVO req) {
		CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo(req.getCloudId());

		CustomOssProjectVO ossProjectDetail = ossProjectservice.detail(req);

		RouteList res = opsApiOptionService.getRouteList(cloudVo, ossProjectDetail.getProjectName());
		HashMap<String, Object> map = new HashMap<>();
		map.put("routeList", res);
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	@RequestMapping(value = "/startBuild")
	public ResponseEntity<Object> startBuild(CustomOssProjectVO req) {

		String cloudId = req.getCloudId();
		CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo(cloudId);
		CustomOssProjectVO ossProjectDetail = ossProjectservice.detail(req);
		OpenShiftClient client = OpenShiftClientManager.getClient(cloudVo);
		BuildRequest buildRequest = new BuildRequest();
		ObjectMeta objMeta = new ObjectMeta();
		objMeta.setName(req.getBuildConfigName());
		buildRequest.setMetadata(objMeta);

		client.buildConfigs().inNamespace(ossProjectDetail.getProjectName().toLowerCase()).withName(req.getBuildConfigName()).instantiate(buildRequest);
		BuildList res = opsApiOptionService.getBuildList(cloudVo, ossProjectDetail.getProjectName().toLowerCase());

		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}
}
