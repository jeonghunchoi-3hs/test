package com.ivucenter.cloud.portal.req.project;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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
import org.springframework.web.bind.annotation.RequestParam;

import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;
import com.ivucenter.cloud.portal.alarms.template.AlarmsTemplateService;
import com.ivucenter.cloud.portal.approval.ApprovalService;
import com.ivucenter.cloud.portal.approval.CustomApprovalVO;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;
import com.ivucenter.cloud.portal.cmm.cloud.OssCloudService;
import com.ivucenter.cloud.portal.login.UserSession;
import com.ivucenter.cloud.portal.req.catalogue.ReqCatalogueService;
import com.ivucenter.cloud.portal.req.customer.CustomReqCustomerVO;
import com.ivucenter.cloud.portal.req.customer.ReqCustomerService;
import com.ivucenter.cloud.portal.req.product.CustomReqProductVO;
import com.ivucenter.cloud.portal.req.product.ReqProductService;
import com.ivucenter.cloud.portal.req.user.CustomReqUserVO;
import com.ivucenter.cloud.portal.util.CodeUtil;
import com.ivucenter.cloud.portal.util.DateUtils;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value="/mbr/req/project")
public class MbrReqProjectController {

    private static final Logger logger = LoggerFactory.getLogger(MbrReqProjectController.class);

	@Autowired
	private ApprovalService approvalService;

	@Autowired
	private ReqCustomerService reqCustomerService;

	@Autowired
	private ReqProjectService reqProjectService;

	@Autowired
	private ReqCatalogueService reqCatalogueService;

	@Autowired
	private ReqProductService reqProductService;

	@Autowired
	private AlarmsTemplateService alarmsTemplateService;

	@Autowired
	private OssCloudService ossCloudService;


	// REQ 프로젝트 신청
	@RequestMapping(value = "/reqProjectInsert")
	public ResponseEntity<Object> reqProjectInsert(HttpServletRequest request,
												   ModelMap model,
												   CustomReqProjectVO req,
												   @RequestParam(value="testnet3",required=false) List<String> values1) {
		// 프로젝트 status 상태 값 : 01-작성중(임시저장), 02-처리중, 03- 반려, 04- 처리완료
		String res="";
		ModelMap map = new ModelMap();
		String regUserId = request.getUserPrincipal().getName();

		req.setRegUserId(regUserId);
		req.setProjectManagerId(req.getAdminiStratorId());

		/*
		int reqProjectManagerTypeCheck = reqProjectService.reqProjectManagerTypeCheck(req);
		if(reqProjectManagerTypeCheck > 1){
			res = "3";
			map.addAttribute("res", res);
			map.addAttribute("reqProjectSeq", req.getReqProjectSeq());
			return new ResponseEntity<Object>(map, HttpStatus.OK);
		}

		//결재자
		Date requestSeqdate = new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
		String reqProjectSeq = dateFormat.format(requestSeqdate);
		req.setReqProjectSeq(reqProjectSeq);
		*/

		String []cloudIds = req.getCloudIds().split(",");

		for(int i = 0; i < cloudIds.length; i++){
			req.setCloudId(cloudIds[i]);
			reqProjectService.setProjectCloudForminsert(req);
		}


		//프로젝트 신청
		reqProjectService.setProjectForminsert(req);
		reqProjectService.setProjectAdminiStratorInsert(req);

		//프로젝트 신청후 req_project_manager 테이블 save_yn  N > Y 업데이트
		reqProjectService.setProjectManagerUpdate(req);

		//프로젝트 네트워크 입력
		/*
		 * 프로젝트 별 네트워크 설정 되는 부분 제거됨.
		try{
			String []networks = network.split(",");
			for(int i=0;i<networks.length;i++){
				CustomReqProjectVO netVo = new CustomReqProjectVO();
				String []reqnet = networks[i].split(":");
				netVo.setReqProjectSeq(req.getReqProjectSeq());
				netVo.setNetDfltKind(reqnet[0]);
				netVo.setNetDfltKindName(reqnet[1]);
				netVo.setSelectFlag(reqnet[2]);
				netVo.setRegUserId(regUserId);
				reqProjectService.setProjectNetinsert(netVo);
			}
		}catch(Exception e){
		}
		 */

		/*
		//1차 승인 예정자
        String hiddenUserIdReview = req.getHiddenUserIdReview();
        //2차 승인 예정자
		String hiddenUserIdApprove = req.getHiddenUserIdApprove();

		List<CustomReqCustomerVO> getApprovalModelSteplist = reqCatalogueService.getApprovalModelSteplistProject();

		//3차 4차 5차 승인예정자
		List<CustomReqCustomerVO> getApprovalUserList = reqCatalogueService.getApprovalUserList();

		for(CustomReqCustomerVO customerVO : getApprovalModelSteplist) {
			CustomReqCustomerVO appmodelstep = new CustomReqCustomerVO();
			appmodelstep.setRequestSeq(req.getReqProjectSeq());
			appmodelstep.setStepId(customerVO.getStepId());
			appmodelstep.setModelId(customerVO.getModelId());
			appmodelstep.setStepName(customerVO.getStepName());
			appmodelstep.setStepLevel(customerVO.getStepLevel());
			appmodelstep.setLeftStepId(customerVO.getLeftStepId());
			appmodelstep.setRightStepId(customerVO.getRightStepId());

			if(appmodelstep.getStepLevel().equals("1")){
				appmodelstep.setApprvState(CodeUtil.CMM_CODE_APPRV_PROCESSING);
				appmodelstep.setApprvScheduleUserId(hiddenUserIdReview);
			}else if(appmodelstep.getStepLevel().equals("2")){
				appmodelstep.setApprvState(CodeUtil.CMM_CODE_APPRV_WAITING);
				appmodelstep.setApprvScheduleUserId(hiddenUserIdApprove);
			}else if(appmodelstep.getStepLevel().equals("3")){
				appmodelstep.setApprvScheduleUserId(getApprovalUserList.get(0).getUserId());
				appmodelstep.setApprvState(CodeUtil.CMM_CODE_APPRV_WAITING);
			}else if(appmodelstep.getStepLevel().equals("4")){
				appmodelstep.setApprvScheduleUserId(getApprovalUserList.get(1).getUserId());
				appmodelstep.setApprvState(CodeUtil.CMM_CODE_APPRV_WAITING);
			}else if(appmodelstep.getStepLevel().equals("5")){
				appmodelstep.setApprvScheduleUserId(getApprovalUserList.get(2).getUserId());
				appmodelstep.setApprvState(CodeUtil.CMM_CODE_APPRV_WAITING);
			}else{
				appmodelstep.setApprvState(CodeUtil.CMM_CODE_APPRV_WAITING);
			}
			reqCatalogueService.setSrApprovalStepinsert2(appmodelstep);
		}


		// 프로젝트 신청시 결재라인 등록
		CustomReqCatalogueVO getProjectId = reqCatalogueService.getProjectId(req.getReqProjectSeq());

		// 프로젝트 결재자 리스트
		List<CustomReqCustomerVO> getApprovalModelMemberlist = reqCatalogueService.getApprovalModelMemberlistProject();
		for(int i=0;i<getApprovalModelMemberlist.size();i++){
			CustomReqCustomerVO appmember = new CustomReqCustomerVO();
			CustomReqOrderVO ordervo = new CustomReqOrderVO();

			appmember.setRequestSeq(req.getReqProjectSeq());
			appmember.setStepId(getApprovalModelMemberlist.get(i).getStepId());
			appmember.setUserId(getApprovalModelMemberlist.get(i).getUserId());
			appmember.setApprvAuthFlag(getApprovalModelMemberlist.get(i).getApprvAuthFlag());
			appmember.setMailRecvFlag(getApprovalModelMemberlist.get(i).getMailRecvFlag());
			appmember.setSmsRecvFlag(getApprovalModelMemberlist.get(i).getSmsRecvFlag());
			appmember.setPushRecvFlag(getApprovalModelMemberlist.get(i).getPushRecvFlag());

			if(appmember.getStepId().equals("WF1000A0") && hiddenUserIdReview !=null){
				appmember.setUserId(hiddenUserIdReview);
				ordervo.setUserId(hiddenUserIdReview);
			}
			if(appmember.getStepId().equals("WF1000B0") && hiddenUserIdApprove !=null){
				appmember.setUserId(hiddenUserIdApprove);
				ordervo.setUserId(hiddenUserIdApprove);
			}
			ordervo.setOrderNo(req.getReqProjectSeq());

			//1차 2차 승인자 체크후 insert
			int reviewChk = reqCatalogueService.reviewChk(ordervo);
			int approveChk = reqCatalogueService.approveChk(ordervo);

			if(reviewChk == 0 && appmember.getStepId().equals("WF1000A0")){
				reqCatalogueService.setSrApprovalMemberinsert2(appmember);
			}else if(approveChk == 0 && appmember.getStepId().equals("WF1000B0")){
				reqCatalogueService.setSrApprovalMemberinsert2(appmember);
			}else if(!appmember.getStepId().equals("WF1000A0") && !appmember.getStepId().equals("WF1000B0"))  {
				reqCatalogueService.setSrApprovalMemberinsert2(appmember);
			}
		}
		*/
		// 2020.05.25(장중일) - 신규 결재라인 등록 부분

		//알람필요변수 1,2차 담당자
		String currentUserIdReview = "";
        String hiddenUserIdReview = "";
		//String hiddenUserIdApprove = req.getHiddenUserIdApprove();

		// 지정된 결재자 정보
		List<Map<String, String>> stepList = req.getApprovalStepList();
		// 결재라인 정보
		List<CustomReqCustomerVO> getApprovalModelSteplist = reqCatalogueService.getApprovalModelSteplistProject();

		int tmpStep = 0;
		boolean tmpStartFlag = false;
		if(req.getSelectApprv().equals("Y") && req.getApprvPass().equals("Y")) {
			for(CustomReqCustomerVO customerVO : getApprovalModelSteplist) {
				UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
				CustomReqCustomerVO paramStepInfo = new CustomReqCustomerVO();
				paramStepInfo.setRequestSeq(req.getReqProjectSeq());
				paramStepInfo.setStepId(customerVO.getStepId());
				paramStepInfo.setModelId(customerVO.getModelId());
				paramStepInfo.setStepName(customerVO.getStepName());
				paramStepInfo.setStepLevel(customerVO.getStepLevel());
				paramStepInfo.setLeftStepId(customerVO.getLeftStepId());
				paramStepInfo.setRightStepId(customerVO.getRightStepId());



				if(tmpStep < 4) {
					paramStepInfo.setApprvUserId(userSession.getUsername());
					paramStepInfo.setApprvUserName(userSession.getNickname());
					paramStepInfo.setApprvScheduleUserId(userSession.getUsername());
					paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_COMPLETED);
				} else {
					if(tmpStep == 4) {
						paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_UNASSIGNED);
					} else {
						paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_WAITING);
					}
				}
				tmpStep++;
				reqCatalogueService.setSrApprovalStepinsert2(paramStepInfo);
			}
		} else {
			for(CustomReqCustomerVO customerVO : getApprovalModelSteplist) {
				HashMap<String, String> stepInfo = (HashMap<String, String>) stepList.get(tmpStep);

				CustomReqCustomerVO paramStepInfo = new CustomReqCustomerVO();
				paramStepInfo.setRequestSeq(req.getReqProjectSeq());
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
						paramStepInfo.setApprvScheduleUserId(stepInfo.get("userId"));
						currentUserIdReview = stepInfo.get("userId");
						hiddenUserIdReview = stepInfo.get("userId");
					}

				} else if( paramStepInfo.getStepLevel().equals("2") ) {
					if( tmpStartFlag ) {
						paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_PROCESSING);
						paramStepInfo.setApprvScheduleUserId(stepInfo.get("userId"));
					} else {
						paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_WAITING);
						paramStepInfo.setApprvScheduleUserId(stepInfo.get("userId"));
						hiddenUserIdReview = stepInfo.get("userId");
					}

				} else if(paramStepInfo.getStepLevel().equals("3")){
					paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_WAITING);
					paramStepInfo.setApprvScheduleUserId(stepInfo.get("userId"));

				} else if(paramStepInfo.getStepLevel().equals("4")){
					paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_WAITING);
					paramStepInfo.setApprvScheduleUserId(stepInfo.get("userId"));

				} else {
					paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_WAITING);
				}
				reqCatalogueService.setSrApprovalStepinsert2(paramStepInfo);

				if(tmpStep < 3) { tmpStep++; }
			}
		}


		// 프로젝트 신청자에게 알림
		CustomReqProjectVO projectVo = reqProjectService.getProjectView(req.getReqProjectSeq());
		Map<String,String> keywordMap = new HashMap<>();
		keywordMap.put("[[프로젝트명]]", projectVo.getProjectAlias());
		keywordMap.put("[[관리자명]]",  projectVo.getProjectAdminiStratorName());
		keywordMap.put("[[URL]]","http://k-cloud.kepco.co.kr/mbr/req/project/projectApproveView.do?reqProjectSeq="+req.getReqProjectSeq());
		// 신청자에게 알람
		alarmsTemplateService.alarms(20, regUserId, keywordMap);
		// 결재자에게 알람
		alarmsTemplateService.alarms(23, currentUserIdReview, keywordMap);
		// 한전 연계 시스템 전송
		Map<String, String> alarmkepcoMap = new HashMap<>();
		alarmkepcoMap.put("gbn", "20");
		alarmkepcoMap.put("requestSeq", req.getReqProjectSeq());
		alarmkepcoMap.put("regUserId", regUserId);	// 프로젝트 신청자
		alarmkepcoMap.put("apprvNextUserId", currentUserIdReview);	// 다음 결재자
		alarmkepcoMap.put("url", "http://k-cloud.kepco.co.kr/mbr/req/project/projectApproveView.do?reqProjectSeq="+req.getReqProjectSeq());
		alarmsTemplateService.alarmsKepco(alarmkepcoMap);

		res = "1";
		map.addAttribute("res", res);
		map.addAttribute("reqProjectSeq", req.getReqProjectSeq());

		return new ResponseEntity<Object>(map, HttpStatus.OK);
	}

	// REQ 프로젝트 신청 임시저장
	@RequestMapping(value = "/reqProjectTempInsert")
	public ResponseEntity<Object> reqProjectTempInsert(HttpServletRequest request, ModelMap model, CustomReqProjectVO req) {
		// 프로젝트 status 상태 값 : 01-작성중(임시저장), 02-처리중, 03- 반려, 04- 처리완료

		String regUserId = request.getUserPrincipal().getName();

		req.setRegUserId(regUserId);
		req.setProjectManagerId(req.getAdminiStratorId());


		String []cloudIds = req.getCloudIds().split(",");

		for(int i = 0; i < cloudIds.length; i++){
			req.setCloudId(cloudIds[i]);
			reqProjectService.setProjectCloudForminsert(req);
		}

		//프로젝트 신청
		reqProjectService.setProjectForminsert(req);
		reqProjectService.setProjectAdminiStratorInsert(req);

		//프로젝트 신청후 req_project_manager 테이블 save_yn  N > Y 업데이트
		reqProjectService.setProjectManagerUpdate(req);


		ModelMap map = new ModelMap();
		map.addAttribute("res", "1");
		map.addAttribute("reqProjectSeq", req.getReqProjectSeq());

		return new ResponseEntity<Object>(map, HttpStatus.OK);
	}

	// REQ 변경
	// 신청 프로젝트 정보 수정화면 상세조회
	@RequestMapping(value = "/projectDetail")
	public ResponseEntity<Object> projectDetail(ModelMap model, CustomReqProjectVO req) {

		CustomReqProjectVO res = reqProjectService.getProjectWrite(req.getReqProjectSeq());
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	// REQ 프로젝트 정보 수정
	@RequestMapping(value = "/projectModify")
	public ResponseEntity<String> projectModify(ModelMap model, CustomReqProjectVO req) {

		UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		req.setUserId(userSession.getUsername());

		int chkval =  reqProjectService.reqProjectManagerTypeCheck(req);
		if(chkval >= 1) {
			reqProjectService.projectAdminiStratorUpdate(req);
		}else {
			reqProjectService.projectAdminiStratorInsert(req);
		}


		String []cloudIds = req.getCloudIds().split(",");

		for(int i = 0; i < cloudIds.length; i++){

			req.setCloudId(cloudIds[i]);
			int projectCloudChk = reqProjectService.reqProjectCloudChk(req);

			if(projectCloudChk == 0) {
				reqProjectService.setProjectCloudForminsert(req);
			}
		}

		String res = reqProjectService.projectUpdate(req);

		return new ResponseEntity<String>(res, HttpStatus.OK);
	}

	// REQ 프로젝트 재신청 수정
	@RequestMapping(value = "/projectReInsert")
	public ResponseEntity<String> projectReModify(ModelMap model, CustomReqProjectVO req) {

		UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		req.setUserId(userSession.getUsername());

		int chkval =  reqProjectService.reqProjectManagerTypeCheck(req);
		if(chkval >= 1) {
			reqProjectService.projectAdminiStratorUpdate(req);
		}else {
			reqProjectService.projectAdminiStratorInsert(req);
		}
		String res = reqProjectService.projectUpdate(req);

		// 2020.05.25(장중일) - 신규 결재라인 등록 부분
		//알람필요변수 1,2차 담당자
		String hiddenUserIdReview = "";
		String currentUserIdReview = "";
		//String hiddenUserIdApprove = req.getHiddenUserIdApprove();

		// 지정된 결재자 정보
		List<Map<String, String>> stepList = req.getApprovalStepList();
		// 결재라인 정보
		List<CustomReqCustomerVO> getApprovalModelSteplist = reqCatalogueService.getApprovalModelSteplistProject();

		int tmpStep = 0;
		boolean tmpStartFlag = false;
		reqCatalogueService.deleteApprovalStep(req);
		for(CustomReqCustomerVO customerVO : getApprovalModelSteplist) {
			HashMap<String, String> stepInfo = (HashMap<String, String>) stepList.get(tmpStep);
			CustomReqCustomerVO paramStepInfo = new CustomReqCustomerVO();
			paramStepInfo.setRequestSeq(req.getReqProjectSeq());
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
					paramStepInfo.setApprvScheduleUserId(stepInfo.get("userId"));
					currentUserIdReview = stepInfo.get("userId");
					hiddenUserIdReview = stepInfo.get("userId");
				}

			} else if( paramStepInfo.getStepLevel().equals("2") ) {
				if( tmpStartFlag ) {
					paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_PROCESSING);
					paramStepInfo.setApprvScheduleUserId(stepInfo.get("userId"));
				} else {
					paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_WAITING);
					paramStepInfo.setApprvScheduleUserId(stepInfo.get("userId"));
					hiddenUserIdReview = stepInfo.get("userId");
				}

			} else if(paramStepInfo.getStepLevel().equals("3")){
				paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_WAITING);
				paramStepInfo.setApprvScheduleUserId(stepInfo.get("userId"));

			} else if(paramStepInfo.getStepLevel().equals("4")){
				paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_WAITING);
				paramStepInfo.setApprvScheduleUserId(stepInfo.get("userId"));

			} else {
				paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_WAITING);
			}

			reqCatalogueService.setSrApprovalStepinsert2(paramStepInfo);

			if(tmpStep < 3) { tmpStep++; }
		}
		/*
		//재신청 스탭 초기화
		res = reqProjectService.srApprovalStepUpdate(req);
        //1스탭  apprv_state = APPRV_PROCESSING 상태값 변경, 1차 결재자 업데이트
		res = reqProjectService.srApprovalStepApprv1StateUpdate(req);
        //2스탭 a2차 결재자 업데이트
		res = reqProjectService.srApprovalStepApprv2StateUpdate(req);
		*/
		//req_project status_flag 02(진행중) 변경
		res = reqProjectService.reqProjectStatusUpdate(req);

		// 프로젝트 신청자에게 알림
		String regUserId = userSession.getUsername();

		CustomReqProjectVO projectVo = reqProjectService.getProjectView(req.getReqProjectSeq());
		Map<String,String> keywordMap = new HashMap<>();
		keywordMap.put("[[프로젝트명]]", projectVo.getProjectAlias());
		keywordMap.put("[[관리자명]]",  projectVo.getProjectAdminiStratorName());
		keywordMap.put("[[URL]]", "http://k-cloud.kepco.co.kr/mbr/req/project/projectApproveView.do?reqProjectSeq="+req.getReqProjectSeq());
		// 신청자에게 알람
		alarmsTemplateService.alarms(20, regUserId, keywordMap);
		// 결재자에게 알람
		alarmsTemplateService.alarms(23, hiddenUserIdReview, keywordMap);
		// 한전 연계 시스템 전송
		Map<String, String> alarmkepcoMap = new HashMap<>();
		alarmkepcoMap.put("gbn", "20");
		alarmkepcoMap.put("requestSeq", req.getReqProjectSeq());
		alarmkepcoMap.put("regUserId", projectVo.getRegUserId());	// 프로젝트 신청자
		alarmkepcoMap.put("apprvNextUserId", currentUserIdReview);	// 다음 결재자
		alarmkepcoMap.put("url", "http://k-cloud.kepco.co.kr/mbr/req/project/projectApproveView.do?reqProjectSeq="+req.getReqProjectSeq());
		alarmsTemplateService.alarmsKepco(alarmkepcoMap);

		return new ResponseEntity<String>(res, HttpStatus.OK);
	}

	// REQ 프로젝트 정보 삭제
	@RequestMapping(value = "/reqProjectDelete")
	public ResponseEntity<String> reqProjectDelete(ModelMap model, CustomReqProjectVO req) {

		String res = reqProjectService.reqProjectDelete(req);
		res = reqProjectService.reqProjectManagerDelete(req);
		res = reqProjectService.srApprovalStepDelete(req);
		res = reqProjectService.cmmFileDelete(req);

		return new ResponseEntity<String>(res, HttpStatus.OK);
	}

	//프로젝트명 중복체크
	@RequestMapping(value = "/projectNamecheck", method = RequestMethod.GET)
	public ResponseEntity<Object> ProjectNameCheck(HttpServletRequest request, ModelMap model) {

		//projectNamecheck
		//reqProjectInsert

		String projectName =  request.getParameter("projectName");
		CustomReqProjectVO projectvo = new CustomReqProjectVO();
		projectvo.setProjectName(projectName);
		String res="";
		int chkval = reqProjectService.setProjectNamechk(projectvo);
		if(chkval == 0){

			res= CodeUtil.NAME_CHK_SUCCESS;
		}else{
			res= CodeUtil.NAME_CHK_FAIL;
		}
		model.addAttribute("namechktext", res);
		model.addAttribute("chkval", chkval);
		model.addAttribute("projectName", projectName);

		log.debug("res : " + res);
		log.debug("chkval : " + chkval);
		log.debug("projectName : " + projectName);

		return new ResponseEntity<Object>(model, HttpStatus.OK);
	}

	//프로젝트 승인자 관리자 체크
	@RequestMapping(value = "/projectManagerApproveCheck", method = RequestMethod.GET)
	public ResponseEntity<Object> projectManagerApproveCheck(HttpServletRequest request, ModelMap model) {

		String reqProjectSeq = request.getParameter("reqProjectSeq");

		CustomReqProjectVO projectvo = new CustomReqProjectVO();
		projectvo.setReqProjectSeq(reqProjectSeq);

		int managerChkval = reqProjectService.setProjectManagerChk(projectvo);
		int approve1Chkval = reqProjectService.setProjectApprove1chk(projectvo);
		int approve2Chkval = reqProjectService.setProjectApprove2chk(projectvo);
		int managerTypeChkval = reqProjectService.setManagerTypechk(projectvo);

		model.addAttribute("managerTypeChkval", managerTypeChkval);
		model.addAttribute("managerChkval", managerChkval);
		model.addAttribute("approve1Chkval", approve1Chkval);
		model.addAttribute("approve2Chkval", approve2Chkval);
		model.addAttribute("projectName", reqProjectSeq);

		return new ResponseEntity<Object>(model, HttpStatus.OK);
	}

	//  OSS 프로젝트 정보 수정
	@RequestMapping(value = "/okProjectModify")
	public ResponseEntity<String> okProjectModify(ModelMap model, CustomReqProjectVO req) {

		UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		req.setUserId(userSession.getUsername());
		int chkval =  reqProjectService.ossProjectManagerTypeCheck(req);
		if(chkval >= 1) {
			reqProjectService.okOssProjectAdminiStratorUpdate(req);
		}else {
			reqProjectService.okOssProjectAdminiStratorInsert(req);
		}

		reqProjectService.okProjectHistoryInsert(req);
		reqProjectService.okProjectBoxUpdate(req);
		String res = reqProjectService.okProjectUpdate(req);

		return new ResponseEntity<String>(res, HttpStatus.OK);
	}


	// 프로젝트 > 프로젝트 현황(신청)
	@RequestMapping(value = "/projectList", method = RequestMethod.GET , produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> projectList(CustomReqProjectVO req, HttpServletRequest request){
		String res = "";
		req.setUserId(request.getUserPrincipal().getName());

		res = reqProjectService.getProjectList(req);
		if(res.equals("")){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	 // 프로젝트 > 프로젝트 승인(결재)
	@RequestMapping(value = "/projectApproveList", method = RequestMethod.GET , produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> projectApproveList(CustomReqProjectVO req, HttpServletRequest request){
		log.info("=== projectApproveList Controller ===");

		String res = "";
		req.setUserId(request.getUserPrincipal().getName());
		res = reqProjectService.getProjectApproveList(req);

		if(res.equals("")) {
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}


	//프로젝트 멤버 등록
	@RequestMapping(value = "/projectMemberImsiInsert")
	public ResponseEntity<String> projectMemberImsiInsert(CustomReqProjectVO req) {
		//String userId =  request.getParameter("userId");
		log.debug(" req.getUserId() : " + req.getUserId());
		log.debug(" req.getProjectId() : " + req.getProjectId());

		req.setProjectMemberRole("PROJMBRROLE_READ");
		reqProjectService.setProjectMemberInsert(req);

		 String memList = "";
	    try {
	        JsonObject jsonResponse = new JsonObject();
//	        Gson gson = new Gson();

	        jsonResponse.addProperty("userId", req.getUserId());
	        jsonResponse.addProperty("projectId", req.getProjectId());
	        jsonResponse.addProperty("userName", req.getUserName());
	        memList = jsonResponse.toString();
	    } catch (JsonIOException e) {
	    	logger.error("JSON 처리 중 오류 발생");
	    }
		//String memList = reqProjectService.projectMemberlist(req);
		log.debug(" memList : " + memList);
		return new ResponseEntity<String>(memList, HttpStatus.OK);
	}


	//프로젝트 신청현황 목록 조회
	@RequestMapping(value = "/projectStatusList", method = RequestMethod.GET)
	public ResponseEntity<Object> projectStatusList(CustomReqProjectVO req){

		String apprvCodeKeyId="APPRV_STATE";
  		String requestCodeKeyId="REQUEST_TYPE";
  		req.setApprvCodeKeyId(apprvCodeKeyId);
  		req.setRequestCodeKeyId(requestCodeKeyId);
//  	log.debug("CustomerId : " + req.getCustomerId());
		String res = reqProjectService.projectStatusList(req);

		if(res.equals("")){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}


	// PM 설정 대상 리스트
	@RequestMapping(value = "/pmPopList", method = RequestMethod.GET)
	public ResponseEntity<Object> pmPopList(CustomReqProjectVO req){

		List<CustomReqUserVO> res = reqProjectService.pmPopList(req);

		HashMap<String, Object> map = new HashMap<>();
		map.put("pmPopList", res);
		map.put("projectId", req.getProjectId());

//		log.debug("popList : " + res.size());
//		log.debug("projectId : " + req.getProjectId());

		return new ResponseEntity<Object>(map, HttpStatus.OK);
	}

	// PM 교체전 승인스텝 확인
	@RequestMapping(value = "/pmVmchk", method = RequestMethod.GET)
	public ResponseEntity<String> pmVmchk(CustomReqProjectVO req){

		int pmVmchk = reqProjectService.getAppPmmemberCnt(req);
		String res = (pmVmchk==0) ? "0" : "1";

		return new ResponseEntity<String>(res, HttpStatus.OK);
	}

	/**
	 * 상세 불러오기
	 */
	@RequestMapping(value = "/detail", method = RequestMethod.POST)
	public ResponseEntity<Object> mbrBbsNoticeDetail(String reqProjectSeq) {
		log.info("=== mbrProjectStatusDetail Controller ===");

		CustomReqProjectVO res = reqProjectService.detail(reqProjectSeq);

		if(res == null){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}

		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	/**
	 *프로젝트 승인스텝 업데이트(승인버튼 클릭)
	 */

	@RequestMapping(value = "/stepUpdate", method = { RequestMethod.GET, RequestMethod.POST })
	public ResponseEntity<String> mngStepUpdate(CustomReqProductVO req, Model model, Principal principal) {
		String res = "";

		// 현재 스탭 상태 변경
		req.setModUserId(req.getRegUserId());
		req.setApprvState(CodeUtil.CMM_CODE_APPRV_COMPLETED);
		res = reqProductService.stepUpdate(req);

		String rightStepId = req.getRightStepId();
		if (rightStepId != "*") { // 최종 스탭이 아닐경우 (최종 스탭은 MNG에서 처리)

			//List<CustomReqCustomerVO> getApprovalModelMemberlist3 = reqCatalogueService.getApprovalNextMemberlistProjectStep(req);
			CustomApprovalVO stepUser = new CustomApprovalVO();
			stepUser.setStepLevel(req.getStepLevel());
			stepUser.setRequestSeq(req.getRequestSeq());
			CustomReqProjectVO projectVo = reqProjectService.getProjectView(req.getRequestSeq());

			// 한전 연계 시스템 전송
			CustomApprovalVO ApprovalVo = approvalService.getNextScheduleUser(stepUser);

			Map<String, String> alarmkepcoMap = new HashMap<>();
			alarmkepcoMap.put("gbn", "23");
			alarmkepcoMap.put("requestSeq", req.getRequestSeq());
			alarmkepcoMap.put("regUserId", projectVo.getRegUserId());	// 프로젝트 신청자
			alarmkepcoMap.put("apprvNowUserId", ApprovalVo.getApprvUserId());	// 현재 결재자
			if(! req.getStepLevel().equals("4")) {
				alarmkepcoMap.put("apprvNextUserId", ApprovalVo.getUserId());	// 다음 결재자

			}

			alarmkepcoMap.put("url", "http://k-cloud.kepco.co.kr/mbr/req/project/projectApproveView.do?reqProjectSeq="+req.getRequestSeq());
			alarmsTemplateService.alarmsKepco(alarmkepcoMap);
			List<CustomApprovalVO> nextApprovalVoList = approvalService.getNextScheduleUserList(stepUser);
			for (CustomApprovalVO nextApprovVO : nextApprovalVoList) {
				//CustomReqProjectVO projectVo = reqProjectService.getProjectView(req.getRequestSeq());
				Map<String,String> keywordMap = new HashMap<>();
				keywordMap.put("[[프로젝트명]]", req.getProjectAlias());
				keywordMap.put("[[URL]]", "http://k-cloud.kepco.co.kr/mbr/req/project/projectApproveView.do?reqProjectSeq="+req.getRequestSeq());
				alarmsTemplateService.alarms(23, nextApprovVO.getUserId(), keywordMap);
				if(req.getStepLevel().equals("4")) {
					alarmkepcoMap = new HashMap<>();
					alarmkepcoMap.put("gbn", "24");
					alarmkepcoMap.put("requestSeq", req.getRequestSeq());
					alarmkepcoMap.put("regUserId", projectVo.getRegUserId());	// 프로젝트 신청자
					alarmkepcoMap.put("apprvNowUserId", nextApprovVO.getUserId());	// 현재 결재자
					alarmkepcoMap.put("url", "http://k-cloud.kepco.co.kr/mng/req/project/workApprovalProjectView?reqProjectSeq="+req.getRequestSeq());
					alarmsTemplateService.alarmsKepco(alarmkepcoMap);
				}
			}



			// 다음 스탭 상태 변경
			if(req.getStepLevel().equals("4")) {
				req.setApprvDescription("(NULL)");
				req.setApprvState(CodeUtil.CMM_CODE_APPRV_UNASSIGNED);
				int stepLevel = Integer.parseInt(req.getStepLevel());
				req.setStepLevel(String.valueOf(stepLevel + 1));
			} else {
				req.setApprvDescription("(NULL)");
				req.setApprvState(CodeUtil.CMM_CODE_APPRV_PROCESSING);
				int stepLevel = Integer.parseInt(req.getStepLevel());
				req.setStepLevel(String.valueOf(stepLevel + 1));
			}


			res = reqProductService.stepUpdateUser(req);
	}

		return new ResponseEntity<String>(res, HttpStatus.OK);
	}


	/**
	 * 프로젝트  미승인(반려) 프로세서
	 */
	@RequestMapping(value = "/rejectedUpdate", method = { RequestMethod.GET, RequestMethod.POST })
	public ResponseEntity<String> mngRejectedUpdate(CustomReqCustomerVO req, Model model) throws Exception {

		UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();

		String res = "";

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
			param.put("RequestSeq", req.getRequestSeq());

			reqProjectService.deleteReqProjectCloud(param);
		}


		String stepLevel = req.getStepLevel();
		req.setModUserId(req.getRegUserId());
		req.setApprvState(CodeUtil.CMM_CODE_APPRV_REJECT);
		req.setStepLevel(stepLevel);
		req.setApprvUserId(userSession.getUsername());
		req.setApprvUserName(userSession.getNickname());

		res = reqCustomerService.stepUpdate(req);
		CustomApprovalVO stepUser = new CustomApprovalVO();
		stepUser.setStepLevel(req.getStepLevel());
		stepUser.setRequestSeq(req.getRequestSeq());


		CustomApprovalVO ApprovalVo = approvalService.getNextScheduleUser(stepUser);
		Map<String,String> keywordMap = new HashMap<>();
		CustomReqProjectVO projectVo = reqProjectService.getProjectView(req.getRequestSeq());

		keywordMap.put("[[프로젝트명]]", projectVo.getProjectAlias());
		keywordMap.put("[[관리자명]]", projectVo.getProjectAdminiStratorName());
		keywordMap.put("[[반려사유]]", req.getApprvDescription());
		keywordMap.put("[[URL]]","http://k-cloud.kepco.co.kr/mbr/req/project/projectApproveView.do?reqProjectSeq="+req.getRequestSeq());
		alarmsTemplateService.alarms(22, req.getRegUserId(), keywordMap);
		// 한전 연계 시스템 전송
		Map<String, String> alarmkepcoMap = new HashMap<>();
		alarmkepcoMap.put("apprvNextUserId", ApprovalVo.getApprvUserId());	// 현재 결재자
		alarmkepcoMap.put("gbn", "22");
		alarmkepcoMap.put("requestSeq", req.getRequestSeq());
		alarmkepcoMap.put("regUserId", projectVo.getRegUserId());	// 프로젝트 신청자
		alarmkepcoMap.put("apprvNowUserId", req.getApprvUserId());	// 현재 결재자
		alarmkepcoMap.put("url", "http://k-cloud.kepco.co.kr/mbr/req/project/projectApproveView.do?reqProjectSeq="+req.getRequestSeq());
		alarmsTemplateService.alarmsKepco(alarmkepcoMap);

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

	// 상신 취소
	@RequestMapping(value = "/cancelledUpdate", method = { RequestMethod.GET, RequestMethod.POST })
	public ResponseEntity<String> mngCancelledUpdate(CustomReqCustomerVO req, Model model) throws Exception {

		UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();

		String res = "";

		CustomReqProjectVO customReqProjectVO = new CustomReqProjectVO();
		customReqProjectVO.setCompleteFlag("Y");
		customReqProjectVO.setReqProjectSeq(req.getRequestSeq());
		customReqProjectVO.setModUserId(userSession.getUsername());
		List<CustomOssCloudVO> reqProjectCloudList = ossCloudService.getOssProjectCloudListByReqProjectSeq(req.getRequestSeq());

		if(reqProjectCloudList.size() > 0){
			reqProjectService.cancelledProject(customReqProjectVO);

			Map<String, Object> param = new HashMap<String, Object>();
			List<String> ids = reqProjectCloudList.stream().map(e -> e.getCloudId()).collect(Collectors.toCollection(ArrayList::new));
			String[] cloudIds = ids.stream().toArray(String[]::new);
			param.put("cloudIds", cloudIds);
			param.put("RequestSeq", req.getRequestSeq());

			reqProjectService.deleteReqProjectCloud(param);
		}


		String stepLevel = req.getStepLevel();
		req.setModUserId(req.getRegUserId());
		req.setApprvState(CodeUtil.CMM_CODE_APPRV_CANCELLED);
		req.setStepLevel(stepLevel);
		req.setApprvUserId(userSession.getUsername());
		req.setApprvUserName(userSession.getNickname());

		res = reqCustomerService.stepUpdate(req);
		CustomApprovalVO stepUser = new CustomApprovalVO();
		stepUser.setStepLevel(req.getStepLevel());
		stepUser.setRequestSeq(req.getRequestSeq());

		return new ResponseEntity<String>(res, HttpStatus.OK);
	}

	// 프로젝트 결재자 삭제
	@RequestMapping(value = "/projectApproveUserDelete")
	public ResponseEntity<String> projectApproveUserDelete(CustomReqProjectVO req){

		int resCount = 	reqProjectService.deleteProjectApproveUserDelete(req);
		String res="";
		if(resCount==0){
			res="0";
		}else{
			res="1";
		}
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}

	@RequestMapping(value = "/projectManagerUserDelete")
	public ResponseEntity<String> projectManagerUserUpdate(CustomReqProjectVO req){

		String res="";
		int ossProjectManagerTypeCheckOne = reqProjectService.reqProjectManagerTypeCheckOne(req);
		if(ossProjectManagerTypeCheckOne == 1) {
			res="2";
		}else {
			int resCount = reqProjectService.projectManagerUserDelete(req);
			res="1";
		}
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}

	@RequestMapping(value = "/projectManagerTypeUdate")
	public ResponseEntity<String> projectManagerTypeUdate(CustomReqProjectVO req){

	    int resCount = reqProjectService.projectManagerTypeUdate(req);
		return new ResponseEntity<String>( (resCount==0) ? "0":"1" , HttpStatus.OK);
	}

	@RequestMapping(value = "/ossProjectManagerUserDelete")
	public ResponseEntity<String> ossProjectManagerUserDelete(CustomReqProjectVO req){
		String res="";
		int ossProjectManagerTypeCheckOne = reqProjectService.ossProjectManagerTypeCheckOne(req);
		if(ossProjectManagerTypeCheckOne == 1) {
			res="2";
		}else {
			int resCount = reqProjectService.ossProjectManagerUserDelete(req);
			if(resCount==0){
				res="0";
			}else{
				res="1";
			}
		}

		return new ResponseEntity<String>(res, HttpStatus.OK);
	}

	@RequestMapping(value = "/ossProjectManagerTypeUdate")
	public ResponseEntity<String> ossProjectManagerTypeUdate(CustomReqProjectVO req){

	    int resCount = reqProjectService.ossProjectManagerTypeUdate(req);
		return new ResponseEntity<String>( (resCount==0) ? "0":"1" , HttpStatus.OK);
	}

	//project 해지 신청(회원사 계정)
	@RequestMapping(value = "/projectExpr")
	public ResponseEntity<String> projectExpr(CustomReqProjectVO req) {
//		log.debug("req.getUserId() : " + req.getUserId());
//		log.debug("req.getProjectId() : " + req.getProjectId());

		// 프로젝트에 등록된 상품(VM) 확인
		int vmcnt = reqProjectService.getProjectCatalogueCnt(req);

//		log.debug("vmcnt : " + vmcnt);
		//프로젝트에 등록된 상품 없으면 해지 진행 있으면 해지 불가
		String reqResult = "";
		if(vmcnt==0){
			//프로젝트 해지reqProjectSeq
			Date requestSeqdate = new Date();
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
			String reqProjectSeq = dateFormat.format(requestSeqdate);
			String requestType = "REQTYPE_EXPR";
			String apprvState = "APPRV_PROCESSING";
			String regUserId = req.getUserId();
			String customerId = req.getUserId();
			req.setReqProjectSeq(reqProjectSeq);
			req.setRequestType(requestType);
			req.setApprvState(apprvState);
			req.setRegUserId(regUserId);
			req.setCustomerId(customerId);

			reqResult = reqProjectService.setprojectReqExpr(req);

			// 승인 플로우
			List<CustomReqCustomerVO> getApprovalModelSteplist = reqProjectService.getApprovalModelSteplist();
			for(int i=0;i<getApprovalModelSteplist.size();i++){
				CustomReqCustomerVO appmodelstep = new CustomReqCustomerVO();
				appmodelstep.setRequestSeq(reqProjectSeq);
				appmodelstep.setStepId(getApprovalModelSteplist.get(i).getStepId());
				appmodelstep.setModelId(getApprovalModelSteplist.get(i).getModelId());
				appmodelstep.setStepName(getApprovalModelSteplist.get(i).getStepName());
				appmodelstep.setStepLevel(getApprovalModelSteplist.get(i).getStepLevel());
				appmodelstep.setLeftStepId(getApprovalModelSteplist.get(i).getLeftStepId());
				appmodelstep.setRightStepId(getApprovalModelSteplist.get(i).getRightStepId());

				if(appmodelstep.getStepLevel().equals("1")){
					appmodelstep.setApprvState("APPRV_PROCESSING");
				}else{
					appmodelstep.setApprvState("APPRV_WAITING");
				}

				reqProjectService.setSrApprovalStepinsert(appmodelstep);
			}
			List<CustomReqCustomerVO> getApprovalModelMemberlist = reqProjectService.getApprovalModelMemberlist();
			for(int i=0;i<getApprovalModelMemberlist.size();i++){
				CustomReqCustomerVO appmember = new CustomReqCustomerVO();
				appmember.setRequestSeq(reqProjectSeq);
				appmember.setStepId(getApprovalModelMemberlist.get(i).getStepId());
				appmember.setUserId(getApprovalModelMemberlist.get(i).getUserId());
				appmember.setApprvAuthFlag(getApprovalModelMemberlist.get(i).getApprvAuthFlag());
				appmember.setMailRecvFlag(getApprovalModelMemberlist.get(i).getMailRecvFlag());
				appmember.setSmsRecvFlag(getApprovalModelMemberlist.get(i).getSmsRecvFlag());
				appmember.setPushRecvFlag(getApprovalModelMemberlist.get(i).getPushRecvFlag());

				reqProjectService.setSrApprovalMemberinsert(appmember);
			}

			return new ResponseEntity<String>(reqResult, HttpStatus.OK);
		}

		return new ResponseEntity<String>(reqResult, HttpStatus.OK);
	}



	// 프로젝트 클라우드 추가
		@RequestMapping(value = "/reqProjectUpdate")
		public ResponseEntity<Object> reqProjectUpdate(HttpServletRequest request,
													   ModelMap model,
													   CustomReqProjectVO req,
													   @RequestParam(value="testnet3",required=false) List<String> values1) {
			// 프로젝트 status 상태 값 : 01-작성중(임시저장), 02-처리중, 03- 반려, 04- 처리완료
			String res="";
			ModelMap map = new ModelMap();

			UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			String regUserId = userSession.getUsername();
			req.setRegUserId(regUserId);
			req.setProjectManagerId(req.getAdminiStratorId());

			String []cloudIds = req.getCloudIds().split(",");

			for(int i = 0; i < cloudIds.length; i++){

				req.setCloudId(cloudIds[i]);
				int projectCloudChk = reqProjectService.reqProjectCloudChk(req);

				if(projectCloudChk == 0) {
					reqProjectService.setProjectCloudForminsert(req);
				}
			}

			reqProjectService.reqProjectStatusUpdate(req);

			CustomReqCustomerVO customReqCustomerVO = new CustomReqCustomerVO();
			// sr_approval_step > sr_approval_step_his
			customReqCustomerVO.setRequestSeq(req.getReqProjectSeq());
			customReqCustomerVO.setRegDatetime( DateUtils.convertDateToString(new Date(), "Asia/Seoul", "yyyyMMddHHmm"));

			reqCatalogueService.insertSrApprovalStepHis(customReqCustomerVO);
			reqCatalogueService.deleteSrApprovalStep(customReqCustomerVO);

			//알람필요변수 1,2차 담당자
			String currentUserIdReview = "";
	        String hiddenUserIdReview = "";

			// 지정된 결재자 정보
			List<Map<String, String>> stepList = req.getApprovalStepList();
			// 결재라인 정보
			List<CustomReqCustomerVO> getApprovalModelSteplist = reqCatalogueService.getApprovalModelSteplistProject();

			int tmpStep = 0;
			boolean tmpStartFlag = false;
			if(req.getSelectApprv().equals("Y") && req.getApprvPass().equals("Y")) {
				for(CustomReqCustomerVO customerVO : getApprovalModelSteplist) {
					CustomReqCustomerVO paramStepInfo = new CustomReqCustomerVO();
					paramStepInfo.setRequestSeq(req.getReqProjectSeq());
					paramStepInfo.setStepId(customerVO.getStepId());
					paramStepInfo.setModelId(customerVO.getModelId());
					paramStepInfo.setStepName(customerVO.getStepName());
					paramStepInfo.setStepLevel(customerVO.getStepLevel());
					paramStepInfo.setLeftStepId(customerVO.getLeftStepId());
					paramStepInfo.setRightStepId(customerVO.getRightStepId());



					if(tmpStep < 4) {
						paramStepInfo.setApprvUserId(userSession.getUsername());
						paramStepInfo.setApprvUserName(userSession.getNickname());
						paramStepInfo.setApprvScheduleUserId(userSession.getUsername());
						paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_COMPLETED);
					} else {
						if(tmpStep == 4) {
							paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_UNASSIGNED);
						} else {
							paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_WAITING);
						}
					}
					tmpStep++;
					reqCatalogueService.setSrApprovalStepinsert2(paramStepInfo);
				}
			} else {
				for(CustomReqCustomerVO customerVO : getApprovalModelSteplist) {
					HashMap<String, String> stepInfo = (HashMap<String, String>) stepList.get(tmpStep);

					CustomReqCustomerVO paramStepInfo = new CustomReqCustomerVO();
					paramStepInfo.setRequestSeq(req.getReqProjectSeq());
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
							paramStepInfo.setApprvScheduleUserId(stepInfo.get("userId"));
							currentUserIdReview = stepInfo.get("userId");
							hiddenUserIdReview = stepInfo.get("userId");
						}

					} else if( paramStepInfo.getStepLevel().equals("2") ) {
						if( tmpStartFlag ) {
							paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_PROCESSING);
							paramStepInfo.setApprvScheduleUserId(stepInfo.get("userId"));
						} else {
							paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_WAITING);
							paramStepInfo.setApprvScheduleUserId(stepInfo.get("userId"));
							hiddenUserIdReview = stepInfo.get("userId");
						}

					} else if(paramStepInfo.getStepLevel().equals("3")){
						paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_WAITING);
						paramStepInfo.setApprvScheduleUserId(stepInfo.get("userId"));

					} else if(paramStepInfo.getStepLevel().equals("4")){
						paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_WAITING);
						paramStepInfo.setApprvScheduleUserId(stepInfo.get("userId"));

					} else {
						paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_WAITING);
					}
					reqCatalogueService.setSrApprovalStepinsert2(paramStepInfo);

					if(tmpStep < 3) { tmpStep++; }
				}
			}


			// 프로젝트 신청자에게 알림
			CustomReqProjectVO projectVo = reqProjectService.getProjectView(req.getReqProjectSeq());
			Map<String,String> keywordMap = new HashMap<>();
			keywordMap.put("[[프로젝트명]]", projectVo.getProjectAlias());
			keywordMap.put("[[관리자명]]",  projectVo.getProjectAdminiStratorName());
			keywordMap.put("[[URL]]","http://k-cloud.kepco.co.kr/mbr/req/project/projectApproveView.do?reqProjectSeq="+req.getReqProjectSeq());
			// 신청자에게 알람
			alarmsTemplateService.alarms(20, regUserId, keywordMap);
			// 결재자에게 알람
			alarmsTemplateService.alarms(23, currentUserIdReview, keywordMap);
			// 한전 연계 시스템 전송
			Map<String, String> alarmkepcoMap = new HashMap<>();
			alarmkepcoMap.put("gbn", "20");
			alarmkepcoMap.put("requestSeq", req.getReqProjectSeq());
			alarmkepcoMap.put("regUserId", regUserId);	// 프로젝트 신청자
			alarmkepcoMap.put("apprvNextUserId", currentUserIdReview);	// 다음 결재자
			alarmkepcoMap.put("url", "http://k-cloud.kepco.co.kr/mbr/req/project/projectApproveView.do?reqProjectSeq="+req.getReqProjectSeq());
			alarmsTemplateService.alarmsKepco(alarmkepcoMap);

			res = "1";

			return new ResponseEntity<Object>(res, HttpStatus.OK);
		}

		@RequestMapping(value = "/reqCloudListChk")
		public ResponseEntity<Object> reqCloudListChk(HttpServletRequest request, CustomReqProjectVO req) {
			String res="";

			String []cloudIds = req.getCloudIds().split(",");

			Map<String, Object> param = new HashMap<String, Object>();
			param.put("cloudIds", cloudIds);
			param.put("reqProjectSeq", req.getReqProjectSeq());


			CustomReqProjectVO customReqProjectVO = new CustomReqProjectVO();
			customReqProjectVO.setProgramSeq(req.getReqProjectSeq());

			int ossProjectChkListCount = reqProjectService.ossProjectChkListCount(customReqProjectVO);

			if(ossProjectChkListCount > 0) {
				res = "3";
				return new ResponseEntity<Object>(res, HttpStatus.OK);
			}

			int cloudChkListCount = reqProjectService.reqProjectCloudChkList(param);
				if(cloudIds.length == cloudChkListCount) {
					res = "2";
					return new ResponseEntity<Object>(res, HttpStatus.OK);
				}
				res = "1";
			return new ResponseEntity<Object>(res, HttpStatus.OK);
		}

}
