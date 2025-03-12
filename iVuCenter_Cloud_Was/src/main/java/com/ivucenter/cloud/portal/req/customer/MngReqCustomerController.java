package com.ivucenter.cloud.portal.req.customer;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ivucenter.cloud.portal.bbs.notice.BbsNoticeService;
import com.ivucenter.cloud.portal.bbs.notice.CustomBbsNoticeVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value="/mng/req/customer")
public class MngReqCustomerController {
	
	@Autowired
	private ReqCustomerService customerService;
	
	@Autowired
	private BbsNoticeService service;
	/**
	 * ȸ���� ��û ��Ȳ ����ȭ��
	 */
	@RequestMapping(value="/")
	public String mngCustomer(Model model) {
		log.debug("=== mngCustomer Controller ===");
		return "mng/req/customer/customerList";
	}
	
	/**
	 * ȸ���� ��û ��Ȳ ����Ʈ��ȸ
	 */
	@RequestMapping(value="/list", method = RequestMethod.GET)
	public ResponseEntity<Object> mngCustomerList(CustomReqCustomerVO req){
		log.debug("=== mngCustomerList Controller ===");		
  		String apprvCodeKeyId="APPRV_STATE";
  		String requestCodeKeyId="REQUEST_TYPE";
  		req.setApprvCodeKeyId(apprvCodeKeyId);
  		req.setRequestCodeKeyId(requestCodeKeyId);
		String res = customerService.list(req);
		
		if(res.equals("")){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}
	
	@RequestMapping(value="/view")
	public String mngBbsNoticeView(Model model, CustomReqCustomerVO req) {
		
		model.addAttribute("requestSeq", req.getRequestSeq());
		
		String codeKeyId="APPRV_STATE";
		String requestSeq =req.getRequestSeq();
		List<CustomReqCustomerVO> approvalList  = customerService.approvalList(requestSeq);
		
		List<CustomReqCustomerVO> approvalUserId  = customerService.approvalUserId(requestSeq);
		
		List<CustomBbsNoticeVO> getNoticeBbscodeList = service.getNoticeBbscodeList(codeKeyId);
		model.addAttribute("code", getNoticeBbscodeList);
		model.addAttribute("getProjectAppSteplist", approvalList);
		model.addAttribute("approvalUserId", approvalUserId);
		
		CustomReqCustomerVO detail = customerService.detail(requestSeq);
		model.addAttribute("detail", detail);
		
		return "mng/req/customer/customerView";
	}

	@RequestMapping(value = "/detail", method = RequestMethod.POST)
	public ResponseEntity<Object> mngBbsNoticeDetail(String requestSeq) {
		log.info("=== mngBbsNoticeDetail Controller ===");
		
		CustomReqCustomerVO res = customerService.detail(requestSeq);
		
		if(res == null){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}	
	/**
	 * ȸ���� ���� ������ �ܰ� ���/����
	 */
	@RequestMapping(value="/insert", method=RequestMethod.POST)
	public ResponseEntity<String> mngBbsNoticeInsert(CustomReqCustomerVO req) {
		log.info("=== mngBbsNoticeInsert Controller1 ===");
		String res = "";
		
		req.setModUserId(req.getRegUserId());
		res = customerService.insert(req); 
		res = customerService.newUpdate(req);
		
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
	
	@RequestMapping(value="/update", method=RequestMethod.POST)
	public ResponseEntity<String> mngBbsNoticeUpdate(CustomReqCustomerVO req) {
		log.info("=== mngBbsNoticeInsert Controller2 ===");
		String res = "";
		
			req.setModUserId(req.getRegUserId());
			res = customerService.update(req);
			res = customerService.exprUpdate(req);
		
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}	
	/**
	 * 회원사 스텝수정
	 */
	@RequestMapping(value="/stepUpdate", method = {RequestMethod.GET,RequestMethod.POST})
	public ResponseEntity<String> mngStepUpdate(CustomReqCustomerVO req) {
		log.debug("=== mngBbsNoticeInsert Controller ===");
		String res = "";
		String requestSeq = req.getRequestSeq();
		log.debug("=== requestSeq  ==="+requestSeq);
		//���� Ÿ�� ����
		String rightStepId = req.getRightStepId();
		log.debug("=== rightStepId ==="+rightStepId); 
		//���ܷ���
		String stepLevel = req.getStepLevel();
		log.debug("=== stepLevel ==="+stepLevel);
		
		req.setModUserId(req.getRegUserId());
		if(rightStepId.equals("*")){
			String apprvState = "APPRV_COMPLETED";
//			String apprvDescription = req.getApprvDescription();
//			if(apprvDescription.equals(null)){
//				apprvDescription="(NULL)";
//			}
			req.setApprvState(apprvState);
			log.info("=== apprvState ==="+apprvState);
			res = customerService.stepUpdate(req);
			
		}else if(rightStepId != "*"){
			String apprvState = "APPRV_COMPLETED";
			req.setApprvState(apprvState);
			res = customerService.stepUpdate(req);
			if(stepLevel.equals("1")){
//				String apprvDescription = req.getApprvDescription();
//				if(apprvDescription.equals(null)){
//					apprvDescription="(NULL)";
//				}
				stepLevel = "2";
				log.info("=== stepLevel2 ==="+stepLevel);
			}else if(stepLevel.equals("2")){
//				String apprvDescription = req.getApprvDescription();
//				if(apprvDescription.equals(null)){
//					apprvDescription="(NULL)";
//				}
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
	/**
	 * 회원사 미승인 프로세서
	 */
	@RequestMapping(value="/rejectedUpdate", method = {RequestMethod.GET,RequestMethod.POST})
	public ResponseEntity<String> mngRejectedUpdate(CustomReqCustomerVO req) {
		log.debug("=== mngBbsNoticeInsert Controller ===");
		String res = "";
		String requestSeq = req.getRequestSeq();
		log.debug("=== requestSeq  ==="+requestSeq);
		//다음단계 스텝
		//String rightStepId = req.getRightStepId();
		//log.info("=== rightStepId ==="+rightStepId); 
		//스텝 레벨
		String stepLevel = req.getStepLevel();
		log.debug("=== stepLevel ==="+stepLevel);
		
		req.setModUserId(req.getRegUserId());

		String apprvState = "APPRV_REJECTED";
		String apprvDescription = req.getApprvDescription();
		req.setApprvDescription(apprvDescription);
		req.setApprvState(apprvState);
		req.setStepLevel(stepLevel);
		res = customerService.rejectedUpdate(req);
		res = customerService.stepUpdate(req);
		
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}	
	/**
	 * ���θ�� ��ȸ
	 */
	@RequestMapping(value="/approvalList", method = RequestMethod.GET)
	public ResponseEntity<Object> mngCustomerApproval(Model model,CustomReqCustomerVO req){
		log.debug("=== mngCustomerList Controller ===");
		String requestSeq =req.getRequestSeq();
		String codeKeyId="APPRV_STATE";
		List<CustomReqCustomerVO> res  = customerService.approvalList(requestSeq);
		log.debug("=== mngCustomerApproval Controller ==="+ req.getRequestSeq());
		
		if(res.equals("")){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}
	/**
	 * ���θ�� ���̵� ��ȸ
	 */
	@RequestMapping(value="/approvalUserId", method = RequestMethod.GET)
	public ResponseEntity<Object> mngCustomerApprovalId(Model model,CustomReqCustomerVO req){
		log.debug("=== mngCustomerList Controller ===");
		String requestSeq =req.getRequestSeq();
		List<CustomReqCustomerVO> res  = customerService.approvalUserId(requestSeq);
		log.debug("=== mngCustomerApproval Controller ==="+ req.getRequestSeq());
		if(res.equals("")){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}
	
}