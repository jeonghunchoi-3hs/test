package com.ivucenter.cloud.portal.project.application;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ivucenter.cloud.portal.alarms.template.AlarmsTemplateService;
import com.ivucenter.cloud.portal.oss.application.CustomOssAppVO;
import com.ivucenter.cloud.portal.oss.application.OssAppService;
import com.ivucenter.cloud.portal.oss.project.CustomOssProjectVO;
import com.ivucenter.cloud.portal.oss.project.OssProjectService;
import com.ivucenter.cloud.portal.req.catalogue.ReqCatalogueService;
import com.ivucenter.cloud.portal.req.product.ReqProductService;

@Controller
@RequestMapping(value="/mng/project/application")
public class MngProjectApplicationController {
	
	@Autowired
	private ReqCatalogueService reqCatalogueService;
	
	@Autowired
	private AlarmsTemplateService alarmsTemplateService;
	
	@Autowired
	private ReqProductService reqProductService;
	
	@Autowired
	OssAppService service;
	
	@Autowired
	OssProjectService service_project;
	
	@RequestMapping(value="/")
	public String MngProjectApp(Model model) {
		return "mng/project/application/application_list";
	}
	
	@RequestMapping(value="/status", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public String status(Model model, CustomOssProjectVO req) {
		
		
		model.addAttribute("req", req);
		return "mng/project/application/status";
	}
	
	
	
	@RequestMapping(value="/list", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public ResponseEntity<String> MbrOssVmList(CustomOssAppVO req) {
		String res = service.list(req);
		
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
	
	
	@RequestMapping(value = "/detail")
	public ResponseEntity<Object> MbrOssProjectDetail(CustomOssProjectVO req, Model model) {
		CustomOssProjectVO res = service_project.boxDetail(req);

		res.setManagerPhone(res.getManagerPhoneDec());
		res.setManagerTel(res.getManagerTelDec());
		
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}
	
	
}
