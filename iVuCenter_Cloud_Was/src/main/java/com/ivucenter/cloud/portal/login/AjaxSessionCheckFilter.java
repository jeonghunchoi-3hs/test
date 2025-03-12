package com.ivucenter.cloud.portal.login;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.AuthenticationException;

public class AjaxSessionCheckFilter implements Filter{

	@Override
	public void doFilter(ServletRequest request, ServletResponse respone, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest)request;
		HttpServletResponse res = (HttpServletResponse)respone;
		
		if(isAjaxRequest(req)){
			try {
				chain.doFilter(req, res);
			} catch (AccessDeniedException e) {
				res.setContentType("application/json;charset=UTF-8");
				res.sendError(901, "동일한 ID로 접속정보가 확인되어 로그아웃됩니다.\n계속 이용하시려면 재로그인을 해주십시오.");
				res.setStatus(901);
			} catch (AuthenticationException e) {
				res.setContentType("application/json;charset=UTF-8");
				res.sendError(902, "접속정보가 확인되지않아 로그아웃이 되었습니다.\n계속 이용하시려면 재로그인을 해주십시오.");
				res.setStatus(902);
			}
		}else{
			chain.doFilter(req, res);
		}
		
	}

	private boolean isAjaxRequest(HttpServletRequest req) {
		String ajaxHeader = req.getHeader("AJAX");  
		if(ajaxHeader == null){
			return false;
		}else if(ajaxHeader.equals(Boolean.TRUE.toString())){
			return true;
		}else{
			return false;
		}
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {}
	
	@Override
	public void destroy() {}
}
