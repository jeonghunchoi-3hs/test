package com.ivucenter.cloud.portal.bss.discount;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value="/mng/bss/discount")
public class MngBssDiscountController {

	@Autowired
	BssDiscountService service;


	/**
	 * PAGE
	 */
	@RequestMapping(value="/")
	public String MngBssDisCount() {
		log.debug("MngBssDiscountController:MngBssDisCount()");
		return "mng/bss/discount/bssDiscount-list";
	}

	@RequestMapping(value="/view")
	public String MngBssDisCountView(Model model, CustomBssDiscountVO req) {
		model.addAttribute("req", req);
		return "mng/bss/discount/bssDiscount-view";
	}

	@RequestMapping(value="/write")
	public String MngBssDisCountWrite(Model model, CustomBssDiscountVO req) {
		model.addAttribute("req", req);
		return "mng/bss/discount/bssDiscount-write";
	}

	/**
	 *	ACTION
	 */
	@RequestMapping(value = "/list", produces="text/plain;charset=UTF-8")
	public ResponseEntity<String> MngBssDisCountList(CustomBssDiscountVO req) {
		return new ResponseEntity<String>(service.list(req), HttpStatus.OK);
	}
	@RequestMapping(value = "/excel")
	public ModelAndView MngBssDisCountExcel(CustomBssDiscountVO req, ModelMap map) {
		map.addAttribute("excel_gbn", "bssDiscount");
		map.addAttribute("excel_title", "요금관리_할인율");
		map.addAttribute("excel_list", service.excel(req));
		return new ModelAndView("cmmCustomerExcelView", map);
	}
	@RequestMapping(value = "/detail", produces="text/plain;charset=UTF-8")
	public ResponseEntity<String> MngBssDisCountDetail(CustomBssDiscountVO req) {
		return new ResponseEntity<String>(service.detail(req), HttpStatus.OK);
	}
	@RequestMapping(value = "/insert", produces="text/plain;charset=UTF-8" , method=RequestMethod.POST)
	public ResponseEntity<String> MngBssDisCountInsert(CustomBssDiscountVO req) {
		return new ResponseEntity<String>(service.insert(req), HttpStatus.OK);
	}
	@RequestMapping(value = "/delete")
	public ResponseEntity<String> MngBssDisCountDelete(CustomBssDiscountVO req) {
		return new ResponseEntity<String>(service.delete(req), HttpStatus.OK);
	}
	@RequestMapping(value = "/update", method=RequestMethod.POST)
	public ResponseEntity<String> MngBssDisCountUpdate(CustomBssDiscountVO req) {
		return new ResponseEntity<String>(service.update(req), HttpStatus.OK);
	}
}
