package com.ivucenter.cloud.entity;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BbsDownloadVO extends DataTableVO{
	private int downloadNo;
	private String downloadType;
	private String title;
	private String content;
	private int filesCnt;
	private Date regDatetime;
	private String regUserId;
	private Date modDatetime;
	private String modUserId;
	private String delFlag = "N";
	
	private String userName;
	
	
	
}
