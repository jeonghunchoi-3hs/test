package com.ivucenter.cloud.portal.alarms.mail.template;

import java.security.Principal;

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
@RequestMapping(value="/mng/mail/template")
public class MngMailTemplateController{
	
	@Autowired
	MailTemplateService service;

	@RequestMapping(value="/")
	public String mngMailTemplate(Model model) {
		log.debug("MngMailTemplateController:mngMailTemplate()");
		return "mng/operation/mailTemplate/mailTemplateList";
	}

	@RequestMapping(value="/view")
	public String mngMailTemplateView(CustomMailTemplateVO req, Model model) {
		try {
			
			model.addAttribute("templateId", req.getTemplateId());
			
			return "mng/operation/mailTemplate/mailTemplateView";
		} catch (Exception e) {
			return "redirect:j_spring_security_logout";
		}
	}	

	@RequestMapping(value="/write")
	public String mngMailTemplatewrite(CustomMailTemplateVO req, Model model) {
		try {
			
			model.addAttribute("templateId", req.getTemplateId());
			
			return "mng/operation/mailTemplate/mailTemplateWrite";
		} catch (Exception e) {
			return "redirect:j_spring_security_logout";
		}
	}	
	
	
	@RequestMapping(value="/list", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public ResponseEntity<String> mngMailTemplateList(CustomMailTemplateVO req) {
		String res = service.list(req);
		
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}	
	
	@RequestMapping(value = "/detail")
	public ResponseEntity<CustomMailTemplateVO> mngMailTemplateDetail(CustomMailTemplateVO req) {
		CustomMailTemplateVO res = service.detail(req);
		
		return new ResponseEntity<CustomMailTemplateVO>(res, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/update")
	public ResponseEntity<String> mngMailTemplateInsert(@RequestBody CustomMailTemplateVO req, Model model, Principal principal) {		
		req.setModUserId(principal.getName());		
		String res = service.update(req);
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/excel")
	public ModelAndView mngMailTemplateExcel(CustomMailTemplateVO req, ModelMap map) {
		map.addAttribute("excel_gbn", "mailTemplate");
		map.addAttribute("excel_title", "알람관리_메일 템플릿");
		map.addAttribute("excel_list", service.excel(req));
		return new ModelAndView("alarmsExcelView", map);
	}	
}
