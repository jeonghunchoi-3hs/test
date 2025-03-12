package com.ivucenter.cloud.api.openstack.object;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Token {
	private String issued_at;
	private List<String> audit_ids;
	private List<String> methods;
	private String expires_at;
	private User user;
	private TokenProject project;
	@JsonIgnore
	private String subjectToken;
}
