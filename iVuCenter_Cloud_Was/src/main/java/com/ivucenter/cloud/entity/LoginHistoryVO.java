package com.ivucenter.cloud.entity;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class LoginHistoryVO extends DataTableVO{
	private String loginDatetime;
	private String userId;
	private String siteGbn;
	private String ip;
	private String successYn;
	private String service;
	private String loginFailMessage;
	
	
}
