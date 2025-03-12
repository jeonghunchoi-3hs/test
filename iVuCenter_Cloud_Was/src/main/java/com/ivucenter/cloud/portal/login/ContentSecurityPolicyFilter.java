package com.ivucenter.cloud.portal.login;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ContentSecurityPolicyFilter implements Filter{

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		if (response instanceof HttpServletResponse && request instanceof HttpServletRequest) {
			HttpServletResponse httpResponse = (HttpServletResponse) response;
			httpResponse.setHeader("Content-Security-Policy", "default-src 'self'; ing-src 'self' data:; frame-ancestors 'none';");
		}
			chain.doFilter(request, response);
	}
}