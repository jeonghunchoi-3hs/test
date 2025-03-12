package com.ivucenter.cloud.api.openstack.interfaces;

import java.util.List;

import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.api.openstack.object.Port;

public interface PortIF {

	public Port getPort(String port_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public List<Port> getPorts() throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public Port createPort(Port port) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public Boolean deletePort(Port port) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
}
