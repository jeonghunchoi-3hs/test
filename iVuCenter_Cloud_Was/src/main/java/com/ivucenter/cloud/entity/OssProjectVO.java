package com.ivucenter.cloud.entity;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class OssProjectVO extends DataTableVO{
	private String projectId;
	private String projectBoxId;
	private String customerId;
	private String projectManagerId;
	private String projectName;
	private String projectAlias;
	private String regDatetime;
	private String regUserId;
	private String modDatetime;
	private String modUserId;
	private String deleteFlag = "N";
	private String description;

	private String reqProjectSeq;
	private String deptCode;
	private String projectStartDatetime;
	private String projectEndDatetime;
	private String projectPrice;
	private String projectDescription;
	private String cloudId;
	private String cloudName;
	private String cloudType;
	private String envType;
}
