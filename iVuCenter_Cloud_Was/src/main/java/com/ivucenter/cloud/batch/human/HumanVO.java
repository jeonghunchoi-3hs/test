package com.ivucenter.cloud.batch.human;

public class HumanVO {
	private String userId;
	private String userName;
	private String deptCode;
	private String dutyCode;
	private String dutyName;
	private String rankCode;
	private String rankName;
	
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
	public String getDeptCode() {
		return deptCode;
	}
	public void setDeptCode(String deptCode) {
		this.deptCode = deptCode;
	}
	public String getDutyCode() {
		return dutyCode;
	}
	public void setDutyCode(String dutyCode) {
		this.dutyCode = dutyCode;
	}
	public String getDutyName() {
		return dutyName;
	}
	public void setDutyName(String dutyName) {
		this.dutyName = dutyName;
	}
	public String getRankCode() {
		return rankCode;
	}
	public void setRankCode(String rankCode) {
		this.rankCode = rankCode;
	}
	public String getRankName() {
		return rankName;
	}
	public void setRankName(String rankName) {
		this.rankName = rankName;
	}
	@Override
	public String toString() {
		return "Report [userId=" + userId + ", userName=" + userName + ", deptCode=" + deptCode + ", dutyCode="
				+ dutyCode + ", dutyName=" + dutyName + ", rankCode=" + rankCode + ", rankName=" + rankName + "]";
	}
	
	
	
}
