package com.ivucenter.cloud.portal.cmm.company;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping(value="/mng/cmm/company")
public class MngCmmCompanyController {


	@Autowired
	private CmmCompanyService service;

	@RequestMapping(value="/")
	public String MngCmmCompany() {
		return "mng/cmm/company/cmmCompany_list";

	}

	@RequestMapping(value="/edit")
	public String MngCmmCompanyView(Model model, CustomCmmCompanyVO req) {

		model.addAttribute("req", req);
		return "mng/cmm/company/cmmCompany_edit";

	}

	@RequestMapping(value="/write")
	public String MngCmmCompanyWrite() {
		return "mng/cmm/company/cmmCompany_write";

	}

	/**
	 * ACTION
	 */
	@RequestMapping(value = "/list" , produces="text/plain;charset=UTF-8")
	public ResponseEntity<String> MngCmmCompanyList(CustomCmmCompanyVO req) {
		return new ResponseEntity<String>(service.list(req), HttpStatus.OK);
	}
	@RequestMapping(value = "/affilatelist", produces="text/plain;charset=UTF-8")
	public ResponseEntity<String> MngAffilateList(CustomCmmCompanyVO req) {
		return new ResponseEntity<String>(service.affilateList(req), HttpStatus.OK);
	}
	@RequestMapping(value = "/companylist")
	public ResponseEntity<String> MngCmmCompanyCompanylist(CustomCmmCompanyVO req) {
		return new ResponseEntity<String>(service.companylist(req), HttpStatus.OK);
	}
	@RequestMapping(value = "/insert", method=RequestMethod.POST)
	public ResponseEntity<String> MngCmmCompanyInsert(CustomCmmCompanyVO req) {
		return new ResponseEntity<String>(service.insert(req), HttpStatus.OK);
	}
	@RequestMapping(value = "/update", method=RequestMethod.POST)
	public ResponseEntity<String> MngCmmCompanyUpdate(CustomCmmCompanyVO req) {
		return new ResponseEntity<String>(service.update(req), HttpStatus.OK);
	}
	@RequestMapping(value = "/detail")
	public ResponseEntity<CustomCmmCompanyVO> MngCmmCompanyDetail(CustomCmmCompanyVO req) {
		CustomCmmCompanyVO res = service.detail(req);
		if(res == null){
			return new ResponseEntity<CustomCmmCompanyVO>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<CustomCmmCompanyVO>(res, HttpStatus.OK);
	}
	@RequestMapping(value = "/excel")
	public ModelAndView MngCmmCompanyExcel(CustomCmmCompanyVO req, ModelMap map) {
		map.addAttribute("excel_gbn", "cmmCompany");
		map.addAttribute("excel_title", "정책관리_계열사관리");
		map.addAttribute("excel_list", service.excel(req));

		return new ModelAndView("operationExcelView", map);
	}
}
