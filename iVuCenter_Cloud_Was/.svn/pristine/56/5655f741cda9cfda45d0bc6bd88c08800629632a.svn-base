package com.ivucenter.cloud.portal.productUsageStatus.lb;

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
@RequestMapping(value="/mng/productUsageStatus/lb")
public class MngProductUsageStatusLbController {

	@Autowired
	ProductUsageStatusLbService service;
	
	/**
	 *	PAGE 
	 */
	@RequestMapping(value="/")
	public String MngProductUsageStatusLb(Model model, CustomProductUsageStatusLbVO req) {
		log.debug("MngProductUsageStatusLbController:MngProductUsageStatusLb()");
		model.addAttribute("req", req);		
		return "mng/productUsageStatus/lb/productUsageStatusLb_list";
	}
	
	/**
	 * ACTION
	 */
	@RequestMapping(value = "/list", produces="text/plain;charset=UTF-8")
	public ResponseEntity<String> MngProductUsageStatusLbList(CustomProductUsageStatusLbVO req) {
		String res = service.list(req);
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
	@RequestMapping(value = "/excel")
	public ModelAndView MngProductUsageStatusTotalExcel(CustomProductUsageStatusLbVO req, ModelMap map) {
		service.excel(req, map);
		return new ModelAndView("productUsageStatusExcelView", map);
	}
}
