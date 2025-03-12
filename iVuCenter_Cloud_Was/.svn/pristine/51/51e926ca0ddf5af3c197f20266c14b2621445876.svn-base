package com.ivucenter.cloud.portal.req.product;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ivucenter.cloud.portal.alarms.template.AlarmsTemplateService;
import com.ivucenter.cloud.portal.approval.ApprovalService;
import com.ivucenter.cloud.portal.approval.CustomApprovalVO;
import com.ivucenter.cloud.portal.req.customer.CustomReqCustomerVO;
import com.ivucenter.cloud.portal.req.customer.ReqCustomerService;
import com.ivucenter.cloud.portal.util.CodeUtil;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value = "/mbr/req/product")
public class MbrReqProductController {

//	@Autowired	private ReqProjectService reqProjectService;

	@Autowired
	private ReqProductService reqProductService;

	@Autowired
	private ReqCustomerService customerService;

	@Autowired
	private AlarmsTemplateService alarmsTemplateService;

	@Autowired
	private ApprovalService approvalService;

//	@Autowired	private ProductUsageStatusTotalService productUsageStatusService;
//	@Autowired	private BbsNoticeService bbsNoticeservice;
//	@Autowired	private ReqCatalogueService reqCatalogueService;
//	@Autowired	private MngReqWorkService mngReqWorkService;

//	@RequestMapping(value = {"/",""})
//	public String mngBbsFaqList() {
//		return "mng/req/product/productList";
//	}

	/**
	 * 상품신청 리스트
	 */
//	@RequestMapping(value = "/list", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
//	public ResponseEntity<Object> MngReqProductControllerList(CustomReqProductVO req) {
//
//		String apprvCodeKeyId = "APPRV_STATE";
//		String requestCodeKeyId = "REQUEST_TYPE";
//		req.setApprvCodeKeyId(apprvCodeKeyId);
//		req.setRequestCodeKeyId(requestCodeKeyId);
//		String res = reqProductService.list(req);
//
//		if (res.equals("")) {
//			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
//		}
//		return new ResponseEntity<Object>(res, HttpStatus.OK);
//	}

//	@RequestMapping(value = "/excel", produces="text/plain;charset=UTF-8")
//	public ModelAndView MngReqProductControllerExcel(CustomReqProductVO req, ModelMap map) {
//
//		String apprvCodeKeyId = "APPRV_STATE";
//		String requestCodeKeyId = "REQUEST_TYPE";
//		req.setApprvCodeKeyId(apprvCodeKeyId);
//		req.setRequestCodeKeyId(requestCodeKeyId);
//
//		map.addAttribute("excel_gbn", "productApprv");
//		map.addAttribute("excel_title", "상품구매승인");
//		map.addAttribute("excel_list", reqProductService.excel(req));
//
//		return new ModelAndView("productExcelView", map);
//	}

	/**
	 * 상품신청 상세 화면
	 */
//	@RequestMapping(value = "/view")
//	public String mngReqProjectView(Model model, CustomReqProductVO req, Principal principal) {
//
//		log.info("mngDetails.getCompanyId() : " + req.getCompanyId());
//
//		// 프로젝트 ID값
//		String projectId = null;
//		String orderNo = req.getOrderNo();
//		model.addAttribute("orderNo", orderNo);
//
//		Map<String,String> map = new HashMap<>();
//		String userId = principal.getName();
//		map.put("userId", userId);
//		map.put("orderNo", orderNo);
//		// 승인스텝멤버 불러오기
//		String stepId = reqProductService.getStepId(map);
//		map.put("stepId", stepId);
//		model.addAttribute("stepId", stepId);
//
//		String userApprvState ="";
//		userApprvState = reqProductService.getUserApprvState(map);
//		model.addAttribute("userApprvState", userApprvState);
//
//		// 승인 라인 정보 조회
//		List<CustomReqProductVO> approvalList = reqProductService.approvalList(map);
//		model.addAttribute("getProjectAppSteplist", approvalList);
//
//		for (int i = 0; i < approvalList.size(); i++) {
//			if(approvalList.get(i).getApprvState().equals("APPRV_REJECTED")){
//				String inject ="Y";
//				model.addAttribute("inject",inject);
//			}
//		}
//
//		// 승인스텝멤버 유저 아이디 조회
////		String flowId = "AFW0040";
//		List<CustomReqProductVO> approvalUserId = reqProductService.approvalUserId(orderNo);
//		model.addAttribute("approvalUserId", approvalUserId);
//
////		List<CustomBbsNoticeVO> getNoticeBbscodeList = bbsNoticeservice.getNoticeBbscodeList(codeKeyId);
////		model.addAttribute("code", getNoticeBbscodeList);
//
//
//		//주문자명 아이디 가져오기 (상품신청 승인 및 취소시) 2017.08.24
//		CustomReqProductVO getOrderUserId = reqProductService.getOrderVo(orderNo);
//		model.addAttribute("getOrderUserId", getOrderUserId);
//
//		// 장바구니 블록디스크 리스트 가져오기
//		List<CustomReqProductVO> getReqDisklistvo = reqProductService.getReqDiskOrderList(orderNo);
//		model.addAttribute("getBasketDisklistvo", getReqDisklistvo);
//		if(getReqDisklistvo.size() != 0) {
//			projectId = getReqDisklistvo.get(0).getProjectId();
//		}
//
//		// 장바구니 NAS 리스트 가져오기
//		List<CustomReqProductVO> getReqNaslistvo = reqProductService.getReqNasOrderList(orderNo);
//		model.addAttribute("getBasketNaslistvo", getReqNaslistvo);
//
//		// 장바구니 IP 리스트 가져오기
//		List<CustomReqProductVO> getReqIplistvo = reqProductService.getReqIpOrderList(orderNo);
//		model.addAttribute("getBasketIplistvo", getReqIplistvo);
//
//		// 장바구니 로드 밸런서 리스트 가져오기
//		List<CustomReqProductVO> getReqLblistvo = reqProductService.getReqLbOrderList(orderNo);
//		model.addAttribute("getBasketLblistvo", getReqLblistvo);
//
//		// 장바구니 서비스 리스트 가져오기
//		List<CustomReqProductVO> getReqServicelistvo = reqProductService.getReqServiceOrderList(orderNo);
//		model.addAttribute("getReqServicelistvo", getReqServicelistvo);
//
//		// vm 가져오기
//		List<CustomReqProductVO> getReqlistvo = reqProductService.getReqVMOrderList(orderNo);
//		CustomReqProductVO detail1 = reqProductService.detail1(orderNo);
//
//		String networkChk = "";
//		for (int i = 0; i < getReqlistvo.size(); i++) {
//			getReqlistvo.get(i).setNetworkChk(networkChk);
//			log.debug("networkChk : " + networkChk);
//			networkChk = "";
//		}
//		model.addAttribute("getReqlistvo", getReqlistvo);
//
//		if(getReqlistvo.size() != 0) {
//			projectId = getReqlistvo.get(0).getProjectId();
//		}
//
//		List<CustomReqProductVO> detail = reqProductService.detail(orderNo);
//		model.addAttribute("detail", detail);
//		model.addAttribute("detail1", detail1);
//
//		String apprvCodeKeyId = "APPRV_STATE";
//		String requestCodeKeyId = "REQUEST_TYPE";
//		req.setApprvCodeKeyId(apprvCodeKeyId);
//		req.setRequestCodeKeyId(requestCodeKeyId);
//
//		// 프로젝트별 상세 가용용량
//		List<CustomReqProductVO> getCloudAvailListVo = reqProductService.getCloudAvailList(orderNo);
//		model.addAttribute("getCloudAvailListVo", getCloudAvailListVo);
//
//		if (getCloudAvailListVo.size() > 0) {
//			model.addAttribute("getCloudAvailCollDatetime", getCloudAvailListVo.get(0).getCollDatetime());
//		} else {
//			model.addAttribute("getCloudAvailCollDatetime", "");
//		}
//
//		//프로젝트 상세정보
//		if(projectId != null) {
//			CustomReqProjectVO projectInfo = reqProjectService.getOkProjectView(projectId);
//			projectInfo.setManagerTel( projectInfo.getManagerTelDec() );
//			model.addAttribute("projectInfo", projectInfo);
//		}
//
//		return "mng/req/product/productView";
//	}

	/**
	 * 상품 상세 불러오기
	 */
//	@RequestMapping(value = "/detail", method = RequestMethod.POST)
//	public ResponseEntity<Object> mngBbsNoticeDetail(String orderNo) {
//		log.debug("detail 상제 불러오기");
//		log.info("=== mngBbsNoticeDetail Controller ===");
//		List<CustomReqProductVO> res = reqProductService.detail(orderNo);
//
//		if (res == null) {
//			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
//		}
//
//		return new ResponseEntity<Object>(res, HttpStatus.OK);
//	}

	@RequestMapping(value = "/stepUpdate", method = { RequestMethod.GET, RequestMethod.POST })
	public ResponseEntity<String> mngStepUpdate(CustomReqProductVO req, Model model, Principal principal) {
		String res = "";

		// 현재 스탭 상태 변경
		req.setModUserId(req.getRegUserId());
		req.setApprvState(CodeUtil.CMM_CODE_APPRV_COMPLETED);
		res = reqProductService.stepUpdate(req);

		String rightStepId = req.getRightStepId();
		if (rightStepId != "*") { // 최종 스탭이 아닐 경우 (초종 스탭은 MNG에서 호출)

			CustomReqProductVO reqProductVo = reqProductService.orderUserInfo(req.getRequestSeq());
			Map<String,String> keywordMap = new HashMap<>();
			keywordMap.put("[[신청자명]]", reqProductVo.getUserName());
			keywordMap.put("[[URL]]", "http://k-cloud.kepco.co.kr/mbr/req/catalogue/bssOrderApproveView?orderNo="+req.getRequestSeq());
			keywordMap.put("[[LURL]]", "http://k-cloud.kepco.co.kr/mbr");

			CustomApprovalVO stepUser = new CustomApprovalVO();
			stepUser.setStepLevel(req.getStepLevel());
			stepUser.setRequestSeq(req.getRequestSeq());

			CustomApprovalVO ApprovalVo = approvalService.getNextScheduleUser(stepUser); // 한전 결재시스템
			Map<String, String> alarmkepcoMap = new HashMap<>();
			alarmkepcoMap.put("gbn", "33");
			alarmkepcoMap.put("requestSeq", req.getRequestSeq());
			alarmkepcoMap.put("regUserId", reqProductVo.getOrderUserId());	// 프로젝트 신청자
			alarmkepcoMap.put("apprvNowUserId", ApprovalVo.getApprvUserId());	// 현재 결재자
			if(! req.getStepLevel().equals("4")) {
				alarmkepcoMap.put("apprvNextUserId", ApprovalVo.getUserId());	// 다음 결재자
			}
			alarmkepcoMap.put("url", "http://k-cloud.kepco.co.kr/mbr/req/catalogue/bssOrderApproveView?orderNo="+req.getRequestSeq());
			alarmsTemplateService.alarmsKepco(alarmkepcoMap);

			List<CustomApprovalVO> nextApprovalVoList = approvalService.getNextScheduleUserList(stepUser);
			for (CustomApprovalVO nextApprovVO : nextApprovalVoList) {

				alarmsTemplateService.alarms(33, nextApprovVO.getUserId(), keywordMap);
				if(req.getStepLevel().equals("4")) {
					alarmkepcoMap = new HashMap<>();
					alarmkepcoMap.put("gbn", "34");
					alarmkepcoMap.put("requestSeq", req.getRequestSeq());
					alarmkepcoMap.put("regUserId", reqProductVo.getOrderUserId());	// 프로젝트 신청자
					alarmkepcoMap.put("apprvNowUserId", nextApprovVO.getUserId());	// 현재 결재자
					alarmkepcoMap.put("url", "http://k-cloud.kepco.co.kr/mng/req/product/view?orderNo="+req.getRequestSeq());
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
	 * 가상서버 신규 마지막 승인 (마지막 승인은 MNG에서 처리)
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public ResponseEntity<String> MngReqProductInsert(CustomReqProductVO req, Model model, Principal principal) {
		log.info("=== MngReqProductController Controller1 ===");

		final String userId = principal.getName();
		//신청 리스트 상태 바꾸는 쿼리
		String res2 = reqProductService.newUpdate(req);

		String apprvDescription = req.getApprvDescription();
		String stepLevel = req.getStepLevel();
		stepLevel ="3";
		req.setApprvState(CodeUtil.CMM_CODE_APPRV_COMPLETED);
		req.setStepLevel(stepLevel);

		log.info("=== stepLevel ===" + stepLevel);
		//최종 승인자 상태 바꾸는 쿼리

		String res3 = reqProductService.stepUpdate(req);
		String requestSeq = req.getRequestSeq();


		// VM 대상으로만 된 쿼리문이라 변경처리함
		//List<CustomReqProductVO> getReqlistvo = reqProductService.detail(requestSeq);

		List<CustomReqProductVO> getReqlistvo = reqProductService.detailBbsOrder(requestSeq);
		log.debug("getReqlistvo.size()=>"+getReqlistvo.size());
		for (CustomReqProductVO vo : getReqlistvo) {
			reqProductService.actProduct(vo);
		}

		List<CustomReqProductVO> getReqNaslistvo = reqProductService.getReqNasOrderList(req.getRequestSeq());
		for (int i = 0; i < getReqNaslistvo.size(); i++) {

			Date requestSeqdate = new Date();
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmssSSS");
			String reqWorkSeq ="";

			CustomReqProductVO reqWork = new CustomReqProductVO();
			reqWork.setReqWorkSeq(dateFormat.format(requestSeqdate));
			reqWork.setOrderProductSeq(getReqNaslistvo.get(i).getOrderProductSeq());
			reqWork.setWorkState("N");
			reqWork.setVmName(getReqNaslistvo.get(i).getVmName());
			reqWork.setDescription(getReqNaslistvo.get(i).getDescription());
			reqWork.setRegUserId(userId);

			log.debug(reqWork.getReqWorkSeq());
			log.debug(reqWork.getOrderProductSeq());
			log.debug(reqWork.getWorkState());
			log.debug(reqWork.getDescription());
			log.debug(reqWork.getRegUserId());

			int reWorkResult = reqProductService.setReqWork(reqWork);
		}
		List<CustomReqProductVO> getReqIplistvo = reqProductService.getReqIpOrderList(req.getRequestSeq());
		for (int i = 0; i < getReqIplistvo.size(); i++) {
			Date requestSeqdate = new Date();
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmssSSS");
			String reqWorkSeq ="";

			CustomReqProductVO reqWork = new CustomReqProductVO();
			reqWork.setReqWorkSeq(dateFormat.format(requestSeqdate));
			reqWork.setOrderProductSeq(getReqIplistvo.get(i).getOrderProductSeq());
			reqWork.setWorkState("N");
			reqWork.setDescription(getReqIplistvo.get(i).getDescription());
			reqWork.setRegUserId(userId);

			log.debug(reqWork.getReqWorkSeq());
			log.debug(reqWork.getOrderProductSeq());
			log.debug(reqWork.getWorkState());
			log.debug(reqWork.getDescription());
			log.debug(reqWork.getRegUserId());

			int reWorkResult = reqProductService.setReqWork(reqWork);
		}
		List<CustomReqProductVO> getReqLblistvo = reqProductService.getReqLbOrderList(req.getRequestSeq());
		for (int i = 0; i < getReqLblistvo.size(); i++) {
			Date requestSeqdate = new Date();
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmssSSS");
			String reqWorkSeq ="";

			CustomReqProductVO reqWork = new CustomReqProductVO();
			reqWork.setReqWorkSeq(dateFormat.format(requestSeqdate));
			reqWork.setOrderProductSeq(getReqLblistvo.get(i).getOrderProductSeq());
			reqWork.setWorkState("N");
			reqWork.setDescription(getReqLblistvo.get(i).getDescription());
			reqWork.setRegUserId(userId);

			log.debug(reqWork.getReqWorkSeq());
			log.debug(reqWork.getOrderProductSeq());
			log.debug(reqWork.getWorkState());
			log.debug(reqWork.getDescription());
			log.debug(reqWork.getRegUserId());

			int reWorkResult = reqProductService.setReqWork(reqWork);
		}
		List<CustomReqProductVO> getReqBaklistvo = reqProductService.getReqBakOrderList(req.getRequestSeq());
		for (int i = 0; i < getReqBaklistvo.size(); i++) {
			Date requestSeqdate = new Date();
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmssSSS");
			String reqWorkSeq ="";

			CustomReqProductVO reqWork = new CustomReqProductVO();
			reqWork.setReqWorkSeq(dateFormat.format(requestSeqdate));
			reqWork.setOrderProductSeq(getReqBaklistvo.get(i).getOrderProductSeq());
			reqWork.setWorkState("N");
			reqWork.setDescription(getReqBaklistvo.get(i).getDescription());
			reqWork.setRegUserId(userId);

			log.debug(reqWork.getReqWorkSeq());
			log.debug(reqWork.getOrderProductSeq());
			log.debug(reqWork.getWorkState());
			log.debug(reqWork.getDescription());
			log.debug(reqWork.getRegUserId());

			int reWorkResult = reqProductService.setReqWork(reqWork);
		}


		//서비스 최종승인후 작업자 insert 작업
//		List<CustomReqProductVO> getReqServicelistvo = reqProductService.getReqBakOrderList(req.getRequestSeq());
		List<CustomReqProductVO> getReqServicelistvo = reqProductService.getReqServiceOrderList(req.getRequestSeq());
		for (int i = 0; i < getReqServicelistvo.size(); i++) {
			Date requestSeqdate = new Date();
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmssSSS");
			String reqWorkSeq ="";

			CustomReqProductVO reqWork = new CustomReqProductVO();
			reqWork.setReqWorkSeq(dateFormat.format(requestSeqdate));
			reqWork.setOrderProductSeq(getReqServicelistvo.get(i).getOrderProductSeq());
			reqWork.setWorkState("N");
			reqWork.setDescription(getReqServicelistvo.get(i).getDescription());
			reqWork.setRegUserId(userId);

			log.debug(reqWork.getReqWorkSeq());
			log.debug(reqWork.getOrderProductSeq());
			log.debug(reqWork.getWorkState());
			log.debug(reqWork.getDescription());
			log.debug(reqWork.getRegUserId());

			int reWorkResult = reqProductService.setReqWork(reqWork);
		}

		List<CustomReqProductVO> getReqMcalistvo = reqProductService.getReqMcaOrderList(req.getRequestSeq());
			for (int i = 0; i < getReqMcalistvo.size(); i++) {
				Date requestSeqdate = new Date();
				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmssSSS");
				String reqWorkSeq ="";

			CustomReqProductVO reqWork = new CustomReqProductVO();
			reqWork.setReqWorkSeq(dateFormat.format(requestSeqdate));
			reqWork.setOrderProductSeq(getReqMcalistvo.get(i).getOrderProductSeq());
			reqWork.setWorkState("N");
			reqWork.setDescription(getReqMcalistvo.get(i).getDescription());
			reqWork.setRegUserId(userId);

			log.debug(reqWork.getReqWorkSeq());
			log.debug(reqWork.getOrderProductSeq());
			log.debug(reqWork.getWorkState());
			log.debug(reqWork.getDescription());
			log.debug(reqWork.getRegUserId());

			int reWorkResult = reqProductService.setReqWork(reqWork);
		}
		List<CustomReqProductVO> getReqScmlistvo = reqProductService.getReqScmOrderList(req.getRequestSeq());
		for (int i = 0; i < getReqScmlistvo.size(); i++) {
			Date requestSeqdate = new Date();
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmssSSS");
			String reqWorkSeq ="";


			CustomReqProductVO reqWork = new CustomReqProductVO();
			reqWork.setReqWorkSeq(dateFormat.format(requestSeqdate));
			reqWork.setOrderProductSeq(getReqScmlistvo.get(i).getOrderProductSeq());
			reqWork.setWorkState("N");
			reqWork.setDescription(getReqScmlistvo.get(i).getDescription());
			reqWork.setRegUserId(userId);

			log.debug(reqWork.getReqWorkSeq());
			log.debug(reqWork.getOrderProductSeq());
			log.debug(reqWork.getWorkState());
			log.debug(reqWork.getDescription());
			log.debug(reqWork.getRegUserId());

			int reWorkResult = reqProductService.setReqWork(reqWork);
		}
		List<CustomReqProductVO> getReqSerlistvo = reqProductService.getReqSerOrderList(req.getRequestSeq());
		for (int i = 0; i < getReqSerlistvo.size(); i++) {
			Date requestSeqdate = new Date();
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmssSSS");
			String reqWorkSeq ="";

			CustomReqProductVO reqWork = new CustomReqProductVO();
			reqWork.setReqWorkSeq(dateFormat.format(requestSeqdate));
			reqWork.setOrderProductSeq(getReqSerlistvo.get(i).getOrderProductSeq());
			reqWork.setWorkState("N");
			reqWork.setDescription(getReqSerlistvo.get(i).getDescription());
			reqWork.setRegUserId(userId);

			log.debug(reqWork.getReqWorkSeq());
			log.debug(reqWork.getOrderProductSeq());
			log.debug(reqWork.getWorkState());
			log.debug(reqWork.getDescription());
			log.debug(reqWork.getRegUserId());

			int reWorkResult = reqProductService.setReqWork(reqWork);
		}

//		List<CustomMngReqWorkVO> worklist = mngReqWorkService.workUserId(req.getRequestSeq());
//		for(CustomMngReqWorkVO vo : worklist){
//			alarmsTemplateService.alarms(35, vo.getWorkUserId(), vo.getProductCategoryName(), "");
//		}
//		alarmsTemplateService.alarms(31, req.getApprvUserId(), req.getOrderUserId(), req.getRequestSeq());
//		alarmsTemplateService.alarmsKepco(31, req.getRequestSeq(), req.getApprvUserId(), req.getOrderUserId(), "");
//
//		return new ResponseEntity<String>(res2, HttpStatus.OK);
	}
	*/

	/**
	 * 상품 미승인 프로세서
	 */
	@RequestMapping(value = "/rejectedUpdate", method = { RequestMethod.GET, RequestMethod.POST })
	public ResponseEntity<String> mngRejectedUpdate(CustomReqCustomerVO req, Model model, Principal principal) {

		log.info("=== mngBbsNoticeInsert Controller ===");
		String res = "";
		String requestSeq = req.getRequestSeq(); // order_no
		log.info("=== requestSeq  ===" + requestSeq);
		// 다음단계 스텝
		// String rightStepId = req.getRightStepId();
		// log.info("=== rightStepId ==="+rightStepId);
		// 스텝 레벨
		String stepLevel = req.getStepLevel();
		log.info("=== stepLevel ===" + stepLevel);

		req.setModUserId(req.getRegUserId());
		req.setApprvDescription(req.getApprvDescription());
		req.setApprvState(CodeUtil.CMM_CODE_APPRV_REJECT);
		req.setStepLevel(stepLevel);

		res = reqProductService.rejectedUpdate(req);

		res = customerService.stepUpdate(req);

		CustomApprovalVO stepUser = new CustomApprovalVO();
		stepUser.setStepLevel(req.getStepLevel());
		stepUser.setRequestSeq(req.getRequestSeq());


		CustomApprovalVO ApprovalVo = approvalService.getNextScheduleUser(stepUser);

		// 반려시 신청자에게 문자/메일
		CustomReqProductVO reqProductVo = reqProductService.orderUserInfo(requestSeq);
		Map<String,String> keywordMap = new HashMap<>();
		keywordMap.put("[[신청자명]]", reqProductVo.getUserName());
		keywordMap.put("[[반려사유]]", req.getApprvDescription());
		keywordMap.put("[[URL]]", "http://k-cloud.kepco.co.kr/mbr/req/catalogue/bssOrderApproveView?orderNo="+req.getRequestSeq());
		alarmsTemplateService.alarms(32, reqProductVo.getOrderUserId(),keywordMap); // 신청자에게 반려 메일
		// 한전 연계 시스템 전송
		Map<String, String> alarmkepcoMap = new HashMap<>();
		alarmkepcoMap.put("apprvNextUserId", ApprovalVo.getApprvUserId());	// 현재 결재자
		alarmkepcoMap.put("gbn", "32");
		alarmkepcoMap.put("requestSeq", requestSeq);
		alarmkepcoMap.put("regUserId", reqProductVo.getOrderUserId());	// 자원 신청자
		alarmkepcoMap.put("apprvNowUserId", req.getApprvUserId());		// 현재 결재자
		alarmkepcoMap.put("url", "http://k-cloud.kepco.co.kr/mbr/req/catalogue/bssOrderApproveView?orderNo="+req.getRequestSeq());
		alarmsTemplateService.alarmsKepco(alarmkepcoMap);

		return new ResponseEntity<String>(res, HttpStatus.OK);
	}

	/**
	 * 상품 pm 지정 리스트
	 */
//	@RequestMapping(value = "/productPmList", method = { RequestMethod.GET, RequestMethod.POST })
//	public ResponseEntity<Object> productPmList(CustomReqProductVO req) {
//		log.info("=== mngBbsNoticeInsert Controller ===");
//
//		List<CustomReqProductVO> res = reqProductService.pmList(req);
//
//		return new ResponseEntity<Object>(res, HttpStatus.OK);
//	}
	/**
	 * 작업자 저장하기
	 */
//	@RequestMapping(value = "/updateWorkUser", method = { RequestMethod.GET, RequestMethod.POST })
//	public ResponseEntity<Object> updateWorkUser(CustomReqProductVO req) {
//		int res = 0;
//		res = reqProductService.setUpdateWorkUser(req);
//		return new ResponseEntity<Object>(res, HttpStatus.OK);
//	}
	/**
	 * 작업자 저장 확인 체크 하기
	 */
//	@RequestMapping(value = "/checkWorkUser", method = { RequestMethod.GET, RequestMethod.POST })
//	public ResponseEntity<Object> checkWorkUser(CustomReqProductVO req) {
//
//		Assert.notNull(req.getOrderNo(), "");
//		List<CustomReqProductVO> checkWorkUser = reqProductService.checkWorkUser(req);
//		int res =checkWorkUser.size();
//		return new ResponseEntity<Object>(res, HttpStatus.OK);
//	}

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
	 * 상품 상세 (mng 처리)
	 */
//	@RequestMapping(value = "/detailOrderProduct", method = { RequestMethod.GET, RequestMethod.POST })
//	public ResponseEntity<Object> detailOrderProduct(CustomReqProductVO req) {
//		String orderProductSeq = req.getOrderProductSeq();
//		String productType = req.getProductType();
//
//		log.debug("   productType  :"+productType);
//		log.debug("orderProductSeq :"+orderProductSeq);
//		CustomReqProductVO res = null;
//		if (productType.equals("vm")) res = reqProductService.getReqVmOrder(orderProductSeq);
//		else if (productType.equals("disk")) res = reqProductService.getReqDiskOrder(orderProductSeq);
//		else if (productType.equals("nas")) res = reqProductService.getReqNasOrder(orderProductSeq);
//		else if (productType.equals("ip")) res = reqProductService.getReqIpOrder(orderProductSeq);
//		else if (productType.equals("lb")) res = reqProductService.getReqLbOrder(orderProductSeq);
//		else if (productType.equals("service")) res = reqProductService.getReqServiceOrder(orderProductSeq);
//
//		return new ResponseEntity<Object>(res, HttpStatus.OK);
//	}
}
