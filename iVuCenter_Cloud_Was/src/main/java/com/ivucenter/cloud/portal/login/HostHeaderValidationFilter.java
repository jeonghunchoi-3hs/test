package com.ivucenter.cloud.portal.login;

import java.io.IOException;
import java.util.HashSet;
import java.util.Set;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.filter.OncePerRequestFilter;

public class HostHeaderValidationFilter extends OncePerRequestFilter{

	private static final Set<String> ALLOWED_HOSTS = new HashSet<>();
	
	static {
		ALLOWED_HOSTS.add("www.k-cloud.kepco.co.kr");
		ALLOWED_HOSTS.add("k-cloud.kepco.co.kr");
		ALLOWED_HOSTS.add("localhost:8020");
		ALLOWED_HOSTS.add("100.1.221.205");
		ALLOWED_HOSTS.add("100.1.221.206");
	}
	
	@Override
	public void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain chain) throws IOException, ServletException {
		String host = request.getHeader("Host");
		if (host == null | !ALLOWED_HOSTS.contains(host)) {
			response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Host header");
			return;
		}
		chain.doFilter(request, response);
	}
}