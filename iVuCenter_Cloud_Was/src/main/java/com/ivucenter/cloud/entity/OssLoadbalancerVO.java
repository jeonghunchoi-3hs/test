package com.ivucenter.cloud.entity;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class OssLoadbalancerVO extends DataTableVO {
	
	private String loadbalancerId;
	private String projectId;
	private String networkId;
	private String loadbalancerName;
	private String description;
	private String hourlyFlag;
	private String protocol;
	private String method;
	private String monitorType;
	private int loadbalancerEa;
	private Date createDatetime;
	private Date expireDatetime;
	private Date deleteDatetime;
	private Date regDatetime;
	private String regUserId;
	private Date modDatetime;
	private String modUserId;	
	private String delFlag = "N";

	
	
}
