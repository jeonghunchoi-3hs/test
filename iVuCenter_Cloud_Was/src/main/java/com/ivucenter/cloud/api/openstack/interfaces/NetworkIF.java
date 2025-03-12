package com.ivucenter.cloud.api.openstack.interfaces;

import java.util.List;

import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.api.openstack.object.Network;

public interface NetworkIF {
	
	public Network createNetwork(Network network) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public Network getNetwork(String network_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public Network updateNetwork(Network network) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public boolean deleteNetwork(String network_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public List<Network> getNetworks() throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public boolean isExist(String name) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
}
