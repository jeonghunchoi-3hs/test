package com.ivucenter.cloud.portal.alarms.sms.history;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value="/mng/smsQueue/history")
public class MngSmsQueueHistoryController{
	
	@Autowired
	SmsQueueHistoryService service;
	
	/**
	 *	PAGE 
	 */
	@RequestMapping(value="/")
	public String mngSmsQueueHistory() {		
		return "mng/operation/smsHistory/smsHistoryList";
		
	}
	
	@RequestMapping(value="/view")
	public String mngSmsQueueHistoryView(Model model, CustomSmsQueueHistoryVO req) {
		try {			
			model.addAttribute("smsSeq", req.getSmsSeq());
			return "mng/operation/smsHistory/smsHistoryView";
		} catch (Exception e) {
			log.error(e.getMessage());
			return "redirect:j_spring_security_logout";
		}
	}
	
	/**
	 *	ACTION 
	 */	
	@RequestMapping(value="/list", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public ResponseEntity<String> mngSmsQueueHistoryList(CustomSmsQueueHistoryVO req) {
		String res = service.list(req);
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}	
	@RequestMapping(value = "/detail", produces="application/json;charset=UTF-8")
	public ResponseEntity<Object> mngSmsQueueHistoryDetail(CustomSmsQueueHistoryVO req) {
		CustomSmsQueueHistoryVO res = service.detail(req);
		if(res == null){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}	
	@RequestMapping(value = "/excel")
	public ModelAndView mngSmsQueueHistoryExcel(CustomSmsQueueHistoryVO req, ModelMap map) {
		map.addAttribute("excel_gbn", "smsHistory");
		map.addAttribute("excel_title", "알람관리_SMS 발송이력");
		map.addAttribute("excel_list", service.excel(req));
		return new ModelAndView("alarmsExcelView", map);
	}			
}
