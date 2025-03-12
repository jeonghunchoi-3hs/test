package com.ivucenter.cloud.portal.mbrinfo;

import java.util.UUID;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ivucenter.cloud.portal.alarms.mail.template.MailTemplateService;
import com.ivucenter.cloud.portal.alarms.sms.template.SmsTemplateService;
import com.ivucenter.cloud.portal.alarms.withnh.NhwithSendService;
import com.ivucenter.cloud.portal.cmm.customer.CmmCustomerService;
import com.ivucenter.cloud.portal.cmm.customer.CustomCmmCustomerVO;
import com.ivucenter.cloud.portal.cmm.department.CmmDepartmentService;
import com.ivucenter.cloud.portal.cmm.department.CustomCmmDepartmentVO;
import com.ivucenter.cloud.portal.cmm.user.CmmUserService;
import com.ivucenter.cloud.portal.cmm.user.CustomCmmUserVO;
import com.ivucenter.cloud.portal.util.CodeUtil;
import com.ivucenter.cloud.portal.util.TokenGenerator;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value="/mbr/mbrinfo")
public class MbrInfoSearchController {

	@Autowired
	private CmmUserService service;
	
	@Autowired
	private CmmCustomerService customerservice;
	
	@Autowired
	private CmmDepartmentService cmmDepartmentService ;
	
	@Autowired
	private SmsTemplateService smsTemplateService;
	
	@Autowired
	private MailTemplateService	mailTemplateService;
	
	@Autowired
	private NhwithSendService nhwithSendService;
	
	@RequestMapping(value="/")
	public String mbrCmmUser(Model model) {
		log.debug("MbrInfoSearchController:mbrCmmUser()");
		return "mbr/mbrinfo/mbrinfosearch"; 
	}
	
	@RequestMapping(value="/mbrinfosearch")
	public String mbrUserInfo(Model model) {
		
		return "mbr/mbrinfo/mbrinfosearch"; 
	}
	
	// 사용자 아이디 찾기 확인
	@RequestMapping(value = "/useridSearch")
	public ResponseEntity<String> useridSearch(CustomCmmUserVO req){
		
		final String recvFlag = req.getRecvFlag();
		if(recvFlag.equals("SMS")){
			req.setSearchKind("user_phone");
			req.setKeyword(req.getUserPhoneEnc());
			req.setKeyword2(req.getUserPhoneEnc2());
		} else {
			req.setSearchKind("user_mail");
			req.setKeyword(req.getUserMailEnc());
		} 
		
		CustomCmmUserVO getUserInfo = service.getUserInfoByName(req);
		
		if(getUserInfo==null){
			return new ResponseEntity<String>("0", HttpStatus.OK);
		}
		
		final String status = getUserInfo.getUserStatus();
		if(status.equals(CodeUtil.LOGIN_USER_STATUS_WITHDRAWAL) || 
		   status.equals(CodeUtil.LOGIN_USER_STATUS_RETIREMENT)) {
			return new ResponseEntity<String>("0", HttpStatus.OK);
		}		
		
		//비밀번호 찾기 처리
//		UUID uid= UUID.randomUUID();
//		String newpassword = TokenGenerator.generate(uid.toString()).substring(0, 10);
//		String mailpw= newpassword; 
//		getUserInfo.setUserPassword(TokenGenerator.generate(getUserInfo.getUserId(), newpassword));			
//		service.setUserPasswordReset(getUserInfo);
//		
//		getUserInfo.setUserPhone(getUserInfo.getUserPhoneDec()); 
//		getUserInfo.setUserTel(getUserInfo.getUserTelDec()); 
//		getUserInfo.setUserMail(getUserInfo.getUserMailDec()); 
		
		if(recvFlag.equals("SMS")){
			smsTemplateService.alarms("50", getUserInfo, getUserInfo.getUserId(), "");
		}else if(recvFlag.equals("NHWith")){
			nhwithSendService.alarms("50", getUserInfo, getUserInfo.getUserId(), "");
		}else if(recvFlag.equals("Mail")){
			mailTemplateService.alarms("50", getUserInfo, getUserInfo.getUserId(), "");
		}
				
		return new ResponseEntity<String>("1", HttpStatus.OK);
	}
	
	// 사용자 패스워드 찾기 확인
	@RequestMapping(value = "/userpwSearch")
	public ResponseEntity<String> userpwSearch(CustomCmmUserVO req){
					
		final String recvFlag = req.getRecvFlag();
		if(recvFlag.equals("SMS")){
			req.setSearchKind("user_phone");
			req.setKeyword(req.getUserPhoneEnc());
			req.setKeyword2(req.getUserPhoneEnc2());
		} else {
			req.setSearchKind("user_mail");
			req.setKeyword(req.getUserMailEnc());
		}
		
		CustomCmmUserVO getUserInfo = service.getUserInfoById(req);
		
		if(getUserInfo==null){
			return new ResponseEntity<String>("0", HttpStatus.OK);
		}
		
		final String status = getUserInfo.getUserStatus();
		if(status.equals(CodeUtil.LOGIN_USER_STATUS_WITHDRAWAL) || 
		   status.equals(CodeUtil.LOGIN_USER_STATUS_RETIREMENT)) {
			return new ResponseEntity<String>("0", HttpStatus.OK);
		}

		//비밀번호 찾기 처리
		UUID uid= UUID.randomUUID();
		String newpassword = TokenGenerator.generate(uid.toString()).substring(0, 10);
		String mailpw= newpassword; 
		getUserInfo.setUserPassword(TokenGenerator.generate(getUserInfo.getUserId(), newpassword));			
		service.setUserPasswordReset(getUserInfo);
		
		//getUserInfo.setUserPhone(getUserInfo.getUserPhoneDec()); 
		//getUserInfo.setUserTel(getUserInfo.getUserTelDec()); 
		//getUserInfo.setUserMail(getUserInfo.getUserMailDec()); 
		
		if(recvFlag.equals("SMS")){
			smsTemplateService.alarms("51", getUserInfo, mailpw, "");
		}else if(recvFlag.equals("NHWith")){
			nhwithSendService.alarms("51", getUserInfo, mailpw, "");
		}else if(recvFlag.equals("Mail")){
			mailTemplateService.alarms("51", getUserInfo, mailpw, "");
		}
		
		return new ResponseEntity<String>("1", HttpStatus.OK);
	}
	
	// 회원사 아이디 찾기 확인
	@RequestMapping(value = "/customeridSearch")
	public ResponseEntity<String> customeridSearch(CustomCmmCustomerVO req){
		
		CustomCmmCustomerVO getUserInfo = customerservice.getCustomerInfo(req);
		
		String res="";
		if(getUserInfo==null){
			res="0";
			log.debug("정보 없음");
		}else{
			res="1";
			
			UUID mailSeq= UUID.randomUUID();
			req.setMailSeq(mailSeq.toString());
			
			req.setTemplateId(CodeUtil.MAL0050);			
			req.setTitle(CodeUtil.MAILIDTITLE);
			req.setContent(CodeUtil.MAILIDCONTENT.replace("ID", getUserInfo.getCustomerId()));
			
			req.setReceiverFlg(CodeUtil.CUSTOMERRECEIVERFLG);
			
			req.setReceiverId(getUserInfo.getCustomerId());

			req.setRegUserId(getUserInfo.getCustomerId());
			
			//아이디 찾기 처리 이메일 데이터 입력
			String setIdSearchResult = customerservice.setSearchResult(req);
			log.debug("setIdSearchResult : " + setIdSearchResult);
			
		}
		
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
	
	
	// 회원사 아이디 찾기 확인
	@RequestMapping(value = "/customerpwSearch")
	public ResponseEntity<String> customerpwSearch(CustomCmmCustomerVO req){
			
		CustomCmmCustomerVO getUserInfo = customerservice.getCustomerInfopw(req);
			
		String res="";
		String newpassword = "";
		if(getUserInfo==null){
			res="0";
			log.debug("정보 없음");
		}else{
			res="1";
				
			//비밀번호 찾기 처리
			UUID uid= UUID.randomUUID();
			newpassword = TokenGenerator.generate(uid.toString());
			log.debug("newpassword : " + newpassword);

			newpassword = newpassword.substring(0, 10); 
			log.debug("newpassword : " + newpassword);
			String mailpw= newpassword;
			
			newpassword = TokenGenerator.generate(getUserInfo.getCustomerId(), newpassword);
			log.debug("newpassword : " + newpassword);
				
			String setUserInfo = customerservice.setUserInfo(getUserInfo);
			log.debug("setUserInfo : " + setUserInfo);
			
			UUID mailSeq= UUID.randomUUID();
			req.setMailSeq(mailSeq.toString());
			
			req.setTemplateId(CodeUtil.MAL0050);			
			req.setTitle(CodeUtil.MAILPWTITLE);
			req.setContent(CodeUtil.MAILPWCONTENT.replace("PW", mailpw));				
			req.setReceiverFlg(CodeUtil.CUSTOMERRECEIVERFLG);
			
			req.setReceiverId(getUserInfo.getCustomerId());
			req.setRegUserId(getUserInfo.getCustomerId());
						
			//비밀번호 찾기 처리 이메일 데이터 입력
			String setPwSearchResult = customerservice.setSearchResult(req);
			log.debug("setPwSearchResult : " + setPwSearchResult);
		}
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/TreeAll", produces="text/plain;charset=UTF-8")
	public ResponseEntity<String> MngCmmDepartmentTreeAll(CustomCmmDepartmentVO req) {
		String res = cmmDepartmentService.TreeAll(req);
		if(StringUtils.isBlank(res)) {
			return new ResponseEntity<String>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
}
