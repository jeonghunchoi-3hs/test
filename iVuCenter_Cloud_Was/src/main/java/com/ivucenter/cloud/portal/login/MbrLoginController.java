package com.ivucenter.cloud.portal.login;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ivucenter.cloud.portal.cmm.code.CmmCodeService;
import com.ivucenter.cloud.portal.cmm.code.CustomCmmCodeVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping(value="/mbr")
@Controller
public class MbrLoginController{

	@Autowired
	private LoginService loginService;

	@Autowired
	private CmmCodeService cmmCodeService;

	@RequestMapping(value={"","/"})
	public String mbrLoginPage(HttpServletRequest request, Model model, @CookieValue(value="pgsecuid", required = false) String pgsecuid) {
		// 한전 로그인 쿠키 체크
		if(StringUtils.isNotBlank(pgsecuid)) {
			log.debug("Cookie pgsecuid : " + pgsecuid);
			if(loginService.kepcoCookie(request, pgsecuid)) {
				return "redirect:/mbr/main";
			}
			else {
				return "mbr/login";
			}
		}
//		else { // 디버그를 위해 추가 (추후 삭제)
//			Cookie cookies[] = request.getCookies();
//			if (cookies != null) {
//				for(int i = 0; i < cookies.length; i++) {
//					Cookie cookie = cookies[i];
//					log.debug("Cookie pgsecuid : " + cookie.getName() + " : " + cookie.getValue());
//				}
//			} else {
//				log.debug("Cookie pgsecuid : NULL !!!!!!" );
//			}
//		}

		List<CustomCmmCodeVO> getEmailCode = cmmCodeService.getCmmCode("EMAIL_KIND");
		model.addAttribute("getEmailCode", getEmailCode);

		return "mbr/login";
	}

	@RequestMapping(value="/{expired}")
	public String mbrLoginPageExpired(HttpSession session, @PathVariable("expired") String expired){

		UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();

		loginService.writeHistory(userSession.getUsername(), "MBR","Y","LogOut",""); // history write

		if(expired.equals("expired")) { return "mbr/login2"; }
		return "mbr/login";
	}

	@RequestMapping(value="/logout")
	public String mbrLogout() {
		return "redirect:j_spring_security_logout";
	}

	@RequestMapping(value="/main")
	@Secured({"ROLE_CUSTOM_USER"})
	public String mbrMain() {

		UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		final String pwdInitFlag = userSession.getPwdInitFlag();

		String retURL = "";

		if(userSession.hasAnyRole("ROLE_CUSTOM_ADMIN",
								  "ROLE_CUSTOM_USER",
								  "ROLE_CUSTOM_PM") ) { // 특수 권한 유저

			if(pwdInitFlag.equals("Y")) { 		 // 신규 유저의 패스워드 변경 유도
				retURL =  "redirect:cmm/user/userInfoWrite?userId="+userSession.getUsername(); // 내정보 수정 화면
			} else if(pwdInitFlag.equals("C")) { // 비밀번호 90일 초과
				retURL =  "mbr/info/userInfo/userInfoPwd"; 				// 패스워드 변경 화면
			} else {
				retURL =  "redirect:mbrhome/dashboard?loginFlag=Y"; 	// 대쉬보드 화면
//				retURL =  "redirect:cmm/user/userInfo"; 				// 내 정보 화면
			}

		} else { 										// 일반 관리자 유저

			if(pwdInitFlag.equals("Y")) { 		 // 신규 유저의 패스워드 변경 유도
				retURL =  "redirect:cmm/user/userInfoWrite?userId="+userSession.getUsername(); // 내정보 수정 화면
			} else if(pwdInitFlag.equals("C")) { // 비밀번호 90일 초과
				retURL =  "mbr/info/userInfo/userInfoPwd"; 				// 패스워드 변경 화면
			} else {
				retURL =  "redirect:cmm/user/userInfo"; 				// 내 정보 화면
			}
		}

		return retURL;
	}
}
