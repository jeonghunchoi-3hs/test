package com.ivucenter.cloud.entity;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.ivucenter.cloud.api.openstack.connector.OpenStackRestConnector;
import com.ivucenter.cloud.portal.util.AES256Util;
import com.ivucenter.cloud.portal.util.CodeUtil;

public class HrsystemTemporaryVO extends DataTableVO{

    private static final Logger logger = LoggerFactory.getLogger(HrsystemTemporaryVO.class);

	public String userId;
	public String userName;
	public String deptCode;
	public String dutyCode;
	public String dutyName;
	public String rankCode;
	public String rankName;
	public String userPhone;
	public String userTel;
	public String userMail;
	public String regUserId;
	public String regDatetime;

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
	public String getUserPhone() {
		return userPhone;
	}
	public void setUserPhone(String userPhone) {
		this.userPhone = userPhone;
	}
	@JsonIgnore
	public String getUserPhoneEnc(){
		if(StringUtils.isEmpty(userPhone)){ return ""; }
		try {
			AES256Util aes = new AES256Util(CodeUtil.KEY_SPEC);
			return aes.encrypt(userPhone);
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {

            logger.error("getUserPhoneEnc Exception");

			return "";
		}
	}
	@JsonIgnore
	public String getUserPhoneDec(){
		if(StringUtils.isEmpty(userPhone)){ return ""; }
		try {
			AES256Util aes = new AES256Util(CodeUtil.KEY_SPEC);
			return aes.decrypt(userPhone);
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {

            logger.error("getUserPhoneDec Exception");

            return "";
		}
	}

	public String getUserTel() {
		return userTel;
	}
	public void setUserTel(String userTel) {
		this.userTel = userTel;
	}
	@JsonIgnore
	public String getUserTelEnc(){
		if(StringUtils.isEmpty(userTel)){ return ""; }
		try {
			AES256Util aes = new AES256Util(CodeUtil.KEY_SPEC);
			return aes.encrypt(userTel);
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {

			logger.error("getUserTelEnc Exception");

			return "";
		}
	}
	@JsonIgnore
	public String getUserTelDec(){
		if(StringUtils.isEmpty(userTel)){ return ""; }
		try {
			AES256Util aes = new AES256Util(CodeUtil.KEY_SPEC);
			return aes.decrypt(userTel);
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {

			logger.error("getUserTelDec Exception");

			return "";
		}
	}

	public String getUserMail() {
		return userMail;
	}
	public void setUserMail(String userMail) {
		this.userMail = userMail;
	}
	@JsonIgnore
	public String getUserMailEnc(){
		if(StringUtils.isEmpty(userMail)){ return ""; }
		try {
			AES256Util aes = new AES256Util(CodeUtil.KEY_SPEC);
			return aes.encrypt(userMail);
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {

			logger.error("getUserMailEnc Exception");

			return "";
		}
	}
	@JsonIgnore
	public String getUserMailDec(){
		if(StringUtils.isEmpty(userMail)){ return ""; }
		try {
			AES256Util aes = new AES256Util(CodeUtil.KEY_SPEC);
			return aes.decrypt(userMail);
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {

			logger.error("getUserMailDec Exception");

			return "";
		}
	}
	public String getRegUserId() {
		return regUserId;
	}
	public void setRegUserId(String regUserId) {
		this.regUserId = regUserId;
	}
	public String getRegDatetime() {
		return regDatetime;
	}
	public void setRegDatetime(String regDatetime) {
		this.regDatetime = regDatetime;
	}
}
