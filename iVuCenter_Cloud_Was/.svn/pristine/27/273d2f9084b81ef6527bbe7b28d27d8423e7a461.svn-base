package com.ivucenter.cloud.portal.cmm.network;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping(value="/mng/cmm/network")
public class MngCmmNetworkController {

	@Autowired
	private CmmNetworkService service;

	//@Autowired	private CmmCodeService cmmCodeService;
	//@Autowired	private CmmCustomerService cmmCustomerService;
	
	/**
	 * page
	 */
	@RequestMapping(value="/")
	@Secured("ROLE_CLOUD_ADMIN")
	public String CmmNetwork() {		
		return "mng/cmm/network/cmmNetwork-list";
	}
	
	@RequestMapping(value="/write")
	@Secured("ROLE_CLOUD_ADMIN")
	public String CmmNetworkWrite(Model model, CustomCmmNetworkVO req) {
		model.addAttribute("req", req);		
		return "mng/cmm/network/cmmNetwork-write";
	}

	@RequestMapping(value="/detail")
	@Secured("ROLE_CLOUD_ADMIN")
	public String CmmNetworkDetail(Model model, CustomCmmNetworkVO req) {
		model.addAttribute("req", req);		
		return "mng/cmm/network/cmmNetwork-view";
	}
	
	/**
	 * Action
	 */
	@RequestMapping(value="/list", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> MngCmmNetworkList(CustomCmmNetworkVO req){
		String res = service.list(req);
		if(res.equals("")){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}
	@RequestMapping(value = "/insert")
	public ResponseEntity<String> MngCmmNetworkInsert(CustomCmmNetworkVO req) {
		return new ResponseEntity<String>(service.insert(req), HttpStatus.OK);
	}	
	@RequestMapping(value = "/excel")
	public ModelAndView MngCmmNetworkExcel(CustomCmmNetworkVO req, ModelMap map) {
		map.addAttribute("excel_gbn", "cmmNetwork");
		map.addAttribute("excel_title", "정책관리_네트워크정책관리");
		map.addAttribute("excel_list", service.excel(req));
		
		return new ModelAndView("operationExcelView", map);
	}	
		
	
	
	/**
	 *	ACTION 
	 */
	@RequestMapping(value="/listAffiliateName", method = RequestMethod.GET)
	public ResponseEntity<List<CustomCmmNetworkVO>> CmmNetworklistAffiliateName(CustomCmmNetworkVO req){
		
		List<CustomCmmNetworkVO> res = service.listAffiliateName(req);
		
		if(res == null){
			return new ResponseEntity<List<CustomCmmNetworkVO>>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<List<CustomCmmNetworkVO>>(res, HttpStatus.OK);
	}
	/*
	@RequestMapping(value = "/detail")
	public ResponseEntity<CustomCmmNetworkVO> CmmNetworkDetail(CustomCmmNetworkVO req) {
		CustomCmmNetworkVO res = service.detail(req);
		
		return new ResponseEntity<CustomCmmNetworkVO>(res, HttpStatus.OK);
	}
	*/
	@RequestMapping(value = "/delete")
	public ResponseEntity<String> CmmNetworkDelete(CustomCmmNetworkVO req) {
		String res = service.delete(req);
			
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
	
	@RequestMapping(value="/customerlist", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> CmmNetworkCustomerlist(CustomCmmNetworkVO req){
		
		String res = service.customerlist(req);
		
		if(res.equals("")){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/customerInsert")
	public ResponseEntity<String> CmmNetworkCustomerInsert(CustomCmmNetworkVO req) {
		String res = service.customerInsert(req);
			
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/customerDelete")
	public ResponseEntity<String> CmmNetworkCustomerDelete(CustomCmmNetworkVO req) {
		String res = service.customerDelete(req);
			
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
	
	@RequestMapping(value="/customerPopList", method = RequestMethod.GET)
	public ResponseEntity<Object> CmmNetworkCustomerPoplist(CustomCmmNetworkVO req){
		
		String res = service.customerPopList(req);
		
		if(res.equals("")){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}
		
	// 세션 클러스트링 TEST
	@RequestMapping(value="/sessionClusteringTest")
	public String sessionClusteringTest() {		
		return "mng/cmm/network/sessionClusteringTest";
	}	
	
}
