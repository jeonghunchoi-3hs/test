package com.ivucenter.cloud.entity;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CmmCodeVO extends DataTableVO{

	private String codeKeyId;
	private String codeId;
	private String codeName;
	private String codeValue;
	private String codeValue1;
	private String codeValue2;
	private String codeValue3;
	private String codeType;
	private int codeLevel;
	private String parentCodeId;
	private String codeHideFlag;
	private int codeSortNum;
	private String regDatetime;
	private String regUserId;
	private String modDatetime;
	private String modUserId;	
	private String delFlag = "N";
	
}
