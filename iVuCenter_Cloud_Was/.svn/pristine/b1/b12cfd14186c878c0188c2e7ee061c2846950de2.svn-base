package com.ivucenter.cloud.portal.cmm.user;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.ivucenter.cloud.portal.cmm.code.CmmCodeService;
import com.ivucenter.cloud.portal.cmm.code.CustomCmmCodeVO;
import com.ivucenter.cloud.portal.cmm.customer.CustomCmmCustomerVO;
import com.ivucenter.cloud.portal.cmm.file.CmmFileService;
import com.ivucenter.cloud.portal.cmm.file.CustomCmmFileVO;
import com.ivucenter.cloud.portal.login.LoginService;
import com.ivucenter.cloud.portal.login.UserSession;
import com.ivucenter.cloud.portal.oss.vm.CustomOssVmVO;
import com.ivucenter.cloud.portal.util.TokenGenerator;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value="/mng/cmm/user")
public class MngCmmUserController{
	
	@Autowired
	private CmmUserService service;
	
	@Autowired
	private CmmFileService cmmFileService;

	@Autowired 
	private CmmCodeService cmmCodeService;	
	
	@Autowired
	private LoginService loginService;
		
	// 사용자관리 목록화면
	@RequestMapping(value="/")
//	@Secured("ROLE_CLOUD_ADMIN, ROLE_CLOUD_ADMIN_USER")
	public String mngCmmUser() {		
		return "mng/cmm/user/userList"; 
	}
	
	// 사용자관리 상세화면
	@RequestMapping(value="/viewPage")
//	@Secured("ROLE_CLOUD_ADMIN, ROLE_CLOUD_ADMIN_USER")
	public String mngCmmUserViewPage(Model model, CustomCmmUserVO req) {		
		model.addAttribute("_userId", req.getUserId());
		return "mng/cmm/user/userView"; 
	}
	
	// 사용자관리 수정화면
	@RequestMapping(value="/updatePage")
//	@Secured("ROLE_CLOUD_ADMIN, ROLE_CLOUD_ADMIN_USER")
	public String mngCmmUserUpdatePage(Model model, CustomCmmUserVO req) {		
		log.debug("updatePage : " + req.getUserId());
		model.addAttribute("_userId", req.getUserId());
		return "mng/cmm/user/userUpdate"; 
	}
	
	@RequestMapping(value="/userInfo")
	public String mngUserInfo(Model model, CustomCmmUserVO req, Principal principal) {
		try {			
			CustomCmmFileVO fileVo = new CustomCmmFileVO();
			fileVo.setProgramName("cmm_user");
			fileVo.setProgramSeq(req.getUserId()); 
			model.addAttribute("file", cmmFileService.list(fileVo));
			model.addAttribute("userId", principal.getName());
			return "mng/info/userInfo/userInfoView";
		} catch (Exception e) {
			return "redirect:j_spring_security_logout";
		}
	}
	
	@RequestMapping(value = "/mngUserPic")
	public ResponseEntity<Object> mngUserPic(CustomCmmUserVO req, Model model, Principal principal) {
		HashMap<String, Object> map = new HashMap<>();		
		CustomCmmFileVO fileVo = new CustomCmmFileVO();
		
		fileVo.setProgramName("cmm_user");
		fileVo.setProgramSeq(principal.getName()); 
		List<CustomCmmFileVO> picFile = cmmFileService.list(fileVo);
		
		map.put("picFile", picFile);
		
		return new ResponseEntity<Object>(map, HttpStatus.OK);
	}
	
	@RequestMapping(value="/userInfoWrite")
	public String mngUserInfoWrite(Model model, CustomCmmUserVO req) {
		try {
			model.addAttribute("userId", req.getUserId());
			
			CustomCmmFileVO fileVo = new CustomCmmFileVO();
			fileVo.setProgramName("cmm_user");
			fileVo.setProgramSeq(req.getUserId()); 
			model.addAttribute("file", cmmFileService.list(fileVo));
			
			List<CustomCmmCodeVO> getEmailCode = cmmCodeService.getCmmCode("EMAIL_KIND");
			model.addAttribute("getEmailCode", getEmailCode);			
			
			List<CustomCmmCodeVO> getPositionCode = cmmCodeService.getCmmCode("POSITION_GRADE");
			model.addAttribute("getPositionCode", getPositionCode);
			
			return "mng/info/userInfo/userInfoInsert";
		} catch (Exception e) {
			return "redirect:j_spring_security_logout";
		}
	}
	
	
	@RequestMapping(value = "/passWordCheck")
	public ResponseEntity<String> MngOssVmPassWordCheck(CustomOssVmVO req, Principal principal) {
		   String res = "";
		   UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		   String insertPassWord =TokenGenerator.generate(userSession.getUsername(), req.getPassWord());
	       String sessionPassword =  userSession.getPassword();
	       
	       if(insertPassWord.equals(sessionPassword)){
			   res = "1";
	       }else{
	    	   res = "2";
	       }
			return new ResponseEntity<String>(res, HttpStatus.OK);
	}
	
	
	
	
	@RequestMapping(value = "/list", produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> mngCmmUserList(CustomCmmUserVO req) {
		String res = service.list(req);
		if(res.equals("")){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/excel")
	public ModelAndView MngCmmUserList(CustomCmmUserVO req, ModelMap map) {
		map.addAttribute("excel_gbn", "user");
		map.addAttribute("excel_title", "정책관리_사용자 관리");
		map.addAttribute("excel_list", service.excel(req));
		return new ModelAndView("cmmCustomerExcelView", map);
	}	
	
	@RequestMapping(value = "/detail")
	public ResponseEntity<CustomCmmUserVO> mngCmmUserDetail(CustomCmmUserVO req) {
		CustomCmmUserVO res = service.detail(req);
		
		return new ResponseEntity<CustomCmmUserVO>(res, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/userInfoDetail", produces="application/json;charset=UTF-8")
	public ResponseEntity<Object> mngUserInfoDetail(CustomCmmUserVO req, Model model) {
		CustomCmmUserVO res = service.userInfoDetail(req);
		
//		if(res.getUserPhone()!=null){
//			String[] mbrPhone = res.getUserPhone().split("-");
//			if(mbrPhone.length==3){
//				res.setMbrPhone1(mbrPhone[0]);
//				res.setMbrPhone2(mbrPhone[1]);
//				res.setMbrPhone3(mbrPhone[2]);			
//			}else{
//				res.setMbrPhone1("");
//				res.setMbrPhone2("");
//				res.setMbrPhone3("");	
//			}
//		}
//		
//		if(res.getUserTel()!=null){
//			String[] mbrTel = res.getUserTel().split("-");
//			if(mbrTel.length==3){
//				res.setMbrTel1(mbrTel[0]);
//				res.setMbrTel2(mbrTel[1]);
//				res.setMbrTel3(mbrTel[2]);			
//			}else{
//				res.setMbrTel1("");
//				res.setMbrTel2("");
//				res.setMbrTel3("");	
//			}
//		}

		if(res == null){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/insert", method=RequestMethod.POST)
	public ResponseEntity<String> mngCmmUserInsert(CustomCmmUserVO req) {
		String res = "";
		
		if(StringUtils.isNotEmpty(req.getUserId())){
			res = service.update(req);
		}else{
			res = service.insert(req); 
		}
		
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/userInfoUpdate")
	public ResponseEntity<String> mbrUserInfoUpdate(CustomCmmUserVO req) {
		String res = service.userInfoUpdate(req);
		
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/delete")
	public ResponseEntity<String> mngCmmUserDelete(CustomCmmUserVO req) {
		
//		log.info(this);
		// 재가입을 위해 req_user, cmm_user 정보 삭제		
		String res = service.delete(req);  
		
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
	
	// 회원사 찾기
	@RequestMapping(value = "/customerSelect")
	public ResponseEntity<Object> customerSearch(HttpServletRequest request) {
		
		log.debug("========== customerSearch ==========");
		
		CustomCmmCustomerVO customerVo = new CustomCmmCustomerVO();
		customerVo.setKeyword(request.getParameter("keyword"));
		
		HashMap<String, Object> map = new HashMap<>();
		
		List<CustomCmmCustomerVO> getCustomerList = service.selectCustomerList(customerVo);
		int selectCustomerListTot =  service.selectCustomerListTot(customerVo);
		
		map.put("getCustomerList", getCustomerList);
		map.put("listTot", selectCustomerListTot);
		
		return new ResponseEntity<Object>(map, HttpStatus.OK);
	}
	
	@RequestMapping(value="/userPasswordCheck")
	public ResponseEntity<String> userPasswordCheck(CustomCmmUserVO req) {
		req.setUserPassword(TokenGenerator.generate(req.getUserId(), req.getUserPassword()));
		String ret = service.userPasswordCheck(req);		 
		return new ResponseEntity<String>(ret, HttpStatus.OK);
	}
	// 사용자관리 회원사정보수정
	@RequestMapping(value = "/updateUserCustomer")
	public ResponseEntity<String> updateUserCustomer(CustomCmmUserVO req) {
		
		String res = service.updateUserCustomer(req);
		
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
	
	/**
	 * 비밀번호 사용 90일 초과시 
	 * @param req
	 * @return
	 */
	@RequestMapping(value = "/userInfoUpdatepw2")
	public ResponseEntity<String> mnguserInfoUpdatepw2(CustomCmmUserVO req) {
		
		UserSession userSession = (UserSession)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		userSession.setPwdInitFlag("N");
		
		req.setUserPassword(TokenGenerator.generate(req.getUserId(), req.getUserPassword()));
		req.setPwdInitFlag("N");
		String res = service.userInfoUpdatepw(req);
		
		loginService.writeHistory(userSession.getUsername(), "MNG","Y","PassUpdate",""); // history write
		
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/userInfoUpdatepw")
	public ResponseEntity<String> MnguserInfoUpdatepw(CustomCmmUserVO req, Model model) {
		
		UserSession userSession = (UserSession)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		userSession.setPwdInitFlag("N");
				
		req.setUserPassword(TokenGenerator.generate(req.getUserId(), req.getUserPassword()));
		req.setPwdInitFlag("N");
		String res = service.userInfoUpdatepw(req);
		
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/blockUpdate")
	public ResponseEntity<String> blockUpdate(CustomCmmUserVO req, Model model) {

		String res = service.blockUpdate(req);
		
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}

}
