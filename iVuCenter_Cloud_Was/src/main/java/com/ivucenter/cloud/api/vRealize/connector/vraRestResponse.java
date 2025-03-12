package com.ivucenter.cloud.api.vRealize.connector;

import com.ivucenter.cloud.api.vRealize.object.vraServer;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class vraRestResponse {
	private String value;
	private String type;
	private int statusCode;
	private String message;
	private String messages;
	private String defaultMessage;
	private vraServer content;
	
}
