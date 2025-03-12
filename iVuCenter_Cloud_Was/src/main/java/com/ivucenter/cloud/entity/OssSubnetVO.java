package com.ivucenter.cloud.entity;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class OssSubnetVO extends DataTableVO{
	private String subnetId;
	private String subnetName;
	private String subnetAlias;
	private String networkId;
	private String allocationPools;
	private String subnetCidr;
	private Boolean enableDhcp;
	private String gatewayIp;
	private String dnsNameservers;
	
	private Date regDatetime;
	private String regUserId;
	private Date modDatetime;
	private String modUserId;
	private String deleteFlag = "N";
	private String cloudId;
	
	
	
}
