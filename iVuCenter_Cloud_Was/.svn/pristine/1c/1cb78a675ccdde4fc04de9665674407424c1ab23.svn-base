package com.ivucenter.cloud.portal.alarms.sms.template;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value="/mng/sms/template")
public class MngSmsTemplateController{
	
	@Autowired
	private SmsTemplateService service;
	
	/**
	 *	PAGE 
	 */
	@RequestMapping(value="/")
	public String mngSmsTemplate() {
	
		return "mng/operation/smsTemplate/smsTemplateList";
	}
	@RequestMapping(value="/view")
	public String mngSmsTemplateView(CustomSmsTemplateVO req, Model model) {
		try {			
			model.addAttribute("templateId", req.getTemplateId());
			return "mng/operation/smsTemplate/smsTemplateView";
		} catch (Exception e) {
			log.error(e.getMessage());
			return "redirect:j_spring_security_logout";
		}
	}	
	@RequestMapping(value="/write")
	public String mngSmsTemplateWrite(CustomSmsTemplateVO req, Model model) {
		try {
			
			model.addAttribute("templateId", req.getTemplateId());
			return "mng/operation/smsTemplate/smsTemplateWrite";
		} catch (Exception e) {
			log.error(e.getMessage());
			return "redirect:j_spring_security_logout";
		}
	}	
	
	/**
	 *	ACTION 
	 */	
	@RequestMapping(value="/list", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public ResponseEntity<String> mngSmsTemplateList(CustomSmsTemplateVO req) {
		String res = service.list(req);
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}	
	@RequestMapping(value = "/detail")
	public ResponseEntity<CustomSmsTemplateVO> mngSmsTemplateDetail(CustomSmsTemplateVO req) {
		CustomSmsTemplateVO res = service.detail(req);
		return new ResponseEntity<CustomSmsTemplateVO>(res, HttpStatus.OK);
	}
	@RequestMapping(value = "/update")
	public ResponseEntity<String> mngSmsTemplateUpdate(@RequestBody CustomSmsTemplateVO req, Model model) {
		String res = service.update(req);
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
	@RequestMapping(value = "/excel")
	public ModelAndView mngSmsTemplateExcel(CustomSmsTemplateVO req, ModelMap map) {
		map.addAttribute("excel_gbn", "smsTemplate");
		map.addAttribute("excel_title", "알람관리_SMS 템플릿");
		map.addAttribute("excel_list", service.excel(req));
		return new ModelAndView("alarmsExcelView", map);
	}		
}
