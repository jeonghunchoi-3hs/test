package com.ivucenter.cloud.portal.productUsageStatus.fs;

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
@RequestMapping(value="/mng/productUsageStatus/fs")
public class MngProductUsageStatusFsController {

	@Autowired
	ProductUsageStatusFsService service;

	/**
	 *	PAGE
	 */
	@RequestMapping(value="/")
	public String MngProductUsageStatusFs(Model model, CustomProductUsageStatusFsVO req) {
		log.debug("MngProductUsageStatusfsController:MngProductUsageStatusFs()");
		model.addAttribute("req", req);
		return "mng/productUsageStatus/fs/productUsageStatusFs_list";
	}

	/**
	 * ACTION
	 */
	@RequestMapping(value = "/list", produces="text/plain;charset=UTF-8")
	public ResponseEntity<String> MngProductUsageStatusFsList(CustomProductUsageStatusFsVO req) {
		String res = service.list(req);
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
	@RequestMapping(value = "/excel")
	public ModelAndView MngProductUsageStatusTotalExcel(CustomProductUsageStatusFsVO req, ModelMap map) {
		service.excel(req, map);
		return new ModelAndView("productUsageStatusExcelView", map);
	}
}
