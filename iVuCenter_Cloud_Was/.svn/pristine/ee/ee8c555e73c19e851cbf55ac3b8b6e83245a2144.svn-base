package com.ivucenter.cloud.entity;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BbsFaqVO extends DataTableVO{
	
	private String searchKind;
	private String keyword = "";
	
	
	private int faqNo;
	private String faqType;
	private String title;
	private String content;	
	private Date regDatetime;
	private String regUserId;
	private Date modDatetime;
	private String modUserId;	
	private String delFlag = "N";
	private String userName;
	private String typeName;
	private int hitCount;
		
	public String getContent() {
		return content.replace("/(?:\r\n|\r|\n)/g", "<br />");
	}
	
}
