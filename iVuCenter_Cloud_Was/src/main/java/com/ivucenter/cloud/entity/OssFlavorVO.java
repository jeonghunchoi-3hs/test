package com.ivucenter.cloud.entity;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class OssFlavorVO extends DataTableVO {
	private String projectId;
	private String diskId;
	private String vmUuid;
	private String cloudId;

	private String flavorId;
	private String flavorName;
	private String flavorType;
	private int ramMb;
	private int diskGb;
	private int ephemeralGb;
	private int vcpus;
	private int swapMb;
	private int isPublic;
	private String properties;

	private Date createDatetime;
	private Date expireDatetime;
	private Date deleteDatetime;
	private Date regDatetime;
	private String regUserId;
	private Date modDatetime;
	private String modUserId;
	private String delFlag = "N";
	private String hourlyFlag;
	private String description;
	private String diskCatalogSeq;
	private String diskProductSeq;
	private String cloudType;
	private String instanceType;

}
