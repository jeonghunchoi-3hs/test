package com.ivucenter.cloud.api.openstack.object;

import java.util.ArrayList;
import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Identity { 
	// variables
	private List<String> methods;
	private RequestPasswordCredentials password;
	
	// Constractors
	public Identity() {}
	public Identity(String project, String username, String password) {
		if(null == this.methods) { methods = new ArrayList<>(); }
		this.methods.add("password");
		this.password = new RequestPasswordCredentials(project, username, password);
	}	
}

