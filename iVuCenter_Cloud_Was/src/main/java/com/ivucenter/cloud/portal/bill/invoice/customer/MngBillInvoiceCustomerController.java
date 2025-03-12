package com.ivucenter.cloud.portal.bill.invoice.customer;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.ivucenter.cloud.portal.bss.adjustment.BssAdjustmentService;

/* 메뉴 : 세금계산서 */
@Controller
@RequestMapping(value="/mng/bill/invoice/customer")
public class MngBillInvoiceCustomerController {
	
	@Autowired
	private BillInvoiceCustomerService service;

	@Autowired
	private BssAdjustmentService bssAdjustmentService;
	
	@RequestMapping(value="/")
	public String MngBillInvoiceCustomer(Model model){		
		model.addAttribute("getBillYyyy", bssAdjustmentService.getBillYyyy());
		return "mng/bill/invoice/customer/billInvoiceCustomer-list";
	}
	
	@RequestMapping(value = "/list", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> MngBillInvoiceCustomerList(CustomBillInvoiceCustomerVO req){
		String res = service.list(req);
		if(res.equals("")){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}	
	
	@RequestMapping(value = "/excel")
	public ModelAndView MngBssAdjustmentExcel(CustomBillInvoiceCustomerVO req, ModelMap map) {
		map.addAttribute("excel_gbn", "billInvoiceCustomer");
		map.addAttribute("excel_title", "요금조회_세금계산서");
		map.addAttribute("excel_list", service.excel(req));
		
		return new ModelAndView("billInvoiceCustomerExcelView", map);
	}
	
	
}
