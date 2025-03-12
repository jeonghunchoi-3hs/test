package com.ivucenter.cloud.portal.alarms.template;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value="/mng/alarms/template")
public class MngAlarmsTemplateController {

	//@Autowired	private SmsTemplateService smsTempService;	
	//@Autowired	private MailTemplateService mailTempService;	
	//@Autowired	private NhwithService nhWithService;
	
	/**
	 * 알림관리 템플릿 리스트 화면
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/")
	public String mngTemplate(Model model, HttpServletRequest request) {		
			
		model.addAttribute("tempGubun", request.getParameter("tempGubun"));
		return "mng/alarms/template/template_list";
		
	}
	
	/**
	 * 템플릿 상세화면
	 * @param req
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/view")
	public String mngTemplateView(HttpServletRequest request, Model model) {
		try {			
			model.addAttribute("templateId", request.getParameter("templateId"));
			model.addAttribute("tempGubun", request.getParameter("tempGubun"));
			return "mng/alarms/template/template_view";
		} catch (Exception e) {
			log.error(e.getMessage());
			return "redirect:j_spring_security_logout";
		}
	}
	
	/**
	 * 템플릿 수정화면
	 * @param req
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/write")
	public String mngSmsTemplateWrite(HttpServletRequest request, Model model) {
		try {			
			model.addAttribute("templateId", request.getParameter("templateId"));
			model.addAttribute("tempGubun", request.getParameter("tempGubun"));
			return "mng/alarms/template/template_write";
		} catch (Exception e) {
			log.error(e.getMessage());
			return "redirect:j_spring_security_logout";
		}
	}	
	
	
}
