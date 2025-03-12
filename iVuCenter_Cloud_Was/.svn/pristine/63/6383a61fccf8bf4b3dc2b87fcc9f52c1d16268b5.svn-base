package com.ivucenter.cloud.portal.application.req;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.time.DateFormatUtils;
import org.codehaus.jettison.json.JSONException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

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
import com.ivucenter.cloud.portal.oss.project.OssProjectService;
import com.ivucenter.cloud.portal.req.catalogue.CustomReqCatalogueVO;
import com.ivucenter.cloud.portal.req.catalogue.ReqCatalogueService;
import com.ivucenter.cloud.portal.req.product.CustomReqProductVO;
import com.ivucenter.cloud.portal.req.product.ReqProductDAO;
import com.ivucenter.cloud.portal.req.product.ReqProductService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value = "/mng/application/req")
public class mngReqAppController {

    private static final Logger logger = LoggerFactory.getLogger(mngReqAppController.class);

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



	// 배포현황(개발) 리스트 페이지
	@RequestMapping(value = "/reqDevDeployList")
	public String mbrReqDevDeployList(HttpServletRequest request, Model model) {

		return "mng/application/req/reqDevDeployList";
	}

	// 배포현황(개발) 리스트 페이지
	@RequestMapping(value = "/reqPrdDeployList")
	public String mbrReqPrdDeployList(HttpServletRequest request, Model model) {

		return "mng/application/req/reqPrdDeployList";
	}

	// 개발배포 페이지 이동함수
	@RequestMapping(value = "/catalogueDevExportDetail")
	public String mngDevExportDetail(HttpServletRequest request, Model model, CustomOssAppVO req) throws JSONException {
		// pipeline ID 조회
		CustomReqProductVO customReqProductVO = new CustomReqProductVO();
		String cicdProjectId = request.getParameter("cicdProjectId");
		String pipelineId = request.getParameter("pipelineId");
		String appName = request.getParameter("appName");
		customReqProductVO.setCicdProjectId(cicdProjectId);
		customReqProductVO.setPipelineId(pipelineId);
		customReqProductVO.setAppName(appName);
		CustomReqProductVO devPipeLine = ossAppService.getDevPipeLineDetail(customReqProductVO);
		model.addAttribute("devPipeLine", devPipeLine);
		System.out.println(devPipeLine.getEnvApplicationVersion());
//		CustomOssAppVO res = ossAppService.ossAppByAppUid(customOssAppVO);

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

		return "mng/application/req/catalogueDevExportDetail";
	}

	// 운영배포 페이지 이동함수
		@RequestMapping(value = "/cataloguePrdExport")
		@Secured({ "ROLE_CUSTOM_ADMIN", "ROLE_CUSTOM_USER" })
		public String mngPrdExportList(HttpServletRequest request, Model model, CustomOssAppVO req) throws JSONException {
			// pipeline ID 조회
			CustomReqProductVO customReqProductVO = new CustomReqProductVO();
			String cicdProjectId = request.getParameter("cicdProjectId");
			customReqProductVO.setCicdProjectId(cicdProjectId);
			String pipelineId = request.getParameter("pipelineId");
			customReqProductVO.setPipelineId(pipelineId);
//			String appUid = request.getParameter("appUid");
			CustomReqProductVO prdPipeLine = ossAppService.getPrdPipeLineDetail(customReqProductVO);
			model.addAttribute("prdPipeLine", prdPipeLine);
			log.info("appVersion {}", prdPipeLine.getEnvApplicationVersion());
//			CustomOssAppVO res = ossAppService.ossAppByAppUid(customOssAppVO);

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

			return "mng/application/req/cataloguePrdExport";
		}

		@RequestMapping(value = "/cataloguePrdExportDetail")
		@Secured({ "ROLE_CUSTOM_ADMIN", "ROLE_CUSTOM_USER" })
		public String mngPrdExportDetail(HttpServletRequest request, Model model, CustomOssAppVO req) throws JSONException {

			// pipeline ID 조회
			CustomReqProductVO customReqProductVO = new CustomReqProductVO();
			String cicdProjectId = request.getParameter("cicdProjectId");
			String pipelineId = request.getParameter("pipelineId");
			String orderProductSeq = request.getParameter("orderProductSeq");
			String appName = request.getParameter("appName");

//			String appUid = request.getParameter("appUid");
			customReqProductVO.setCicdProjectId(cicdProjectId);
			customReqProductVO.setPipelineId(pipelineId);
			customReqProductVO.setOrderProductSeq(orderProductSeq);
			customReqProductVO.setAppName(appName);

			CustomReqProductVO prdPipeLine = ossAppService.getPrdPipeLineDetail(customReqProductVO);
			model.addAttribute("prdPipeLine", prdPipeLine);
			log.info("prd Export Detail >>  {}",prdPipeLine.getFlavorId());
			log.info("appVersion {}",prdPipeLine.getEnvApplicationVersion());
//			CustomOssAppVO res = ossAppService.ossAppByAppUid(customOssAppVO);

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

			return "mng/application/req/cataloguePrdExportDetail";
		}

}
