package com.ivucenter.cloud.entity;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BillChargeResourceDetailVO extends DataTableVO{
	
	private String billYyyymm;
	private String cloudId;
	private String customerId;
	private String projectId;
	private String resourceId;
	private String resourceItem;
	private Date chargeStartDatetime;
	private Date chargeEndDatetime;
	private double measureValue;
	private String hourlyFlag;
	private int duration;
	private double price;
	private int amount;
	private int amountSub;
	private String serviceType;
	private String volumeType;
	private String imageItemId;
}
