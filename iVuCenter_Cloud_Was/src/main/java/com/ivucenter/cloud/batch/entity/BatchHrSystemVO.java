package com.ivucenter.cloud.batch.entity;

public class BatchHrSystemVO {
	private String userId;
	private String userName;
	private String deptCode;
	private String dutyCode;
	private String dutyName;
	private String rankCode;
	private String rankName;
	private String userPhone;
	private String userTel;	
	private String userMail;
	private String regUserId;
	private String regDatetime;
	
	
	
	/**
	 * @return the userId
	 */
	public String getUserId() {
		return userId;
	}



	/**
	 * @param userId the userId to set
	 */
	public void setUserId(String userId) {
		this.userId = userId;
	}



	/**
	 * @return the userName
	 */
	public String getUserName() {
		return userName;
	}



	/**
	 * @param userName the userName to set
	 */
	public void setUserName(String userName) {
		this.userName = userName;
	}



	/**
	 * @return the deptCode
	 */
	public String getDeptCode() {
		return deptCode;
	}



	/**
	 * @param deptCode the deptCode to set
	 */
	public void setDeptCode(String deptCode) {
		this.deptCode = deptCode;
	}



	/**
	 * @return the dutyCode
	 */
	public String getDutyCode() {
		return dutyCode;
	}



	/**
	 * @param dutyCode the dutyCode to set
	 */
	public void setDutyCode(String dutyCode) {
		this.dutyCode = dutyCode;
	}



	/**
	 * @return the dutyName
	 */
	public String getDutyName() {
		return dutyName;
	}



	/**
	 * @param dutyName the dutyName to set
	 */
	public void setDutyName(String dutyName) {
		this.dutyName = dutyName;
	}



	/**
	 * @return the rankCode
	 */
	public String getRankCode() {
		return rankCode;
	}



	/**
	 * @param rankCode the rankCode to set
	 */
	public void setRankCode(String rankCode) {
		this.rankCode = rankCode;
	}



	/**
	 * @return the rankName
	 */
	public String getRankName() {
		return rankName;
	}



	/**
	 * @param rankName the rankName to set
	 */
	public void setRankName(String rankName) {
		this.rankName = rankName;
	}



	/**
	 * @return the userPhone
	 */
	public String getUserPhone() {
		return userPhone;
	}



	/**
	 * @param userPhone the userPhone to set
	 */
	public void setUserPhone(String userPhone) {
		this.userPhone = userPhone;
	}



	/**
	 * @return the userTel
	 */
	public String getUserTel() {
		return userTel;
	}



	/**
	 * @param userTel the userTel to set
	 */
	public void setUserTel(String userTel) {
		this.userTel = userTel;
	}



	/**
	 * @return the userMail
	 */
	public String getUserMail() {
		return userMail;
	}



	/**
	 * @param userMail the userMail to set
	 */
	public void setUserMail(String userMail) {
		this.userMail = userMail;
	}



	/**
	 * @return the regUserId
	 */
	public String getRegUserId() {
		return regUserId;
	}



	/**
	 * @param regUserId the regUserId to set
	 */
	public void setRegUserId(String regUserId) {
		this.regUserId = regUserId;
	}



	/**
	 * @return the regDatetime
	 */
	public String getRegDatetime() {
		return regDatetime;
	}



	/**
	 * @param regDatetime the regDatetime to set
	 */
	public void setRegDatetime(String regDatetime) {
		this.regDatetime = regDatetime;
	}



	@Override
	public String toString() {
		return "HrSystemVO [userId=" + userId + ", userName=" + userName + ", deptCode=" + deptCode + ", dutyCode="
				+ dutyCode + ", dutyName=" + dutyName + ", rankCode=" + rankCode + ", rankName=" + rankName + 
				", userPhone="+userPhone+", userTel="+userTel+", userMail="+userMail+", regUserId="+regUserId+", regDatetime="+regDatetime+"]";
	}
	
	
	
}
