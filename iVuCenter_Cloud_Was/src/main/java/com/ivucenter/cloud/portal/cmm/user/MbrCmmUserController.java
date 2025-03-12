package com.ivucenter.cloud.portal.cmm.user;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.JsonObject;
import com.ivucenter.cloud.portal.cmm.code.CmmCodeService;
import com.ivucenter.cloud.portal.cmm.code.CustomCmmCodeVO;
import com.ivucenter.cloud.portal.cmm.customer.CustomCmmCustomerVO;
import com.ivucenter.cloud.portal.cmm.file.CmmFileService;
import com.ivucenter.cloud.portal.cmm.file.CustomCmmFileVO;
import com.ivucenter.cloud.portal.login.LoginService;
import com.ivucenter.cloud.portal.login.UserSession;
import com.ivucenter.cloud.portal.operation.approveUser.CustomApproveUserVO;
import com.ivucenter.cloud.portal.util.CodeUtil;
import com.ivucenter.cloud.portal.util.TokenGenerator;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value="/mbr/cmm/user")
public class MbrCmmUserController{
	
	@Autowired
	private CmmUserService service;
	
	@Autowired
	private CmmFileService cmmFileService;
	
	@Autowired 
	private CmmCodeService cmmCodeService;
	
	@Autowired
	private LoginService loginService;
	
	@RequestMapping(value="/")
	@Secured( {"ROLE_CUSTOM_ADMIN","ROLE_CUSTOM_USER", "ROLE_CUSTOM_PM"} )
	public String mbrCmmUser() {		
		return "mbr/operation/user/user";		
	}
	
	@RequestMapping(value="/userInfo")
	public String mbrUserInfo(Model model, Principal principal) {
		try {
			CustomCmmFileVO fileVo = new CustomCmmFileVO();
			fileVo.setProgramName("cmm_user");
			fileVo.setProgramSeq(principal.getName());
			model.addAttribute("file", cmmFileService.list(fileVo));

			return "mbr/info/userInfo/userInfoView";
			
		} catch (Exception e) {
			return "redirect:j_spring_security_logout";
		}
		
	}
	
	@RequestMapping(value = "/userPic")
	public ResponseEntity<Object> userPic(CustomCmmUserVO req, Model model, Principal principal) {
		
		CustomCmmFileVO fileVo = new CustomCmmFileVO();
		
		fileVo.setProgramName("cmm_user");
		fileVo.setProgramSeq(principal.getName());
		List<CustomCmmFileVO> picFile = cmmFileService.list(fileVo);		
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("picFile", picFile);		
		return new ResponseEntity<Object>(map, HttpStatus.OK);
	}
	
	// 내 정보 수정
	@RequestMapping(value="/userInfoWrite") 
	public String mbrUserInfoWrite(Model model, CustomCmmUserVO req, Principal principal) {
		try {
			
			CustomCmmFileVO fileVo = new CustomCmmFileVO();
			fileVo.setProgramName("cmm_user");
			fileVo.setProgramSeq(principal.getName()); // userId
			model.addAttribute("file", cmmFileService.list(fileVo));
			
			List<CustomCmmCodeVO> getEmailCode = cmmCodeService.getCmmCode("EMAIL_KIND");
			model.addAttribute("getEmailCode", getEmailCode);
			
			List<CustomCmmCodeVO> getPositionCode = cmmCodeService.getCmmCode("POSITION_GRADE");
			model.addAttribute("getPositionCode", getPositionCode);		
			
			return "mbr/info/userInfo/userInfoInsert";
		} catch (Exception e) {
			return "redirect:j_spring_security_logout";
		}
	}

	@RequestMapping(value = "/list", produces="text/plain;charset=UTF-8")
	public ResponseEntity<String> mbrCmmUserList(CustomCmmUserVO req) {		
		String res = service.list(req);
		
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}

	@RequestMapping(value = "/detail")
	public ResponseEntity<CustomCmmUserVO> mbrCmmUserDetail(CustomCmmUserVO req) {		
		CustomCmmUserVO res = service.detail(req);
		
		return new ResponseEntity<CustomCmmUserVO>(res, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/userInfoDetail")
	public ResponseEntity<Object> mbrUserInfoDetail(CustomCmmUserVO req, Model model) {
		CustomCmmUserVO res = service.userInfoDetail(req);
		if(res == null){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}		
		
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}
	
	@RequestMapping(value="/userPasswordCheck")
	public ResponseEntity<String> userPasswordCheck(CustomCmmUserVO req) {
		req.setUserPassword(TokenGenerator.generate(req.getUserId(), req.getUserPassword()));
		String ret = service.userPasswordCheck(req);		 
		return new ResponseEntity<String>(ret, HttpStatus.OK);
	}

	@RequestMapping(value = "/insert")
	public ResponseEntity<String> mbrCmmUserInsert(CustomCmmUserVO req) {
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
	
	@RequestMapping(value = "/userInfoUpdatepw")
	public ResponseEntity<String> userInfoUpdatepw(CustomCmmUserVO req, Model model) {
		req.setUserPassword(TokenGenerator.generate(req.getUserId(), req.getUserPassword()));
		req.setPwdInitFlag("N");
		String res = service.userInfoUpdatepw(req);
		
		UserSession userDetails = (UserSession)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		userDetails.setPwdInitFlag("N");
		
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
	
	/**
	 * 비밀번호 사용 90일 초과시 
	 * @param req
	 * @return
	 */
	@RequestMapping(value = "/userInfoUpdatepw2")
	public ResponseEntity<String> mbruserInfoUpdatepw2(CustomCmmUserVO req) {
		UserSession details = (UserSession)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		details.setPwdInitFlag("N");
		req.setUserPassword(TokenGenerator.generate(req.getUserId(), req.getUserPassword()));
		req.setPwdInitFlag("N");
		
		String res = service.userInfoUpdatepw(req);
		
		UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();		
		loginService.writeHistory(userSession.getUsername(), "MBR","Y","PassUpdate",""); // history write
		
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/delete")
	public ResponseEntity<String> mbrCmmUserDelete(CustomCmmUserVO req) {		
		String res = service.delete(req);		
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
	
	
	/**
	 * 약관 화면
	 */
	@RequestMapping(value="/agreementList")
	public String agreementList() {
		return "mbr/cmm/user/agreementList";
	}
	
	
	// 사용자 회원가입신청 화면
	@RequestMapping(value = "/mbrInsertPage")
	public String MbrInsertForm(ModelMap model ){
		log.debug("========== mbrInsertPage ==========");
		
		List<CustomCmmCodeVO> getEmailCode = cmmCodeService.getCmmCode("EMAIL_KIND");
		model.addAttribute("getEmailCode", getEmailCode);
		
		return "mbr/cmm/user/mbrInsert";
	}
	
	// 사용자 회원가입 완료 화면
	@RequestMapping(value = "/mbrCompPage")
	public String MbrCompFome(ModelMap model ){
		log.debug("========== mbrmbfCompPage ==========");
		
		return "mbr/cmm/user/mbrComp";
	}
	
	// 사용자 아이디 중복 체크
	@RequestMapping(value = "/mbrIdcheck", produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> MbrIDcheckvalue(CustomCmmUserVO req){
		
		log.debug("========== mbrIdcheck ==========");
		
		String res="";
		int chkval = service.setMbrFormchk(req);
		if(chkval == 0){
			res= CodeUtil.ID_CHK_SUCCES;
		}else{
			res= CodeUtil.ID_CHK_FAIL;
		}
		
		JsonObject jsonResponse = new JsonObject();
	    jsonResponse.addProperty("idchktext", res);
	    jsonResponse.addProperty("chkval", chkval);
	    jsonResponse.addProperty("mbrId", req.getUserId());
		
		return new ResponseEntity<Object>(jsonResponse.toString(), HttpStatus.OK);
	}
	
	// 회원사 찾기
	@RequestMapping(value = "/customerSelect")
	public ResponseEntity<Object> customerSearch(HttpServletRequest request) {
		
		log.debug("========== customerSearch ==========");
		
		CustomCmmCustomerVO customerVo = new CustomCmmCustomerVO();
		customerVo.setKeyword(request.getParameter("keyword"));
		
		List<CustomCmmCustomerVO> getCustomerList = service.selectCustomerList(customerVo);
		return new ResponseEntity<Object>(getCustomerList, HttpStatus.OK);
	}
	
	// 회원가입신청
	@RequestMapping(value = "/mbrInsert")
	public ResponseEntity<String> mbrInsert(HttpServletRequest request, CustomCmmUserVO req) {
		log.debug("========== mbrInsert ==========");
		
		// 자동가입방지문자 체크
		String autoStringtext =  request.getParameter("autoStringtext");
		String autoStringtextHash =  request.getParameter("autoStringtextHash");
		int hash = 5381;
//		autoStringtext = autoStringtext.toUpperCase();
		for(int i=0;i<autoStringtext.length();i++){
			hash =((hash<<5)+hash)+autoStringtext.charAt(i);
		}
		if(!autoStringtextHash.equals(hash+"")){
			return new ResponseEntity<String>("3", HttpStatus.OK);
		}
		
		String userMail = req.getUserMail();
		String mailDomain = req.getMailDomain();
		req.setUserMail(userMail+"@"+mailDomain);
		
		String res="";
		int chkval = service.setMbrFormchk(req);
		// 사용자 아이디 중복 체크
		if(chkval == 0){
			service.setMbrForminsert(req);
			res="1";
		}else{
			res="2";
			return new ResponseEntity<String>(res,HttpStatus.OK);
		}
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/getTempPw")
	public ResponseEntity<String> getTempPw(HttpServletRequest request) {
		log.debug("========== getTempPw ==========");
		String userId = request.getParameter("userId");
		String content = service.getTempPw(userId);
		return new ResponseEntity<String>(content, HttpStatus.OK);
	}
	
	// 회원가입 사원 조회
	@RequestMapping(value="/searchUserInfo" , produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> MbrAdminUserAdd2List(CustomApproveUserVO req, Model model){
		//UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();		
		//req.setUserId(userSession.getUsername());
		
		return new ResponseEntity<Object>(service.searchUserInfo(req), HttpStatus.OK);
	}
	

}
