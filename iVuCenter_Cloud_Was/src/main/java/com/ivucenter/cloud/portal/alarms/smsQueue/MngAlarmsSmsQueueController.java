package com.ivucenter.cloud.portal.alarms.smsQueue;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.security.NoSuchAlgorithmException;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ivucenter.cloud.portal.alarms.sms.queue.SmsQueueService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value="/mng/alarms/smsQueue")
public class MngAlarmsSmsQueueController {
	
	@Autowired
	private SmsQueueService service;
	
//	@Autowired	private CmmUserService cmmUserService;

	@RequestMapping(value="/")
	public String mngSmsQueue() {
		log.debug("MngAlarmsSmsQueueController:mngSmsQueue()");
		return "mng/alarms/smsQueue/smsQueue-write";
	}
	/*
	@RequestMapping(value="/list", method = RequestMethod.GET)
	public ResponseEntity<String> mngSmsQueueList(CustomSmsQueueVO req) {
		String res = service.list(req);
		
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}	
	*/
	@RequestMapping(value = "/insert")
	public ResponseEntity<String> mngSmsQueueInsert(@RequestParam Map<String, String> params) 
			throws UnsupportedEncodingException, NoSuchAlgorithmException, GeneralSecurityException {
		return new ResponseEntity<String>(service.insert(params), HttpStatus.OK);
	}
	

}
