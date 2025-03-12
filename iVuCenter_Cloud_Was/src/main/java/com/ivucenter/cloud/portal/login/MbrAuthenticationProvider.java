package com.ivucenter.cloud.portal.login;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang.time.DateFormatUtils;
import org.apache.commons.lang.time.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;

import com.ivucenter.cloud.portal.cmm.user.CmmUserService;
import com.ivucenter.cloud.portal.cmm.user.CustomCmmUserVO;
import com.ivucenter.cloud.portal.util.CodeUtil;
import com.ivucenter.cloud.portal.util.TokenGenerator;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class MbrAuthenticationProvider implements AuthenticationProvider{

	@Autowired
	private CmmUserService service;

	@Autowired
	private LoginService loginService;

	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		log.debug("authenticate() init");
		String sId = authentication.getName();
		String sPw = TokenGenerator.generate(sId, authentication.getCredentials().toString());

		// 사용자 정보 DB get
		CustomCmmUserVO req = new CustomCmmUserVO();
		req.setUserId(sId);
		CustomCmmUserVO res = service.loginChk(req);

		if(res == null) {
			loginService.writeHistory(sId, "MBR","N","LogIn",CodeUtil.LOGIN_FAIL_MESSAGE2); // history write
			throw new BadCredentialsException(CodeUtil.LOGIN_FAIL_MESSAGE2);
		}

		// 패스워드 일치 여부
//		  if(res.getUserPassword().equals(sPw) == false ){
//			  service.failPassword(req);
//			  loginService.writeHistory(sId, "MBR","N","LogIn",CodeUtil.LOGIN_FAIL_MESSAGE2); // history write throw new
//			  throw new BadCredentialsException(CodeUtil.LOGIN_FAIL_MESSAGE2);
//		  }

		// 접근 권한 체크
		final String sRoles = res.getUserAuthority();
		System.out.println(sRoles);
		if(sRoles == null){
			loginService.writeHistory(sId, "MBR","N","LogIn",CodeUtil.LOGIN_AUTHFAIL_MESSAGE); // history write
			throw new BadCredentialsException(CodeUtil.LOGIN_AUTHFAIL_MESSAGE);
		}

		if(res.getUserBlock().equals("Y")) {
			loginService.writeHistory(sId, "MBR","N","LogIn",CodeUtil.LOGIN_FAIL_MESSAGE3); // history write
			throw new BadCredentialsException(CodeUtil.LOGIN_FAIL_MESSAGE3);
		}
		// 세부 권한 체크는 @Secured() 어노테이션에서 담당
//		if(sRoles.charAt(15) !='1'){
//			loginService.writeHistory(sId, "MBR","N","LogIn",CodeUtil.LOGIN_AUTHFAIL_MESSAGE); // history write
//			throw new BadCredentialsException(CodeUtil.LOGIN_AUTHFAIL_MESSAGE);
//		}

		// 유저 상태 체크 (잠금/탈퇴/퇴사)
		final String status = res.getUserStatus();
		if(status.equals(CodeUtil.LOGIN_USER_STATUS_ABSENCE)) {
			loginService.writeHistory(sId, "MBR","N","LogIn",CodeUtil.LOGIN_ABSENCE_MESSAGE); // history write
			throw new BadCredentialsException(CodeUtil.LOGIN_ABSENCE_MESSAGE);
		}
		if(status.equals(CodeUtil.LOGIN_USER_STATUS_WITHDRAWAL) || res.getDelFlag().equals("Y")) {
			loginService.writeHistory(sId, "MBR","N","LogIn",CodeUtil.LOGIN_WITHDRAWAL_MESSAGE); // history write
			throw new BadCredentialsException(CodeUtil.LOGIN_WITHDRAWAL_MESSAGE);
			}
		if(status.equals(CodeUtil.LOGIN_USER_STATUS_RETIREMENT)) {
			loginService.writeHistory(sId, "MBR","N","LogIn",CodeUtil.LOGIN_RETIREMENT_MESSAGE); // history write
			throw new BadCredentialsException(CodeUtil.LOGIN_RETIREMENT_MESSAGE);
			}

		// 패스워드 5회 실패 체크
		if(res.getPasswordFailCnt() > 4 ) {
			loginService.writeHistory(sId, "MBR","N","LogIn",CodeUtil.LOGIN_PASSWORDFAIL_MESSAGE); // history write
			throw new BadCredentialsException(CodeUtil.LOGIN_PASSWORDFAIL_MESSAGE);
			}

		// 패스워드 변경일 90일 경과 여부
		if(res.getPwdModDatetime() != null) {
			final Integer baseDay = Integer.parseInt(DateFormatUtils.format(DateUtils.addDays(new Date(), -90), "yyyyMMdd"));
			final Integer modiDay = Integer.parseInt(DateFormatUtils.format(res.getPwdModDatetime(), "yyyyMMdd"));
			if( sId.equals("admin") == false && (baseDay > modiDay) ){
				res.setPwdInitFlag("C");
			}
		}

		// spring security 권한 토큰 생성
//		UserSession userSession = new UserSession(sId, sPw, sRoles, res.getUserName(), res.getPwdInitFlag(), res.getDeptCode(),res.getApprvPass());
//		UsernamePasswordAuthenticationToken result = new UsernamePasswordAuthenticationToken(userSession, sPw, userSession.getAuthorities());

//		StringBuffer sb = new StringBuffer(sRoles);
//		sb.setCharAt(15, '0');
		Map<String, String> paramMap = new HashMap<>();
//		paramMap.put("roles", sb.toString());
		paramMap.put("roles", sRoles);
		paramMap.put("id", sId);
		paramMap.put("nickname", res.getUserName());
		paramMap.put("initFlag", res.getPwdInitFlag());
		paramMap.put("deptCode", res.getDeptCode());
		paramMap.put("apprvPass", res.getApprvPass());
		paramMap.put("customerId", res.getCustomerId());
		paramMap.put("levelCode", res.getUserLevelCode());
		paramMap.put("levelName", res.getUserLevelCodeName());
		UserSession userSession = new UserSession(paramMap);
		UsernamePasswordAuthenticationToken result = new UsernamePasswordAuthenticationToken(userSession, "",
				userSession.getAuthorities());

		// 로그인 시간, 실패 카운트 초기화
		service.loginOk(req);
		loginService.writeHistory(sId, "MBR","Y","LogIn",""); // history write
		log.debug("authenticate() end : " + result.toString());
		return result;
	}

	@Override
	public boolean supports(Class<?> authentication) {
		return authentication.equals(UsernamePasswordAuthenticationToken.class);
	}
}
