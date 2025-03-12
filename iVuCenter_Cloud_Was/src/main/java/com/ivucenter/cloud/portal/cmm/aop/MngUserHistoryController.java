package com.ivucenter.cloud.portal.cmm.aop;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.ivucenter.cloud.portal.login.CustomLoginHistoryVO;

@Controller
@RequestMapping(value="/mng/cmm/aop")
public class MngUserHistoryController {
	
	@Autowired
	private UserHistoryService service;
	
	@RequestMapping(value="/")
	public String mngUserHistory() {
		return "mng/cmm/aop/aopList";
	}	
	
	@RequestMapping(value="/list", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> mngUserHistoryList(UserHistoryVO req){
		String res = service.list(req);
		
		if(res.equals("")){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/excel")
	public ModelAndView userHistoryExcel(UserHistoryVO req, ModelMap map) {
		map.addAttribute("excel_gbn", "userHistory");
		map.addAttribute("excel_title", "고객센터_유저히스토리");
		map.addAttribute("excel_list", service.excel(req));
		return new ModelAndView("userHistoryExcelView", map);
	}
	
	
	@RequestMapping(value = "/loginHistoryExcel")
	public ModelAndView loginHistoryExcel(CustomLoginHistoryVO req, ModelMap map) {
		map.addAttribute("excel_gbn", "loginUserHistory");
		map.addAttribute("excel_title", "고객센터_유저히스토리");
		map.addAttribute("excel_list", service.loginHistoryListTot(req));
		return new ModelAndView("userHistoryExcelView", map);
	}
	
	
	
	//사용자 로그인 이력 메소드 
	@RequestMapping(value="/loginHistory")
	public String mngLoginUserHistory() {
		return "mng/cmm/loginhistory/loginHistoryList";
	}	
	
	@RequestMapping(value="/loginHistoryList", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> mngUserLoginHistoryList(CustomLoginHistoryVO req){

		String res = service.loginHistoryList(req);
		
		if(res.equals("")){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}
	
}
