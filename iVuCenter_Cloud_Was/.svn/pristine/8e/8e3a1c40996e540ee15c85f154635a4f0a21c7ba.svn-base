package com.ivucenter.cloud.portal.productUsageStatus.vm;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ivucenter.cloud.portal.cmm.cloud.OssCloudService;

@Controller
@RequestMapping(value="/mng/productUsageStatus/vm")
public class MngProductUsageStatusVmController {

	@Autowired
	private ProductUsageStatusVmService service;
	
	@Autowired
	private OssCloudService ossCloudService;
	  
	/**
	 *	PAGE
	 */
	@RequestMapping(value="/")
	public String MngProductUsageStatusVm(Model model, CustomProductUsageStatusVmVO req) {
		model.addAttribute("req", req);
	
		return "mng/productUsageStatus/vm/productUsageStatusVm_list";
	}

	/**
	 * ACTION
	 */
	@RequestMapping(value = "/list", produces="text/plain;charset=UTF-8")
	public ResponseEntity<String> MngProductUsageStatusTotalList(CustomProductUsageStatusVmVO req) {
		String res = service.list(req);
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/excel")
	public ModelAndView MngProductUsageStatusTotalExcel(CustomProductUsageStatusVmVO req, ModelMap map) {
		service.excel(req, map);
		return new ModelAndView("productUsageStatusExcelView", map);
	}
}
