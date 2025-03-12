package com.ivucenter.cloud.api.gitlab;

public class GitlabException extends Exception {

	private static final long serialVersionUID = 2348374613284204666L;
	private int code;

	public int getCode() {
		return code;
	}

	public GitlabException(int code, String message) {
		super(message);
		this.code = code;
	}
}
