package com.ivucenter.cloud.entity;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BillChargeVmVO extends DataTableVO{

	private String billYyyymm;
	private String cloudId;
	private String customerId;
	private String projectId;
	private String vmUuid;
	private String hostname;
	private String hostnameAlias;
	private String chargeResourceStatus;
	private String hourlyFlag;             
	private Date createDatetime;     
	private Date expireDatetime; 
	private Date chargeStartDatetime;     
	private Date chargeEndDatetime;   
	private int amount;
	
}
