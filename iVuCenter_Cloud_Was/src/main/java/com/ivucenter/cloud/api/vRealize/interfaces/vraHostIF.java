package com.ivucenter.cloud.api.vRealize.interfaces;

import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.api.vRealize.object.vraHostContent;

public interface vraHostIF {
	public vraHostContent getHosts() throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
}
