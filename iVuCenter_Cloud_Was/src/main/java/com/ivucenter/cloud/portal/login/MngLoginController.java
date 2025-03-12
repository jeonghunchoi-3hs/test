package com.ivucenter.cloud.portal.login;


import java.security.Principal;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ivucenter.cloud.portal.cmm.code.CmmCodeService;
import com.ivucenter.cloud.portal.cmm.code.CustomCmmCodeVO;
import com.ivucenter.cloud.portal.cmm.user.CmmUserService;
import com.ivucenter.cloud.portal.cmm.user.CustomCmmUserVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value="/mng")
public class MngLoginController{

	@Autowired
	private LoginService loginService;

	@Autowired
	private CmmCodeService cmmCodeService;

	@Autowired
	private CmmUserService cmmUserService;

	@RequestMapping(value= {"", "/"})
	public String mngDefault() {
		return "exception/error403";
	}

	@RequestMapping(value={"/login"})
	public String mngLogin(HttpServletRequest request, Model model, @CookieValue(value="pgsecuid", required = false) String pgsecuid) {
		log.debug("mngLogin() init");
		// 한전 로그인 쿠키 체크
		if(StringUtils.isNotBlank(pgsecuid)) {
			log.debug("Cookie pgsecuid : " + pgsecuid);
			if(loginService.kepcoCookie(request, pgsecuid)) {
				return "redirect:/mng/main";
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
		log.debug("mngLogin() end");
		return "mng/login";
	}

	@RequestMapping(value="/{expired}")
	public String mngLoginPageExpired(HttpSession session, @PathVariable("expired") String expired){
		UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();

		loginService.writeHistory(userSession.getUsername(), "MNG","Y","LogOut",""); // history write

		if(expired.equals("expired")) { return "mng/login";}
		return "mng/login";
	}


	@RequestMapping(value="/logout")
	public String mngLogout() {
		return "redirect:j_spring_security_logout";
	}

	@RequestMapping(value="/main")
	public String mngMain(Model model) {

		log.debug("mngMain() init");
		UserSession userSession =(UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		final String pwdInitFlag = userSession.getPwdInitFlag();

		System.out.println(pwdInitFlag);

		String retURL = "";
		if(pwdInitFlag.equals("Y")) {			// 신규 유저  - 내 정보 페이지
			retURL = "redirect:/mng/cmm/user/userInfo";
		}else if(pwdInitFlag.equals("C")) {		// 비밀번호 90일 초과
			model.addAttribute("pwd", true);
			retURL = "mng/info/userInfo/userInfoPwd"; // 패스워드 변경
		} else {
			if(userSession.hasAnyRole("ROLE_CLOUD_ADMIN",
				   					  "ROLE_CLOUD_OPERATION",
				   					  "ROLE_CLOUD_ADMIN_USER",
				   					  "ROLE_CLOUD_USER")) {
				retURL = "redirect:/mng/mnghome/dashboard?loginFlag=Y"; // 특수권한 - 대쉬보드
//				retURL = "redirect:cmm/user/userInfo"; // 기본 권한 - 내정보 페이지
			} else {
				retURL = "redirect:/mng/cmm/user/userInfo"; // 기본 권한 - 내정보 페이지
			}
		}
		log.debug("mngMain() end");
		return retURL;
	}


//	ip check 추가
//	@RequestMapping(value="/check")
//	public String mngLoginCheck(Model model, Principal principal, HttpServletRequest request, HttpServletResponse response) {
//
//		String ip = request.getHeader("X-Forwarded-For");
//
//		if (ip == null) ip = request.getHeader("Proxy-Client-IP");
//		if (ip == null) ip = request.getHeader("WL-Proxy-Client-IP");
//		if (ip == null) ip = request.getHeader("HTTP_CLIENT_IP");
//		if (ip == null) ip = request.getHeader("HTTP_X_FORWARDED_FOR");
//		if (ip == null) ip = request.getRemoteAddr();
//
//		String userId = principal.getName();
//		CustomCmmUserVO userVO = cmmUserService.getUserInfo(userId);
//
//		userVO.setIp(ip);
//
//		int userIpCheck = cmmUserService.userIpCheck(userVO);
//
//		if (userIpCheck == 0) {
//			model.addAttribute("userIp", ip);
//
//			return "exception/error404";
//		}
//
//		return "redirect:/mng/main";
//	}

	@RequestMapping(value="/check")
	public String mngLoginCheck(Model model, Principal principal, HttpServletRequest request, HttpServletResponse response) {

		String ip = request.getHeader("X-Forwarded-For");

		if (ip == null) ip = request.getHeader("Proxy-Client-IP");
		if (ip == null) ip = request.getHeader("WL-Proxy-Client-IP");
		if (ip == null) ip = request.getHeader("HTTP_CLIENT_IP");
		if (ip == null) ip = request.getHeader("HTTP_X_FORWARDED_FOR");
		if (ip == null) ip = request.getRemoteAddr();

		String userId = principal.getName();
		CustomCmmUserVO userVO = cmmUserService.getUserInfo(userId);

		userVO.setIp(ip);

		int userIpCheck = cmmUserService.userIpCheck(userVO);

		if (userIpCheck == 0) {
			model.addAttribute("userIp", ip);

			HttpSession session = request.getSession(false);

			if (session != null) {
				session.invalidate();
			}

			Cookie cookie = new Cookie("JSESSIONID", null);
			cookie.setPath(request.getContextPath());
			cookie.setMaxAge(0);
			response.addCookie(cookie);

			SecurityContextHolder.clearContext();

			return "exception/error404";
		}

		return "redirect:/mng/main";
	}

}
