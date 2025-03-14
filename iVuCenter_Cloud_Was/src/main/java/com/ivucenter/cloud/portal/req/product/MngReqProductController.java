package com.ivucenter.cloud.portal.req.product;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.time.DateFormatUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.ivucenter.cloud.api.AbstractFactory;
import com.ivucenter.cloud.api.openshift.object.OpsApiOptionService;
import com.ivucenter.cloud.api.openstack.OpenStackUsage;
import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.api.openstack.interfaces.FlavorIF;
import com.ivucenter.cloud.api.openstack.interfaces.ProjectIF;
import com.ivucenter.cloud.api.openstack.interfaces.ServerIF;
import com.ivucenter.cloud.api.openstack.interfaces.ServerQuotaIF;
import com.ivucenter.cloud.api.openstack.interfaces.VolumeIF;
import com.ivucenter.cloud.api.openstack.object.Flavor;
import com.ivucenter.cloud.api.openstack.object.Project;
import com.ivucenter.cloud.api.openstack.object.QuotaSet;
import com.ivucenter.cloud.api.openstack.object.Server;
import com.ivucenter.cloud.api.openstack.object.Volume;
import com.ivucenter.cloud.api.vRealize.interfaces.vraAbstractFactory;
import com.ivucenter.cloud.api.vRealize.interfaces.vraProjectIF;
import com.ivucenter.cloud.api.vRealize.interfaces.vraServerIF;
import com.ivucenter.cloud.api.vRealize.object.vraContent;
import com.ivucenter.cloud.api.vRealize.object.vraDisks;
import com.ivucenter.cloud.api.vRealize.object.vraProjectObject;
import com.ivucenter.cloud.api.vRealize.object.vraServer;
import com.ivucenter.cloud.portal.alarms.template.AlarmsTemplateService;
import com.ivucenter.cloud.portal.approval.ApprovalService;
import com.ivucenter.cloud.portal.approval.CustomApprovalVO;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;
import com.ivucenter.cloud.portal.cmm.cloud.OssCloudService;
import com.ivucenter.cloud.portal.cmm.file.CmmFileService;
import com.ivucenter.cloud.portal.cmm.file.CustomCmmFileVO;
import com.ivucenter.cloud.portal.cmm.user.CmmUserService;
import com.ivucenter.cloud.portal.cmm.user.CustomCmmUserVO;
import com.ivucenter.cloud.portal.login.UserSession;
import com.ivucenter.cloud.portal.mng.req.work.CustomMngReqWorkVO;
import com.ivucenter.cloud.portal.mng.req.work.MngReqWorkService;
import com.ivucenter.cloud.portal.oss.project.CustomOssProjectVO;
import com.ivucenter.cloud.portal.oss.project.OssProjectService;
import com.ivucenter.cloud.portal.oss.zone.OssZoneNetworkDiskService;
import com.ivucenter.cloud.portal.oss.zone.OssZoneNetworkDiskVO;
import com.ivucenter.cloud.portal.req.catalogue.CustomReqCatalogueVO;
import com.ivucenter.cloud.portal.req.catalogue.CustomReqOrderVO;
import com.ivucenter.cloud.portal.req.catalogue.ReqCatalogueService;
import com.ivucenter.cloud.portal.req.customer.CustomReqCustomerVO;
import com.ivucenter.cloud.portal.req.customer.ReqCustomerService;
import com.ivucenter.cloud.portal.req.project.CustomReqProjectVO;
import com.ivucenter.cloud.portal.req.project.ReqProjectService;
import com.ivucenter.cloud.portal.util.CodeUtil;

import io.fabric8.openshift.api.model.Parameter;
import io.fabric8.openshift.api.model.Template;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value = "/mng/req/product")
public class MngReqProductController {

    private static final Logger logger = LoggerFactory.getLogger(MngReqProductController.class);

	private static final String Loop = null;

	@Autowired
	private ReqProjectService reqProjectService;

	@Autowired
	private ReqProductService reqProductService;

	@Autowired
	private ReqCustomerService customerService;

	@Autowired
	private ReqCatalogueService reqCatalogueService;

	@Autowired
	private MngReqWorkService mngReqWorkService;

	@Autowired
	private AlarmsTemplateService alarmsTemplateService;

	@Autowired
	private ApprovalService approvalService;

	@Autowired
	private CmmUserService cmmUserService;

	@Autowired
	private OssCloudService ossCloudService;

	@Autowired
	private CmmFileService cmmFileService;

	@Autowired
	private OssZoneNetworkDiskService ossZoneNetworkDiskservice;

	@Autowired
	private OssProjectService ossProjectService;

	@Autowired
	private OpsApiOptionService opsApiOptionService;

//	@Autowired	private CmmCodeService cmmCodeService;
//	@Autowired	private OssCloudService ossCloudservice;


	@RequestMapping(value = {"/",""})
	public String mngBbsFaqList(HttpServletRequest request , Model model) {
		String myWorkYn =  request.getParameter("myWorkYn");
		model.addAttribute("myWorkYn", myWorkYn);
		return "mng/req/product/productList";
	}


	/**
	 * 상품신청 리스트
	 */
	@RequestMapping(value = "/list", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> MngReqProductControllerList(CustomReqProductVO req) {
		UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		req.setUserId(userSession.getUsername());
        req.setRoleYn(userSession.hasRole("ROLE_CLOUD_ADMIN"));

        String apprvCodeKeyId = "APPRV_STATE";
		String requestCodeKeyId = "REQUEST_TYPE";

		req.setApprvCodeKeyId(apprvCodeKeyId);
		req.setRequestCodeKeyId(requestCodeKeyId);
		String res = reqProductService.list(req);

		if (res.equals("")) {
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	@RequestMapping(value = "/excel")
	public ModelAndView MngReqProductControllerExcel(CustomReqProductVO req, ModelMap map) {
		String apprvCodeKeyId = "APPRV_STATE";
		String requestCodeKeyId = "REQUEST_TYPE";
		req.setApprvCodeKeyId(apprvCodeKeyId);
		req.setRequestCodeKeyId(requestCodeKeyId);

		map.addAttribute("excel_gbn", "productApprv");
		map.addAttribute("excel_title", "작업승인처리_상품 신청 관리");
		map.addAttribute("excel_list", reqProductService.excel(req));

		return new ModelAndView("productExcelView", map);
	}

	/**
	 * 상품신청 상세 화면
	 */
	@RequestMapping(value = "/view")
	public String mngReqProjectView(Model model, CustomReqProductVO req, Principal principal) {
		//log.info("mngDetails.getCompanyId() : " + req.getCompanyId());

		UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		model.addAttribute("apprvPass", userSession.getApprvPass());
		//model.addAttribute("userName", userSession.getUsername());
		CustomCmmUserVO cmmUserInfo = new CustomCmmUserVO();
		cmmUserInfo.setUserId(principal.getName());
		cmmUserInfo = cmmUserService.userInfoDetail(cmmUserInfo);
		model.addAttribute("userLevelCode", cmmUserInfo.getUserLevelCode());

		// 프로젝트 ID값
		String projectId = null;

		String orderNo = req.getOrderNo();
		model.addAttribute("orderNo", orderNo);

		// 승인스텝멤버 불러오기
		Map<String,String> map = new HashMap<>();
		map.put("userId", principal.getName());
		map.put("orderNo", orderNo);
		String stepId = reqProductService.getStepId(map);
		map.put("stepId", stepId);
		model.addAttribute("stepId", stepId);

		String userApprvState ="";
		userApprvState = reqProductService.getUserApprvState(map);
		model.addAttribute("userApprvState", userApprvState);

		List<CustomReqProductVO> approvalList = reqProductService.approvalList2(map);
		model.addAttribute("getProductAppSteplist", approvalList);

		for (int i = 0; i < approvalList.size(); i++) {
			if(approvalList.get(i).getApprvState().equals("APPRV_REJECTED")){
				String inject ="Y";
				model.addAttribute("inject",inject);
			}
		}

		// 승인스텝멤버 유저 아이디 조회
//		String flowId = "AFW0040";
//		List<CustomReqProductVO> approvalUserId = reqProductService.approvalUserId(orderNo);
//		model.addAttribute("approvalUserId", approvalUserId);

		// 코드정보 조회
//		List<CustomCmmCodeVO> getCodeList = cmmCodeService.getCmmCode("APPRV_STATE");
//		model.addAttribute("code", getCodeList);

		//주문자명 아이디 가져오기 (상품신청 승인 및 취소시) 2017.08.24
		CustomReqProductVO getOrderUserId = reqProductService.getOrderVo(orderNo);
		model.addAttribute("getOrderUserId", getOrderUserId);

		// 가상서버 주문내역 가져오기
		List<CustomReqProductVO> getReqlistvo = reqProductService.getReqVMOrderList(orderNo);
		model.addAttribute("getReqlistvo", getReqlistvo);

		JsonObject vmJsonResponse = new JsonObject();
		Gson vmGson = new Gson();

		vmJsonResponse.add("data", vmGson.toJsonTree(getReqlistvo));
		model.addAttribute("reqVmJsonList", vmJsonResponse.toString());

		// 서버대역
		OssZoneNetworkDiskVO ossZoneNetworkDiskVO = new OssZoneNetworkDiskVO();
		if (getReqlistvo.size() != 0) {
			ossZoneNetworkDiskVO.setProjectBoxId(getReqlistvo.get(0).getProjectBoxId());
		}
		List<OssZoneNetworkDiskVO> res = ossZoneNetworkDiskservice.list(ossZoneNetworkDiskVO);
		model.addAttribute("getNetwork", res);

		// 가상서버 주문내역에서 projectID 추출하기
		if(getReqlistvo.size() != 0) { projectId = getReqlistvo.get(0).getProjectId(); }


		//List<CustomReqProductVO> detail = reqProductService.detail(orderNo);
		//model.addAttribute("detail", detail);
		//CustomReqProductVO detail1 = reqProductService.detail1(orderNo);
		//model.addAttribute("detail1", detail1);

		//String apprvCodeKeyId = "APPRV_STATE";
		//String requestCodeKeyId = "REQUEST_TYPE";
		//req.setApprvCodeKeyId(apprvCodeKeyId);
		//req.setRequestCodeKeyId(requestCodeKeyId);

		// 장바구니 블록디스크 리스트 가져오기
		List<CustomReqProductVO> getReqDisklistvo = reqProductService.getReqDiskOrderList(orderNo);
		model.addAttribute("getBasketDisklistvo", getReqDisklistvo);
		if(getReqDisklistvo.size() != 0) { projectId = getReqDisklistvo.get(0).getProjectId();}

		// 장바구니 서비스 리스트 가져오기
		List<CustomReqProductVO> getReqServicelistvo = reqProductService.getReqServiceOrderList(orderNo);
		// 통합 Service 테이블에서 타입으로 서비스 구분하기
		for (int i = 0; i < getReqServicelistvo.size(); i++) {
			String vmUserPassword = getReqServicelistvo.get(i).getBastionVmUserPasswordDec();
			if(vmUserPassword != null && vmUserPassword != ""){
				getReqServicelistvo.get(i).setBastionVmUserPassword(vmUserPassword);
			} else {
				getReqServicelistvo.get(i).setBastionVmUserPassword(null);
			}
		}
		model.addAttribute("getReqServicelistvo", getReqServicelistvo);
		if(getReqServicelistvo.size() != 0) { projectId = getReqServicelistvo.get(0).getProjectId();}

		//application 주문정보
		CustomReqOrderVO CustomReqOrderVO = new CustomReqOrderVO();
		CustomReqOrderVO.setOrderNo(orderNo);
		List<CustomReqOrderVO> orderAppviewList = reqCatalogueService.orderAppviewList_sub(CustomReqOrderVO);
		model.addAttribute("orderAppviewList", orderAppviewList);

		// 자원요청 승인 컨테이너 상세 입력
		List<Object> paramList = new ArrayList<Object>();
		List<Object> orderAppJson = new ArrayList<Object>();
		List<Object> orderEnvJson = new ArrayList<Object>();

		if(orderAppviewList.size() != 0) {

			for (CustomReqOrderVO customReqOrder : orderAppviewList) {
//			System.out.println(customReqOrder.getCloudId());
				// Template API 호출
				log.info("customReqOrder.getTemplateName() : {}", customReqOrder.getTemplateName());
				log.info("customReqOrder.getTemplateNameSpace(): {}", customReqOrder.getTemplateNameSpace());
				CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo(customReqOrder.getCloudId());
				Template template = new Template();

//				if(!customReqOrder.getTemplateName().isEmpty() && customReqOrder.getTemplateName() != null) {
//					template = opsApiOptionService.getTemplate(cloudVo, customReqOrder.getTemplateName(),
//							customReqOrder.getTemplateNameSpace());
//					paramList.add(template.getParameters());
//				}

				// Message Queue Param XML, PROPERTIES 제외
				for (Parameter param : template.getParameters()) {

					switch(param.getName()) {
					case "SOURCE_REPOSITORY_URL":
						param.setValue(customReqOrder.getGitRepository());
						break;
					case "NUMBER_OF_INSTANCES":
						param.setValue(String.valueOf(customReqOrder.getPodCnt()));
						break;

					case "CPU_LIMIT":
						param.setValue(String.valueOf(customReqOrder.getCpuLimit()));
						break;

					case "MEMORY_LIMIT":
						param.setValue(String.valueOf(customReqOrder.getMemLimit()));
						break;

					default:
						if(param.getName().contains("XML") || param.getName().contains("PROPERTIES")){
							if(param.getValue().length() != 0) {
								param.setValue("Y");
							}
						}
						break;
					}
				}
				orderAppJson.add(customReqOrder);
			}
		}

		// 어플리케이션 주문 정보 JSON
		JsonObject appJsonResponse = new JsonObject();
		Gson appGson = new Gson();

		appJsonResponse.add("appJson", appGson.toJsonTree(orderAppJson));
		model.addAttribute("orderAppJsonList", appJsonResponse.toString());

		// 자원요청 승인 컨테이너 상세
		JsonObject jsonResponse = new JsonObject();
		Gson gson = new Gson();

		jsonResponse.add("jsonParam", gson.toJsonTree(paramList));
		model.addAttribute("parametersList", jsonResponse.toString());

		// application template 정보
		CustomReqCatalogueVO customCatalogVO = new CustomReqCatalogueVO();
		customCatalogVO.setApplyDate(DateFormatUtils.format(new Date(), "yyyy-MM-dd"));
//		customCatalogVO.setConditionCategory(Arrays.asList("CATACATE_APP")); // 기본상품(VM) Category에 해당하는것

		List<CustomReqOrderVO> orderEnvviewList = reqCatalogueService.orderEnvviewList_sub(CustomReqOrderVO);
		model.addAttribute("orderEnvviewList", orderEnvviewList);

		List<CustomReqCatalogueVO> getTemplateList = reqCatalogueService.getContainerList(customCatalogVO);
		// List<CustomReqCatalogueVO> getTemplateList =
		// reqCatalogueService.getCatalogueAppList(customCatalogVO);
		model.addAttribute("getTemplateList", getTemplateList);

		log.info("req.getCloudId : {}", req.getCloudId());
		customCatalogVO.setCloudId(req.getCloudId());
		List<CustomReqCatalogueVO> getImageTemplateList = reqCatalogueService.getCatalogueAppVersionList(customCatalogVO);
		model.addAttribute("getImageTemplateList", getImageTemplateList);

//		if( orderAppviewList.size() != 0) {
//			projectId = orderAppviewList.get(0).getProjectId();
//		}

		// 주문서 Ip 정보
		List<CustomReqOrderVO> orderIpviewList = reqCatalogueService.orderIpviewList(CustomReqOrderVO);
		model.addAttribute("orderIpviewList", orderIpviewList);

		// 장바구니 NAS 리스트 가져오기
		List<CustomReqProductVO> getReqNaslistvo = reqProductService.getReqNasOrderList(orderNo);
		model.addAttribute("getBasketNaslistvo", getReqNaslistvo);
		if(getReqNaslistvo.size() != 0) { projectId = getReqNaslistvo.get(0).getProjectId();}

		if (getReqNaslistvo.size() != 0) {
			ossZoneNetworkDiskVO.setProjectBoxId(getReqNaslistvo.get(0).getProjectBoxId());
		}
		List<OssZoneNetworkDiskVO> resNas = ossZoneNetworkDiskservice.list(ossZoneNetworkDiskVO);
		model.addAttribute("getNetworkNas", resNas);

		//작업자 확인 및 완료 값 2017.08.25 이윤준
//		for (int i = 0; i < getReqNaslistvo.size(); i++) {
//			String orderProductSeq = "";
//			orderProductSeq = getReqNaslistvo.get(i).getOrderProductSeq();
//			CustomMngReqWorkVO getReqWorkView = mngReqWorkService.getReqWorkchk(orderProductSeq);
//			if(getReqWorkView!=null){
//				getReqNaslistvo.get(i).setWorkState(getReqWorkView.getWorkState());
//			}else{
//				getReqNaslistvo.get(i).setWorkState("");
//			}
//
//		}


		// 장바구니 IP 리스트 가져오기
		List<CustomReqProductVO> getReqIplistvo = reqProductService.getReqIpOrderList(orderNo);
		//작업자 확인 및 완료 값 2017.08.25 이윤준
//		for (int i = 0; i < getReqIplistvo.size(); i++) {
//			String orderProductSeq = "";
//			orderProductSeq = getReqIplistvo.get(i).getOrderProductSeq();
//			CustomMngReqWorkVO getReqWorkView = mngReqWorkService.getReqWorkchk(orderProductSeq);
//			if(getReqWorkView!=null){
//				getReqIplistvo.get(i).setWorkState(getReqWorkView.getWorkState());
//			}else{
//				getReqIplistvo.get(i).setWorkState("");
//			}
//		}
		model.addAttribute("getBasketIplistvo", getReqIplistvo);

		// 장바구니 로드 밸런서 리스트 가져오기
		List<CustomReqProductVO> getReqLblistvo = reqProductService.getReqLbOrderList(orderNo);
		if(getReqLblistvo.size() != 0) { projectId = getReqLblistvo.get(0).getProjectId();}
		// 장바구니 스냅샷 리스트 가져오기
		List<CustomReqProductVO> getReqSnlistvo = reqProductService.getReqSnOrderList(orderNo);
		if(getReqSnlistvo.size() != 0) { projectId = getReqSnlistvo.get(0).getProjectId();}
		// 장바구니 어플리케이션 리스트 가져오기
		List<CustomReqProductVO> getReqApplistvo = reqProductService.getReqAppOrderList(orderNo);
		if(getReqApplistvo.size() != 0) { projectId = getReqApplistvo.get(0).getProjectId();}
		//작업자 확인 및 완료 값 2017.08.25 이윤준
//		for (int i = 0; i < getReqLblistvo.size(); i++) {
//			String orderProductSeq = "";
//			orderProductSeq = getReqLblistvo.get(i).getOrderProductSeq();
//			CustomMngReqWorkVO getReqWorkView = mngReqWorkService.getReqWorkchk(orderProductSeq);
//			if(getReqWorkView!=null){
//				getReqLblistvo.get(i).setWorkState(getReqWorkView.getWorkState());
//			}else{
//				getReqLblistvo.get(i).setWorkState("");
//			}
//
//		}
		model.addAttribute("getBasketLblistvo", getReqLblistvo);
		model.addAttribute("getBasketSnlistvo", getReqSnlistvo);
		model.addAttribute("getBasketApplistvo", getReqApplistvo);

		// 개발환경 신청
		List<CustomReqProductVO> getReqEnvlistvo = reqProductService.getReqEnvOrderList(orderNo);
		if(getReqEnvlistvo.size() != 0) { projectId = getReqEnvlistvo.get(0).getProjectId();}
		model.addAttribute("getReqEnvlistvo", getReqEnvlistvo);

		// 개발/운영 배포
		List<CustomReqProductVO> getReqDeploylistvo = reqProductService.getReqPrdOrderList(orderNo);
		if(getReqDeploylistvo.size() != 0) { projectId = getReqDeploylistvo.get(0).getProjectId();}
		model.addAttribute("getReqDeploylistvo", getReqDeploylistvo);

		// 프로젝트별 상세 가용용량
		List<CustomReqProductVO> getCloudAvailListVo = reqProductService.getCloudAvailList(orderNo);
		model.addAttribute("getCloudAvailListVo", getCloudAvailListVo);

		if (getCloudAvailListVo.size() > 0) {
			model.addAttribute("getCloudAvailCollDatetime", getCloudAvailListVo.get(0).getCollDatetime());
		} else {
			model.addAttribute("getCloudAvailCollDatetime", "");
		}

		// 프로젝트 상세정보
		if(projectId != null) {
			CustomReqProjectVO projectBox = reqProjectService.getProjectBoxId(projectId);
			String projectBoxId = projectBox.getProjectBoxId();
			CustomReqProjectVO projectInfo = reqProjectService.getOkProjectView(projectBoxId);
			projectInfo.setManagerTel( projectInfo.getManagerTelDec() );
			model.addAttribute("projectInfo", projectInfo);
			model.addAttribute("h_projectId", projectId);
			model.addAttribute("h_projectBoxId", projectBoxId);

			CustomCmmFileVO vo = new CustomCmmFileVO();
			vo.setProgramName(CodeUtil.FILE_PROGRAM_NAME4);
			vo.setProgramSeq(projectInfo.getProgramSeq()+"");

			model.addAttribute("file", cmmFileService.list(vo));
		}


		// 주문상품 요약가격
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
		int appAmount = 0;

		int envNew = 0;
		int envCh = 0;
		int envEx = 0;

		int deployNew = 0;
		int deployCh = 0;
		int deployEx = 0;

		int totCnt = 0;
		int totAmount = 0;

		//기본VM
		for(int i=0; i < getReqlistvo.size(); i++){
			vmAmount = vmAmount + (int) Float.parseFloat(getReqlistvo.get(i).getAmount());
			if((getReqlistvo.get(i).getRequestName()).equals("신규")){
				vmNew++;
			}else if((getReqlistvo.get(i).getRequestName()).equals("변경")){
				vmCh++;
			}else if((getReqlistvo.get(i).getRequestName()).equals("해지")){
				vmEx++;
			}
		}
		//부가
		for(int i=0; i<getReqDisklistvo.size(); i++){
			subAmount = subAmount +  (int) Float.parseFloat(getReqDisklistvo.get(i).getAmount());
			if((getReqDisklistvo.get(i).getRequestName()).equals("신규")){
				subNew++;
			}else if((getReqDisklistvo.get(i).getRequestName()).equals("변경")){
				subCh++;
			}else if((getReqDisklistvo.get(i).getRequestName()).equals("해지")){
				subEx++;
			}
		}
		//서비스
		for(int i=0; i<getReqServicelistvo.size(); i++){
			servAmount = servAmount +  (int) Float.parseFloat(getReqServicelistvo.get(i).getAmount());
			if((getReqServicelistvo.get(i).getRequestName()).equals("신규")){
				servNew++;
			}else if((getReqServicelistvo.get(i).getRequestName()).equals("변경")){
				servCh++;
			}else if((getReqServicelistvo.get(i).getRequestName()).equals("해지")){
				servEx++;
			}
		}
		//어플리케이션
		for(int i=0; i<getReqApplistvo.size(); i++){
			//servAmount = servAmount +  (int) Float.parseFloat(getReqApplistvo.get(i).getAmount());
			if((getReqApplistvo.get(i).getRequestName()).equals("신규")){
				appNew++;
			}else if((getReqApplistvo.get(i).getRequestName()).equals("변경")){
				appCh++;
			}else if((getReqApplistvo.get(i).getRequestName()).equals("해지")){
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

		totAmount = vmAmount + subAmount + servAmount;
		totCnt = vmNew + vmCh + vmEx + subNew + subCh + subEx + servNew + servCh + servEx;

		List<CustomReqProductVO> checkHostName = reqProductService.setHostNameCheck(req);
		List<CustomReqProductVO> checkIp = reqProductService.setIpCheck(req);
		List<CustomReqProductVO> checkNasIp = reqProductService.setNasIpCheck(req);
		List<CustomReqProductVO> checkBackupIp = reqProductService.setBackupIpCheck(req);

		model.addAttribute("checkBackupIp",checkBackupIp);
		model.addAttribute("checkIp",checkIp);
		model.addAttribute("checkNasIp",checkNasIp);
		model.addAttribute("checkHostName",checkHostName);
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
		model.addAttribute("appNew", servNew);
		model.addAttribute("appCh", servCh);
		model.addAttribute("appEx", servEx);
		model.addAttribute("servAmount", servAmount);
		model.addAttribute("totAmount", totAmount);
		model.addAttribute("totCnt", totCnt);

		model.addAttribute("serAppNew", appNew);
		model.addAttribute("serAppCh", appCh);
		model.addAttribute("serAppEx", appEx);

		model.addAttribute("envNew", envNew);
		model.addAttribute("envCh", envCh);
		model.addAttribute("envEx", envEx);

		return "mng/req/product/productView";
	}

	/**
	 * 상품 상세 불러오기
	 */
	@RequestMapping(value = "/detail", method = RequestMethod.POST)
	public ResponseEntity<Object> mngBbsNoticeDetail(String orderNo) {
		log.debug("detail 상제 불러오기");
		List<CustomReqProductVO> res = reqProductService.detail(orderNo);

		if (res == null) {
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}

		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	@RequestMapping(value = "/stepUpdate", method = { RequestMethod.GET, RequestMethod.POST })
	public ResponseEntity<String> mngStepUpdate(CustomReqProductVO req, Model model, Principal principal) {
		log.debug("ApprvUserId   : "+req.getApprvUserId());
		log.debug("ApprvUserName : "+req.getApprvUserName());
		log.debug("RequestSeq    : "+req.getRequestSeq());
		log.debug("RightStepId   : "+req.getRightStepId());
		log.debug("StepLevel     : "+req.getStepLevel());
		log.debug("ProjectAlias  : "+req.getProjectAlias());
		log.debug("ManagerId     : "+req.getManagerId());
		log.debug("ManagerName   : "+req.getManagerName());

		String res = "";

		// 현재 스탭 상태 변경
//		req.setModUserId(req.getRegUserId());
		req.setApprvState(CodeUtil.CMM_CODE_APPRV_COMPLETED);
		res = reqProductService.stepUpdate(req);

		String rightStepId = req.getRightStepId();
		if (rightStepId != "*") { //  최종 스탭이 아닐 경우

			CustomReqProductVO reqProductVo = reqProductService.orderUserInfo(req.getRequestSeq());
			Map<String,String> keywordMap = new HashMap<>();
			keywordMap.put("[[신청자명]]", reqProductVo.getUserName());
			keywordMap.put("[[URL]]", "http://k-cloud.kepco.co.kr/mng/req/product/view?orderNo="+req.getRequestSeq());
			keywordMap.put("[[LURL]]", "http://k-cloud.kepco.co.kr/mng/login");

			CustomApprovalVO stepUser = new CustomApprovalVO();
			stepUser.setStepLevel(req.getStepLevel());
			stepUser.setRequestSeq(req.getRequestSeq());
			CustomApprovalVO ApprovalVo = approvalService.getNextScheduleUser(stepUser);
			List<CustomApprovalVO> nextApprovalVoList = approvalService.getNextScheduleUserList(stepUser);
			for (CustomApprovalVO nextApprovVO : nextApprovalVoList) {

				alarmsTemplateService.alarms(33, nextApprovVO.getUserId(), keywordMap);
				// 한전 연계 시스템 전송
				Map<String, String> alarmkepcoMap = new HashMap<>();
				alarmkepcoMap.put("gbn", "33");
				alarmkepcoMap.put("requestSeq", req.getRequestSeq());
				alarmkepcoMap.put("regUserId", reqProductVo.getOrderUserId());	// 자원 신청자
				alarmkepcoMap.put("apprvNowUserId", ApprovalVo.getApprvUserId());		// 현재 결재자
				if(! req.getStepLevel().equals("4")) {
					alarmkepcoMap.put("apprvNextUserId", nextApprovVO.getUserId());	// 다음 결재자
				}
				alarmkepcoMap.put("url", "http://k-cloud.kepco.co.kr/mng/req/product/view?orderNo="+req.getRequestSeq());
				alarmsTemplateService.alarmsKepco(alarmkepcoMap);
			}

			// 다음 스탭 상태 변경
			req.setApprvDescription("(NULL)");
			req.setApprvState(CodeUtil.CMM_CODE_APPRV_PROCESSING);
			int stepLevel = Integer.parseInt(req.getStepLevel());
			req.setStepLevel(String.valueOf(stepLevel + 1));

			res = reqProductService.stepUpdate(req);
		}

		return new ResponseEntity<String>(res, HttpStatus.OK);
	}

	/**
	 * 가상서버 신규 마지막 승인
	 */
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public ResponseEntity<String> MngReqProductInsert(CustomReqProductVO req, Model model, Principal principal) {

		final String userId = principal.getName();

		//신청 리스트 상태 바꾸는 쿼리 - bss_order
		String res2 = reqProductService.newUpdate(req);

		String apprvState = CodeUtil.CMM_CODE_APPRV_COMPLETED;
//		String apprvDescription = req.getApprvDescription();
		String stepLevel = req.getStepLevel();
		stepLevel ="8";
		req.setApprvState(apprvState);
		req.setStepLevel(stepLevel);
		log.debug("=== apprvState ===" + apprvState);
		log.debug("=== stepLevel ===" + stepLevel);
		CustomApprovalVO stepUser = new CustomApprovalVO();
		stepUser.setStepLevel(req.getStepLevel());
		stepUser.setRequestSeq(req.getRequestSeq() );
		CustomApprovalVO ApprovalVo = approvalService.getNextScheduleUser(stepUser);
		//최종 승인자 상태 바꾸는 쿼리 - sr_approval_step

		UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		req.setApprvUserName(userSession.getNickname());
		req.setApprvUserId(userSession.getUsername());

		String res3 = reqProductService.stepUpdate(req);
		String requestSeq = req.getRequestSeq();


		// VM 대상으로만 된 쿼리문이라 변경처리함
		//List<CustomReqProductVO> getReqlistvo = reqProductService.detail(requestSeq);

		String replaceParams = "";

		// OpenStack 관련 작업 Provisioning 요청
//		List<CustomReqProductVO> getReqlistvo = reqProductService.detailBbsOrder(requestSeq);
		List<CustomReqProductVO> getReqlistvo = reqProductService.detailBssOrder(requestSeq);
		for (CustomReqProductVO vo : getReqlistvo) {

			if (vo.getProductCategory().equals(CodeUtil.CMM_CODE_PRODCATE_APP)) {
				// Data Set
				vo.setAppName(req.getAppName());
				vo.setTemplateProductSeq(req.getTemplateProductSeq());
				vo.setTemplateCatalogSeq(req.getTemplateCatalogSeq());
				vo.setGitRepository(req.getGitRepository());
				vo.setLabel(req.getLabel());
				// params Xss 적용으로 &amp; 제거
				replaceParams = req.getParams().replaceAll("&amp;", "&");
				vo.setParams(replaceParams);
				vo.setOrderProductSeq(requestSeq);
        		vo.setOsProductSeq(req.getOsProductSeq());
				vo.setImageId(req.getTemplateName());
				vo.setPodCnt(req.getPodCnt());
				vo.setCpuLimit(req.getCpuLimit());
				vo.setMemLimit(req.getMemLimit());
				reqProductService.bssOrderProductAppUpdate(vo);
			}
			reqProductService.actProduct(vo);
		}

		List<CustomReqProductVO> getReqLbOrderList =  reqProductService.getReqLbOrderList(req.getRequestSeq());
		for (int i = 0; i < getReqLbOrderList.size(); i++) {
			Date requestSeqdate = new Date();
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmssSSS");

			CustomReqProductVO reqWork = new CustomReqProductVO();
			reqWork.setReqWorkSeq(dateFormat.format(requestSeqdate));
			reqWork.setOrderProductSeq(getReqLbOrderList.get(i).getOrderProductSeq());
			reqWork.setWorkState("N");
			reqWork.setDescription(getReqLbOrderList.get(i).getDescription());
			reqWork.setRegUserId(userId);
			int reWorkResult = reqProductService.setReqWork(reqWork);
		}

		List<CustomReqProductVO> getReqSnOrderList =  reqProductService.getReqSnOrderList(req.getRequestSeq());
		for (int i = 0; i < getReqSnOrderList.size(); i++) {
			Date requestSeqdate = new Date();
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmssSSS");

			CustomReqProductVO reqWork = new CustomReqProductVO();
			reqWork.setReqWorkSeq(dateFormat.format(requestSeqdate));
			reqWork.setOrderProductSeq(getReqSnOrderList.get(i).getOrderProductSeq());
			reqWork.setWorkState("N");
			reqWork.setDescription(getReqSnOrderList.get(i).getDescription());
			reqWork.setRegUserId(userId);

			int reWorkResult = reqProductService.setReqWork(reqWork);
		}

		// 서비스 상품은 작업자 지정을 해야함.
		List<CustomReqProductVO> getReqServicelistvo = reqProductService.getReqServiceOrderList(req.getRequestSeq());
		for (int i = 0; i < getReqServicelistvo.size(); i++) {
			Date requestSeqdate = new Date();
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmssSSS");

			CustomReqProductVO reqWork = new CustomReqProductVO();
			reqWork.setReqWorkSeq(dateFormat.format(requestSeqdate));
			reqWork.setOrderProductSeq(getReqServicelistvo.get(i).getOrderProductSeq());
			reqWork.setWorkState("N");
			reqWork.setDescription(getReqServicelistvo.get(i).getDescription());
			reqWork.setRegUserId(userId);

			int reWorkResult = reqProductService.setReqWork(reqWork);
		}

		List<CustomMngReqWorkVO> worklist = mngReqWorkService.workUserId(req.getRequestSeq());
		for(CustomMngReqWorkVO vo : worklist){
			Map<String,String> keywordMap = new HashMap<>();
			keywordMap.put("[[상품명]]", vo.getProductCategoryName());
			keywordMap.put("[[URL]]", "http://k-cloud.kepco.co.kr/mng/req/product/view?orderNo="+req.getRequestSeq());
			alarmsTemplateService.alarms(35, vo.getWorkUserId(), keywordMap);
		}

		// 가상서버 주문내역 가져오기
		String orderUserName = "";
		String orderUserId = "";
		Map<String,String> keywordMap = new HashMap<>();

		StringBuffer buf = new StringBuffer();
		List<CustomReqProductVO> getReqOrderlistVo = reqProductService.getReqOrderList(req.getRequestSeq());
		for(CustomReqProductVO reqProductVo : getReqOrderlistVo) {
			orderUserName = reqProductVo.getUserName();
			orderUserId = reqProductVo.getOrderUserId();
		}
		keywordMap.put("[[신청자명]]", orderUserName);
		keywordMap.put("[[URL]]", "http://k-cloud.kepco.co.kr/mng/req/product/view?orderNo="+req.getRequestSeq());
		alarmsTemplateService.alarms(31, orderUserId, keywordMap); // 신청자에게 결재 완료 전송
		// 한전 연계 시스템 전송
		Map<String, String> alarmkepcoMap = new HashMap<>();
		alarmkepcoMap.put("gbn", "31");
		alarmkepcoMap.put("requestSeq", req.getRequestSeq());
		alarmkepcoMap.put("regUserId", req.getOrderUserId());	// 자원 신청자
		alarmkepcoMap.put("apprvNowUserId", ApprovalVo.getApprvUserId());			// 현재 결재자
		alarmkepcoMap.put("url", "http://k-cloud.kepco.co.kr/mng/req/product/view?orderNo="+req.getRequestSeq());
		alarmsTemplateService.alarmsKepco(alarmkepcoMap);

		return new ResponseEntity<String>(res2, HttpStatus.OK);
	}

	/**
	 * 상품 미승인 프로세서
	 */
	@RequestMapping(value = "/rejectedUpdate", method = { RequestMethod.GET, RequestMethod.POST })
	public ResponseEntity<String> mngRejectedUpdate(CustomReqCustomerVO req, Model model,Principal principal) {

		log.debug("=== requestSeq  ===" + req.getRequestSeq());
		log.debug("=== stepLevel ===" + req.getStepLevel());
		String apprvUserId = principal.getName();
		// 다음단계 스텝:
		// String rightStepId = req.getRightStepId();
		// log.info("=== rightStepId ==="+rightStepId);
		// 스텝 레벨
//		String stepLevel = req.getStepLevel();

		req.setModUserId(req.getRegUserId());
		req.setApprvDescription(req.getApprvDescription());
		req.setApprvState(CodeUtil.CMM_CODE_APPRV_REJECT);
		req.setStepLevel(req.getStepLevel());

		String res = "";
		res = reqProductService.rejectedUpdate(req);
		res = customerService.stepUpdate(req);

		CustomApprovalVO stepUser = new CustomApprovalVO();
		stepUser.setStepLevel(req.getStepLevel());
		stepUser.setRequestSeq(req.getRequestSeq());


		CustomApprovalVO ApprovalVo = approvalService.getNextScheduleUser(stepUser);

		// 알람 루틴
		List<CustomReqProductVO> reqProductVoList = reqProductService.getReqOrderList(req.getRequestSeq());
		for(CustomReqProductVO listVo: reqProductVoList) {

			Map<String,String> keywordMap = new HashMap<>();
			keywordMap.put("[[반려사유]]", 	req.getApprvDescription());
			keywordMap.put("[[신청자명]]",		listVo.getUserName());
			keywordMap.put("[[URL]]", "http://K-cloud.kepco.co.kr/mbr/req/catalogue/bssOrderApproveList");
			alarmsTemplateService.alarms(32, listVo.getOrderUserId(), keywordMap);
			// 한전 연계 시스템 전송
			Map<String, String> alarmkepcoMap = new HashMap<>();
			if(ApprovalVo != null) {
				alarmkepcoMap.put("apprvNextUserId", ApprovalVo.getApprvUserId());	// 현재 결재자
			}
			alarmkepcoMap.put("gbn", "32");
			alarmkepcoMap.put("requestSeq", req.getRequestSeq());
			alarmkepcoMap.put("regUserId", listVo.getOrderUserId());	// 자원 신청자
			alarmkepcoMap.put("apprvNowUserId", req.getApprvUserId());	// 현재 결재자
			alarmkepcoMap.put("url", "http://K-cloud.kepco.co.kr/mbr/req/catalogue/bssOrderApproveList");
			alarmsTemplateService.alarmsKepco(alarmkepcoMap);
		}


		// 승인완료한 스텝멤버 리스트 조회
//		CustomApprovalVO vo = new CustomApprovalVO();
//		vo.setRequestSeq(req.getRequestSeq());
//		List<CustomApprovalVO> getApprovalModelMemberlist = approvalService.getComplatedMemberList(vo);
//		for(CustomApprovalVO vo1 : getApprovalModelMemberlist){
//			alarmsTemplateService.alarms("32", vo1.getUserId(), req.getRequestSeq(), "");
//		}

		// 1차승인시 작업자에게 통지
//		CustomMngReqWorkVO workVO = new CustomMngReqWorkVO();
//		workVO.setOrderNo(req.getRequestSeq());
//		List<CustomMngReqWorkVO> workerlist = mngReqWorkService.getOrderWorkList(workVO);
//		for(int i=0;i<workerlist.size();i++){
//			alarmsTemplateService.alarms("38", workerlist.get(i).getWorkUserId(), workerlist.get(i).getProductName(), "");
//		}

		return new ResponseEntity<String>(res, HttpStatus.OK);
	}

	/**
	 * 상품 pm 지정 리스트
	 */
	@RequestMapping(value = "/productPmList", method = { RequestMethod.GET, RequestMethod.POST })
	public ResponseEntity<Object> productPmList(CustomReqProductVO req) {
		log.info("=== mngBbsNoticeInsert Controller ===");

		List<CustomReqProductVO> res = reqProductService.pmList(req);

		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}
	/**
	 * 작업자 저장하기
	 */
	@RequestMapping(value = "/updateWorkUser", method = { RequestMethod.GET, RequestMethod.POST })
	public ResponseEntity<Object> updateWorkUser(CustomReqProductVO req) {
		int res = 0;
		res = reqProductService.setUpdateWorkUser(req);
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}
	/**
	 * 작업자 저장 확인 체크 하기
	 */
	@RequestMapping(value = "/checkWorkUser", method = { RequestMethod.GET, RequestMethod.POST })
	public ResponseEntity<Object> checkWorkUser(CustomReqProductVO req) {

		Assert.notNull(req.getOrderNo(), "");

		List<CustomReqProductVO> checkWorkUser = reqProductService.checkWorkUser(req);
		int res =checkWorkUser.size();
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	/*
	 * 클라우드 가용량 조회
	 */
	@RequestMapping(value = "/cloudUsageProject", method = { RequestMethod.GET, RequestMethod.POST })
	public ResponseEntity<Object> cloudUsageProject(CustomReqProductVO req) {

		String projectBoxId= req.getProjectBoxId();
		List<CustomReqProductVO> res = reqProductService.getCloudAvail(projectBoxId);

		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}


	/*
	 * 상품 상세
	 */
	@RequestMapping(value = "/detailOrderProduct", method = { RequestMethod.GET, RequestMethod.POST })
	public ResponseEntity<Object> detailOrderProduct(CustomReqProductVO req) {
		String orderProductSeq = req.getOrderProductSeq();
		String productType = req.getProductType();

		log.debug("   productType  :"+productType);
		log.debug("orderProductSeq :"+orderProductSeq);
		CustomReqProductVO res = null;
		if (productType.equals("vm")) res = reqProductService.getReqVmOrder(orderProductSeq);
		else if (productType.equals("disk")) res = reqProductService.getReqDiskOrder(orderProductSeq);
		else if (productType.equals("nas")) res = reqProductService.getReqNasOrder(orderProductSeq);
		else if (productType.equals("ip")) res = reqProductService.getReqIpOrder(orderProductSeq);
		else if (productType.equals("lb")) res = reqProductService.getReqLbOrder(orderProductSeq);
		else if (productType.equals("service")) res = reqProductService.getReqServiceOrder(orderProductSeq);
		else if (productType.equals("application")) res = reqProductService.getReqAppOrder(orderProductSeq);
		else if (productType.equals("env")) res = reqProductService.getReqEnvOrder(orderProductSeq);
//		else if (productType.equals("bak")) res = reqProductService.getReqBakOrder(orderProductSeq);
//		else if (productType.equals("mca")) res = reqProductService.getReqMcaOrder(orderProductSeq);
//		else if (productType.equals("scm")) res = reqProductService.getReqScmOrder(orderProductSeq);
//		else if (productType.equals("scr")) res = reqProductService.getReqScrOrder(orderProductSeq);

		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	/**
	 * HOSTNAME check
	 */
	@RequestMapping(value = "/setHostNameCheck", method = { RequestMethod.GET, RequestMethod.POST })
	public ResponseEntity<Object> setHostNameCheck(CustomReqProductVO req) {

		List<CustomReqProductVO> checkWorkUser = reqProductService.setHostNameCheck(req);
		int res =checkWorkUser.size();
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	/**
	 * IP Address check
	 */
	@RequestMapping(value = "/setIpCheck", method = { RequestMethod.GET, RequestMethod.POST })
	public ResponseEntity<Object> setIpCheck(CustomReqProductVO req) {

		List<CustomReqProductVO> checkIp = reqProductService.setIpCheck(req);
		int res = checkIp.size();
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	/**
	 * NAS IP Address check
	 */
	@RequestMapping(value = "/setNasIpCheck", method = { RequestMethod.GET, RequestMethod.POST })
	public ResponseEntity<Object> setNasIpCheck(CustomReqProductVO req) {

		List<CustomReqProductVO> checkIp = reqProductService.setNasIpCheck(req);
		int res = checkIp.size();
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	/**
	 * Backup IP Address check
	 */
	@RequestMapping(value = "/setBackupIpCheck", method = { RequestMethod.GET, RequestMethod.POST })
	public ResponseEntity<Object> setBackupIpCheck(CustomReqProductVO req) {

		List<CustomReqProductVO> checkBackupIp = reqProductService.setBackupIpCheck(req);
		int res = checkBackupIp.size();
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	/**
	 * userId check
	 */
	@RequestMapping(value = "/setUserIdCheck", method = { RequestMethod.GET, RequestMethod.POST })
	public ResponseEntity<Object> setUserIdCheck(CustomReqProductVO req) {

		req.setBastionVmUserPassword(req.getBastionVmUserPasswordEnc());

		List<CustomReqProductVO> checkUserId = reqProductService.setUserIdCheck(req);
		int res =checkUserId.size();
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	/**
	 * userPw check
	 */
	@RequestMapping(value = "/setUserPwCheck", method = { RequestMethod.GET, RequestMethod.POST })
	public ResponseEntity<Object> setUserPwCheck(CustomReqProductVO req) {

		req.setBastionVmUserPassword(req.getBastionVmUserPasswordEnc());

		List<CustomReqProductVO> checkUserPw = reqProductService.setUserPwCheck(req);
		int res =checkUserPw.size();
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	/*
	 * HOSTNAME 저장
	 */
	@RequestMapping(value = "/setHostName", method = { RequestMethod.GET, RequestMethod.POST })
	public ResponseEntity<String> setHostName(CustomReqProductVO req) {

		String res = reqProductService.updateHostName(req);
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}

	/*
	 * IP 저장
	 */
	@RequestMapping(value = "/setIp", method = { RequestMethod.GET, RequestMethod.POST })
	public ResponseEntity<String> setIp(CustomReqProductVO req) {

		String res = reqProductService.updateIp(req);
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}

	/*
	 * BACKUP IP 저장
	 */
	@RequestMapping(value = "/setBackupIp", method = { RequestMethod.GET, RequestMethod.POST })
	public ResponseEntity<String> setBackupIp(CustomReqProductVO req) {

		String res = reqProductService.updateBackupIp(req);
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}

	/*
	 * IP 저장
	 */
	@RequestMapping(value = "/setNasIp", method = { RequestMethod.GET, RequestMethod.POST })
	public ResponseEntity<String> setNasIp(CustomReqProductVO req) {

		String res = reqProductService.updateNasIp(req);
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}

	/*
	 * VmUserId 저장
	 */
	@RequestMapping(value = "/setVmUserId", method = { RequestMethod.GET, RequestMethod.POST })
	public ResponseEntity<String> setVmUserId(CustomReqProductVO req) {

		String res = reqProductService.setUpdateUserId(req);
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}

	/*
	 * VmUserPw 저장
	 */
	@RequestMapping(value = "/setVmUserPw", method = { RequestMethod.GET, RequestMethod.POST })
	public ResponseEntity<String> setVmUserPw(CustomReqProductVO req) {

		req.setBastionVmUserPassword(req.getBastionVmUserPasswordEnc());

		String res = reqProductService.setUpdateUserPw(req);
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}


	@RequestMapping(value = "/changeProvisioning", method = { RequestMethod.GET, RequestMethod.POST})
	public ResponseEntity<String> changeProvisioning(CustomReqProductVO req) {
		String res = reqProductService.changeProvisioning(req);
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}

	@RequestMapping(value = "/endProvisioning", method = { RequestMethod.GET, RequestMethod.POST})
	public ResponseEntity<String> endProvisioning(CustomReqProductVO req) {
		String res = reqProductService.endProvisioning(req);
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}

	//승인부서 결재라인 업데이트
	@RequestMapping(value = "/updateApprovalLine")
	public ResponseEntity<Object> reqProjectInsert(HttpServletRequest request, ModelMap model, CustomReqProductVO req) {
		String res="";
		ModelMap map = new ModelMap();

		// 승인요청 통지를 위한 결재라인 지정 후 첫번째 결재자 ID정보
		String CurrentUserIdReview = "";
        String hiddenUserIdReview = "";
        String regUserId = "";

		List<Map<String, String>> updateList = req.getBssOrderProductVmUpdateList();


		if(updateList != null) {

			for(int i = 0 ; i < updateList.size(); i++) {

				HashMap<String, String> updateinfo = (HashMap<String, String>) updateList.get(i);
				CustomReqProductVO customReqProductVO = new CustomReqProductVO();

				if(updateinfo.get("requestType").equals("REQTYPE_NEW")) {

					customReqProductVO.setOrderProductSeq(updateinfo.get("orderProductSeq"));
					customReqProductVO.setCloudId(updateinfo.get("cloudId"));
					customReqProductVO.setAzName(updateinfo.get("azName"));
					customReqProductVO.setOsProductSeq(updateinfo.get("osProductSeq"));
					customReqProductVO.setVmProductSeq(updateinfo.get("vmProductSeq"));
					customReqProductVO.setVcpus(updateinfo.get("vcpus"));
					customReqProductVO.setMemGb(updateinfo.get("memGb"));
					customReqProductVO.setFlavorId(updateinfo.get("falvorId"));
					customReqProductVO.setDefaultNetworkId(updateinfo.get("defaultNetworkId"));
					customReqProductVO.setDefaultNetworkName(updateinfo.get("defaultNetworkName"));
					customReqProductVO.setDefaultNetworkAlias(updateinfo.get("defaultNetworkAlias"));

					customReqProductVO.setVolumeType(updateinfo.get("volumeType"));

					int mem_gb = Integer.parseInt(updateinfo.get("memGb"));
					int mem_mb = mem_gb * 1024;

					customReqProductVO.setMemMb(String.valueOf(mem_mb));


					CustomOssProjectVO customOssProjectVO = new CustomOssProjectVO();
					customOssProjectVO.setCloudId(customReqProductVO.getCloudId());
					customOssProjectVO.setProjectBoxId(updateinfo.get("projectBoxId"));

					CustomOssProjectVO getProjectDetail = ossProjectService.getOssProjectIdByCloudId(customOssProjectVO);


					if(getProjectDetail != null) {

						customReqProductVO.setProjectId(getProjectDetail.getProjectId());
						CustomReqProductVO getFlaverDetail = reqProductService.getFlaverDetail(customReqProductVO);
						getFlaverDetail.getFlavorId();
						customReqProductVO.setFlavorId(getFlaverDetail.getFlavorId());

						reqProductService.bssOrderProductUpdate(customReqProductVO);
						reqProductService.bssOrderProductVmUpdate(customReqProductVO);

					}else {
						res = "2";
						map.addAttribute("res", res);
						return new ResponseEntity<Object>(map, HttpStatus.OK);
					}
				}
			}
		}

		List<Map<String, String>> updateNasList = req.getBssOrderProductNasUpdateList();


		if(updateNasList != null) {

			for(int i = 0 ; i < updateNasList.size(); i++) {

				HashMap<String, String> updateNasinfo = (HashMap<String, String>) updateNasList.get(i);
				CustomReqProductVO customReqProductVO = new CustomReqProductVO();

				if(updateNasinfo.get("requestType").equals("REQTYPE_NEW")) {

					customReqProductVO.setOrderProductSeq(updateNasinfo.get("orderProductSeq"));
					customReqProductVO.setCloudId(updateNasinfo.get("cloudId"));
					customReqProductVO.setAzName(updateNasinfo.get("azName"));
					customReqProductVO.setDefaultNetworkId(updateNasinfo.get("defaultNetworkId"));
					customReqProductVO.setDefaultNetworkName(updateNasinfo.get("defaultNetworkName"));
					customReqProductVO.setDefaultNetworkAlias(updateNasinfo.get("defaultNetworkAlias"));

					CustomOssProjectVO customOssProjectVO = new CustomOssProjectVO();
					customOssProjectVO.setCloudId(customReqProductVO.getCloudId());
					customOssProjectVO.setProjectBoxId(updateNasinfo.get("projectBoxId"));

					CustomOssProjectVO getProjectDetail = ossProjectService.getOssProjectIdByCloudId(customOssProjectVO);

					if(getProjectDetail != null) {
						customReqProductVO.setProjectId(getProjectDetail.getProjectId());

						reqProductService.bssOrderProductUpdate(customReqProductVO);
						reqProductService.bssOrderProductNasUpdate(customReqProductVO);

					}else {
						res = "2";
						map.addAttribute("res", res);
						return new ResponseEntity<Object>(map, HttpStatus.OK);
					}
				}
			}
		}

		// applicaiton update
		String requestSeq = req.getRequestSeq();
		List<CustomReqProductVO> getReqlistvo = reqProductService.detailBssOrder(requestSeq);
		String replaceParams = "";

		for (CustomReqProductVO vo : getReqlistvo) {
			replaceParams = "";
			if (vo.getProductCategory().equals(CodeUtil.CMM_CODE_PRODCATE_APP)) {
				// Data Set
				vo.setAppName(req.getAppName());
				vo.setTemplateProductSeq(req.getTemplateProductSeq());
				vo.setTemplateCatalogSeq(req.getTemplateCatalogSeq());
				vo.setGitRepository(req.getGitRepository());
				vo.setLabel(req.getLabel());
				replaceParams = req.getParams().replaceAll("&amp;", "&");

				vo.setParams(replaceParams);
				vo.setOrderProductSeq(requestSeq);
				vo.setImageId(req.getTemplateName());
				vo.setPodCnt(req.getPodCnt());
				vo.setCpuLimit(req.getCpuLimit());
				vo.setMemLimit(req.getMemLimit());
        		vo.setOsProductSeq(req.getOsProductSeq());

				reqProductService.bssOrderProductAppUpdate(vo);
			}
//			reqProductService.actProduct(vo);
		}


        // 지정된 결재자 정보
		List<Map<String, String>> stepList = req.getApprovalStepList();

		// 현재 결재라인 정보
		//List<CustomReqCustomerVO> getApprovalModelSteplist = reqCatalogueService.getApprovalModelSteplistProject();

		int tmpStep = 0;
		boolean tmpStartFlag = false;
		if(req.getSelectApprv().equals("Y") && req.getApprvPass().equals("Y")) {
			for(int i = 5; i < 9; i++) {
				UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
				CustomReqCustomerVO paramStepInfo = new CustomReqCustomerVO();
				paramStepInfo.setRequestSeq(req.getRequestSeq());
				paramStepInfo.setRegUserId(req.getRegUserId());
				paramStepInfo.setStepId(req.getRegUserId());
				paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_COMPLETED);
				paramStepInfo.setStepLevel(i+"");
				paramStepInfo.setApprvUserId(userSession.getUsername());
				paramStepInfo.setApprvUserName(userSession.getNickname());
				paramStepInfo.setApprvScheduleUserId(userSession.getUsername());
				paramStepInfo.setApprvPass("Y");
				reqCatalogueService.updateSrApprovalStepinsert(paramStepInfo);
			}
			map.addAttribute("apprv", "pass");
		} else {
			for(int i = 0 ; i < stepList.size(); i++) {
				HashMap<String, String> stepInfo = (HashMap<String, String>) stepList.get(i);

				CustomReqCustomerVO paramStepInfo = new CustomReqCustomerVO();
				paramStepInfo.setRequestSeq(req.getRequestSeq());
				paramStepInfo.setRegUserId(req.getRegUserId());
				paramStepInfo.setStepId( stepInfo.get("userId") );
				paramStepInfo.setStepLevel( (i+5)+"" );

				if( paramStepInfo.getStepLevel().equals("5") ) {
					if(stepInfo.get("userId").equals("") || stepInfo.get("userId") == null ) {
						//입안보조자가 없을경우
						tmpStartFlag = true;
						paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_COMPLETED);
					} else {
						paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_PROCESSING);
						paramStepInfo.setApprvScheduleUserId(stepInfo.get("userId"));
						hiddenUserIdReview = stepInfo.get("userId");
						CurrentUserIdReview = stepInfo.get("userId");
					}

				} else if( paramStepInfo.getStepLevel().equals("6") ) {
					if( tmpStartFlag ) {
						paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_PROCESSING);
						paramStepInfo.setApprvScheduleUserId(stepInfo.get("userId"));
					} else {
						paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_WAITING);
						paramStepInfo.setApprvScheduleUserId(stepInfo.get("userId"));
						hiddenUserIdReview = stepInfo.get("userId");
					}

				} else if(paramStepInfo.getStepLevel().equals("7")){
					paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_WAITING);
					paramStepInfo.setApprvScheduleUserId(stepInfo.get("userId"));

				} else if(paramStepInfo.getStepLevel().equals("8")){
					paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_WAITING);
					paramStepInfo.setApprvScheduleUserId(stepInfo.get("userId"));

				} else {
					paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_WAITING);
				}
				reqCatalogueService.updateSrApprovalStepinsert(paramStepInfo);

				if(tmpStep < 3) { tmpStep++; }
			}
			map.addAttribute("apprv", "block");
		}


		// 결재자에게 알람
		Map<String,String> keywordMap = new HashMap<>();
		CustomReqProductVO reqProductVo = reqProductService.orderUserInfo(req.getRequestSeq());
		keywordMap.put("[[신청자명]]", reqProductVo.getUserName());
		keywordMap.put("[[URL]]", "http://k-cloud.kepco.co.kr/mng/req/product/view?orderNo="+req.getRequestSeq());
		keywordMap.put("[[LURL]]", "http://k-cloud.kepco.co.kr/mng/login");

//		alarmsTemplateService.alarms(33, CurrentUserIdReview, keywordMap);
//
//		CustomApprovalVO stepUser = new CustomApprovalVO();
//		stepUser.setRequestSeq(req.getRequestSeq());
//		List<CustomApprovalVO> nextApprovalVoList = approvalService.getApprovalQueueMemberList(stepUser);
//		for (CustomApprovalVO nextApprovVO : nextApprovalVoList) {
//			Map<String, String> alarmkepcoMap = new HashMap<>();
//			alarmkepcoMap.put("gbn", "35");
//			alarmkepcoMap.put("requestSeq", req.getRequestSeq());
//			alarmkepcoMap.put("regUserId", reqProductVo.getOrderUserId());	// 프로젝트 신청자
//			alarmkepcoMap.put("apprvNowUserId", nextApprovVO.getUserId());	// 현재 결재자
//			alarmkepcoMap.put("url", "http://k-cloud.kepco.co.kr/mng/req/product/view?orderNo="+req.getRequestSeq());
//			alarmsTemplateService.alarmsKepco(alarmkepcoMap);
//		}

		// 한전 연계 시스템 전송
		Map<String, String> alarmkepcoMap = new HashMap<>();
		alarmkepcoMap = new HashMap<>();
		alarmkepcoMap.put("gbn", "33");
		alarmkepcoMap.put("requestSeq", req.getRequestSeq());
		alarmkepcoMap.put("regUserId", reqProductVo.getOrderUserId());
		alarmkepcoMap.put("apprvNextUserId", CurrentUserIdReview);
		alarmkepcoMap.put("url", "http://k-cloud.kepco.co.kr/mng/req/product/view?orderNo="+req.getRequestSeq());
		alarmsTemplateService.alarmsKepco(alarmkepcoMap);


		res = "1";
		map.addAttribute("res", res);
		map.addAttribute("reqProjectSeq", req.getRequestSeq() );

		return new ResponseEntity<Object>(map, HttpStatus.OK);
	}

	@RequestMapping(value = "/checkCloudUsage")
	public ResponseEntity<Object> checkCloudUsage(HttpServletRequest request, ModelMap model, CustomReqProductVO req) {

		ModelMap map = new ModelMap();
		Map<String, Object> project = new HashMap<>();



		// 현재 신청한 VM용량
		List<CustomReqProductVO> vmSumlist = reqProductService.getSumVm(req);
		List<CustomReqProductVO> DiskSumlist = reqProductService.getSumDisk(req);
		List<CustomReqProductVO> getSumService = reqProductService.getSumService(req);
		List<CustomReqProductVO> getSumLBList = reqProductService.getSumLB(req);
		List<CustomReqProductVO> getSumSNList = reqProductService.getSumSN(req);
		List<CustomReqProductVO> getSumAPPList = reqProductService.getSumAPP(req);
		for (CustomReqProductVO getSumLB : getSumLBList) {
			if(getSumLB != null) {
				getSumLB.setVcpus(Integer.toString(0));
				getSumLB.setDiskGb(Integer.toString(0));
				getSumLB.setMemGb(Integer.toString(0));
				getSumLB.setVmUsed(0);
				getSumLB.setDiskUsed(0);
				project.put(getSumLB.getProjectId(),getSumLB);
			}
		}

		for (CustomReqProductVO getSumSN : getSumSNList) {
			if(getSumSN != null) {
				getSumSN.setVcpus(Integer.toString(0));
				getSumSN.setDiskGb(Integer.toString(0));
				getSumSN.setMemGb(Integer.toString(0));
				getSumSN.setVmUsed(0);
				getSumSN.setDiskUsed(0);
				project.put(getSumSN.getProjectId(),getSumSN);
			}
		}

		for (CustomReqProductVO getSumAPP : getSumAPPList) {
			if(getSumAPP != null) {
				getSumAPP.setVcpus(Integer.toString(0));
				getSumAPP.setDiskGb(Integer.toString(0));
				getSumAPP.setMemGb(Integer.toString(0));
				getSumAPP.setVmUsed(0);
				getSumAPP.setDiskUsed(0);
				project.put(getSumAPP.getProjectId(),getSumAPP);
			}
		}



		for (CustomReqProductVO serviceSum : getSumService) {
			int vcpus = 0;
			int vDisk = 0;
			int mem = 0;
			int vm = 0;
			serviceSum.setVcpus(Integer.toString(vcpus));
			serviceSum.setDiskGb(Integer.toString(vDisk));
			serviceSum.setMemGb(Integer.toString(mem));
			serviceSum.setVmUsed(vm);
			serviceSum.setDiskUsed(serviceSum.getDiskUsed());
			project.put(serviceSum.getProjectId(),serviceSum);
		}
		for (CustomReqProductVO vmSum : vmSumlist) {

			int vcpus = Integer.parseInt(vmSum.getVcpus()) - Integer.parseInt(vmSum.getBeforeVcpus());
			int vDisk = Integer.parseInt(vmSum.getDiskGb()) - Integer.parseInt(vmSum.getBeforeDiskGb());
			int mem = Integer.parseInt(vmSum.getMemGb()) - Integer.parseInt(vmSum.getBeforeMemGb());
			int vm = vmSum.getVmUsed() - Integer.parseInt(vmSum.getChangeCnt()) - Integer.parseInt(vmSum.getExprCnt());
			String newCnt = vmSum.getNewCnt();
			vmSum.setVcpus(Integer.toString(vcpus));
			vmSum.setDiskGb(Integer.toString(vDisk));
			vmSum.setMemGb(Integer.toString(mem));
			vmSum.setVmUsed(vm);
			vmSum.setDiskUsed(vmSum.getDiskUsed());
			vmSum.setNewCnt(newCnt);
			project.put(vmSum.getProjectId(),vmSum);
		}

		for(CustomReqProductVO vmDisk : DiskSumlist) {
			CustomReqProductVO crpv = (CustomReqProductVO) project.get(vmDisk.getProjectId());
			int disk = 0;
			int diskUsed = 0;
			int newCnt = 0;
			if(crpv != null) {
				disk = Integer.parseInt(crpv.getDiskGb()) + Integer.parseInt(vmDisk.getDiskGb());
				diskUsed = crpv.getDiskUsed();
				if(crpv.getNewCnt() == null) {
					crpv.setNewCnt("0");
				}
				newCnt = Integer.parseInt(crpv.getNewCnt()) + Integer.parseInt(vmDisk.getNewCnt());
			} else {
				crpv = new CustomReqProductVO();
				crpv.setProjectId(vmDisk.getProjectId());
				newCnt = Integer.parseInt(vmDisk.getNewCnt());
				diskUsed = vmDisk.getDiskUsed();
				crpv.setCloudId(vmDisk.getCloudId());
				crpv.setCloudType(vmDisk.getCloudType());
				disk = Integer.parseInt(vmDisk.getDiskGb()) - Integer.parseInt(vmDisk.getBeforeDiskGb());
			}
			crpv.setDiskGb(Integer.toString(disk));
			crpv.setDiskUsed(diskUsed);
			crpv.setNewCnt(Integer.toString(newCnt));
			project.put(vmDisk.getProjectId(), crpv);
		}

		    boolean ft = true;
		    List list = new ArrayList();

		project.forEach((strKey,strValue)->{
			CustomReqProductVO CRPV = (CustomReqProductVO) strValue;
			if(CRPV.getCloudType().equals("openstack")) {
				CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo(CRPV.getCloudId());
				ProjectIF projectIF = AbstractFactory.getProject(cloudVo);
				String adminProjectId = "";
				List<Project> projects;
				try {
					projects = projectIF.getProjects();
					for (Project pj : projects) {
						if (pj.getName().equalsIgnoreCase("admin"))
							adminProjectId = pj.getId();
					}
				} catch (NotConnectGatewayException | NotSupportGatewayException | InvaildOpenStackException e2) {
					// TODO Auto-generated catch block
					e2.printStackTrace();
				}
				ServerQuotaIF apiIF = AbstractFactory.getServerQuotaIF(cloudVo);
				ServerQuotaIF serverQuotaIF = AbstractFactory.getServerQuotaIF(cloudVo);
				FlavorIF flaverIF = AbstractFactory.getFlavorIF(cloudVo);
				Map<String, Flavor> flavorMap = new HashMap<String, Flavor>();
				List<Flavor> flavors;
				try {
					flavors = flaverIF.getFlavors();
					for (Flavor flavor : flavors) {
						flavorMap.put(flavor.getId(), flavor);
					}
				} catch (NotConnectGatewayException | NotSupportGatewayException | InvaildOpenStackException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
				VolumeIF volumeIF = AbstractFactory.getVolumeIF(CRPV.getProjectName(),cloudVo);
				try {
					int usedMem = 0;
					int usedVcpus = 0;
					int usedDisk = 0;
					int volumeCount = 0;
					int vmUsed = CRPV.getVmUsed();
					int newCnt = 0;
					if(CRPV.getNewCnt() != null) {
						newCnt += Integer.parseInt(CRPV.getNewCnt());
					}
					OpenStackUsage projectdUsage = new OpenStackUsage();
					ServerIF serverIF = AbstractFactory.getServerIF(CRPV.getProjectName(),cloudVo);
					List<Server> servers = serverIF.getAllServers("&project_id="+CRPV.getProjectId());
					CustomReqProductVO processVm = reqProductService.processSumVm(CRPV);
					CustomReqProductVO processDisk = reqProductService.processSumDisk(CRPV);
					usedMem += Integer.parseInt(processVm.getMemGb()) - Integer.parseInt(processVm.getBeforeMemGb());
					usedVcpus += Integer.parseInt(processVm.getVcpus()) - Integer.parseInt(processVm.getBeforeVcpus());
					usedDisk += Integer.parseInt(processVm.getDiskGb()) - Integer.parseInt(processVm.getBeforeDiskGb()) + Integer.parseInt(processDisk.getDiskGb()) - Integer.parseInt(processDisk.getBeforeDiskGb());
					vmUsed += processVm.getVmUsed() - Integer.parseInt(processVm.getChangeCnt()) - Integer.parseInt(processVm.getExprCnt());
					volumeCount += CRPV.getDiskUsed() + newCnt + Integer.parseInt(processVm.getNewCnt()) + Integer.parseInt(processDisk.getNewCnt());
					for (Server server : servers) {
						Flavor tmpflavor = flavorMap.get(server.getFlavor().getId());
						usedMem += tmpflavor.getRam() / 1024;
						usedVcpus += tmpflavor.getVcpus();
						vmUsed += 1;
					}

					projectdUsage.setProjectId(CRPV.getProjectId());
					projectdUsage.setProjectName(CRPV.getProjectName());
					QuotaSet quota = serverQuotaIF.getServerQuota(CRPV.getProjectId());
					projectdUsage.setVmTotal(quota.getInstances());
					projectdUsage.setVCpuTotal(quota.getCores());
					projectdUsage.setMemTotal(quota.getRam());
					if(CRPV.getMemGb() != null) {
						usedMem += Integer.parseInt(CRPV.getMemGb());
					}
					if(CRPV.getVcpus() != null) {
						usedVcpus += Integer.parseInt(CRPV.getVcpus());
					}
					if(CRPV.getDiskGb() != null) {
						usedDisk += Integer.parseInt(CRPV.getDiskGb());
					}

					int QuotaRam = quota.getRam() / 1024;
					int quotaVm = quota.getInstances();

					List<Volume> volumes = volumeIF.getAllVolumes("&project_id="+CRPV.getProjectId());
					QuotaSet vquota = volumeIF.getVolumeQuota(adminProjectId, CRPV.getProjectId());
					int QuotaDisk = vquota.getGigabytes();
					int volumeMax = vquota.getVolumes();
					for (Volume volume : volumes) {
						usedDisk += volume.getSize();
					}

					map.addAttribute("res", "200");

					if(usedVcpus > quota.getCores()) {
						map.addAttribute("res", "406");
					}
					if(usedMem > QuotaRam) {
						map.addAttribute("res", "407");
					}
					if(usedDisk > QuotaDisk) {
						map.addAttribute("res", "408");
					}
					if(vmUsed > quotaVm){
						map.addAttribute("res", "409");
					}
					if(volumeCount > volumeMax){
						map.addAttribute("res", "410");
					}

					list.add( map.get("res"));
				} catch (NotConnectGatewayException | NotSupportGatewayException | InvaildOpenStackException e) {
					logger.error("openstack checkCloudUsage Exception");
				}
			} else if(CRPV.getCloudType().equals("vmware")) {
				CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo(CRPV.getCloudId());
				vraServerIF serverIF = vraAbstractFactory.getServerIF(cloudVo);
				vraProjectIF projectIF = vraAbstractFactory.getProject(cloudVo);

				try {
					int usedMem = 0;
					int usedVcpus = 0;
					int usedDisk = 0;
					int vmUsed = CRPV.getVmUsed();
					int newCnt = 0;

					OpenStackUsage projectdUsage = new OpenStackUsage();
					if(CRPV.getNewCnt() != null) {
						newCnt += Integer.parseInt(CRPV.getNewCnt());
					}
					CustomReqProductVO processVm = reqProductService.processSumVm(CRPV);
					CustomReqProductVO processDisk = reqProductService.processSumDisk(CRPV);

					usedMem += Integer.parseInt(processVm.getMemGb()) - Integer.parseInt(processVm.getBeforeMemGb());
					usedVcpus += Integer.parseInt(processVm.getVcpus()) - Integer.parseInt(processVm.getBeforeVcpus());
					usedDisk += Integer.parseInt(processVm.getDiskGb()) - Integer.parseInt(processVm.getBeforeDiskGb()) + Integer.parseInt(processDisk.getDiskGb()) - Integer.parseInt(processDisk.getBeforeDiskGb());
					vmUsed += processVm.getVmUsed() - Integer.parseInt(processVm.getChangeCnt()) - Integer.parseInt(processVm.getExprCnt());
					vraServer getServer = serverIF.getServers(CRPV.getProjectId());
					List<vraContent> serverContents = getServer.getContent();
					for(vraContent server : serverContents) {
						vraServer depInfo = serverIF.getDepInfo(server.getId());
						List<vraContent> contents = depInfo.getContent();
						for(vraContent content : contents) {
							if(content.getType().equals("Cloud.vSphere.Machine")) {
								usedMem += Integer.parseInt(content.getProperties().getTotalMemoryMB()) / 1024;
								usedVcpus += Integer.parseInt(content.getProperties().getCpuCount());
								vmUsed += 1;
								List<vraDisks> Disks = content.getProperties().getStorage().getDisks();
								for(vraDisks disk : Disks) {
									usedDisk += Integer.parseInt(disk.getCapacityGb());
								}
							}
						}
					}
					projectdUsage.setProjectId(CRPV.getProjectId());
					projectdUsage.setProjectName(CRPV.getProjectName());
					vraProjectObject projects = projectIF.getProject(CRPV.getProjectId());

					//quota.setGigabytes(Integer.parseInt(projects.getZones().get(0).getStorageLimitGB()));
					projectdUsage.setVmTotal(projects.getZones().get(0).getMaxNumberInstances());
					projectdUsage.setVCpuTotal(projects.getZones().get(0).getCpuLimit() / 1024);
					projectdUsage.setMemTotal(Integer.parseInt(projects.getZones().get(0).getMemoryLimitMB()));
					if(CRPV.getMemGb() != null) {
						usedMem += Integer.parseInt(CRPV.getMemGb());
					}
					if(CRPV.getVcpus() != null) {
						usedVcpus += Integer.parseInt(CRPV.getVcpus());
					}
					if(CRPV.getDiskGb() != null) {
						usedDisk += Integer.parseInt(CRPV.getDiskGb());
					}

					int QuotaRam = Integer.parseInt(projects.getZones().get(0).getMemoryLimitMB()) / 1024;
					int quotaVm = projects.getZones().get(0).getMaxNumberInstances();
					int QuotaDisk = Integer.parseInt(projects.getZones().get(0).getStorageLimitGB());

					map.addAttribute("res", "200");

					if(usedVcpus > projects.getZones().get(0).getCpuLimit() / 1024) {
						map.addAttribute("res", "406");
					}
					if(usedMem > QuotaRam) {
						map.addAttribute("res", "407");
					}
					if(usedDisk > QuotaDisk) {
						map.addAttribute("res", "408");
					}
					if(vmUsed > quotaVm){
						map.addAttribute("res", "409");
					}

					list.add( map.get("res"));

				} catch (Exception e) {
					logger.error(" vmware checkCloudUsage Exception");
				}
				map.addAttribute("res", "200");
			} else if(CRPV.getCloudType().equals("openshift")) {
				map.addAttribute("res", "200");
			}
		});

		Loop : for( int i =0; i<list.size(); ++i ) {
			String res = (String) list.get( i);
			map.addAttribute("res", "200");
			if( !"200".equals( res)){
				map.addAttribute("res", res);
				break Loop;
			}
		}
		if( list == null || list.size() <= 0 ) {
			map.addAttribute("res", "200");
		}

		return new ResponseEntity<Object>(map, HttpStatus.OK);
	}

	@RequestMapping(value = "/appNameChk", method = { RequestMethod.POST })
	public ResponseEntity<Object> projectNameChk(CustomReqProductVO req, Model model) {

		System.out.println(req.getProjectId());
		int chkVal = reqProductService.bssOrderProductAppNameChk(req);

		System.out.println("chkVal" + chkVal);
		return new ResponseEntity<Object>(chkVal, HttpStatus.OK);
	}

	@RequestMapping(value = "/selectTemplate", method = { RequestMethod.GET, RequestMethod.POST })
	public ResponseEntity<Object> selectTemplate(HttpServletRequest request, CustomReqProductVO req) {

		final String cloudId = req.getCloudId();
		Assert.notNull(cloudId, "");
		CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo(cloudId);
		HashMap<String, Object> map = new HashMap<>();
		if (cloudVo.getCloudType().equals("openshift")) {
			try {
//				map.put("appTemplateList", opsApiOptionService.getTemplates(cloudVo));
				Template template = opsApiOptionService.getTemplate(cloudVo, request.getParameter("templateName"),
						request.getParameter("templateNameSpace"));
				JsonObject jsonResponse = new JsonObject();
				Gson gson = new Gson();

				jsonResponse.add("jsonParam", gson.toJsonTree(template));
				map.put("parametersList", jsonResponse.toString());

			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return new ResponseEntity<Object>(map, HttpStatus.OK);
	}

	// 개발환경 그룹 URL 등록
	@RequestMapping(value = "/mngEnvNameInsert", method = RequestMethod.POST)
	public ResponseEntity<Object> mngEnvNameInsert(CustomReqProductVO orderNo) {
		String res = "";
		res = reqProductService.envNameInsert(orderNo);
		if (res == null) {
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	// 개발환경 그룹 URL 중복체크
	@RequestMapping(value = "/envGrpUrlChk")
	public ResponseEntity<Object> envGrpUrlChk(CustomReqProductVO req) {
		int chkUrlVal = reqProductService.envGrpUrlChk(req);
		return new ResponseEntity<Object>(chkUrlVal, HttpStatus.OK);
	}

	// 개발환경 그룹 URL 중복체크
	@RequestMapping(value = "/envNameChk")
	public ResponseEntity<Object> envNameChk(CustomReqProductVO req) {
		int chkUrlVal = reqProductService.envNameChk(req);
		return new ResponseEntity<Object>(chkUrlVal, HttpStatus.OK);
	}


	// 개발환경 그룹명 등록
	@RequestMapping(value = "/mngEnvGroupNameInsert", method = RequestMethod.POST)
	public ResponseEntity<Object> mngEnvGroupNameInsert(CustomReqProductVO orderNo) {
		String res = "";
		res = reqProductService.envGroupNameInsert(orderNo);
		if (res == null) {
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	// 개발환경 그룹 이름 중복체크
	@RequestMapping(value = "/envGroupNameChk")
	public ResponseEntity<Object> envGroupNameChk(CustomReqProductVO req) {
		int chkNameVal = reqProductService.envGroupNameChk(req);
		return new ResponseEntity<Object>(chkNameVal, HttpStatus.OK);
	}

}
