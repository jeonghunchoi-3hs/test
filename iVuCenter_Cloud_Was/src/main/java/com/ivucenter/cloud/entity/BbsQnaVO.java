package com.ivucenter.cloud.entity;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BbsQnaVO extends DataTableVO{
	
	private String searchKind;
	private String typeCodeKind;
	private String keyword = "";	
	private String category;
	
	private int qnaNo;
	private int parentQnaNo;
	private String qnaType;
	private String title;
	private String content;	
	private String secretFlag = "N";
	private Date regDatetime;
	private String regUserId;
	private Date modDatetime;
	private String modUserId;
	private String delFlag = "N";
		
	private String userName;
	

}
