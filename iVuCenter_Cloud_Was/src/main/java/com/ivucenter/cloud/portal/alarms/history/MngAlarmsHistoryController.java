package com.ivucenter.cloud.portal.alarms.history;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ivucenter.cloud.portal.alarms.sms.history.SmsQueueHistoryService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value="/mng/alarms/history")
public class MngAlarmsHistoryController {
	
	@Autowired
	SmsQueueHistoryService smsHistoryService;
	
	/**
	 * 알림관리 발송이력 리스트 화면
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/")
	public String mngHistory(Model model, HttpServletRequest request) {
		log.debug("MngAlarmsHistoryController:mngHistory()");
		try {			
			model.addAttribute("historyGubun", request.getParameter("historyGubun"));
			return "mng/alarms/history/history_list";
		} catch (RuntimeException | LinkageError e) {
			return "redirect:j_spring_security_logout";
		}
	}
	
	/**
	 * 발송이력 상세화면
	 * @param req
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/view")
	public String mngHistoryView(HttpServletRequest request, Model model) {
		try {			
			model.addAttribute("historySeq", request.getParameter("historySeq"));
			model.addAttribute("historyGubun", request.getParameter("historyGubun"));
			return "mng/alarms/history/history_view";
		} catch (RuntimeException | LinkageError e) {
			return "redirect:j_spring_security_logout";
		}
	}
	
	
	/**
	 * sms 발송이력 목록 조회
	 * @param req
	 * @return
	 */
//	@RequestMapping(value="/smsHistoryList", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
//	public ResponseEntity<String> mngSmsHistoryList(CustomSmsQueueHistoryVO req) {
//		String res = smsHistoryService.list(req);
//		return new ResponseEntity<String>(res, HttpStatus.OK);
//	}
	
	
	/**
	 * sms 발송이력 상세 조회
	 * @param req
	 * @return
	 */
//	@RequestMapping(value = "/smsHistoryDetail", produces="application/json;charset=UTF-8")
//	public ResponseEntity<Object> mngSmsHistoryDetail(CustomSmsQueueHistoryVO req) {
//		CustomSmsQueueHistoryVO res = smsHistoryService.detail(req);
//		if(res == null){
//			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
//		}
//		return new ResponseEntity<Object>(res, HttpStatus.OK);
//	}	

}
