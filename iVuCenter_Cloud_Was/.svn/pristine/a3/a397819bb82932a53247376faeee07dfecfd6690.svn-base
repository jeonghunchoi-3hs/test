package com.ivucenter.cloud.portal.req.user;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ivucenter.cloud.portal.cmm.user.CmmUserService;
import com.ivucenter.cloud.portal.cmm.user.CustomCmmUserVO;
import com.ivucenter.cloud.portal.login.UserSession;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value="/mng/req/user")
public class MngReqUserController {

	@Autowired
	private ReqUserService reqUserService;

	@Autowired
	private CmmUserService cmmUserService;
		
	/* page */
	
	// 사용자신청 목록화면
	@RequestMapping(value= {"/","/userApproval"})
	//@Secured("ROLE_CLOUD_USER")
	public String mngUserApproval() {		
		return "mng/req/user/userApproval"; 
	}
	
	// 사용자승인 상세화면
	@RequestMapping(value="/viewApprovalPage")
	//@Secured("ROLE_CLOUD_USER")
	public String mngUserApprovalViewPage(Model model, CustomReqUserVO req) {		
		model.addAttribute("vo", req); // reqUserSeq
		
		UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String userId = userSession.getUsername();
		CustomCmmUserVO userapprove = new CustomCmmUserVO();
		if(userId.equals("admin")) {
			// admin User
			userapprove.setConfirmAction("Y");
			model.addAttribute("userapprove", userapprove); // reqUserSeq
		} else {
			// Common User
			userapprove = cmmUserService.loginUserApproveYn(userId);
			model.addAttribute("userapprove", userapprove); // reqUserSeq
		}
		
		return "mng/req/user/userApprovalView"; 
	}
	
	/* Action */
	
	@RequestMapping(value = "/list", produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> mngReqUserList(CustomReqUserVO req) {
		
		String res = reqUserService.list(req);
		if(res.equals("")){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/excel")
	public ModelAndView MngCmmUserList(CustomReqUserVO req, ModelMap map) {
		
		map.addAttribute("excel_gbn", "user");
		map.addAttribute("excel_title", "정책관리_사용자 관리");
		map.addAttribute("excel_list", reqUserService.excel(req));
		return new ModelAndView("cmmCustomerExcelView", map);
	}
	
//	@RequestMapping(value = "/customerSelect")
//	public ResponseEntity<Object> customerSelect(HttpServletRequest request) {
//		log.info("customerSelect");
//		CustomCmmCustomerVO customerVo = new CustomCmmCustomerVO();
//		customerVo.setKeyword(request.getParameter("keyword"));
//		
//		List<CustomCmmCustomerVO> getCustomerList = reqUserService.selectCustomerList(customerVo);
//				
//		return new ResponseEntity<Object>(getCustomerList, HttpStatus.OK);
//	}

	@RequestMapping(value = "/getUserView", produces="application/json;charset=UTF-8")
	public ResponseEntity<Object> mngGetUserView(CustomReqUserVO req) {
		CustomReqUserVO res = reqUserService.getUserView(req);
		if(res == null){ return new ResponseEntity<Object>(HttpStatus.NO_CONTENT); }
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/getloginAdminUser", produces="application/json;charset=UTF-8")
	public ResponseEntity<List<CustomCmmUserVO>> loginAdminDetail() {
		List<CustomCmmUserVO> res = cmmUserService.loginAdminDetail();
		if(res == null){ return new ResponseEntity<List<CustomCmmUserVO>>(HttpStatus.NO_CONTENT); }
		return new ResponseEntity<List<CustomCmmUserVO>>(res, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/reqUserConfirm", produces="application/json;charset=UTF-8")
	public ResponseEntity<Object> mngUserConfirm(CustomReqUserVO managerVo) {
		String res = reqUserService.UserConfirm(managerVo);
		if(res.equals("")){ return new ResponseEntity<Object>(HttpStatus.NO_CONTENT); }
		return new ResponseEntity<Object> (res, HttpStatus.OK);
	}	
}
