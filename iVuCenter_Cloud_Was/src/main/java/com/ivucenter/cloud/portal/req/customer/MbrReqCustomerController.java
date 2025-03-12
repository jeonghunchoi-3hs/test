package com.ivucenter.cloud.portal.req.customer;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ivucenter.cloud.portal.bbs.notice.BbsNoticeService;
import com.ivucenter.cloud.portal.bbs.notice.CustomBbsNoticeVO;
import com.ivucenter.cloud.portal.req.user.ReqUserService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value="/mbr/req/customer")
public class MbrReqCustomerController {

    private static final Logger logger = LoggerFactory.getLogger(MbrReqCustomerController.class);

	@Autowired
	private ReqCustomerService reqCustomerService;

	@Autowired
	private BbsNoticeService service;

	@Autowired
	private ReqUserService reqUserService;

	//회원사 신청화면
	@RequestMapping(value = "/customerInsert.do",params="!type")
	@Secured( {"ROLE_CUSTOM_ADMIN","ROLE_CUSTOM_USER", "ROLE_CUSTOM_PM"} )
	public String CustomerInsertForm(Model model){

		List<CustomReqCustomerVO> getCompanyList = reqCustomerService.getCompanyList();
		model.addAttribute("vo", getCompanyList);

		return "mbr/req/customer/customerInsert";
	}



	//회원사 ID 중복확인 ajaxcheck
	@RequestMapping(value = "/customerIDajaxcheck")
	public void customerIDajaxchkval(HttpServletRequest request,HttpServletResponse response,ModelMap model ){
		String customerId =  request.getParameter("customerId");

		String customerIDcheck = reqCustomerService.getCustomefIdcheck(customerId);
		boolean customerIDajaxcheck = (StringUtils.isBlank(customerIDcheck)) ? true : false;

		PrintWriter writer = null;
		try {

			writer = response.getWriter();
			writer.write(customerIDajaxcheck+"");
			writer.flush();

		} catch (IOException e) {
			logger.error(" customerIDajaxcheck IOException");
		}finally{
			if(writer!=null){
				writer.close();
			}
		}
	}

	//회원사 이름 중복확인 ajaxcheck
	@RequestMapping(value = "/customerNameajaxcheck")
	public void customerNameajaxchkval(HttpServletRequest request,HttpServletResponse response,ModelMap model ){
		String customerName =  request.getParameter("customerName");

		String customerNamecheck = reqCustomerService.getCustomerNamecheck(customerName);

		boolean customerNameajaxcheck = (StringUtils.isBlank(customerNamecheck)) ? true : false;

		PrintWriter writer = null;
		try {
			writer = response.getWriter();
			writer.write(customerNameajaxcheck+"");
			writer.flush();

		} catch (IOException e) {
			logger.error(" customerNameajaxcheck IOException");
		}finally{
			if(writer!=null){
				writer.close();
			}
		}
	}

	//회원사 신청처리
	@RequestMapping(value = "/customerInsert.do",params="type=write")
	@Secured( {"ROLE_CUSTOM_ADMIN","ROLE_CUSTOM_USER", "ROLE_CUSTOM_PM"} )
	public String CustomerInsertWrite(HttpServletRequest request,HttpServletResponse response,Model model ){

		String customerId =  request.getParameter("customerId");
		String customerName =  request.getParameter("customerName");
		String companyId =  request.getParameter("companyId");
		String contactName =  request.getParameter("contactName");
		String contactPhone1 =  request.getParameter("contactPhone1");
		String contactPhone2 =  request.getParameter("contactPhone2");
		String contactPhone3 =  request.getParameter("contactPhone3");
		String contactTel1 =  request.getParameter("contactTel1");
		String contactTel2 =  request.getParameter("contactTel2");
		String contactTel3 =  request.getParameter("contactTel3");
		String contactMail =  request.getParameter("contactMail");
		String smsRecvFlag =  request.getParameter("smsRecvFlag");
		// String autoStringtext =  request.getParameter("autoStringtext");
		String contactPhone = contactPhone1+"-"+contactPhone2+"-"+contactPhone3;
		String contactTel = contactTel1+"-"+contactTel2+"-"+contactTel3;

		Date requestSeqdate = new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
		String requestSeq = dateFormat.format(requestSeqdate);

		contactMail = contactMail+"@3hs.co.kr";
		CustomReqCustomerVO customervo = new CustomReqCustomerVO();
		customervo.setCustomerId(customerId);
		customervo.setCustomerName(customerName);
		customervo.setCompanyId(companyId);
		customervo.setContactName(contactName);
		customervo.setContactPhone(contactPhone);
		customervo.setContactTel(contactTel);
		customervo.setSmsRecvFlag(smsRecvFlag);
		customervo.setRequestSeq(requestSeq);
		customervo.setContactMail(contactMail);

		customervo.setRequestType("REQTYPE_NEW");

		int chkval = reqCustomerService.setCustomerFormchk(customervo);
		//회원사 아이디, 이름 중복 검증
		if(chkval != 0){
			// 중복 메시지 전달
			List<CustomReqCustomerVO> getCompanyList = reqCustomerService.getCompanyList();
			model.addAttribute("vo", getCompanyList);
			model.addAttribute("errortext", "회원사 아이디 또는 이름을 사용하실 수 없습니다.");
			return "mbr/req/customer/customerInsert";
		}

		reqCustomerService.setCustomerForminsert(customervo);
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
		return "mbr/req/customer/customerInsert";
	}


	//회원사 신청처리
	@RequestMapping(value = "/reqcustomerinsert")
	public ResponseEntity<String> ReqcustomerInsert(HttpServletRequest request, ModelMap model) {

		String autoStringtext =  request.getParameter("autoStringtext");
		String autoStringtextHash =  request.getParameter("autoStringtextHash");
		int hash = 5381;
		autoStringtext = autoStringtext.toUpperCase();
		for(int i=0;i<autoStringtext.length();i++){
			hash =((hash<<5)+hash)+autoStringtext.charAt(i);
		}
		if(!autoStringtextHash.equals(hash+"")){
			return new ResponseEntity<String>("3", HttpStatus.OK);
		}

		String customerId =  request.getParameter("customerId");
		String customerName =  request.getParameter("customerName");
		String companyId =  request.getParameter("companyId");
		String contactName =  request.getParameter("contactName");
		String contactPhone1 =  request.getParameter("contactPhone1");
		String contactPhone2 =  request.getParameter("contactPhone2");
		String contactPhone3 =  request.getParameter("contactPhone3");
		String contactTel1 =  request.getParameter("contactTel1");
		String contactTel2 =  request.getParameter("contactTel2");
		String contactTel3 =  request.getParameter("contactTel3");
		String contactMail =  request.getParameter("contactMail");
		String smsRecvFlag =  request.getParameter("smsRecvFlag");
		String contactPhone = contactPhone1+"-"+contactPhone2+"-"+contactPhone3;
		String contactTel = contactTel1+"-"+contactTel2+"-"+contactTel3;

		Date requestSeqdate = new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
		String requestSeq = dateFormat.format(requestSeqdate);

		contactMail = contactMail+"@3hs.co.kr";
		CustomReqCustomerVO customervo = new CustomReqCustomerVO();
		customervo.setCustomerId(customerId);
		customervo.setCustomerName(customerName);
		customervo.setCompanyId(companyId);
		customervo.setContactName(contactName);
		customervo.setContactPhone(contactPhone);
		customervo.setContactTel(contactTel);
		customervo.setSmsRecvFlag(smsRecvFlag);
		customervo.setRequestSeq(requestSeq);
		customervo.setContactMail(contactMail);

		customervo.setRequestType("REQTYPE_NEW");

		int chkval = reqCustomerService.setCustomerFormchk(customervo);
		//회원사 아이디, 이름 중복 검증
		if(chkval != 0){
			// 중복 메시지 전달
			List<CustomReqCustomerVO> getCompanyList = reqCustomerService.getCompanyList();
			model.addAttribute("vo", getCompanyList);
			model.addAttribute("errortext", "회원사 아이디 또는 이름을 사용하실 수 없습니다.");
			return new ResponseEntity<String>(HttpStatus.NO_CONTENT);
		}
		reqCustomerService.setCustomerForminsert(customervo);
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
		String res="1";
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}


	//회원사 신청 사업자 선택시 사업자정보
	@RequestMapping(value = "/companySelect")
	public ResponseEntity<Object> companySelect(HttpServletRequest request) {
		log.debug("companySelect");

		String companyId =  request.getParameter("companyId");
		CustomReqCustomerVO mbrvo = new CustomReqCustomerVO();
		mbrvo.setCompanyId(companyId);
		List<CustomReqCustomerVO> getCompanyList = reqCustomerService.getCompanyList();

		return new ResponseEntity<Object>(getCompanyList, HttpStatus.OK);
	}


	//회원사 신청현황 목록 화면
	@RequestMapping(value="/")
	@Secured( {"ROLE_CUSTOM_ADMIN","ROLE_CUSTOM_USER", "ROLE_CUSTOM_PM"} )
	public String mngCustomer() {

		return "mbr/req/customer/customerList";
	}

	//회원사 신청현황 목록 조회
	@RequestMapping(value="/list", method = RequestMethod.GET)
	public ResponseEntity<Object> mbrCustomerList(CustomReqCustomerVO req){
		log.info("=== mbrCustomerList Controller ===");

  		String apprvCodeKeyId="APPRV_STATE";
  		String requestCodeKeyId="REQUEST_TYPE";
  		req.setApprvCodeKeyId(apprvCodeKeyId);
  		req.setRequestCodeKeyId(requestCodeKeyId);
		String res = reqCustomerService.list(req);

		if(res.equals("")){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	//회원사 신청현황 상세 화면
	@RequestMapping(value="/view")
	@Secured( {"ROLE_CUSTOM_ADMIN","ROLE_CUSTOM_USER", "ROLE_CUSTOM_PM"} )
	public String mbrBbsNoticeView(Model model, CustomReqCustomerVO req) {

		model.addAttribute("requestSeq", req.getRequestSeq());

		String codeKeyId="APPRV_STATE";
		String requestSeq =req.getRequestSeq();
		List<CustomReqCustomerVO> approvalList  = reqCustomerService.approvalList(requestSeq);

		List<CustomReqCustomerVO> approvalUserId  = reqCustomerService.approvalUserId(requestSeq);

		List<CustomBbsNoticeVO> getNoticeBbscodeList = service.getNoticeBbscodeList(codeKeyId);
		model.addAttribute("code", getNoticeBbscodeList);
		model.addAttribute("getProjectAppSteplist", approvalList);
		model.addAttribute("approvalUserId", approvalUserId);

		CustomReqCustomerVO detail = reqCustomerService.detail(requestSeq);
		model.addAttribute("detail", detail);

		return "mbr/req/customer/customerView";
	}

	//회원사 신청현황 상세 조회
	@RequestMapping(value = "/detail", method = RequestMethod.POST)
	public ResponseEntity<Object> mbrCustomerDetail(String requestSeq) {
		log.info("=== mbrDetail Controller ===");

		CustomReqCustomerVO res = reqCustomerService.detail(requestSeq);

		if(res == null){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}

		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

}