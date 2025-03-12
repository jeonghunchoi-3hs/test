package com.ivucenter.cloud.api.openstack.exception;

public class NotSupportGatewayException extends Exception {
	private static final long serialVersionUID = 2194210284423776795L;

	private int code;

	public int getCode() {
		return code;
	}

	public NotSupportGatewayException(int code, String message) {
		super(message);
		this.code = code;
	}

}
