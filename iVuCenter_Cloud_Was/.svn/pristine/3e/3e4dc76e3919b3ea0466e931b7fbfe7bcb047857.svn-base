package com.ivucenter.cloud.portal.operation.adminuser;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ivucenter.cloud.portal.cmm.cloud.OssCloudService;
import com.ivucenter.cloud.portal.cmm.user.CmmUserService;
import com.ivucenter.cloud.portal.cmm.user.CustomCmmUserVO;

@Controller
@RequestMapping(value="/mng/operation/adminUser")
public class MngAdminUserController {
	
	
	@Autowired
	AdminUserService service;

	@Autowired
	OssCloudService cloudService;
 	
	@Autowired
	CmmUserService userService;
	
	/**
	 *	PAGE 
	 */
	@RequestMapping(value="/")
	public String MngadminUserList(){
		
		return "mng/operation/adminUser/operationAdminUser-list";
	}
	
	@RequestMapping(value="/view")
	public String MngAdminUserView(CustomAdminUserVO req, Model model){
		model.addAttribute("req", req);		
		
		
		CustomCmmUserVO  userVo = new CustomCmmUserVO();  
		userVo.setUserId(req.getUserId());
		CustomCmmUserVO  userInfo =    userService.detail(userVo);
		//String[] arrayAuth = userInfo.getUserCloudAuthority().split("");


		return "mng/operation/adminUser/operationAdminUser-view";		
	}
	
	/**
	 *	ACTION 
	 */
	@RequestMapping(value="/list", produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> MngAdminUserList(CustomAdminUserVO req, Model model){
		return new ResponseEntity<Object>(service.list(req), HttpStatus.OK);
	}
	
	@RequestMapping(value="/addList", produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> MngAdminUserAddList(CustomAdminUserVO req, Model model){
		return new ResponseEntity<Object>(service.addList(req), HttpStatus.OK);
	}
	
	@RequestMapping(value="/auth")
	public ResponseEntity<Object> MngAdminUserAuth(CustomAdminUserVO req, Model model){
		return new ResponseEntity<Object>(service.auth(req), HttpStatus.OK);
	}
	
	@RequestMapping(value="/checkLoginAuth")
	public ResponseEntity<Object> MngAdminUserLoginAuth(CustomAdminUserVO req, Model model) {
		return new ResponseEntity<Object>(service.LoginAuth(), HttpStatus.OK);
	}
	
	@RequestMapping(value = "/excel")
	public ModelAndView MngAdminUserExcel(CustomAdminUserVO req, ModelMap map) {
		map.addAttribute("excel_gbn", "adminUser");
		map.addAttribute("excel_title", "정책관리_관리자권한관리");
		map.addAttribute("excel_list", service.excel(req));
		
		return new ModelAndView("operationExcelView", map);
	}

	@RequestMapping(value="/insertAdmin")
	public ResponseEntity<Object> MngAdminUserInsertAdmin(CustomAdminUserVO req, Model model){
		return new ResponseEntity<Object>(service.insertAdmin(req), HttpStatus.OK);
	}
	
	@RequestMapping(value="/updateAdmin")
	public ResponseEntity<Object> MngAdminUserUpdateAdmin(CustomAdminUserVO req, Model model){
		return new ResponseEntity<Object>(service.updateAdmin(req), HttpStatus.OK);
	}	
	
	/*
	*//**
	 * 일반 목록조회
	 *//*
	@RequestMapping(value="/userList")
	public ResponseEntity<Object> userList(CustomAdminUserVO req, Model model){
		String res =service.userList(req);
		
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}
	
	*//**
	 * 권한 수정
	 *//*
	@RequestMapping(value="/updateRole")
	public ResponseEntity<Object> updateRole(CustomAdminUserVO req, Model model){
		String res =service.updateRole(req);
		
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}
	
	*//**
	 * 관리자 등록
	 *//*
	@RequestMapping(value="/adminInsert")
	public ResponseEntity<Object> adminInsert(CustomAdminUserVO req, Model model){
		String res =service.adminInsert(req);
	
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}*/

}
