package com.ivucenter.cloud.portal.productUsageStatus.disk;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ivucenter.cloud.portal.cmm.cloud.OssCloudService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value="/mng/productUsageStatus/disk")
public class MngProductUsageStatusDiskController {
	
	@Autowired
	private ProductUsageStatusDiskService service;

	@Autowired
	private OssCloudService ossCloudService;

	/**
	 *	PAGE
	 */
	@RequestMapping(value="/")
	public String MngProductUsageStatusDisk(Model model, CustomProductUsageStatusDiskVO req) {
		log.debug("MngProductUsageStatusDiskController:MngProductUsageStatusDisk()");

		
		model.addAttribute("req", req);
		
		return "mng/productUsageStatus/disk/productUsageStatusDisk_list";
	}

	/**
	 * ACTION
	 */
	@RequestMapping(value = "/list", produces="text/plain;charset=UTF-8")
	public ResponseEntity<String> MngProductUsageStatusDiskList(CustomProductUsageStatusDiskVO req) {
		String res = service.list(req);
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/excel")
	public ModelAndView MngProductUsageStatusTotalExcel(CustomProductUsageStatusDiskVO req, ModelMap map) {
		service.excel(req, map);
		return new ModelAndView("productUsageStatusExcelView", map);
	}
}
