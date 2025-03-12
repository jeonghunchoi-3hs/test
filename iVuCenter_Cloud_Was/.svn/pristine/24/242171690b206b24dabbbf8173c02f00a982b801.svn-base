package com.ivucenter.cloud.portal.req.user;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.JsonObject;
import com.ivucenter.cloud.portal.alarms.template.AlarmsTemplateService;
import com.ivucenter.cloud.portal.cmm.code.CmmCodeService;
import com.ivucenter.cloud.portal.cmm.code.CustomCmmCodeVO;
import com.ivucenter.cloud.portal.cmm.customer.CustomCmmCustomerVO;
import com.ivucenter.cloud.portal.cmm.department.CmmDepartmentService;
import com.ivucenter.cloud.portal.cmm.department.CustomCmmDepartmentVO;
import com.ivucenter.cloud.portal.cmm.user.CmmUserService;
import com.ivucenter.cloud.portal.cmm.user.CustomCmmUserVO;
import com.ivucenter.cloud.portal.login.LoginService;
import com.ivucenter.cloud.portal.operation.adminuser.AdminUserService;
import com.ivucenter.cloud.portal.operation.adminuser.CustomAdminUserVO;
import com.ivucenter.cloud.portal.operation.approveUser.CustomApproveUserVO;
import com.ivucenter.cloud.portal.util.CodeUtil;

@Controller
@RequestMapping(value="/mbr/req/user")
public class MbrReqUserController {

	@Autowired
	private ReqUserService reqUserService;	
	
	@Autowired
	private CmmCodeService cmmCodeService;
	
	@Autowired
	private CmmUserService cmmService;
	
	@Autowired
	private LoginService loginService;
	
	@Autowired
	private CmmUserService cmmUserService;
	
	@Autowired
	private AlarmsTemplateService alarmsTemplateService;
	
	@Autowired
	private CmmDepartmentService cmmDepartmentService ;
	
	@Autowired
	private ReqUserDAO reqUserDao;
	
	@Autowired
	private AdminUserService adminUserService;
	
//	@Autowired	private CmmDepartmentService cmmDeptService;
	 
	// 약관 동의
	@RequestMapping(value="/agreementList")
	public String agreementList() {
		return "mbr/req/user/agreementList";
	}
	
	// 회원가입신청 화면
	@RequestMapping(value = "/mbrInsert.do",params="!type")
	public String MbrInsertForm(Model model , @CookieValue(value="pgsecuid", required = false) String pgsecuid,HttpServletRequest request){
		if(StringUtils.isNotBlank(pgsecuid)) {
			if(loginService.kepcoCookie(request, pgsecuid)) {
				String getUserId = (pgsecuid.equals("admin")) ? "admin" : loginService.decryptKepco(pgsecuid); // debugging
				model.addAttribute("getUserId",getUserId);
			}
		}
		CustomCmmCustomerVO customerVo = new CustomCmmCustomerVO(); // 검색 옵션 
		List<CustomCmmCustomerVO> getCustomerList = reqUserService.selectCustomerList(customerVo);
		model.addAttribute("getCustomerList", getCustomerList);
		
		List<CustomCmmCodeVO> getEmailCode = cmmCodeService.getCmmCode("EMAIL_KIND");
		model.addAttribute("getEmailCode", getEmailCode);
		
		List<CustomCmmCodeVO> getPositionCode = cmmCodeService.getCmmCode("POSITION_GRADE");
		model.addAttribute("getPositionCode", getPositionCode);		
		
		return "mbr/req/user/mbrInsert";
	}
	
	// 회원가입신청 저장
	@RequestMapping(value = "/mbrInsert")
	public ResponseEntity<String> mbrInsert(HttpServletRequest request, CustomReqUserVO req) {

		// 자동가입방지문자 체크
		String autoStringtext =  request.getParameter("autoStringtext");
		String autoStringtextHash =  request.getParameter("autoStringtextHash");

		int hash = 5381;
		for(int i=0;i<autoStringtext.length();i++){
			hash =((hash<<5)+hash)+autoStringtext.charAt(i);
		}
		if(!autoStringtextHash.equals(hash+"")){
			return new ResponseEntity<String>("3", HttpStatus.OK);
		}

		// 사용자 ID 중복 체크
		if(! reqUserService.chkUniqueId(req)) {
			return new ResponseEntity<String>("2",HttpStatus.OK);
		}
		// 회원 가입 완료 알람 (신청자)
		Map<String, String> keywordMap = new HashMap<>();
		keywordMap.put("[[사번]]", req.getUserId());
		//alarmsTemplateService.alarms(54, req.getUserId(), keywordMap);
		
		// 회원 가입 승인 요청 (회원 관리자)
		List<CustomCmmUserVO> loginAdminList = cmmUserService.loginAdminDetail();
		for(CustomCmmUserVO loginUserVo : loginAdminList) {
			//alarmsTemplateService.alarms(55, loginUserVo.getUserId(), keywordMap);
		}
		String reqSeq = reqUserService.setUserInsert(req); 		// req_user 테이블 저장
		
		CustomReqUserVO managerVo = new CustomReqUserVO();
		managerVo.setReqUserSeq(reqSeq);
		managerVo.setApprvUserId("18109816");
		managerVo.setApprvFlag("Y");
		managerVo.setDescription("");
		managerVo.setApprvOperation("");
		managerVo.setUserId(req.getUserId());
		reqUserDao.setUserConfirm(managerVo);	    // update req_user (apprv_user_id, apprv_flag, spprv_datetime, description)			
		reqUserDao.copyUserInfoToCmm(managerVo);	// copy from req_user to cmm_user
		
		if( StringUtils.isNotBlank(managerVo.getApprvOperation()) ) {
			// 관리자 권한 추가
			CustomAdminUserVO vo = new CustomAdminUserVO(); 
			vo.setUserId(managerVo.getUserId());
			adminUserService.insertAdmin(vo);
			
			if(managerVo.getApprvOperation().equals("WF1000A0")) {
				vo.setWF1000A0("Y"); 
			} else if(managerVo.getApprvOperation().equals("WF1000B0")) {
				vo.setWF1000B0("Y");
			}
			vo.setOperation("N");
			vo.setConfirmAction("N");
			vo.setLogin("N");
			vo.setLength(1);				
			adminUserService.updateAdmin(vo);
		}
		//alarmsTemplateService.alarms("52", managerVo.getUserId(), managerVo.getUserId(), "");
		
		return new ResponseEntity<String>("1", HttpStatus.OK);
	}
	
	// 회원가입 완료 화면
	@RequestMapping(value = "/mbrCompPage")
	public String MbrCompPage(Principal principal){
		return "mbr/req/user/mbrComp";
	}	
	
	// 사용자 아이디 중복 체크
	@RequestMapping(value = "/mbrIdcheck", produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> MbrIDcheckvalue(CustomReqUserVO req){
		
		String res= CodeUtil.ID_CHK_SUCCES;	
		int chkval = 0;
		if(! reqUserService.chkUniqueId(req)) {
			res = CodeUtil.ID_CHK_FAIL;
			chkval = 1; 
		}
		
		JsonObject jsonResponse = new JsonObject();
	    jsonResponse.addProperty("idchktext", res);
	    jsonResponse.addProperty("chkval", chkval);
	    jsonResponse.addProperty("mbrId", req.getUserId());
		
		return new ResponseEntity<Object>(jsonResponse.toString(), HttpStatus.OK);	
	}
	
	// 사번으로 정보 검색
	@RequestMapping(value = "/mbrIdSearch", produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> mbrIdSearch(CustomReqUserVO req){
		
		String res= CodeUtil.ID_CHK_SUCCES;	
		int chkval = 0;
		if(! reqUserService.chkUniqueId(req)) {
			res = CodeUtil.ID_CHK_FAIL;
			chkval = 1; 
		}
		 
		JsonObject jsonResponse = new JsonObject();
	    jsonResponse.addProperty("idchktext", res);
	    jsonResponse.addProperty("chkval", chkval);
	    jsonResponse.addProperty("mbrId", req.getUserId());
		
		return new ResponseEntity<Object>(jsonResponse.toString(), HttpStatus.OK);	
	}
	@RequestMapping(value="/searchUserInfo" , produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> MbrAdminUserAdd2List(CustomApproveUserVO req, Model model){
		//UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();		
		//req.setUserId(userSession.getUsername());
		
		return new ResponseEntity<Object>(cmmService.searchUserInfo(req), HttpStatus.OK);
	}
	@RequestMapping(value = "/TreeAll", produces="text/plain;charset=UTF-8")
	public ResponseEntity<String> MngCmmDepartmentTreeAll(CustomCmmDepartmentVO req) {
		String res = cmmDepartmentService.TreeAll(req);
		if(StringUtils.isBlank(res)) {
			return new ResponseEntity<String>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
	//  Modal 일 때 필요. 
//	@RequestMapping(value = "/customerSelect")
//	public ResponseEntity<Object> customerSelect(HttpServletRequest request) {
//		
//		CustomCmmCustomerVO customerVo = new CustomCmmCustomerVO();
//		customerVo.setKeyword(request.getParameter("keyword"));
//		
//		List<CustomCmmCustomerVO> getCustomerList = reqUserService.selectCustomerList(customerVo);
//				
//		return new ResponseEntity<Object>(getCustomerList, HttpStatus.OK);
//	}
	
//	@RequestMapping(value = "/selectDepartment", produces="text/plain;charset=UTF-8")
//	public ResponseEntity<String> departmentSelect(CustomCmmDepartmentVO req) {		
//
//		String res = cmmDeptService.TreeAll(req);
//		return new ResponseEntity<String>(res, HttpStatus.OK);
//	}
}
