package com.ivucenter.cloud.entity;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BillPolicyVO extends DataTableVO{

	//bill_product_catalog 테이블
	private String policySeq;
	private String policyName;
	private String applyDate;
	private String regDatetime;
	private String regUserId;
	private String modDatetime;
	private String modUserId;
	private String delFlag = "N";
	
	//bill_policy_item 테이블
	private String itemId;
	
	//bill_product_catalog_item 테이블
	private String startRange;
	private String endRange;
	private String hourlyPrice;
	private String monthlyPrice;
	
	//bill_product 테이블
	private String itemName = "";
	private String unit;
	private String quantity;
	private String description;
	private String itemCategory;
	private String disableFlag;
	
		
}
