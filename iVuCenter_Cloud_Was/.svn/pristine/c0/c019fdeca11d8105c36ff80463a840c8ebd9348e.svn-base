package com.ivucenter.cloud.portal.approval;

import java.security.Principal;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ivucenter.cloud.api.openstack.connector.OpenStackRestConnector;
import com.ivucenter.cloud.portal.alarms.template.AlarmsTemplateService;
import com.ivucenter.cloud.portal.bss.adjustment.BssAdjustmentService;
import com.ivucenter.cloud.portal.bss.adjustment.CustomBssAdjustmentVO;
import com.ivucenter.cloud.portal.charge.bill.ChargeBillService;
import com.ivucenter.cloud.portal.charge.bill.CustomChargeBillVO;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;
import com.ivucenter.cloud.portal.cmm.cloud.OssCloudService;
import com.ivucenter.cloud.portal.cmm.user.CmmUserService;
import com.ivucenter.cloud.portal.cmm.user.CustomCmmUserVO;
import com.ivucenter.cloud.portal.login.UserSession;
import com.ivucenter.cloud.portal.util.CodeUtil;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value="/mng/approval/calculate")
public class MngApprovalController {

    private static final Logger logger = LoggerFactory.getLogger(MngApprovalController.class);

	@Autowired
	private ApprovalService service;

	@Autowired
	private ChargeBillService billService;

	@Autowired
	private CmmUserService cmmUserService;

	@Autowired
	private BssAdjustmentService bssAdjustmentService;

	@Autowired
	private AlarmsTemplateService alarmsTemplateService;

	@Autowired
	private OssCloudService ossCloudService;

//	@Autowired	private BbsNoticeService codeService;
	//@Autowired private NhwithService nhwithService;
	//@Autowired private NhwithSendService nhwithSendService;
	//@Autowired private MailTemplateService mailTemplateService;
	//@Autowired private MailQueueService mailQueueService;
	//@Autowired private SmsTemplateService smsTemplateService;
	//@Autowired private SmsQueueService smsQueueService;

	/**
	 * 정산 목록 조회 화면
	 * @param req
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/calApprovalListPage")
	public String calApprovalListPage(CustomChargeBillVO req, Model model){

		model.addAttribute("yearList", service.billYearList(req));

		List<CustomOssCloudVO> getCloudList = ossCloudService.getCloudList();
		model.addAttribute("getCloudList", getCloudList);

		return "mng/approval/calculate/calculateApprvList";
	}


	/**
	 * 정산 목록 조회
	 * @param req
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/calApprovalList", produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> getcalculateList(CustomChargeBillVO req, Model model){

		String res = service.calculateList(req);

		return (res.equals("")) ? new ResponseEntity<Object>(HttpStatus.NO_CONTENT):new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	@RequestMapping(value = "/excel")
	public ModelAndView getcalculateExcel(CustomChargeBillVO req, ModelMap map) {
		map.addAttribute("excel_gbn", "calculateExcel");
		map.addAttribute("excel_title", "작업승인처리_정산승인");
		map.addAttribute("excel_list", service.excel(req));
		return new ModelAndView("productExcelView", map);
	}


	/**
	 * 정산 승인 상세 화면 (승인정보)
	 * @param req
	 * @param model
	 * @param appVo
	 * @param map
	 * @return
	 */
	@RequestMapping(value="/calApprovalDetailPage", produces="text/plain;charset=UTF-8")
	public String calApprovalDetailPage(CustomChargeBillVO req, Model model, CustomApprovalVO appVo, Principal principal){

//		model.addAttribute("customerId", req.getCustomerId());

		if(req.getBillYyyymm()==null){
			req.setBillYyyymm(DateFormatUtils.format(new Date(),"yyyyMM"));
		}
		model.addAttribute("billYyyymm", req.getBillYyyymm());

		// 보정 재정산 여부 확인
		int adjustYn = service.adjustYn(req);
		model.addAttribute("adjustYnCnt", adjustYn);

		// 승인플로우 조회
		String orderNo = req.getBillYyyymm();
		appVo.setOrderNo(orderNo);
		model.addAttribute("orderNo", orderNo);

		String userId = principal.getName();
		appVo.setUserId(userId);
		model.addAttribute("userId", userId);

		Map<String, String> map = new HashMap<String, String>();
		map.put("orderNo", orderNo);
		map.put("userId", userId);

		String stepId = service.getStepId(map);
		model.addAttribute("stepId", stepId);

		String userApprvState ="";
		userApprvState = service.getUserApprvState(map);
		model.addAttribute("userApprvState", userApprvState);

		String flowId = "AFW0060";
		appVo.setFlowId(flowId);

		List<CustomApprovalVO> approvalList = service.approvalList(appVo);
		model.addAttribute("getProjectAppSteplist", approvalList);

		for (int i = 0; i < approvalList.size(); i++) {
			if(approvalList.get(i).getApprvState().equals("APPRV_REJECTED")){
				String inject ="Y";
				model.addAttribute("inject",inject);
			}
		}

		// 승인스텝멤버 유저 아이디 조회
		List<CustomApprovalVO> approvalUserId = service.approvalUserId(appVo);
		model.addAttribute("approvalUserId", approvalUserId);

		List<CustomBssAdjustmentVO> getBillYyyy = bssAdjustmentService.getBillYyyy();
		model.addAttribute("getBillYyyy", getBillYyyy);

		return "mng/approval/calculate/calculateApprvView";
	}


	/**
	 * 정산 상세 내용 조회
	 * @param req
	 * @param model
	 * @param map
	 * @param appVo
	 * @return
	 */
	@RequestMapping(value="/calApprovalDetail", produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> calApprovalDetail(CustomChargeBillVO req, Model model, CustomApprovalVO appVo){

		log.debug(req.getBillYyyymm());
		String res = service.calculateDetailList(req);
		if(res.equals("")){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}


	/**
	 * 정산 승인 요청
	 * @param req
	 * @param model
	 * @param ordervo
	 * @return
	 */
	@RequestMapping(value="/calApprovalRequest")
	public ResponseEntity<Object> calApprovalRequest(CustomChargeBillVO req, Model model, CustomApprovalVO ordervo){


		UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String orderNo = req.getBillYyyymm();
		String res="1";
		ordervo.setOrderNo(orderNo);

		req.setApprvStat("APPRV_PROCESSING");

		//정산승인요청 - bill_master 테이블 apprv_stat 업데이트
		try{
			res = service.reqCalculateApproval(req);
		}catch(Exception e){

            logger.error("calApprovalRequest Exception");

			res = "0";
		}

		//관리자 승인 스텝 입력

		List<CustomApprovalVO> getApprovalModelSteplist = service.getCalculatetApprovalModelSteplist();


		for(int i=0;i<getApprovalModelSteplist.size();i++){
			CustomApprovalVO appmodelstep = new CustomApprovalVO();
			appmodelstep.setRequestSeq(ordervo.getOrderNo());
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

			try{
				service.setSrApprovalStepinsert(appmodelstep);
			}catch(Exception e){

	            logger.error("calApprovalRequest Exception");

	            res = "0";
			}
		}
		ordervo.setFlowId("AFW0060");
		//관리자 승인 스텝멤버 입력
		List<CustomApprovalVO> getApprovalModelMemberlist = service.getApprovalModelMemberlist(ordervo);
		for(int i=0;i<getApprovalModelMemberlist.size();i++){
			CustomApprovalVO appmember = new CustomApprovalVO();
			appmember.setRequestSeq(orderNo);
			appmember.setStepId(getApprovalModelMemberlist.get(i).getStepId());
			appmember.setUserId(getApprovalModelMemberlist.get(i).getUserId());
			appmember.setApprvAuthFlag(getApprovalModelMemberlist.get(i).getApprvAuthFlag());
			appmember.setMailRecvFlag(getApprovalModelMemberlist.get(i).getMailRecvFlag());
			appmember.setSmsRecvFlag(getApprovalModelMemberlist.get(i).getSmsRecvFlag());
			appmember.setPushRecvFlag(getApprovalModelMemberlist.get(i).getPushRecvFlag());
			try{
				service.setSrApprovalMemberinsert(appmember);
			}catch(Exception e){

				logger.error("calApprovalRequest Exception");

				res = "0";
			}
		}


		//정산승인 요청시 요청자 승인완료 처리
		if(res.equals("1")){
			CustomApprovalVO approvalVo = new CustomApprovalVO();
			String StepId = "WF4000A0";
			log.debug("StepId : "+StepId);

			String requestSeq = orderNo;
			log.debug("=== requestSeq  ===" + requestSeq);

			String rightStepId = "WF4000B0";
			log.debug("=== rightStepId ===" + rightStepId);

			String stepLevel = "1";
			log.debug("=== stepLevel ===" + stepLevel);

			approvalVo.setFlowId("AFW0060");
			approvalVo.setApprvUserId(userSession.getUsername());
			approvalVo.setApprvUserName(userSession.getNickname());
			approvalVo.setRequestSeq(requestSeq);
			approvalVo.setStepLevel(stepLevel);
			log.debug("approvalVo : " + approvalVo.getFlowId());
			log.debug("approvalVo : " + approvalVo.getApprvUserId());
			log.debug("approvalVo : " + approvalVo.getApprvUserName());
			log.debug("approvalVo : " + approvalVo.getRequestSeq());
			log.debug("approvalVo : " + approvalVo.getStepLevel());

			String apprvState = CodeUtil.CMM_CODE_APPRV_COMPLETED;
			approvalVo.setApprvState(apprvState);

			try{
				service.stepUpdate(approvalVo);
			}catch(Exception e){

				logger.error("calApprovalRequest Exception");

				res = "0";
			}


			// 다음 스텝레벨 세팅
			if (stepLevel.equals("1")) {
				stepLevel = "2";
				approvalVo.setStepLevel(stepLevel);
			}

			List<CustomApprovalVO> getApprovalModelMemberlist2 = service.getApprovalModelMemberlist(approvalVo);
			for(int i=0;i<getApprovalModelMemberlist2.size();i++){
				alarmsTemplateService.alarms("40", userSession.getUsername(), requestSeq, "");
			}
		}

		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}



	/**
	 * 정산 승인플로우 업데이트
	 * @param req
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/stepUpdate")
	public ResponseEntity<String> stepUpdate(CustomApprovalVO req, Model model, Principal principal) {

		req.setUserId(principal.getName());

		String res = "";
		String StepId = req.getStepId();
		log.debug("StepId : "+StepId);

		String requestSeq = req.getRequestSeq();
		log.debug("=== requestSeq  ===" + requestSeq);

		String rightStepId = req.getRightStepId();
		log.debug("=== rightStepId ===" + rightStepId);

		String stepLevel = req.getStepLevel();
		log.debug("=== stepLevel ===" + stepLevel);

		req.setFlowId("AFW0060");

		// bill_master 업데이트용
		CustomChargeBillVO billVo = new CustomChargeBillVO();

		if (rightStepId.equals("*")) {
			String apprvState = CodeUtil.CMM_CODE_APPRV_COMPLETED;

			req.setApprvState(apprvState);
			log.debug("=== apprvState ===" + apprvState);

			//승인테이블 업데이트
			res = service.stepUpdate(req);

			billVo.setBillYyyymm(req.getRequestSeq());
			billVo.setApprvStat(apprvState);
			billVo.setUserId(req.getUserId());

			CustomCmmUserVO userVo = new CustomCmmUserVO();
			userVo.setUserId(req.getUserId());
			billVo.setUserName(cmmUserService.detail(userVo).getUserName());

			//bill_master 상태값 업데이트
			try{
				service.reqCalculateApproval(billVo);
			}catch(Exception e){

	            logger.error("stepUpdate Exception");

				res = "0";
			}

			//정산확정
			try{
				billService.updateConfirmFlag(billVo);
			}catch(Exception e){

	            logger.error("updateConfirmFlag Exception");

				res = "0";
			}

			// 최초 요청자 조회
			CustomApprovalVO newReq = new CustomApprovalVO();
			newReq.setStepId("WF4000A0");
			newReq.setRequestSeq(requestSeq);
			CustomApprovalVO firstMem = service.getSetpMember(newReq);

			alarmsTemplateService.alarms("41", firstMem.getApprvUserId(), req.getRequestSeq(), "");

		} else if (rightStepId != "*") {
			String apprvState = CodeUtil.CMM_CODE_APPRV_COMPLETED;
			req.setApprvState(apprvState);
			res = service.stepUpdate(req);


			if(stepLevel.equals("2")){
				req.setStepLevel("3");
			}else if(stepLevel.equals("3")){
				req.setStepLevel("4");
			}else if(stepLevel.equals("4")){
				req.setStepLevel("5");
			}


			List<CustomApprovalVO> getApprovalModelMemberlist = service.getApprovalModelMemberlist(req);
			for(int i=0;i<getApprovalModelMemberlist.size();i++){
				alarmsTemplateService.alarms("40", getApprovalModelMemberlist.get(i).getUserId(), req.getRequestSeq(), "");
			}

		}
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}


	/**
	 * 승인플로우 업데이트(반려)
	 * @param req
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/stepRejectUpdate")
	public ResponseEntity<String> rejectUpdate(CustomApprovalVO req, Model model) {

		String res = "1";
		req.setFlowId("AFW0030");

		String apprvState = CodeUtil.CMM_CODE_APPRV_REJECT;

		req.setApprvState(apprvState);
		log.debug("=== apprvState ===" + apprvState);
		res = service.stepRejectUpdate(req);


		// bill_master 업데이트용
		CustomChargeBillVO billVo = new CustomChargeBillVO();
		billVo.setBillYyyymm(req.getRequestSeq());
		billVo.setApprvStat(apprvState);
		try{
			service.reqCalculateApproval(billVo);
		}catch(Exception e){

            logger.error("rejectUpdate Exception");

			res = "0";
		}


//		String requestSeq = req.getRequestSeq();
//		List<CustomApprovalVO> getApprovalModelMemberlist9 = service.getApprovalModelMemberlist(req);
//		log.debug("========getApprovalModelMemberlist9 : "+ getApprovalModelMemberlist9.get(0).getUserMail());

		// 승인완료한 스텝멤버 리스트 조회
		List<CustomApprovalVO> getApprovalModelMemberlist = service.getComplatedMemberList(req);
		log.debug("========getApprovalModelMemberlist : "+ getApprovalModelMemberlist.get(0).getUserMail());

		for(int i=0;i<getApprovalModelMemberlist.size();i++){
			alarmsTemplateService.alarms("42", getApprovalModelMemberlist.get(i).getUserId(), req.getRequestSeq(), "");
		}

		return new ResponseEntity<String>(res, HttpStatus.OK);
	}

	// 승인플로우 업데이트(반려 후 재요청시)
	@RequestMapping(value="/reReqUpdate")
	public ResponseEntity<String> reReqUpdate(CustomApprovalVO req, Model model) {

		String res = "1";
		req.setFlowId("AFW0030");

		String apprvState = CodeUtil.CMM_CODE_APPRV_PROCESSING;

		req.setApprvState(apprvState);
		log.debug("=== apprvState ===" + apprvState);
		log.debug("=== requestSeq ===" + req.getBillYyyymm());

		UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		final String userId = userSession.getUsername();
		final String userName = userSession.getNickname();

//		String orderNo = req.getOrderNo();
		String orderNo = req.getBillYyyymm();
		req.setRequestSeq(orderNo);

		// bill_master 업데이트용
		CustomChargeBillVO billVo = new CustomChargeBillVO();

		billVo.setBillYyyymm(req.getBillYyyymm());
		billVo.setApprvStat(apprvState);

		// 기존 승인 멤버, 스텝 삭제
		try{
			service.reReqDelete(req);
		}catch(Exception e){

            logger.error("reReqDelete Exception");

			res = "0";
		}

		// bill_master 상태값 업데이트
		try{
			service.reqCalculateApproval(billVo);
		}catch(Exception e){

            logger.error("reqCalculateApproval Exception");

			res = "0";
		}


		//관리자 승인 스텝 입력
		List<CustomApprovalVO> getApprovalModelSteplist = service.getApprovalModelSteplist();
		for(int i=0;i<getApprovalModelSteplist.size();i++){
			CustomApprovalVO appmodelstep = new CustomApprovalVO();
			appmodelstep.setRequestSeq(req.getRequestSeq());
			appmodelstep.setStepId(getApprovalModelSteplist.get(i).getStepId());
			appmodelstep.setModelId(getApprovalModelSteplist.get(i).getModelId());
			appmodelstep.setStepName(getApprovalModelSteplist.get(i).getStepName());
			appmodelstep.setStepLevel(getApprovalModelSteplist.get(i).getStepLevel());
			appmodelstep.setLeftStepId(getApprovalModelSteplist.get(i).getLeftStepId());
			appmodelstep.setRightStepId(getApprovalModelSteplist.get(i).getRightStepId());
			if(appmodelstep.getStepLevel().equals("1")){
				appmodelstep.setApprvState("APPRV_COMPLETED");
			}else if(appmodelstep.getStepLevel().equals("2")){
				appmodelstep.setApprvState("APPRV_PROCESSING");
			}else{
				appmodelstep.setApprvState("APPRV_WAITING");
			}

			try{
				service.setSrApprovalStepinsert(appmodelstep);
			}catch(Exception e){

				logger.error("setSrApprovalStepinsert Exception");

				res = "0";
			}
		}
		req.setFlowId("AFW0030");
		//관리자 승인 스텝멤버 입력
		List<CustomApprovalVO> getApprovalModelMemberlist = service.getApprovalModelMemberlist(req);
		for(int i=0;i<getApprovalModelMemberlist.size();i++){
			CustomApprovalVO appmember = new CustomApprovalVO();
			appmember.setRequestSeq(req.getRequestSeq());
			appmember.setStepId(getApprovalModelMemberlist.get(i).getStepId());
			appmember.setUserId(getApprovalModelMemberlist.get(i).getUserId());
			appmember.setApprvAuthFlag(getApprovalModelMemberlist.get(i).getApprvAuthFlag());
			appmember.setMailRecvFlag(getApprovalModelMemberlist.get(i).getMailRecvFlag());
			appmember.setSmsRecvFlag(getApprovalModelMemberlist.get(i).getSmsRecvFlag());
			appmember.setPushRecvFlag(getApprovalModelMemberlist.get(i).getPushRecvFlag());
			try{
				service.setSrApprovalMemberinsert(appmember);
			}catch(Exception e){

				logger.error("setSrApprovalMemberinsert Exception");

				res = "0";
			}
		}



		//정산승인 요청시 요청자 승인완료 처리
		if(res.equals("1")){

			CustomApprovalVO approvalVo = new CustomApprovalVO();
			String StepId = "WF2000A0";
			log.debug("StepId : "+StepId);

			String requestSeq = orderNo;
			log.debug("=== requestSeq  ===" + requestSeq);

			String rightStepId = "WF2000B0";
			log.debug("=== rightStepId ===" + rightStepId);

			String stepLevel = "1";
			log.debug("=== stepLevel ===" + stepLevel);

			approvalVo.setFlowId("AFW0030");

	//		String apprvState = CodeUtil.CMM_CODE_APPRV_COMPLETED;
			approvalVo.setApprvState(CodeUtil.CMM_CODE_APPRV_COMPLETED);
			approvalVo.setFlowId("AFW0030");
			approvalVo.setApprvUserId(userId);
			approvalVo.setApprvUserName(userName);
			approvalVo.setRequestSeq(requestSeq);
			approvalVo.setStepLevel(stepLevel);
			try{
				service.stepUpdate(approvalVo);
			}catch(Exception e){

				logger.error("stepUpdate Exception");

				res = "0";
			}

			// 다음 스텝레벨 세팅
			if (stepLevel.equals("1")) {
				stepLevel = "2";
				approvalVo.setStepLevel(stepLevel);
			}

			List<CustomApprovalVO> getApprovalModelMemberlist2 = service.getApprovalModelMemberlist(approvalVo);
			for(int i=0;i<getApprovalModelMemberlist2.size();i++){
				alarmsTemplateService.alarms("41", getApprovalModelMemberlist2.get(i).getUserId(), requestSeq, "");
			}
		}

//		res = "1";

		return new ResponseEntity<String>(res, HttpStatus.OK);
	}

}



