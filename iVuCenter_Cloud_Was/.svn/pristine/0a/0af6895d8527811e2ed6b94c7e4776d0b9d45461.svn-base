package com.ivucenter.cloud.portal.alarms.withnh;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
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
@RequestMapping(value="/mng/nhwith/template")
public class MngNhwithController {

	@Autowired
	private NhwithService nhwithService;
	
	@RequestMapping(value="/")
	@Secured("ROLE_CLOUD_ADMIN")
	public String Nhwith() {
		log.debug("MngNhwithController:Nhwith()");
		return "mng/nhwith/template/nhwithTemplateList";		
	}
	
	//nhwith 템플릿 리스트
	@RequestMapping(value = "/nhwithTemplateList")
	public String nhwithTemplateList(){				
		return "mng/nhwith/template/nhwithTemplateList";
	}
	
	@RequestMapping(value="/templateView")
	public String templateView(CustomNhwithVO req, Model model) {
		try {			
			model.addAttribute("templateId", req.getTemplateId());			
			return "mng/nhwith/template/templateView";
		} catch (Exception e) {
			return "redirect:j_spring_security_logout";
		}
	}
	
	@RequestMapping(value="/templateWrite")
	public String templateWrite(CustomNhwithVO req, Model model) {
		try {			
			model.addAttribute("templateId", req.getTemplateId());			
			return "mng/nhwith/template/templateWrite";
			
		} catch (Exception e) {
			return "redirect:j_spring_security_logout";
		}
	}
	
	//nhwith History 템플릿 리스트
	@RequestMapping(value = "/nhwithTemplateHistoryList.do")
	public String nhwithTemplateHistoryList(){					
		return "mng/nhwith/template/nhwithTemplateHistoryList";
	}
	
	//nhwith History 템플릿 상세
	@RequestMapping(value = "/nhwithTemplateHistoryView")
	public String nhwithTemplateHistoryView(Model model,ModelMap modelMap,CustomNhwithVO req){
			
		model.addAttribute("nhwithSeq", req.getNhwithSeq());
		return "mng/nhwith/template/nhwithTemplateHistoryView";
	}
	
	@RequestMapping(value="/nhwithTemplatelist", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public ResponseEntity<String> nhwithTemplatelist(CustomNhwithVO req){		
		String res = nhwithService.nhwithTemplatelist(req);
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
	
	@RequestMapping(value="/nhwithTemplateHistoryList", method = RequestMethod.GET)
	public ResponseEntity<String> nhwithTemplateHistoryList(CustomNhwithVO req){		
		String res = nhwithService.nhwithTemplateHistoryList(req);
		return new ResponseEntity<String>(res, HttpStatus.OK);			
	}
	
	@RequestMapping(value = "/nhwithTemplateHistoryDetail")
	public ResponseEntity<CustomNhwithVO> nhwithTemplateHistoryDetail(CustomNhwithVO req){
		CustomNhwithVO res = nhwithService.nhwithTemplateHistoryDetail(req);
		return new ResponseEntity<CustomNhwithVO>(res, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/templateviewDetail")
	public ResponseEntity<CustomNhwithVO> templateviewDetail(CustomNhwithVO req){
		CustomNhwithVO res = nhwithService.templateviewDetail(req);
		return new ResponseEntity<CustomNhwithVO>(res, HttpStatus.OK);
	}
	
	
	@RequestMapping(value = "/templateUpdate")
	public ResponseEntity<String> templateUpdate(@RequestBody CustomNhwithVO req, Principal principal) {
		
		req.setModUserId(principal.getName());
		String res = nhwithService.templateUpdate(req);
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/excel")
	public ModelAndView mngSmsTemplateExcel(CustomNhwithVO req, ModelMap map) {
		map.addAttribute("excel_gbn", "nhWithTemplate");
		map.addAttribute("excel_title", "알람관리_NHWITH 템플릿");
		map.addAttribute("excel_list", nhwithService.excel(req));
		return new ModelAndView("alarmsExcelView", map);
	}	
	
	@RequestMapping(value = "/historyExcel")
	public ModelAndView mngSmsTemplateHistoryExcel(CustomNhwithVO req, ModelMap map) {
		map.addAttribute("excel_gbn", "nhWithTemplate");
		map.addAttribute("excel_title", "알람관리_NHWITH 발송이력");
		map.addAttribute("excel_list", nhwithService.historyExcel(req));
		return new ModelAndView("alarmsExcelView", map);
	}	
}
