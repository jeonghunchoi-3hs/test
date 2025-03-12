package com.ivucenter.cloud.entity;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BillMasterVO extends DataTableVO{
	
	private String billYyyymm;
	private String cloudId;
	private String billProcStat;
	private String procUserName;
	private Date procDatetime;
	private String confirnFlag;
	private String comfirmUserName;
	private Date confirmDatetime;
	
}
