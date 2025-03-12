package com.ivucenter.cloud.portal.productUsageStatus.fs;

import com.ivucenter.cloud.entity.DataTableVO;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CustomProductUsageStatusFsVO extends DataTableVO{


	private String searchKind;
	private String keyword = "";

	private String cloudId;
	private String cloudName;
	private String cloudType;

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
