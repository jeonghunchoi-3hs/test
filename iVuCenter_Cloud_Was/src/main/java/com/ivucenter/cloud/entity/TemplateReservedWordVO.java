package com.ivucenter.cloud.entity;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class TemplateReservedWordVO extends DataTableVO{
	
	private String templateId;
	private String reservedWord;
	
}
