package com.ivucenter.cloud.main;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.security.NoSuchAlgorithmException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value="/mng/DBEncrypt")
public class DBEncryptController {

	@Autowired
	DBEncryptService service;
	
	@RequestMapping(value="/enc/{gbn}")
	public void dBEncryptEnc(@PathVariable("gbn") String gbn) throws UnsupportedEncodingException, NoSuchAlgorithmException, GeneralSecurityException{
//		System.out.println("gbn=>"+gbn);
		if(gbn.equals("ALL")){
    		service.DBEncryptCmmCustomer();
    		service.DBEncryptCmmUser();
			service.DBEncryptHrsystemTemporary();
			service.DBEncryptMailQueue();
			service.DBEncryptMailQueueHistory();
			service.DBEncryptNhwithQueueHistory();
			service.DBEncryptSmsQueue();
			service.DBEncryptSmsQueueHistory();
		}
		else if(gbn.equals("cmm_customer")){ service.DBEncryptCmmCustomer(); }
		else if(gbn.equals("cmm_user")){ service.DBEncryptCmmUser(); }
		else if(gbn.equals("hrsystem_temporary")){ service.DBEncryptHrsystemTemporary(); }
		else if(gbn.equals("mail_queue")){ service.DBEncryptMailQueue(); }
		else if(gbn.equals("mail_queue_history")){ service.DBEncryptMailQueueHistory(); }
		else if(gbn.equals("nhwith_queue_history")){ service.DBEncryptNhwithQueueHistory(); }
		else if(gbn.equals("sms_queue")){ service.DBEncryptSmsQueue(); }
		else if(gbn.equals("SmsQueueHistoryList")){ service.DBEncryptSmsQueueHistory(); }
	}
	
	@RequestMapping(value="/dec/{gbn}")
	public void dBEncryptDec(@PathVariable("gbn") String gbn) throws UnsupportedEncodingException, NoSuchAlgorithmException, GeneralSecurityException{
//		System.out.println("gbn=>"+gbn);
		if(gbn.equals("ALL")){
    		service.DBEncryptDecCmmCustomer();
    		service.DBEncryptDecCmmUser();
			service.DBEncryptDecHrsystemTemporary();
			service.DBEncryptDecMailQueue();
			service.DBEncryptDecMailQueueHistory();
			service.DBEncryptDecNhwithQueueHistory();
			service.DBEncryptDecSmsQueue();
			service.DBEncryptDecSmsQueueHistory();
		}
		else if(gbn.equals("cmm_customer")){ service.DBEncryptDecCmmCustomer(); }
		else if(gbn.equals("cmm_user")){ service.DBEncryptDecCmmUser(); }
		else if(gbn.equals("hrsystem_temporary")){ service.DBEncryptDecHrsystemTemporary(); }
		else if(gbn.equals("mail_queue")){ service.DBEncryptDecMailQueue(); }
		else if(gbn.equals("mail_queue_history")){ service.DBEncryptDecMailQueueHistory(); }
		else if(gbn.equals("nhwith_queue_history")){ service.DBEncryptDecNhwithQueueHistory(); }
		else if(gbn.equals("sms_queue")){ service.DBEncryptDecSmsQueue(); }
		else if(gbn.equals("SmsQueueHistoryList")){ service.DBEncryptDecSmsQueueHistory(); }
	}
}
