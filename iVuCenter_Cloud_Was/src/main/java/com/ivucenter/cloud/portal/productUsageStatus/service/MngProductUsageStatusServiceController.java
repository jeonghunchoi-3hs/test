package com.ivucenter.cloud.portal.productUsageStatus.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value="/mng/productUsageStatus/service")
public class MngProductUsageStatusServiceController {

	@Autowired
	private ProductUsageStatusServiceService service;


	/**
	 *	PAGE
	 */
	@RequestMapping(value="/")
	public String MngProductUsageStatusBack(Model model, CustomProductUsageStatusServiceVO req) {
		log.debug("MngProductUsageStatusBackController:MngProductUsageStatusBack()");
		model.addAttribute("req", req);
		
		return "mng/productUsageStatus/service/productUsageStatusService_list";
	}

	@RequestMapping(value="/list", produces="text/plain;charset=UTF-8")
	public ResponseEntity<String> MngProductUsageStatusBackList(CustomProductUsageStatusServiceVO req){
		String res = service.list(req);
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/excel")
	public ModelAndView MngProductUsageStatusBackExcel(CustomProductUsageStatusServiceVO req, ModelMap map) {
		service.excel(req, map);
		return new ModelAndView("productUsageStatusExcelView", map);
	}
}
