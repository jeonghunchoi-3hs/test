package com.ivucenter.cloud.api.openstack.interfaces;

import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.api.openstack.object.Token;

public interface IdentityIF {
	public Token getToken(String project, String username, String password) 
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
}
