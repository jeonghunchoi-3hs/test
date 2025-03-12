package com.ivucenter.cloud.portal.productUsageStatus.nas;

import com.ivucenter.cloud.entity.DataTableVO;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CustomProductUsageStatusNasVO extends DataTableVO{
	
	
	private String searchKind;
	private String keyword = "";
	
	private String searchKey0;
	private String searchKey1;
	private String searchKey2;
	private String searchKey3;


	private String companyName;
	private String customerId;
	private String customerName;
	private String projectId;
	private String projectName;
	private String projectAlias;
	private String hourlyFlag;
	private String regDatetime;
	
	private String nasName;
	private String nasGb;
	
}
