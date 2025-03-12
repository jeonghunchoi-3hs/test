package com.ivucenter.cloud.api.openstack.interfaces;

import java.util.List;

import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.api.openstack.object.Listener;

public interface ListenerIF {
	
	public Listener createListener(Listener listener) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public Listener getListener(String listener_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public Listener updateListener(Listener listener) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public boolean deleteListener(String listener_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public List<Listener> getListeners() throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public boolean isExist(String name) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
}
