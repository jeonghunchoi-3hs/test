package com.ivucenter.cloud.api.ansible;

public class AnsibleException extends Exception {

	private static final long serialVersionUID = 2348374613284204666L;
	private int code;

	public int getCode() {
		return code;
	}

	public AnsibleException(int code, String message) {
		super(message);
		this.code = code;
	}
}
