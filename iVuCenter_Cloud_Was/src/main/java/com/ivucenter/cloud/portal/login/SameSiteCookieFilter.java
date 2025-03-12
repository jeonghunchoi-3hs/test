package com.ivucenter.cloud.portal.login;

import java.io.IOException;
import java.util.Collection;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.filter.OncePerRequestFilter;

public class SameSiteCookieFilter extends OncePerRequestFilter{

	@Override
	protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain chain) throws IOException, ServletException {
		
		chain.doFilter(request, response);
		
		Collection<String> headers = response.getHeaders("Set-Cookie");
		boolean firstHeader = true;
		for (String header : headers) {
			if (header.contains("JSESSIONID") && !header.contains("SameSite")) {
				String newHeader = String.format("%s; SameSite=Lax", header);
				if(firstHeader) {
					response.setHeader("Set-Cookie", newHeader);
					firstHeader = false;
				} else {
					response.addHeader("Set-Cookie", newHeader);
				}
			}
		}
		
	}
}