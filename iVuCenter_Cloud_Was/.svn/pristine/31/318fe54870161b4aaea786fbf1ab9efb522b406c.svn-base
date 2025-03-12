package com.ivucenter.cloud.portal.req.project;

import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

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
import com.ivucenter.cloud.portal.req.catalogue.ReqCatalogueService;
import com.ivucenter.cloud.portal.req.customer.CustomReqCustomerVO;
import com.ivucenter.cloud.portal.req.customer.ReqCustomerService;
import com.ivucenter.cloud.portal.req.product.CustomReqProductVO;
import com.ivucenter.cloud.portal.req.product.ReqProductService;
import com.ivucenter.cloud.portal.req.user.CustomReqUserVO;
import com.ivucenter.cloud.portal.util.CodeUtil;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
@RequestMapping(value="/mng/req/project")
public class MngReqProjectController {

    private static final Logger logger = LoggerFactory.getLogger(MngReqProjectController.class);

	@Autowired
	private ReqProjectService reqProjectService;

	@Autowired
	private ReqCustomerService customerService;

	@Autowired
	private ReqProductService reqProductService;

	@Autowired
	private CmmFileService cmmFileService;

	@Autowired
	private ReqCatalogueService reqCatalogueService;

	@Autowired
	private AlarmsTemplateService alarmsTemplateService;

	@Autowired
	private CmmUserService cmmUserService;

	@Autowired
	private ApprovalService approvalService;

	@Autowired
	private OssCloudService ossCloudService;

	/**
	 * 프로젝트 미승인 프로세서
	 * @throws Exception
	 */
	@RequestMapping(value="/rejectedUpdate", method = {RequestMethod.GET,RequestMethod.POST})
	public ResponseEntity<String> mngRejectedUpdate(CustomReqCustomerVO req) throws Exception {

		UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();


		String res = "";
		String requestSeq = req.getRequestSeq();
		String stepLevel = req.getStepLevel();

		CustomReqProjectVO customReqProjectVO = new CustomReqProjectVO();
		customReqProjectVO.setCompleteFlag("Y");
		customReqProjectVO.setReqProjectSeq(req.getRequestSeq());
		customReqProjectVO.setModUserId(userSession.getUsername());
		List<CustomOssCloudVO> reqProjectCloudList = ossCloudService.getOssProjectCloudListByReqProjectSeq(req.getRequestSeq());

		if(reqProjectCloudList.size() > 0){
			reqProjectService.updateProject(customReqProjectVO);

			Map<String, Object> param = new HashMap<String, Object>();
			List<String> ids = reqProjectCloudList.stream().map(e -> e.getCloudId()).collect(Collectors.toCollection(ArrayList::new));
			String[] cloudIds = ids.stream().toArray(String[]::new);
			param.put("cloudIds", cloudIds);
			param.put("requestSeq", req.getRequestSeq());

			reqProjectService.deleteReqProjectCloud(param);
		}

		req.setModUserId(req.getRegUserId());
		String apprvState = "APPRV_REJECTED";
		String apprvDescription = req.getApprvDescription();
		req.setApprvDescription(apprvDescription);
		req.setApprvState(apprvState);
		req.setStepLevel(stepLevel);
		req.setApprvUserId(userSession.getUsername());
		req.setApprvUserName(userSession.getNickname());
		res = customerService.stepUpdate(req);

		CustomApprovalVO stepUser = new CustomApprovalVO();
		stepUser.setStepLevel(req.getStepLevel());
		stepUser.setRequestSeq(req.getRequestSeq());


		CustomApprovalVO ApprovalVo = approvalService.getNextScheduleUser(stepUser);

		Map<String,String> keywordMap = new HashMap<>();
		CustomReqProjectVO projectVo = reqProjectService.getProjectView(requestSeq);
		keywordMap.put("[[프로젝트명]]", projectVo.getProjectAlias());
		keywordMap.put("[[관리자명]]",  projectVo.getManagerName());
		keywordMap.put("[[반려사유]]", req.getApprvDescription());
		keywordMap.put("[[URL]]", "http://k-cloud.kepco.co.kr/mng/req/project/workApprovalProjectView?reqProjectSeq="+req.getRequestSeq());
		alarmsTemplateService.alarms(22, projectVo.getRegUserId(), keywordMap);
		// 한전 연계 시스템 전송
		Map<String, String> alarmkepcoMap = new HashMap<>();

		if(ApprovalVo != null) {
			alarmkepcoMap.put("apprvNextUserId", ApprovalVo.getApprvUserId());	// 현재 결재자
		}
		alarmkepcoMap.put("gbn", "22");
		alarmkepcoMap.put("requestSeq", req.getRequestSeq());
		alarmkepcoMap.put("regUserId", projectVo.getRegUserId());		// 프로젝트 신청자
		alarmkepcoMap.put("apprvNowUserId", req.getApprvUserId());	// 현재 결재자
		alarmkepcoMap.put("url", "http://k-cloud.kepco.co.kr/mng/req/project/workApprovalProjectView?reqProjectSeq="+req.getRequestSeq());
		alarmsTemplateService.alarmsKepco(alarmkepcoMap);
		//
		return (res == null) ? new ResponseEntity<String>(HttpStatus.NO_CONTENT) : new ResponseEntity<String>(res, HttpStatus.OK);
	}


	// 프로젝트 신청 작업 완료
	@RequestMapping(value = "/projectWorkComplete")
	public ResponseEntity<String> projectWorkComplete(CustomReqProjectVO req, Principal principal){

		//완료 처리
		String res = reqProjectService.setProjectWorkComplete(req);

		return (res == null) ? new ResponseEntity<String>(HttpStatus.NO_CONTENT) : new ResponseEntity<String>(res, HttpStatus.OK);//
	}

	@RequestMapping(value = "/updateProject")
	public ResponseEntity<String> MngReqProjectUpdate(CustomReqProjectVO req) {
		String res = null;
		try {
			res = reqProjectService.updateProject(req);
		}catch (Exception e) {
			res = "0";
			logger.error("updateProject Exception");
		}
		return (res == null) ? new ResponseEntity<String>(HttpStatus.NO_CONTENT) : new ResponseEntity<String>(res, HttpStatus.OK);
	}

	// PM 설정 대상 리스트
	@RequestMapping(value = "/pmPopList", method = RequestMethod.GET)
	public ResponseEntity<Object> pmPopList1(CustomReqProjectVO req){

		List<CustomReqUserVO> res = reqProjectService.pmPopList(req);

		HashMap<String, Object> map = new HashMap<>();
		map.put("pmPopList", res);
		map.put("projectId", req.getProjectId());

		return (res == null) ? new ResponseEntity<Object>(HttpStatus.NO_CONTENT) : new ResponseEntity<Object>(res, HttpStatus.OK);//
	}

	//프로젝트 PM 등록
	@RequestMapping(value = "/projectPmInsert")
	public ResponseEntity<String> projectPmInsert1(CustomReqProjectVO req) {
		log.debug(" req.getUserId() : " + req.getUserId());
		log.debug(" req.getProjectId() : " + req.getProjectId());
		String res = reqProjectService.setProjectPmupdate(req);
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}

	/**
	 * 프로젝트 신청목록 화면(New)
	 */
	@RequestMapping(value="/workApprovalProject")
	public String mngWorkApprovalProject(HttpServletRequest request , Model model) {

        String myWorkYn =  request.getParameter("myWorkYn");
		model.addAttribute("myWorkYn", myWorkYn);

		return "mng/req/workApproval/project/workApprovalProject_list";
	}

	/**
	 * 프로젝트 신청목록 조회(New)
	 */
	@RequestMapping(value = "/workApprovalProjectList", produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> mngWorkApprovalProjectList(CustomReqProjectVO req){
		UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        req.setUserId(userSession.getUsername());
        req.setRoleYn(userSession.hasRole("ROLE_CLOUD_ADMIN"));
		String res = reqProjectService.list(req);
		if(res.equals("")){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	@RequestMapping(value = "/workApprovalProjectExcel")
	public ModelAndView mngWorkApprovalProjectExcel(CustomReqProjectVO req, ModelMap map){
		map.addAttribute("excel_gbn", "workApprovalProject");
		map.addAttribute("excel_title", "작업승인처리_프로젝트 신청관리");
		map.addAttribute("excel_list", reqProjectService.excel(req));

		return new ModelAndView("ossProjectExcelView", map);
	}

	// 프로젝트 신청 작업완료 화면
	@RequestMapping(value = "/workApprovalProjectView")
	public String mngWorkApprovalProjectView(HttpServletRequest request, Model model, Principal principal) {

		UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		model.addAttribute("apprvPass", userSession.getApprvPass());

		final String reqProjectSeq =  request.getParameter("reqProjectSeq");

		model.addAttribute("reqProjectSeq", reqProjectSeq);
		model.addAttribute("orderNo", reqProjectSeq);

		// 로그인 유저 정보
		final String loginUserId = principal.getName();
		CustomCmmUserVO cmmUserInfo = new CustomCmmUserVO();
		cmmUserInfo.setUserId(loginUserId);
		cmmUserInfo = cmmUserService.userInfoDetail(cmmUserInfo);
		model.addAttribute("userDeptCode", cmmUserInfo.getDeptCode());
		model.addAttribute("userDeptName", cmmUserInfo.getDeptNameOnly());
		model.addAttribute("userCustomerName", cmmUserInfo.getCustomerName());
		model.addAttribute("userCustomerId", cmmUserInfo.getCustomerId());
		model.addAttribute("userLevelCode", cmmUserInfo.getUserLevelCode());

		Map<String, String> map = new HashMap<>();
		map.put("userId", loginUserId);
		map.put("orderNo", reqProjectSeq);
		// 승인스텝멤버 불러오기
		String stepId = reqProductService.getStepId(map);
		model.addAttribute("stepId", stepId);

		String userApprvState ="";
		userApprvState = reqProductService.getUserApprvState(map);
		model.addAttribute("userApprvState", userApprvState);

		List<CustomReqProductVO> approvalList = reqProductService.approvalList(map);
		for (int i = 0; i < approvalList.size(); i++) {
			if(approvalList.get(i).getApprvState().equals("APPRV_REJECTED")){
				String inject ="Y";
				model.addAttribute("inject",inject);
			}
		}
		model.addAttribute("getProjectAppSteplist", approvalList);

		List<CustomReqProductVO> approvalUserId = reqProductService.approvalUserId(reqProjectSeq);
		model.addAttribute("approvalUserId", approvalUserId);

		// 프로젝트 신청 정보
		CustomReqProjectVO getProjectView = reqProjectService.getProjectView(reqProjectSeq);
		model.addAttribute("getProjectView", getProjectView);

		// 프로젝트 신청 클라우드 정보
		List<CustomReqProjectVO> getProjectCloudView = reqProjectService.getProjectCloudView(reqProjectSeq);


		model.addAttribute("getProjectCloudView", getProjectCloudView);
		model.addAttribute("getProjectCloudViewSize", getProjectCloudView.size());

		// 프로젝트 신청자 정보
		CustomCmmUserVO userInfo = reqProjectService.getUserInfo(reqProjectSeq);
		model.addAttribute("userVo", userInfo);

		// 프로젝트 첨부파일 정보
		CustomCmmFileVO vo = new CustomCmmFileVO();
		vo.setProgramName(CodeUtil.FILE_PROGRAM_NAME4);
		vo.setProgramSeq(reqProjectSeq);
		model.addAttribute("file", cmmFileService.list(vo));


		List<CustomOssCloudVO> reqProjectCloudList = ossCloudService.getReqProjectCloudListByReqProjectSeq(reqProjectSeq);
		model.addAttribute("reqProjectCloudList", reqProjectCloudList);


		// 프로젝트 관리자 정보
		List<CustomReqCustomerVO> managerList = reqProjectService.reqManagerList(reqProjectSeq);
		for(CustomReqCustomerVO vo1 : managerList) {
			vo1.setUserPhone(vo1.getUserPhoneDec());
			vo1.setUserMail(vo1.getUserMailDec());
			vo1.setUserTel(vo1.getUserTelDec());
    	}
		model.addAttribute("managerList", managerList);

		return "mng/req/workApproval/project/workApprovalProject_view";
	}


	@RequestMapping(value = "/stepUpdate", method = { RequestMethod.GET, RequestMethod.POST })
	public ResponseEntity<String> mngProjectStepUpdate(CustomReqProductVO req, Model model, Principal principal) {
		String res = "";

		// 현재 스탭 상태 변경
		req.setModUserId(req.getRegUserId());
		req.setApprvState(CodeUtil.CMM_CODE_APPRV_COMPLETED);
		res = reqProductService.stepUpdate(req);

		String rightStepId = req.getRightStepId();
		if (rightStepId != "*") { // 최종 스탭이 아닐 경우

			int stepLevel = Integer.parseInt(req.getStepLevel());
			if (stepLevel == 5 || stepLevel == 6) {
				//3차 승인시 프로젝트명,프로젝트 설명 req_project 테이블 업데이트 4차 5차 승인자는 수정불가
				res = reqProductService.reqProjectUpdate(req);
			}

			CustomApprovalVO stepUser = new CustomApprovalVO();
			stepUser.setStepLevel(req.getStepLevel());
			stepUser.setRequestSeq(req.getRequestSeq() );
			CustomApprovalVO ApprovalVo = approvalService.getNextScheduleUser(stepUser);
			List<CustomApprovalVO> nextApprovalVoList = approvalService.getNextScheduleUserList(stepUser);
			for (CustomApprovalVO nextApprovVO : nextApprovalVoList) {
				CustomReqProjectVO projectVo = reqProjectService.getProjectView(req.getRequestSeq());
				Map<String,String> keywordMap = new HashMap<>();
				keywordMap.put("[[프로젝트명]]", projectVo.getProjectAlias());
				keywordMap.put("[[URL]]", "http://k-cloud.kepco.co.kr/mng/req/project/workApprovalProjectView?reqProjectSeq="+req.getRequestSeq());
				alarmsTemplateService.alarms(23, nextApprovVO.getUserId(), keywordMap);
				// 한전 연계 시스템 전송
				Map<String, String> alarmkepcoMap = new HashMap<>();
				alarmkepcoMap.put("gbn", "23");
				alarmkepcoMap.put("requestSeq", req.getRequestSeq());
				alarmkepcoMap.put("regUserId", projectVo.getRegUserId());		// 프로젝트 신청자
				alarmkepcoMap.put("apprvNowUserId", ApprovalVo.getApprvUserId());		// 현재 결재자
				if(!req.getStepLevel().equals("4")) {
					alarmkepcoMap.put("apprvNextUserId", ApprovalVo.getUserId());	// 다음 결재자
				}
				alarmkepcoMap.put("url", "http://k-cloud.kepco.co.kr/mng/req/project/workApprovalProjectView?reqProjectSeq="+req.getRequestSeq());
				alarmsTemplateService.alarmsKepco(alarmkepcoMap);
			}
			// 다음 스탭 상태 변경
			req.setApprvDescription("(NULL)");
			req.setApprvState(CodeUtil.CMM_CODE_APPRV_PROCESSING);
			req.setStepLevel(String.valueOf(stepLevel + 1));

			res = reqProductService.stepUpdate(req);
		}

		return new ResponseEntity<String>(res, HttpStatus.OK);
	}

	// 승인부서 결재라인 업데이트
	@RequestMapping(value = "/updateApprovalLine")
	public ResponseEntity<Object> reqProjectInsert(HttpServletRequest request, ModelMap model, CustomReqProjectVO req) {
		String res="";

		List<Map<String, String>> quotaList = req.getReqProjectCloudQuotaList();
		List<Map<String, String>> quotaListNutanix = req.getReqProjectCloudQuotaNutanixList();
		CustomReqProjectVO customReqProjectVO = new CustomReqProjectVO();

		if(quotaList != null) {
			for(int i = 0 ; i < quotaList.size(); i++) {
				HashMap<String, String> quotaInfo = (HashMap<String, String>) quotaList.get(i);

				customReqProjectVO.setCloudId(quotaInfo.get("cloudId"));
				customReqProjectVO.setReqProjectSeq(req.getReqProjectSeq());
				customReqProjectVO.setCpuLimit(quotaInfo.get("cpuLimit"));
				customReqProjectVO.setMemLimit(quotaInfo.get("memLimit"));
				customReqProjectVO.setMemReq(quotaInfo.get("memReq"));
				customReqProjectVO.setCpuReq(quotaInfo.get("cpuReq"));
				customReqProjectVO.setVolumeReq(quotaInfo.get("volumeReq"));
				customReqProjectVO.setPodReq(quotaInfo.get("podReq"));
				customReqProjectVO.setQuotaYn(quotaInfo.get("quotaYn"));


				customReqProjectVO.setPodCpuMin(quotaInfo.get("podCpuMin"));
				customReqProjectVO.setPodCpuMax(quotaInfo.get("podCpuMax"));
				customReqProjectVO.setPodMemMin(quotaInfo.get("podMemMin"));
				customReqProjectVO.setPodMemMax(quotaInfo.get("podMemMax"));

				customReqProjectVO.setLimitRangeCpuMin(quotaInfo.get("limitRangeCpuMin"));
				customReqProjectVO.setLimitRangeCpuMax(quotaInfo.get("limitRangeCpuMax"));
				customReqProjectVO.setLimitRangeMemMin(quotaInfo.get("limitRangeMemMin"));
				customReqProjectVO.setLimitRangeMemMax(quotaInfo.get("limitRangeMemMax"));
				customReqProjectVO.setLimitRangeCpuDefault(quotaInfo.get("limitRangeCpuDefault"));
				customReqProjectVO.setLimitRangeMemDefault(quotaInfo.get("limitRangeMemDefault"));
				customReqProjectVO.setLimitRangeCpuDefaultRequest(quotaInfo.get("limitRangeCpuDefaultRequest"));
				customReqProjectVO.setLimitRangeMemDefaultRequest(quotaInfo.get("limitRangeMemDefaultRequest"));
				customReqProjectVO.setLimitRangeCpuLimitRequestRatio(quotaInfo.get("limitRangeCpuLimitRequestRatio"));
				customReqProjectVO.setLimitRangeMemLimitRequestRatio(quotaInfo.get("limitRangeMemLimitRequestRatio"));



				// req_project_box update
				reqProjectService.updateReqProjectCloudLimit(customReqProjectVO);

			}
		}



		if(quotaListNutanix != null) {
			for(int i = 0 ; i < quotaListNutanix.size(); i++) {
				HashMap<String, String> list = (HashMap<String, String>) quotaListNutanix.get(i);

				customReqProjectVO.setCloudId(list.get("cloudId"));
				customReqProjectVO.setReqProjectSeq(req.getReqProjectSeq());
				customReqProjectVO.setCpuReq(list.get("cpuReq"));
				customReqProjectVO.setMemReq(list.get("memReq"));
				customReqProjectVO.setStorageReq(list.get("storageReq"));
				customReqProjectVO.setQuotaYn(list.get("quotaYn"));

				// req_project_box update
				reqProjectService.updateReqProjectCloudLimit(customReqProjectVO);

			}
		}

		reqProjectService.reqProjectStatusUpdate04(req.getReqProjectSeq());



		// 승인요청 통지를 위한 결재라인 지정 후 첫번째 결재자 ID정보
        String hiddenUserIdReview = "";
        String currentUserIdReview = "";
        String regUserId = "";

		// 지정된 결재자 정보
		List<Map<String, String>> stepList = req.getApprovalStepList();

		// 현재 결재라인 정보

		int tmpStep = 0;
		boolean tmpStartFlag = false;
		ModelMap map = new ModelMap();
		if(req.getSelectApprv().equals("Y") && req.getApprvPass().equals("Y")) {
			for(int i = 5; i < 9; i++) {
				UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
				CustomReqCustomerVO paramStepInfo = new CustomReqCustomerVO();
				paramStepInfo.setRequestSeq(req.getReqProjectSeq());
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
				paramStepInfo.setRequestSeq(req.getReqProjectSeq());
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
						currentUserIdReview = stepInfo.get("userId");
						hiddenUserIdReview = stepInfo.get("userId");
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


		// 프로젝트 신청자에게 알림

			// 결재자에게 알람
			Map<String,String> keyword = new HashMap<>();
			CustomReqProjectVO projectVo = reqProjectService.getProjectView(req.getReqProjectSeq());
			keyword.put("[[프로젝트명]]", projectVo.getProjectAlias());
			keyword.put("[[관리자명]]",  projectVo.getProjectAdminiStratorName());
			keyword.put("[[URL]]", "http://k-cloud.kepco.co.kr/mng/req/project/workApprovalProjectView?reqProjectSeq="+req.getReqProjectSeq());
			alarmsTemplateService.alarms(23, currentUserIdReview, keyword);

//			CustomApprovalVO stepUser = new CustomApprovalVO();
//			stepUser.setRequestSeq(req.getReqProjectSeq());
//			List<CustomApprovalVO> nextApprovalVoList = approvalService.getApprovalQueueMemberList(stepUser);
//			for (CustomApprovalVO nextApprovVO : nextApprovalVoList) {
//				Map<String, String> alarmkepcoMap = new HashMap<>();
//				alarmkepcoMap.put("gbn", "25");
//				alarmkepcoMap.put("requestSeq", req.getReqProjectSeq());
//				alarmkepcoMap.put("regUserId", projectVo.getRegUserId());	// 프로젝트 신청자
//				alarmkepcoMap.put("apprvNowUserId", nextApprovVO.getUserId());	// 현재 결재자
//				alarmkepcoMap.put("url", "http://k-cloud.kepco.co.kr/mng/req/project/workApprovalProjectView?reqProjectSeq="+req.getReqProjectSeq());
//				alarmsTemplateService.alarmsKepco(alarmkepcoMap);
//			}

			// 한전 연계 시스템 전송
			Map<String, String> alarmkepcoMap = new HashMap<>();
			alarmkepcoMap.put("gbn", "23");
			alarmkepcoMap.put("requestSeq", req.getReqProjectSeq());
			alarmkepcoMap.put("regUserId", projectVo.getRegUserId());
			alarmkepcoMap.put("apprvNextUserId", currentUserIdReview);
			alarmkepcoMap.put("url", "http://k-cloud.kepco.co.kr/mng/req/project/workApprovalProjectView?reqProjectSeq="+req.getReqProjectSeq());
			alarmsTemplateService.alarmsKepco(alarmkepcoMap);
		res = "1";

		map.addAttribute("res", res);
		map.addAttribute("reqProjectSeq", req.getReqProjectSeq());

		return new ResponseEntity<Object>(map, HttpStatus.OK);
	}

}
