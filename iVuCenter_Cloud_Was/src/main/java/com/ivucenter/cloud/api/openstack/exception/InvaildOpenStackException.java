package com.ivucenter.cloud.api.openstack.exception;

public class InvaildOpenStackException extends Exception {
	private static final long serialVersionUID = 2191610284423776795L;

	private int code;

	public int getCode() {
		return code;
	}

	public InvaildOpenStackException(int code, String message) {
		super(message);
		this.code = code;
	}

}
