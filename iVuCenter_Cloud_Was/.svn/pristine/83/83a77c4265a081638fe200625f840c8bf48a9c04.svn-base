package com.ivucenter.cloud.entity;

import java.util.List;
import java.util.Map;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.ivucenter.cloud.portal.util.CamelUtil;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class DataTableVO {
	
	private int draw;
	private int start;
	private int length;
		
	private String startDt;
	private String endDt;
	
	// 오픈스택 응답 메세지
	private String errorMsg;	
	private String errorStatus;	
	
	private String regDatetime2;
	
	private List<Map<String, String>> order;	// jquery.datatable ,"order": [[4,"desc"]]
	private List<Map<String, String>> columns;	// jquery.datatable ,"columns":[
	
	@JsonIgnore
	public String getOrderDir(){
		try {
			return getOrder().get(0).get("dir");	
		} catch (Exception e) {
			return "";
		}		
	}
	
	@JsonIgnore
	public int getOrderColumnNo(){
		try {
			return Integer.parseInt(getOrder().get(0).get("column"));	
		} catch (Exception e) {
			return 0;
		}
	}
	
	@JsonIgnore
	public String getOrderColumn(){
		try {
			return CamelUtil.UnderScoreCase(getColumns().get(getOrderColumnNo()).get("data"));	
		} catch (Exception e) {
			return "";
		}
	}
	
	@JsonIgnore
	public String getOrderColumnCamel(){
		try {
			return CamelUtil.CamelCase(getColumns().get(getOrderColumnNo()).get("data"));	
		} catch (Exception e) {
			return "";
		}
	}
}
