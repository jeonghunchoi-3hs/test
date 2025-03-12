package com.ivucenter.cloud.portal.login;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.MediaType;
import org.springframework.security.web.session.InvalidSessionStrategy;
import org.springframework.security.web.util.matcher.ELRequestMatcher;
import org.springframework.security.web.util.matcher.RequestMatcher;
import org.springframework.util.StringUtils;

import lombok.extern.slf4j.Slf4j;
 
@Slf4j
public class AjaxSessionFilter implements InvalidSessionStrategy{

	private RequestMatcher requestMatcher = new ELRequestMatcher("hasHeader('X-Requested-With','XMLhttpRequest')"); 
	
	@Override
	public void onInvalidSessionDetected(HttpServletRequest request, HttpServletResponse respone) throws IOException, ServletException {
		log.debug("AjaxSessionFilter");
		boolean ajaxRedirect = requestMatcher.matches(request);
		if(ajaxRedirect){
			respone.setContentType(MediaType.APPLICATION_JSON_VALUE);
			respone.sendError(901, "동일한 ID로 접속정보가 확인되어 로그아웃됩니다.\n계속 이용하시려면 재로그인을 해주십시오.");
		}else{
			String requestURI = getRequestUrl(request);
			request.getSession(true);
			respone.sendRedirect(requestURI);
		}
	}

	private String getRequestUrl(HttpServletRequest request) {
		StringBuffer requestURL = request.getRequestURL();
		
		String questyString = request.getQueryString();
		if(StringUtils.hasText(questyString)){
			requestURL.append("?").append(questyString);
		}
		return requestURL.toString();
	}
	
}
