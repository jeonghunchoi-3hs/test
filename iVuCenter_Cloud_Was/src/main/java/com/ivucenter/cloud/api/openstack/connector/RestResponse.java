package com.ivucenter.cloud.api.openstack.connector;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class RestResponse {
	private int statusCode;
	private String message;
	private String subjectToken;
}
