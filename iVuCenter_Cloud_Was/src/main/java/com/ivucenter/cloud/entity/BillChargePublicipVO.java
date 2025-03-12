package com.ivucenter.cloud.entity;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BillChargePublicipVO extends DataTableVO{

	private String billYyyymm;
	private String customerId;
	private String projectId;	
	private String publicipId;
	private String chargeResourceStatus;
	private String hourlyFlag;             
	private Date createDatetime;     
	private Date expireDatetime; 
	private Date chargeStartDatetime;     
	private Date chargeEndDatetime;   
	private int amount;
	
}
