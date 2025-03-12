package com.ivucenter.cloud.api.openstack.object;

import java.util.HashMap;
import java.util.Map;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class RequestPasswordCredentials {
	// Inner class
	private class RequestUser {
		// variables
		private Map<String, String> domain;
		private String name;
		private String password;
		
		// Constractors
		public RequestUser() { domain = new HashMap<String, String>(); }
		public RequestUser(String project, String username, String password) {
			domain = new HashMap<String, String>();
			this.domain.put("name","Default");
			// ToDo : 인증 요청 시 project 명 추가 여부 검토 필요
			// ToDo : 도메인명이 default가 아닌 것이 필요한지 여부 검토 필요
			this.name = username;
			this.password = password;
		}
		

		public Map<String, String> getDomain() { return domain; }
		public void setDomain(Map<String, String> domain) { this.domain = domain; }

		public String getName() { return name; }
		public void setName(String name) { this.name = name; }

		public String getPassword() { return password; }
		public void setPassword(String password) { this.password = password; }
	}
	
	// Members
	private RequestUser user;
	
	// Constractors
	public RequestPasswordCredentials() { this.user = new RequestUser(); }
	public RequestPasswordCredentials(String project, String username, String password) {
		this.user = new RequestUser(project, username, password);
	}
}
