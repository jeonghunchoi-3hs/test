package com.ivucenter.cloud.portal.req.catalogue;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.time.DateFormatUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.view.RedirectView;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;
import com.ivucenter.cloud.api.openshift.object.OpsApiOptionService;
import com.ivucenter.cloud.api.openshift.object.OpsApiOptionVO;
import com.ivucenter.cloud.entity.OssFlavorVO;
import com.ivucenter.cloud.portal.alarms.template.AlarmsTemplateService;
import com.ivucenter.cloud.portal.bbs.notice.BbsNoticeService;
import com.ivucenter.cloud.portal.bbs.notice.CustomBbsNoticeVO;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;
import com.ivucenter.cloud.portal.cmm.cloud.OssCloudService;
import com.ivucenter.cloud.portal.cmm.code.CmmCodeService;
import com.ivucenter.cloud.portal.cmm.code.CustomCmmCodeVO;
import com.ivucenter.cloud.portal.cmm.file.CmmFileService;
import com.ivucenter.cloud.portal.cmm.file.CustomCmmFileVO;
import com.ivucenter.cloud.portal.cmm.user.CmmUserService;
import com.ivucenter.cloud.portal.cmm.user.CustomCmmUserVO;
import com.ivucenter.cloud.portal.login.UserSession;
import com.ivucenter.cloud.portal.mng.req.work.CustomMngOssVo;
import com.ivucenter.cloud.portal.oss.scaleOut.CustomScaleOutVO;
import com.ivucenter.cloud.portal.oss.scaleOut.ScaleOutService;
import com.ivucenter.cloud.portal.oss.zone.OssZoneNetworkDiskService;
import com.ivucenter.cloud.portal.oss.zone.OssZoneNetworkDiskVO;
import com.ivucenter.cloud.portal.req.customer.CustomReqCustomerVO;
import com.ivucenter.cloud.portal.req.customer.ReqCustomerService;
import com.ivucenter.cloud.portal.req.product.CustomReqProductVO;
import com.ivucenter.cloud.portal.req.product.ReqProductService;
import com.ivucenter.cloud.portal.req.project.CustomReqProjectVO;
import com.ivucenter.cloud.portal.req.project.ReqProjectService;
import com.ivucenter.cloud.portal.util.CodeUtil;
import com.ivucenter.cloud.portal.util.DateUtils;

import io.fabric8.openshift.api.model.DeploymentConfig;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value = "/mbr/req/catalogue")
public class MbrReqCatalogueController {

	@Autowired
	private ScaleOutService service;

	@Autowired
	private ReqProjectService reqProjectService;

	@Autowired
	private ReqCatalogueService reqCatalogueService;

	@Autowired
	private ReqCustomerService customerService;

	@Autowired
	private CmmCodeService cmmCodeService;

	@Autowired
	private AlarmsTemplateService alarmsTemplateService;

	@Autowired
	private ReqProductService reqProductService;

	@Autowired
	private BbsNoticeService bbsNoticeservice;

	@Autowired
	private CmmUserService cmmUserService;

	@Autowired
	private OssCloudService ossCloudService;

	@Autowired
	private OssZoneNetworkDiskService ossZoneNetworkDiskservice;

	@Autowired
	OssZoneNetworkDiskService OssZoneNetworkDiskService;

	@Autowired
	private CmmFileService cmmFileService;

	@Autowired
	private OpsApiOptionService opsApiOptionService;


	@Autowired
	private OssCloudService cloudService;




	// @Autowired
//	private OssZoneNetworkDiskService reqOssZoneNetworkDiskService;

	@RequestMapping(value = "/")
	@Secured({ "ROLE_CUSTOM_ADMIN", "ROLE_CUSTOM_USER" })
	public String catalogue() {
		return "mbr/req/catalogue/catalogueList";
	}

	// 카테고리 추천상품 리스트
	@RequestMapping(value = "/catalogueList.do", params = "!type")
	@Secured({ "ROLE_CUSTOM_USER" })
	public String catalogueList(Model model) {

		CustomReqCatalogueVO projectvo = new CustomReqCatalogueVO();
		projectvo.setApplyDate(DateFormatUtils.format(new Date(), "yyyy-MM-dd"));

		List<CustomReqCatalogueVO> getCatalogueList = reqCatalogueService.getCatalogueList(projectvo);
		model.addAttribute("getCatalogueList", getCatalogueList);

		List<CustomReqCatalogueVO> getCatalogueServiceList = reqCatalogueService.getCatalogueServiceList(projectvo);
		model.addAttribute("getCatalogueServiceList", getCatalogueServiceList);

		return "mbr/req/catalogue/catalogueListNew";
	}

	// 카테고리 서비스 리스트
	@RequestMapping(value = "/catalogueServiceList.do", params = "!type")
	@Secured({ "ROLE_CUSTOM_USER" })
	public String catalogueServiceList(Model model) {

		return "mbr/req/catalogue/catalogueServiceListNew";
	}

	@RequestMapping(value = "/serviceList")
	public ResponseEntity<Object> getServiceList(HttpServletRequest req) {

		CustomReqCatalogueVO customCatalogVO = new CustomReqCatalogueVO();
		customCatalogVO.setApplyDate(DateFormatUtils.format(new Date(), "yyyy-MM-dd"));
		// 모든상품 보여주기 && Display Falg = N
		customCatalogVO.setEnableRecommandFlag("N");
		// 기본상품(VM) Category에 해당하는것
		customCatalogVO.setConditionCategory(Arrays.asList("CATACATE_BACKUP", "CATACATE_SECURITY", "CATACATE_MCA"));
		List<CustomReqCatalogueVO> getCatalogueServiceList = reqCatalogueService
				.getCatalogueServiceList(customCatalogVO);

		return new ResponseEntity<Object>(getCatalogueServiceList, HttpStatus.OK);
	}

	// 카테고리 상품 가상서버 선택시 페이지 이동
	@RequestMapping(value = "/catalogueOrder.do", params = "!type")
	@Secured({ "ROLE_CUSTOM_ADMIN", "ROLE_CUSTOM_USER" })
	public String catalogueOrder(HttpServletRequest request, Model model) {
		UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		model.addAttribute("apprvPass", userSession.getApprvPass());
		String productSeq = request.getParameter("productSeq");
//		String imageType = request.getParameter("imageType");
		String hourlyFlag = request.getParameter("hourlyFlag");
		Assert.notNull(productSeq, "");

		String vmType = request.getParameter("instanceType");
		model.addAttribute("instanceType" , vmType);

		CustomCmmUserVO cmmUserInfo = new CustomCmmUserVO();
		cmmUserInfo.setUserId(request.getUserPrincipal().getName());
		cmmUserInfo = cmmUserService.userInfoDetail(cmmUserInfo);
		model.addAttribute("userLevelCode", cmmUserInfo.getUserLevelCode());

		CustomReqCatalogueVO projectvo = new CustomReqCatalogueVO();
		projectvo.setApplyDate(DateFormatUtils.format(new Date(), "yyyy-MM-dd"));
		projectvo.setProductSeq(productSeq);

		CustomReqCatalogueVO getCatalogueSelectView = reqCatalogueService.getCatalogueSelectView(projectvo);
		getCatalogueSelectView.setHourlyFlag(hourlyFlag);
		projectvo.setVmImageType(getCatalogueSelectView.getVmImageType());
		model.addAttribute("getCatalogueSelectView", getCatalogueSelectView);

		CustomReqCatalogueVO getCatalogueItempric = reqCatalogueService.getCatalogueItempric(projectvo);
		model.addAttribute("getCatalogueItempric", getCatalogueItempric);

		OssZoneNetworkDiskVO req = new OssZoneNetworkDiskVO();
		req.setVmImageType(projectvo.getVmImageType());
		req.setCatalogSeq(getCatalogueSelectView.getCatalogSeq());

		List<String> parentCodeKeyList = new ArrayList<>();
        parentCodeKeyList.add("NAS_SAVE_TYPE");
        parentCodeKeyList.add("ENV_TYPE");

        List<CustomCmmCodeVO> cmmCode = cmmCodeService.getCmmCodeByList(parentCodeKeyList);
        model.addAttribute("cmmCode", cmmCode);

		//List<OssZoneNetworkDiskVO> res = ossZoneNetworkDiskservice.list(req);
		//model.addAttribute("getNetwork", res);

		// List<OssZoneNetworkDiskVO> getCatalogueZoneList =
		// reqOssZoneNetworkDiskService.list();
		// model.addAttribute("getCatalogueZoneList", getCatalogueZoneList);
		/*
		 * List<CustomCmmCodeVO> getSharedNetwork = service.getSharedNetwork();
		 * model.addAttribute("getSharedNetwork", getSharedNetwork);
		 */

		return "mbr/req/catalogue/catalogueOrderNew";
	}

	// 카테고리 상품 가상서버 선택시 페이지 이동
	@RequestMapping(value = "/catalogueOrderDriect.do", params = "!type")
	@Secured({ "ROLE_CUSTOM_ADMIN", "ROLE_CUSTOM_USER" })
	public String catalogueOrderDriect(HttpServletRequest request, Model model) {
		UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		model.addAttribute("apprvPass", userSession.getApprvPass());
		String productSeq = request.getParameter("productSeq");
		String hourlyFlag = request.getParameter("hourlyFlag");
		Assert.notNull(productSeq, "");

		CustomCmmUserVO cmmUserInfo = new CustomCmmUserVO();
		cmmUserInfo.setUserId(request.getUserPrincipal().getName());
		cmmUserInfo = cmmUserService.userInfoDetail(cmmUserInfo);
		model.addAttribute("userLevelCode", cmmUserInfo.getUserLevelCode());

		Date nowdate = new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		String applyDate = dateFormat.format(nowdate);
		CustomReqCatalogueVO projectvo = new CustomReqCatalogueVO();
		projectvo.setApplyDate(applyDate);
		projectvo.setProductSeq(productSeq);

		CustomReqCatalogueVO getCatalogueSelectView = reqCatalogueService.getCatalogueSelectView(projectvo);
		getCatalogueSelectView.setHourlyFlag(hourlyFlag);
		projectvo.setVmImageType(getCatalogueSelectView.getVmImageType());
		model.addAttribute("getCatalogueSelectView", getCatalogueSelectView);

		CustomReqCatalogueVO getCatalogueItempric = reqCatalogueService.getCatalogueItempric(projectvo);
		model.addAttribute("getCatalogueItempric", getCatalogueItempric);

		OssZoneNetworkDiskVO req = new OssZoneNetworkDiskVO();
		req.setVmImageType(projectvo.getVmImageType());
		req.setCatalogSeq(getCatalogueSelectView.getCatalogSeq());
		List<OssZoneNetworkDiskVO> res = ossZoneNetworkDiskservice.list(req);
		model.addAttribute("getNetwork", res);

		// List<OssZoneNetworkDiskVO> getCatalogueZoneList =
		// reqOssZoneNetworkDiskService.list();
		// model.addAttribute("getCatalogueZoneList", getCatalogueZoneList);
		/*
		 * List<CustomCmmCodeVO> getSharedNetwork = service.getSharedNetwork();
		 * model.addAttribute("getSharedNetwork", getSharedNetwork);
		 */

		return "mbr/req/catalogue/catalogueOrderDriect";
	}

	// 카테고리 상품 디스크 선택시 페이지 이동
	@RequestMapping(value = "/catalogueDiskOrder.do", params = "!type")
	@Secured({ "ROLE_CUSTOM_ADMIN", "ROLE_CUSTOM_USER" })
	public String catalogueDiskOrder(HttpServletRequest request, Model model) {
		UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		model.addAttribute("apprvPass", userSession.getApprvPass());
		String productSeq = request.getParameter("productSeq");
		String hourlyFlag = request.getParameter("hourlyFlag");
		Assert.notNull(productSeq, "");

		CustomCmmUserVO cmmUserInfo = new CustomCmmUserVO();
		cmmUserInfo.setUserId(request.getUserPrincipal().getName());
		cmmUserInfo = cmmUserService.userInfoDetail(cmmUserInfo);
		model.addAttribute("userLevelCode", cmmUserInfo.getUserLevelCode());

		CustomReqCatalogueVO projectvo = new CustomReqCatalogueVO();
		projectvo.setProductSeq(productSeq);
		projectvo.setApplyDate(DateFormatUtils.format(new Date(), "yyyy-MM-dd"));

		CustomReqCatalogueVO getCatalogueSelectView = reqCatalogueService.getCatalogueSelectView(projectvo);
		getCatalogueSelectView.setHourlyFlag(hourlyFlag);
		model.addAttribute("getCatalogueSelectView", getCatalogueSelectView);

		List<CustomOssCloudVO> cloudList = cloudService.getCloudList();
		model.addAttribute("cloudList", cloudList);

		/*
		 * 안쓰는 듯 CustomReqCatalogueVO getCatalogueItempric =
		 * reqCatalogueService.getCatalogueItempric(projectvo);
		 * model.addAttribute("getCatalogueItempric", getCatalogueItempric);
		 *
		 * List<CustomReqCatalogueVO> getCatalogueOslist =
		 * reqCatalogueService.getCatalogueOslist(projectvo);
		 * model.addAttribute("getCatalogueOslist", getCatalogueOslist);
		 *
		 * List<CustomCmmCodeVO> getSharedNetwork = service.getSharedNetwork();
		 * model.addAttribute("getSharedNetwork", getSharedNetwork);
		 */

		return "mbr/req/catalogue/catalogueDiskOrder";
	}

	// 카테고리 상품 IP 선택시 페이지 이동
	@RequestMapping(value = "/catalogueIpOrder.do", params = "!type")
	@Secured({ "ROLE_CUSTOM_ADMIN", "ROLE_CUSTOM_USER" })
	public String catalogueIpOrder(HttpServletRequest request, Model model) {

		String productSeq = request.getParameter("productSeq");
		String hourlyFlag = request.getParameter("hourlyFlag");
		Assert.notNull(productSeq, "");

		CustomReqCatalogueVO projectvo = new CustomReqCatalogueVO();
		projectvo.setProductSeq(productSeq);
		projectvo.setApplyDate(DateFormatUtils.format(new Date(), "yyyy-MM-dd"));

		CustomReqCatalogueVO getCatalogueSelectView = reqCatalogueService.getCatalogueSelectView(projectvo);
		getCatalogueSelectView.setHourlyFlag(hourlyFlag);
		model.addAttribute("getCatalogueSelectView", getCatalogueSelectView);

		CustomReqCatalogueVO getCatalogueItempric = reqCatalogueService.getCatalogueItempric(projectvo);
		model.addAttribute("getCatalogueItempric", getCatalogueItempric);

		List<CustomReqCatalogueVO> getCatalogueOslist = reqCatalogueService.getCatalogueOslist(projectvo);
		model.addAttribute("getCatalogueOslist", getCatalogueOslist);

		List<CustomCmmCodeVO> getSharedNetwork = cmmCodeService.getSharedNetwork();
		model.addAttribute("getSharedNetwork", getSharedNetwork);

		return "mbr/req/catalogue/catalogueIpOrder";
	}

	// Persistent Volume 신청페이지
	@RequestMapping(value = "/cataloguePvOrder.do", params = "!type")
	@Secured({ "ROLE_CUSTOM_ADMIN", "ROLE_CUSTOM_USER" })
	public String cataloguePvOrder(HttpServletRequest request, Model model) {
		UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		model.addAttribute("apprvPass", userSession.getApprvPass());
		String productSeq = request.getParameter("productSeq");
		String hourlyFlag = request.getParameter("hourlyFlag");
		Assert.notNull(productSeq, "");

		CustomCmmUserVO cmmUserInfo = new CustomCmmUserVO();
		cmmUserInfo.setUserId(request.getUserPrincipal().getName());
		cmmUserInfo = cmmUserService.userInfoDetail(cmmUserInfo);
		model.addAttribute("userLevelCode", cmmUserInfo.getUserLevelCode());

		CustomReqCatalogueVO projectvo = new CustomReqCatalogueVO();
		projectvo.setProductSeq(productSeq);
		projectvo.setApplyDate(DateFormatUtils.format(new Date(), "yyyy-MM-dd"));

		CustomReqCatalogueVO getCatalogueSelectView = reqCatalogueService.getCatalogueSelectView(projectvo);
		getCatalogueSelectView.setHourlyFlag(hourlyFlag);
		model.addAttribute("getCatalogueSelectView", getCatalogueSelectView);

		CustomReqCatalogueVO getCatalogueItempric = reqCatalogueService.getCatalogueItempric(projectvo);
		model.addAttribute("getCatalogueItempric", getCatalogueItempric);

		List<CustomReqCatalogueVO> getCatalogueOslist = reqCatalogueService.getCatalogueOslist(projectvo);
		model.addAttribute("getCatalogueOslist", getCatalogueOslist);

		List<CustomCmmCodeVO> getSharedNetwork = cmmCodeService.getSharedNetwork();
		model.addAttribute("getSharedNetwork", getSharedNetwork);

		List<CustomOssCloudVO> cloudList = cloudService.getCloudList();
		model.addAttribute("cloudList", cloudList);

        List<String> parentCodeKeyList = new ArrayList<>();
        parentCodeKeyList.add("NAS_SAVE_TYPE");
        parentCodeKeyList.add("ENV_TYPE");

        List<CustomCmmCodeVO> cmmCode = cmmCodeService.getCmmCodeByList(parentCodeKeyList);
        model.addAttribute("cmmCode", cmmCode);

		return "mbr/req/catalogue/cataloguePvOrder";
	}

	// File Storage 신청페이지
	@RequestMapping(value = "/catalogueFsOrder.do", params = "!type")
	@Secured({ "ROLE_CUSTOM_ADMIN", "ROLE_CUSTOM_USER" })
	public String catalogueFsOrder(HttpServletRequest request, Model model) {
		UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		model.addAttribute("apprvPass", userSession.getApprvPass());
		String productSeq = request.getParameter("productSeq");
		String hourlyFlag = request.getParameter("hourlyFlag");
		Assert.notNull(productSeq, "");

		CustomCmmUserVO cmmUserInfo = new CustomCmmUserVO();
		cmmUserInfo.setUserId(request.getUserPrincipal().getName());
		cmmUserInfo = cmmUserService.userInfoDetail(cmmUserInfo);
		model.addAttribute("userLevelCode", cmmUserInfo.getUserLevelCode());

		CustomReqCatalogueVO projectvo = new CustomReqCatalogueVO();
		projectvo.setProductSeq(productSeq);
		projectvo.setApplyDate(DateFormatUtils.format(new Date(), "yyyy-MM-dd"));

		CustomReqCatalogueVO getCatalogueSelectView = reqCatalogueService.getCatalogueSelectView(projectvo);
		getCatalogueSelectView.setHourlyFlag(hourlyFlag);
		model.addAttribute("getCatalogueSelectView", getCatalogueSelectView);

		CustomReqCatalogueVO getCatalogueItempric = reqCatalogueService.getCatalogueItempric(projectvo);
		model.addAttribute("getCatalogueItempric", getCatalogueItempric);

		List<CustomReqCatalogueVO> getCatalogueOslist = reqCatalogueService.getCatalogueOslist(projectvo);
		model.addAttribute("getCatalogueOslist", getCatalogueOslist);

		List<CustomCmmCodeVO> getSharedNetwork = cmmCodeService.getSharedNetwork();
		model.addAttribute("getSharedNetwork", getSharedNetwork);

		List<CustomOssCloudVO> cloudList = cloudService.getCloudList();
		model.addAttribute("cloudList", cloudList);

        List<String> parentCodeKeyList = new ArrayList<>();
        parentCodeKeyList.add("ENV_TYPE");

		OssZoneNetworkDiskVO req = new OssZoneNetworkDiskVO();
		req.setVmImageType(projectvo.getVmImageType());
		req.setCatalogSeq(getCatalogueSelectView.getCatalogSeq());
		List<OssZoneNetworkDiskVO> res = ossZoneNetworkDiskservice.list(req);
		model.addAttribute("getNetwork", res);

        List<CustomCmmCodeVO> cmmCode = cmmCodeService.getCmmCodeByList(parentCodeKeyList);
        model.addAttribute("cmmCode", cmmCode);

		return "mbr/req/catalogue/catalogueFsOrder";
	}

	// 카테고리 상품 NAS 선택시 페이지 이동
	@RequestMapping(value = "/catalogueNasOrder.do", params = "!type")
	@Secured({ "ROLE_CUSTOM_ADMIN", "ROLE_CUSTOM_USER" })
	public String catalogueNasOrder(HttpServletRequest request, Model model) {

		String productSeq = request.getParameter("productSeq");
		String hourlyFlag = request.getParameter("hourlyFlag");
		Assert.notNull(productSeq, "");

		CustomReqCatalogueVO projectvo = new CustomReqCatalogueVO();
		projectvo.setProductSeq(productSeq);
		projectvo.setApplyDate(DateFormatUtils.format(new Date(), "yyyy-MM-dd"));

		CustomReqCatalogueVO getCatalogueSelectView = reqCatalogueService.getCatalogueSelectView(projectvo);
		getCatalogueSelectView.setHourlyFlag(hourlyFlag);
		model.addAttribute("getCatalogueSelectView", getCatalogueSelectView);

		CustomReqCatalogueVO getCatalogueItempric = reqCatalogueService.getCatalogueItempric(projectvo);
		model.addAttribute("getCatalogueItempric", getCatalogueItempric);

		List<CustomReqCatalogueVO> getCatalogueOslist = reqCatalogueService.getCatalogueOslist(projectvo);
		model.addAttribute("getCatalogueOslist", getCatalogueOslist);

		List<CustomCmmCodeVO> getSharedNetwork = cmmCodeService.getSharedNetwork();
		model.addAttribute("getSharedNetwork", getSharedNetwork);

		return "mbr/req/catalogue/catalogueNasOrder";
	}

	// 카테고리 pass 상품 Service 선택시 페이지 이동
	@RequestMapping(value = "/cataloguePaasServiceOrder.do", params = "!type")
	@Secured({ "ROLE_CUSTOM_ADMIN", "ROLE_CUSTOM_USER" })
	public String cataloguePaasServiceOrder(HttpServletRequest request, Model model) {
		UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		model.addAttribute("apprvPass", userSession.getApprvPass());

		String productSeq = request.getParameter("productSeq");
		String hourlyFlag = request.getParameter("hourlyFlag");
		Assert.notNull(productSeq, "");

		CustomReqCatalogueVO projectvo = new CustomReqCatalogueVO();
		projectvo.setProductSeq(productSeq);
		projectvo.setApplyDate(DateFormatUtils.format(new Date(), "yyyy-MM-dd"));

		CustomCmmUserVO cmmUserInfo = new CustomCmmUserVO();
		cmmUserInfo.setUserId(request.getUserPrincipal().getName());
		cmmUserInfo = cmmUserService.userInfoDetail(cmmUserInfo);
		model.addAttribute("userLevelCode", cmmUserInfo.getUserLevelCode());

		CustomReqCatalogueVO getCatalogueServiceView = reqCatalogueService.getCatalogueServiceView(projectvo);
		getCatalogueServiceView.setHourlyFlag(hourlyFlag);
		model.addAttribute("getCatalogueServiceView", getCatalogueServiceView);

		CustomReqCatalogueVO getCatalogueItempric = reqCatalogueService.getCatalogueItempric(projectvo);
		model.addAttribute("getCatalogueItempric", getCatalogueItempric);

		List<CustomReqCatalogueVO> getCatalogueOslist = reqCatalogueService.getCatalogueOslist(projectvo);
		model.addAttribute("getCatalogueOslist", getCatalogueOslist);

		List<CustomCmmCodeVO> getSharedNetwork = cmmCodeService.getSharedNetwork();
		model.addAttribute("getSharedNetwork", getSharedNetwork);

		return "mbr/req/catalogue/cataloguePassServiceOrder";
	}


	// 카테고리 상품 Service 선택시 페이지 이동
		@RequestMapping(value = "/catalogueServiceOrder.do", params = "!type")
		@Secured({ "ROLE_CUSTOM_ADMIN", "ROLE_CUSTOM_USER" })
		public String catalogueServiceOrder(HttpServletRequest request, Model model) {
			UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			model.addAttribute("apprvPass", userSession.getApprvPass());

			String productSeq = request.getParameter("productSeq");
			String hourlyFlag = request.getParameter("hourlyFlag");
			Assert.notNull(productSeq, "");

			CustomReqCatalogueVO projectvo = new CustomReqCatalogueVO();
			projectvo.setProductSeq(productSeq);
			projectvo.setApplyDate(DateFormatUtils.format(new Date(), "yyyy-MM-dd"));

			CustomCmmUserVO cmmUserInfo = new CustomCmmUserVO();
			cmmUserInfo.setUserId(request.getUserPrincipal().getName());
			cmmUserInfo = cmmUserService.userInfoDetail(cmmUserInfo);
			model.addAttribute("userLevelCode", cmmUserInfo.getUserLevelCode());

			CustomReqCatalogueVO getCatalogueServiceView = reqCatalogueService.getCatalogueServiceView(projectvo);
			getCatalogueServiceView.setHourlyFlag(hourlyFlag);
			model.addAttribute("getCatalogueServiceView", getCatalogueServiceView);

			CustomReqCatalogueVO getCatalogueItempric = reqCatalogueService.getCatalogueItempric(projectvo);
			model.addAttribute("getCatalogueItempric", getCatalogueItempric);

			List<CustomReqCatalogueVO> getCatalogueOslist = reqCatalogueService.getCatalogueOslist(projectvo);
			model.addAttribute("getCatalogueOslist", getCatalogueOslist);

			List<CustomCmmCodeVO> getSharedNetwork = cmmCodeService.getSharedNetwork();
			model.addAttribute("getSharedNetwork", getSharedNetwork);

			List<CustomOssCloudVO> cloudList = ossCloudService.getCloudList();
			model.addAttribute("cloudList", cloudList);

			List<String> parentCodeKeyList = new ArrayList<>();
	        parentCodeKeyList.add("ENV_TYPE");

	        List<CustomCmmCodeVO> cmmCode = cmmCodeService.getCmmCodeByList(parentCodeKeyList);
	        model.addAttribute("cmmCode", cmmCode);

			return "mbr/req/catalogue/catalogueServiceOrder";
		}


		// 카테고리 상품 Service 선택시 페이지 이동
	@RequestMapping(value = "/catalogueServiceOrder2.do", params = "!type")
	@Secured({ "ROLE_CUSTOM_ADMIN", "ROLE_CUSTOM_USER" })
	public String catalogueServiceOrder2(HttpServletRequest request, Model model) {

		String productSeq = request.getParameter("productSeq");
		String hourlyFlag = request.getParameter("hourlyFlag");
		Assert.notNull(productSeq, "");

		CustomReqCatalogueVO projectvo = new CustomReqCatalogueVO();
		projectvo.setProductSeq(productSeq);
		projectvo.setApplyDate(DateFormatUtils.format(new Date(), "yyyy-MM-dd"));

		CustomReqCatalogueVO getCatalogueServiceView = reqCatalogueService.getCatalogueServiceView(projectvo);
		getCatalogueServiceView.setHourlyFlag(hourlyFlag);
		model.addAttribute("getCatalogueServiceView", getCatalogueServiceView);

		CustomReqCatalogueVO getCatalogueItempric = reqCatalogueService.getCatalogueItempric(projectvo);
		model.addAttribute("getCatalogueItempric", getCatalogueItempric);

		List<CustomReqCatalogueVO> getCatalogueOslist = reqCatalogueService.getCatalogueOslist(projectvo);
		model.addAttribute("getCatalogueOslist", getCatalogueOslist);

		List<CustomCmmCodeVO> getSharedNetwork = cmmCodeService.getSharedNetwork();
		model.addAttribute("getSharedNetwork", getSharedNetwork);

		return "mbr/req/catalogue/catalogueServiceOrder2";
	}

	// 블록 디스크 상세 페이지 화면
	@RequestMapping(value = "/getcatalogueDiskOrderView")
	public ResponseEntity<Object> getcatalogueDiskOrder(HttpServletRequest request) {

		String productSeq = request.getParameter("productSeq");
		String hourlyFlag = request.getParameter("hourlyFlag");
		String diskcnt = request.getParameter("diskcnt");
		String cloudId = request.getParameter("cloudId");
		Assert.notNull(productSeq, "");

		CustomReqCatalogueVO projectvo = new CustomReqCatalogueVO();
		projectvo.setProductSeq(productSeq);
		projectvo.setApplyDate(DateFormatUtils.format(new Date(), "yyyy-MM-dd"));
		projectvo.setCloudId(cloudId);

		CustomReqCatalogueVO getCatalogueSelectView = reqCatalogueService.getCatalogueSelectView(projectvo);
		getCatalogueSelectView.setHourlyFlag(hourlyFlag);
		getCatalogueSelectView.setDiskcnt(diskcnt);

		log.debug("getDiskType : " + getCatalogueSelectView.getDiskType());
		log.debug("getDiskGb : " + getCatalogueSelectView.getDiskGb());
		log.debug("getDiskQuantity : " + getCatalogueSelectView.getDiskQuantity());
		log.debug("getDiskHourlyPrice : " + getCatalogueSelectView.getDiskHourlyPrice());
		log.debug("getDiskMonthlyPrice : " + getCatalogueSelectView.getDiskMonthlyPrice());

		return new ResponseEntity<Object>(getCatalogueSelectView, HttpStatus.OK);
	}

	// 블록 디스크 바로 주문시 페이지 이동
	@RequestMapping(value = "/catalogueDiskOrderNow.do", params = "type=noworder")
	@Secured({ "ROLE_CUSTOM_ADMIN", "ROLE_CUSTOM_USER" })
	public String catalogueDiskOrderNow(HttpServletRequest request, Model model, CustomReqCatalogueVO ordervo) {

		model.addAttribute("ordervo", ordervo);

		String hiddenUserIdReview = request.getParameter("hiddenUserIdReview");
		String hiddenUserIdApprove = request.getParameter("hiddenUserIdApprove");

		model.addAttribute("hiddenUserIdReview", hiddenUserIdReview);
		model.addAttribute("hiddenUserIdApprove", hiddenUserIdApprove);

		return "mbr/req/catalogue/catalogueDiskOrderNow";
	}

	// NAS 바로 주문시 페이지 이동
	@RequestMapping(value = "/catalogueNasOrderNow.do", params = "type=noworder")
	@Secured({ "ROLE_CUSTOM_ADMIN", "ROLE_CUSTOM_USER" })
	public String catalogueNasOrderNow(Model model, CustomReqCatalogueVO ordervo) {

		model.addAttribute("ordervo", ordervo);
//		log.debug("ordervo.getTotalPrice() : " + ordervo.getTotalPrice());

		return "mbr/req/catalogue/catalogueNasOrderNow";
	}

	// NAS 변경 바로 주문시 페이지 이동
//	@RequestMapping(value = "/catalogueNasOrderNow.do",params="type=nowordernasedit")
//	@Secured( {"ROLE_CUSTOM_ADMIN","ROLE_CUSTOM_USER"} )
//	public String catalogueNasOrderEditNow(HttpServletRequest request, Model model, CustomReqCatalogueVO ordervo ){
//
//		ordervo.setApplyDatetime(request.getParameter("editnas_expr_tab_applyTime"));
//		ordervo.setApplyTime(request.getParameter("editnas_expr_tab_applyTime"));
//		ordervo.setApplyDate(request.getParameter("editnas_expr_applyDate"));
//		ordervo.setDescription(request.getParameter("editnasdescription"));
//		ordervo.setNasId(request.getParameter("editnasId"));
//
//		ordervo.setRequestType("REQTYPE_CHANGE");
//
//		ordervo.setTotalPrice(request.getParameter("editnastotalPrice"));
//		ordervo.setProjectAlias(request.getParameter("editnasprojectAlias"));
//		ordervo.setProjectId(request.getParameter("editnasprojectId"));
//		ordervo.setProductSeq(request.getParameter("editnasproductSeq"));
//		ordervo.setProductCategory(request.getParameter("editnasproductCategory"));
//		ordervo.setCatalogSeq(request.getParameter("editnascatalogSeq"));
//		ordervo.setImageName(request.getParameter("editnasimageName"));
//		ordervo.setDiskcnt(request.getParameter("editnasGb"));
//		ordervo.setDiskName(request.getParameter("editnasName"));
//		ordervo.setBeforeNasGb(request.getParameter("beforeNasGb"));
//
//		model.addAttribute("ordervo", ordervo);
////		log.debug("ordervo.getTotalPrice() : " + ordervo.getTotalPrice());
//		return "mbr/req/catalogue/catalogueNasOrderNow";
//	}

	// NAS 해지 바로 주문시 페이지 이동
//	@RequestMapping(value = "/catalogueNasOrderNow.do",params="type=::")
//	@Secured( {"ROLE_CUSTOM_ADMIN","ROLE_CUSTOM_USER"} )
//	public String catalogueNasOrderExprNow(HttpServletRequest request, Model model, CustomReqCatalogueVO ordervo ){
//
//		ordervo.setApplyDatetime(request.getParameter("nas_expr_tab_applyTime"));
//		ordervo.setApplyTime(request.getParameter("nas_expr_tab_applyTime"));
//		ordervo.setApplyDate(request.getParameter("nas_expr_applyDate"));
//		ordervo.setDescription(request.getParameter("nasdescription"));
//		ordervo.setNasId(request.getParameter("nasId"));
//
//		ordervo.setRequestType("REQTYPE_EXPR");
//
//		ordervo.setTotalPrice(request.getParameter("nastotalPrice"));
//		ordervo.setProjectAlias(request.getParameter("nasprojectAlias"));
//		ordervo.setProjectId(request.getParameter("nasprojectId"));
//		ordervo.setProductSeq(request.getParameter("nasproductSeq"));
//		ordervo.setProductCategory(request.getParameter("nasproductCategory"));
//		ordervo.setCatalogSeq(request.getParameter("nascatalogSeq"));
//		ordervo.setImageName(request.getParameter("nasimageName"));
//		ordervo.setDiskcnt(request.getParameter("nasGb"));
//		ordervo.setDiskName(request.getParameter("nasName"));
//
//		model.addAttribute("ordervo", ordervo);
//		//log.debug("ordervo.getTotalPrice() : " + ordervo.getTotalPrice());
//		return "mbr/req/catalogue/catalogueNasOrderNow";
//	}

	// 공인IP 바로 주문시 페이지 이동
	@RequestMapping(value = "/catalogueIpOrderNow.do", params = "type=noworder")
	@Secured({ "ROLE_CUSTOM_ADMIN", "ROLE_CUSTOM_USER" })
	public String catalogueIpOrderNow(Model model, CustomReqCatalogueVO ordervo) {

		model.addAttribute("ordervo", ordervo);
		// log.debug("ordervo.getTotalPrice() : " + ordervo.getTotalPrice());
		return "mbr/req/catalogue/catalogueIpOrderNow";
	}

	// 서비스 바로 주문시 페이지 이동
	@RequestMapping(value = "/catalogueServiceOrderNow.do", params = "type=noworder")
	@Secured({ "ROLE_CUSTOM_ADMIN", "ROLE_CUSTOM_USER" })
	public String catalogueServiceOrderNow(HttpServletRequest request, Model model, CustomReqCatalogueVO ordervo) {

		model.addAttribute("ordervo", ordervo);

		String hiddenUserIdReview = request.getParameter("hiddenUserIdReview");
		String hiddenUserIdApprove = request.getParameter("hiddenUserIdApprove");

		model.addAttribute("hiddenUserIdReview", hiddenUserIdReview);
		model.addAttribute("hiddenUserIdApprove", hiddenUserIdApprove);

		// log.debug("ordervo.getTotalPrice() : " + ordervo.getTotalPrice());
		return "mbr/req/catalogue/catalogueServiceOrderNow";
	}

	// 공인IP 해지 바로 주문시 페이지 이동
//	@RequestMapping(value = "/catalogueIpOrderNow.do",params="type=noworderipexpr")
//	@Secured( {"ROLE_CUSTOM_ADMIN","ROLE_CUSTOM_USER"} )
//	public String catalogueIpExprNow(HttpServletRequest request, Model model, CustomReqCatalogueVO ordervo ){
//
//		ordervo.setApplyDatetime(request.getParameter("ip_expr_tab_applyTime"));
//		ordervo.setApplyTime(request.getParameter("ip_expr_tab_applyTime"));
//		ordervo.setApplyDate(request.getParameter("ip_expr_applyDate"));
//		ordervo.setDescription(request.getParameter("ipdescription"));
//		ordervo.setPublicipId(request.getParameter("publicipId"));
//		ordervo.setRequestType("REQTYPE_EXPR");
//		ordervo.setVmName(request.getParameter("iphostnameAlias"));
//		ordervo.setVmUuid(request.getParameter("ipvmUuid"));
//
//		ordervo.setTotalPrice(request.getParameter("iptotalPrice"));
//		ordervo.setProjectAlias(request.getParameter("ipprojectAlias"));
//		ordervo.setProjectId(request.getParameter("ipprojectId"));
//		ordervo.setProductSeq(request.getParameter("ipproductSeq"));
//		ordervo.setProductCategory(request.getParameter("ipproductCategory"));
//		ordervo.setCatalogSeq(request.getParameter("ipcatalogSeq"));
//		ordervo.setImageName(request.getParameter("ipimageName"));
//
//
//		model.addAttribute("ordervo", ordervo);
//		//log.debug("ordervo.getTotalPrice() : " + ordervo.getTotalPrice());
//		return "mbr/req/catalogue/catalogueIpOrderNow";
//	}

	// 백업 서비스 해지 바로 주문시 페이지 이동
//	@RequestMapping(value = "/catalogueServiceOrderNow.do",params="type=noworderexpr")
//	@Secured( {"ROLE_CUSTOM_ADMIN","ROLE_CUSTOM_USER"} )
//	public String catalogueServiceExprNow(HttpServletRequest request, Model model, CustomReqCatalogueVO ordervo ){
//
//		ordervo.setApplyDatetime(request.getParameter("back_expr_tab_applyTime"));
//		ordervo.setApplyTime(request.getParameter("back_expr_tab_applyTime"));
//		ordervo.setApplyDate(request.getParameter("back_expr_applyDate"));
//		ordervo.setDescription(request.getParameter("bakdescription"));
//		ordervo.setBackupId(request.getParameter("backupId"));
//		ordervo.setRequestType("REQTYPE_EXPR");
//		ordervo.setVmName(request.getParameter("hostnameAlias"));
//
//
//		model.addAttribute("ordervo", ordervo);
//		//log.debug("ordervo.getTotalPrice() : " + ordervo.getTotalPrice());
//		return "mbr/req/catalogue/catalogueServiceOrderNow";
//	}

	// 대외계 서비스 해지 바로 주문시 페이지 이동
//	@RequestMapping(value = "/catalogueServiceOrderNow.do",params="type=nowordermcaexpr")
//	@Secured( {"ROLE_CUSTOM_ADMIN","ROLE_CUSTOM_USER"} )
//	public String catalogueServiceMvaExprNow(HttpServletRequest request, Model model, CustomReqCatalogueVO ordervo ){
//
//		ordervo.setApplyDatetime(request.getParameter("mca_expr_tab_applyTime"));
//		ordervo.setApplyTime(request.getParameter("mca_expr_tab_applyTime"));
//		ordervo.setApplyDate(request.getParameter("mca_expr_applyDate"));
//		ordervo.setDescription(request.getParameter("mcadescription"));
//		ordervo.setMcaId(request.getParameter("mcaId"));
//		ordervo.setTotalPrice(request.getParameter("mcatotalPrice"));
//		ordervo.setProjectAlias(request.getParameter("mcaprojectAlias"));
//		ordervo.setRequestType("REQTYPE_EXPR");
//		ordervo.setProjectId(request.getParameter("mcaprojectId"));
//		ordervo.setProductSeq(request.getParameter("mcaproductSeq"));
//		ordervo.setProductCategory(request.getParameter("mcaproductCategory"));
//		ordervo.setCatalogSeq(request.getParameter("mcacatalogSeq"));
//		ordervo.setMcaId(request.getParameter("mcaId"));
//		ordervo.setImageName(request.getParameter("mcaimageName"));
//
//		//ordervo.setVmName(request.getParameter("hostnameAlias"));
//
//		model.addAttribute("ordervo", ordervo);
//		//log.debug("ordervo.getTotalPrice() : " + ordervo.getTotalPrice());
//		return "mbr/req/catalogue/catalogueServiceOrderNow";
//	}

	// 형상관리 서비스 해지 바로 주문시 페이지 이동
//	@RequestMapping(value = "/catalogueServiceOrderNow.do",params="type=noworderscmexpr")
//	@Secured( {"ROLE_CUSTOM_ADMIN","ROLE_CUSTOM_USER"} )
//	public String catalogueServiceScmExprNow(HttpServletRequest request, Model model,CustomReqCatalogueVO ordervo ){
//
//		ordervo.setApplyDatetime(request.getParameter("scm_expr_tab_applyTime"));
//		ordervo.setApplyTime(request.getParameter("scm_expr_tab_applyTime"));
//		ordervo.setApplyDate(request.getParameter("scm_expr_applyDate"));
//		ordervo.setDescription(request.getParameter("scmdescription"));
//		ordervo.setTotalPrice(request.getParameter("scmtotalPrice"));
//		ordervo.setProjectAlias(request.getParameter("scmprojectAlias"));
//		ordervo.setRequestType("REQTYPE_EXPR");
//		ordervo.setProjectId(request.getParameter("scmprojectId"));
//		ordervo.setProductSeq(request.getParameter("scmproductSeq"));
//		ordervo.setProductCategory(request.getParameter("scmproductCategory"));
//		ordervo.setCatalogSeq(request.getParameter("scmcatalogSeq"));
//		ordervo.setScmId(request.getParameter("scmId"));
//		ordervo.setImageName(request.getParameter("scmimageName"));
//
//		//ordervo.setVmName(request.getParameter("hostnameAlias"));
//
//		model.addAttribute("ordervo", ordervo);
//		//log.debug("ordervo.getTotalPrice() : " + ordervo.getTotalPrice());
//		return "mbr/req/catalogue/catalogueServiceOrderNow";
//	}

	// 보안관제 서비스 해지 바로 주문시 페이지 이동
//	@RequestMapping(value = "/catalogueServiceOrderNow.do",params="type=noworderscrexpr")
//	@Secured( {"ROLE_CUSTOM_ADMIN","ROLE_CUSTOM_USER"} )
//	public String catalogueServiceScrExprNow(HttpServletRequest request, Model model, CustomReqCatalogueVO ordervo ){
//
//		ordervo.setApplyDatetime(request.getParameter("scr_expr_tab_applyTime"));
//		ordervo.setApplyTime(request.getParameter("scr_expr_tab_applyTime"));
//		ordervo.setApplyDate(request.getParameter("scr_expr_applyDate"));
//		ordervo.setDescription(request.getParameter("scrdescription"));
//		ordervo.setTotalPrice(request.getParameter("scrtotalPrice"));
//		ordervo.setProjectAlias(request.getParameter("scrprojectAlias"));
//		ordervo.setRequestType("REQTYPE_EXPR");
//		ordervo.setProjectId(request.getParameter("scrprojectId"));
//		ordervo.setProductSeq(request.getParameter("scrproductSeq"));
//		ordervo.setProductCategory(request.getParameter("scrproductCategory"));
//		ordervo.setCatalogSeq(request.getParameter("scrcatalogSeq"));
//		ordervo.setSecurityId(request.getParameter("securityId"));
//		ordervo.setImageName(request.getParameter("scrimageName"));
//
//		//ordervo.setVmName(request.getParameter("hostnameAlias"));
//
//		model.addAttribute("ordervo", ordervo);
//		//log.debug("ordervo.getTotalPrice() : " + ordervo.getTotalPrice());
//		return "mbr/req/catalogue/catalogueServiceOrderNow";
//	}

	// 카테고리 기본상품 페이지 이동
	@RequestMapping(value = "/catalogueBasicList.do", params = "!type")
	@Secured({ "ROLE_CUSTOM_USER" })
	public String catalogueBasicList(HttpServletRequest request, Model model) {

		CustomReqCatalogueVO customCatalogVO = new CustomReqCatalogueVO();
		customCatalogVO.setApplyDate(DateFormatUtils.format(new Date(), "yyyy-MM-dd"));
		customCatalogVO.setEnableRecommandFlag("N"); // 모든상품 보여주기 && Display Falg = N
		customCatalogVO.setConditionCategory(Arrays.asList("CATACATE_VM")); // 기본상품(VM) Category에 해당하는것

		String instanceType = request.getParameter("instanceType");
		model.addAttribute("instanceType", instanceType);

		List<CustomReqCatalogueVO> getCatalogueList = reqCatalogueService.getCatalogueList(customCatalogVO);
		model.addAttribute("getCatalogueList", getCatalogueList);

		return "mbr/req/catalogue/catalogueBasicList";
	}

	// 카테고리 기본상품 페이지 이동
	@RequestMapping(value = "/catalogueDirectList.do", params = "!type")
	@Secured({ "ROLE_CUSTOM_USER" })
	public String catalogueDirectList(HttpServletRequest request, Model model) {

		CustomReqCatalogueVO customCatalogVO = new CustomReqCatalogueVO();
		customCatalogVO.setApplyDate(DateFormatUtils.format(new Date(), "yyyy-MM-dd"));
		customCatalogVO.setEnableRecommandFlag("N"); // 모든상품 보여주기 && Display Falg = N
		customCatalogVO.setConditionCategory(Arrays.asList("CATACATE_VM")); // 기본상품(VM) Category에 해당하는것

		List<CustomReqCatalogueVO> getCatalogueList = reqCatalogueService.getCatalogueList(customCatalogVO);
		model.addAttribute("getCatalogueList", getCatalogueList);

		return "mbr/req/catalogue/catalogueDirectList";
	}

	@RequestMapping(value = "/vmList")
	public ResponseEntity<Object> getVmList(HttpServletRequest request, Model model) {

		CustomReqCatalogueVO customCatalogVO = new CustomReqCatalogueVO();
		customCatalogVO.setApplyDate(DateFormatUtils.format(new Date(), "yyyy-MM-dd"));
		customCatalogVO.setEnableRecommandFlag("N"); // 모든상품 보여주기 && Display Falg = N
		customCatalogVO.setConditionCategory(Arrays.asList("CATACATE_VM")); // 기본상품(VM) Category에 해당하는것

		List<CustomReqCatalogueVO> getCatalogueList = reqCatalogueService.getCatalogueList(customCatalogVO);
		model.addAttribute("getCatalogueList", getCatalogueList);

		return new ResponseEntity<Object>(getCatalogueList, HttpStatus.OK);
	}

	// 카테고리 기본상품 페이지 이동
	@RequestMapping(value = "/catalogueBasic.do", params = "!type")
	@Secured({ "ROLE_CUSTOM_ADMIN", "ROLE_CUSTOM_USER" })
	public String catalogueBasic(HttpServletRequest request, Model model) {

//		String hourlyFlag =  request.getParameter("hourlyFlag");

		CustomReqCatalogueVO projectvo = new CustomReqCatalogueVO();
		projectvo.setApplyDate(DateFormatUtils.format(new Date(), "yyyy-MM-dd"));

		CustomReqCatalogueVO getCatalogueItempric = reqCatalogueService.getCatalogueItempric(projectvo);
		model.addAttribute("getCatalogueItempric", getCatalogueItempric);

		List<CustomReqCatalogueVO> getCatalogueOslist = reqCatalogueService.getCatalogueOslist(projectvo);
		model.addAttribute("getCatalogueOslist", getCatalogueOslist);

		List<CustomCmmCodeVO> getSharedNetwork = cmmCodeService.getSharedNetwork();
		model.addAttribute("getSharedNetwork", getSharedNetwork);

//		CustomCmmCodeVO req=new CustomCmmCodeVO();
		// List<CustomCmmCodeVO> getSharedNetwork = service.detail(req);
//		String vcpus ="1";
//		String mem ="1";
//		String disk ="100";

		CustomReqCatalogueVO getCatalogueSelectView = reqCatalogueService.getCatalogueSelectBasicView(projectvo);
		model.addAttribute("getCatalogueSelectView", getCatalogueSelectView);

		return "mbr/req/catalogue/catalogueBasicOrder";
	}

	// 카테고리 소프트웨어 페이지 이동
	@RequestMapping(value = "/catalogueSoftOrder.do", params = "!type")
	@Secured({ "ROLE_CUSTOM_ADMIN", "ROLE_CUSTOM_USER" })
	public String catalogueSoftOrder(HttpServletRequest request, Model model) {

//		String hourlyFlag =  request.getParameter("hourlyFlag");

		CustomReqCatalogueVO projectvo = new CustomReqCatalogueVO();
		projectvo.setApplyDate(DateFormatUtils.format(new Date(), "yyyy-MM-dd"));

		CustomReqCatalogueVO getCatalogueItempric = reqCatalogueService.getCatalogueItempric(projectvo);
		model.addAttribute("getCatalogueItempric", getCatalogueItempric);

		List<CustomReqCatalogueVO> getCatalogueOslist = reqCatalogueService.getCatalogueOslist(projectvo);
		model.addAttribute("getCatalogueOslist", getCatalogueOslist);

		List<CustomCmmCodeVO> getSharedNetwork = cmmCodeService.getSharedNetwork();
		model.addAttribute("getSharedNetwork", getSharedNetwork);

//		CustomCmmCodeVO req=new CustomCmmCodeVO();
		// List<CustomCmmCodeVO> getSharedNetwork = service.detail(req);

//		String vcpus ="1";
//		String mem ="1";
//		String disk ="100";

		CustomReqCatalogueVO getCatalogueSelectView = reqCatalogueService.getCatalogueSelectBasicView(projectvo);
		model.addAttribute("getCatalogueSelectView", getCatalogueSelectView);

		return "mbr/req/catalogue/catalogueSoftOrder";
	}

	// 기본상품 상세 페이지 화면
	@RequestMapping(value = "/getcatalogueBasicOrderView")
	@Secured({ "ROLE_CUSTOM_ADMIN", "ROLE_CUSTOM_USER" })
	public ResponseEntity<Object> getcatalogueBasicOrderView(HttpServletRequest request, Model model) {

//		String productSeq =  request.getParameter("productSeq");

		String hourlyFlag = request.getParameter("hourlyFlag");
		String diskcnt = request.getParameter("diskcnt");
		Assert.notNull(hourlyFlag, "");
		Assert.notNull(diskcnt, "");

		CustomReqCatalogueVO projectvo = new CustomReqCatalogueVO();
		projectvo.setApplyDate(DateFormatUtils.format(new Date(), "yyyy-MM-dd"));

		CustomReqCatalogueVO getCatalogueItempric = reqCatalogueService.getCatalogueItempric(projectvo);
		model.addAttribute("getCatalogueItempric", getCatalogueItempric);
		log.debug(getCatalogueItempric.getDiskMonthlyPrice());
		log.debug(getCatalogueItempric.getDiskHourlyPrice());

		List<CustomReqCatalogueVO> getCatalogueOslist = reqCatalogueService.getCatalogueOslist(projectvo);
		model.addAttribute("getCatalogueOslist", getCatalogueOslist);

		CustomReqCatalogueVO getCatalogueSelectBasicView = new CustomReqCatalogueVO();
		getCatalogueSelectBasicView.setCpuMonthlyPrice(getCatalogueItempric.getCpuMonthlyPrice());
		getCatalogueSelectBasicView.setMemMonthlyPrice(getCatalogueItempric.getMemMonthlyPrice());
		getCatalogueSelectBasicView.setDiskMonthlyPrice(getCatalogueItempric.getDiskMonthlyPrice());
		getCatalogueSelectBasicView.setCpuHourlyPrice(getCatalogueItempric.getCpuHourlyPrice());
		getCatalogueSelectBasicView.setMemHourlyPrice(getCatalogueItempric.getMemHourlyPrice());
		getCatalogueSelectBasicView.setDiskHourlyPrice(getCatalogueItempric.getDiskHourlyPrice());
		getCatalogueSelectBasicView.setDiskGb(diskcnt);
		log.debug(getCatalogueSelectBasicView.getDiskGb());

		return new ResponseEntity<Object>(getCatalogueSelectBasicView, HttpStatus.OK);
	}

	// OS 선택시 OS별 가격 정보
	@RequestMapping(value = "/osSelect")
	public ResponseEntity<Object> osSelect(HttpServletRequest request) {

		String osProductSeq = request.getParameter("osProductSeq");
		String cloudId = request.getParameter("cloudId");
		Assert.notNull(osProductSeq, "");

		CustomReqCatalogueVO osselectvo = new CustomReqCatalogueVO();
		osselectvo.setOsProductSeq(osProductSeq);
		osselectvo.setCloudId(cloudId);
		osselectvo.setApplyDate(DateFormatUtils.format(new Date(), "yyyy-MM-dd"));

		CustomReqCatalogueVO getCatalogueOsprice = reqCatalogueService.getCatalogueOs(osselectvo);

		return new ResponseEntity<Object>(getCatalogueOsprice, HttpStatus.OK);
	}

	// NAS 변경 신청 장바구니 페이지 이동 및 장바구니 테이블 입력
//	@RequestMapping(value = "/basketOrder.do",params="type=nowordernasedit")
//	public RedirectView cataloguebasketNaseditOrder(HttpServletRequest request, Model model,CustomReqCatalogueVO ordervo ){
//
//		final String modUserId = request.getUserPrincipal().getName();
//
//		CustomReqBasketVO basketvo = new CustomReqBasketVO();
//		basketvo.setBasketSeq(DateFormatUtils.format(new Date(), "yyyyMMddHHmmss"));
//		basketvo.setUserId(modUserId);
//		basketvo.setRequestType("REQTYPE_CHANGE");
//		basketvo.setProductCategory(request.getParameter("editnasproductCategory"));
//
//		if(basketvo.getProductCategory().equals("PRODCATE_NAS")){
//
//			String basketSummary = "";
//			basketvo.setOnDemandFlag(request.getParameter("onDemandFlag"));
//			String applyDatetime = "";
//			if(ordervo.getOnDemandFlag().equals("N")){
//				applyDatetime =		request.getParameter("editnas_expr_applyDate") +" "+ request.getParameter("editnas_expr_tab_applyTime") +":00";
//			}
//			basketSummary ="<table><colgroup><col width='30%'><col width='70%'></colgroup><tbody>";
//			basketSummary = basketSummary +"<tr><td class='left'>서비스시작일시</td><td>"+applyDatetime+"</td></tr>";
//			basketSummary = basketSummary +"<tr><td class='left'>프로젝트</td><td>"+request.getParameter("editnashostnameAlias")+" </td></tr>";
//			basketSummary = basketSummary +"<tr><td class='left'>NAS 이름</td><td>"+request.getParameter("editnasName")+" </td></tr>";
//			basketSummary = basketSummary +"<tr><td class='left'>NAS 용량</td><td>"+request.getParameter("editnasGb")+" GB </td></tr>";
//			basketSummary = basketSummary +"<tr><td class='left'>비고</td><td>"+request.getParameter("editnasdescription")+"</td></tr>";
//			basketSummary = basketSummary +"<tr><td colspan='2' class='tar f18 fc-red'>"+request.getParameter("editnastotalPrice")+" <span class='f12 fc66'>원</span></td></tr>";
//			basketSummary = basketSummary +"</tbody></table>";
//
//			basketvo.setBasketSummary(basketSummary);
//			basketvo.setHourlyFlag(request.getParameter("editnasoldhourlyFlag"));
//			basketvo.setAmount(request.getParameter("editnastotalPrice"));
//
//			basketvo.setDiskName(request.getParameter("editnasName"));
//			basketvo.setNasName(request.getParameter("editnasName"));
//			basketvo.setNasGb(request.getParameter("editnasGb"));
//
//			basketvo.setVmUuid(request.getParameter("editnasvmUuid"));
//
//			basketvo.setApplyDatetime(applyDatetime);
//			basketvo.setProjectId(request.getParameter("editnasprojectId"));
//
//			basketvo.setDiskGb(request.getParameter("editnasGb"));
//			basketvo.setCatalogSeq(request.getParameter("editnascatalogSeq"));
//			basketvo.setNasProductSeq(request.getParameter("editnasproductSeq"));
//
//			basketvo.setDescription(request.getParameter("editnasdescription"));
//			basketvo.setNasId(request.getParameter("editnasId"));
//			basketvo.setBeforeNasGb(request.getParameter("beforeNasGb"));
//
//			reqCatalogueService.setBasket(basketvo);
//			reqCatalogueService.setBasketNas(basketvo);
//		}
//
//		//장바구니 vm 리스트 가져오기
//		List<CustomReqBasketVO> getBasketlistvo = reqCatalogueService.getBasketlist(basketvo);
//		String networkChk ="";
//		for (int i = 0; i < getBasketlistvo.size(); i++) {
//			List<CustomReqBasketVO> getBasketVmList = reqCatalogueService.getBasketVmList(getBasketlistvo.get(i).getBasketSeq());
//			for (int j = 0; j < getBasketVmList.size(); j++) {
//				networkChk = getBasketVmList.get(j).getSharedNetwork();
//				networkChk = networkChk+":"+getBasketVmList.get(j).getSharedNetworkName();
//				networkChk = networkChk+":"+getBasketVmList.get(j).getSelectedFlag();
//				getBasketlistvo.get(i).setNetworkChk(networkChk);
//				log.debug("networkChk : "+ networkChk);
//				networkChk="";
//			}
//		}
//		model.addAttribute("getBasketlistvo", getBasketlistvo);
//
//		//장바구니 블록디스크 리스트 가져오기
//		List<CustomReqBasketVO> getBasketDisklistvo = reqCatalogueService.getBasketDisklistvo(basketvo);
//		model.addAttribute("getBasketDisklistvo", getBasketDisklistvo);
//
//		//장바구니 NAS 리스트 가져오기
//		List<CustomReqBasketVO> getBasketNaslistvo = reqCatalogueService.getBasketNaslistvo(basketvo);
//		model.addAttribute("getBasketNaslistvo", getBasketNaslistvo);
//
//		//장바구니 IP 리스트 가져오기
//		List<CustomReqBasketVO> getBasketIplistvo = reqCatalogueService.getBasketIplistvo(basketvo);
//		model.addAttribute("getBasketIplistvo", getBasketIplistvo);
//
//		//장바구니 로드 밸런서 리스트 가져오기
//		List<CustomReqBasketVO> getBasketLblistvo = reqCatalogueService.getBasketLblistvo(basketvo);
//		model.addAttribute("getBasketIplistvo", getBasketLblistvo);
//
//		//장바구니 서비스 백업 리스트 가져오기
//		List<CustomReqBasketVO> getBasketBaklistvo = reqCatalogueService.getBasketBaklistvo(basketvo);
//		model.addAttribute("getBasketBaklistvo", getBasketBaklistvo);
//
//		//장바구니 서비스 리스트 가져오기
//		List<CustomReqBasketVO> getBasketServicelistvo = reqCatalogueService.getBasketServicelistvo(basketvo);
//		model.addAttribute("getBasketServicelistvo", getBasketServicelistvo);
//
//		//장바구니 서비스 대외계 리스트 가져오기
//		List<CustomReqBasketVO> getBasketMcalistvo = reqCatalogueService.getBasketMcalistvo(basketvo);
//		model.addAttribute("getBasketMcalistvo", getBasketMcalistvo);
//
//		//장바구니 서비스 형상관리 리스트 가져오기
//		List<CustomReqBasketVO> getBasketScmlistvo = reqCatalogueService.getBasketScmlistvo(basketvo);
//		model.addAttribute("getBasketScmlistvo", getBasketScmlistvo);
//
//		//장바구니 서비스 보안관제 리스트 가져오기
//		List<CustomReqBasketVO> getBasketSerlistvo = reqCatalogueService.getBasketSerlistvo(basketvo);
//		model.addAttribute("getBasketSerlistvo", getBasketSerlistvo);
//
//		//장바구니 서비스 리스트 가져오기
//		/*
//		 * List<CustomReqBasketVO> getBasketService =
//		 * reqCatalogueService.getbasketServicelistvo(basketvo);
//		 * model.addAttribute("getBasketServicevo", getBasketServicelistvo);
//		 */
//
//		RedirectView rv = new RedirectView("basketOrder.do");
//		rv.setExposeModelAttributes(false);
//		return rv;
//	}

	// NAS 해지 신청 장바구니 페이지 이동 및 장바구니 테이블 입력
//	@RequestMapping(value = "/basketOrder.do",params="type=nowordernasexpr")
//	public RedirectView cataloguebasketNasOrder(HttpServletRequest request, Model model,CustomReqCatalogueVO ordervo ){
//
//		//bss_basket
//		String basketSeq = DateFormatUtils.format(new Date(), "yyyyMMddHHmmss");
//		String requestType = "REQTYPE_EXPR";
//
//		CustomReqBasketVO basketvo = new CustomReqBasketVO();
//		basketvo.setBasketSeq(basketSeq);
//		basketvo.setUserId(request.getUserPrincipal().getName());
//		basketvo.setRequestType(requestType);
//		basketvo.setProductCategory(request.getParameter("nasproductCategory"));
//
//		if(basketvo.getProductCategory().equals("PRODCATE_NAS")){
//
//			String basketSummary = "";
//			basketvo.setOnDemandFlag("N");
//			String applyDatetime = "";
//			if(ordervo.getOnDemandFlag().equals("N")){
//				applyDatetime =	request.getParameter("nas_expr_applyDate") +" "+ request.getParameter("nas_expr_tab_applyTime") +":00";
//			}
//			basketSummary ="<table><colgroup><col width='30%'><col width='70%'></colgroup><tbody>";
//			basketSummary = basketSummary +"<tr><td class='left'>서비스시작일시</td><td>"+applyDatetime+"</td></tr>";
//			basketSummary = basketSummary +"<tr><td class='left'>프로젝트</td><td>"+request.getParameter("nashostnameAlias")+" </td></tr>";
//			basketSummary = basketSummary +"<tr><td class='left'>NAS 이름</td><td>"+request.getParameter("nasName")+" </td></tr>";
//			basketSummary = basketSummary +"<tr><td class='left'>NAS 용량</td><td>"+request.getParameter("nasGb")+" GB </td></tr>";
//			basketSummary = basketSummary +"<tr><td class='left'>비고</td><td>"+request.getParameter("nasdescription")+"</td></tr>";
//			basketSummary = basketSummary +"<tr><td colspan='2' class='tar f18 fc-red'>"+request.getParameter("nastotalPrice")+" <span class='f12 fc66'>원</span></td></tr>";
//			basketSummary = basketSummary +"</tbody></table>";
//
//			basketvo.setBasketSummary(basketSummary);
//			basketvo.setHourlyFlag("N");
//			basketvo.setAmount(request.getParameter("nastotalPrice"));
//
//			basketvo.setDiskName(request.getParameter("nasName"));
//			basketvo.setNasName(request.getParameter("nasName"));
//			basketvo.setNasGb(request.getParameter("nasGb"));
//
//			basketvo.setVmUuid(request.getParameter("nasvmUuid"));
//
//			basketvo.setApplyDatetime(applyDatetime);
//			basketvo.setProjectId(request.getParameter("nasprojectId"));
//
//			basketvo.setDiskGb(request.getParameter("nasGb"));
//			basketvo.setCatalogSeq(request.getParameter("nascatalogSeq"));
//			basketvo.setNasProductSeq(request.getParameter("nasproductSeq"));
//
//			basketvo.setDescription(request.getParameter("nasdescription"));
//			basketvo.setNasId(request.getParameter("nasId"));
//
//			reqCatalogueService.setBasket(basketvo);
//			reqCatalogueService.setBasketNas(basketvo);
//
//		}
//
//		//장바구니 vm 리스트 가져오기
//		List<CustomReqBasketVO> getBasketlistvo = reqCatalogueService.getBasketlist(basketvo);
//		String networkChk ="";
//		for (int i = 0; i < getBasketlistvo.size(); i++) {
//			List<CustomReqBasketVO> getBasketVmList = reqCatalogueService.getBasketVmList(getBasketlistvo.get(i).getBasketSeq());
//			for (int j = 0; j < getBasketVmList.size(); j++) {
//				networkChk = getBasketVmList.get(j).getSharedNetwork();
//				networkChk = networkChk+":"+getBasketVmList.get(j).getSharedNetworkName();
//				networkChk = networkChk+":"+getBasketVmList.get(j).getSelectedFlag();
//				getBasketlistvo.get(i).setNetworkChk(networkChk);
//				log.debug("networkChk : "+ networkChk);
//				networkChk="";
//			}
//		}
//		model.addAttribute("getBasketlistvo", getBasketlistvo);
//
//		//장바구니 블록디스크 리스트 가져오기
//		List<CustomReqBasketVO> getBasketDisklistvo = reqCatalogueService.getBasketDisklistvo(basketvo);
//		model.addAttribute("getBasketDisklistvo", getBasketDisklistvo);
//
//		//장바구니 NAS 리스트 가져오기
//		List<CustomReqBasketVO> getBasketNaslistvo = reqCatalogueService.getBasketNaslistvo(basketvo);
//		model.addAttribute("getBasketNaslistvo", getBasketNaslistvo);
//
//		//장바구니 IP 리스트 가져오기
//		List<CustomReqBasketVO> getBasketIplistvo = reqCatalogueService.getBasketIplistvo(basketvo);
//		model.addAttribute("getBasketIplistvo", getBasketIplistvo);
//
//		//장바구니 로드 밸런서 리스트 가져오기
//		List<CustomReqBasketVO> getBasketLblistvo = reqCatalogueService.getBasketLblistvo(basketvo);
//		model.addAttribute("getBasketIplistvo", getBasketLblistvo);
//
//		//장바구니 서비스 백업 리스트 가져오기
//		List<CustomReqBasketVO> getBasketBaklistvo = reqCatalogueService.getBasketBaklistvo(basketvo);
//		model.addAttribute("getBasketBaklistvo", getBasketBaklistvo);
//
//		//장바구니 서비스 리스트 가져오기
//		List<CustomReqBasketVO> getBasketServicelistvo = reqCatalogueService.getBasketServicelistvo(basketvo);
//		model.addAttribute("getBasketServicelistvo", getBasketServicelistvo);
//
//		//장바구니 서비스 대외계 리스트 가져오기
//		List<CustomReqBasketVO> getBasketMcalistvo = reqCatalogueService.getBasketMcalistvo(basketvo);
//		model.addAttribute("getBasketMcalistvo", getBasketMcalistvo);
//
//		//장바구니 서비스 형상관리 리스트 가져오기
//		List<CustomReqBasketVO> getBasketScmlistvo = reqCatalogueService.getBasketScmlistvo(basketvo);
//		model.addAttribute("getBasketScmlistvo", getBasketScmlistvo);
//
//		//장바구니 서비스 보안관제 리스트 가져오기
//		List<CustomReqBasketVO> getBasketSerlistvo = reqCatalogueService.getBasketSerlistvo(basketvo);
//		model.addAttribute("getBasketSerlistvo", getBasketSerlistvo);
//
//		RedirectView rv = new RedirectView("basketOrder.do");
//		rv.setExposeModelAttributes(false);
//		return rv;
//	}

	// 로드밸런서 해지 신청 장바구니 페이지 이동 및 장바구니 테이블 입력
//	@RequestMapping(value = "/basketOrder.do",params="type=noworderlbexpr")
//	public RedirectView cataloguebasketLbOrder(HttpServletRequest request, Model model,CustomReqCatalogueVO ordervo ){
//
//		//bss_basket
//		String basketSeq = DateFormatUtils.format(new Date(), "yyyyMMddHHmmss");
//		String requestType = "REQTYPE_EXPR";
//
//		CustomReqBasketVO basketvo = new CustomReqBasketVO();
//		basketvo.setBasketSeq(basketSeq);
//		basketvo.setUserId(request.getUserPrincipal().getName());
//		basketvo.setRequestType(requestType);
//		basketvo.setProductCategory(request.getParameter("lbproductCategory"));
//
//		if(basketvo.getProductCategory().equals("PRODCATE_LOADBALANCER")){
//
//			String basketSummary = "";
//			basketvo.setOnDemandFlag("N");
//			String applyDatetime = "";
//			if(ordervo.getOnDemandFlag().equals("N")){
//				applyDatetime =		request.getParameter("lb_expr_applyDate") +" "+ request.getParameter("lb_expr_tab_applyTime") +":00";
//			}
//			basketSummary ="<table><colgroup><col width='30%'><col width='70%'></colgroup><tbody>";
//			basketSummary = basketSummary +"<tr><td class='left'>서비스시작일시</td><td>"+applyDatetime+"</td></tr>";
//			basketSummary = basketSummary +"<tr><td class='left'>프로젝트</td><td>"+request.getParameter("lbprojectName")+" </td></tr>";
//			basketSummary = basketSummary +"<tr><td class='left'>네트워크 ZONE</td><td>"+request.getParameter("lbnetworkAlias")+" </td></tr>";
//			basketSummary = basketSummary +"<tr><td class='left'>가상서버</td><td>"+request.getParameter("lbloadbalancerVm")+" </td></tr>";
//			basketSummary = basketSummary +"<tr><td class='left'>로드밸런서 이름</td><td>"+request.getParameter("lbloadbalancerName")+"</td></tr>";
//			basketSummary = basketSummary +"<tr><td class='left'>Protocol</td><td>"+request.getParameter("lbprotocol")+"</td></tr>";
//			basketSummary = basketSummary +"<tr><td class='left'>Method</td><td>"+request.getParameter("lbmethod")+"</td></tr>";
//			basketSummary = basketSummary +"<tr><td class='left'>Monitor Type</td><td>"+request.getParameter("lbmonitorType")+"</td></tr>";
//			basketSummary = basketSummary +"<tr><td class='left'>비고</td><td>"+request.getParameter("lbdescription")+"</td></tr>";
//			basketSummary = basketSummary +"<tr><td colspan='2' class='tar f18 fc-red'>"+request.getParameter("lbtotalPrice")+" <span class='f12 fc66'>원</span></td></tr>";
//			basketSummary = basketSummary +"</tbody></table>";
//
//			basketvo.setBasketSummary(basketSummary);
//			basketvo.setApplyDatetime(applyDatetime);
//			basketvo.setHourlyFlag("N");
//			basketvo.setProjectId(request.getParameter("lbprojectId"));
//			basketvo.setDefaultNetworkId(request.getParameter("lbnetworkId"));
//			basketvo.setLoadbalancerName(request.getParameter("lbloadbalancerName"));
//			basketvo.setLoadbalancerEa("1");
//			basketvo.setDescription(request.getParameter("lbdescription"));
//			basketvo.setMethod(request.getParameter("lbmethod"));
//			basketvo.setProtocol(request.getParameter("lbprotocol"));
//			basketvo.setMonitorType(request.getParameter("lbmonitorType"));
//			basketvo.setLoadbalancerProductSeq(request.getParameter("lbproductSeq"));
//
//			basketvo.setAmount(request.getParameter("lbtotalPrice"));
//			basketvo.setVmUuid(request.getParameter("lbvmUuid"));
//			basketvo.setCatalogSeq(request.getParameter("lbcatalogSeq"));
//			basketvo.setLoadbalancerId(request.getParameter("loadbalancerId"));
//
//			reqCatalogueService.setBasket(basketvo);
//			reqCatalogueService.setBasketLoad(basketvo);
//			/*String setBasketLoadVm = reqCatalogueService.setBasketLoadVm(basketvo);*/
//		}
//
//		//장바구니 vm 리스트 가져오기
//		List<CustomReqBasketVO> getBasketlistvo = reqCatalogueService.getBasketlist(basketvo);
//		String networkChk ="";
//		for (int i = 0; i < getBasketlistvo.size(); i++) {
//			List<CustomReqBasketVO> getBasketVmList = reqCatalogueService.getBasketVmList(getBasketlistvo.get(i).getBasketSeq());
//			for (int j = 0; j < getBasketVmList.size(); j++) {
//				networkChk = getBasketVmList.get(j).getSharedNetwork();
//				networkChk = networkChk+":"+getBasketVmList.get(j).getSharedNetworkName();
//				networkChk = networkChk+":"+getBasketVmList.get(j).getSelectedFlag();
//				getBasketlistvo.get(i).setNetworkChk(networkChk);
//				log.debug("networkChk : "+ networkChk);
//				networkChk="";
//			}
//		}
//		model.addAttribute("getBasketlistvo", getBasketlistvo);
//
//		//장바구니 블록디스크 리스트 가져오기
//		List<CustomReqBasketVO> getBasketDisklistvo = reqCatalogueService.getBasketDisklistvo(basketvo);
//		model.addAttribute("getBasketDisklistvo", getBasketDisklistvo);
//
//		//장바구니 NAS 리스트 가져오기
//		List<CustomReqBasketVO> getBasketNaslistvo = reqCatalogueService.getBasketNaslistvo(basketvo);
//		model.addAttribute("getBasketNaslistvo", getBasketNaslistvo);
//
//		//장바구니 IP 리스트 가져오기
//		List<CustomReqBasketVO> getBasketIplistvo = reqCatalogueService.getBasketIplistvo(basketvo);
//		model.addAttribute("getBasketIplistvo", getBasketIplistvo);
//
//		//장바구니 로드 밸런서 리스트 가져오기
//		List<CustomReqBasketVO> getBasketLblistvo = reqCatalogueService.getBasketLblistvo(basketvo);
//		model.addAttribute("getBasketIplistvo", getBasketLblistvo);
//
//		//장바구니 서비스 백업 리스트 가져오기
//		List<CustomReqBasketVO> getBasketBaklistvo = reqCatalogueService.getBasketBaklistvo(basketvo);
//		model.addAttribute("getBasketBaklistvo", getBasketBaklistvo);
//
//		//장바구니 서비스 리스트 가져오기
//		List<CustomReqBasketVO> getBasketServicelistvo = reqCatalogueService.getBasketServicelistvo(basketvo);
//		model.addAttribute("getBasketServicelistvo", getBasketServicelistvo);
//
//		//장바구니 서비스 대외계 리스트 가져오기
//		List<CustomReqBasketVO> getBasketMcalistvo = reqCatalogueService.getBasketMcalistvo(basketvo);
//		model.addAttribute("getBasketMcalistvo", getBasketMcalistvo);
//
//		//장바구니 서비스 형상관리 리스트 가져오기
//		List<CustomReqBasketVO> getBasketScmlistvo = reqCatalogueService.getBasketScmlistvo(basketvo);
//		model.addAttribute("getBasketScmlistvo", getBasketScmlistvo);
//
//		//장바구니 서비스 보안관제 리스트 가져오기
//		List<CustomReqBasketVO> getBasketSerlistvo = reqCatalogueService.getBasketSerlistvo(basketvo);
//		model.addAttribute("getBasketSerlistvo", getBasketSerlistvo);
//
//		RedirectView rv = new RedirectView("basketOrder.do");
//		rv.setExposeModelAttributes(false);
//		return rv;
//	}

	// 공인 IP 해지 신청 장바구니 페이지 이동 및 장바구니 테이블 입력
//	@RequestMapping(value = "/basketOrder.do",params="type=noworderipexpr")
//	public RedirectView cataloguebasketIpOrder(HttpServletRequest request, Model model,CustomReqCatalogueVO ordervo ){
//
//		//bss_basket
//		String basketSeq = DateFormatUtils.format(new Date(), "yyyyMMddHHmmss");
//		String requestType = "REQTYPE_EXPR";
//
//		CustomReqBasketVO basketvo = new CustomReqBasketVO();
//		basketvo.setBasketSeq(basketSeq);
//		basketvo.setUserId(request.getUserPrincipal().getName());
//		basketvo.setRequestType(requestType);
//		basketvo.setProductCategory(request.getParameter("ipproductCategory"));
//
//		if(basketvo.getProductCategory().equals("PRODCATE_PUBLICIP")){
//
//			String basketSummary = "";
//			basketvo.setOnDemandFlag("N");
//			String applyDatetime = "";
//			if(ordervo.getOnDemandFlag().equals("N")){
//				applyDatetime =		request.getParameter("ip_expr_applyDate") +" "+ request.getParameter("ip_expr_tab_applyTime") +":00";
//			}
//			basketSummary ="<table><colgroup><col width='30%'><col width='70%'></colgroup><tbody>";
//			basketSummary = basketSummary +"<tr><td class='left'>서비스시작일시</td><td>"+applyDatetime+"</td></tr>";
//			basketSummary = basketSummary +"<tr><td class='left'>프로젝트</td><td>"+request.getParameter("ipprojectAlias")+" </td></tr>";
//			basketSummary = basketSummary +"<tr><td class='left'>가상서버</td><td>"+request.getParameter("ipvmName")+" </td></tr>";
//			basketSummary = basketSummary +"<tr><td class='left'>비고</td><td>"+request.getParameter("ipdescription")+"</td></tr>";
//			basketSummary = basketSummary +"<tr><td colspan='2' class='tar f18 fc-red'>"+request.getParameter("iptotalPrice")+" <span class='f12 fc66'>원</span></td></tr>";
//			basketSummary = basketSummary +"</tbody></table>";
//
//			basketvo.setBasketSummary(basketSummary);
//			basketvo.setHourlyFlag("N");
//			basketvo.setAmount(request.getParameter("iptotalPrice"));
//
//			basketvo.setVmUuid(request.getParameter("ipvmUuid"));
//			basketvo.setCatalogSeq(request.getParameter("ipcatalogSeq"));
//
//			basketvo.setApplyDatetime(applyDatetime);
//			basketvo.setProjectId(request.getParameter("ipprojectId"));
//
//			//basketvo.setDiskGb(ordervo.getDiskcnt());
//
//			basketvo.setPublicipProductSeq(request.getParameter("ipproductSeq"));
//
//			basketvo.setDescription(request.getParameter("ipdescription"));
//			basketvo.setPublicipId(request.getParameter("publicipId"));
//
//
//			reqCatalogueService.setBasket(basketvo);
//			reqCatalogueService.setBasketIp(basketvo);
//
//		}
//
//		//장바구니 vm 리스트 가져오기
//		List<CustomReqBasketVO> getBasketlistvo = reqCatalogueService.getBasketlist(basketvo);
//		String networkChk ="";
//		for (int i = 0; i < getBasketlistvo.size(); i++) {
//			List<CustomReqBasketVO> getBasketVmList = reqCatalogueService.getBasketVmList(getBasketlistvo.get(i).getBasketSeq());
//			for (int j = 0; j < getBasketVmList.size(); j++) {
//				networkChk = getBasketVmList.get(j).getSharedNetwork();
//				networkChk = networkChk+":"+getBasketVmList.get(j).getSharedNetworkName();
//				networkChk = networkChk+":"+getBasketVmList.get(j).getSelectedFlag();
//				getBasketlistvo.get(i).setNetworkChk(networkChk);
//				log.debug("networkChk : "+ networkChk);
//				networkChk="";
//			}
//		}
//		model.addAttribute("getBasketlistvo", getBasketlistvo);
//
//		//장바구니 블록디스크 리스트 가져오기
//		List<CustomReqBasketVO> getBasketDisklistvo = reqCatalogueService.getBasketDisklistvo(basketvo);
//		model.addAttribute("getBasketDisklistvo", getBasketDisklistvo);
//
//		//장바구니 NAS 리스트 가져오기
//		List<CustomReqBasketVO> getBasketNaslistvo = reqCatalogueService.getBasketNaslistvo(basketvo);
//		model.addAttribute("getBasketNaslistvo", getBasketNaslistvo);
//
//		//장바구니 IP 리스트 가져오기
//		List<CustomReqBasketVO> getBasketIplistvo = reqCatalogueService.getBasketIplistvo(basketvo);
//		model.addAttribute("getBasketIplistvo", getBasketIplistvo);
//
//		//장바구니 로드 밸런서 리스트 가져오기
//		List<CustomReqBasketVO> getBasketLblistvo = reqCatalogueService.getBasketLblistvo(basketvo);
//
//
//		model.addAttribute("getBasketIplistvo", getBasketLblistvo);
//
//		//장바구니 서비스 백업 리스트 가져오기
//		List<CustomReqBasketVO> getBasketBaklistvo = reqCatalogueService.getBasketBaklistvo(basketvo);
//		model.addAttribute("getBasketBaklistvo", getBasketBaklistvo);
//
//		//장바구니 서비스 리스트 가져오기
//		List<CustomReqBasketVO> getBasketServicelistvo = reqCatalogueService.getBasketServicelistvo(basketvo);
//		model.addAttribute("getBasketServicelistvo", getBasketServicelistvo);
//
//		//장바구니 서비스 대외계 리스트 가져오기
//		List<CustomReqBasketVO> getBasketMcalistvo = reqCatalogueService.getBasketMcalistvo(basketvo);
//		model.addAttribute("getBasketMcalistvo", getBasketMcalistvo);
//
//		//장바구니 서비스 형상관리 리스트 가져오기
//		List<CustomReqBasketVO> getBasketScmlistvo = reqCatalogueService.getBasketScmlistvo(basketvo);
//		model.addAttribute("getBasketScmlistvo", getBasketScmlistvo);
//
//		//장바구니 서비스 보안관제 리스트 가져오기
//		List<CustomReqBasketVO> getBasketSerlistvo = reqCatalogueService.getBasketSerlistvo(basketvo);
//		model.addAttribute("getBasketSerlistvo", getBasketSerlistvo);
//
//		RedirectView rv = new RedirectView("basketOrder.do");
//		rv.setExposeModelAttributes(false);
//		return rv;
//	}

	// 백업 서비스 해지 신청 장바구니 페이지 이동 및 장바구니 테이블 입력
//	@RequestMapping(value = "/basketOrder.do",params="type=noworderexpr")
//	public RedirectView cataloguebasketBakOrder(HttpServletRequest request, Model model,CustomReqCatalogueVO ordervo ){
//
//		//bss_basket
//		String basketSeq = DateFormatUtils.format(new Date(), "yyyyMMddHHmmss");
//		String requestType = "REQTYPE_EXPR";
//
//		CustomReqBasketVO basketvo = new CustomReqBasketVO();
//		basketvo.setBasketSeq(basketSeq);
//		basketvo.setUserId(request.getUserPrincipal().getName());
//		basketvo.setRequestType(requestType);
//		basketvo.setProductCategory(request.getParameter("productCategory"));
//
//		if(basketvo.getProductCategory().equals("PRODCATE_BACKUP")){
//
//			String basketSummary = "";
//			basketvo.setOnDemandFlag("N");
//			String applyDatetime = "";
//			if(ordervo.getOnDemandFlag().equals("N")){
//				applyDatetime =		request.getParameter("back_expr_applyDate") +" "+ request.getParameter("back_expr_tab_applyTime") +":00";
//			}
//			basketSummary ="<table><colgroup><col width='30%'><col width='70%'></colgroup><tbody>";
//			basketSummary = basketSummary +"<tr><td class='left'>서비스시작일시</td><td>"+applyDatetime+"</td></tr>";
//			basketSummary = basketSummary +"<tr><td class='left'>프로젝트</td><td>"+request.getParameter("projectAlias")+" </td></tr>";
//			basketSummary = basketSummary +"<tr><td class='left'>비고</td><td>"+request.getParameter("bakdescription")+"</td></tr>";
//			basketSummary = basketSummary +"<tr><td colspan='2' class='tar f18 fc-red'>"+request.getParameter("totalPrice")+"<span class='f12 fc66'>원</span></td></tr>";
//			basketSummary = basketSummary +"</tbody></table>";
//
//			basketvo.setBasketSummary(basketSummary);
//			basketvo.setHourlyFlag("N");
//			basketvo.setAmount(request.getParameter("totalPrice"));
//
//			basketvo.setCatalogSeq(request.getParameter("catalogSeq"));
//
//			basketvo.setApplyDatetime(applyDatetime);
//			basketvo.setProjectId(request.getParameter("projectId"));
//			basketvo.setVmUuid(request.getParameter("vmUuid"));
//
//			basketvo.setProductSeq(request.getParameter("productSeq"));
//			basketvo.setDescription(request.getParameter("bakdescription"));
//			basketvo.setBackupId(request.getParameter("backupId"));
//
//			reqCatalogueService.setBasket(basketvo);
//			reqCatalogueService.setBasketBak(basketvo);
//		}
//
//		//장바구니 vm 리스트 가져오기
//		List<CustomReqBasketVO> getBasketlistvo = reqCatalogueService.getBasketlist(basketvo);
//		String networkChk ="";
//		for (int i = 0; i < getBasketlistvo.size(); i++) {
//			List<CustomReqBasketVO> getBasketVmList = reqCatalogueService.getBasketVmList(getBasketlistvo.get(i).getBasketSeq());
//			for (int j = 0; j < getBasketVmList.size(); j++) {
//				networkChk = getBasketVmList.get(j).getSharedNetwork();
//				networkChk = networkChk+":"+getBasketVmList.get(j).getSharedNetworkName();
//				networkChk = networkChk+":"+getBasketVmList.get(j).getSelectedFlag();
//				getBasketlistvo.get(i).setNetworkChk(networkChk);
//				log.debug("networkChk : "+ networkChk);
//				networkChk="";
//			}
//		}
//		model.addAttribute("getBasketlistvo", getBasketlistvo);
//
//		//장바구니 블록디스크 리스트 가져오기
//		List<CustomReqBasketVO> getBasketDisklistvo = reqCatalogueService.getBasketDisklistvo(basketvo);
//		model.addAttribute("getBasketDisklistvo", getBasketDisklistvo);
//
//		//장바구니 NAS 리스트 가져오기
//		List<CustomReqBasketVO> getBasketNaslistvo = reqCatalogueService.getBasketNaslistvo(basketvo);
//		model.addAttribute("getBasketNaslistvo", getBasketNaslistvo);
//
//		//장바구니 IP 리스트 가져오기
//		List<CustomReqBasketVO> getBasketIplistvo = reqCatalogueService.getBasketIplistvo(basketvo);
//		model.addAttribute("getBasketIplistvo", getBasketIplistvo);
//
//		//장바구니 로드 밸런서 리스트 가져오기
//		List<CustomReqBasketVO> getBasketLblistvo = reqCatalogueService.getBasketLblistvo(basketvo);
//
//
//		model.addAttribute("getBasketIplistvo", getBasketLblistvo);
//
//		//장바구니 서비스 백업 리스트 가져오기
//		List<CustomReqBasketVO> getBasketBaklistvo = reqCatalogueService.getBasketBaklistvo(basketvo);
//		model.addAttribute("getBasketBaklistvo", getBasketBaklistvo);
//
//		//장바구니 서비스 리스트 가져오기
//		List<CustomReqBasketVO> getBasketServicelistvo = reqCatalogueService.getBasketServicelistvo(basketvo);
//		model.addAttribute("getBasketServicelistvo", getBasketServicelistvo);
//
//		//장바구니 서비스 대외계 리스트 가져오기
//		List<CustomReqBasketVO> getBasketMcalistvo = reqCatalogueService.getBasketMcalistvo(basketvo);
//		model.addAttribute("getBasketMcalistvo", getBasketMcalistvo);
//
//		//장바구니 서비스 형상관리 리스트 가져오기
//		List<CustomReqBasketVO> getBasketScmlistvo = reqCatalogueService.getBasketScmlistvo(basketvo);
//		model.addAttribute("getBasketScmlistvo", getBasketScmlistvo);
//
//		//장바구니 서비스 보안관제 리스트 가져오기
//		List<CustomReqBasketVO> getBasketSerlistvo = reqCatalogueService.getBasketSerlistvo(basketvo);
//		model.addAttribute("getBasketSerlistvo", getBasketSerlistvo);
//
//		RedirectView rv = new RedirectView("basketOrder.do");
//		rv.setExposeModelAttributes(false);
//		return rv;
//	}

	// 대외계 서비스 해지 신청 장바구니 페이지 이동 및 장바구니 테이블 입력
//	@RequestMapping(value = "/basketOrder.do",params="type=nowordermcaexpr")
//	public RedirectView cataloguebasketMcaOrder(HttpServletRequest request, Model model,CustomReqCatalogueVO ordervo ){
//
//			//bss_basket
//			String basketSeq = DateFormatUtils.format(new Date(), "yyyyMMddHHmmss");
//			String requestType = "REQTYPE_EXPR";
//
//			CustomReqBasketVO basketvo = new CustomReqBasketVO();
//			basketvo.setBasketSeq(basketSeq);
//			basketvo.setUserId(request.getUserPrincipal().getName());
//			basketvo.setRequestType(requestType);
//			basketvo.setProductCategory(request.getParameter("mcaproductCategory"));
//
//			if(basketvo.getProductCategory().equals("PRODCATE_MCA")){
//
//				String basketSummary = "";
//				basketvo.setOnDemandFlag("N");
//				String applyDatetime = "";
//				if(ordervo.getOnDemandFlag().equals("N")){
//					applyDatetime =		request.getParameter("mca_expr_applyDate") +" "+ request.getParameter("mca_expr_tab_applyTime") +":00";
//				}
//				basketSummary ="<table><colgroup><col width='30%'><col width='70%'></colgroup><tbody>";
//				basketSummary = basketSummary +"<tr><td class='left'>서비스시작일시</td><td>"+applyDatetime+"</td></tr>";
//				basketSummary = basketSummary +"<tr><td class='left'>프로젝트</td><td>"+request.getParameter("mcaprojectAlias")+" </td></tr>";
//				basketSummary = basketSummary +"<tr><td class='left'>비고</td><td>"+request.getParameter("mcadescription")+"</td></tr>";
//				basketSummary = basketSummary +"<tr><td colspan='2' class='tar f18 fc-red'>"+request.getParameter("mcatotalPrice")+"<span class='f12 fc66'>원</span></td></tr>";
//				basketSummary = basketSummary +"</tbody></table>";
//
//				basketvo.setBasketSummary(basketSummary);
//				basketvo.setHourlyFlag("N");
//				basketvo.setAmount(request.getParameter("mcatotalPrice"));
//
//				basketvo.setCatalogSeq(request.getParameter("mcacatalogSeq"));
//
//				basketvo.setApplyDatetime(applyDatetime);
//				basketvo.setProjectId(request.getParameter("mcaprojectId"));
//
//				basketvo.setProductSeq(request.getParameter("mcaproductSeq"));
//				basketvo.setDescription(request.getParameter("mcadescription"));
//				basketvo.setMcaId(request.getParameter("mcaId"));
//
//				reqCatalogueService.setBasket(basketvo);
//				reqCatalogueService.setBasketMca(basketvo);
//
//			}
//
//			//장바구니 vm 리스트 가져오기
//			List<CustomReqBasketVO> getBasketlistvo = reqCatalogueService.getBasketlist(basketvo);
//			String networkChk ="";
//			for (int i = 0; i < getBasketlistvo.size(); i++) {
//				List<CustomReqBasketVO> getBasketVmList = reqCatalogueService.getBasketVmList(getBasketlistvo.get(i).getBasketSeq());
//				for (int j = 0; j < getBasketVmList.size(); j++) {
//					networkChk = getBasketVmList.get(j).getSharedNetwork();
//					networkChk = networkChk+":"+getBasketVmList.get(j).getSharedNetworkName();
//					networkChk = networkChk+":"+getBasketVmList.get(j).getSelectedFlag();
//					getBasketlistvo.get(i).setNetworkChk(networkChk);
//					log.debug("networkChk : "+ networkChk);
//					networkChk="";
//				}
//			}
//			model.addAttribute("getBasketlistvo", getBasketlistvo);
//
//			//장바구니 블록디스크 리스트 가져오기
//			List<CustomReqBasketVO> getBasketDisklistvo = reqCatalogueService.getBasketDisklistvo(basketvo);
//			model.addAttribute("getBasketDisklistvo", getBasketDisklistvo);
//
//			//장바구니 NAS 리스트 가져오기
//			List<CustomReqBasketVO> getBasketNaslistvo = reqCatalogueService.getBasketNaslistvo(basketvo);
//			model.addAttribute("getBasketNaslistvo", getBasketNaslistvo);
//
//			//장바구니 IP 리스트 가져오기
//			List<CustomReqBasketVO> getBasketIplistvo = reqCatalogueService.getBasketIplistvo(basketvo);
//			model.addAttribute("getBasketIplistvo", getBasketIplistvo);
//
//			//장바구니 로드 밸런서 리스트 가져오기
//			List<CustomReqBasketVO> getBasketLblistvo = reqCatalogueService.getBasketLblistvo(basketvo);
//
//
//			model.addAttribute("getBasketIplistvo", getBasketLblistvo);
//
//			//장바구니 서비스 백업 리스트 가져오기
//			List<CustomReqBasketVO> getBasketBaklistvo = reqCatalogueService.getBasketBaklistvo(basketvo);
//			model.addAttribute("getBasketBaklistvo", getBasketBaklistvo);
//
//			//장바구니 서비스 리스트 가져오기
//			List<CustomReqBasketVO> getBasketServicelistvo = reqCatalogueService.getBasketServicelistvo(basketvo);
//			model.addAttribute("getBasketServicelistvo", getBasketServicelistvo);
//
//			//장바구니 서비스 대외계 리스트 가져오기
//			List<CustomReqBasketVO> getBasketMcalistvo = reqCatalogueService.getBasketMcalistvo(basketvo);
//			model.addAttribute("getBasketMcalistvo", getBasketMcalistvo);
//
//			//장바구니 서비스 형상관리 리스트 가져오기
//			List<CustomReqBasketVO> getBasketScmlistvo = reqCatalogueService.getBasketScmlistvo(basketvo);
//			model.addAttribute("getBasketScmlistvo", getBasketScmlistvo);
//
//			//장바구니 서비스 보안관제 리스트 가져오기
//			List<CustomReqBasketVO> getBasketSerlistvo = reqCatalogueService.getBasketSerlistvo(basketvo);
//			model.addAttribute("getBasketSerlistvo", getBasketSerlistvo);
//
//			RedirectView rv = new RedirectView("basketOrder.do");
//			rv.setExposeModelAttributes(false);
//			return rv;
//	}

	// 형상관리 서비스 해지 신청 장바구니 페이지 이동 및 장바구니 테이블 입력
//	@RequestMapping(value = "/basketOrder.do",params="type=noworderscmexpr")
//	public RedirectView cataloguebasketScmOrder(HttpServletRequest request, Model model,CustomReqCatalogueVO ordervo ){
//
//			//bss_basket
//			String basketSeq = DateFormatUtils.format(new Date(), "yyyyMMddHHmmss");
//			String requestType = "REQTYPE_EXPR";
//
//			CustomReqBasketVO basketvo = new CustomReqBasketVO();
//			basketvo.setBasketSeq(basketSeq);
//			basketvo.setUserId(request.getUserPrincipal().getName());
//			basketvo.setRequestType(requestType);
//			basketvo.setProductCategory(request.getParameter("scmproductCategory"));
//
//			if(basketvo.getProductCategory().equals("PRODCATE_SCM")){
//
//				String basketSummary = "";
//				basketvo.setOnDemandFlag("N");
//				String applyDatetime = "";
//				if(ordervo.getOnDemandFlag().equals("N")){
//					applyDatetime =		request.getParameter("scm_expr_applyDate") +" "+ request.getParameter("scm_expr_tab_applyTime") +":00";
//				}
//				basketSummary ="<table><colgroup><col width='30%'><col width='70%'></colgroup><tbody>";
//				basketSummary = basketSummary +"<tr><td class='left'>서비스시작일시</td><td>"+applyDatetime+"</td></tr>";
//				basketSummary = basketSummary +"<tr><td class='left'>프로젝트</td><td>"+request.getParameter("scmprojectAlias")+" </td></tr>";
//				basketSummary = basketSummary +"<tr><td class='left'>비고</td><td>"+request.getParameter("scmdescription")+"</td></tr>";
//				basketSummary = basketSummary +"<tr><td colspan='2' class='tar f18 fc-red'>"+request.getParameter("scmtotalPrice")+"<span class='f12 fc66'>원</span></td></tr>";
//				basketSummary = basketSummary +"</tbody></table>";
//
//				basketvo.setBasketSummary(basketSummary);
//				basketvo.setHourlyFlag("N");
//				basketvo.setAmount(request.getParameter("scmtotalPrice"));
//
//				basketvo.setCatalogSeq(request.getParameter("scmcatalogSeq"));
//
//				basketvo.setApplyDatetime(applyDatetime);
//				basketvo.setProjectId(request.getParameter("scmprojectId"));
//
//				basketvo.setProductSeq(request.getParameter("scmproductSeq"));
//				basketvo.setDescription(request.getParameter("scmdescription"));
//				basketvo.setScmId(request.getParameter("scmId"));
//
//				reqCatalogueService.setBasket(basketvo);
//				reqCatalogueService.setBasketScm(basketvo);
//
//			}
//
//			//장바구니 vm 리스트 가져오기
//			List<CustomReqBasketVO> getBasketlistvo = reqCatalogueService.getBasketlist(basketvo);
//			String networkChk ="";
//			for (int i = 0; i < getBasketlistvo.size(); i++) {
//				List<CustomReqBasketVO> getBasketVmList = reqCatalogueService.getBasketVmList(getBasketlistvo.get(i).getBasketSeq());
//				for (int j = 0; j < getBasketVmList.size(); j++) {
//					networkChk = getBasketVmList.get(j).getSharedNetwork();
//					networkChk = networkChk+":"+getBasketVmList.get(j).getSharedNetworkName();
//					networkChk = networkChk+":"+getBasketVmList.get(j).getSelectedFlag();
//					getBasketlistvo.get(i).setNetworkChk(networkChk);
//					log.debug("networkChk : "+ networkChk);
//					networkChk="";
//				}
//			}
//			model.addAttribute("getBasketlistvo", getBasketlistvo);
//
//			//장바구니 블록디스크 리스트 가져오기
//			List<CustomReqBasketVO> getBasketDisklistvo = reqCatalogueService.getBasketDisklistvo(basketvo);
//			model.addAttribute("getBasketDisklistvo", getBasketDisklistvo);
//
//			//장바구니 NAS 리스트 가져오기
//			List<CustomReqBasketVO> getBasketNaslistvo = reqCatalogueService.getBasketNaslistvo(basketvo);
//			model.addAttribute("getBasketNaslistvo", getBasketNaslistvo);
//
//			//장바구니 IP 리스트 가져오기
//			List<CustomReqBasketVO> getBasketIplistvo = reqCatalogueService.getBasketIplistvo(basketvo);
//			model.addAttribute("getBasketIplistvo", getBasketIplistvo);
//
//			//장바구니 로드 밸런서 리스트 가져오기
//			List<CustomReqBasketVO> getBasketLblistvo = reqCatalogueService.getBasketLblistvo(basketvo);
//
//
//			model.addAttribute("getBasketIplistvo", getBasketLblistvo);
//
//			//장바구니 서비스 백업 리스트 가져오기
//			List<CustomReqBasketVO> getBasketBaklistvo = reqCatalogueService.getBasketBaklistvo(basketvo);
//			model.addAttribute("getBasketBaklistvo", getBasketBaklistvo);
//
//			//장바구니 서비스 리스트 가져오기
//			List<CustomReqBasketVO> getBasketServicelistvo = reqCatalogueService.getBasketServicelistvo(basketvo);
//			model.addAttribute("getBasketServicelistvo", getBasketServicelistvo);
//
//			//장바구니 서비스 대외계 리스트 가져오기
//			List<CustomReqBasketVO> getBasketMcalistvo = reqCatalogueService.getBasketMcalistvo(basketvo);
//			model.addAttribute("getBasketMcalistvo", getBasketMcalistvo);
//
//			//장바구니 서비스 형상관리 리스트 가져오기
//			List<CustomReqBasketVO> getBasketScmlistvo = reqCatalogueService.getBasketScmlistvo(basketvo);
//			model.addAttribute("getBasketScmlistvo", getBasketScmlistvo);
//
//			//장바구니 서비스 보안관제 리스트 가져오기
//			List<CustomReqBasketVO> getBasketSerlistvo = reqCatalogueService.getBasketSerlistvo(basketvo);
//			model.addAttribute("getBasketSerlistvo", getBasketSerlistvo);
//
//
//			RedirectView rv = new RedirectView("basketOrder.do");
//			rv.setExposeModelAttributes(false);
//			//return "redirect:basketOrder.do";
//			return rv;
//	}

	// 보안관제 서비스 해지 신청 장바구니 페이지 이동 및 장바구니 테이블 입력
//	@RequestMapping(value = "/basketOrder.do",params="type=noworderscrexpr")
//	public RedirectView cataloguebasketScrOrder(HttpServletRequest request, Model model,CustomReqCatalogueVO ordervo ){
//
//			//bss_basket
//			String basketSeq = DateFormatUtils.format(new Date(), "yyyyMMddHHmmss");
//			String requestType = "REQTYPE_EXPR";
//
//			CustomReqBasketVO basketvo = new CustomReqBasketVO();
//			basketvo.setBasketSeq(basketSeq);
//			basketvo.setUserId(request.getUserPrincipal().getName());
//			basketvo.setRequestType(requestType);
//			basketvo.setProductCategory(request.getParameter("scrproductCategory"));
//
//			if(basketvo.getProductCategory().equals("PRODCATE_SECURITY")){
//
//				String basketSummary = "";
//				basketvo.setOnDemandFlag("N");
//				String applyDatetime = "";
//				if(ordervo.getOnDemandFlag().equals("N")){
//					applyDatetime =		request.getParameter("scr_expr_applyDate") +" "+ request.getParameter("scr_expr_tab_applyTime") +":00";
//				}
//				basketSummary ="<table><colgroup><col width='30%'><col width='70%'></colgroup><tbody>";
//				basketSummary = basketSummary +"<tr><td class='left'>서비스시작일시</td><td>"+applyDatetime+"</td></tr>";
//				basketSummary = basketSummary +"<tr><td class='left'>프로젝트</td><td>"+request.getParameter("scrprojectAlias")+" </td></tr>";
//				basketSummary = basketSummary +"<tr><td class='left'>비고</td><td>"+request.getParameter("scrdescription")+"</td></tr>";
//				basketSummary = basketSummary +"<tr><td colspan='2' class='tar f18 fc-red'>"+request.getParameter("scrtotalPrice")+"<span class='f12 fc66'>원</span></td></tr>";
//				basketSummary = basketSummary +"</tbody></table>";
//
//				basketvo.setBasketSummary(basketSummary);
//				basketvo.setHourlyFlag("N");
//				basketvo.setAmount(request.getParameter("scrtotalPrice"));
//
//				basketvo.setCatalogSeq(request.getParameter("scrcatalogSeq"));
//
//				basketvo.setApplyDatetime(applyDatetime);
//				basketvo.setProjectId(request.getParameter("scrprojectId"));
//
//				basketvo.setProductSeq(request.getParameter("scrproductSeq"));
//				basketvo.setDescription(request.getParameter("scrdescription"));
//				basketvo.setSecurityId(request.getParameter("securityId"));
//
//				reqCatalogueService.setBasket(basketvo);
//				reqCatalogueService.setBasketScr(basketvo);
//
//			}
//
//			//장바구니 vm 리스트 가져오기
//			List<CustomReqBasketVO> getBasketlistvo = reqCatalogueService.getBasketlist(basketvo);
//			String networkChk ="";
//			for (int i = 0; i < getBasketlistvo.size(); i++) {
//				List<CustomReqBasketVO> getBasketVmList = reqCatalogueService.getBasketVmList(getBasketlistvo.get(i).getBasketSeq());
//				for (int j = 0; j < getBasketVmList.size(); j++) {
//					networkChk = getBasketVmList.get(j).getSharedNetwork();
//					networkChk = networkChk+":"+getBasketVmList.get(j).getSharedNetworkName();
//					networkChk = networkChk+":"+getBasketVmList.get(j).getSelectedFlag();
//					getBasketlistvo.get(i).setNetworkChk(networkChk);
//					log.debug("networkChk : "+ networkChk);
//					networkChk="";
//				}
//			}
//			model.addAttribute("getBasketlistvo", getBasketlistvo);
//
//			//장바구니 블록디스크 리스트 가져오기
//			List<CustomReqBasketVO> getBasketDisklistvo = reqCatalogueService.getBasketDisklistvo(basketvo);
//			model.addAttribute("getBasketDisklistvo", getBasketDisklistvo);
//
//			//장바구니 NAS 리스트 가져오기
//			List<CustomReqBasketVO> getBasketNaslistvo = reqCatalogueService.getBasketNaslistvo(basketvo);
//			model.addAttribute("getBasketNaslistvo", getBasketNaslistvo);
//
//			//장바구니 IP 리스트 가져오기
//			List<CustomReqBasketVO> getBasketIplistvo = reqCatalogueService.getBasketIplistvo(basketvo);
//			model.addAttribute("getBasketIplistvo", getBasketIplistvo);
//
//			//장바구니 로드 밸런서 리스트 가져오기
//			List<CustomReqBasketVO> getBasketLblistvo = reqCatalogueService.getBasketLblistvo(basketvo);
//
//
//			model.addAttribute("getBasketIplistvo", getBasketLblistvo);
//
//			//장바구니 서비스 백업 리스트 가져오기
//			List<CustomReqBasketVO> getBasketBaklistvo = reqCatalogueService.getBasketBaklistvo(basketvo);
//			model.addAttribute("getBasketBaklistvo", getBasketBaklistvo);
//
//			//장바구니 서비스 리스트 가져오기
//			List<CustomReqBasketVO> getBasketServicelistvo = reqCatalogueService.getBasketServicelistvo(basketvo);
//			model.addAttribute("getBasketServicelistvo", getBasketServicelistvo);
//
//			//장바구니 서비스 대외계 리스트 가져오기
//			List<CustomReqBasketVO> getBasketMcalistvo = reqCatalogueService.getBasketMcalistvo(basketvo);
//			model.addAttribute("getBasketMcalistvo", getBasketMcalistvo);
//
//			//장바구니 서비스 형상관리 리스트 가져오기
//			List<CustomReqBasketVO> getBasketScmlistvo = reqCatalogueService.getBasketScmlistvo(basketvo);
//			model.addAttribute("getBasketScmlistvo", getBasketScmlistvo);
//
//			//장바구니 서비스 보안관제 리스트 가져오기
//			List<CustomReqBasketVO> getBasketSerlistvo = reqCatalogueService.getBasketSerlistvo(basketvo);
//			model.addAttribute("getBasketSerlistvo", getBasketSerlistvo);
//
//
//			RedirectView rv = new RedirectView("basketOrder.do");
//			rv.setExposeModelAttributes(false);
//			//return "redirect:basketOrder.do";
//			return rv;
//	}

	// 카테고리 상품 장바구니 페이지 이동 및 장바구니 테이블 입력
	@RequestMapping(value = "/basketOrder2.do", params = "type=noworderinsert")
	public ResponseEntity<Object> cataloguebasketOrder2(HttpServletRequest request, Model model,
			CustomReqCatalogueVO ordervo) {

		// 프로젝트 체크
		CustomReqBasketCountVO customReqBasketCountVO = new CustomReqBasketCountVO();
		ordervo.setUserId(request.getUserPrincipal().getName());
		customReqBasketCountVO = reqCatalogueService.checkProject(ordervo);
		int vmCount = Integer.parseInt(customReqBasketCountVO.getVmCount());
		int DiskCount = Integer.parseInt(customReqBasketCountVO.getDiskCount());
		int ServiceCount = Integer.parseInt(customReqBasketCountVO.getServiceCount());
		if (vmCount + DiskCount + ServiceCount > 0) {
			String res = "2";
			return new ResponseEntity<Object>(res, HttpStatus.OK);
		}
		// bss_basket
		String basketSeq = DateFormatUtils.format(new Date(), "yyyyMMddHHmmss");
		String requestType = "REQTYPE_NEW";

		CustomReqBasketVO basketvo = new CustomReqBasketVO();
		basketvo.setBasketSeq(basketSeq);
		basketvo.setUserId(request.getUserPrincipal().getName());
		basketvo.setRequestType(requestType);
		basketvo.setProductCategory(ordervo.getProductCategory());
		basketvo.setServiceType(ordervo.getServiceType());
		basketvo.setDescription(ordervo.getDescription());
		basketvo.setVmUuid(ordervo.getVmUuid());
		basketvo.setServiceName(ordervo.getProductName());
		basketvo.setCloudId(ordervo.getCloudId());
		basketvo.setCloudType(ordervo.getCloudType());

		if (ordervo.getProductCategory().equals("PRODCATE_VM")) {
			// 가상머신 상품
			String basketSummary = "";
			basketvo.setOnDemandFlag(ordervo.getOnDemandFlag());
			String applyDatetime = "";
			if (ordervo.getOnDemandFlag().equals("N")) {
				applyDatetime = ordervo.getApplyDate() + " " + ordervo.getApplyTime() + ":00";
			}
			basketSummary = "<hr />";
			basketSummary = basketSummary + "<table><colgroup><col width='30%'><col width='70%'></colgroup><tbody>";
			basketSummary = basketSummary + "<tr><td class='left'>신청자원</td><td>가상서버</td></tr>";
			// basketSummary = basketSummary +"<tr><td
			// class='left'>서비스시작일시</td><td>"+applyDatetime+"</td></tr>";
			basketSummary = basketSummary + "<tr><td class='left'>프로젝트</td><td>" + ordervo.getProjectName()
					+ " </td></tr>";
			basketSummary = basketSummary + "<tr><td class='left'>네트워크</td><td>" + ordervo.getAzName() + " </td></tr>";
			basketSummary = basketSummary + "<tr><td class='left'>서버명</td><td>" + ordervo.getHostnameAlias()
					+ "</td></tr>";
			// basketSummary = basketSummary +"<tr><td class='left'>HOST
			// ALIAS</td><td>"+ordervo.getHostnameAlias()+"</td></tr>";
			basketSummary = basketSummary + "<tr><td class='left'>CPU</td><td>" + ordervo.getCpucnt()
					+ " vCPU</td></tr>";
			basketSummary = basketSummary + "<tr><td class='left'>MEM</td><td>" + ordervo.getMemcnt() + " GB</td></tr>";
			basketSummary = basketSummary + "<tr><td class='left'>DISK</td><td>" + ordervo.getDiskcnt()
					+ " GB </td></tr>";
			if (ordervo.getDescription() != null) {
				basketSummary = basketSummary + "<tr><td class='left'>요청사항</td><td>" + ordervo.getDescription()
						+ "</td></tr>";
			}
			// basketSummary = basketSummary +"<tr><td
			// class='left'>아이디</td><td>appuser</td></tr>";
			// basketSummary = basketSummary +"<tr><td
			// class='left'>패스워드</td><td>kepco123/456</td></tr>";
			// basketSummary = basketSummary +"<tr><td colspan='2' class='tar f18
			// fc-red'>"+ordervo.getTotalPrice()+" <span class='f12
			// fc66'>원</span></td></tr>";
			basketSummary = basketSummary + "</tbody></table>";

			basketvo.setBasketSummary(basketSummary);
			basketvo.setHourlyFlag(ordervo.getHourlyFlag());
			basketvo.setAmount(ordervo.getTotalPrice());

			// bss_basket_vm
			// String defaultNetworkId = "";

			basketvo.setApplyDatetime(applyDatetime);
			basketvo.setProjectId(ordervo.getProjectId());
			basketvo.setDefaultNetworkId(ordervo.getNetworkId());
			basketvo.setDefaultNetworkName(ordervo.getDefaultNetworkName());
			basketvo.setDefaultNetworkAlias(ordervo.getDefaultNetworkAlias());
			basketvo.setHostname(ordervo.getHostname());
			basketvo.setHostnameAlias(ordervo.getHostnameAlias());
			basketvo.setVcpus(ordervo.getCpucnt());
			basketvo.setMemGb(ordervo.getMemcnt());
			basketvo.setDiskGb(ordervo.getDiskcnt());
			basketvo.setVolumeType(ordervo.getVolumeType());
			basketvo.setVmProductSeq(ordervo.getProductSeq());
			basketvo.setOsProductSeq(ordervo.getOsProductSeq());
			basketvo.setDescription(ordervo.getDescription());
			basketvo.setCatalogSeq(ordervo.getCatalogSeq());

			basketvo.setInstanceType(ordervo.getInstanceType());

			basketvo.setBackupNetworkFlag(ordervo.getBackupNetworkFlag());
			basketvo.setFlavorId(ordervo.getFlavorId());
			basketvo.setAzName(ordervo.getAzName());
			basketvo.setReqMessage(ordervo.getReqMessage());
			basketvo.setDatastoreId(ordervo.getDatastoreId());
			basketvo.setImageId(ordervo.getOsProductSeq());


			CustomReqOrderVO ov = new CustomReqOrderVO();
			ov.setProjectBoxId(ordervo.getProjectBoxId());
			ov.setOsProductSeq(ordervo.getOsProductSeq());
			ov.setCloudId(basketvo.getCloudId());

			String projectId = reqCatalogueService.detailProjectId(ov);
			basketvo.setProjectId(projectId);
			reqCatalogueService.setBasket(basketvo);
			reqCatalogueService.setBasketVm(basketvo);

//				String network = ordervo.getNetworkChk();
//				String[] networks = network.split(",");

			// 공용네트워크 network_vm 추가
			/*
			 * for (int i = 0; i < networks.length; i++) {
			 *
			 * CustomReqBasketVO setBasketNetworkVm = new CustomReqBasketVO();
			 *
			 * String[] reqnet = networks[i].split(":");
			 * setBasketNetworkVm.setSharedNetwork(reqnet[0]);
			 * setBasketNetworkVm.setSharedNetworkName(reqnet[1]);
			 * setBasketNetworkVm.setSelectedFlag(reqnet[2]);
			 * setBasketNetworkVm.setBasketSeq(basketSeq); String setBasketVmNetwork =
			 * reqCatalogueService.setBasketVmNetwork(setBasketNetworkVm); }
			 */

		} else if (ordervo.getProductCategory().equals("PRODCATE_DISK")) {

			String basketSummary = "";
			basketvo.setOnDemandFlag(ordervo.getOnDemandFlag());
			String applyDatetime = "";
			if (ordervo.getOnDemandFlag().equals("N")) {
				applyDatetime = ordervo.getApplyDate() + " " + ordervo.getApplyTime() + ":00";
			}
			basketSummary = "<hr />";
			basketSummary = basketSummary + "<table><colgroup><col width='30%'><col width='70%'></colgroup><tbody>";
			// basketSummary = basketSummary +"<tr><td
			// class='left'>서비스시작일시</td><td>"+applyDatetime+"</td></tr>";
			basketSummary = basketSummary + "<tr><td class='left'>신청자원</td><td>블록디스크</td></tr>";
			basketSummary = basketSummary + "<tr><td class='left'>프로젝트</td><td>" + ordervo.getProjectName()
					+ " </td></tr>";
			basketSummary = basketSummary + "<tr><td class='left'>가상서버</td><td>" + ordervo.getVmName() + " </td></tr>";
			basketSummary = basketSummary + "<tr><td class='left'>DISK</td><td>" + ordervo.getDiskGb()
					+ " GB </td></tr>";
			// basketSummary = basketSummary +"<tr><td
			// class='left'>비고</td><td>"+ordervo.getDescription()+"</td></tr>";
			// basketSummary = basketSummary +"<tr><td colspan='2' class='tar f18
			// fc-red'>"+ordervo.getTotalPrice()+" <span class='f12
			// fc66'>원</span></td></tr>";
			basketSummary = basketSummary + "</tbody></table>";

			basketvo.setBasketSummary(basketSummary);
			basketvo.setHourlyFlag(ordervo.getHourlyFlag());
			basketvo.setAmount(ordervo.getTotalPrice());

			basketvo.setVmUuid(ordervo.getVmUuid());
			basketvo.setDiskName(ordervo.getDiskName());
			basketvo.setDiskType(ordervo.getDiskType());

			basketvo.setApplyDatetime(applyDatetime);
			basketvo.setProjectId(ordervo.getProjectId());

			basketvo.setCatalogSeq(ordervo.getCatalogSeq());
			basketvo.setDiskGb(ordervo.getDiskcnt());
			// basketvo.setVmProductSeq(ordervo.getProductSeq());
			basketvo.setDiskProductSeq(ordervo.getProductSeq());

			basketvo.setDescription(ordervo.getDescription());
			basketvo.setVmdkFile(ordervo.getVmdkFile());

			reqCatalogueService.setBasket(basketvo);
			reqCatalogueService.setBasketDisk(basketvo);

		} else if (ordervo.getProductCategory().equals("PRODCATE_NAS")) {

			String basketSummary = "";
			basketvo.setOnDemandFlag(ordervo.getOnDemandFlag());
			String applyDatetime = "";
			if (ordervo.getOnDemandFlag().equals("N")) {
				applyDatetime = ordervo.getApplyDate() + " " + ordervo.getApplyTime() + ":00";
			}
			basketSummary = "<table><colgroup><col width='30%'><col width='70%'></colgroup><tbody>";
			basketSummary = basketSummary + "<tr><td class='left'>서비스시작일시</td><td>" + applyDatetime + "</td></tr>";
			basketSummary = basketSummary + "<tr><td class='left'>프로젝트</td><td>" + ordervo.getProjectName()
					+ " </td></tr>";
			basketSummary = basketSummary + "<tr><td class='left'>가상서버</td><td>" + ordervo.getVmName() + " </td></tr>";
			basketSummary = basketSummary + "<tr><td class='left'>NAS 이름</td><td>" + ordervo.getNasName()
					+ " </td></tr>";
			basketSummary = basketSummary + "<tr><td class='left'>mountPath</td><td>" + ordervo.getNasFileSystemPath()
					+ " </td></tr>";
			basketSummary = basketSummary + "<tr><td class='left'>NAS 용량</td><td>" + ordervo.getNasGb()
					+ " GB </td></tr>";
			basketSummary = basketSummary + "<tr><td class='left'>비고</td><td>" + ordervo.getDescription()
					+ "</td></tr>";
			basketSummary = basketSummary + "<tr><td colspan='2' class='tar f18 fc-red'>" + ordervo.getTotalPrice()
					+ " <span class='f12 fc66'>원</span></td></tr>";
			basketSummary = basketSummary + "</tbody></table>";

			basketvo.setBasketSummary(basketSummary);
			basketvo.setHourlyFlag(ordervo.getHourlyFlag());
			basketvo.setAmount(ordervo.getTotalPrice());

			basketvo.setNasName(ordervo.getNasName());
			basketvo.setNasAlias(ordervo.getNasName());
			basketvo.setNasNfsObjectId(ordervo.getNasNfsObjectId());
			basketvo.setNasGb(ordervo.getNasGb());

//			if (!"openshift".equals(ordervo.getCloudType())) {
//				basketvo.setNasFileSystemPath(ordervo.getNasFileSystemPath());
//			} else {
				basketvo.setNasFileSystemPath("/"+ ordervo.getProjectName() + "." + ordervo.getNasFileSystemPath());
				String projectId = reqCatalogueService.getOpsNasProjectId(ordervo);
				basketvo.setProjectId(projectId);
//			}

			basketvo.setVmName(ordervo.getVmName());
			basketvo.setVmUuid(ordervo.getVmUuid());
			basketvo.setApplyDatetime(applyDatetime);

			basketvo.setNasCatalogSeq(ordervo.getCatalogSeq());
			basketvo.setNasProductSeq(ordervo.getProductSeq());

			basketvo.setDescription(ordervo.getDescription());

			reqCatalogueService.setBasket(basketvo);
			reqCatalogueService.setBasketNas(basketvo);

			if (!"openshift".equals(ordervo.getCloudType())) {
				reqCatalogueService.setBasketNasVm(basketvo);
			}

		} else if (ordervo.getProductCategory().equals("PRODCATE_PUBLICIP")) {

			String basketSummary = "";
			basketvo.setOnDemandFlag(ordervo.getOnDemandFlag());
			String applyDatetime = "";
			if (ordervo.getOnDemandFlag().equals("N")) {
				applyDatetime = ordervo.getApplyDate() + " " + ordervo.getApplyTime() + ":00";
			}
			basketSummary = "<table><colgroup><col width='30%'><col width='70%'></colgroup><tbody>";
			basketSummary = basketSummary + "<tr><td class='left'>서비스시작일시</td><td>" + applyDatetime + "</td></tr>";
			basketSummary = basketSummary + "<tr><td class='left'>프로젝트</td><td>" + ordervo.getProjectName()
					+ " </td></tr>";
			basketSummary = basketSummary + "<tr><td class='left'>가상서버</td><td>" + ordervo.getVmName() + " </td></tr>";
			basketSummary = basketSummary + "<tr><td class='left'>비고</td><td>" + ordervo.getDescription()
					+ "</td></tr>";
			basketSummary = basketSummary + "<tr><td colspan='2' class='tar f18 fc-red'>" + ordervo.getTotalPrice()
					+ " <span class='f12 fc66'>원</span></td></tr>";
			basketSummary = basketSummary + "</tbody></table>";

			basketvo.setBasketSummary(basketSummary);
			basketvo.setHourlyFlag(ordervo.getHourlyFlag());
			basketvo.setAmount(ordervo.getTotalPrice());

			basketvo.setVmUuid(ordervo.getVmUuid());
			basketvo.setCatalogSeq(ordervo.getCatalogSeq());

			basketvo.setApplyDatetime(applyDatetime);
			basketvo.setProjectId(ordervo.getProjectId());

			basketvo.setDiskGb(ordervo.getDiskcnt());

			basketvo.setPublicipProductSeq(ordervo.getProductSeq());

			basketvo.setDescription(ordervo.getDescription());

			reqCatalogueService.setBasket(basketvo);
			reqCatalogueService.setBasketIp(basketvo);
		} else if (ordervo.getProductCategory().equals("PRODCATE_LOADBALANCER")) {
			/*
			 * String vmNetwork = request.getParameter("vmNetwork"); String vmNetworkChk =
			 * ordervo.getVmNetworkChk(); //프로젝트 네트워크 입력 String []vmNetworks =
			 * vmNetworkChk.split(","); for(int i=0;i<vmNetworks.length;i++){
			 * CustomReqBasketVO netVo = new CustomReqBasketVO(); String []reqnet =
			 * vmNetworks[i].split(":"); netVo.setBasketSeq(basketSeq);
			 * netVo.setVmUuid(reqnet[1]); reqCatalogueService.setBasketLoadVm(netVo);
			 *
			 * }
			 */
			String basketSummary = "";
			basketvo.setOnDemandFlag(ordervo.getOnDemandFlag());
			String applyDatetime = "";
			if (ordervo.getOnDemandFlag().equals("N")) {
				applyDatetime = ordervo.getApplyDate() + " " + ordervo.getApplyTime() + ":00";
			}
			basketSummary = "<table><colgroup><col width='30%'><col width='70%'></colgroup><tbody>";
			basketSummary = basketSummary + "<tr><td class='left'>서비스시작일시</td><td>" + applyDatetime + "</td></tr>";
			basketSummary = basketSummary + "<tr><td class='left'>프로젝트</td><td>" + ordervo.getProjectName()
					+ " </td></tr>";
			/*
			 * basketSummary = basketSummary
			 * ="<tr><td class='left'>네트워크 ZONE</td><td>"+ordervo.getNetworkAlias()
			 * +" </td></tr>"; basketSummary = basketSummary
			 * ="<tr><td class='left'>가상서버</td><td>"+ordervo.getVmNetwork()+" </td></tr>";
			 */
			basketSummary = basketSummary + "<tr><td class='left'>서비스 네트워크명</td><td>" + ordervo.getLoadbalancerName()
					+ "</td></tr>";
			/*
			 * basketSummary = basketSummary
			 * ="<tr><td class='left'>Protocol</td><td>"+ordervo.getProtocol()+"</td></tr>";
			 * basketSummary = basketSummary
			 * ="<tr><td class='left'>Method</td><td>"+ordervo.getMethod()+"</td></tr>";
			 * basketSummary = basketSummary
			 * ="<tr><td class='left'>Monitor Type</td><td>"+ordervo.getMonitorType()+
			 * "</td></tr>"; basketSummary = basketSummary
			 * +"<tr><td class='left'>비고</td><td>"+ordervo.getDescription()+"</td></tr>";
			 */
			basketSummary = basketSummary + "<tr><td colspan='2' class='tar f18 fc-red'>" + ordervo.getTotalPrice()
					+ " <span class='f12 fc66'>원</span></td></tr>";
			basketSummary = basketSummary + "</tbody></table>";

			basketvo.setBasketSummary(basketSummary);
			basketvo.setApplyDatetime(applyDatetime);
			basketvo.setHourlyFlag(ordervo.getHourlyFlag());
			basketvo.setProjectId(ordervo.getProjectId());
			basketvo.setDefaultNetworkId(ordervo.getNetworkId());
			basketvo.setLoadbalancerName(ordervo.getLoadbalancerName());
			basketvo.setLoadbalancerEa("1");
			basketvo.setDescription(ordervo.getDescription());
			basketvo.setMethod(ordervo.getMethod());
			basketvo.setProtocol(ordervo.getProtocol());
			basketvo.setMonitorType(ordervo.getMonitorType());
			basketvo.setLoadbalancerProductSeq(ordervo.getProductSeq());

			basketvo.setAmount(ordervo.getTotalPrice());
//				basketvo.setVmUuid(ordervo.getVmUuid());
			basketvo.setCatalogSeq(ordervo.getCatalogSeq());

			reqCatalogueService.setBasket(basketvo);
			reqCatalogueService.setBasketLoad(basketvo);
			/* String setBasketLoadVm = reqCatalogueService.setBasketLoadVm(basketvo); */
		} else if (ordervo.getProductCategory().equals("PRODCATE_SERVICE")) {

			String basketSummary = "";
			basketvo.setOnDemandFlag(ordervo.getOnDemandFlag());
			String applyDatetime = "";
			if (ordervo.getOnDemandFlag().equals("N")) {
				applyDatetime = ordervo.getApplyDate() + " " + ordervo.getApplyTime() + ":00";
			}
			basketSummary = "<hr />";
			basketSummary = basketSummary + "<table><colgroup><col width='30%'><col width='70%'></colgroup><tbody>";
			// basketSummary = basketSummary +"<tr><td
			// class='left'>서비스시작일시</td><td>"+applyDatetime+"</td></tr>";
			basketSummary = basketSummary + "<tr><td class='left'>신청자원</td><td>서비스</td></tr>";
			basketSummary = basketSummary + "<tr><td class='left'>프로젝트</td><td>" + ordervo.getProjectName()
					+ " </td></tr>";
			basketSummary = basketSummary + "<tr><td class='left'>가상서버</td><td>" + ordervo.getVmName() + " </td></tr>";
			if (ordervo.getDescription() != null) {
				basketSummary = basketSummary + "<tr><td class='left'>요청사항</td><td>" + ordervo.getDescription()
						+ "</td></tr>";
			}
			// basketSummary = basketSummary +"<tr><td colspan='2' class='tar f18
			// fc-red'>"+ordervo.getTotalPrice()+" <span class='f12
			// fc66'>원</span></td></tr>";
			basketSummary = basketSummary + "</tbody></table>";

			basketvo.setBasketSummary(basketSummary);
			basketvo.setHourlyFlag(ordervo.getHourlyFlag());
			basketvo.setAmount(ordervo.getTotalPrice());

			basketvo.setVmUuid(ordervo.getVmUuid());

			basketvo.setApplyDatetime(applyDatetime);
			basketvo.setProjectId(ordervo.getProjectId());

			basketvo.setCatalogSeq(ordervo.getCatalogSeq());

			basketvo.setProductSeq(ordervo.getProductSeq());
			basketvo.setDescription(ordervo.getDescription());

			reqCatalogueService.setBasket(basketvo);
			reqCatalogueService.setBasketService(basketvo);
		}

//			else if(ordervo.getProductCategory().equals("PRODCATE_MCA")){
//
//				String basketSummary = "";
//				basketvo.setOnDemandFlag(ordervo.getOnDemandFlag());
//				String applyDatetime = "";
//				if(ordervo.getOnDemandFlag().equals("N")){
//					applyDatetime =		ordervo.getApplyDate() +" "+ ordervo.getApplyTime() +":00";
//				}
//				basketSummary ="<table><colgroup><col width='30%'><col width='70%'></colgroup><tbody>";
//				basketSummary = basketSummary +"<tr><td class='left'>서비스시작일시</td><td>"+applyDatetime+"</td></tr>";
//				basketSummary = basketSummary +"<tr><td class='left'>프로젝트</td><td>"+ordervo.getProjectName()+" </td></tr>";
//				basketSummary = basketSummary +"<tr><td class='left'>비고</td><td>"+ordervo.getDescription()+"</td></tr>";
//				basketSummary = basketSummary +"<tr><td colspan='2' class='tar f18 fc-red'>"+ordervo.getTotalPrice()+" <span class='f12 fc66'>원</span></td></tr>";
//				basketSummary = basketSummary +"</tbody></table>";
//
//				basketvo.setBasketSummary(basketSummary);
//				basketvo.setHourlyFlag(ordervo.getHourlyFlag());
//				basketvo.setAmount(ordervo.getTotalPrice());
//
//				basketvo.setCatalogSeq(ordervo.getCatalogSeq());
//
//				basketvo.setApplyDatetime(applyDatetime);
//				basketvo.setProjectId(ordervo.getProjectId());
//
//
//				basketvo.setProductSeq(ordervo.getProductSeq());
//				basketvo.setDescription(ordervo.getDescription());
//
//				reqCatalogueService.setBasket(basketvo);
//				reqCatalogueService.setBasketMca(basketvo);
//
//			}else if(ordervo.getProductCategory().equals("PRODCATE_SCM")){
//
//				String basketSummary = "";
//				basketvo.setOnDemandFlag(ordervo.getOnDemandFlag());
//				String applyDatetime = "";
//				if(ordervo.getOnDemandFlag().equals("N")){
//					applyDatetime =		ordervo.getApplyDate() +" "+ ordervo.getApplyTime() +":00";
//				}
//				basketSummary ="<table><colgroup><col width='30%'><col width='70%'></colgroup><tbody>";
//				basketSummary = basketSummary +"<tr><td class='left'>서비스시작일시</td><td>"+applyDatetime+"</td></tr>";
//				basketSummary = basketSummary +"<tr><td class='left'>프로젝트</td><td>"+ordervo.getProjectName()+" </td></tr>";
//				basketSummary = basketSummary +"<tr><td class='left'>비고</td><td>"+ordervo.getDescription()+"</td></tr>";
//				basketSummary = basketSummary +"<tr><td colspan='2' class='tar f18 fc-red'>"+ordervo.getTotalPrice()+" <span class='f12 fc66'>원</span></td></tr>";
//				basketSummary = basketSummary +"</tbody></table>";
//
//				basketvo.setBasketSummary(basketSummary);
//				basketvo.setHourlyFlag(ordervo.getHourlyFlag());
//				basketvo.setAmount(ordervo.getTotalPrice());
//
//				basketvo.setCatalogSeq(ordervo.getCatalogSeq());
//
//				basketvo.setApplyDatetime(applyDatetime);
//				basketvo.setProjectId(ordervo.getProjectId());
//
//				basketvo.setProductSeq(ordervo.getProductSeq());
//				basketvo.setDescription(ordervo.getDescription());
//
//				reqCatalogueService.setBasket(basketvo);
//				reqCatalogueService.setBasketScm(basketvo);
//
//			}else if(ordervo.getProductCategory().equals("PRODCATE_SECURITY")){
//
//				String basketSummary = "";
//				basketvo.setOnDemandFlag(ordervo.getOnDemandFlag());
//				String applyDatetime = "";
//				if(ordervo.getOnDemandFlag().equals("N")){
//					applyDatetime =		ordervo.getApplyDate() +" "+ ordervo.getApplyTime() +":00";
//				}
//				basketSummary ="<table><colgroup><col width='30%'><col width='70%'></colgroup><tbody>";
//				basketSummary = basketSummary +"<tr><td class='left'>서비스시작일시</td><td>"+applyDatetime+"</td></tr>";
//				basketSummary = basketSummary +"<tr><td class='left'>프로젝트</td><td>"+ordervo.getProjectName()+" </td></tr>";
//				basketSummary = basketSummary +"<tr><td class='left'>비고</td><td>"+ordervo.getDescription()+"</td></tr>";
//				basketSummary = basketSummary +"<tr><td colspan='2' class='tar f18 fc-red'>"+ordervo.getTotalPrice()+" <span class='f12 fc66'>원</span></td></tr>";
//				basketSummary = basketSummary +"</tbody></table>";
//
//				basketvo.setBasketSummary(basketSummary);
//				basketvo.setHourlyFlag(ordervo.getHourlyFlag());
//				basketvo.setAmount(ordervo.getTotalPrice());
//
//				basketvo.setCatalogSeq(ordervo.getCatalogSeq());
//
//				basketvo.setApplyDatetime(applyDatetime);
//				basketvo.setProjectId(ordervo.getProjectId());
//
//				basketvo.setProductSeq(ordervo.getProductSeq());
//				basketvo.setDescription(ordervo.getDescription());
//
//				reqCatalogueService.setBasket(basketvo);
//				reqCatalogueService.setBasketScr(basketvo);
//
//			}else if(ordervo.getProductCategory().equals("PRODCATE_BACKUP")){
//
//				String basketSummary = "";
//				basketvo.setOnDemandFlag(ordervo.getOnDemandFlag());
//				String applyDatetime = "";
//				if(ordervo.getOnDemandFlag().equals("N")){
//					applyDatetime =		ordervo.getApplyDate() +" "+ ordervo.getApplyTime() +":00";
//				}
//				basketSummary ="<table><colgroup><col width='30%'><col width='70%'></colgroup><tbody>";
//				basketSummary = basketSummary +"<tr><td class='left'>서비스시작일시</td><td>"+applyDatetime+"</td></tr>";
//				basketSummary = basketSummary +"<tr><td class='left'>프로젝트</td><td>"+ordervo.getProjectName()+" </td></tr>";
////				basketSummary = basketSummary +"<tr><td class='left'>가상서버</td><td>"+ordervo.getVmName()+" </td></tr>";
//				basketSummary = basketSummary +"<tr><td class='left'>비고</td><td>"+ordervo.getDescription()+"</td></tr>";
//				basketSummary = basketSummary +"<tr><td colspan='2' class='tar f18 fc-red'>"+ordervo.getTotalPrice()+" <span class='f12 fc66'>원</span></td></tr>";
//				basketSummary = basketSummary +"</tbody></table>";
//
//				basketvo.setBasketSummary(basketSummary);
//				basketvo.setHourlyFlag(ordervo.getHourlyFlag());
//				basketvo.setAmount(ordervo.getTotalPrice());
//
////				basketvo.setVmUuid(ordervo.getVmUuid());
//
//				basketvo.setApplyDatetime(applyDatetime);
//				basketvo.setProjectId(ordervo.getProjectId());
//
//				basketvo.setCatalogSeq(ordervo.getCatalogSeq());
//
//				basketvo.setProductSeq(ordervo.getProductSeq());
//				basketvo.setDescription(ordervo.getDescription());
//
//				reqCatalogueService.setBasket(basketvo);
//				reqCatalogueService.setBasketBak(basketvo);
//			}

		// 장바구니 vm 리스트 가져오기
		List<CustomReqBasketVO> getBasketlistvo = reqCatalogueService.getBasketlist(basketvo);
		String networkChk = "";
		for (int i = 0; i < getBasketlistvo.size(); i++) {
			List<CustomReqBasketVO> getBasketVmList = reqCatalogueService
					.getBasketVmList(getBasketlistvo.get(i).getBasketSeq());
			for (int j = 0; j < getBasketVmList.size(); j++) {
				networkChk = getBasketVmList.get(j).getSharedNetwork();
				networkChk = networkChk + ":" + getBasketVmList.get(j).getSharedNetworkName();
				networkChk = networkChk + ":" + getBasketVmList.get(j).getSelectedFlag();
				getBasketlistvo.get(i).setNetworkChk(networkChk);
				log.debug("networkChk : " + networkChk);
				networkChk = "";
			}
		}
		model.addAttribute("getBasketlistvo", getBasketlistvo);

		// 장바구니 블록디스크 리스트 가져오기
		List<CustomReqBasketVO> getBasketDisklistvo = reqCatalogueService.getBasketDisklistvo(basketvo);
		model.addAttribute("getBasketDisklistvo", getBasketDisklistvo);

		// 장바구니 NAS 리스트 가져오기
		List<CustomReqBasketVO> getBasketNaslistvo = reqCatalogueService.getBasketNaslistvo(basketvo);
		model.addAttribute("getBasketNaslistvo", getBasketNaslistvo);

		// 장바구니 IP 리스트 가져오기
		List<CustomReqBasketVO> getBasketIplistvo = reqCatalogueService.getBasketIplistvo(basketvo);
		model.addAttribute("getBasketIplistvo", getBasketIplistvo);

		// 장바구니 로드 밸런서 리스트 가져오기
		List<CustomReqBasketVO> getBasketLblistvo = reqCatalogueService.getBasketLblistvo(basketvo);
		model.addAttribute("getBasketIplistvo", getBasketLblistvo);

		// 장바구니 서비스 리스트 가져오기
		List<CustomReqBasketVO> getBasketServicelistvo = reqCatalogueService.getBasketServicelistvo(basketvo);
		model.addAttribute("getBasketServicelistvo", getBasketServicelistvo);

		// 장바구니 서비스 백업 리스트 가져오기
//			List<CustomReqBasketVO> getBasketBaklistvo = reqCatalogueService.getBasketBaklistvo(basketvo);
//			model.addAttribute("getBasketBaklistvo", getBasketBaklistvo);

		// 장바구니 서비스 대외계 리스트 가져오기
//			List<CustomReqBasketVO> getBasketMcalistvo = reqCatalogueService.getBasketMcalistvo(basketvo);
//			model.addAttribute("getBasketMcalistvo", getBasketMcalistvo);

		// 장바구니 서비스 형상관리 리스트 가져오기
//			List<CustomReqBasketVO> getBasketScmlistvo = reqCatalogueService.getBasketScmlistvo(basketvo);
//			model.addAttribute("getBasketScmlistvo", getBasketScmlistvo);

		// 장바구니 서비스 보안관제 리스트 가져오기
//			List<CustomReqBasketVO> getBasketSerlistvo = reqCatalogueService.getBasketSerlistvo(basketvo);
//			model.addAttribute("getBasketSerlistvo", getBasketSerlistvo);

		return new ResponseEntity<Object>("1", HttpStatus.OK);
	}

	// 카테고리 상품 장바구니 페이지 이동 및 장바구니 테이블 입력
	@RequestMapping(value = "/basketOrder.do", params = "type=noworder")
	public RedirectView cataloguebasketOrder(HttpServletRequest request, Model model, CustomReqCatalogueVO ordervo) {
		CustomReqBasketVO basketvo = new CustomReqBasketVO();

		Date requestSeqdate = new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");

		// bss_basket
		String basketSeq = dateFormat.format(requestSeqdate);
		String requestType = "REQTYPE_NEW";

		basketvo.setBasketSeq(basketSeq);
		basketvo.setUserId(request.getUserPrincipal().getName());
		basketvo.setRequestType(requestType);
		basketvo.setProductCategory(ordervo.getProductCategory());
		basketvo.setCloudId(ordervo.getCloudId());
		if (ordervo.getProductCategory().equals("PRODCATE_VM")) {
			// 가상머신 상품
			String basketSummary = "";
			basketvo.setOnDemandFlag(ordervo.getOnDemandFlag());
			String applyDatetime = "";
			if (ordervo.getOnDemandFlag().equals("N")) {
				applyDatetime = ordervo.getApplyDate() + " " + ordervo.getApplyTime() + ":00";
			}
			basketSummary = "<table><colgroup><col width='30%'><col width='70%'></colgroup><tbody>";
			basketSummary = basketSummary + "<tr><td class='left'>서비스시작일시</td><td>" + applyDatetime + "</td></tr>";
			basketSummary = basketSummary + "<tr><td class='left'>프로젝트</td><td>" + ordervo.getProjectName()
					+ " </td></tr>";
			basketSummary = basketSummary + "<tr><td class='left'>네트워크 ZONE</td><td>" + ordervo.getDefaultNetworkAlias()
					+ " </td></tr>";
			basketSummary = basketSummary + "<tr><td class='left'>HOST</td><td>" + ordervo.getHostname() + "</td></tr>";
			basketSummary = basketSummary + "<tr><td class='left'>HOST ALIAS</td><td>" + ordervo.getHostnameAlias()
					+ "</td></tr>";
			basketSummary = basketSummary + "<tr><td class='left'>CPU</td><td>" + ordervo.getVcpus()
					+ " vCPU</td></tr>";
			basketSummary = basketSummary + "<tr><td class='left'>MEM</td><td>" + ordervo.getMemGb() + " GB</td></tr>";
			basketSummary = basketSummary + "<tr><td class='left'>DISK</td><td>" + ordervo.getDiskGb()
					+ " GB </td></tr>";
			basketSummary = basketSummary + "<tr><td class='left'>비고</td><td>" + ordervo.getDescription()
					+ "</td></tr>";
			basketSummary = basketSummary + "<tr><td colspan='2' class='tar f18 fc-red'>" + ordervo.getTotalPrice()
					+ " <span class='f12 fc66'>원</span></td></tr>";
			basketSummary = basketSummary + "</tbody></table>";

			basketvo.setBasketSummary(basketSummary);
			basketvo.setHourlyFlag(ordervo.getHourlyFlag());
			basketvo.setAmount(ordervo.getTotalPrice());

			// bss_basket_vm
			// String defaultNetworkId = "";

			basketvo.setApplyDatetime(applyDatetime);
			basketvo.setProjectId(ordervo.getProjectId());
			basketvo.setDefaultNetworkId(ordervo.getNetworkId());
			basketvo.setDefaultNetworkName(ordervo.getDefaultNetworkName());
			basketvo.setDefaultNetworkAlias(ordervo.getDefaultNetworkAlias());
			basketvo.setHostname(ordervo.getHostname());
			basketvo.setHostnameAlias(ordervo.getHostnameAlias());
			basketvo.setVcpus(ordervo.getCpucnt());
			basketvo.setMemGb(ordervo.getMemcnt());
			basketvo.setDiskGb(ordervo.getDiskcnt());
			basketvo.setVmProductSeq(ordervo.getProductSeq());
			basketvo.setOsProductSeq(ordervo.getOsProductSeq());
			basketvo.setDescription(ordervo.getDescription());
			basketvo.setCatalogSeq(ordervo.getCatalogSeq());

			reqCatalogueService.setBasket(basketvo);
			reqCatalogueService.setBasketVm(basketvo);

//				String network = ordervo.getNetworkChk();
//				String[] networks = network.split(",");

			// 공용네트워크 network_vm 추가
			/*
			 * for (int i = 0; i < networks.length; i++) {
			 *
			 * CustomReqBasketVO setBasketNetworkVm = new CustomReqBasketVO();
			 *
			 * String[] reqnet = networks[i].split(":");
			 * setBasketNetworkVm.setSharedNetwork(reqnet[0]);
			 * setBasketNetworkVm.setSharedNetworkName(reqnet[1]);
			 * setBasketNetworkVm.setSelectedFlag(reqnet[2]);
			 * setBasketNetworkVm.setBasketSeq(basketSeq); String setBasketVmNetwork =
			 * reqCatalogueService.setBasketVmNetwork(setBasketNetworkVm); }
			 */

		} else if (ordervo.getProductCategory().equals("PRODCATE_DISK")) {

			String basketSummary = "";
			basketvo.setOnDemandFlag(ordervo.getOnDemandFlag());
			String applyDatetime = "";
			if (ordervo.getOnDemandFlag().equals("N")) {
				applyDatetime = ordervo.getApplyDate() + " " + ordervo.getApplyTime() + ":00";
			}
			basketSummary = "<table><colgroup><col width='30%'><col width='70%'></colgroup><tbody>";
			basketSummary = basketSummary + "<tr><td class='left'>서비스시작일시</td><td>" + applyDatetime + "</td></tr>";
			basketSummary = basketSummary + "<tr><td class='left'>프로젝트</td><td>" + ordervo.getProjectName()
					+ " </td></tr>";
			basketSummary = basketSummary + "<tr><td class='left'>가상서버</td><td>" + ordervo.getVmName() + " </td></tr>";
			basketSummary = basketSummary + "<tr><td class='left'>DISK</td><td>" + ordervo.getDiskGb()
					+ " GB </td></tr>";
			basketSummary = basketSummary + "<tr><td class='left'>비고</td><td>" + ordervo.getDescription()
					+ "</td></tr>";
			basketSummary = basketSummary + "<tr><td colspan='2' class='tar f18 fc-red'>" + ordervo.getTotalPrice()
					+ " <span class='f12 fc66'>원</span></td></tr>";
			basketSummary = basketSummary + "</tbody></table>";

			basketvo.setBasketSummary(basketSummary);
			basketvo.setHourlyFlag(ordervo.getHourlyFlag());
			basketvo.setAmount(ordervo.getTotalPrice());

			basketvo.setVmUuid(ordervo.getVmUuid());
			basketvo.setDiskName(ordervo.getNasName());
			basketvo.setDiskType(ordervo.getDiskType());

			basketvo.setApplyDatetime(applyDatetime);
			basketvo.setProjectId(ordervo.getProjectId());

			basketvo.setCatalogSeq(ordervo.getCatalogSeq());
			basketvo.setDiskGb(ordervo.getDiskcnt());
			// basketvo.setVmProductSeq(ordervo.getProductSeq());
			basketvo.setDiskProductSeq(ordervo.getProductSeq());

			basketvo.setDescription(ordervo.getDescription());

			reqCatalogueService.setBasket(basketvo);
			reqCatalogueService.setBasketDisk(basketvo);

		} else if (ordervo.getProductCategory().equals("PRODCATE_NAS")) {

			String basketSummary = "";
			basketvo.setOnDemandFlag(ordervo.getOnDemandFlag());
			String applyDatetime = "";
			if (ordervo.getOnDemandFlag().equals("N")) {
				applyDatetime = ordervo.getApplyDate() + " " + ordervo.getApplyTime() + ":00";
			}
			basketSummary = "<table><colgroup><col width='30%'><col width='70%'></colgroup><tbody>";
			basketSummary = basketSummary + "<tr><td class='left'>서비스시작일시</td><td>" + applyDatetime + "</td></tr>";
			basketSummary = basketSummary + "<tr><td class='left'>프로젝트</td><td>" + ordervo.getProjectName()
					+ " </td></tr>";
			basketSummary = basketSummary + "<tr><td class='left'>가상서버</td><td>" + ordervo.getVmName() + " </td></tr>";
			basketSummary = basketSummary + "<tr><td class='left'>NAS 이름</td><td>" + ordervo.getNasName()
					+ " </td></tr>";
			basketSummary = basketSummary + "<tr><td class='left'>NAS 용량</td><td>" + ordervo.getNasGb()
					+ " GB </td></tr>";
			basketSummary = basketSummary + "<tr><td class='left'>비고</td><td>" + ordervo.getDescription()
					+ "</td></tr>";
			basketSummary = basketSummary + "<tr><td colspan='2' class='tar f18 fc-red'>" + ordervo.getTotalPrice()
					+ " <span class='f12 fc66'>원</span></td></tr>";
			basketSummary = basketSummary + "</tbody></table>";

			basketvo.setBasketSummary(basketSummary);
			basketvo.setHourlyFlag(ordervo.getHourlyFlag());
			basketvo.setAmount(ordervo.getTotalPrice());

			basketvo.setDiskName(ordervo.getNasName());
			basketvo.setNasName(ordervo.getNasName());
			basketvo.setNasGb(ordervo.getNasGb());

			basketvo.setVmName(ordervo.getVmName());
			basketvo.setVmUuid(ordervo.getVmUuid());

			basketvo.setApplyDatetime(applyDatetime);
//			basketvo.setProjectId(ordervo.getProjectId());
			String projectId = reqCatalogueService.getOpsNasProjectId(ordervo);
			basketvo.setProjectId(projectId);

			basketvo.setDiskGb(ordervo.getDiskcnt());
			basketvo.setCatalogSeq(ordervo.getCatalogSeq());
			basketvo.setNasProductSeq(ordervo.getProductSeq());

			basketvo.setDescription(ordervo.getDescription());

			reqCatalogueService.setBasket(basketvo);
			reqCatalogueService.setBasketNas(basketvo);

			if (!"openshift".equals(ordervo.getCloudType())) {
				reqCatalogueService.setBasketNasVm(basketvo);
			}

		} else if (ordervo.getProductCategory().equals("PRODCATE_PUBLICIP")) {

			String basketSummary = "";
			basketvo.setOnDemandFlag(ordervo.getOnDemandFlag());
			String applyDatetime = "";
			if (ordervo.getOnDemandFlag().equals("N")) {
				applyDatetime = ordervo.getApplyDate() + " " + ordervo.getApplyTime() + ":00";
			}
			basketSummary = "<table><colgroup><col width='30%'><col width='70%'></colgroup><tbody>";
			basketSummary = basketSummary + "<tr><td class='left'>서비스시작일시</td><td>" + applyDatetime + "</td></tr>";
			basketSummary = basketSummary + "<tr><td class='left'>프로젝트</td><td>" + ordervo.getProjectName()
					+ " </td></tr>";
			basketSummary = basketSummary + "<tr><td class='left'>가상서버</td><td>" + ordervo.getVmName() + " </td></tr>";
			basketSummary = basketSummary + "<tr><td class='left'>비고</td><td>" + ordervo.getDescription()
					+ "</td></tr>";
			basketSummary = basketSummary + "<tr><td colspan='2' class='tar f18 fc-red'>" + ordervo.getTotalPrice()
					+ " <span class='f12 fc66'>원</span></td></tr>";
			basketSummary = basketSummary + "</tbody></table>";

			basketvo.setBasketSummary(basketSummary);
			basketvo.setHourlyFlag(ordervo.getHourlyFlag());
			basketvo.setAmount(ordervo.getTotalPrice());

			basketvo.setVmUuid(ordervo.getVmUuid());
			basketvo.setCatalogSeq(ordervo.getCatalogSeq());

			basketvo.setApplyDatetime(applyDatetime);
			basketvo.setProjectId(ordervo.getProjectId());

			basketvo.setDiskGb(ordervo.getDiskcnt());

			basketvo.setPublicipProductSeq(ordervo.getProductSeq());

			basketvo.setDescription(ordervo.getDescription());

			reqCatalogueService.setBasket(basketvo);
			reqCatalogueService.setBasketIp(basketvo);

		} else if (ordervo.getProductCategory().equals("PRODCATE_LOADBALANCER")) {

//				String vmNetwork = request.getParameter("vmNetwork");
//				String vmNetworkChk = ordervo.getVmNetworkChk();
			// 프로젝트 네트워크 입력
			/*
			 * String []vmNetworks = vmNetworkChk.split(",");
			 *
			 * for(int i=0;i<vmNetworks.length;i++){ CustomReqBasketVO netVo = new
			 * CustomReqBasketVO(); String []reqnet = vmNetworks[i].split(":");
			 * netVo.setBasketSeq(basketSeq); netVo.setVmUuid(reqnet[1]);
			 * reqCatalogueService.setBasketLoadVm(netVo);
			 *
			 * }
			 */

			String basketSummary = "";
			basketvo.setOnDemandFlag(ordervo.getOnDemandFlag());
			String applyDatetime = "";
			if (ordervo.getOnDemandFlag().equals("N")) {
				applyDatetime = ordervo.getApplyDate() + " " + ordervo.getApplyTime() + ":00";
			}
			basketSummary = "<table><colgroup><col width='30%'><col width='70%'></colgroup><tbody>";
			basketSummary = basketSummary + "<tr><td class='left'>서비스시작일시</td><td>" + applyDatetime + "</td></tr>";
			basketSummary = basketSummary + "<tr><td class='left'>프로젝트</td><td>" + ordervo.getProjectName()
					+ " </td></tr>";
			/*
			 * basketSummary = basketSummary
			 * +"<tr><td class='left'>네트워크 ZONE</td><td>"+ordervo.getNetworkAlias()
			 * +" </td></tr>"; basketSummary = basketSummary
			 * +"<tr><td class='left'>가상서버</td><td>"+ordervo.getVmNetwork()+" </td></tr>";
			 */
			basketSummary = basketSummary + "<tr><td class='left'>서비스네트워크명</td><td>" + ordervo.getLoadbalancerName()
					+ "</td></tr>";
			/*
			 * basketSummary = basketSummary
			 * ="<tr><td class='left'>Protocol</td><td>"+ordervo.getProtocol()+"</td></tr>";
			 */
			/*
			 * basketSummary = basketSummary
			 * ="<tr><td class='left'>Method</td><td>"+ordervo.getMethod()+"</td></tr>";
			 */
			/*
			 * basketSummary = basketSummary
			 * ="<tr><td class='left'>Monitor Type</td><td>"+ordervo.getMonitorType()+
			 * "</td></tr>"; basketSummary = basketSummary
			 * ="<tr><td class='left'>비고</td><td>"+ordervo.getDescription()+"</td></tr>";
			 */
			basketSummary = basketSummary + "<tr><td colspan='2' class='tar f18 fc-red'>" + ordervo.getTotalPrice()
					+ " <span class='f12 fc66'>원</span></td></tr>";
			basketSummary = basketSummary + "</tbody></table>";

			basketvo.setBasketSummary(basketSummary);
			basketvo.setApplyDatetime(applyDatetime);
			basketvo.setHourlyFlag(ordervo.getHourlyFlag());
			basketvo.setProjectId(ordervo.getProjectId());
			basketvo.setDefaultNetworkId(ordervo.getNetworkId());
			basketvo.setLoadbalancerName(ordervo.getLoadbalancerName());
			basketvo.setLoadbalancerEa("1");
			basketvo.setDescription(ordervo.getDescription());
			basketvo.setMethod(ordervo.getMethod());
			basketvo.setProtocol(ordervo.getProtocol());
			basketvo.setMonitorType(ordervo.getMonitorType());
			basketvo.setLoadbalancerProductSeq(ordervo.getProductSeq());

			basketvo.setAmount(ordervo.getTotalPrice());
			basketvo.setVmUuid(ordervo.getVmUuid());
			basketvo.setCatalogSeq(ordervo.getCatalogSeq());

			reqCatalogueService.setBasket(basketvo);
			reqCatalogueService.setBasketLoad(basketvo);
			/* String setBasketLoadVm = reqCatalogueService.setBasketLoadVm(basketvo); */
		}

//			else if(ordervo.getProductCategory().equals("PRODCATE_MCA")){
//
//				String basketSummary = "";
//				basketvo.setOnDemandFlag(ordervo.getOnDemandFlag());
//				String applyDatetime = "";
//				if(ordervo.getOnDemandFlag().equals("N")){
//					applyDatetime =		ordervo.getApplyDate() +" "+ ordervo.getApplyTime() +":00";
//				}
//				basketSummary ="<table><colgroup><col width='30%'><col width='70%'></colgroup><tbody>";
//				basketSummary = basketSummary +"<tr><td class='left'>서비스시작일시</td><td>"+applyDatetime+"</td></tr>";
//				basketSummary = basketSummary +"<tr><td class='left'>프로젝트</td><td>"+ordervo.getProjectName()+" </td></tr>";
//				basketSummary = basketSummary +"<tr><td class='left'>비고</td><td>"+ordervo.getDescription()+"</td></tr>";
//				basketSummary = basketSummary +"<tr><td colspan='2' class='tar f18 fc-red'>"+ordervo.getTotalPrice()+" <span class='f12 fc66'>원</span></td></tr>";
//				basketSummary = basketSummary +"</tbody></table>";
//
//				basketvo.setBasketSummary(basketSummary);
//				basketvo.setHourlyFlag(ordervo.getHourlyFlag());
//				basketvo.setAmount(ordervo.getTotalPrice());
//
//				basketvo.setCatalogSeq(ordervo.getCatalogSeq());
//
//				basketvo.setApplyDatetime(applyDatetime);
//				basketvo.setProjectId(ordervo.getProjectId());
//
//
//				basketvo.setProductSeq(ordervo.getProductSeq());
//				basketvo.setDescription(ordervo.getDescription());
//
//				reqCatalogueService.setBasket(basketvo);
//				reqCatalogueService.setBasketMca(basketvo);
//
//			}else if(ordervo.getProductCategory().equals("PRODCATE_SCM")){
//
//				String basketSummary = "";
//				basketvo.setOnDemandFlag(ordervo.getOnDemandFlag());
//				String applyDatetime = "";
//				if(ordervo.getOnDemandFlag().equals("N")){
//					applyDatetime =		ordervo.getApplyDate() +" "+ ordervo.getApplyTime() +":00";
//				}
//				basketSummary ="<table><colgroup><col width='30%'><col width='70%'></colgroup><tbody>";
//				basketSummary = basketSummary +"<tr><td class='left'>서비스시작일시</td><td>"+applyDatetime+"</td></tr>";
//				basketSummary = basketSummary +"<tr><td class='left'>프로젝트</td><td>"+ordervo.getProjectName()+" </td></tr>";
//				basketSummary = basketSummary +"<tr><td class='left'>비고</td><td>"+ordervo.getDescription()+"</td></tr>";
//				basketSummary = basketSummary +"<tr><td colspan='2' class='tar f18 fc-red'>"+ordervo.getTotalPrice()+" <span class='f12 fc66'>원</span></td></tr>";
//				basketSummary = basketSummary +"</tbody></table>";
//
//				basketvo.setBasketSummary(basketSummary);
//				basketvo.setHourlyFlag(ordervo.getHourlyFlag());
//				basketvo.setAmount(ordervo.getTotalPrice());
//
//				basketvo.setCatalogSeq(ordervo.getCatalogSeq());
//
//				basketvo.setApplyDatetime(applyDatetime);
//				basketvo.setProjectId(ordervo.getProjectId());
//
//				basketvo.setProductSeq(ordervo.getProductSeq());
//				basketvo.setDescription(ordervo.getDescription());
//
//				reqCatalogueService.setBasket(basketvo);
//				reqCatalogueService.setBasketScm(basketvo);
//
//			}else if(ordervo.getProductCategory().equals("PRODCATE_SECURITY")){
//
//				String basketSummary = "";
//				basketvo.setOnDemandFlag(ordervo.getOnDemandFlag());
//				String applyDatetime = "";
//				if(ordervo.getOnDemandFlag().equals("N")){
//					applyDatetime =		ordervo.getApplyDate() +" "+ ordervo.getApplyTime() +":00";
//				}
//				basketSummary ="<table><colgroup><col width='30%'><col width='70%'></colgroup><tbody>";
//				basketSummary = basketSummary +"<tr><td class='left'>서비스시작일시</td><td>"+applyDatetime+"</td></tr>";
//				basketSummary = basketSummary +"<tr><td class='left'>프로젝트</td><td>"+ordervo.getProjectName()+" </td></tr>";
//				basketSummary = basketSummary +"<tr><td class='left'>비고</td><td>"+ordervo.getDescription()+"</td></tr>";
//				basketSummary = basketSummary +"<tr><td colspan='2' class='tar f18 fc-red'>"+ordervo.getTotalPrice()+" <span class='f12 fc66'>원</span></td></tr>";
//				basketSummary = basketSummary +"</tbody></table>";
//
//				basketvo.setBasketSummary(basketSummary);
//				basketvo.setHourlyFlag(ordervo.getHourlyFlag());
//				basketvo.setAmount(ordervo.getTotalPrice());
//
//				basketvo.setCatalogSeq(ordervo.getCatalogSeq());
//
//				basketvo.setApplyDatetime(applyDatetime);
//				basketvo.setProjectId(ordervo.getProjectId());
//
//				basketvo.setProductSeq(ordervo.getProductSeq());
//				basketvo.setDescription(ordervo.getDescription());
//
//				reqCatalogueService.setBasket(basketvo);
//				reqCatalogueService.setBasketScr(basketvo);
//
//			}else if(ordervo.getProductCategory().equals("PRODCATE_BACKUP")){
//
//				String basketSummary = "";
//				basketvo.setOnDemandFlag(ordervo.getOnDemandFlag());
//				String applyDatetime = "";
//				if(ordervo.getOnDemandFlag().equals("N")){
//					applyDatetime =		ordervo.getApplyDate() +" "+ ordervo.getApplyTime() +":00";
//				}
//				basketSummary ="<table><colgroup><col width='30%'><col width='70%'></colgroup><tbody>";
//				basketSummary = basketSummary +"<tr><td class='left'>서비스시작일시</td><td>"+applyDatetime+"</td></tr>";
//				basketSummary = basketSummary +"<tr><td class='left'>프로젝트</td><td>"+ordervo.getProjectName()+" </td></tr>";
//				basketSummary = basketSummary +"<tr><td class='left'>가상서버</td><td>"+ordervo.getVmName()+" </td></tr>";
//				basketSummary = basketSummary +"<tr><td class='left'>비고</td><td>"+ordervo.getDescription()+"</td></tr>";
//				basketSummary = basketSummary +"<tr><td colspan='2' class='tar f18 fc-red'>"+ordervo.getTotalPrice()+" <span class='f12 fc66'>원</span></td></tr>";
//				basketSummary = basketSummary +"</tbody></table>";
//
//				basketvo.setBasketSummary(basketSummary);
//				basketvo.setHourlyFlag(ordervo.getHourlyFlag());
//				basketvo.setAmount(ordervo.getTotalPrice());
//
//				basketvo.setVmUuid(ordervo.getVmUuid());
//
//				basketvo.setApplyDatetime(applyDatetime);
//				basketvo.setProjectId(ordervo.getProjectId());
//
//				basketvo.setCatalogSeq(ordervo.getCatalogSeq());
//
//				basketvo.setProductSeq(ordervo.getProductSeq());
//				basketvo.setDescription(ordervo.getDescription());
//
//				reqCatalogueService.setBasket(basketvo);
//				reqCatalogueService.setBasketBak(basketvo);
//
//				String vmUuids = basketvo.getVmUuid();
//				String[] vmUuid = vmUuids.split(",");
//				for (int i = 0; i < vmUuid.length; i++) {
//					CustomReqBasketVO setVmUuid = new CustomReqBasketVO();
//					setVmUuid.setVmUuid(vmUuid[i]);
//					setVmUuid.setBasketSeq(basketSeq);
//					reqCatalogueService.setBasketBackVm(setVmUuid);
//				}
//			}

		// 장바구니 vm 리스트 가져오기
		List<CustomReqBasketVO> getBasketlistvo = reqCatalogueService.getBasketlist(basketvo);
		String networkChk = "";
		for (int i = 0; i < getBasketlistvo.size(); i++) {
			List<CustomReqBasketVO> getBasketVmList = reqCatalogueService
					.getBasketVmList(getBasketlistvo.get(i).getBasketSeq());
			for (int j = 0; j < getBasketVmList.size(); j++) {
				networkChk = getBasketVmList.get(j).getSharedNetwork();
				networkChk = networkChk + ":" + getBasketVmList.get(j).getSharedNetworkName();
				networkChk = networkChk + ":" + getBasketVmList.get(j).getSelectedFlag();
				getBasketlistvo.get(i).setNetworkChk(networkChk);
				networkChk = "";
			}
		}
		model.addAttribute("getBasketlistvo", getBasketlistvo);

		// 장바구니 블록디스크 리스트 가져오기
		List<CustomReqBasketVO> getBasketDisklistvo = reqCatalogueService.getBasketDisklistvo(basketvo);
		model.addAttribute("getBasketDisklistvo", getBasketDisklistvo);

		// 장바구니 NAS 리스트 가져오기
		List<CustomReqBasketVO> getBasketNaslistvo = reqCatalogueService.getBasketNaslistvo(basketvo);
		model.addAttribute("getBasketNaslistvo", getBasketNaslistvo);

		// 장바구니 IP 리스트 가져오기
		List<CustomReqBasketVO> getBasketIplistvo = reqCatalogueService.getBasketIplistvo(basketvo);
		model.addAttribute("getBasketIplistvo", getBasketIplistvo);

		// 장바구니 로드 밸런서 리스트 가져오기
		List<CustomReqBasketVO> getBasketLblistvo = reqCatalogueService.getBasketLblistvo(basketvo);
		model.addAttribute("getBasketIplistvo", getBasketLblistvo);

		// 장바구니 서비스 리스트 가져오기
		List<CustomReqBasketVO> getBasketServicelistvo = reqCatalogueService.getBasketServicelistvo(basketvo);
		model.addAttribute("getBasketServicelistvo", getBasketServicelistvo);

		// 장바구니 서비스 백업 리스트 가져오기
//			List<CustomReqBasketVO> getBasketBaklistvo = reqCatalogueService.getBasketBaklistvo(basketvo);
//			model.addAttribute("getBasketBaklistvo", getBasketBaklistvo);

		// 장바구니 서비스 대외계 리스트 가져오기
//			List<CustomReqBasketVO> getBasketMcalistvo = reqCatalogueService.getBasketMcalistvo(basketvo);
//			model.addAttribute("getBasketMcalistvo", getBasketMcalistvo);

		// 장바구니 서비스 형상관리 리스트 가져오기
//			List<CustomReqBasketVO> getBasketScmlistvo = reqCatalogueService.getBasketScmlistvo(basketvo);
//			model.addAttribute("getBasketScmlistvo", getBasketScmlistvo);

		// 장바구니 서비스 보안관제 리스트 가져오기
//			List<CustomReqBasketVO> getBasketSerlistvo = reqCatalogueService.getBasketSerlistvo(basketvo);
//			model.addAttribute("getBasketSerlistvo", getBasketSerlistvo);

		RedirectView rv = new RedirectView("basketOrder.do");
		rv.setExposeModelAttributes(false);
		return rv;
	}

	// 카테고리 상품 장바구니 리스트 페이지 이동
	@RequestMapping(value = "/basketOrder.do", params = "!type")
	public String cataloguebasketList(HttpServletRequest request, Model model, CustomReqCatalogueVO ordervo) {
		UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		model.addAttribute("apprvPass", userSession.getApprvPass());
		CustomCmmUserVO cmmUserInfo = new CustomCmmUserVO();
		cmmUserInfo.setUserId(request.getUserPrincipal().getName());
		cmmUserInfo = cmmUserService.userInfoDetail(cmmUserInfo);
		model.addAttribute("userLevelCode", cmmUserInfo.getUserLevelCode());

		CustomReqBasketVO basketvo = new CustomReqBasketVO();
		basketvo.setUserId(request.getUserPrincipal().getName());

		// 장바구니 vm 리스트 가져오기
		List<CustomReqBasketVO> getBasketlistvo = reqCatalogueService.getBasketlist(basketvo);
		String networkChk = "";
		for (int i = 0; i < getBasketlistvo.size(); i++) {
			List<CustomReqBasketVO> getBasketVmList = reqCatalogueService
					.getBasketVmList(getBasketlistvo.get(i).getBasketSeq());

			for (int j = 0; j < getBasketVmList.size(); j++) {

				networkChk = networkChk + getBasketVmList.get(j).getSharedNetwork();
				networkChk = networkChk + ":" + getBasketVmList.get(j).getSharedNetworkName();
				networkChk = networkChk + ":" + getBasketVmList.get(j).getSelectedFlag() + ",";
			}
			getBasketlistvo.get(i).setNetworkChk(networkChk);
			networkChk = "";
		}
		model.addAttribute("getBasketlistvo", getBasketlistvo);

		// 장바구니 블록디스크 리스트 가져오기
		List<CustomReqBasketVO> getBasketDisklistvo = reqCatalogueService.getBasketDisklistvo(basketvo);
		model.addAttribute("getBasketDisklistvo", getBasketDisklistvo);

		// 장바구니 NAS 리스트 가져오기
		List<CustomReqBasketVO> getBasketNaslistvo = reqCatalogueService.getBasketNaslistvo(basketvo);
		model.addAttribute("getBasketNaslistvo", getBasketNaslistvo);

		// 장바구니 IP 리스트 가져오기
		List<CustomReqBasketVO> getBasketIplistvo = reqCatalogueService.getBasketIplistvo(basketvo);
		model.addAttribute("getBasketIplistvo", getBasketIplistvo);

		// 장바구니 로드 밸런서 리스트 가져오기
		List<CustomReqBasketVO> getBasketLblistvo = reqCatalogueService.getBasketLblistvo(basketvo);
		model.addAttribute("getBasketLblistvo", getBasketLblistvo);

		// 장바구니 서비스 리스트 가져오기
		List<CustomReqBasketVO> getBasketServicelistvo = reqCatalogueService.getBasketServicelistvo(basketvo);
		model.addAttribute("getBasketServicelistvo", getBasketServicelistvo);

		// 장바구니 서비스 백업 리스트 가져오기
//		List<CustomReqBasketVO> getBasketBaklistvo = reqCatalogueService.getBasketBaklistvo(basketvo);
//		model.addAttribute("getBasketBaklistvo", getBasketBaklistvo);

		// 장바구니 서비스 대외계 리스트 가져오기
//		List<CustomReqBasketVO> getBasketMcalistvo = reqCatalogueService.getBasketMcalistvo(basketvo);
//		model.addAttribute("getBasketMcalistvo", getBasketMcalistvo);

		// 장바구니 서비스 형상관리 리스트 가져오기
//		List<CustomReqBasketVO> getBasketScmlistvo = reqCatalogueService.getBasketScmlistvo(basketvo);
//		model.addAttribute("getBasketScmlistvo", getBasketScmlistvo);

		// 장바구니 서비스 보안관제 리스트 가져오기
//		List<CustomReqBasketVO> getBasketSerlistvo = reqCatalogueService.getBasketSerlistvo(basketvo);
//		model.addAttribute("getBasketSerlistvo", getBasketSerlistvo);

		return "mbr/req/catalogue/basketOrder";
	}

	// 카테고리 상품 장바구니 상품 체크박스 삭제 2017.07.27 이윤준 수정
	@RequestMapping(value = "/basketOrder.do", params = "type=chkbasketdel")
	public RedirectView cataloguebasketChkDel(HttpServletRequest request, Model model, CustomReqCatalogueVO ordervo) {

		String basketSeqs = request.getParameter("basketSeq");
		Assert.notNull(basketSeqs, "");

		// bss_basket
		List<String> basketSeqList = new ArrayList<String>();
		String[] basketSeq = basketSeqs.split(",");
		for (String seq : basketSeq) {
			basketSeqList.add(seq);
		}

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("basketSeqList", basketSeqList);
		reqCatalogueService.setChkBasketDel(map); // 선택한 장바구니 삭제
		reqCatalogueService.setChkBasketVmDel(map); // 선택한 장바구니 삭제 vm
		reqCatalogueService.setChkBasketDiskDel(map); // 선택한 장바구니 삭제 disk
		reqCatalogueService.setChkBasketNasDel(map); // 선택한 장바구니 삭제 nas
		reqCatalogueService.setChkBasketLbDel(map); // 선택한 장바구니 삭제 LB(로드밸런스)
		reqCatalogueService.setChkBasketLbNetDel(map);
		reqCatalogueService.setChkBasketIpDel(map); // 선택한 장바구니 삭제 공인 IP
		reqCatalogueService.setChkBasketserviceDel(map);// 선택한 장바구니 삭제 서비스
//		reqCatalogueService.setChkBasketbakDel(map);	// 선택한 장바구니 삭제 서비스 백업
//		reqCatalogueService.setChkBasketScmDel(map);	// 선택한 장바구니 삭제 서비스 형상관리
//		reqCatalogueService.setChkBasketMcaDel(map);	// 선택한 장바구니 삭제	 서비스 공용대외계
//		reqCatalogueService.setChkBasketSerDel(map);	// 선택한 장바구니 삭제	 서비스 통합보안관제

		CustomReqBasketVO basketvo = new CustomReqBasketVO();
		// basketvo.setBasketSeq(basketSeq);
		basketvo.setUserId(request.getUserPrincipal().getName());

		// 장바구니 리스트 가져오기
		List<CustomReqBasketVO> basketlist = reqCatalogueService.getBasketlist(basketvo);
		for (CustomReqBasketVO basketVo : basketlist) { // int i = 0; i < getBasketlistvo.size(); i++) {
			String networkChk = "";
			List<CustomReqBasketVO> basketVmList = reqCatalogueService.getBasketVmList(basketVo.getBasketSeq());
			for (CustomReqBasketVO vmVo : basketVmList) {

				networkChk = networkChk + vmVo.getSharedNetwork();
				networkChk = networkChk + ":" + vmVo.getSharedNetworkName();
				networkChk = networkChk + ":" + vmVo.getSelectedFlag() + ",";
			}
			basketVo.setNetworkChk(networkChk);
		}
		model.addAttribute("getBasketlistvo", basketlist);

		// 장바구니 블록디스크 리스트 가져오기
		List<CustomReqBasketVO> getBasketDisklistvo = reqCatalogueService.getBasketDisklistvo(basketvo);
		model.addAttribute("getBasketDisklistvo", getBasketDisklistvo);

		// 장바구니 NAS 리스트 가져오기
		List<CustomReqBasketVO> getBasketNaslistvo = reqCatalogueService.getBasketNaslistvo(basketvo);
		model.addAttribute("getBasketNaslistvo", getBasketNaslistvo);

		// 장바구니 IP 리스트 가져오기
		List<CustomReqBasketVO> getBasketIplistvo = reqCatalogueService.getBasketIplistvo(basketvo);
		model.addAttribute("getBasketIplistvo", getBasketIplistvo);

		// 장바구니 로드 밸런서 리스트 가져오기
		List<CustomReqBasketVO> getBasketLblistvo = reqCatalogueService.getBasketLblistvo(basketvo);
		model.addAttribute("getBasketLblistvo", getBasketLblistvo);

		// 장바구니 서비스 리스트 가져오기
		List<CustomReqBasketVO> getBasketServicelistvo = reqCatalogueService.getBasketServicelistvo(basketvo);
		model.addAttribute("getBasketServicelistvo", getBasketServicelistvo);

		// 장바구니 서비스 백업 리스트 가져오기
//		List<CustomReqBasketVO> getBasketBaklistvo = reqCatalogueService.getBasketBaklistvo(basketvo);
//		model.addAttribute("getBasketBaklistvo", getBasketBaklistvo);

		// 장바구니 서비스 대외계 리스트 가져오기
//		List<CustomReqBasketVO> getBasketMcalistvo = reqCatalogueService.getBasketMcalistvo(basketvo);
//		model.addAttribute("getBasketMcalistvo", getBasketMcalistvo);

		// 장바구니 서비스 형상관리 리스트 가져오기
//		List<CustomReqBasketVO> getBasketScmlistvo = reqCatalogueService.getBasketScmlistvo(basketvo);
//		model.addAttribute("getBasketScmlistvo", getBasketScmlistvo);

		// 장바구니 서비스 보안관제 리스트 가져오기
//		List<CustomReqBasketVO> getBasketSerlistvo = reqCatalogueService.getBasketSerlistvo(basketvo);
//		model.addAttribute("getBasketSerlistvo", getBasketSerlistvo);

		RedirectView rv = new RedirectView("basketOrder.do");
		rv.setExposeModelAttributes(false);
		return rv;
	}

	// 카테고리 상품 장바구니 상품 삭제
	@RequestMapping(value = "/basketOrder.do", params = "type=basketdel")
	public RedirectView cataloguebasketDel(HttpServletRequest request, Model model) {

		// bss_basket
		String basketSeq = request.getParameter("basketSeq");
		Assert.notNull(basketSeq, "");

		CustomReqBasketVO basketvo = new CustomReqBasketVO();
		basketvo.setBasketSeq(basketSeq);
		basketvo.setUserId(request.getUserPrincipal().getName());

		reqCatalogueService.setBasketDel(basketvo);
		reqCatalogueService.setBasketVmDel(basketvo);

		// 장바구니 리스트 가져오기
		List<CustomReqBasketVO> getBasketlistvo = reqCatalogueService.getBasketlist(basketvo);
		model.addAttribute("getBasketlistvo", getBasketlistvo);

		RedirectView rv = new RedirectView("basketOrder.do");
		rv.setExposeModelAttributes(false);
		return rv;
	}


	// 장바구니 상품 최종 주문시 주문서 이동 입력
	@RequestMapping(value = "/basketOrderNow.do", params = "type=basketorderinsert")
	public ResponseEntity<Object> cataloguebasketOrderInsert(HttpServletRequest request, Model model,
			CustomReqOrderVO ordervo) {
		CustomReqBasketVO basketvo = new CustomReqBasketVO();
		basketvo.setUserId(request.getUserPrincipal().getName());
		StringBuffer alarmContentBuf = new StringBuffer();

		// STEP 1 - 요청부서 결재라인 저
		String currentUserIdReview = "";
		String hiddenUserIdReview = request.getParameter("hiddenUserIdReview");
		String hiddenUserIdApprove = request.getParameter("hiddenUserIdApprove");
		String tmpApprovalStepList = request.getParameter("approvalStepListString");

//		JSONArray jsonArray = new JSONArray(tmpApprovalStepList);
//		List list = new ArrayList<>();
//
//		for (int i = 0; i < jsonArray.length(); i++) {
//			jsonArray.getJSONObject(i);
//			list.add(JsonUtil.toMap(jsonArray.getJSONObject(i)));
//		}

		ordervo.setApprovalStepList(tmpApprovalStepList);

		model.addAttribute("hiddenUserIdReview", hiddenUserIdReview);
		model.addAttribute("hiddenUserIdApprove", hiddenUserIdApprove);

		// STEP2 장바구니 정보 -> 주문정보 이동

		String basketSeqs = request.getParameter("basketSeqs");
		String[] basketSeq = basketSeqs.split(",");
		List<String> basketSeqList = new ArrayList<String>();
		for (int i = 0; i < basketSeq.length; i++) {
			basketSeqList.add(basketSeq[i]);
		}
		Map<String, Object> map = new HashMap<>();
		map.put("basketSeqList", basketSeqList);

		List<CustomReqBasketVO> getBasketlistvo = reqCatalogueService.getBasketOrderList(map);

		String networkChk = "";
		for (int i = 0; i < getBasketlistvo.size(); i++) {
			List<CustomReqBasketVO> getBasketVmList = reqCatalogueService
					.getBasketVmList(getBasketlistvo.get(i).getBasketSeq());

			for (int j = 0; j < getBasketVmList.size(); j++) {

				networkChk = networkChk + getBasketVmList.get(j).getSharedNetwork();
				networkChk = networkChk + ":" + getBasketVmList.get(j).getSharedNetworkName();
				networkChk = networkChk + ":" + getBasketVmList.get(j).getSelectedFlag() + ",";
			}
			getBasketlistvo.get(i).setNetworkChk(networkChk);
			networkChk = "";
		}
		ordervo.setOrderUserId(request.getUserPrincipal().getName());

		// STEP2-1 bss_order 정보 입력
		String orderNo = DateFormatUtils.format(new Date(), "yyyyMMddHHmmss");
		ordervo.setOrderNo(orderNo);

		// 주문정보 저장
		reqCatalogueService.setOrder(ordervo);
		/*
		 * for(int i=0;i<basketSeq.length;i++) { log.debug("basketSeq : "+
		 * basketSeq[i]); basketSeqList.add(basketSeq[i]); }
		 * log.debug("basketSeqList : "+ basketSeqList);
		 * map.put("basketSeqList", basketSeqList);
		 */

		// STEP2-2 VM 정보 이동
		for (int i = 0; i < getBasketlistvo.size(); i++) {
			CustomReqOrderVO basketordervo = new CustomReqOrderVO();
			basketordervo.setOrderProductSeq(getBasketlistvo.get(i).getBasketSeq());
			basketordervo.setOrderNo(ordervo.getOrderNo());
			basketordervo.setRequestType(getBasketlistvo.get(i).getRequestType());
			basketordervo.setProductCategory(getBasketlistvo.get(i).getProductCategory());
			basketordervo.setOrderSummary(getBasketlistvo.get(i).getBasketSummary());
			basketordervo.setHourlyFlag(getBasketlistvo.get(i).getHourlyFlag());
			basketordervo.setAmount(getBasketlistvo.get(i).getAmount());
			basketordervo.setOnDemandFlag(getBasketlistvo.get(i).getOnDemandFlag());
			basketordervo.setApplyDatetime(getBasketlistvo.get(i).getApplyDatetime());
			basketordervo.setProjectId(getBasketlistvo.get(i).getProjectId());
			basketordervo.setDefaultNetworkId(getBasketlistvo.get(i).getDefaultNetworkId());
			basketordervo.setDefaultNetworkName(getBasketlistvo.get(i).getDefaultNetworkName());
			basketordervo.setDefaultNetworkAlias(getBasketlistvo.get(i).getDefaultNetworkAlias());
			basketordervo.setBackupNetworkFlag(getBasketlistvo.get(i).getBackupNetworkFlag());

			basketordervo.setHostname(getBasketlistvo.get(i).getHostname());
			basketordervo.setHostnameAlias(getBasketlistvo.get(i).getHostnameAlias());
			basketordervo.setFlavorId(getBasketlistvo.get(i).getFlavorId());
			basketordervo.setVcpus(getBasketlistvo.get(i).getVcpus());
			basketordervo.setMemGb(getBasketlistvo.get(i).getMemGb());
			basketordervo.setDiskGb(getBasketlistvo.get(i).getVmDiskGb());
			basketordervo.setVolumeType(getBasketlistvo.get(i).getVolumeType());
			basketordervo.setAzName(getBasketlistvo.get(i).getAzName());
			basketordervo.setVmProductSeq(getBasketlistvo.get(i).getVmProductSeq());

			basketordervo.setVmProductSeq(getBasketlistvo.get(i).getVmProductSeq());
			basketordervo.setProductSeq(getBasketlistvo.get(i).getVmProductSeq());

			basketordervo.setOsProductSeq(getBasketlistvo.get(i).getOsProductSeq());
			basketordervo.setHourlyFlag(getBasketlistvo.get(i).getHourlyFlag());
			basketordervo.setReqMessage(getBasketlistvo.get(i).getReqMessage());
			basketordervo.setDescription(getBasketlistvo.get(i).getDescription());
			basketordervo.setVmUuid(getBasketlistvo.get(i).getVmUuid());
			basketordervo.setBeforeFlavorId(getBasketlistvo.get(i).getBeforeFlavorId());
			basketordervo.setBeforeVcpus(getBasketlistvo.get(i).getBeforeVcpus());
			basketordervo.setBeforeMemGb(getBasketlistvo.get(i).getBeforeMemGb());
			basketordervo.setCatalogSeq(getBasketlistvo.get(i).getCatalogSeq());
			basketordervo.setImageId(getBasketlistvo.get(i).getImageId());
			basketordervo.setCloudId(getBasketlistvo.get(i).getCloudId());
			basketordervo.setDatastoreId(getBasketlistvo.get(i).getDatastoreId());

			basketordervo.setInstanceType(getBasketlistvo.get(i).getInstanceType());

			ordervo.setProjectId(basketordervo.getProjectId());

			reqCatalogueService.setOrderProduct(basketordervo);
			reqCatalogueService.setOrderProductVm(basketordervo);

			basketvo.setBasketSeq(getBasketlistvo.get(i).getBasketSeq());
			reqCatalogueService.setBasketDel(basketvo);
			reqCatalogueService.setBasketVmDel(basketvo);

			alarmContentBuf.append("<p> 호스트명 : ").append(getBasketlistvo.get(i).getHostnameAlias()).append("</p>");

			/*
			 * List<CustomReqBasketVO> getBasketVmList =
			 * reqCatalogueService.getBasketVmList(getBasketlistvo.get(i).getBasketSeq());
			 * //network_vm 추가 for (int j = 0; j < getBasketVmList.size(); j++) {
			 * CustomReqOrderVO setNetworkVm = new CustomReqOrderVO();
			 * setNetworkVm.setSharedNetwork(getBasketVmList.get(j).getSharedNetwork());
			 * setNetworkVm.setSharedNetworkName(getBasketVmList.get(j).getSharedNetworkName
			 * ()); setNetworkVm.setSelectedFlag(getBasketVmList.get(j).getSelectedFlag());
			 * setNetworkVm.setOrderProductSeq(getBasketlistvo.get(i).getBasketSeq());
			 * reqCatalogueService.setOrderProductVmNetwork(setNetworkVm);
			 *
			 * } String setBasketVmNetwork =
			 * reqCatalogueService.setBasketVmNetworkDel(basketvo);
			 */

		}

		// 디스크 주문서 입력
		List<CustomReqBasketVO> getBasketDisklistvo = reqCatalogueService.getBasketDiskOrderList(map);
		for (int i = 0; i < getBasketDisklistvo.size(); i++) {
			CustomReqOrderVO basketordervo = new CustomReqOrderVO();

			basketordervo.setOrderProductSeq(getBasketDisklistvo.get(i).getBasketSeq());
			basketordervo.setOrderNo(ordervo.getOrderNo());
			basketordervo.setRequestType(getBasketDisklistvo.get(i).getRequestType());
			basketordervo.setProductCategory(getBasketDisklistvo.get(i).getProductCategory());
			basketordervo.setOrderSummary(getBasketDisklistvo.get(i).getBasketSummary());
			basketordervo.setHourlyFlag(getBasketDisklistvo.get(i).getHourlyFlag());
			basketordervo.setAmount(getBasketDisklistvo.get(i).getAmount());
			basketordervo.setOnDemandFlag(getBasketDisklistvo.get(i).getOnDemandFlag());
			basketordervo.setApplyDatetime(getBasketDisklistvo.get(i).getApplyDatetime());
			basketordervo.setProjectId(getBasketDisklistvo.get(i).getProjectId());

			basketordervo.setVmUuid(getBasketDisklistvo.get(i).getVmUuid());
			basketordervo.setDiskName(getBasketDisklistvo.get(i).getDiskName());
			basketordervo.setDiskType(getBasketDisklistvo.get(i).getDiskType());
			basketordervo.setDiskProductSeq(getBasketDisklistvo.get(i).getDiskProductSeq());
			basketordervo.setDiskGb(getBasketDisklistvo.get(i).getDiskGb());

			basketordervo.setHourlyFlag(getBasketDisklistvo.get(i).getHourlyFlag());
			basketordervo.setDescription(getBasketDisklistvo.get(i).getDescription());

			basketordervo.setCatalogSeq(getBasketDisklistvo.get(i).getCatalogSeq());
			basketordervo.setBeforeDiskGb(getBasketDisklistvo.get(i).getBeforeDiskGb());
			basketordervo.setDiskCatalogSeq(getBasketDisklistvo.get(i).getDiskCatalogSeq());
			basketordervo.setDiskId(getBasketDisklistvo.get(i).getDiskId());
			basketordervo.setCloudId(getBasketDisklistvo.get(i).getCloudId());
			basketordervo.setVmdkFile(getBasketDisklistvo.get(i).getVmdkFile());
			ordervo.setProjectId(basketordervo.getProjectId());

			reqCatalogueService.setOrderProduct(basketordervo);
			reqCatalogueService.setOrderProductDisk(basketordervo);

			basketvo.setBasketSeq(getBasketDisklistvo.get(i).getBasketSeq());
			reqCatalogueService.setBasketDel(basketvo);
			reqCatalogueService.setBasketDiskDel(basketvo);

			alarmContentBuf.append("<p> 디스크명 : ").append(getBasketDisklistvo.get(i).getDiskName()).append("</p>");
		}

		// NAS 주문서 입력
		List<CustomReqBasketVO> getBasketNaslistvo = reqCatalogueService.getBasketNasOrderList(map);
		for (int i = 0; i < getBasketNaslistvo.size(); i++) {
			CustomReqOrderVO basketordervo = new CustomReqOrderVO();

			basketordervo.setOrderProductSeq(getBasketNaslistvo.get(i).getBasketSeq());
			basketordervo.setOrderNo(ordervo.getOrderNo());
			basketordervo.setRequestType(getBasketNaslistvo.get(i).getRequestType());
			basketordervo.setProductCategory(getBasketNaslistvo.get(i).getProductCategory());
			basketordervo.setOrderSummary(getBasketNaslistvo.get(i).getBasketSummary());
			basketordervo.setHourlyFlag(getBasketNaslistvo.get(i).getHourlyFlag());
			basketordervo.setAmount(getBasketNaslistvo.get(i).getAmount());
			basketordervo.setOnDemandFlag(getBasketNaslistvo.get(i).getOnDemandFlag());
			basketordervo.setApplyDatetime(getBasketNaslistvo.get(i).getApplyDatetime());
			basketordervo.setProjectId(getBasketNaslistvo.get(i).getProjectId());

			basketordervo.setNasName(getBasketNaslistvo.get(i).getNasName());
			basketordervo.setNasAlias(getBasketNaslistvo.get(i).getNasName());
			basketordervo.setNasNfsObjectId(getBasketNaslistvo.get(i).getNasNfsObjectId());
			basketordervo.setNasFileSystemPath(getBasketNaslistvo.get(i).getNasFileSystemPath());
			basketordervo.setNasGb(getBasketNaslistvo.get(i).getNasGb());
			basketordervo.setNasProductSeq(getBasketNaslistvo.get(i).getNasProductSeq());

			basketordervo.setVmUuid(getBasketNaslistvo.get(i).getVmUuid());
			basketordervo.setVmName(getBasketNaslistvo.get(i).getVmName());
			basketordervo.setNasVmServer(getBasketNaslistvo.get(i).getVmName());
			basketordervo.setNasVmIp(getBasketNaslistvo.get(i).getVmName());

			basketordervo.setHourlyFlag(getBasketNaslistvo.get(i).getHourlyFlag());
			basketordervo.setDescription(getBasketNaslistvo.get(i).getDescription());

			basketordervo.setNasCatalogSeq(getBasketNaslistvo.get(i).getCatalogSeq());
			basketordervo.setNasId(getBasketNaslistvo.get(i).getNasId());
			basketordervo.setBeforeNasGb(getBasketNaslistvo.get(i).getBeforeNasGb());
			basketordervo.setCloudId(getBasketNaslistvo.get(i).getCloudId());
			ordervo.setProjectId(basketordervo.getProjectId());


			reqCatalogueService.setOrderProduct(basketordervo);
			reqCatalogueService.setOrderProductNas(basketordervo);

			if (!"openshift".equals(getBasketNaslistvo.get(i).getCloudType())) {
				reqCatalogueService.setOrderProductNasVm(basketordervo);
			}

			basketvo.setBasketSeq(getBasketNaslistvo.get(i).getBasketSeq());
			reqCatalogueService.setBasketDel(basketvo);
			reqCatalogueService.setBasketNasDel(basketvo);

			alarmContentBuf.append("<p> NAS 명 : ").append(getBasketNaslistvo.get(i).getNasName()).append("</p>");
		}

		// 공인IP 주문서 입력
		List<CustomReqBasketVO> getBasketIplistvo = reqCatalogueService.getBasketIpOrderList(map);
		for (int i = 0; i < getBasketIplistvo.size(); i++) {
			CustomReqOrderVO basketordervo = new CustomReqOrderVO();

			basketordervo.setOrderProductSeq(getBasketIplistvo.get(i).getBasketSeq());
			basketordervo.setOrderNo(ordervo.getOrderNo());
			basketordervo.setRequestType(getBasketIplistvo.get(i).getRequestType());
			basketordervo.setProductCategory(getBasketIplistvo.get(i).getProductCategory());
			basketordervo.setOrderSummary(getBasketIplistvo.get(i).getBasketSummary());
			basketordervo.setHourlyFlag(getBasketIplistvo.get(i).getHourlyFlag());
			basketordervo.setAmount(getBasketIplistvo.get(i).getAmount());
			basketordervo.setOnDemandFlag(getBasketIplistvo.get(i).getOnDemandFlag());
			basketordervo.setApplyDatetime(getBasketIplistvo.get(i).getApplyDatetime());
			basketordervo.setProjectId(getBasketIplistvo.get(i).getProjectId());

			basketordervo.setVmUuid(getBasketIplistvo.get(i).getVmUuid());
			basketordervo.setProjectId(getBasketIplistvo.get(i).getProjectId());
			basketordervo.setPublicipProductSeq(getBasketIplistvo.get(i).getPublicipProductSeq());

			basketordervo.setHourlyFlag(getBasketIplistvo.get(i).getHourlyFlag());
			basketordervo.setDescription(getBasketIplistvo.get(i).getDescription());

			basketordervo.setCatalogSeq(getBasketIplistvo.get(i).getCatalogSeq());
			basketordervo.setPublicipId(getBasketIplistvo.get(i).getPublicipId());
			basketordervo.setCloudId(getBasketlistvo.get(i).getCloudId());
			ordervo.setProjectId(basketordervo.getProjectId());

			reqCatalogueService.setOrderProduct(basketordervo);
			reqCatalogueService.setOrderProductIp(basketordervo);

			basketvo.setBasketSeq(getBasketIplistvo.get(i).getBasketSeq());
			reqCatalogueService.setBasketDel(basketvo);
			reqCatalogueService.setBasketIpDel(basketvo);
		}

		// 로드 밸런서 주문서 입력
		List<CustomReqBasketVO> getBasketLblistvo = reqCatalogueService.getBasketLbOrderList(map);
		for (int i = 0; i < getBasketLblistvo.size(); i++) {
			CustomReqOrderVO basketordervo = new CustomReqOrderVO();

			basketordervo.setOrderProductSeq(getBasketLblistvo.get(i).getBasketSeq());
			basketordervo.setOrderNo(ordervo.getOrderNo());
			basketordervo.setRequestType(getBasketLblistvo.get(i).getRequestType());
			basketordervo.setProductCategory(getBasketLblistvo.get(i).getProductCategory());
			basketordervo.setOrderSummary(getBasketLblistvo.get(i).getBasketSummary());
			basketordervo.setHourlyFlag(getBasketLblistvo.get(i).getHourlyFlag());
			basketordervo.setAmount(getBasketLblistvo.get(i).getAmount());
			basketordervo.setOnDemandFlag(getBasketLblistvo.get(i).getOnDemandFlag());
			basketordervo.setApplyDatetime(getBasketLblistvo.get(i).getApplyDatetime());
			basketordervo.setProjectId(getBasketLblistvo.get(i).getProjectId());

			basketordervo.setDefaultNetworkId(getBasketLblistvo.get(i).getDefaultNetworkId());
			basketordervo.setLoadbalancerName(getBasketLblistvo.get(i).getLoadbalancerName());
			basketordervo.setLoadbalancerEa(getBasketLblistvo.get(i).getLoadbalancerEa());
			basketordervo.setMethod(getBasketLblistvo.get(i).getMethod());
			basketordervo.setProtocol(getBasketLblistvo.get(i).getProtocol());
			basketordervo.setMonitorType(getBasketLblistvo.get(i).getMonitorType());
			basketordervo.setLoadbalancerProductSeq(getBasketLblistvo.get(i).getLoadbalancerProductSeq());

			basketordervo.setDescription(getBasketLblistvo.get(i).getDescription());

			basketordervo.setCatalogSeq(getBasketLblistvo.get(i).getCatalogSeq());
			basketordervo.setLoadbalancerId(getBasketLblistvo.get(i).getLoadbalancerId());
			basketordervo.setCloudId(getBasketlistvo.get(i).getCloudId());
			ordervo.setProjectId(basketordervo.getProjectId());

			reqCatalogueService.setOrderProduct(basketordervo);
			reqCatalogueService.setOrderProductLb(basketordervo);

			List<CustomReqBasketVO> getBasketLbNetList = reqCatalogueService
					.getBasketLbNetList(getBasketLblistvo.get(i).getBasketSeq());
			// bss_basket_loadbalancer_vm 추가
			for (int j = 0; j < getBasketLbNetList.size(); j++) {
				CustomReqOrderVO setLbNetworkVm = new CustomReqOrderVO();
				setLbNetworkVm.setOrderProductSeq((getBasketLbNetList.get(j).getBasketSeq()));
				setLbNetworkVm.setVmUuid(getBasketLbNetList.get(j).getVmUuid());
				reqCatalogueService.setOrderProductLbVm(setLbNetworkVm);
			}
			basketvo.setBasketSeq(getBasketLblistvo.get(i).getBasketSeq());
			reqCatalogueService.setBasketDel(basketvo);
			reqCatalogueService.setBasketLbDel(basketvo);
			reqCatalogueService.setBasketLbVmDel(basketvo);
		}

		// 서비스 주문서 입력
		List<CustomReqBasketVO> getBasketServicelistvo = reqCatalogueService.getBasketServiceOrderList(map);
		for (int i = 0; i < getBasketServicelistvo.size(); i++) {
			CustomReqOrderVO basketordervo = new CustomReqOrderVO();

			basketordervo.setOrderProductSeq(getBasketServicelistvo.get(i).getBasketSeq());
			basketordervo.setOrderNo(ordervo.getOrderNo());
			basketordervo.setRequestType(getBasketServicelistvo.get(i).getRequestType());
			basketordervo.setProductCategory(getBasketServicelistvo.get(i).getProductCategory());
			basketordervo.setOrderSummary(getBasketServicelistvo.get(i).getBasketSummary());
			basketordervo.setHourlyFlag(getBasketServicelistvo.get(i).getHourlyFlag());
			basketordervo.setAmount(getBasketServicelistvo.get(i).getAmount());
			basketordervo.setOnDemandFlag(getBasketServicelistvo.get(i).getOnDemandFlag());
			basketordervo.setApplyDatetime(getBasketServicelistvo.get(i).getApplyDatetime());
			basketordervo.setProjectId(getBasketServicelistvo.get(i).getProjectId());

			basketordervo.setVmUuid(getBasketServicelistvo.get(i).getVmUuid());
			basketordervo.setProjectId(getBasketServicelistvo.get(i).getProjectId());
			basketordervo.setProductSeq(getBasketServicelistvo.get(i).getProductSeq());

			basketordervo.setHourlyFlag(getBasketServicelistvo.get(i).getHourlyFlag());
			basketordervo.setDescription(getBasketServicelistvo.get(i).getDescription());
//							basketordervo.setBackupId(getBasketBaklistvo.get(i).getBackupId());
			basketordervo.setServiceId(getBasketServicelistvo.get(i).getServiceId());

			basketordervo.setCatalogSeq(getBasketServicelistvo.get(i).getCatalogSeq());
			basketordervo.setServiceType(getBasketServicelistvo.get(i).getServiceType());
			basketordervo.setServiceName(getBasketServicelistvo.get(i).getServiceName());

			basketordervo.setCloudId(getBasketServicelistvo.get(i).getCloudId());
			ordervo.setProjectId(basketordervo.getProjectId());

			reqCatalogueService.setOrderProduct(basketordervo);
//					reqCatalogueService.setOrderProductServiceBak(basketordervo);
			reqCatalogueService.setOrderProductServiceService(basketordervo);

			// 2017.08.23 이윤준 추가
//			List<CustomReqBasketVO> getBasketBackVmList = reqCatalogueService.getBasketBackVmList(getBasketServicelistvo.get(i).getBasketSeq());
//			List<CustomReqBasketVO> getBasketBackVmList = reqCatalogueService.getBasketServiceVmList(getBasketServicelistvo.get(i).getBasketSeq());
//			for (int j = 0; j < getBasketBackVmList.size(); j++) {
//				CustomReqOrderVO setBackupVm = new CustomReqOrderVO();
//				setBackupVm.setOrderProductSeq(getBasketBackVmList.get(j).getBasketSeq());
//				setBackupVm.setVmUuid(getBasketBackVmList.get(j).getVmUuid());
//				reqCatalogueService.setOrderBackVm(setBackupVm);
//			}

			basketvo.setBasketSeq(getBasketServicelistvo.get(i).getBasketSeq());
			reqCatalogueService.setBasketDel(basketvo);
			// 서비스 장바구니 신청후 DELETE
//			reqCatalogueService.setBasketbakDel(basketvo);
//			reqCatalogueService.setBasketbakDel(basketvo);
//			reqCatalogueService.setBasketBackupVmDel(basketvo);

			alarmContentBuf.append("<p> 서비스 명 : ").append(getBasketServicelistvo.get(i).getServiceName())
					.append("</p>");
		}

		// 대외계 주문서 입력기
//		List<CustomReqBasketVO> getBasketMcalistvo = reqCatalogueService.getBasketMcaOrderList(map);
//		for(int i=0;i<getBasketMcalistvo.size();i++){
//			CustomReqOrderVO basketordervo = new CustomReqOrderVO();
//
//			basketordervo.setOrderProductSeq(getBasketMcalistvo.get(i).getBasketSeq());
//			basketordervo.setOrderNo(ordervo.getOrderNo());
//			basketordervo.setRequestType(getBasketMcalistvo.get(i).getRequestType());
//			basketordervo.setProductCategory(getBasketMcalistvo.get(i).getProductCategory());
//			basketordervo.setOrderSummary(getBasketMcalistvo.get(i).getBasketSummary());
//			basketordervo.setHourlyFlag(getBasketMcalistvo.get(i).getHourlyFlag());
//			basketordervo.setAmount(getBasketMcalistvo.get(i).getAmount());
//			basketordervo.setOnDemandFlag(getBasketMcalistvo.get(i).getOnDemandFlag());
//			basketordervo.setApplyDatetime(getBasketMcalistvo.get(i).getApplyDatetime());
//			basketordervo.setProjectId(getBasketMcalistvo.get(i).getProjectId());
//
//			//basketordervo.setVmUuid(getBasketMcalistvo.get(i).getVmUuid());
//			basketordervo.setProjectId(getBasketMcalistvo.get(i).getProjectId());
//			basketordervo.setProductSeq(getBasketMcalistvo.get(i).getMcaProductSeq());
//
//			basketordervo.setHourlyFlag(getBasketMcalistvo.get(i).getHourlyFlag());
//			basketordervo.setDescription(getBasketMcalistvo.get(i).getDescription());
//			basketordervo.setMcaId(getBasketMcalistvo.get(i).getMcaId());
//			basketordervo.setCloudId(getBasketlistvo.get(i).getCloudId());
//			basketordervo.setCatalogSeq(getBasketMcalistvo.get(i).getCatalogSeq());
//			ordervo.setProjectId(basketordervo.getProjectId());
//
//			reqCatalogueService.setOrderProduct(basketordervo);
//			reqCatalogueService.setOrderProductMca(basketordervo);
//
//			basketvo.setBasketSeq(getBasketMcalistvo.get(i).getBasketSeq());
//			reqCatalogueService.setBasketDel(basketvo);
//			reqCatalogueService.setBasketMcaDel(basketvo);
//		}

		// 형상관리 주문서 입력기
//		List<CustomReqBasketVO> getBasketScmlistvo = reqCatalogueService.getBasketScmOrderList(map);
//		for(int i=0;i<getBasketScmlistvo.size();i++){
//			CustomReqOrderVO basketordervo = new CustomReqOrderVO();
//
//			basketordervo.setOrderProductSeq(getBasketScmlistvo.get(i).getBasketSeq());
//			basketordervo.setOrderNo(ordervo.getOrderNo());
//			basketordervo.setRequestType(getBasketScmlistvo.get(i).getRequestType());
//			basketordervo.setProductCategory(getBasketScmlistvo.get(i).getProductCategory());
//			basketordervo.setOrderSummary(getBasketScmlistvo.get(i).getBasketSummary());
//			basketordervo.setHourlyFlag(getBasketScmlistvo.get(i).getHourlyFlag());
//			basketordervo.setAmount(getBasketScmlistvo.get(i).getAmount());
//			basketordervo.setOnDemandFlag(getBasketScmlistvo.get(i).getOnDemandFlag());
//			basketordervo.setApplyDatetime(getBasketScmlistvo.get(i).getApplyDatetime());
//			basketordervo.setProjectId(getBasketScmlistvo.get(i).getProjectId());
//
//			//basketordervo.setVmUuid(getBasketMcalistvo.get(i).getVmUuid());
//			basketordervo.setProjectId(getBasketScmlistvo.get(i).getProjectId());
//			basketordervo.setProductSeq(getBasketScmlistvo.get(i).getScmProductSeq());
//
//			basketordervo.setHourlyFlag(getBasketScmlistvo.get(i).getHourlyFlag());
//			basketordervo.setDescription(getBasketScmlistvo.get(i).getDescription());
//
//			basketordervo.setCatalogSeq(getBasketScmlistvo.get(i).getCatalogSeq());
//			basketordervo.setScmId(getBasketScmlistvo.get(i).getScmId());
//			basketordervo.setCloudId(getBasketlistvo.get(i).getCloudId());
//			ordervo.setProjectId(basketordervo.getProjectId());
//
//			reqCatalogueService.setOrderProduct(basketordervo);
//			reqCatalogueService.setOrderProductServiceScm(basketordervo);
//
//			basketvo.setBasketSeq(getBasketScmlistvo.get(i).getBasketSeq());
//			reqCatalogueService.setBasketDel(basketvo);
//			reqCatalogueService.setBasketScmDel(basketvo);
//		}

		// 보안관제 주문서 입력기
//		List<CustomReqBasketVO> getBasketSerlistvo = reqCatalogueService.getBasketScrOrderList(map);
//		for(int i=0;i<getBasketSerlistvo.size();i++){
//			CustomReqOrderVO basketordervo = new CustomReqOrderVO();
//
//			basketordervo.setOrderProductSeq(getBasketSerlistvo.get(i).getBasketSeq());
//			basketordervo.setOrderNo(ordervo.getOrderNo());
//			basketordervo.setRequestType(getBasketSerlistvo.get(i).getRequestType());
//			basketordervo.setProductCategory(getBasketSerlistvo.get(i).getProductCategory());
//			basketordervo.setOrderSummary(getBasketSerlistvo.get(i).getBasketSummary());
//			basketordervo.setHourlyFlag(getBasketSerlistvo.get(i).getHourlyFlag());
//			basketordervo.setAmount(getBasketSerlistvo.get(i).getAmount());
//			basketordervo.setOnDemandFlag(getBasketSerlistvo.get(i).getOnDemandFlag());
//			basketordervo.setApplyDatetime(getBasketSerlistvo.get(i).getApplyDatetime());
//			basketordervo.setProjectId(getBasketSerlistvo.get(i).getProjectId());
//
//			//basketordervo.setVmUuid(getBasketMcalistvo.get(i).getVmUuid());
//			basketordervo.setProjectId(getBasketSerlistvo.get(i).getProjectId());
//			basketordervo.setProductSeq(getBasketSerlistvo.get(i).getSecurityProductSeq());
//
//			basketordervo.setHourlyFlag(getBasketSerlistvo.get(i).getHourlyFlag());
//			basketordervo.setDescription(getBasketSerlistvo.get(i).getDescription());
//
//			basketordervo.setCatalogSeq(getBasketSerlistvo.get(i).getCatalogSeq());
//			basketordervo.setSecurityId(getBasketSerlistvo.get(i).getSecurityId());
//			basketordervo.setCloudId(getBasketlistvo.get(i).getCloudId());
//			ordervo.setProjectId(basketordervo.getProjectId());
//
//			reqCatalogueService.setOrderProduct(basketordervo);
//			reqCatalogueService.setOrderProductServiceScr(basketordervo);
//
//			basketvo.setBasketSeq(getBasketSerlistvo.get(i).getBasketSeq());
//			reqCatalogueService.setBasketDel(basketvo);
//			reqCatalogueService.setBasketSerDel(basketvo);
//		}
		// 서비스 백업 주문서 입력
//		List<CustomReqBasketVO> getBasketBaklistvo = reqCatalogueService.getBasketBakOrderList(map);
//		for(int i=0;i<getBasketBaklistvo.size();i++){
//			CustomReqOrderVO basketordervo = new CustomReqOrderVO();
//
//			basketordervo.setOrderProductSeq(getBasketBaklistvo.get(i).getBasketSeq());
//			basketordervo.setOrderNo(ordervo.getOrderNo());
//			basketordervo.setRequestType(getBasketBaklistvo.get(i).getRequestType());
//			basketordervo.setProductCategory(getBasketBaklistvo.get(i).getProductCategory());
//			basketordervo.setOrderSummary(getBasketBaklistvo.get(i).getBasketSummary());
//			basketordervo.setHourlyFlag(getBasketBaklistvo.get(i).getHourlyFlag());
//			basketordervo.setAmount(getBasketBaklistvo.get(i).getAmount());
//			basketordervo.setOnDemandFlag(getBasketBaklistvo.get(i).getOnDemandFlag());
//			basketordervo.setApplyDatetime(getBasketBaklistvo.get(i).getApplyDatetime());
//			basketordervo.setProjectId(getBasketBaklistvo.get(i).getProjectId());
//
//			basketordervo.setVmUuid(getBasketBaklistvo.get(i).getVmUuid());
//			basketordervo.setProjectId(getBasketBaklistvo.get(i).getProjectId());
//			basketordervo.setProductSeq(getBasketBaklistvo.get(i).getBackupProductSeq());
//
//			basketordervo.setHourlyFlag(getBasketBaklistvo.get(i).getHourlyFlag());
//			basketordervo.setDescription(getBasketBaklistvo.get(i).getDescription());
//			basketordervo.setBackupId(getBasketBaklistvo.get(i).getBackupId());
//			basketordervo.setCloudId(getBasketlistvo.get(i).getCloudId());
//			basketordervo.setCatalogSeq(getBasketBaklistvo.get(i).getCatalogSeq());
//			ordervo.setProjectId(basketordervo.getProjectId());
//
//			log.debug("ordervo.getCatalogSeq() : " + getBasketBaklistvo.get(i).getCatalogSeq());
//			log.debug("basketordervo.getCatalogSeq() : " + basketordervo.getCatalogSeq());
//
//			reqCatalogueService.setOrderProduct(basketordervo);
//			reqCatalogueService.setOrderProductServiceBak(basketordervo);
//
//			//2017.08.23 이윤준 추가
//			List<CustomReqBasketVO> getBasketBackVmList = reqCatalogueService.getBasketBackVmList(getBasketBaklistvo.get(i).getBasketSeq());
//			for (int j = 0; j < getBasketBackVmList.size(); j++) {
//				CustomReqOrderVO setBackupVm = new CustomReqOrderVO();
//				setBackupVm.setOrderProductSeq(getBasketBackVmList.get(j).getBasketSeq());
//				setBackupVm.setVmUuid(getBasketBackVmList.get(j).getVmUuid());
//				reqCatalogueService.setOrderBackVm(setBackupVm);
//			}
//
//			basketvo.setBasketSeq(getBasketBaklistvo.get(i).getBasketSeq());
//			reqCatalogueService.setBasketDel(basketvo);
//			reqCatalogueService.setBasketbakDel(basketvo);
//			reqCatalogueService.setBasketBackupVmDel(basketvo);
//		}

		// 2020.05.25(장중일) - 기존 결재라인 등록 부분
		/*
		 *
		 * List<CustomReqCustomerVO> getApprovalModelSteplist =
		 * reqCatalogueService.getApprovalModelSteplist2(); for(int
		 * i=0;i<getApprovalModelSteplist.size();i++){ CustomReqCustomerVO appmodelstep
		 * = new CustomReqCustomerVO();
		 * appmodelstep.setRequestSeq(ordervo.getOrderNo());
		 * appmodelstep.setStepId(getApprovalModelSteplist.get(i).getStepId());
		 * appmodelstep.setModelId(getApprovalModelSteplist.get(i).getModelId());
		 * appmodelstep.setStepName(getApprovalModelSteplist.get(i).getStepName());
		 * appmodelstep.setStepLevel(getApprovalModelSteplist.get(i).getStepLevel());
		 * appmodelstep.setLeftStepId(getApprovalModelSteplist.get(i).getLeftStepId());
		 * appmodelstep.setRightStepId(getApprovalModelSteplist.get(i).getRightStepId())
		 * ; if(appmodelstep.getStepLevel().equals("1")){
		 * appmodelstep.setApprvState("APPRV_PROCESSING");
		 * appmodelstep.setApprvScheduleUserId(hiddenUserIdReview); }else
		 * if(appmodelstep.getStepLevel().equals("2")){
		 * appmodelstep.setApprvState("APPRV_WAITING");
		 * appmodelstep.setApprvScheduleUserId(hiddenUserIdApprove); }else{
		 * appmodelstep.setApprvState("APPRV_WAITING"); }
		 * reqCatalogueService.setSrApprovalStepinsert2(appmodelstep); }
		 *
		 * CustomReqCatalogueVO getProjectId =
		 * reqCatalogueService.getProjectId(ordervo.getProjectId());
		 * List<CustomReqCustomerVO> getApprovalModelMemberlist =
		 * reqCatalogueService.getApprovalModelMemberlist2(); for(int
		 * i=0;i<getApprovalModelMemberlist.size();i++){ CustomReqCustomerVO appmember =
		 * new CustomReqCustomerVO(); appmember.setRequestSeq(ordervo.getOrderNo());
		 * appmember.setStepId(getApprovalModelMemberlist.get(i).getStepId());
		 * appmember.setUserId(getApprovalModelMemberlist.get(i).getUserId());
		 * appmember.setApprvAuthFlag(getApprovalModelMemberlist.get(i).getApprvAuthFlag
		 * ());
		 * appmember.setMailRecvFlag(getApprovalModelMemberlist.get(i).getMailRecvFlag()
		 * );
		 * appmember.setSmsRecvFlag(getApprovalModelMemberlist.get(i).getSmsRecvFlag());
		 * appmember.setPushRecvFlag(getApprovalModelMemberlist.get(i).getPushRecvFlag()
		 * );
		 *
		 * if(appmember.getStepId().equals("WF1000A0") && hiddenUserIdReview !=null){
		 * appmember.setUserId(hiddenUserIdReview);
		 * ordervo.setUserId(hiddenUserIdReview); }
		 * if(appmember.getStepId().equals("WF1000B0") && hiddenUserIdApprove !=null){
		 * appmember.setUserId(hiddenUserIdApprove);
		 * ordervo.setUserId(hiddenUserIdApprove); } ordervo.setOrderNo(orderNo);
		 *
		 * //1차 2차 승인자 체크후 insert int reviewChk =
		 * reqCatalogueService.reviewChk(ordervo); int approveChk =
		 * reqCatalogueService.approveChk(ordervo);
		 *
		 * if(reviewChk == 0 && appmember.getStepId().equals("WF1000A0")){
		 * reqCatalogueService.setSrApprovalMemberinsert2(appmember); }else
		 * if(approveChk == 0 && appmember.getStepId().equals("WF1000B0")){
		 * reqCatalogueService.setSrApprovalMemberinsert2(appmember); }else
		 * if(!appmember.getStepId().equals("WF1000A0") &&
		 * !appmember.getStepId().equals("WF1000B0")) {
		 * reqCatalogueService.setSrApprovalMemberinsert2(appmember); } }
		 */

		// 2020.05.25(장중일) - 신규 결재라인 등록 부분
		// 지정된 결재자 정보
				List<Map<String, Object>> stepList = ordervo.getApprovalStepList();
				// 결재라인 정보
				List<CustomReqCustomerVO> getApprovalModelSteplist = reqCatalogueService.getApprovalModelSteplist2();

				int tmpStep = 0;
				boolean tmpStartFlag = false;
				if(ordervo.getSelectApprv().equals("Y") && ordervo.getApprvPass().equals("Y")) {
					for(CustomReqCustomerVO customerVO : getApprovalModelSteplist) {
						UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
						CustomReqCustomerVO paramStepInfo = new CustomReqCustomerVO();
						paramStepInfo.setRequestSeq(ordervo.getOrderNo());
						paramStepInfo.setStepId(customerVO.getStepId());
						paramStepInfo.setModelId(customerVO.getModelId());
						paramStepInfo.setStepName(customerVO.getStepName());
						paramStepInfo.setStepLevel(customerVO.getStepLevel());
						paramStepInfo.setLeftStepId(customerVO.getLeftStepId());
						paramStepInfo.setRightStepId(customerVO.getRightStepId());

						if(tmpStep < 5) {
							paramStepInfo.setApprvUserId(userSession.getUsername());
							paramStepInfo.setApprvUserName(userSession.getNickname());
							paramStepInfo.setApprvScheduleUserId(userSession.getUsername());
							paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_COMPLETED);
						} else {
							if(tmpStep == 5) {
								paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_UNASSIGNED);
							} else {
								paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_WAITING);
							}
						}
						tmpStep++;
						reqCatalogueService.setSrApprovalStepinsert2(paramStepInfo);

						if(tmpStep < 3) { tmpStep++; }
					}
				} else {
					for(CustomReqCustomerVO customerVO : getApprovalModelSteplist) {
						HashMap<String, Object> stepInfo = (HashMap<String, Object>) stepList.get(tmpStep);

						CustomReqCustomerVO paramStepInfo = new CustomReqCustomerVO();
						paramStepInfo.setRequestSeq(ordervo.getOrderNo());
						paramStepInfo.setStepId(customerVO.getStepId());
						paramStepInfo.setModelId(customerVO.getModelId());
						paramStepInfo.setStepName(customerVO.getStepName());
						paramStepInfo.setStepLevel(customerVO.getStepLevel());
						paramStepInfo.setLeftStepId(customerVO.getLeftStepId());
						paramStepInfo.setRightStepId(customerVO.getRightStepId());

						if( paramStepInfo.getStepLevel().equals("1") ) {
							if(stepInfo.get("userId").equals("") || stepInfo.get("userId") == null ) {
								tmpStartFlag = true;
								paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_COMPLETED);
							} else {
								paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_PROCESSING);
								paramStepInfo.setApprvScheduleUserId((String)stepInfo.get("userId"));
								hiddenUserIdReview = (String)stepInfo.get("userId");
								currentUserIdReview = (String)stepInfo.get("userId");
							}

						} else if( paramStepInfo.getStepLevel().equals("2") ) {
							if( tmpStartFlag ) {
								paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_PROCESSING);
								paramStepInfo.setApprvScheduleUserId((String)stepInfo.get("userId"));
							} else {
								paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_WAITING);
								paramStepInfo.setApprvScheduleUserId((String)stepInfo.get("userId"));
								hiddenUserIdReview = (String)stepInfo.get("userId");
							}

						} else if(paramStepInfo.getStepLevel().equals("3")){
							paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_WAITING);
							paramStepInfo.setApprvScheduleUserId((String)stepInfo.get("userId"));

						} else if(paramStepInfo.getStepLevel().equals("4")){
							paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_WAITING);
							paramStepInfo.setApprvScheduleUserId((String)stepInfo.get("userId"));

						} else {
							paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_WAITING);
						}
						reqCatalogueService.setSrApprovalStepinsert2(paramStepInfo);

						if(tmpStep < 3) { tmpStep++; }
					}
				}

				CustomReqProductVO reqProductVo = reqProductService.orderUserInfo(ordervo.getOrderNo());
				Map<String,String> keywordMap = new HashMap<>();
				keywordMap.put("[[신청자명]]", reqProductVo.getUserName());
				keywordMap.put("[[서버명]]", alarmContentBuf.toString());
				keywordMap.put("[[URL]]", "http://k-cloud.kepco.co.kr/mbr/req/catalogue/bssOrderApproveView?orderNo="+ordervo.getOrderNo());
				keywordMap.put("[[LURL]]", "http://k-cloud.kepco.co.kr/mbr");
				// 신청자에게 알림
				alarmsTemplateService.alarms(30, ordervo.getOrderUserId(), keywordMap);
				// 결재자에게 요청
				alarmsTemplateService.alarms(33, currentUserIdReview, keywordMap);
				// 한전 연계 시스템 전송
				Map<String, String> alarmkepcoMap = new HashMap<>();
				alarmkepcoMap.put("gbn", "30");
				alarmkepcoMap.put("requestSeq", ordervo.getOrderNo());
				alarmkepcoMap.put("regUserId", ordervo.getOrderUserId());	// 자원 신청자
				alarmkepcoMap.put("apprvNextUserId", currentUserIdReview);	// 다음 결재자
				alarmkepcoMap.put("url", "http://k-cloud.kepco.co.kr/mbr/req/catalogue/bssOrderApproveView?orderNo="+ordervo.getOrderNo());
				alarmsTemplateService.alarmsKepco(alarmkepcoMap);
				return new ResponseEntity<Object>("true", HttpStatus.OK);
	}

	// 카테고리 상품 바로 주문시 페이지 이동
	@RequestMapping(value = "/catalogueOrderNow.do", params = "type=noworder")
	public String catalogueOrderNoworder(HttpServletRequest request, Model model, CustomReqCatalogueVO ordervo) {
		String hiddenUserIdReview = request.getParameter("hiddenUserIdReview");
		String hiddenUserIdApprove = request.getParameter("hiddenUserIdApprove");

		model.addAttribute("hiddenUserIdReview", hiddenUserIdReview);
		model.addAttribute("hiddenUserIdApprove", hiddenUserIdApprove);

		model.addAttribute("ordervo", ordervo);
		// log.debug("ordervo.getTotalPrice() : " + ordervo.getTotalPrice());
		return "mbr/req/catalogue/catalogueOrderNow";
	}

	// HOST_NAME (영문명) 중복체크
	@RequestMapping(value = "/hostnameChk")
	public ResponseEntity<Object> hostnameChk(CustomReqOrderVO ordervo) {
		int res = reqCatalogueService.hostnameChk(ordervo);
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	// 서비스 상품 바로 주문 입력
	@RequestMapping(value = "/catalogueServiceOrderNow", params = "type=noworderinsert")
	public ResponseEntity<Object> catalogueServiceOrderNowInsert(HttpServletRequest request, Model model,
			CustomReqOrderVO ordervo) {

		ordervo.setOrderUserId(request.getUserPrincipal().getName());
		model.addAttribute("ordervo", ordervo);

		String orderProductSeq = DateFormatUtils.format(new Date(), "yyyyMMddHHmmss");
		String orderNo         = orderProductSeq;

		ordervo.setRequestType("REQTYPE_NEW");
		ordervo.setOrderProductSeq(orderProductSeq);
		ordervo.setOrderNo(orderNo);
		String applyDatetime = "";
		if(ordervo.getOnDemandFlag().equals("N")){
			applyDatetime =	ordervo.getApplyDatetime();
		}


		String tmpApprovalStepList = request.getParameter("approvalStepListString");

//		JSONArray jsonArray = new JSONArray(tmpApprovalStepList);
//		List list = new ArrayList<>();
//
//		for (int i=0; i<jsonArray.length(); i++) {
//			jsonArray.getJSONObject(i);
//		    list.add( JsonUtil.toMap(jsonArray.getJSONObject(i)) );
//		}

		ordervo.setApprovalStepList(tmpApprovalStepList);

		String orderSummary = "";
		orderSummary = "<hr />";
		orderSummary = orderSummary + "<table><colgroup><col width='30%'><col width='70%'></colgroup><tbody>";
		//orderSummary = orderSummary +"<tr><td class='left'>서비스시작일시</td><td>"+applyDatetime+"</td></tr>";
		orderSummary = orderSummary +"<tr><td class='left'>신청자원</td><td>서비스</td></tr>";
		orderSummary = orderSummary +"<tr><td class='left'>프로젝트</td><td>"+ordervo.getProjectName()+" </td></tr>";
		orderSummary = orderSummary +"<tr><td class='left'>가상서버</td><td>"+ordervo.getVmName()+" </td></tr>";
		if(ordervo.getDescription() != null){
			orderSummary = orderSummary +"<tr><td class='left'>요청사항</td><td>"+ordervo.getDescription()+" </td></tr>";
		}
		if(ordervo.getProductCategory().equals("PRODCATE_BACKUP")){
			//orderSummary = orderSummary +"<tr><td class='left'>가상서버</td><td>"+ordervo.getVmName()+" </td></tr>";
		}
		//orderSummary = orderSummary +"<tr><td colspan='2' class='tar f18 fc-red'>"+ordervo.getAmount()+" <span class='f12 fc66'>원</span></td></tr>";
		orderSummary = orderSummary +"</tbody></table>";
		ordervo.setOrderSummary(orderSummary);

		String setOrder = reqCatalogueService.setOrder(ordervo);
		reqCatalogueService.setOrderProduct(ordervo);
//		if(ordervo.getProductCategory().equals("PRODCATE_MCA")){
//			log.debug("getMcaId : " + ordervo.getMcaId());
//			log.debug("PRODCATE_MCA : " + ordervo.getProductCategory());
//			reqCatalogueService.setOrderProductServiceMca(ordervo);
//		}else if(ordervo.getProductCategory().equals("PRODCATE_SCM")){
//			log.debug("PRODCATE_SCM : " + ordervo.getProductCategory());
//			reqCatalogueService.setOrderProductServiceScm(ordervo);
//		}else if(ordervo.getProductCategory().equals("PRODCATE_SECURITY")){
//			log.debug("PRODCATE_SECURITY : " + ordervo.getProductCategory());
//			reqCatalogueService.setOrderProductServiceScr(ordervo);
//		}else if(ordervo.getProductCategory().equals("PRODCATE_BACKUP")){
//			log.debug("BACKUPID : " + ordervo.getBackupId());
//			reqCatalogueService.setOrderProductServiceBak(ordervo);
//			String vmUuids = ordervo.getVmUuid();
//			String[] vmUuid = vmUuids.split(",");
//			for (int i = 0; i < vmUuid.length; i++) {
//				CustomReqOrderVO setVmUuid = new CustomReqOrderVO();
//				setVmUuid.setVmUuid(vmUuid[i]);
//				setVmUuid.setOrderProductSeq(orderProductSeq);
//				reqCatalogueService.setOrderBackVm(setVmUuid);
//			}
//		}else
		if(ordervo.getProductCategory().equals("PRODCATE_SERVICE")){
			// 서비스 상품 바로주문 로직 추가
			reqCatalogueService.setOrderProductServiceService(ordervo);
		}

		//1차 승인 예정자
		String currentUserIdReview = "";
        String hiddenUserIdReview = request.getParameter("hiddenUserIdReview");
        //2차 승인 예정자
		String hiddenUserIdApprove = request.getParameter("hiddenUserIdApprove");
		// 2020.05.25(장중일) - 신규 결재라인 등록 부분
		// 지정된 결재자 정보
		List<Map<String, Object>> stepList = ordervo.getApprovalStepList();
		// 결재라인 정보
		List<CustomReqCustomerVO> getApprovalModelSteplist = reqCatalogueService.getApprovalModelSteplist2();

		int tmpStep = 0;
		boolean tmpStartFlag = false;
		if(ordervo.getSelectApprv().equals("Y") && ordervo.getApprvPass().equals("Y")) {
			for(CustomReqCustomerVO customerVO : getApprovalModelSteplist) {
				UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
				CustomReqCustomerVO paramStepInfo = new CustomReqCustomerVO();
				paramStepInfo.setRequestSeq(ordervo.getOrderNo());
				paramStepInfo.setStepId(customerVO.getStepId());
				paramStepInfo.setModelId(customerVO.getModelId());
				paramStepInfo.setStepName(customerVO.getStepName());
				paramStepInfo.setStepLevel(customerVO.getStepLevel());
				paramStepInfo.setLeftStepId(customerVO.getLeftStepId());
				paramStepInfo.setRightStepId(customerVO.getRightStepId());



				if(tmpStep < 5) {
					paramStepInfo.setApprvUserId(userSession.getUsername());
					paramStepInfo.setApprvUserName(userSession.getNickname());
					paramStepInfo.setApprvScheduleUserId(userSession.getUsername());
					paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_COMPLETED);
				} else {
					if(tmpStep == 5) {
						paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_UNASSIGNED);
					} else {
						paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_WAITING);
					}
				}
				tmpStep++;
				reqCatalogueService.setSrApprovalStepinsert2(paramStepInfo);

				if(tmpStep < 3) { tmpStep++; }
			}
		}else {
			for(CustomReqCustomerVO customerVO : getApprovalModelSteplist) {
				HashMap<String, Object> stepInfo = (HashMap<String, Object>) stepList.get(tmpStep);

				CustomReqCustomerVO paramStepInfo = new CustomReqCustomerVO();
				paramStepInfo.setRequestSeq(ordervo.getOrderNo());
				paramStepInfo.setStepId(customerVO.getStepId());
				paramStepInfo.setModelId(customerVO.getModelId());
				paramStepInfo.setStepName(customerVO.getStepName());
				paramStepInfo.setStepLevel(customerVO.getStepLevel());
				paramStepInfo.setLeftStepId(customerVO.getLeftStepId());
				paramStepInfo.setRightStepId(customerVO.getRightStepId());

				if( paramStepInfo.getStepLevel().equals("1") ) {
					if(stepInfo.get("userId").equals("") || stepInfo.get("userId") == null ) {
						tmpStartFlag = true;
						paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_COMPLETED);
					} else {
						paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_PROCESSING);
						paramStepInfo.setApprvScheduleUserId((String)stepInfo.get("userId"));
						hiddenUserIdReview = (String)stepInfo.get("userId");
						currentUserIdReview = (String)stepInfo.get("userId");
					}

				} else if( paramStepInfo.getStepLevel().equals("2") ) {
					if( tmpStartFlag ) {
						paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_PROCESSING);
						paramStepInfo.setApprvScheduleUserId((String)stepInfo.get("userId"));
					} else {
						paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_WAITING);
						paramStepInfo.setApprvScheduleUserId((String)stepInfo.get("userId"));
						hiddenUserIdReview = (String)stepInfo.get("userId");
					}

				} else if(paramStepInfo.getStepLevel().equals("3")){
					paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_WAITING);
					paramStepInfo.setApprvScheduleUserId((String)stepInfo.get("userId"));

				} else if(paramStepInfo.getStepLevel().equals("4")){
					paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_WAITING);
					paramStepInfo.setApprvScheduleUserId((String)stepInfo.get("userId"));

				} else {
					paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_WAITING);
				}
				reqCatalogueService.setSrApprovalStepinsert2(paramStepInfo);

				if(tmpStep < 3) { tmpStep++; }
			}
		}

		CustomReqProductVO reqProductVo = reqProductService.orderUserInfo(ordervo.getOrderNo());
		Map<String,String> keywordMap = new HashMap<>();
		keywordMap.put("[[신청자명]]", reqProductVo.getUserName());
		keywordMap.put("[[서버명]]", orderSummary);
		keywordMap.put("[[URL]]", "http://k-cloud.kepco.co.kr/mbr/req/catalogue/bssOrderApproveView?orderNo="+ordervo.getOrderNo());
		keywordMap.put("[[LURL]]", "http://k-cloud.kepco.co.kr/mbr");
		// 신청자에게 알림
		alarmsTemplateService.alarms(30, ordervo.getOrderUserId(), keywordMap);
		// 결재자에게 요청
		alarmsTemplateService.alarms(33, currentUserIdReview, keywordMap);
		// 한전 연계 시스템 전송
		Map<String, String> alarmkepcoMap = new HashMap<>();
		alarmkepcoMap.put("gbn", "30");
		alarmkepcoMap.put("requestSeq", ordervo.getOrderNo());
		alarmkepcoMap.put("regUserId", ordervo.getOrderUserId());	// 자원 신청자
		alarmkepcoMap.put("apprvNextUserId", currentUserIdReview);	// 다음 결재자
		alarmkepcoMap.put("url", "http://k-cloud.kepco.co.kr/mbr/req/catalogue/bssOrderApproveView?orderNo="+ordervo.getOrderNo());
		alarmsTemplateService.alarmsKepco(alarmkepcoMap);
		String res = setOrder;
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	// 공인IP 상품 바로 주문 입력
	@RequestMapping(value = "/catalogueIpOrderNow", params = "type=noworderinsert")
	public ResponseEntity<Object> catalogueIpOrderNowInsert(HttpServletRequest request, Model model,
			CustomReqOrderVO ordervo) {

		ordervo.setOrderUserId(request.getUserPrincipal().getName());
		model.addAttribute("ordervo", ordervo);

		String orderProductSeq = DateFormatUtils.format(new Date(), "yyyyMMddHHmmss");
		String orderNo = orderProductSeq;

		if (ordervo.getRequestType().equals("")) {
			ordervo.setRequestType("REQTYPE_NEW");
		}
		ordervo.setOrderProductSeq(orderProductSeq);
		ordervo.setOrderNo(orderNo);

		// log.debug("ordervo.getParameter() : " +
		// request.getParameter("defaultNetworkAlias"));
		// log.debug("ordervo.getDefaultNetworkAlias() : " +
		// ordervo.getDefaultNetworkAlias());
		// log.debug("ordervo.getNetworkAlias() : " +
		// ordervo.getNetworkAlias());

		String orderSummary = "";
		orderSummary = "<table><colgroup><col width='30%'><col width='70%'></colgroup><tbody>";
		orderSummary = orderSummary + "<tr><td class='left'>서비스시작일시</td><td>" + ordervo.getApplyDatetime()
				+ "</td></tr>";
		orderSummary = orderSummary + "<tr><td class='left'>프로젝트</td><td>" + ordervo.getProjectName() + " </td></tr>";
		orderSummary = orderSummary + "<tr><td class='left'>가상서버</td><td>" + ordervo.getVmName() + " </td></tr>";
		orderSummary = orderSummary + "<tr><td class='left'>비고</td><td>" + ordervo.getDescription() + " </td></tr>";
		orderSummary = orderSummary + "<tr><td colspan='2' class='tar f18 fc-red'>" + ordervo.getAmount()
				+ " <span class='f12 fc66'>원</span></td></tr>";
		orderSummary = orderSummary + "</tbody></table>";
		ordervo.setOrderSummary(orderSummary);

		String setOrder = reqCatalogueService.setOrder(ordervo);
		reqCatalogueService.setOrderProduct(ordervo);
		reqCatalogueService.setOrderProductIp(ordervo);

		// 승인 스텝 입력
		List<CustomReqCustomerVO> getApprovalModelSteplist = reqCatalogueService.getApprovalModelSteplist2();
		for (int i = 0; i < getApprovalModelSteplist.size(); i++) {
			CustomReqCustomerVO appmodelstep = new CustomReqCustomerVO();
			appmodelstep.setRequestSeq(orderNo);
			appmodelstep.setStepId(getApprovalModelSteplist.get(i).getStepId());
			if (!appmodelstep.getStepId().equals("")) {

			}
			appmodelstep.setModelId(getApprovalModelSteplist.get(i).getModelId());
			appmodelstep.setStepName(getApprovalModelSteplist.get(i).getStepName());
			appmodelstep.setStepLevel(getApprovalModelSteplist.get(i).getStepLevel());
			appmodelstep.setLeftStepId(getApprovalModelSteplist.get(i).getLeftStepId());
			appmodelstep.setRightStepId(getApprovalModelSteplist.get(i).getRightStepId());
			if (appmodelstep.getStepLevel().equals("1")) {
				appmodelstep.setApprvState("APPRV_PROCESSING");
			} else {
				appmodelstep.setApprvState("APPRV_WAITING");
			}
			reqCatalogueService.setSrApprovalStepinsert2(appmodelstep);
		}
		// ordervo.getProjectId();
		CustomReqCatalogueVO getProjectId = reqCatalogueService.getProjectId(ordervo.getProjectId());
		List<CustomReqCustomerVO> getApprovalModelMemberlist = reqCatalogueService.getApprovalModelMemberlist2();
		for (int i = 0; i < getApprovalModelMemberlist.size(); i++) {
			CustomReqCustomerVO appmember = new CustomReqCustomerVO();
			appmember.setRequestSeq(orderNo);
			appmember.setStepId(getApprovalModelMemberlist.get(i).getStepId());
			appmember.setUserId(getApprovalModelMemberlist.get(i).getUserId());
			appmember.setApprvAuthFlag(getApprovalModelMemberlist.get(i).getApprvAuthFlag());
			appmember.setMailRecvFlag(getApprovalModelMemberlist.get(i).getMailRecvFlag());
			appmember.setSmsRecvFlag(getApprovalModelMemberlist.get(i).getSmsRecvFlag());
			appmember.setPushRecvFlag(getApprovalModelMemberlist.get(i).getPushRecvFlag());
			/*
			 * if(appmember.getUserId().equals("RESERVED_PM")){
			 * appmember.setUserId(getProjectId.getProjectManagerId()); }else{
			 * appmember.setUserId(getProjectId.getCustomerId()); }
			 */

			reqCatalogueService.setSrApprovalMemberinsert2(appmember);
		}

		String res = setOrder;
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	// NAS 상품 바로 주문 입력
	@RequestMapping(value = "/catalogueNasOrderNow", params = "type=noworderinsert")
	public ResponseEntity<Object> catalogueNasOrderNowInsert(HttpServletRequest request, Model model,
			CustomReqOrderVO ordervo) {

		ordervo.setOrderUserId(request.getUserPrincipal().getName());
		model.addAttribute("ordervo", ordervo);

		String orderProductSeq = DateFormatUtils.format(new Date(), "yyyyMMddHHmmss");
		String orderNo = orderProductSeq;

		if (ordervo.getRequestType().equals("") || ordervo.getRequestType().equals(null)) {
			ordervo.setRequestType("REQTYPE_NEW");
		}

		ordervo.setOrderProductSeq(orderProductSeq);
		ordervo.setOrderNo(orderNo);
		ordervo.setDefaultNetworkId(ordervo.getNetworkId());
		ordervo.setDefaultNetworkName(ordervo.getNetworkAlias());
		ordervo.setDefaultNetworkName(ordervo.getNetworkAlias());
		ordervo.setAzName(ordervo.getAzName());

		String projectId = reqCatalogueService.detailProjectId(ordervo);
		ordervo.setProjectId(projectId);

		String orderSummary = "";
		orderSummary = "<table><colgroup><col width='30%'><col width='70%'></colgroup><tbody>";
		orderSummary = orderSummary + "<tr><td class='left'>서비스시작일시</td><td>" + ordervo.getApplyDatetime()
				+ "</td></tr>";
		orderSummary = orderSummary + "<tr><td class='left'>프로젝트</td><td>" + ordervo.getProjectName() + " </td></tr>";
		orderSummary = orderSummary + "<tr><td class='left'>가상서버</td><td>" + ordervo.getVmName() + " </td></tr>";
		orderSummary = orderSummary + "<tr><td class='left'>NAS 이름</td><td>" + ordervo.getNasName() + " </td></tr>";
		orderSummary = orderSummary + "<tr><td class='left'>NAS 용량</td><td>" + ordervo.getNasGb() + " GB </td></tr>";
		orderSummary = orderSummary + "<tr><td class='left'>비고</td><td>" + ordervo.getDescription() + " </td></tr>";
//		orderSummary = orderSummary + "<tr><td colspan='2' class='tar f18 fc-red'>" + ordervo.getAmount()
//				+ " <span class='f12 fc66'>원</span></td></tr>";
		orderSummary = orderSummary + "</tbody></table>";
		ordervo.setOrderSummary(orderSummary);

		String setOrder = reqCatalogueService.setOrder(ordervo);
		reqCatalogueService.setOrderProduct(ordervo);
		reqCatalogueService.setOrderProductNas(ordervo);

		String tmpApprovalStepList = request.getParameter("approvalStepListString");

		if (!"openshift".equals(ordervo.getCloudType())) {
			ordervo.setVmUuid(ordervo.getVmUuid());
			ordervo.setNasVmServer(ordervo.getVmName());
			ordervo.setNasVmIp(ordervo.getFixedIps());
			reqCatalogueService.setOrderProductNasVm(ordervo);
		}

		ordervo.setApprovalStepList(tmpApprovalStepList);

		// 승인 스텝 입력
//		List<CustomReqCustomerVO> getApprovalModelSteplist = reqCatalogueService.getApprovalModelSteplist2();
//		for (int i = 0; i < getApprovalModelSteplist.size(); i++) {
//			CustomReqCustomerVO appmodelstep = new CustomReqCustomerVO();
//			appmodelstep.setRequestSeq(orderNo);
//			appmodelstep.setStepId(getApprovalModelSteplist.get(i).getStepId());
//			if (!appmodelstep.getStepId().equals("")) {
//
//			}
//			appmodelstep.setModelId(getApprovalModelSteplist.get(i).getModelId());
//			appmodelstep.setStepName(getApprovalModelSteplist.get(i).getStepName());
//			appmodelstep.setStepLevel(getApprovalModelSteplist.get(i).getStepLevel());
//			appmodelstep.setLeftStepId(getApprovalModelSteplist.get(i).getLeftStepId());
//			appmodelstep.setRightStepId(getApprovalModelSteplist.get(i).getRightStepId());
//			if (appmodelstep.getStepLevel().equals("1")) {
//				appmodelstep.setApprvState("APPRV_PROCESSING");
//			} else {
//				appmodelstep.setApprvState("APPRV_WAITING");
//			}
//			reqCatalogueService.setSrApprovalStepinsert2(appmodelstep);
//		}

		String currentUserIdReview = "";
		String hiddenUserIdReview = request.getParameter("hiddenUserIdReview");
		// 2차 승인 예정자
		String hiddenUserIdApprove = request.getParameter("hiddenUserIdApprove");

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
		}



		// ordervo.getProjectId();
		CustomReqCatalogueVO getProjectId = reqCatalogueService.getProjectId(ordervo.getProjectId());
		List<CustomReqCustomerVO> getApprovalModelMemberlist = reqCatalogueService.getApprovalModelMemberlist2();
		for (int i = 0; i < getApprovalModelMemberlist.size(); i++) {
			CustomReqCustomerVO appmember = new CustomReqCustomerVO();
			appmember.setRequestSeq(orderNo);
			appmember.setStepId(getApprovalModelMemberlist.get(i).getStepId());
			appmember.setUserId(getApprovalModelMemberlist.get(i).getUserId());
			appmember.setApprvAuthFlag(getApprovalModelMemberlist.get(i).getApprvAuthFlag());
			appmember.setMailRecvFlag(getApprovalModelMemberlist.get(i).getMailRecvFlag());
			appmember.setSmsRecvFlag(getApprovalModelMemberlist.get(i).getSmsRecvFlag());
			appmember.setPushRecvFlag(getApprovalModelMemberlist.get(i).getPushRecvFlag());
			/*
			 * if(appmember.getUserId().equals("RESERVED_PM")){
			 * appmember.setUserId(getProjectId.getProjectManagerId()); }else{
			 * appmember.setUserId(getProjectId.getCustomerId()); }
			 */
			reqCatalogueService.setSrApprovalMemberinsert2(appmember);
		}

		String res = setOrder;
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	// 블록디스크 상품 바로 주문 입력
	@RequestMapping(value = "/catalogueDiskOrderNow", params = "type=noworderinsert")
	public ResponseEntity<Object> catalogueDiskOrderNowInsert(HttpServletRequest request, Model model,
			CustomReqOrderVO ordervo) {

		ordervo.setOrderUserId(request.getUserPrincipal().getName());
		model.addAttribute("ordervo", ordervo);

		String orderProductSeq = DateFormatUtils.format(new Date(), "yyyyMMddHHmmss");
		String orderNo = orderProductSeq;

		ordervo.setRequestType("REQTYPE_NEW");
		ordervo.setOrderProductSeq(orderProductSeq);
		ordervo.setOrderNo(orderNo);

		String tmpApprovalStepList = request.getParameter("approvalStepListString");

//		JSONArray jsonArray = new JSONArray(tmpApprovalStepList);
//		List list = new ArrayList<>();
//
//		for (int i = 0; i < jsonArray.length(); i++) {
//			jsonArray.getJSONObject(i);
//			list.add(JsonUtil.toMap(jsonArray.getJSONObject(i)));
//		}

		ordervo.setApprovalStepList(tmpApprovalStepList);

		// log.debug("ordervo.getParameter() : " +
		// request.getParameter("defaultNetworkAlias"));
		// log.debug("ordervo.getDefaultNetworkAlias() : " +
		// ordervo.getDefaultNetworkAlias());
		// log.debug("ordervo.getNetworkAlias() : " +
		// ordervo.getNetworkAlias());
		ordervo.setAmount(ordervo.getTotalPrice());
		ordervo.setDiskGb(ordervo.getDiskcnt());
		String orderSummary = "";
		orderSummary = "<hr />";
		orderSummary = orderSummary + "<table><colgroup><col width='30%'><col width='70%'></colgroup><tbody>";
		// orderSummary = orderSummary +"<tr><td
		// class='left'>서비스시작일시</td><td>"+ordervo.getApplyDatetime()+"</td></tr>";
		orderSummary = orderSummary + "<tr><td class='left'>신청자원</td><td>블록디스크</td></tr>";
		orderSummary = orderSummary + "<tr><td class='left'>프로젝트</td><td>" + ordervo.getProjectName() + " </td></tr>";
		orderSummary = orderSummary + "<tr><td class='left'>가상서버</td><td>" + ordervo.getVmName() + " </td></tr>";
		orderSummary = orderSummary + "<tr><td class='left'>DISK</td><td>" + ordervo.getDiskGb() + " GB </td></tr>";
		// orderSummary = orderSummary +"<tr><td colspan='2' class='tar f18
		// fc-red'>"+ordervo.getAmount()+" <span class='f12 fc66'>원</span></td></tr>";
		orderSummary = orderSummary + "</tbody></table>";
		ordervo.setOrderSummary(orderSummary);

		String setOrder = reqCatalogueService.setOrder(ordervo);
		reqCatalogueService.setOrderProduct(ordervo);
		reqCatalogueService.setOrderProductDisk(ordervo);

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
		}

		CustomReqProductVO reqProductVo = reqProductService.orderUserInfo(ordervo.getOrderNo());
		Map<String,String> keywordMap = new HashMap<>();
		keywordMap.put("[[신청자명]]", reqProductVo.getUserName());
		keywordMap.put("[[서버명]]", orderSummary);
		keywordMap.put("[[URL]]", "http://k-cloud.kepco.co.kr/mbr/req/catalogue/bssOrderApproveView?orderNo="+orderNo);
		keywordMap.put("[[LURL]]", "http://k-cloud.kepco.co.kr/mbr");
		// 신청자에게 알림
		alarmsTemplateService.alarms(30, ordervo.getOrderUserId(), keywordMap);
		// 결재자에게 요청
		alarmsTemplateService.alarms(33, currentUserIdReview, keywordMap);
		// 한전 연계 시스템 전송
		Map<String, String> alarmkepcoMap = new HashMap<>();
		alarmkepcoMap.put("gbn", "30");
		alarmkepcoMap.put("requestSeq", ordervo.getOrderNo());
		alarmkepcoMap.put("regUserId", ordervo.getOrderUserId());	// 자원 신청자
		alarmkepcoMap.put("apprvNextUserId", currentUserIdReview);	// 다음 결재자
		alarmkepcoMap.put("url", "http://k-cloud.kepco.co.kr/mbr/req/catalogue/bssOrderApproveView?orderNo="+orderNo);
		alarmsTemplateService.alarmsKepco(alarmkepcoMap);

		String res = setOrder;
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	// 카테고리 상품 바로 주문 입력
	@RequestMapping(value = "/catalogueOrderNow",params="type=noworderinsert")
	public ResponseEntity<Object> catalogueOrderNowInsert(HttpServletRequest request, Model model,CustomReqOrderVO ordervo ){
		ordervo.setOrderUserId(request.getUserPrincipal().getName());
		model.addAttribute("ordervo", ordervo);

		// 결재라인 정보 JSON -> List Map 형식으로 변환하여 넣기
		String tmpApprovalStepList = request.getParameter("approvalStepListString");
//		JSONArray jsonArray = new JSONArray(tmpApprovalStepList);
//		List list = new ArrayList<>();
//		for (int i=0; i<jsonArray.length(); i++) {
//			jsonArray.getJSONObject(i);
//		    list.add( JsonUtil.toMap(jsonArray.getJSONObject(i)) );
//		}

		ordervo.setApprovalStepList(tmpApprovalStepList);

		//1차 승인 예정자
		String currentUserIdReview = "";
	    String hiddenUserIdReview = request.getParameter("hiddenUserIdReview");
	    //2차 승인 예정자
		String hiddenUserIdApprove = request.getParameter("hiddenUserIdApprove");

		String orderProductSeq = DateFormatUtils.format(new Date(), "yyyyMMddHHmmss");
		String orderNo         = orderProductSeq;

		ordervo.setOrderProductSeq(orderProductSeq);
		ordervo.setOrderNo(orderNo);

		ordervo.setRequestType("REQTYPE_NEW");

		String orderSummary = "";
		orderSummary = "<hr />";
		orderSummary = orderSummary + "<table><colgroup><col width='30%'><col width='70%'></colgroup><tbody>";
		//orderSummary = orderSummary +"<tr><td class='left'>서비스시작일시</td><td>"+ordervo.getApplyDatetime()+"</td></tr>";\
		orderSummary = orderSummary +"<tr><td class='left'>신청자원</td><td>가상서버</td></tr>";
		orderSummary = orderSummary +"<tr><td class='left'>프로젝트</td><td>"+ordervo.getProjectName()+" </td></tr>";
		orderSummary = orderSummary +"<tr><td class='left'>네트워크</td><td>"+ordervo.getAzName()+" </td></tr>";
		orderSummary = orderSummary +"<tr><td class='left'>서버명</td><td>"+ordervo.getHostnameAlias()+"</td></tr>";
		//orderSummary = orderSummary +"<tr><td class='left'>HOST ALIAS</td><td>"+ordervo.getHostnameAlias()+"</td></tr>";
		orderSummary = orderSummary +"<tr><td class='left'>CPU</td><td>"+ordervo.getCpucnt()+" vCPU</td></tr>";
		orderSummary = orderSummary +"<tr><td class='left'>MEM</td><td>"+ordervo.getMemcnt()+" GB</td></tr>";
		orderSummary = orderSummary +"<tr><td class='left'>DISK</td><td>"+ordervo.getDiskcnt()+" GB </td></tr>";
		if(ordervo.getDescription() != null){
			orderSummary = orderSummary +"<tr><td class='left'>기타사항</td><td>"+ordervo.getDescription()+" </td></tr>";
		}
		//orderSummary = orderSummary +"<tr><td class='left'>아이디</td><td>appuser</td></tr>";
		//orderSummary = orderSummary +"<tr><td class='left'>패스워드</td><td>kepco123/456</td></tr>";
		//orderSummary = orderSummary +"<tr><td colspan='2' class='tar f18 fc-red'>"+ordervo.getAmount()+" <span class='f12 fc66'>원</span></td></tr>";
		orderSummary = orderSummary +"</tbody></table>";
		ordervo.setOrderSummary(orderSummary);

		ordervo.setDefaultNetworkId(ordervo.getNetworkId());
		ordervo.setDefaultNetworkName(ordervo.getNetworkAlias());
		ordervo.setVcpus(ordervo.getCpucnt());
		ordervo.setMemGb(ordervo.getMemcnt());
		ordervo.setDiskGb(ordervo.getDiskcnt());
		ordervo.setVmProductSeq(ordervo.getProductSeq());


		String projectId = reqCatalogueService.detailProjectId(ordervo);
		ordervo.setProjectId(projectId);
		String setOrder = reqCatalogueService.setOrder(ordervo);
		reqCatalogueService.setOrderProduct(ordervo);
		reqCatalogueService.setOrderProductVm(ordervo);

		if(ordervo.getVmImageType().equals("APPIMGDEV110")){
			orderProductSeq = DateFormatUtils.format(DateUtils.addSeconds(new Date(),1), "yyyyMMddHHmmss");
			ordervo.setOrderProductSeq(orderProductSeq);
			ordervo.setHourlyFlag("N");
			ordervo.setApplyDatetime(DateUtils.convertDateToString(new Date(), "Asia/Seoul", "yyyy-MM-dd HH:mm"));
			ordervo.setDescription(ordervo.getReqMessage());
			ordervo.setServiceType("SERVICE99");
//			ordervo.setServiceName(request.getParameter("hostnameAlias"));
			ordervo.setProductName(ordervo.getHostnameAlias());
			ordervo.setEnvType(ordervo.getBastionEnvType());
			ordervo.setProductCategory("PRODCATE_SERVICE");
			reqCatalogueService.setOrderProduct(ordervo);
			reqCatalogueService.setOrderProductServiceService(ordervo);
		}

//		String network = ordervo.getNetworkChk();
//		String[] networks = network.split(",");

		// 2020.05.25(장중일) - 신규 결재라인 등록 부분
		// 지정된 결재자 정보
		List<Map<String, Object>> stepList = ordervo.getApprovalStepList();
		// 결재라인 정보
		List<CustomReqCustomerVO> getApprovalModelSteplist = reqCatalogueService.getApprovalModelSteplist2();

		int tmpStep = 0;
		boolean tmpStartFlag = false;
		if(ordervo.getSelectApprv().equals("Y") && ordervo.getApprvPass().equals("Y")) {
			for(CustomReqCustomerVO customerVO : getApprovalModelSteplist) {
				UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
				CustomReqCustomerVO paramStepInfo = new CustomReqCustomerVO();
				paramStepInfo.setRequestSeq(ordervo.getOrderNo());
				paramStepInfo.setStepId(customerVO.getStepId());
				paramStepInfo.setModelId(customerVO.getModelId());
				paramStepInfo.setStepName(customerVO.getStepName());
				paramStepInfo.setStepLevel(customerVO.getStepLevel());
				paramStepInfo.setLeftStepId(customerVO.getLeftStepId());
				paramStepInfo.setRightStepId(customerVO.getRightStepId());



				if(tmpStep < 5) {
					paramStepInfo.setApprvUserId(userSession.getUsername());
					paramStepInfo.setApprvUserName(userSession.getNickname());
					paramStepInfo.setApprvScheduleUserId(userSession.getUsername());
					paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_COMPLETED);
				} else {
					if(tmpStep == 5) {
						paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_UNASSIGNED);
					} else {
						paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_WAITING);
					}
				}
				tmpStep++;
				reqCatalogueService.setSrApprovalStepinsert2(paramStepInfo);

				if(tmpStep < 3) { tmpStep++; }
			}
		} else {
			for(CustomReqCustomerVO customerVO : getApprovalModelSteplist) {
				HashMap<String, Object> stepInfo = (HashMap<String, Object>) stepList.get(tmpStep);

				CustomReqCustomerVO paramStepInfo = new CustomReqCustomerVO();
				paramStepInfo.setRequestSeq(ordervo.getOrderNo());
				paramStepInfo.setStepId(customerVO.getStepId());
				paramStepInfo.setModelId(customerVO.getModelId());
				paramStepInfo.setStepName(customerVO.getStepName());
				paramStepInfo.setStepLevel(customerVO.getStepLevel());
				paramStepInfo.setLeftStepId(customerVO.getLeftStepId());
				paramStepInfo.setRightStepId(customerVO.getRightStepId());

				if( paramStepInfo.getStepLevel().equals("1") ) {
					if(stepInfo.get("userId").equals("") || stepInfo.get("userId") == null ) {
						tmpStartFlag = true;
						paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_COMPLETED);
					} else {
						paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_PROCESSING);
						paramStepInfo.setApprvScheduleUserId((String)stepInfo.get("userId"));
						hiddenUserIdReview = (String)stepInfo.get("userId");
						currentUserIdReview = (String)stepInfo.get("userId");
					}

				} else if( paramStepInfo.getStepLevel().equals("2") ) {
					if( tmpStartFlag ) {
						paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_PROCESSING);
						paramStepInfo.setApprvScheduleUserId((String)stepInfo.get("userId"));
					} else {
						paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_WAITING);
						paramStepInfo.setApprvScheduleUserId((String)stepInfo.get("userId"));
						hiddenUserIdReview = (String)stepInfo.get("userId");
					}

				} else if(paramStepInfo.getStepLevel().equals("3")){
					paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_WAITING);
					paramStepInfo.setApprvScheduleUserId((String)stepInfo.get("userId"));

				} else if(paramStepInfo.getStepLevel().equals("4")){
					paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_WAITING);
					paramStepInfo.setApprvScheduleUserId((String)stepInfo.get("userId"));

				} else {
					paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_WAITING);
				}
				reqCatalogueService.setSrApprovalStepinsert2(paramStepInfo);

				if(tmpStep < 3) { tmpStep++; }
			}
		}

		CustomReqProductVO reqProductVo = reqProductService.orderUserInfo(ordervo.getOrderNo());
		Map<String,String> keywordMap = new HashMap<>();
		keywordMap.put("[[신청자명]]", reqProductVo.getUserName());
		keywordMap.put("[[서버명]]", orderSummary);
		keywordMap.put("[[URL]]", "http://k-cloud.kepco.co.kr/mbr/req/catalogue/bssOrderApproveView?orderNo="+orderNo);
		keywordMap.put("[[LURL]]", "http://k-cloud.kepco.co.kr/mbr");
		// 신청자에게 알림
		alarmsTemplateService.alarms(30, ordervo.getOrderUserId(), keywordMap);
		// 결재자에게 요청
		alarmsTemplateService.alarms(33, currentUserIdReview, keywordMap);
		// 한전 연계 시스템 전송
		Map<String, String> alarmkepcoMap = new HashMap<>();
		alarmkepcoMap.put("gbn", "30");
		alarmkepcoMap.put("requestSeq", orderNo);
		alarmkepcoMap.put("regUserId", ordervo.getOrderUserId());	// 자원 신청자
		alarmkepcoMap.put("apprvNextUserId", currentUserIdReview);	// 다음 결재자
		alarmkepcoMap.put("url", "http://k-cloud.kepco.co.kr/mbr/req/catalogue/bssOrderApproveView?orderNo="+orderNo);
		alarmsTemplateService.alarmsKepco(alarmkepcoMap);

		String res = setOrder;
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	// 주문 결과후 페이지
//	@RequestMapping(value = "/catalogueOrderResult.do",params="!type")
//	public String catalogueOrderResult(){
//
//		return "mbr/req/catalogue/catalogueOrderResult";
//	}

	// project 검색 팝업
	@RequestMapping(value = "/projectSearch.do", params = "!type")
	public String projectSearch() {

		return "mbr/req/catalogue/projectSearch";
	}

	// project 검색 팝업 결과
	@RequestMapping(value = "/projectSearch.do", params = "type=check")
	public String projectSearchvalue(HttpServletRequest request, Model model) {

		String searchValue = request.getParameter("searchValue");
		CustomReqCatalogueVO projectvo = new CustomReqCatalogueVO();
		// projectvo.setSearchKey(searchKey);
		projectvo.setSearchValue(searchValue);
		projectvo.setRegUserId(request.getUserPrincipal().getName());

		List<CustomReqCatalogueVO> getProjectList = reqCatalogueService.getProjectList(projectvo);

		model.addAttribute("getProjectList", getProjectList);
		// model.addAttribute("searchKey", searchKey);
		model.addAttribute("searchValue", searchValue);
		return "mbr/req/catalogue/projectSearch";
	}

	// 모달 - 프로젝트 리스트 검색
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

	// 모달 - 스냅샷 리스트 검색
	@RequestMapping(value = "/snapshotPopList", method = RequestMethod.GET)
	public ResponseEntity<Object> snapshotPopList(HttpServletRequest request, CustomMngOssVo SnValue) {
		List<CustomMngOssVo> getSnapshots = reqCatalogueService.getSnapshots(SnValue);

		HashMap<String, Object> map = new HashMap<>();
		map.put("userId", request.getUserPrincipal().getName());
		map.put("getSnapshots", getSnapshots);
		return new ResponseEntity<Object>(map, HttpStatus.OK);
	}

	@RequestMapping(value = "/getProjectPopList", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public ResponseEntity<String> getProjectPopList(HttpServletRequest request, CustomReqCatalogueVO req) {


		req.setRegUserId(request.getUserPrincipal().getName());
		String res = reqCatalogueService.getProjectPopList(req);
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}


	// 네트워크 vm 모달팝업 검색
	@RequestMapping(value = "/networkVmPopList", method = RequestMethod.GET)
	public ResponseEntity<String> networkVmPopList(HttpServletRequest request) {

		String searchValue = request.getParameter("searchValue");
		String networkId = request.getParameter("networkId");
		CustomReqCatalogueVO projectvo = new CustomReqCatalogueVO();
		projectvo.setNetworkId(networkId);
		projectvo.setSearchValue(searchValue);
		projectvo.setRegUserId(request.getUserPrincipal().getName());

		String res = reqCatalogueService.networkVmPopList(projectvo);
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}

	// 신청현황 > 상품구매 요청 현황 View-Controller
	@RequestMapping(value = "/bssOrderList")
	public String bssOrderList() {
		return "mbr/req/catalogue/bssOrderList";
	}

	// 신천현황 > 자원구매 요청 현황 리스트
	@RequestMapping(value = "/bssOrderStatusList", method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
	public ResponseEntity<Object> bssOrderStatusList(CustomReqOrderVO req) {

		Assert.notNull(req.getUserId(), "");

		List<CustomReqOrderVO> getPmOrderList = null;
		String res = "";
		// 사용자 아이디 PM 확인
		getPmOrderList = reqCatalogueService.getPmOrderList(req);
		int recordsTotal = reqCatalogueService.pmlistTot(req);
		int recordsFiltered = recordsTotal;

		try {
			JsonObject jsonResponse = new JsonObject();
			Gson gson = new Gson();

			jsonResponse.addProperty("draw", req.getDraw());
			jsonResponse.addProperty("recordsTotal", recordsTotal);
			jsonResponse.addProperty("recordsFiltered", recordsFiltered);
			jsonResponse.add("data", gson.toJsonTree(getPmOrderList));

			res = jsonResponse.toString();
		} catch (JsonIOException e) {
			log.error(e.getMessage());
		}

		if (res.equals("")) {
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	// PM 상품 신청현황 목록 조회
	@RequestMapping(value = "/bssOrderStatusCnt", method = RequestMethod.GET)
	public ResponseEntity<Object> bssOrderApproveStatusCnt(HttpServletRequest request, CustomReqOrderVO req,
			Model model) {

		CustomReqOrderVO res = reqCatalogueService.getPmOrderStatusCnt(req);
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	// 승인처리 - 상품구매 요청 승인 View-Controller
	@RequestMapping(value = "/bssOrderApproveList")
	public String productApproveListPage() {
		return "mbr/req/catalogue/bssOrderApproveList";
	}

	// PM 상품 신청현황 목록 조회
	@RequestMapping(value = "/bssOrderApproveStatusList", method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
	public ResponseEntity<Object> bssOrderApproveStatusList(CustomReqOrderVO req) {

		Assert.notNull(req.getUserId(), "");

		String res = "";


		List<CustomReqOrderVO> getPmOrderList = reqCatalogueService.getOrderApproveList(req);

		int recordsTotal = reqCatalogueService.productApproveListTot(req);
		int recordsFiltered = recordsTotal;



		try {
			JsonObject jsonResponse = new JsonObject();
			Gson gson = new Gson();

			jsonResponse.addProperty("draw", req.getDraw());
			jsonResponse.addProperty("recordsTotal", recordsTotal);
			jsonResponse.addProperty("recordsFiltered", recordsFiltered);
			jsonResponse.add("data", gson.toJsonTree(getPmOrderList));

			res = jsonResponse.toString();
		} catch (JsonIOException e) {
			log.error(e.getMessage());
		}

		if (res.equals("")) {
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	@RequestMapping(value = "/bssOrderApproveStatusCnt", method = RequestMethod.GET)
	public ResponseEntity<Object> bssOrderStatusCnt(CustomReqOrderVO req) {

		log.debug("startDt: {}, EndDt:{}, keyword:{}", req.getStartDt(), req.getEndDt(), req.getKeyword());
		CustomReqOrderVO res = reqCatalogueService.getOrderApproveStatusCnt(req);

		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	// PM 상품 신청현황 상세 화면
	@RequestMapping(value = "/bssOrderView")
	public String bssOrderview(CustomReqOrderVO req, Model model, Principal principal) {

		final String orderNo = req.getOrderNo();
		final String loginUserId = principal.getName();
		Assert.notNull(orderNo, "");
		Assert.notNull(loginUserId, "");

		model.addAttribute("orderNo", orderNo);
		model.addAttribute("loginUserId", loginUserId);

		CustomCmmUserVO cmmUserInfo = new CustomCmmUserVO();
		cmmUserInfo.setUserId(loginUserId);
		cmmUserInfo = cmmUserService.userInfoDetail(cmmUserInfo);
		model.addAttribute("userLevelCode", cmmUserInfo.getUserLevelCode());

		/*
		 * //상품 신청현황 PM,회원사 승인처리 리스트 String requestSeq =req.getOrderNo();
		 * CustomReqCatalogueVO catalolovo = new CustomReqCatalogueVO();
		 * catalolovo.setRequestSeq(requestSeq); catalolovo.setFlowId("AFW0030");
		 * List<CustomReqCustomerVO> approvalList =
		 * reqCatalogueService.approvalList(catalolovo); List<CustomReqCustomerVO>
		 * approvalUserId = reqCatalogueService.approvalUserId(catalolovo);
		 * model.addAttribute("getProjectAppSteplist", approvalList);
		 * model.addAttribute("approvalUserId", approvalUserId);
		 *
		 * catalolovo.setFlowId("AFW0040"); List<CustomReqCustomerVO> approvalList2 =
		 * reqCatalogueService.approvalList(catalolovo); List<CustomReqCustomerVO>
		 * approvalUserId2 = reqCatalogueService.approvalUserId(catalolovo);
		 * model.addAttribute("getProjectAppSteplist2", approvalList2);
		 * model.addAttribute("approvalUserId2", approvalUserId2);
		 */

		// 프로젝트 ID값
		String projectId = null;
		String codeKeyId = "APPRV_STATE";
		List<CustomBbsNoticeVO> getNoticeBbscodeList = bbsNoticeservice.getNoticeBbscodeList(codeKeyId);
		model.addAttribute("code", getNoticeBbscodeList);

		Map<String, String> map = new HashMap<>();
		map.put("userId", loginUserId);
		map.put("orderNo", orderNo);

		// #### 결재라인 불러오기 시작 ####
		// 승인스텝멤버 불러오기
		String stepId = reqProductService.getStepId(map);
		map.put("stepId", stepId);
		model.addAttribute("stepId", stepId);

		String userApprvState = "";
		userApprvState = reqProductService.getUserApprvState(map);
		model.addAttribute("userApprvState", userApprvState);

		List<CustomReqProductVO> approvalList3 = reqProductService.approvalList(map);
		for (int i = 0; i < approvalList3.size(); i++) {
			if (approvalList3.get(i).getApprvState().equals("APPRV_REJECTED")) {
				String inject = "Y";
				model.addAttribute("inject", inject);
			}
		}
		model.addAttribute("getResourceApprovalStep", approvalList3);

		// 승인스텝멤버 유저 아이디 조회
		List<CustomReqProductVO> approvalUserId3 = reqProductService.approvalUserId(orderNo);
		model.addAttribute("approvalUserId3", approvalUserId3);

		// 주문자명 아이디 가져오기 (상품신청 승인 및 취소시) 2017.08.24
		CustomReqProductVO getOrderUserId3 = reqProductService.getOrderVo(orderNo);
		model.addAttribute("getOrderUserId3", getOrderUserId3);

		// ### 결재라인 불러오기 끝 ###
		// 주문서 정보
		CustomReqOrderVO orderview = reqCatalogueService.orderview(req);
		model.addAttribute("orderview", orderview);

		// 주문서 VM 정보
		List<CustomReqOrderVO> orderviewList = reqCatalogueService.orderviewList(req);
		model.addAttribute("orderviewList", orderviewList);
		if (orderviewList.size() != 0) {
			projectId = orderviewList.get(0).getProjectId();
		}

		// 주문서 DISK 정보
		List<CustomReqOrderVO> orderDiskviewList = reqCatalogueService.orderDiskviewList(req);
		model.addAttribute("orderDiskviewList", orderDiskviewList);
		if (orderDiskviewList.size() != 0) {
			projectId = orderDiskviewList.get(0).getProjectId();
		}

		// 주문서 NAS 정보
		List<CustomReqOrderVO> orderNasviewList = reqCatalogueService.orderNasviewList(req);
		model.addAttribute("orderNasviewList", orderNasviewList);
		if (orderNasviewList.size() != 0) {
			projectId = orderNasviewList.get(0).getProjectId();
		}

		// 주문서 로드밸런스 정보
		List<CustomReqOrderVO> orderLbviewList = reqCatalogueService.orderLbviewList(req);
		model.addAttribute("orderLbviewList", orderLbviewList);
		if (orderLbviewList.size() != 0) {
			projectId = orderLbviewList.get(0).getProjectId();
		}
		// 주문서 스냅샷 정보
		List<CustomReqOrderVO> orderSnviewList = reqCatalogueService.orderSnviewList(req);
		model.addAttribute("orderSnviewList", orderSnviewList);
		if (orderSnviewList.size() != 0) {
			projectId = orderSnviewList.get(0).getProjectId();
		}
		// 주문서 Ip 정보
		List<CustomReqOrderVO> orderIpviewList = reqCatalogueService.orderIpviewList(req);
		model.addAttribute("orderIpviewList", orderIpviewList);

		// 주문서 서비스 정보
		List<CustomReqOrderVO> orderServiceviewList = reqCatalogueService.orderServiceviewList(req);
		model.addAttribute("orderServiceviewList", orderServiceviewList);
		if (orderServiceviewList.size() != 0) {
			projectId = orderServiceviewList.get(0).getProjectId();
		}

		//
		List<CustomReqOrderVO> orderAppviewList = reqCatalogueService.orderAppviewList_sub(req);


		for( int i =0; i<orderAppviewList.size(); ++i) {
			CustomReqOrderVO customReqOrderVO = new CustomReqOrderVO();
			customReqOrderVO = (CustomReqOrderVO) orderAppviewList.get( i);
			CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo( customReqOrderVO.getCloudId());
			//client.deploymentConfigs().inNamespace( customReqOrderVO.getProjectName()).withName( customReqOrderVO.getAppName());

//			DeploymentConfig deploymentConfig = opsApiOptionService.getDeploymentConfig( cloudVo, customReqOrderVO.getProjectName(), customReqOrderVO.getAppName());

			// 20220303 주석 customReqOrderVO.setAfterPodCount( deploymentConfig.getSpec().getReplicas());
				//DeploymentConfigList res = opsApiOptionService.getDeploymentConfigList(cloudVo, customReqOrderVO.getProjectName());
				/*List<DeploymentConfig> items = res.getItems();
			for(DeploymentConfig item : items) {
				Route route = opsApiOptionService.getRoute(cloudVo, vo.getAppNameSpace(), vo.getAppName());
				ServicePort servicePort = opsApiOptionService.getServicePort( cloudVo, vo.getAppNameSpace(), vo.getAppName(), 0);
				item.setAdditionalProperty("cloudName", cloudVo.getCloudName());
				item.setAdditionalProperty("host", route.getSpec().getHost());
				item.setAdditionalProperty("servicePort", servicePort.getPort());
				item.setAdditionalProperty("cloudId", vo.getCloudId());
				item.setAdditionalProperty("projectId", vo.getProjectId());
				item.setAdditionalProperty("templateProductSeq", vo.getTemplateProductSeq());
				item.setAdditionalProperty("templateCatalogSeq", vo.getTemplateCatalogSeq());

			}
			*/

		}

		model.addAttribute("orderAppviewList", orderAppviewList);
		if (orderServiceviewList.size() != 0) {
			projectId = orderServiceviewList.get(0).getProjectId();
		}

		if( orderAppviewList.size() != 0) {
			projectId = orderAppviewList.get(0).getProjectId();
		}

		List<CustomReqOrderVO> orderEnvviewList = reqCatalogueService.orderEnvviewList_sub(req);
		model.addAttribute("orderEnvviewList", orderEnvviewList);
		if( orderEnvviewList.size() != 0) {
			projectId = orderEnvviewList.get(0).getProjectId();
		}

		//앱정보없음

		//앱정보넣는곳

		// 주문서 서비스 backup 정보
//		List<CustomReqOrderVO> orderBakviewList  =  reqCatalogueService.orderBakviewList(req);
//		model.addAttribute("orderBakviewList", orderBakviewList);

		// 주문서 서비스 형상관리 정보
//		List<CustomReqOrderVO> getReqScmOrderList  =  reqCatalogueService.getReqScmOrderList(req);
//		model.addAttribute("getReqScmOrderList", getReqScmOrderList);

		// 주문서 서비스 공용대외계 정보
//		List<CustomReqOrderVO> getReqMcaOrderList  =  reqCatalogueService.getReqMcaOrderList(req);
//		model.addAttribute("getReqMcaOrderList", getReqMcaOrderList);

		// 주문서 서비스 보안관제 정보
//		List<CustomReqOrderVO> getReqSerOrderList  =  reqCatalogueService.getReqSerOrderList(req);
//		model.addAttribute("getReqSerOrderList", getReqSerOrderList);

		// 프로젝트 상세정보
		if (projectId != null) {
			CustomReqProjectVO projectBox = reqProjectService.getProjectBoxId(projectId);
			String projectBoxId = projectBox.getProjectBoxId();
			CustomReqProjectVO projectInfo = reqProjectService.getOkProjectView(projectBoxId);
			projectInfo.setManagerTel(projectInfo.getManagerTelDec());
			model.addAttribute("projectInfo", projectInfo);
		}

		int vmNew = 0;
		int vmCh = 0;
		int vmEx = 0;
		int vmAmount = 0;

		int subNew = 0;
		int subCh = 0;
		int subEx = 0;
		int subAmount = 0;

		int servNew = 0;
		int servCh = 0;
		int servEx = 0;
		int servAmount = 0;

		int serAppNew = 0;
		int serAppCh = 0;
		int serAppEx = 0;
		int serAppAmount = 0;

		int appNew = 0;
		int appCh = 0;
		int appEx = 0;

		int envNew = 0;
		int envCh = 0;
		int envEx = 0;


		int totCnt = 0;
		int totAmount = 0;

		// 기본
		for (int i = 0; i < orderviewList.size(); i++) {
			vmAmount = vmAmount + (int) Float.parseFloat(orderviewList.get(i).getAmount());
			if ((orderviewList.get(i).getRequestName()).equals("신규")) {
				vmNew++;
			} else if ((orderviewList.get(i).getRequestName()).equals("변경")) {
				vmCh++;
			} else if ((orderviewList.get(i).getRequestName()).equals("해지")) {
				vmEx++;
			}
		}
		// 부가
		for (int i = 0; i < orderDiskviewList.size(); i++) {
			subAmount = subAmount + (int) Float.parseFloat(orderDiskviewList.get(i).getAmount());
			if ((orderDiskviewList.get(i).getRequestName()).equals("신규")) {
				subNew++;
			} else if ((orderDiskviewList.get(i).getRequestName()).equals("변경")) {
				subCh++;
			} else if ((orderDiskviewList.get(i).getRequestName()).equals("해지")) {
				subEx++;
			}
		}
		for (int i = 0; i < orderNasviewList.size(); i++) {
			subAmount = subAmount + (int) Float.parseFloat(orderNasviewList.get(i).getAmount());
			if ((orderNasviewList.get(i).getRequestName()).equals("신규")) {
				subNew++;
			} else if ((orderNasviewList.get(i).getRequestName()).equals("변경")) {
				subCh++;
			} else if ((orderNasviewList.get(i).getRequestName()).equals("해지")) {
				subEx++;
			}
		}
		for (int i = 0; i < orderLbviewList.size(); i++) {
			subAmount = 0;
			if ((orderLbviewList.get(i).getRequestName()).equals("신규")) {
				servNew++;
			} else if ((orderLbviewList.get(i).getRequestName()).equals("변경")) {
				servCh++;
			} else if ((orderLbviewList.get(i).getRequestName()).equals("해지")) {
				servEx++;
			}
		}
		for (int i = 0; i < orderIpviewList.size(); i++) {
			subAmount = subAmount + (int) Float.parseFloat(orderIpviewList.get(i).getAmount());
			if ((orderIpviewList.get(i).getRequestName()).equals("신규")) {
				subNew++;
			} else if ((orderIpviewList.get(i).getRequestName()).equals("변경")) {
				subCh++;
			} else if ((orderIpviewList.get(i).getRequestName()).equals("해지")) {
				subEx++;
			}
		}
		// 백업 서비스
//		for(int i=0; i<orderBakviewList.size(); i++){
//			servAmount = servAmount +  (int) Float.parseFloat(orderBakviewList.get(i).getAmount());
//			if((orderBakviewList.get(i).getRequestName()).equals("신규")){
//				servNew++;
//			}else if((orderBakviewList.get(i).getRequestName()).equals("변경")){
//				servCh++;
//			}else if((orderBakviewList.get(i).getRequestName()).equals("해지")){
//				servEx++;
//			}
//		}
		// 서비스
		for (int i = 0; i < orderServiceviewList.size(); i++) {
			servAmount = servAmount + (int) Float.parseFloat(orderServiceviewList.get(i).getAmount());
			if ((orderServiceviewList.get(i).getRequestName()).equals("신규")) {
				servNew++;
			} else if ((orderServiceviewList.get(i).getRequestName()).equals("변경")) {
				servCh++;
			} else if ((orderServiceviewList.get(i).getRequestName()).equals("해지")) {
				servEx++;
			}
		}

		// 어플리케이션
		for (int i = 0; i < orderAppviewList.size(); i++) {
			if ((orderAppviewList.get(i).getRequestName()).equals("신규")) {
				serAppNew++;
			} else if ((orderAppviewList.get(i).getRequestName()).equals("변경")) {
				serAppCh++;
			} else if ((orderAppviewList.get(i).getRequestName()).equals("해지")) {
				serAppEx++;
			}
		}

		// 개발환경
		for (int i = 0; i < orderEnvviewList.size(); i++) {
			if ((orderEnvviewList.get(i).getRequestName()).equals("신규")) {
				envNew++;
			} else if ((orderEnvviewList.get(i).getRequestName()).equals("변경")) {
				envCh++;
			} else if ((orderEnvviewList.get(i).getRequestName()).equals("해지")) {
				envEx++;
			}
		}


//		for(int i=0; i<getReqScmOrderList.size(); i++){
//			servAmount = servAmount +  (int) Float.parseFloat(getReqScmOrderList.get(i).getAmount());
//			if((getReqScmOrderList.get(i).getRequestName()).equals("신규")){
//				servNew++;
//			}else if((getReqScmOrderList.get(i).getRequestName()).equals("변경")){
//				servCh++;
//			}else if((getReqScmOrderList.get(i).getRequestName()).equals("해지")){
//				servEx++;
//			}
//		}
//		for(int i=0; i<getReqMcaOrderList.size(); i++){
//			servAmount = servAmount +  (int) Float.parseFloat(getReqMcaOrderList.get(i).getAmount());
//			if((getReqMcaOrderList.get(i).getRequestName()).equals("신규")){
//				servNew++;
//			}else if((getReqMcaOrderList.get(i).getRequestName()).equals("변경")){
//				servCh++;
//			}else if((getReqMcaOrderList.get(i).getRequestName()).equals("해지")){
//				servEx++;
//			}
//		}
//		for(int i=0; i<getReqSerOrderList.size(); i++){
//			servAmount = servAmount +  (int) Float.parseFloat(getReqSerOrderList.get(i).getAmount());
//			if((getReqSerOrderList.get(i).getRequestName()).equals("신규")){
//				servNew++;
//			}else if((getReqSerOrderList.get(i).getRequestName()).equals("변경")){
//				servCh++;
//			}else if((getReqSerOrderList.get(i).getRequestName()).equals("해지")){
//				servEx++;
//			}
//		}

		totAmount = vmAmount + subAmount + servAmount;
		totCnt = vmNew + vmCh + vmEx + subNew + subCh + subEx + servNew + servCh + servEx + appNew + appCh + appEx + envNew + envCh + envEx;


		model.addAttribute("vmNew", vmNew);
		model.addAttribute("vmCh", vmCh);
		model.addAttribute("vmEx", vmEx);
		model.addAttribute("vmAmount", vmAmount);
		model.addAttribute("subNew", subNew);
		model.addAttribute("subCh", subCh);
		model.addAttribute("subEx", subEx);
		model.addAttribute("subAmount", subAmount);
		model.addAttribute("servNew", servNew);
		model.addAttribute("servCh", servCh);
		model.addAttribute("servEx", servEx);
		model.addAttribute("servAmount", servAmount);
		model.addAttribute("totAmount", totAmount);
		model.addAttribute("totCnt", totCnt);
		model.addAttribute("serAppNew", serAppNew);
		model.addAttribute("serAppCh", serAppCh);
		model.addAttribute("serAppEx", serAppEx);

		model.addAttribute("envNew", envNew);
		model.addAttribute("envCh", envCh);
		model.addAttribute("envEx", envEx);


		return "mbr/req/catalogue/bssOrderView";
	}

	/*
	 * 상품 신청현황 상세 화면
	 */
	@RequestMapping(value = "/bssOrderApproveView")
	public String bssOrderApproveView(CustomReqOrderVO req, Model model, Principal principal) {

		final String orderNo = req.getOrderNo();
		final String loginUserId = principal.getName();
		Assert.notNull(orderNo, "");
		Assert.notNull(loginUserId, "");
		model.addAttribute("orderNo", orderNo);
		model.addAttribute("loginUserId", loginUserId);

		// 상품 신청현황 PM,회원사 승인처리 리스트
		/*
		 * String requestSeq =req.getOrderNo(); CustomReqCatalogueVO catalolovo = new
		 * CustomReqCatalogueVO(); catalolovo.setRequestSeq(requestSeq);
		 *
		 * catalolovo.setFlowId("AFW0030"); List<CustomReqCustomerVO> approvalList =
		 * reqCatalogueService.approvalList(catalolovo); List<CustomReqCustomerVO>
		 * approvalUserId = reqCatalogueService.approvalUserId(catalolovo);
		 * model.addAttribute("getProjectAppSteplist", approvalList);
		 * model.addAttribute("approvalUserId", approvalUserId);
		 *
		 * catalolovo.setFlowId("AFW0040"); List<CustomReqCustomerVO> approvalList2 =
		 * reqCatalogueService.approvalList(catalolovo); List<CustomReqCustomerVO>
		 * approvalUserId2 = reqCatalogueService.approvalUserId(catalolovo);
		 * model.addAttribute("getProjectAppSteplist2", approvalList2);
		 * model.addAttribute("approvalUserId2", approvalUserId2);
		 */

		// 프로젝트 ID값
		String projectId = null;

		String codeKeyId = "APPRV_STATE";
		List<CustomBbsNoticeVO> getNoticeBbscodeList = bbsNoticeservice.getNoticeBbscodeList(codeKeyId);
		model.addAttribute("code", getNoticeBbscodeList);

		Map<String, String> map = new HashMap<>();
		map.put("userId", loginUserId);
		map.put("orderNo", orderNo);

		// #### 결재라인 불러오기 시작 ####
		// 승인스텝멤버 불러오기
		String stepId = reqProductService.getStepId(map);
		map.put("stepId", stepId);
		model.addAttribute("stepId", stepId);

		String userApprvState = "";
		userApprvState = reqProductService.getUserApprvState(map);
		model.addAttribute("userApprvState", userApprvState);

		List<CustomReqProductVO> approvalList3 = reqProductService.approvalList(map);
		for (int i = 0; i < approvalList3.size(); i++) {
			if (approvalList3.get(i).getApprvState().equals("APPRV_REJECTED")) {
				String inject = "Y";
				model.addAttribute("inject", inject);
			}
		}
		model.addAttribute("getResourceApprovalStep", approvalList3);

		// 승인스텝멤버 유저 아이디 조회
		List<CustomReqProductVO> approvalUserId3 = reqProductService.approvalUserId(orderNo);
		model.addAttribute("approvalUserId3", approvalUserId3);

		// 주문자명 아이디 가져오기 (상품신청 승인 및 취소시) 2017.08.24
		CustomReqProductVO getOrderUserId3 = reqProductService.getOrderVo(orderNo);
		model.addAttribute("getOrderUserId3", getOrderUserId3);

		// ### 결재라인 불러오기 끝 ###

		// 주문서 정보
		CustomReqOrderVO orderview = reqCatalogueService.orderview(req);
		model.addAttribute("orderview", orderview);

		// 주문서 VM 정보
		List<CustomReqOrderVO> orderviewList = reqCatalogueService.orderviewList(req);
		model.addAttribute("orderviewList", orderviewList);
		if (orderviewList.size() != 0) {
			projectId = orderviewList.get(0).getProjectId();
		}

		// 주문서 DISK 정보
		List<CustomReqOrderVO> orderDiskviewList = reqCatalogueService.orderDiskviewList(req);
		model.addAttribute("orderDiskviewList", orderDiskviewList);
		if (orderDiskviewList.size() != 0) {
			projectId = orderDiskviewList.get(0).getProjectId();
		}

		// 주문서 NAS 정보
		List<CustomReqOrderVO> orderNasviewList = reqCatalogueService.orderNasviewList(req);
		model.addAttribute("orderNasviewList", orderNasviewList);
		if (orderNasviewList.size() != 0) {
			projectId = orderNasviewList.get(0).getProjectId();
		}

		// 주문서 로드밸런스 정보
		List<CustomReqOrderVO> orderLbviewList = reqCatalogueService.orderLbviewList(req);
		model.addAttribute("orderLbviewList", orderLbviewList);
		if (orderLbviewList.size() != 0) {
			projectId = orderLbviewList.get(0).getProjectId();
		}
		// 주문서 스냅샷 정보
		List<CustomReqOrderVO> orderSnviewList = reqCatalogueService.orderSnviewList(req);
		model.addAttribute("orderSnviewList", orderSnviewList);
		if (orderSnviewList.size() != 0) {
			projectId = orderSnviewList.get(0).getProjectId();
		}
		// 주문서 Ip 정보
		List<CustomReqOrderVO> orderIpviewList = reqCatalogueService.orderIpviewList(req);
		model.addAttribute("orderIpviewList", orderIpviewList);

		// 주문서 서비스 정보
		List<CustomReqOrderVO> orderServiceviewList = reqCatalogueService.orderServiceviewList(req);
		model.addAttribute("orderServiceviewList", orderServiceviewList);
		if (orderServiceviewList.size() != 0) {
			projectId = orderServiceviewList.get(0).getProjectId();
		}

//		List<CustomReqOrderVO> orderAppviewList = reqCatalogueService.orderAppviewList(req);
//		model.addAttribute("orderAppviewList", orderAppviewList);
//		if (orderAppviewList.size() != 0) {
//			projectId = orderAppviewList.get(0).getProjectId();
//		}

		List<CustomReqOrderVO> orderAppviewList = reqCatalogueService.orderAppviewList_sub(req);
//		for( int i =0; i<orderAppviewList.size(); ++i) {
//			CustomReqOrderVO customReqOrderVO = new CustomReqOrderVO();
//			customReqOrderVO = (CustomReqOrderVO) orderAppviewList.get( i);
//			CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo( customReqOrderVO.getCloudId());
			//client.deploymentConfigs().inNamespace( customReqOrderVO.getProjectName()).withName( customReqOrderVO.getAppName());

//			DeploymentConfig deploymentConfig = opsApiOptionService.getDeploymentConfig( cloudVo, customReqOrderVO.getProjectName(), customReqOrderVO.getAppName());

			// 20220303 주석 customReqOrderVO.setAfterPodCount( deploymentConfig.getSpec().getReplicas());
				//DeploymentConfigList res = opsApiOptionService.getDeploymentConfigList(cloudVo, customReqOrderVO.getProjectName());
				/*List<DeploymentConfig> items = res.getItems();
			for(DeploymentConfig item : items) {
				Route route = opsApiOptionService.getRoute(cloudVo, vo.getAppNameSpace(), vo.getAppName());
				ServicePort servicePort = opsApiOptionService.getServicePort( cloudVo, vo.getAppNameSpace(), vo.getAppName(), 0);
				item.setAdditionalProperty("cloudName", cloudVo.getCloudName());
				item.setAdditionalProperty("host", route.getSpec().getHost());
				item.setAdditionalProperty("servicePort", servicePort.getPort());
				item.setAdditionalProperty("cloudId", vo.getCloudId());
				item.setAdditionalProperty("projectId", vo.getProjectId());
				item.setAdditionalProperty("templateProductSeq", vo.getTemplateProductSeq());
				item.setAdditionalProperty("templateCatalogSeq", vo.getTemplateCatalogSeq());

			}
			*/
//		}

		model.addAttribute("orderAppviewList", orderAppviewList);
		if (orderServiceviewList.size() != 0) {
			projectId = orderServiceviewList.get(0).getProjectId();
		}

		if( orderAppviewList.size() != 0) {
			projectId = orderAppviewList.get(0).getProjectId();
		}

		List<CustomReqOrderVO> orderEnvviewList = reqCatalogueService.orderEnvviewList_sub(req);
		model.addAttribute("orderEnvviewList", orderEnvviewList);
		if( orderEnvviewList.size() != 0) {
			projectId = orderEnvviewList.get(0).getProjectId();
		}


		// 주문서 서비스 backup 정보
//		List<CustomReqOrderVO> orderBakviewList  =  reqCatalogueService.orderBakviewList(req);
//		model.addAttribute("orderBakviewList", orderBakviewList);

		// 주문서 서비스 형상관리 정보
//		List<CustomReqOrderVO> getReqScmOrderList  =  reqCatalogueService.getReqScmOrderList(req);
//		model.addAttribute("getReqScmOrderList", getReqScmOrderList);

		// 주문서 서비스 공용대외계 정보
//		List<CustomReqOrderVO> getReqMcaOrderList  =  reqCatalogueService.getReqMcaOrderList(req);
//		model.addAttribute("getReqMcaOrderList", getReqMcaOrderList);

		// 주문서 서비스 보안관제 정보
//		List<CustomReqOrderVO> getReqSerOrderList  =  reqCatalogueService.getReqSerOrderList(req);
//		model.addAttribute("getReqSerOrderList", getReqSerOrderList);

		// 프로젝트 상세정보
		if (projectId != null) {
			CustomReqProjectVO projectBox = reqProjectService.getProjectBoxId(projectId);
			String projectBoxId = projectBox.getProjectBoxId();
			CustomReqProjectVO projectInfo = reqProjectService.getOkProjectView(projectBoxId);
			projectInfo.setManagerTel(projectInfo.getManagerTelDec());
			model.addAttribute("projectInfo", projectInfo);
			CustomCmmFileVO vo = new CustomCmmFileVO();
			vo.setProgramName(CodeUtil.FILE_PROGRAM_NAME4);
			vo.setProgramSeq(projectInfo.getProgramSeq()+"");

			model.addAttribute("file", cmmFileService.list(vo));
		}

		int vmNew = 0;
		int vmCh = 0;
		int vmEx = 0;
		int vmAmount = 0;

		int subNew = 0;
		int subCh = 0;
		int subEx = 0;
		int subAmount = 0;

		int servNew = 0;
		int servCh = 0;
		int servEx = 0;
		int servAmount = 0;

		int appNew = 0;
		int appCh = 0;
		int appEx = 0;

		int envNew = 0;
		int envCh = 0;
		int envEx = 0;

		int deployNew = 0;
		int deployCh = 0;
		int deployEx = 0;

		int totCnt = 0;
		int totAmount = 0;

		// 기본
		for (int i = 0; i < orderviewList.size(); i++) {
			vmAmount = vmAmount + (int) Float.parseFloat(orderviewList.get(i).getAmount());
			if ((orderviewList.get(i).getRequestName()).equals("신규")) {
				vmNew++;
			} else if ((orderviewList.get(i).getRequestName()).equals("변경")) {
				vmCh++;
			} else if ((orderviewList.get(i).getRequestName()).equals("해지")) {
				vmEx++;
			}
		}
		// 부가
		for (int i = 0; i < orderDiskviewList.size(); i++) {
			subAmount = subAmount + (int) Float.parseFloat(orderDiskviewList.get(i).getAmount());
			if ((orderDiskviewList.get(i).getRequestName()).equals("신규")) {
				subNew++;
			} else if ((orderDiskviewList.get(i).getRequestName()).equals("변경")) {
				subCh++;
			} else if ((orderDiskviewList.get(i).getRequestName()).equals("해지")) {
				subEx++;
			}
		}
		for (int i = 0; i < orderNasviewList.size(); i++) {
			subAmount = subAmount + (int) Float.parseFloat(orderNasviewList.get(i).getAmount());
			if ((orderNasviewList.get(i).getRequestName()).equals("신규")) {
				subNew++;
			} else if ((orderNasviewList.get(i).getRequestName()).equals("변경")) {
				subCh++;
			} else if ((orderNasviewList.get(i).getRequestName()).equals("해지")) {
				subEx++;
			}
		}
		for (int i = 0; i < orderLbviewList.size(); i++) {
			subAmount = 0;
			if ((orderLbviewList.get(i).getRequestName()).equals("신규")) {
				servNew++;
			} else if ((orderLbviewList.get(i).getRequestName()).equals("변경")) {
				servCh++;
			} else if ((orderLbviewList.get(i).getRequestName()).equals("해지")) {
				servEx++;
			}
		}
		for (int i = 0; i < orderIpviewList.size(); i++) {
			subAmount = subAmount + (int) Float.parseFloat(orderIpviewList.get(i).getAmount());
			if ((orderIpviewList.get(i).getRequestName()).equals("신규")) {
				subNew++;
			} else if ((orderIpviewList.get(i).getRequestName()).equals("변경")) {
				subCh++;
			} else if ((orderIpviewList.get(i).getRequestName()).equals("해지")) {
				subEx++;
			}
		}

		// 서비스
		for (int i = 0; i < orderServiceviewList.size(); i++) {
			servAmount = servAmount + (int) Float.parseFloat(orderServiceviewList.get(i).getAmount());
			if ((orderServiceviewList.get(i).getRequestName()).equals("신규")) {
				servNew++;
			} else if ((orderServiceviewList.get(i).getRequestName()).equals("변경")) {
				servCh++;
			} else if ((orderServiceviewList.get(i).getRequestName()).equals("해지")) {
				servEx++;
			}
		}

		// 어플리케이션
		for (int i = 0; i < orderAppviewList.size(); i++) {
			//appAmount = appAmount + (int) Float.parseFloat(orderAppviewList.get(i).getAmount());
			if ((orderAppviewList.get(i).getRequestName()).equals("신규")) {
				appNew++;
			} else if ((orderAppviewList.get(i).getRequestName()).equals("변경")) {
				appCh++;
			} else if ((orderAppviewList.get(i).getRequestName()).equals("해지")) {
				appEx++;
			}
		}

		// 개발환경
		for (int i = 0; i < orderEnvviewList.size(); i++) {
			if ((orderEnvviewList.get(i).getRequestName()).equals("신규")) {
				envNew++;
			} else if ((orderEnvviewList.get(i).getRequestName()).equals("변경")) {
				envCh++;
			} else if ((orderEnvviewList.get(i).getRequestName()).equals("해지")) {
				envEx++;
			}
		}

		// 백업 서비스
//		for(int i=0; i<orderBakviewList.size(); i++){
//			servAmount = servAmount +  (int) Float.parseFloat(orderBakviewList.get(i).getAmount());
//			if((orderBakviewList.get(i).getRequestName()).equals("신규")){
//				servNew++;
//			}else if((orderBakviewList.get(i).getRequestName()).equals("변경")){
//				servCh++;
//			}else if((orderBakviewList.get(i).getRequestName()).equals("해지")){
//				servEx++;
//			}
//		}
//		for(int i=0; i<getReqScmOrderList.size(); i++){
//			servAmount = servAmount +  (int) Float.parseFloat(getReqScmOrderList.get(i).getAmount());
//			if((getReqScmOrderList.get(i).getRequestName()).equals("신규")){
//				servNew++;
//			}else if((getReqScmOrderList.get(i).getRequestName()).equals("변경")){
//				servCh++;
//			}else if((getReqScmOrderList.get(i).getRequestName()).equals("해지")){
//				servEx++;
//			}
//		}
//		for(int i=0; i<getReqMcaOrderList.size(); i++){
//			servAmount = servAmount +  (int) Float.parseFloat(getReqMcaOrderList.get(i).getAmount());
//			if((getReqMcaOrderList.get(i).getRequestName()).equals("신규")){
//				servNew++;
//			}else if((getReqMcaOrderList.get(i).getRequestName()).equals("변경")){
//				servCh++;
//			}else if((getReqMcaOrderList.get(i).getRequestName()).equals("해지")){
//				servEx++;
//			}
//		}
//		for(int i=0; i<getReqSerOrderList.size(); i++){
//			servAmount = servAmount +  (int) Float.parseFloat(getReqSerOrderList.get(i).getAmount());
//			if((getReqSerOrderList.get(i).getRequestName()).equals("신규")){
//				servNew++;
//			}else if((getReqSerOrderList.get(i).getRequestName()).equals("변경")){
//				servCh++;
//			}else if((getReqSerOrderList.get(i).getRequestName()).equals("해지")){
//				servEx++;
//			}
//		}

		totAmount = vmAmount + subAmount + servAmount;
		totCnt = vmNew + vmCh + vmEx + subNew + subCh + subEx + servNew + servCh + servEx + appNew + appCh + appEx + envNew + envCh + envEx;



		model.addAttribute("vmNew", vmNew);
		model.addAttribute("vmCh", vmCh);
		model.addAttribute("vmEx", vmEx);
		model.addAttribute("vmAmount", vmAmount);
		model.addAttribute("subNew", subNew);
		model.addAttribute("subCh", subCh);
		model.addAttribute("subEx", subEx);
		model.addAttribute("appNew", appNew);
		model.addAttribute("appCh", appCh);
		model.addAttribute("appEx", appEx);
		model.addAttribute("subAmount", subAmount);
		model.addAttribute("servNew", servNew);
		model.addAttribute("servCh", servCh);
		model.addAttribute("servEx", servEx);
		model.addAttribute("servAmount", servAmount);
		model.addAttribute("totAmount", totAmount);
		model.addAttribute("totCnt", totCnt);

		model.addAttribute("envNew", envNew);
		model.addAttribute("envCh", envCh);
		model.addAttribute("envEx", envEx);

		return "mbr/req/catalogue/bssOrderApproveView";
	}

//	//PM 상품 신청현황  상세 화면 가상서버 팝업
//	@RequestMapping(value = "/bssOrderviewPopup")
//	public ResponseEntity<Object> bssOrderviewPopup(CustomReqOrderVO req, Model model){
//
//		final String orderNo = req.getOrderNo();
//		Assert.notNull(orderNo, "");
//		model.addAttribute("orderNo", orderNo);
//
//		//주문서 VM 정보
//		List<CustomReqOrderVO> list  =  reqCatalogueService.orderviewList(req);
//		CustomReqOrderVO res = list.get(0);
//
//		return new ResponseEntity<Object>(res, HttpStatus.OK);
//	}

	// PM 상품 신청현황 승인처리
	@RequestMapping(value = "/stepUpdate", method = { RequestMethod.GET, RequestMethod.POST })
	public ResponseEntity<String> mngStepUpdate(CustomReqCustomerVO req) {
		String res = "";
		String requestSeq = req.getRequestSeq();
		String rightStepId = req.getRightStepId();
		String stepLevel = req.getStepLevel();

		req.setModUserId(req.getRegUserId());
		if (rightStepId.equals("*")) {
			String apprvState = "APPRV_COMPLETED";
//			String apprvDescription = req.getApprvDescription();
//			if(apprvDescription.equals(null)){
//				apprvDescription="(NULL)";
//			}
			req.setApprvState(apprvState);

			res = customerService.stepUpdate(req);

			// VM 신청 관리자 승인 스텝모델 입력
			// 사용자 승인 스텝 입력
			List<CustomReqCustomerVO> getApprovalModelSteplist = reqCatalogueService.getApprovalModelSteplist2();
			for (int i = 0; i < getApprovalModelSteplist.size(); i++) {
				CustomReqCustomerVO appmodelstep = new CustomReqCustomerVO();
				appmodelstep.setRequestSeq(requestSeq);
				appmodelstep.setStepId(getApprovalModelSteplist.get(i).getStepId());
				if (!appmodelstep.getStepId().equals("")) {

				}
				appmodelstep.setModelId(getApprovalModelSteplist.get(i).getModelId());
				appmodelstep.setStepName(getApprovalModelSteplist.get(i).getStepName());
				appmodelstep.setStepLevel(getApprovalModelSteplist.get(i).getStepLevel());
				appmodelstep.setLeftStepId(getApprovalModelSteplist.get(i).getLeftStepId());
				appmodelstep.setRightStepId(getApprovalModelSteplist.get(i).getRightStepId());
				if (appmodelstep.getStepLevel().equals("1")) {
					appmodelstep.setApprvState("APPRV_PROCESSING");
				} else {
					appmodelstep.setApprvState("APPRV_WAITING");
				}
				reqCatalogueService.setSrApprovalStepinsert2(appmodelstep);
			}

			List<CustomReqCustomerVO> getApprovalModelMemberlist = reqCatalogueService.getApprovalModelMemberlist2();
			for (int i = 0; i < getApprovalModelMemberlist.size(); i++) {
				CustomReqCustomerVO appmember = new CustomReqCustomerVO();
				appmember.setRequestSeq(requestSeq);
				appmember.setStepId(getApprovalModelMemberlist.get(i).getStepId());
				appmember.setUserId(getApprovalModelMemberlist.get(i).getUserId());
				appmember.setApprvAuthFlag(getApprovalModelMemberlist.get(i).getApprvAuthFlag());
				appmember.setMailRecvFlag(getApprovalModelMemberlist.get(i).getMailRecvFlag());
				appmember.setSmsRecvFlag(getApprovalModelMemberlist.get(i).getSmsRecvFlag());
				appmember.setPushRecvFlag(getApprovalModelMemberlist.get(i).getPushRecvFlag());

				reqCatalogueService.setSrApprovalMemberinsert2(appmember);
			}

		} else if (rightStepId != "*") {
			String apprvState = "APPRV_COMPLETED";
			req.setApprvState(apprvState);
			res = customerService.stepUpdate(req);
			if (stepLevel.equals("1")) {
//				String apprvDescription = req.getApprvDescription();
//				if(apprvDescription.equals(null)){
//					apprvDescription="(NULL)";
//				}
				stepLevel = "2";
				log.debug("=== stepLevel2 ===" + stepLevel);
			} else if (stepLevel.equals("2")) {
				String apprvDescription = req.getApprvDescription();
				if (apprvDescription.equals(null)) {
					apprvDescription = "(NULL)";
				}
				stepLevel = "3";
			}
			apprvState = "APPRV_PROCESSING";
			String apprvDescription = "(NULL)";
			req.setApprvDescription(apprvDescription);
			req.setApprvState(apprvState);
			req.setStepLevel(stepLevel);
			res = customerService.stepUpdate(req);
		}

		return new ResponseEntity<String>(res, HttpStatus.OK);
	}

	// PM 상품 신청현황 미승인처리
	@RequestMapping(value = "/rejectedUpdate", method = { RequestMethod.GET, RequestMethod.POST })
	public ResponseEntity<String> rejectedUpdate(CustomReqCustomerVO req) {
		String res = "";
		String requestSeq = req.getRequestSeq();
		String stepLevel = req.getStepLevel();
		// req.setModUserId(req.getRegUserId());

		String apprvState = "APPRV_REJECTED";
		String apprvDescription = req.getApprvDescription();
		req.setApprvDescription(apprvDescription);
		req.setApprvState(apprvState);
		req.setStepLevel(stepLevel);
		res = customerService.stepUpdate(req);
		// res = customerService.rejectedUpdate(req);

		return new ResponseEntity<String>(res, HttpStatus.OK);
	}

	// 카테고리 부가상품 리스트
	@RequestMapping(value = "/catalogueSubList.do")
	@Secured({ "ROLE_CUSTOM_USER" })
	public String catalogueSubList(HttpServletRequest request, Model model) {

		CustomReqCatalogueVO customCatalogVO = new CustomReqCatalogueVO();
		customCatalogVO.setApplyDate(DateFormatUtils.format(new Date(), "yyyy-MM-dd"));
		customCatalogVO.setEnableRecommandFlag("N"); // 모든상품 보여주기 && Display Falg = N
		customCatalogVO.setConditionCategory(Arrays.asList("CATACATE_DISK", "CATACATE_NAS")); // 기본상품(VM) Category에 해당하는것

		List<CustomReqCatalogueVO> getCatalogueList = reqCatalogueService.getCatalogueList(customCatalogVO);
		model.addAttribute("getCatalogueList", getCatalogueList);
		return "mbr/req/catalogue/catalogueSubList";
	}

	@RequestMapping(value = "/diskList")
	public ResponseEntity<Object> getDiskList(HttpServletRequest request, Model model) {

		CustomReqCatalogueVO customCatalogVO = new CustomReqCatalogueVO();
		customCatalogVO.setApplyDate(DateFormatUtils.format(new Date(), "yyyy-MM-dd"));
		customCatalogVO.setEnableRecommandFlag("N"); // 모든상품 보여주기 && Display Falg = N
		customCatalogVO.setConditionCategory(Arrays.asList("CATACATE_DISK", "CATACATE_NAS"));// 기본상품(VM) Category에 해당하는것

		List<CustomReqCatalogueVO> getCatalogueList = reqCatalogueService.getCatalogueList(customCatalogVO);
		model.addAttribute("getCatalogueList", getCatalogueList);

		return new ResponseEntity<Object>(getCatalogueList, HttpStatus.OK);
	}

	// 카테고리 로드 밸런서 주문
	@RequestMapping(value = "/catalogueLoadBalancerOrder.do", params = "!type", method = RequestMethod.GET)
	public String catalogueLoadBalancerOrder(HttpServletRequest request, Model model) {
		UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		model.addAttribute("apprvPass", userSession.getApprvPass());

		String productSeq = request.getParameter("productSeq");
		String hourlyFlag = request.getParameter("hourlyFlag");
		Assert.notNull(productSeq, "");
//		Assert.notNull(hourlyFlag, "");

		CustomReqCatalogueVO projectvo = new CustomReqCatalogueVO();
		projectvo.setProductSeq(productSeq);
		projectvo.setApplyDate(DateFormatUtils.format(new Date(), "yyyy-MM-dd"));

		CustomCmmUserVO cmmUserInfo = new CustomCmmUserVO();
		cmmUserInfo.setUserId(request.getUserPrincipal().getName());
		cmmUserInfo = cmmUserService.userInfoDetail(cmmUserInfo);
		model.addAttribute("userLevelCode", cmmUserInfo.getUserLevelCode());

		CustomReqCatalogueVO getCatalogueSubList = reqCatalogueService.getCatalogueSelectView(projectvo);
		getCatalogueSubList.setHourlyFlag(hourlyFlag);
		getCatalogueSubList.setTotalPrice(getCatalogueSubList.getMonthlyPrice());
		model.addAttribute("getCatalogueSubList", getCatalogueSubList);

		List<CustomCmmCodeVO> getLoadProtocol = cmmCodeService.getLoadProtocol();
		model.addAttribute("protocolList", getLoadProtocol);

		List<CustomCmmCodeVO> getLoadMethod = cmmCodeService.getLoadMethod();
		model.addAttribute("methodList", getLoadMethod);

		List<CustomCmmCodeVO> getLoadMonitorType = cmmCodeService.getLoadMonitorType();
		model.addAttribute("monitorTypeList", getLoadMonitorType);

		OssZoneNetworkDiskVO req = new OssZoneNetworkDiskVO();
		List<OssZoneNetworkDiskVO> networkList = OssZoneNetworkDiskService.list(req);
		model.addAttribute("networkList", networkList);

		CustomReqCatalogueVO hourlyvo = new CustomReqCatalogueVO();
		hourlyvo.setHourlyFlag(hourlyFlag);
		model.addAttribute("hourlyvo", hourlyvo);

		return "mbr/req/catalogue/catalogueLoadBalancerOrder";
	}

	// 카테고리 스냅샷 주문
	@RequestMapping(value = "/catalogueSnapShotOrder.do", params = "!type", method = RequestMethod.GET)
	public String catalogueSnapShotOrder(HttpServletRequest request, Model model) {
		UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		model.addAttribute("apprvPass", userSession.getApprvPass());

		String productSeq = request.getParameter("productSeq");
		String hourlyFlag = request.getParameter("hourlyFlag");
		Assert.notNull(productSeq, "");
//			Assert.notNull(hourlyFlag, "");

		CustomReqCatalogueVO projectvo = new CustomReqCatalogueVO();
		projectvo.setProductSeq(productSeq);
		projectvo.setApplyDate(DateFormatUtils.format(new Date(), "yyyy-MM-dd"));

		CustomCmmUserVO cmmUserInfo = new CustomCmmUserVO();
		cmmUserInfo.setUserId(request.getUserPrincipal().getName());
		cmmUserInfo = cmmUserService.userInfoDetail(cmmUserInfo);
		model.addAttribute("userLevelCode", cmmUserInfo.getUserLevelCode());

		CustomReqCatalogueVO getCatalogueSubList = reqCatalogueService.getCatalogueSelectView(projectvo);
		getCatalogueSubList.setHourlyFlag(hourlyFlag);
		getCatalogueSubList.setTotalPrice(getCatalogueSubList.getMonthlyPrice());
		model.addAttribute("getCatalogueSubList", getCatalogueSubList);

		CustomReqCatalogueVO hourlyvo = new CustomReqCatalogueVO();
		hourlyvo.setHourlyFlag(hourlyFlag);
		model.addAttribute("hourlyvo", hourlyvo);

		return "mbr/req/catalogue/catalogueSnapShotOrder";
	}

//	@RequestMapping(value="/price")
//	public ResponseEntity<Object> MbrReqCataloguePrice(CustomReqCatalogueVO req) {
//		//req.setApplyDate(DateFormatUtils.format(new Date(), "yyyy-MM-dd"));
//		//req = reqCatalogueService.getCatalogueSelectView(req);
//
//		req = reqCatalogueService.getCatalogueItempric(req);
//
//		if(req == null){
//			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
//		}
//
//		return new ResponseEntity<Object>(req, HttpStatus.OK);
//	}

	// vm_network 조회
	@RequestMapping(value = "/vmNetworkList", method = RequestMethod.GET)
	public ResponseEntity<Object> getVmNetworkList(HttpServletRequest request) {

		final String networkId = request.getParameter("networkId");
		Assert.notNull(networkId, "");

		CustomReqCatalogueVO projectvo = new CustomReqCatalogueVO();
		projectvo.setRegUserId(request.getUserPrincipal().getName());
		projectvo.setNetworkId(networkId);
		List<CustomReqCatalogueVO> res = reqCatalogueService.getVmNetworkList(projectvo);

		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	// oss_network 조회
	@RequestMapping(value = "/networkList", method = RequestMethod.GET)
	public ResponseEntity<Object> getnetworkList(HttpServletRequest request, Model model) {

		final String projectId = request.getParameter("projectId");
		Assert.notNull(projectId, "");

		CustomReqCatalogueVO projectvo = new CustomReqCatalogueVO();
		projectvo.setRegUserId(request.getUserPrincipal().getName());
		projectvo.setProjectId(projectId);
		List<CustomReqCatalogueVO> res = reqCatalogueService.getNetworkList(projectvo);

		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	// 로드밸런서 바로 주문시 페이지 이동
	@RequestMapping(value = "/catalogueLoadOrderNow.do", params = "type=noworder")
	public String catalogueLoadOrderNow(Model model, CustomReqCatalogueVO ordervo) {

		model.addAttribute("ordervo", ordervo);

		// log.debug("ordervo.getTotalPrice() : " + ordervo.getTotalPrice());
		return "mbr/req/catalogue/catalogueLoadBalancerOrderNow";
	}

	// 로드밸런서 해지 바로 주문시 페이지 이동
	@RequestMapping(value = "/catalogueLoadOrderNow.do", params = "type=noworderlbexpr")
	public String catalogueLoadExprOrderNow(HttpServletRequest request, Model model, CustomReqCatalogueVO ordervo) {

		ordervo.setApplyDatetime(request.getParameter("lb_expr_tab_applyTime"));
		ordervo.setApplyTime(request.getParameter("lb_expr_tab_applyTime"));
		ordervo.setApplyDate(request.getParameter("lb_expr_applyDate"));
		ordervo.setDescription(request.getParameter("lbdescription"));
		ordervo.setLoadbalancerId(request.getParameter("loadbalancerId"));
		ordervo.setLoadbalancerName(request.getParameter("lbloadbalancerName"));
		ordervo.setRequestType("REQTYPE_EXPR");
		ordervo.setNetworkAlias(request.getParameter("lbnetworkAlias"));
		// ordervo.setVmName(request.getParameter("iphostnameAlias"));
		// ordervo.setVmUuid(request.getParameter("ipvmUuid"));

		ordervo.setTotalPrice(request.getParameter("lbtotalPrice"));
		ordervo.setProjectAlias(request.getParameter("lbprojectAlias"));
		ordervo.setProjectId(request.getParameter("lbprojectId"));
		ordervo.setProductSeq(request.getParameter("lbproductSeq"));
		ordervo.setProductCategory(request.getParameter("lbproductCategory"));
		ordervo.setCatalogSeq(request.getParameter("lbcatalogSeq"));
		ordervo.setImageName(request.getParameter("lbimageName"));

		ordervo.setProtocolName(request.getParameter("lbprotocolName"));
		ordervo.setProtocol(request.getParameter("lbprotocol"));
		ordervo.setMethod(request.getParameter("lbmethod"));
		ordervo.setMethodName(request.getParameter("lbmethodName"));
		ordervo.setMonitorType(request.getParameter("lbmonitorType"));
		ordervo.setMonitorTypeName(request.getParameter("lbmonitorTypeName"));
		ordervo.setNetworkId(request.getParameter("lbnetworkId"));
		ordervo.setVmNetworkName(request.getParameter("lbloadbalancerVm"));

		model.addAttribute("ordervo", ordervo);

		return "mbr/req/catalogue/catalogueLoadBalancerOrderNow";
	}

	// 로드밸런서 상품 바로 주문 입력
	@RequestMapping(value = "/catalogueLoadOrderNow", params = "type=noworderinsert")
	public ResponseEntity<Object> catalogueLoadOrderNowinsert(HttpServletRequest request, Model model,
			CustomReqOrderVO ordervo) {

		ordervo.setOrderUserId(request.getUserPrincipal().getName());
		model.addAttribute("ordervo", ordervo);

		String orderProductSeq = DateFormatUtils.format(new Date(), "yyyyMMddHHmmss");
		String orderNo = orderProductSeq;

		ordervo.setOrderProductSeq(orderProductSeq);
		ordervo.setOrderNo(orderNo);

		if (ordervo.getRequestType().equals("")) {
			ordervo.setRequestType("REQTYPE_NEW");
		}

		// log.debug("ordervo.getParameter() : " +
		// request.getParameter("defaultNetworkAlias"));
		// log.debug("ordervo.getDefaultNetworkAlias() : " +
		// ordervo.getDefaultNetworkAlias());
		// log.debug("ordervo.getNetworkAlias() : " +
		// ordervo.getNetworkAlias());

//		String vmNetwork = ordervo.getVmNetwork();
//		String vmNetworkChk = ordervo.getVmNetworkChk();

		// 프로젝트 네트워크 입력
		// String []vmNetworks = vmNetwork.split(",");
		/*
		 * if(ordervo.getRequestType().equals("REQTYPE_NEW")){
		 *
		 * String []vmNetworks = vmNetworkChk.split(",");
		 *
		 * for(int i=0;i<vmNetworks.length;i++){
		 *
		 *
		 * CustomReqOrderVO netVo = new CustomReqOrderVO(); String []reqnet =
		 * vmNetworks[i].split(":"); netVo.setOrderProductSeq(orderNo);
		 * netVo.setVmUuid(reqnet[1]); reqCatalogueService.setOrderProductLbVm(netVo);
		 *
		 * } }
		 */

		String orderSummary = "";
		orderSummary = "<table><colgroup><col width='30%'><col width='70%'></colgroup><tbody>";
		orderSummary = orderSummary + "<tr><td class='left'>서비스시작일시</td><td>" + ordervo.getApplyDatetime()
				+ "</td></tr>";
		orderSummary = orderSummary + "<tr><td class='left'>프로젝트</td><td>" + ordervo.getProjectName() + " </td></tr>";
		/*
		 * orderSummary = orderSummary
		 * ="<tr><td class='left'>네트워크 ZONE</td><td>"+ordervo.getNetworkAlias()
		 * +" </td></tr>"; orderSummary = orderSummary
		 * ="<tr><td class='left'>가상서버</td><td>"+ordervo.getVmNetworkName()
		 * +" </td></tr>";
		 */
		orderSummary = orderSummary + "<tr><td class='left'>서비스 네트워크명</td><td>" + ordervo.getLoadBalancerName()
				+ "</td></tr>";
		/*
		 * orderSummary = orderSummary
		 * ="<tr><td class='left'>Protocol</td><td>"+ordervo.getProtocol()+"</td></tr>";
		 * orderSummary = orderSummary
		 * ="<tr><td class='left'>Method</td><td>"+ordervo.getMethod()+"</td></tr>";
		 * orderSummary = orderSummary
		 * ="<tr><td class='left'>Monitor Type</td><td>"+ordervo.getMonitorType()+
		 * "</td></tr>"; orderSummary = orderSummary
		 * ="<tr><td class='left'>비고</td><td>"+ordervo.getDescription()+"</td></tr>";
		 */
		orderSummary = orderSummary + "<tr><td colspan='2' class='tar f18 fc-red'>" + ordervo.getAmount()
				+ " <span class='f12 fc66'>원</span></td></tr>";
		orderSummary = orderSummary + "</tbody></table>";
		ordervo.setOrderSummary(orderSummary);

		String setOrder = reqCatalogueService.setOrder(ordervo);
		reqCatalogueService.setOrderProduct(ordervo);
		reqCatalogueService.setOrderProductLb(ordervo);

		// 승인 스텝 입력
		List<CustomReqCustomerVO> getApprovalModelSteplist = reqCatalogueService.getApprovalModelSteplist2();
		for (int i = 0; i < getApprovalModelSteplist.size(); i++) {
			CustomReqCustomerVO appmodelstep = new CustomReqCustomerVO();
			appmodelstep.setRequestSeq(orderNo);
			appmodelstep.setStepId(getApprovalModelSteplist.get(i).getStepId());
			if (!appmodelstep.getStepId().equals("")) {

			}
			appmodelstep.setModelId(getApprovalModelSteplist.get(i).getModelId());
			appmodelstep.setStepName(getApprovalModelSteplist.get(i).getStepName());
			appmodelstep.setStepLevel(getApprovalModelSteplist.get(i).getStepLevel());
			appmodelstep.setLeftStepId(getApprovalModelSteplist.get(i).getLeftStepId());
			appmodelstep.setRightStepId(getApprovalModelSteplist.get(i).getRightStepId());
			if (appmodelstep.getStepLevel().equals("1")) {
				appmodelstep.setApprvState("APPRV_PROCESSING");
			} else {
				appmodelstep.setApprvState("APPRV_WAITING");
			}
			reqCatalogueService.setSrApprovalStepinsert2(appmodelstep);
		}
		// ordervo.getProjectId();
		CustomReqCatalogueVO getProjectId = reqCatalogueService.getProjectId(ordervo.getProjectId());
		List<CustomReqCustomerVO> getApprovalModelMemberlist = reqCatalogueService.getApprovalModelMemberlist2();
		for (int i = 0; i < getApprovalModelMemberlist.size(); i++) {
			CustomReqCustomerVO appmember = new CustomReqCustomerVO();
			appmember.setRequestSeq(orderNo);
			appmember.setStepId(getApprovalModelMemberlist.get(i).getStepId());
			appmember.setUserId(getApprovalModelMemberlist.get(i).getUserId());
			appmember.setApprvAuthFlag(getApprovalModelMemberlist.get(i).getApprvAuthFlag());
			appmember.setMailRecvFlag(getApprovalModelMemberlist.get(i).getMailRecvFlag());
			appmember.setSmsRecvFlag(getApprovalModelMemberlist.get(i).getSmsRecvFlag());
			appmember.setPushRecvFlag(getApprovalModelMemberlist.get(i).getPushRecvFlag());
			/*
			 * if(appmember.getUserId().equals("RESERVED_PM")){
			 * appmember.setUserId(getProjectId.getProjectManagerId()); }else{
			 * appmember.setUserId(getProjectId.getCustomerId()); }
			 */
			reqCatalogueService.setSrApprovalMemberinsert2(appmember);

		}

		String res = setOrder;
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	// 장바구니 갯수 검색
	@RequestMapping(value = "/getBasketCnt")
	public ResponseEntity<Object> getBasketCnt(HttpServletRequest request) {

		int res = reqCatalogueService.getBasketCnt(request.getUserPrincipal().getName());
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	@RequestMapping(value = "/productNameChk")
	public ResponseEntity<Object> productNameChk(CustomReqProductVO req) {

		int chkVal = reqProductService.getProductNameChk(req);

		return new ResponseEntity<Object>(chkVal, HttpStatus.OK);
	}

	@RequestMapping(value = "/osList", method = RequestMethod.GET)
	public ResponseEntity<Object> osList(CustomReqCatalogueVO req) throws Exception {


		List<CustomReqCatalogueVO> getCatalogueOslist = new ArrayList<>();

		Date nowdate = new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		String applyDate = dateFormat.format(nowdate);
		req.setApplyDate(applyDate);
		CustomReqCatalogueVO getCatalogueSelectView = reqCatalogueService.getCatalogueSelectView(req);
		req.setVmImageType(getCatalogueSelectView.getVmImageType());

		log.debug(" os List >> {}", req.getVmImageType(), " vmImageType : {}", getCatalogueSelectView.getVmImageType());
		if (req.getCloudType().equals("openshift")) {
			getCatalogueOslist = reqCatalogueService.getCatalogueAppVersionList(req);
		}else {
			getCatalogueOslist = reqCatalogueService.getCatalogueOslist(req);
		}



		return new ResponseEntity<Object>(getCatalogueOslist, HttpStatus.OK);
	}

	@RequestMapping(value = "/osListMngReq", method = RequestMethod.GET)
	public ResponseEntity<Object> osListMngReq(CustomReqCatalogueVO req) throws Exception {

		List<CustomReqCatalogueVO> getCatalogueOslist = new ArrayList();

			Date nowdate = new Date();
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			String applyDate = dateFormat.format(nowdate);
			req.setApplyDate(applyDate);

			req.setVmImageType(req.getVmImageType());

			getCatalogueOslist = reqCatalogueService.getCatalogueOslist(req);

		return new ResponseEntity<Object>(getCatalogueOslist, HttpStatus.OK);
	}

	@RequestMapping(value = "/getFlavorTypeList", method = RequestMethod.GET)
	public ResponseEntity<Object> getFlavorTypeList(CustomReqCatalogueVO req) {
		List<OssFlavorVO> getFlavorTypeList = reqCatalogueService.getFlavorTypeList(req);

		return new ResponseEntity<Object>(getFlavorTypeList, HttpStatus.OK);
	}

	@RequestMapping(value = "/getCatalogueFlavorList", method = RequestMethod.GET)
	public ResponseEntity<Object> getCatalogueFlavorList(CustomReqCatalogueVO req) {
		List<OssFlavorVO> getCatalogueFlavorList = reqCatalogueService.getCatalogueFlavorList(req);

		return new ResponseEntity<Object>(getCatalogueFlavorList, HttpStatus.OK);
	}

	@RequestMapping(value = "/getDataStore", method = RequestMethod.GET)
	public ResponseEntity<Object> getDataStore(CustomReqCatalogueVO req) {

		String cloudId = req.getCloudId();
		List<CustomReqDataStoreVO> dataStore = reqCatalogueService.getDataStoreList(cloudId);

		return new ResponseEntity<Object>(dataStore, HttpStatus.OK);
	}

	@RequestMapping(value = "/getDiskType", method = RequestMethod.POST)
	public ResponseEntity<Object> getDiskType(CustomReqCatalogueVO req) {
		List<CustomCmmCodeVO> cateList = cmmCodeService.getBlockDisk(req);
		return new ResponseEntity<Object>(cateList, HttpStatus.OK);
	}

	@RequestMapping(value = "/catalogueOrderDirect", params = "type=noworderinsert")
	public ResponseEntity<Object> catalogueOrderDirect(HttpServletRequest request, Model model,
			CustomReqOrderVO ordervo) {
		ordervo.setOrderUserId(request.getUserPrincipal().getName());
		model.addAttribute("ordervo", ordervo);

		// 결재라인 정보 JSON -> List Map 형식으로 변환하여 넣기
		String tmpApprovalStepList = request.getParameter("approvalStepListString");
//		JSONArray jsonArray = new JSONArray(tmpApprovalStepList);
//		List list = new ArrayList<>();
//		for (int i = 0; i < jsonArray.length(); i++) {
//			jsonArray.getJSONObject(i);
//			list.add(JsonUtil.toMap(jsonArray.getJSONObject(i)));
//		}

		ordervo.setApprovalStepList(tmpApprovalStepList);

		// 1차 승인 예정자
		String hiddenUserIdReview = request.getParameter("hiddenUserIdReview");
		// 2차 승인 예정자
		String hiddenUserIdApprove = request.getParameter("hiddenUserIdApprove");

		String orderProductSeq = DateFormatUtils.format(new Date(), "yyyyMMddHHmmss");
		String orderNo = orderProductSeq;

		ordervo.setOrderProductSeq(orderProductSeq);
		ordervo.setOrderNo(orderNo);

		ordervo.setRequestType("REQTYPE_NEW");

		String orderSummary = "";
		orderSummary = "<hr />";
		orderSummary = orderSummary + "<table><colgroup><col width='30%'><col width='70%'></colgroup><tbody>";
		// orderSummary = orderSummary +"<tr><td
		// class='left'>서비스시작일시</td><td>"+ordervo.getApplyDatetime()+"</td></tr>";\
		orderSummary = orderSummary + "<tr><td class='left'>신청자원</td><td>가상서버</td></tr>";
		orderSummary = orderSummary + "<tr><td class='left'>프로젝트</td><td>" + ordervo.getProjectName() + " </td></tr>";
		orderSummary = orderSummary + "<tr><td class='left'>네트워크</td><td>" + ordervo.getAzName() + " </td></tr>";
		orderSummary = orderSummary + "<tr><td class='left'>서버명</td><td>" + ordervo.getHostnameAlias() + "</td></tr>";
		// orderSummary = orderSummary +"<tr><td class='left'>HOST
		// ALIAS</td><td>"+ordervo.getHostnameAlias()+"</td></tr>";
		orderSummary = orderSummary + "<tr><td class='left'>CPU</td><td>" + ordervo.getCpucnt() + " vCPU</td></tr>";
		orderSummary = orderSummary + "<tr><td class='left'>MEM</td><td>" + ordervo.getMemcnt() + " GB</td></tr>";
		orderSummary = orderSummary + "<tr><td class='left'>DISK</td><td>" + ordervo.getDiskcnt() + " GB </td></tr>";
		if (ordervo.getDescription() != null) {
			orderSummary = orderSummary + "<tr><td class='left'>기타사항</td><td>" + ordervo.getDescription()
					+ " </td></tr>";
		}
		// orderSummary = orderSummary +"<tr><td
		// class='left'>아이디</td><td>appuser</td></tr>";
		// orderSummary = orderSummary +"<tr><td
		// class='left'>패스워드</td><td>kepco123/456</td></tr>";
		// orderSummary = orderSummary +"<tr><td colspan='2' class='tar f18
		// fc-red'>"+ordervo.getAmount()+" <span class='f12 fc66'>원</span></td></tr>";
		orderSummary = orderSummary + "</tbody></table>";
		ordervo.setOrderSummary(orderSummary);

		// 일괄신청과 단독신청간 컬럼명 차이로 데이터가 들어가고 안들어가고 달라지는 부분이 있어 처리 2020.06.26 장중일
		ordervo.setDefaultNetworkId(ordervo.getNetworkId());
		ordervo.setDefaultNetworkName(ordervo.getNetworkAlias());
		ordervo.setVcpus(ordervo.getCpucnt());
		ordervo.setMemGb(ordervo.getMemcnt());
		ordervo.setDiskGb(ordervo.getDiskcnt());
		ordervo.setVmProductSeq(ordervo.getProductSeq());
		ordervo.setDefaultNetworkIp(ordervo.getDefaultNetworkIp());

		String projectId = reqCatalogueService.detailProjectId(ordervo);
		ordervo.setProjectId(projectId);

		String setOrder = reqCatalogueService.setOrderDirect(ordervo);

		reqCatalogueService.setOrderProduct(ordervo);
		reqCatalogueService.setOrderDirectProductVm(ordervo);

//			String network = ordervo.getNetworkChk();
//			String[] networks = network.split(",");

		// 2020.05.25(장중일) - 신규 결재라인 등록 부분
		// 지정된 결재자 정보
		List<Map<String, Object>> stepList = ordervo.getApprovalStepList();
		// 결재라인 정보
		List<CustomReqCustomerVO> getApprovalModelSteplist = reqCatalogueService.getApprovalModelSteplist2();

		int tmpStep = 0;
		boolean tmpStartFlag = false;
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
			if (tmpStep < 9) {
				paramStepInfo.setApprvUserId(userSession.getUsername());
				paramStepInfo.setApprvUserName(userSession.getNickname());
				paramStepInfo.setApprvScheduleUserId(userSession.getUsername());
				paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_COMPLETED);
			}
			tmpStep++;
			reqCatalogueService.setSrApprovalStepinsert2(paramStepInfo);
		}

		String res = setOrder;

		List<CustomReqProductVO> getReqlistvo = reqProductService.detailBbsOrder(orderNo);
		for (CustomReqProductVO vo : getReqlistvo) {
			reqProductService.actProduct(vo);
		}

		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	@RequestMapping(value = "/catalogueLoadBalancer", params = "type=noworder")
	public ResponseEntity<Object> catalogueLoadBalancer(HttpServletRequest request, Model model,
			CustomReqOrderVO ordervo) {
		String res = "1";
		ordervo.setOrderUserId(request.getUserPrincipal().getName());
		model.addAttribute("ordervo", ordervo);

		String orderProductSeq = DateFormatUtils.format(new Date(), "yyyyMMddHHmmss");
		String orderNo = orderProductSeq;

		ordervo.setRequestType("REQTYPE_NEW");
		ordervo.setOrderProductSeq(orderProductSeq);
		ordervo.setOrderNo(orderNo);
		ordervo.setProductCategory("ITEMCATE_LOADBALANCER");
		ordervo.setHourlyFlag("N");
		ordervo.setProjectId(ordervo.getProjectBoxId());
		String applyDatetime = "";

		if (ordervo.getOnDemandFlag().equals("N")) {
			applyDatetime = ordervo.getApplyDatetime();
		}

		String tmpApprovalStepList = request.getParameter("approvalStepListString");

//		JSONArray jsonArray = new JSONArray(tmpApprovalStepList);
//		List list = new ArrayList<>();
//
//		for (int i = 0; i < jsonArray.length(); i++) {
//			jsonArray.getJSONObject(i);
//			list.add(JsonUtil.toMap(jsonArray.getJSONObject(i)));
//		}

		ordervo.setApprovalStepList(tmpApprovalStepList);

		String orderSummary = "";
		orderSummary = "<hr />";
		orderSummary = orderSummary + "<table><colgroup><col width='30%'><col width='70%'></colgroup><tbody>";
		// orderSummary = orderSummary +"<tr><td
		// class='left'>서비스시작일시</td><td>"+applyDatetime+"</td></tr>";
		orderSummary = orderSummary + "<tr><td class='left'>신청자원</td><td>로드밸런스</td></tr>";
		orderSummary = orderSummary + "<tr><td class='left'>프로젝트</td><td>" + ordervo.getProjectName() + " </td></tr>";
		orderSummary = orderSummary + "<tr><td class='left'>로드밸런스명</td><td>" + ordervo.getLoadbalancerName() + " </td></tr>";
		orderSummary = orderSummary + "<tr><td class='left'>IP</td><td>" + ordervo.getIp() + " </td></tr>";
		orderSummary = orderSummary + "<tr><td class='left'>포트</td><td>" + ordervo.getPort() + " </td></tr>";
		orderSummary = orderSummary + "<tr><td class='left'>네트워크</td><td>" + ordervo.getNetworkAlias() + " </td></tr>";
		orderSummary = orderSummary + "<tr><td class='left'>Method</td><td>" + ordervo.getMethod() + " </td></tr>";
		orderSummary = orderSummary + "<tr><td class='left'>protocol</td><td>" + ordervo.getProtocol() + " </td></tr>";
		if (ordervo.getDescription() != null) {
			orderSummary = orderSummary + "<tr><td class='left'>요청사항</td><td>" + ordervo.getDescription()
					+ " </td></tr>";
		}

		orderSummary = orderSummary + "</tbody></table>";
		ordervo.setOrderSummary(orderSummary);

		String setOrder = reqCatalogueService.setOrder(ordervo);
		reqCatalogueService.setOrderProduct(ordervo);

		reqCatalogueService.setOrderProductLb(ordervo);
		String[] arrayParam = request.getParameterValues("vmUuid");
		for (int i = 0; i < arrayParam.length; i++) {
			ordervo.setVmUuid(arrayParam[i]);
			reqCatalogueService.setOrderProductLbVm(ordervo);
		}

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
			keywordMap.put("[[URL]]","http://k-cloud.kepco.co.kr/mbr/req/catalogue/bssOrderApproveView?orderNo=" + ordervo.getOrderNo());
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
			alarmkepcoMap.put("url","http://k-cloud.kepco.co.kr/mbr/req/catalogue/bssOrderApproveView?orderNo=" + orderNo);
			alarmsTemplateService.alarmsKepco(alarmkepcoMap);
		}

		res = setOrder;

		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	@RequestMapping(value = "/catalogueSnapshot", params = "type=noworder")
	public ResponseEntity<Object> catalogueSnapshot(HttpServletRequest request, Model model, CustomReqOrderVO ordervo) {
		String res = "1";
		ordervo.setOrderUserId(request.getUserPrincipal().getName());
		model.addAttribute("ordervo", ordervo);

		String orderProductSeq = DateFormatUtils.format(new Date(), "yyyyMMddHHmmss");
		String orderNo = orderProductSeq;

		ordervo.setOrderProductSeq(orderProductSeq);
		ordervo.setOrderNo(orderNo);
		ordervo.setProductCategory("ITEMCATE_SNAPSHOT");
		ordervo.setHourlyFlag("N");
		ordervo.setProjectId(ordervo.getProjectBoxId());
		String applyDatetime = "";

		if (ordervo.getOnDemandFlag().equals("N")) {
			applyDatetime = ordervo.getApplyDatetime();
		}

		String tmpApprovalStepList = request.getParameter("approvalStepListString");

//		JSONArray jsonArray = new JSONArray(tmpApprovalStepList);
//		List list = new ArrayList<>();
//
//		for (int i = 0; i < jsonArray.length(); i++) {
//			jsonArray.getJSONObject(i);
//			list.add(JsonUtil.toMap(jsonArray.getJSONObject(i)));
//		}

		ordervo.setApprovalStepList(tmpApprovalStepList);

		String orderSummary = "";
		orderSummary = "<hr />";
		orderSummary = orderSummary + "<table><colgroup><col width='30%'><col width='70%'></colgroup><tbody>";
		// orderSummary = orderSummary +"<tr><td
		// class='left'>서비스시작일시</td><td>"+applyDatetime+"</td></tr>";
		orderSummary = orderSummary + "<tr><td class='left'>신청자원</td><td>스냅샷";
		if(ordervo.getRequestType().equals("REQTYPE_NEW")) {
			orderSummary = orderSummary + " 생성";
			orderSummary = orderSummary + "<tr><td class='left'>스냅샷명</td><td>" + ordervo.getSnapshotName() + " </td></tr>";
			orderSummary = orderSummary + "<tr><td class='left'>요청디스크</td><td>" + ordervo.getDiskAlias() + " </td></tr>";
		} else if(ordervo.getRequestType().equals("REQTYPE_EXPR")) {
			orderSummary = orderSummary + " 삭제";
		} else if(ordervo.getRequestType().equals("REQTYPE_CHANGE")) {
			orderSummary = orderSummary + " 적용";
		}
		orderSummary = orderSummary + "</td></tr>";



		String setOrder = reqCatalogueService.setOrder(ordervo);
		if (!ordervo.getRequestType().equals("REQTYPE_NEW")) {
			CustomReqOrderVO snapshotInfo = reqCatalogueService.getSnapshotInfo(ordervo);
			ordervo.setSnapshotId(snapshotInfo.getSnapshotId());
			ordervo.setProjectId(snapshotInfo.getProjectId());
			ordervo.setSnapshotName(snapshotInfo.getSnapshotName());
			ordervo.setCatalogSeq(snapshotInfo.getSnapshotCatalogSeq());
			ordervo.setSnapshotProductSeq(snapshotInfo.getSnapshotProductSeq());
			orderSummary = orderSummary + "<tr><td class='left'>스냅샷명</td><td>" + snapshotInfo.getSnapshotName() + " </td></tr>";
			orderSummary = orderSummary + "<tr><td class='left'>요청디스크</td><td>" + snapshotInfo.getDiskAlias() + " </td></tr>";
		}
		if (ordervo.getDescription() != null) {
			orderSummary = orderSummary + "<tr><td class='left'>설명</td><td>" + ordervo.getDescription()
					+ " </td></tr>";
		}

		orderSummary = orderSummary + "</tbody></table>";
		ordervo.setOrderSummary(orderSummary);
		reqCatalogueService.setOrderProduct(ordervo);

		reqCatalogueService.setOrderProductSn(ordervo);

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

		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	@RequestMapping(value = "/delete")
	public ResponseEntity<String> MbrBssScaleOutDelete(CustomScaleOutVO req, Model model) {
		String res = "";

//		UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo(req.getCloudId());
		OpsApiOptionVO opsApiOptionVO = new OpsApiOptionVO();

		opsApiOptionVO.setNameSpace(req.getNameSpace());
		opsApiOptionVO.setAppName(req.getAppName());
		opsApiOptionVO.setScaleOutName(req.getScaleOutName());

		Boolean response = opsApiOptionService.deletePodAutoscalerV2(cloudVo, opsApiOptionVO);

		if(response != true) {
			// 삭제 실패
			res = "0";
			return new ResponseEntity<String>(res, HttpStatus.OK);
		}
		res = service.delete(req);

		return new ResponseEntity<String>(res, HttpStatus.OK);
	}

	// 오토스케일 개수.
	@RequestMapping(value = "/getAutoScaleOutCnt")
	public ResponseEntity<Object> getAutoScaleOutCnt(@RequestParam String appUid) {

		int res = reqCatalogueService.getAutoScaleOutCnt(appUid);
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	// 어플리케이션 개수.
	@RequestMapping(value = "/getAppCnt")
	public ResponseEntity<Object> getAppCnt(@RequestParam String projectBoxId) {

		int res = reqCatalogueService.getAppCnt(projectBoxId);
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	@RequestMapping(value = "/pathChk")
	public ResponseEntity<Object> pathChk(@RequestParam String nasFileSystemPath) {

		int res = reqCatalogueService.pathChk(nasFileSystemPath);
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	@RequestMapping(value = "/bssEnvUserList", method = { RequestMethod.GET, RequestMethod.POST })
	public ResponseEntity<Object> bssEnvUserList(CustomReqProductVO req) {

		String orderProductSeq = req.getOrderProductSeq();
		List<CustomReqProductVO> res = reqProductService.bssEnvUserList(orderProductSeq);

		for(CustomReqProductVO vo : res) {
			String decUserEmail = vo.getEnvUserEmailDec();
			vo.setEnvUserEmail(decUserEmail);
		}

		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}


}
