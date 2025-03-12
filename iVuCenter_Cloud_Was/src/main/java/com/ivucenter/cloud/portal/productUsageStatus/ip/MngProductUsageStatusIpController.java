package com.ivucenter.cloud.portal.productUsageStatus.ip;

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
@RequestMapping(value="/mng/productUsageStatus/ip")
public class MngProductUsageStatusIpController {

	@Autowired
	ProductUsageStatusIpService service;
	
	/**
	 *	PAGE 
	 */
	@RequestMapping(value="/")
	public String MngProductUsageStatusIp(Model model, CustomProductUsageStatusIpVO req) {
		log.debug("MngProductUsageStatusIpController:MngProductUsageStatusIp()");
		model.addAttribute("req", req);		
		return "mng/productUsageStatus/ip/productUsageStatusIp_list";
	}
	
	/**
	 * 공인IP 목록 조회
	 * @param req
	 * @return
	 */
	@RequestMapping(value="/list", produces="text/plain;charset=UTF-8")
	public ResponseEntity<String> MngProductUsageStatusIpList(CustomProductUsageStatusIpVO req){
		String res = service.list(req);
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
	@RequestMapping(value = "/excel")
	public ModelAndView MngProductUsageStatusTotalExcel(CustomProductUsageStatusIpVO req, ModelMap map) {
		service.excel(req, map);
		return new ModelAndView("productUsageStatusExcelView", map);
	}

}
