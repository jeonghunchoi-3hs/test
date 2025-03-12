package com.ivucenter.cloud.api.openstack.interfaces;

import java.util.List;

import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.api.openstack.object.Subnet;

public interface SubnetIF {

	public Subnet createSubnet(Subnet subnet) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public Subnet getSubnet(String subnet_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public Subnet updateSubnet(Subnet subnet) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public boolean deleteSubnet(String subnet_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public List<Subnet> getSubnets(String network_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public List<Subnet> getSubnets() throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
}
