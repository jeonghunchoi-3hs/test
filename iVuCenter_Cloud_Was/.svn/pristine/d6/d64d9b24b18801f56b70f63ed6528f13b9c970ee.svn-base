package com.ivucenter.cloud.api.openstack.object;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class RequestAuth {	
	// members
	private Identity identity;
	private Scope scope;
	
	// Constractors
	public RequestAuth() { 
		identity = new Identity();
		scope = new Scope(null, null, null);
	}
	public RequestAuth(String project, String username, String password) {
		identity = new Identity(project, username, password);
		scope = new Scope(project, username, password);
	}
}
