package com.ivucenter.cloud.portal.cmm.customer;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ivucenter.cloud.portal.bss.adjustment.BssAdjustmentService;
import com.ivucenter.cloud.portal.bss.adjustment.CustomBssAdjustmentVO;
import com.ivucenter.cloud.portal.cmm.file.CmmFileService;
import com.ivucenter.cloud.portal.cmm.file.CustomCmmFileVO;
import com.ivucenter.cloud.portal.req.customer.CustomReqCustomerVO;
import com.ivucenter.cloud.portal.req.customer.ReqCustomerService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value="/mbr/cmm/customer")
public class MbrCmmCustomerController {

	@Autowired
	private CmmCustomerService service;
	
	@Autowired
	private BssAdjustmentService bssAdjustmentService;

	@Autowired
	private CmmFileService cmmFileService;
	
	@Autowired
	private ReqCustomerService reqCustomerService;
	
	@RequestMapping(value="/customerInfo")
	@Secured( {"ROLE_CUSTOM_ADMIN","ROLE_CUSTOM_USER", "ROLE_CUSTOM_PM"} )
	public String mbrCustomerInfo(Model model, Principal principal){
		model.addAttribute("customerId", principal.getName());
		return "mbr/info/customerInfo/customerInfoView";
	}
	
	@RequestMapping(value = "/customerInfoWrite")
	@Secured( {"ROLE_CUSTOM_ADMIN","ROLE_CUSTOM_USER", "ROLE_CUSTOM_PM"} )
	public String mbrCustomerInfoWrite(Model model, CustomCmmCustomerVO req){
					
		model.addAttribute("customerId", req.getCustomerId());
		return "mbr/info/customerInfo/customerInfoInsert";		
	}
	
	@RequestMapping(value = "/customerInfoUpdate")
	public ResponseEntity<String> mbrCustomerInfoUpdate(@RequestBody CustomCmmCustomerVO req, Model model){
		String res = service.customerInfoUpdate(req);
		
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/customerInfoDelete")
	public ResponseEntity<String> mbrCustomerInfoDelete(@RequestBody CustomCmmCustomerVO req, Model model){
		String res = service.delete(req);
		
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
	
	//회원사 신청 사업자 선택시 사업자정보 
	@RequestMapping(value = "/customerExpr")
	public ResponseEntity<Object> customerExpr(
		HttpServletRequest request,HttpServletResponse response,ModelMap model,CustomReqCustomerVO req) {
		log.debug("회원사 탈퇴");
		log.debug("req.getCustomerId() : " + req.getCustomerId());
		//String companyId =  request.getParameter("companyId");		
		//CustomReqCustomerVO mbrvo = new CustomReqCustomerVO();		
		//mbrvo.setCompanyId(companyId);
		//List<CustomReqCustomerVO> getCustomerList = reqUserService.getCompanySelectList(mbrvo);
		//String getCustomerExprResult = "";
		
		//회원사에 등록된 프로젝트 확인
		int customerProjectcnt = service.customerProjectcnt(req);
		log.debug("customerProjectcnt : " + customerProjectcnt);
		
		if(customerProjectcnt!=0){
			//getCustomerExprResult = "등록된 프로젝트가 있어서 해지 안됨";
			return new ResponseEntity<Object>(customerProjectcnt, HttpStatus.OK);
		}else{
			//해지 신청 처리
			Date requestSeqdate = new Date();
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
			String requestSeq = dateFormat.format(requestSeqdate);
			
			String apprvState = "APPRV_PROCESSING";
			String requestType = "REQTYPE_EXPR";
			String regUserId = req.getCustomerId();
			req.setRequestSeq(requestSeq);
			req.setApprvState(apprvState);
			req.setRequestType(requestType);
			req.setRegUserId(regUserId);
			reqCustomerService.setCustomerForminsert(req);			
			//승인 스텝 처리
			List<CustomReqCustomerVO> getApprovalModelSteplist = reqCustomerService.getApprovalModelSteplist();
			for(int i=0;i<getApprovalModelSteplist.size();i++){			
				CustomReqCustomerVO appmodelstep = new CustomReqCustomerVO();
				appmodelstep.setRequestSeq(requestSeq);
				appmodelstep.setStepId(getApprovalModelSteplist.get(i).getStepId());
				if(!appmodelstep.getStepId().equals(""))
				{
					//stepId로 입력 처리시 작업
				}
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
				reqCustomerService.setSrApprovalStepinsert(appmodelstep);
			}
			List<CustomReqCustomerVO> getApprovalModelMemberlist = reqCustomerService.getApprovalModelMemberlist();
			for(int i=0;i<getApprovalModelMemberlist.size();i++){				
				CustomReqCustomerVO appmember = new CustomReqCustomerVO();
				appmember.setRequestSeq(requestSeq);
				appmember.setStepId(getApprovalModelMemberlist.get(i).getStepId());
				appmember.setUserId(getApprovalModelMemberlist.get(i).getUserId());
				appmember.setApprvAuthFlag(getApprovalModelMemberlist.get(i).getApprvAuthFlag());
				appmember.setMailRecvFlag(getApprovalModelMemberlist.get(i).getMailRecvFlag());
				appmember.setSmsRecvFlag(getApprovalModelMemberlist.get(i).getSmsRecvFlag());
				appmember.setPushRecvFlag(getApprovalModelMemberlist.get(i).getPushRecvFlag());
				
				reqCustomerService.setSrApprovalMemberinsert(appmember);
			}
		}
		
		return new ResponseEntity<Object>(customerProjectcnt, HttpStatus.OK);
	}

	@RequestMapping(value="/customerView")
	@Secured( "ROLE_CUSTOM_ADMIN" )
	public String mngSmsQueueView(Model model, CustomCmmCustomerVO req, Principal principal) {
		try {
			String userId = principal.getName();
			
			req.setManagerId(userId);
			CustomCmmCustomerVO customerView = service.detailManagerId(req);
			
			CustomCmmFileVO vo = new CustomCmmFileVO();			
			vo.setProgramName("cmm_customer");	
			vo.setProgramSeq(customerView.getCustomerId());
			
			req.setUserId(userId);
			req.setCustomerId(customerView.getCustomerId());
			if(req.getBillYyyymm()==null){
				Date dt = new Date();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
				req.setBillYyyymm(sdf.format(dt));
//				req.setBillYyyymm("201709");
				model.addAttribute("customerId", req.getCustomerId());
				model.addAttribute("billYyyymm", req.getBillYyyymm());
			}else{
				model.addAttribute("customerId", req.getCustomerId());
				model.addAttribute("billYyyymm", req.getBillYyyymm());
			}
		
			//Chart 최근3개월 청구금액
			List<CustomCmmCustomerVO> get3MonthAmountList = service.get3MonthAmount2(req, model);
			for (int i = get3MonthAmountList.size(); i < 3; i++) {
				CustomCmmCustomerVO tmp = new CustomCmmCustomerVO();
				tmp.setAmount("0");
				get3MonthAmountList.add(tmp);
			}
			service.get3MonthAmount(req, model);

			// 당월 사용금액
			CustomCmmCustomerVO currentAmount =  service.getCurrentAmount(req);
			//Chart 리소스별 총사용량
			CustomCmmCustomerVO getResourceTotalAmount = service.getResourceTotalAmount2(req, model);
//			service.getResourceTotalAmount(req, model);
			
			//과금년도
			List<CustomBssAdjustmentVO> getBillYyyy = bssAdjustmentService.getBillYyyy();
			
			model.addAttribute("getBillYyyy", getBillYyyy);
			model.addAttribute("customerView", customerView);
			model.addAttribute("get3MonthAmountList", get3MonthAmountList);
			model.addAttribute("currentAmount", currentAmount);
			model.addAttribute("getResourceTotalAmount", getResourceTotalAmount);
			model.addAttribute("file", cmmFileService.list(vo));
			vo.setProgramName("cmm_customer_pic");
			
			List<CustomCmmFileVO> filePicList = cmmFileService.list(vo);
			
			log.debug("filePicList : " + filePicList.size());
			
			model.addAttribute("filePic", filePicList);
			
			return "mbr/cmm/customer/customerView";
		} catch (Exception e) {
			log.error(e.getMessage());
			return "redirect:j_spring_security_logout";
		}
	}	

	@RequestMapping(value="/userPopView")
	public String userPopView(Model model, CustomCmmCustomerVO req) {
		try{	
						
			CustomCmmCustomerVO userView = service.detailUser(req);
			userView.getUserAuthority();	
			
			//프로젝트 관리자
			if(userView.getUserAuthority().charAt(12) == '1'){
				userView.setAuthority1("1");
			}
			//회계담당
			if(userView.getUserAuthority().charAt(11) == '1'){
				userView.setAuthority2("1");
			}
			
			//StringBuffer sb = new StringBuffer(userView.getUserAuthority());
			//log.debug("userView.getUserAuthority()1 : " + userView.getUserAuthority());
			//sb.setCharAt(14, '1');
			
			//log.debug("userView.getUserAuthority()2 : " + sb);
			
			
			model.addAttribute("userView", userView);
		
			return "mbr/cmm/customer/userPopView";
		} catch (Exception e) {
			log.error(e.getMessage());
			return "redirect:j_spring_security_logout";
		}
	
	}
	
	@RequestMapping(value="/userPopViewEdit")
	public String userPopViewEdit(Model model, @RequestBody CustomCmmCustomerVO req) {
		try{
			String authority = req.getUserAuthority();
			StringBuffer userAuthority = new StringBuffer(authority);
			//프로젝트 관리자
			if(req.getAuthority1().equals("1")){
				userAuthority.setCharAt(12, '1');
			}else{
				userAuthority.setCharAt(12, '0');
			}
			//회계담당
			if(req.getAuthority2().equals("1")){
				userAuthority.setCharAt(11, '1');
			}else{
				userAuthority.setCharAt(11, '0');
			}	
			
			req.setUserAuthority(userAuthority.toString());
			
			service.editUser(req);			
			
			CustomCmmCustomerVO userView = service.detailUser(req);
			userView.getUserAuthority();			
			//프로젝트 관리자
			if(userView.getUserAuthority().charAt(12) == '1'){
				userView.setAuthority1("1");
			}
			//회계담당
			if(userView.getUserAuthority().charAt(11) == '1'){
				userView.setAuthority2("1");
			}
						
			model.addAttribute("userView", userView);
		
			return "mbr/cmm/customer/userPopView";
		} catch (Exception e) {
			log.error(e.getMessage());
			return "redirect:j_spring_security_logout";
		}
	
	}
	
	@RequestMapping(value="/userlist", method = RequestMethod.GET, produces="text/plain;charset=UTF-8" )
	public ResponseEntity<Object> userList(CustomCmmCustomerVO req){

		String res = service.userList(req);
		
		if(res.equals("")){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/userViewModal", method = RequestMethod.GET)
	public ResponseEntity<Object> userViewModal(CustomCmmCustomerVO req){
		
		
		CustomCmmCustomerVO userView = service.detailUser(req);
		userView.getUserAuthority();	
		
		//프로젝트 관리자
		if(userView.getUserAuthority().charAt(12) == '1'){
			userView.setAuthority1("1");
		}
		//회계담당
		if(userView.getUserAuthority().charAt(11) == '1'){
			userView.setAuthority2("1");
		}

		HashMap<String, Object> map = new HashMap<>();
		map.put("getCustomerMemberList", userView);
		
		return new ResponseEntity<Object>(userView, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/userModalViewEdit", method = RequestMethod.GET)
	public ResponseEntity<String> userModalViewEdit(@RequestBody CustomCmmCustomerVO req){
 		
		log.debug("req.getUserAuthority() : " + req.getUserAuthority());
		log.debug("req.getUserId() : " + req.getUserId());
		
		StringBuffer userAuthority = new StringBuffer(req.getUserAuthority());
		//프로젝트 관리자
		if(req.getAuthority1().equals("1")){
			userAuthority.setCharAt(12, '1');
		}else{
			userAuthority.setCharAt(12, '0');
		}
		//회계담당
		if(req.getAuthority2().equals("1")){
			userAuthority.setCharAt(11, '1');
		}else{
			userAuthority.setCharAt(11, '0');
		}	
		
		req.setUserAuthority(userAuthority.toString());
		
		log.debug("userAuthority.toString() : " + userAuthority.toString());
		log.debug("req.getUserAuthority() : " + req.getUserAuthority());
		
		String userEdit =  service.editUser(req);
				
		
		return new ResponseEntity<String>(userEdit, HttpStatus.OK);
	}
}
