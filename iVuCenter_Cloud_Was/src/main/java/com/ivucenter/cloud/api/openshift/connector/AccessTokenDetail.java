package com.ivucenter.cloud.api.openshift.connector;

import java.util.Date;

import org.apache.commons.lang.StringUtils;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class AccessTokenDetail {
	
	private String token;
	private String expires;
	private String userName;
	private Date issueDate;
	private int i_expires;
	private int EXPIRE_BEFORE_SEC = 300;   // 만료 5분전 재발행

	public boolean isAuthorized() {
		return StringUtils.isNotBlank(token);
	}

	public String getToken() {
		return this.token;
	}

	public String getExpiresIn() {
		return expires;
	}

	public void setToken(String token) {
		this.token = token;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserName() {
		return this.userName;
	}

	public void setExpiresIn(String expiresIn) {
		try {
			this.i_expires = Integer.parseInt(expiresIn);
		} catch (NumberFormatException e) {
			log.error(expiresIn, e);
		}
		this.expires = expiresIn;
	}

	public boolean isValidToken() {
		if (StringUtils.isBlank(this.token)) {
			return false;
		}
		if (issueDate != null) {
			int termSec = (int) (System.currentTimeMillis() - this.issueDate.getTime()) / 1000 + 1;
			int limitSec = this.i_expires - termSec - EXPIRE_BEFORE_SEC;
			if (limitSec > 0) {
				return true;
			}
		}

		return false;
	}

	public void setIssueDate(Date issueDate) {
		this.issueDate = issueDate;
	}

	@Override
	public String toString() {
		return "AccessTokenDetail [token=" + token + ", expires=" + expires + ", userName=" + userName + ", issueDate="
				+ issueDate + ", i_expires=" + i_expires + ", EXPIRE_BEFORE_SEC=" + EXPIRE_BEFORE_SEC + "]";
	}
	
	
	
}
