package com.ivucenter.cloud.portal.alarms.mail.history;

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
@RequestMapping(value="/mng/mailQueue/history")
public class MngMailQueueHistoryController{
	
	@Autowired
	MailQueueHistoryService service;
	

	@RequestMapping(value="/")
	public String mngMailQueueHistory() {
		log.debug("MngMailQueueHistoryController:mngMailQueueHistory()");
		return "mng/operation/mailHistory/mailHistoryList";
		
	}

	@RequestMapping(value="/view")
	public String mngMailQueueHistoryView(Model model, CustomMailQueueHistoryVO req) {			
		model.addAttribute("mailSeq", req.getMailSeq());			
		return "mng/operation/mailHistory/mailHistoryView";		
	}	
	
	@RequestMapping(value="/list", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public ResponseEntity<String> mngMailQueueHistoryList(CustomMailQueueHistoryVO req) {
		String res = service.list(req);		
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}	
	
	/**
	 * 상세 정보
	 */
	@RequestMapping(value = "/detail", produces="application/json;charset=UTF-8")
	public ResponseEntity<Object> mngMailQueueHistoryDetail(CustomMailQueueHistoryVO req) {
		CustomMailQueueHistoryVO res = service.detail(req);
		
		if(res == null){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}	
	
	@RequestMapping(value = "/excel")
	public ModelAndView mngMailQueueHistoryExcel(CustomMailQueueHistoryVO req, ModelMap map) {
		map.addAttribute("excel_gbn", "mailHistory");
		map.addAttribute("excel_title", "알람관리_메일 발송이력");
		map.addAttribute("excel_list", service.excel(req));
		return new ModelAndView("alarmsExcelView", map);
	}	
		
}
