package com.ivucenter.cloud.portal.cmm.customer;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.ivucenter.cloud.portal.cmm.company.CmmCompanyDAO;
import com.ivucenter.cloud.portal.cmm.company.CustomCmmCompanyVO;
import com.ivucenter.cloud.portal.cmm.file.CmmFileService;
import com.ivucenter.cloud.portal.cmm.file.CustomCmmFileVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value="/mng/cmm/customer")
public class MngCmmCustomerController {

	@Autowired
	private CmmCustomerService service;

	@Autowired
	private CmmFileService cmmFileService;
	
	@Autowired
	private CmmCompanyDAO cmmCompanyDao;  // 한전 특화 : 한전은 하나의 cmm_company 값을 가짐
	/**
	 * PAGE 
	 */
	@RequestMapping(value="/")
	public String MngCmmCustomer(Model model) {
		try {
			log.debug("MngCmmCustomerController:MngCmmCustomer()"); 
			// company 선택 select 삭제 (한전 특화)  
			//model.addAttribute("customerHeardList", service.upCompanyList());		
						
			return "mng/cmm/customer/customerList";
			
		} catch (Exception e) {
			return "redirect:j_spring_security_logout";
		}
	}
	@RequestMapping(value="/view")
	public String MngCmmCustomerView(Model model, CustomCmmCustomerVO req) {
		try {
			
			model.addAttribute("customerId", req.getCustomerId());
			
			CustomCmmFileVO vo = new CustomCmmFileVO();			
			vo.setProgramName("cmm_customer");
			vo.setProgramSeq(req.getCustomerId());
			
			model.addAttribute("file", cmmFileService.list(vo));
			model.addAttribute("filesCnt", cmmFileService.list(vo).size());
			
			return "mng/cmm/customer/customerView";
		} catch (Exception e) {
			return "redirect:j_spring_security_logout";
		}
	}
	
	@RequestMapping(value="/edit")
	public String customerEdit(Model model, CustomCmmCustomerVO req, ModelMap modelMap) {
//		try {
			
			model.addAttribute("customerId", req.getCustomerId());
			CustomCmmCustomerVO getCustomerVo = service.detail(req);
			
			
			if(!getCustomerVo.getCorporationNo().equals("")){
				String []corporationNo = getCustomerVo.getCorporationNo().split("-");	
				getCustomerVo.setCorporationNo1(corporationNo[0]); 
				getCustomerVo.setCorporationNo2(corporationNo[1]);
			}
			if(!getCustomerVo.getCompanyNo().equals("")){
				String []companyNo = getCustomerVo.getCompanyNo().split("-");	
				getCustomerVo.setCompanyNo1(companyNo[0]); 
				getCustomerVo.setCompanyNo2(companyNo[1]);
				getCustomerVo.setCompanyNo3(companyNo[2]);
			}
			
			modelMap.put("getCustomerVo", getCustomerVo);
			
			/*
			List<CustomCmmCustomerVO> vatRateList = service.vatRateList();
			model.addAttribute("vatRateList", vatRateList);
			*/
			
			CustomCmmFileVO vo = new CustomCmmFileVO();
			
			vo.setProgramName("cmm_customer");
			vo.setProgramSeq(getCustomerVo.getCustomerId());
			
			model.addAttribute("file", cmmFileService.list(vo));
			model.addAttribute("filesCnt", cmmFileService.list(vo).size());
			
			return "mng/cmm/customer/customerEdit";
//		} catch (Exception e) {
//			return "redirect:j_spring_security_logout";
//		}
	}
	
	@RequestMapping(value="/write")
	public String MngCmmCustomerWrite(Model model, CustomCmmCustomerVO req) {
		try {
			
			model.addAttribute("customerId", req.getCustomerId());
			
			CustomCmmCompanyVO companyVo = new CustomCmmCompanyVO(); 
			List<CustomCmmCompanyVO> lists = cmmCompanyDao.list(companyVo);
			String companyId = lists.get(0).getCompanyId();			
			model.addAttribute("refCompanyId", companyId);
			
			List<CustomCmmCustomerVO> vatRateList = service.vatRateList();
			model.addAttribute("vatRateList", vatRateList);
			 
			return "mng/cmm/customer/customerWrite";
		} catch (Exception e) {
			return "redirect:j_spring_security_logout";
		}
	}
	
	@RequestMapping(value="/coustomadminPopList")
	public String coustomadminPopList(Model model, CustomCmmCustomerVO req) {
		try {
			
			model.addAttribute("customerId", req.getCustomerId());
			
			List<CustomCmmCustomerVO> getCustomerMemberList = service.getCustomerMemberList(req);
			model.addAttribute("getCustomerMemberList", getCustomerMemberList);
			 
			return "mng/cmm/customer/coustomadminPopList";
		} catch (Exception e) {
			return "redirect:j_spring_security_logout";
		}
	}
	
	
	/**
	 * PAGE 
	 */
	@RequestMapping(value="/vatRateListPage")
	public String MngCmmCustomerVatRateListPage() {
			
		return "mng/cmm/customer/vatRate/cmmCustomerVatRate-list";
		
	}
	@RequestMapping(value="/vatRateViewPage")
	public String MngCmmCustomerVatRateViewPage(Model model, CustomCmmCustomerVO req) {
		
		model.addAttribute("req", req);
		return "mng/cmm/customer/vatRate/cmmCustomerVatRate-view";
		
	}
	
	@RequestMapping(value="/vatRateEditPage")
	public String MngCmmCustomerVatRateEditPage(Model model, CustomCmmCustomerVO req, ModelMap modelMap) {
		model.addAttribute("req", req);
		try {
			
			List<CustomCmmCustomerVO> vatRateList = service.vatRateList();
			model.addAttribute("vatRateList", vatRateList);
			
			return "mng/cmm/customer/vatRate/cmmCustomerVatRate-edit";
		} catch (Exception e) {
			return "redirect:j_spring_security_logout";
		}
	}
	
	/**
	 *	ACTION 
	 */
	@RequestMapping(value="/list", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> mngCustomerList(CustomCmmCustomerVO req){
			
		String res = service.list(req);
		
		if(res.equals("")){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}
	@RequestMapping(value = "/detail")
	public ResponseEntity<Object> mngCustomerDetail(CustomCmmCustomerVO req) {
		CustomCmmCustomerVO res = service.detail(req);
		
		if(res == null){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}	
	
	@RequestMapping(value="/excel")
	public ModelAndView MngCmmCustomerExcel(CustomCmmCustomerVO req, ModelMap map){
		map.addAttribute("excel_gbn", "network");
		map.addAttribute("excel_title", "프로젝트_네트워크");
		map.addAttribute("excel_list", service.excel(req));
		 
		return new ModelAndView("custExcelView", map);		
	}
		
	@RequestMapping(value="/customerInsert")
	public ResponseEntity<Object> mngCustomerInsert(CustomCmmCustomerVO req){
		int companyNoChk = service.companyNoChk(req); // 고객사 사업자번호 중복체크
		log.debug("============ companyNoChk : " +companyNoChk);
		if(companyNoChk==0){
			String res = service.customerInsert(req);
			log.debug("============ customerInsert res : " +res);
			if(res.equals("")){
				return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
			}
			return new ResponseEntity<Object>(res, HttpStatus.OK);
		}else{
			String res = "2";
			return new ResponseEntity<Object>(res, HttpStatus.OK);
		}
		
	}
	
	@RequestMapping(value = "/customadminInsert")
	public ResponseEntity<String> customadminInsert(@RequestBody CustomCmmCustomerVO req){
		
		log.debug("req.getUserAuthority() : " + req.getUserAuthority());
		
		//새로 입력
		StringBuffer userAuthority = new StringBuffer(req.getUserAuthority());
		
		//기존 회원사 관리자 체크		
		CustomCmmCustomerVO manageridChk = service.setManageridChk(req);
		
		if(manageridChk.getManagerId()==null || manageridChk.getManagerId().equals("")){
			//회원사 관리자 신규
			userAuthority.setCharAt(8, '1');
			req.setUserAuthority(userAuthority.toString());
		}else{
			//회원사 관리자 기존 권한 수정후 
			manageridChk.getManagerId();
			CustomCmmCustomerVO userAuthView = service.getuserAuthView(manageridChk);
			StringBuffer oldUserAuthority = new StringBuffer(userAuthView.getUserAuthority());
			oldUserAuthority.setCharAt(8, '0');
			userAuthView.setUserAuthority(oldUserAuthority.toString());
			
			String userAuthChg = service.setuserAuthChg(userAuthView);			
			log.debug("user Auth :" + userAuthChg);
			userAuthority.setCharAt(8, '1');
			req.setUserAuthority(userAuthority.toString());
		}
				
		String res = service.setCustomadminInsert(req);
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
	
	@RequestMapping(value="/customerEdit")
	public ResponseEntity<Object> mngCustomerEdit(CustomCmmCustomerVO req){
		
		req.setVatRate("0"); // 화면 select 삭제 후 보정
		String res = service.customerEdit(req);
		
		if(res.equals("")){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}
		
	@RequestMapping(value = "/userListModal", method = RequestMethod.GET)
	public ResponseEntity<Object> pmPopList(CustomCmmCustomerVO req){
		
		List<CustomCmmCustomerVO> getCustomerMemberList = service.getCustomerMemberList(req);
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("getCustomerMemberList", getCustomerMemberList);
		log.debug(getCustomerMemberList.toString());
		return new ResponseEntity<Object>(map, HttpStatus.OK);
	}
		
	@RequestMapping(value = "/companySelectList")
	public ResponseEntity<Object> companySelectList(CustomCmmCustomerVO req) {
		List<CustomCmmCustomerVO> companySelectList = service.companySelectList(req);
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("selectCompanyList", companySelectList);
		
		if(companySelectList == null){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(map, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/companyListModal", method = RequestMethod.GET)
	public ResponseEntity<Object> companyPopList(CustomCmmCustomerVO req){
		
		List<CustomCmmCustomerVO> companyList = service.getCompanyList(req);
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("companyList", companyList);
		
		return new ResponseEntity<Object>(map, HttpStatus.OK);
	}
	@RequestMapping(value = "/companyFullListModal", method = RequestMethod.GET)
	public ResponseEntity<Object> companyPopFullList(CustomCmmCustomerVO req){
		
		List<CustomCmmCustomerVO> companyList = service.getCompanyFullList(req);
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("companyList", companyList);
		
		return new ResponseEntity<Object>(map, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/vatRateExcel")
	public ModelAndView MngCmmCustomerVatRateExcel(CustomCmmCustomerVO req, ModelMap map) {
		map.addAttribute("excel_gbn", "vatRate");
		map.addAttribute("excel_title", "요금관리_부가가치세율");
		map.addAttribute("excel_list", service.vatRateExcel(req));
		
		return new ModelAndView("cmmCustomerExcelView", map);
	}
	
	@RequestMapping(value="/vatRateEdit")
	public ResponseEntity<Object> MngCmmCustomerVatRateEdit(@RequestBody CustomCmmCustomerVO req){
		return new ResponseEntity<Object>(service.vatRateEdit(req), HttpStatus.OK);
	}
	
}
