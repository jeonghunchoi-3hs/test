package com.ivucenter.cloud.api.nas;

public class NasException extends Exception {

	private static final long serialVersionUID = 2348374613284204666L;
	private int code;

	public int getCode() {
		return code;
	}

	public NasException(int code, String message) {
		super(message);
		this.code = code;
	}
}
