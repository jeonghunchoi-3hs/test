package com.ivucenter.cloud.portal.login;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.SequenceInputStream;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import com.ivucenter.cloud.portal.cmm.user.CmmUserService;
import com.ivucenter.cloud.portal.cmm.user.CustomCmmUserVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class LoginService {

	@Autowired
	private LoginDAO dao;

	@Autowired
	private CmmUserService cmmUserService;

	public void writeHistory(String userId, String siteGBN, String successYn, String service, String loginFailMessage) {
		CustomLoginHistoryVO vo = new CustomLoginHistoryVO();
		vo.setUserId(userId);
		vo.setSiteGbn(siteGBN); // MNG, MBR
		vo.setSuccessYn(successYn);
		vo.setService(service);
		vo.setLoginFailMessage(loginFailMessage);

		InetAddress local = null;
		try {
			local = InetAddress.getLocalHost();
			vo.setIp( (null != local) ? local.getHostAddress():"" );
		} catch (UnknownHostException e) {
			log.error(e.toString());
		}

		dao.insertLoginHitory(vo);
	}

	public boolean kepcoCookie(HttpServletRequest request, String pgsecuid) {

		String getUserId = (pgsecuid.equals("admin")) ? "admin" : decryptKepco(pgsecuid); // debugging
		if(StringUtils.isBlank(getUserId)) { return false; }

		// 사용자 정보 DB get
		CustomCmmUserVO req = new CustomCmmUserVO();
		req.setUserId(getUserId);
		CustomCmmUserVO res = cmmUserService.loginChk(req);

		if(res != null) {
			if(res.getUserBlock().equals("Y")) {
				return false;
			}
			// security session 생성
//			UserSession userSession =
//					new UserSession(getUserId, res.getUserPassword(), res.getUserAuthority(), res.getUserName(), res.getPwdInitFlag(), res.getDeptCode(), res.getApprvPass());
//			UsernamePasswordAuthenticationToken authToken =
//					new UsernamePasswordAuthenticationToken(userSession, res.getUserPassword(), userSession.getAuthorities());

			// security session 생성
			Map<String, String> paramMap = new HashMap<>();
			paramMap.put("roles",res.getUserAuthority());
			paramMap.put("id", getUserId);
			paramMap.put("nickname", res.getUserName());
			paramMap.put("initFlag", res.getPwdInitFlag());
			paramMap.put("deptCode", res.getDeptCode());
			paramMap.put("apprvPass", res.getApprvPass());
			paramMap.put("customerId",res.getCustomerId());
			paramMap.put("levelCode", res.getUserLevelCode());
			paramMap.put("levelName", res.getUserLevelCodeName());

			UserSession userSession = new UserSession(paramMap);
			UsernamePasswordAuthenticationToken authToken = new UsernamePasswordAuthenticationToken(userSession, "", userSession.getAuthorities());

			SecurityContext sc = SecurityContextHolder.getContext();
			sc.setAuthentication(authToken);

			HttpSession session = request.getSession(true);
			session.setAttribute("SPRING_SECURITY_CONTEXT", sc);

			return true;
		} else {
			return false;
		}

	}

	public String decryptKepco(String pgsecuid) {
		String getUserId = "";
		String cmd = "/app/tomcat/seed_decode -d " + pgsecuid;  // 복호화 모듈
		Runtime rt = Runtime.getRuntime();
		try {
			Process ps = rt.exec(cmd);
			try(BufferedReader br = new BufferedReader(new InputStreamReader(new SequenceInputStream(ps.getInputStream(), ps.getErrorStream())))) {
				getUserId = br.readLine();
			}
		} catch(Exception e) {
			log.error(e.toString());
		}
		return getUserId;
	}

	public boolean mailSession(HttpServletRequest request, String userId) {

		if(StringUtils.isBlank(userId)) { return false; }

		// 사용자 정보 DB get
		CustomCmmUserVO req = new CustomCmmUserVO();
		req.setUserId(userId);
		CustomCmmUserVO res = cmmUserService.loginChk(req);

		if(res != null) {
			if(res.getUserBlock().equals("Y")) {
				return false;
			}
			// security session 생성
//			UserSession userSession =
//					new UserSession(userId, res.getUserPassword(), res.getUserAuthority(), res.getUserName(), res.getPwdInitFlag(), res.getDeptCode(), res.getApprvPass());
//			UsernamePasswordAuthenticationToken authToken =
//					new UsernamePasswordAuthenticationToken(userSession, res.getUserPassword(), userSession.getAuthorities());

			Map<String, String> paramMap = new HashMap<>();
			paramMap.put("roles",res.getUserAuthority());
			paramMap.put("id", res.getUserId());
			paramMap.put("nickname", res.getUserName());
			paramMap.put("initFlag", res.getPwdInitFlag());
			paramMap.put("deptCode", res.getDeptCode());
			paramMap.put("apprvPass", res.getApprvPass());
			paramMap.put("customerId",res.getCustomerId());
			paramMap.put("levelCode", res.getUserLevelCode());
			paramMap.put("levelName", res.getUserLevelCodeName());

			UserSession userSession = new UserSession(paramMap);
			UsernamePasswordAuthenticationToken authToken = new UsernamePasswordAuthenticationToken(userSession, "", userSession.getAuthorities());

			SecurityContext sc = SecurityContextHolder.getContext();
			sc.setAuthentication(authToken);

			HttpSession session = request.getSession(true);
			session.setAttribute("SPRING_SECURITY_CONTEXT", sc);

			return true;
		} else {
			return false;
		}

	}

}
