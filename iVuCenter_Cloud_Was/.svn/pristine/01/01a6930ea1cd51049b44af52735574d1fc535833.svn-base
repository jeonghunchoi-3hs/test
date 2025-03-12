package com.ivucenter.cloud.portal.alarms.sms.queue;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.security.NoSuchAlgorithmException;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.ivucenter.cloud.portal.cmm.user.CmmUserService;
import com.ivucenter.cloud.portal.cmm.user.CustomCmmUserVO;
import com.ivucenter.cloud.portal.login.UserSession;

@Controller
@RequestMapping(value="/mng/sms/queue")
public class MngSmsQueueController{
	
	@Autowired
	private SmsQueueService service;
	
	@Autowired
	private CmmUserService cmmUserService;

	@RequestMapping(value="/")
	public String mngSmsQueue(Model model) {
		UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		model.addAttribute("senderName", userSession.getNickname());
		CustomCmmUserVO vo = new CustomCmmUserVO();
		vo.setUserId(userSession.getUsername());
		CustomCmmUserVO vo2 = cmmUserService.detail(vo);
		model.addAttribute("senderNumber", vo2.getUserPhone());
		
		return "mng/operation/smsQueue/smsQueueWrite";
	}
	
	@RequestMapping(value="/list", method = RequestMethod.GET)
	public ResponseEntity<String> mngSmsQueueList(CustomSmsQueueVO req) {
		String res = service.list(req);
		
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}	
	
	@RequestMapping(value = "/insert") 
	public ResponseEntity<String> mngSmsQueueInsert(@RequestParam Map<String, String> params) 
			throws UnsupportedEncodingException, NoSuchAlgorithmException, GeneralSecurityException {
		String res = service.insert(params);			
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
	
}
