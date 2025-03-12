package com.ivucenter.cloud.api.openstack.interfaces;

import java.util.List;

import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.api.openstack.object.Floatingip;

public interface FloatingipIF {

	public Floatingip createFloatingip(String name, boolean enabled, String description) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public Floatingip getFloatingip(String floatingip_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public Floatingip updateFloatingip(String floatingIP_id, String name, boolean enabled, String description) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public boolean deleteFloatingip(String floatingIP_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public List<Floatingip> getFloatingips() throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public boolean isExist(String name) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
}
