package com.ivucenter.cloud.portal.productUsageStatus.total;

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
@RequestMapping(value="/mng/productUsageStatus/total")
public class MngProductUsageStatusTotalController {

	@Autowired
	private ProductUsageStatusTotalService service;

	@Autowired
  	private OssCloudService ossCloudService;
  

	/**
	 *	PAGE
	 */
	@RequestMapping(value="/")
	public String MngProductUsageStatusTotal(Model model) {
		return "mng/productUsageStatus/total/productUsageStatusTotal_list";
	}

	/**
	 *	ACTION
	 */
	@RequestMapping(value = "/list", produces="text/plain;charset=UTF-8")
	public ResponseEntity<String> MngProductUsageStatusTotalList(CustomProductUsageStatusTotalVO req) {
		String res = service.list(req);
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/excel")
	public ModelAndView MngProductUsageStatusTotalExcel(CustomProductUsageStatusTotalVO req, ModelMap map) {
		service.excel(req, map);
		return new ModelAndView("productUsageStatusExcelView", map);
	}
	
	@RequestMapping(value = "/searchBox" , produces="text/plain;charset=UTF-8")
	public ResponseEntity<String> MngProductUsageStatusTotalSearchBox(CustomProductUsageStatusTotalVO req) {
		String res = service.searchBox(req);
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
}
