package com.ivucenter.cloud.api.openstack.interfaces;

import java.util.List;

import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.api.openstack.object.Flavor;

public interface FlavorIF {

	public Flavor createFlavor(Flavor flavor) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public Flavor getFlavor(String flavor_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public List<Flavor> getFlavors() throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
}
