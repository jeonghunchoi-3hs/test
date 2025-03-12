package com.ivucenter.cloud.portal.cmm.aop;

import java.util.List;
import java.util.Map;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.ivucenter.cloud.portal.util.CamelUtil;

public class UserHistoryVO {

	private String historyDatetime;
	private String userId;
	private String userRole;
	private String userName;
	private String ip;
	private String methodName;
	private String taskName;


	private int start;
	private int length;

	private int draw;


	private String searchKind;
	private String keyword;
	private List<Map<String, String>> columns;






	private List<Map<String, String>> order;

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

	public int getDraw() {
		return draw;
	}
	public void setDraw(int draw) {
		this.draw = draw;
	}
	public int getStart() {
		return start;
	}
	public void setStart(int start) {
		this.start = start;
	}
	public int getLength() {
		return length;
	}
	public void setLength(int length) {
		this.length = length;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public String getSearchKind() {
		return searchKind;
	}
	public void setSearchKind(String searchKind) {
		this.searchKind = searchKind;
	}





	public String getUserRole() {
		return userRole;
	}
	public void setUserRole(String userRole) {
		this.userRole = userRole;
	}
	public String getHistoryDatetime() {
		return historyDatetime;
	}
	public void setHistoryDatetime(String historyDatetime) {
		this.historyDatetime = historyDatetime;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public String getMethodName() {
		return methodName;
	}
	public void setMethodName(String MethodName) {
		this.methodName = MethodName;
	}
	public String getTaskName() {
		return taskName;
	}
	public void setTaskName(String taskName) {
		this.taskName = taskName;
	}

	public List<Map<String, String>> getOrder() {
		return order;
	}
	public void setOrder(List<Map<String, String>> order) {
		this.order = order;
	}

	public void setColumns(List<Map<String, String>> columns) {
		this.columns = columns;
	}
	public List<Map<String, String>> getColumns() {
		return columns;
	}


}
