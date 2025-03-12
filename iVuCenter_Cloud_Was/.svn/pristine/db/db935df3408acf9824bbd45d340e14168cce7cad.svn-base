package com.ivucenter.cloud.api.openstack.interfaces;

import java.util.List;

import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.api.openstack.object.Router;

public interface RouterIF {

	public Router createRouter(Router router) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public Router getRouter(String router_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public Router updateRouter(Router router) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public boolean deleteRouter(String router_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public List<Router> getRouters() throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public boolean isExist(String name) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public boolean addRouterInterfaceSubnet(String router_id, String subnet_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public boolean addRouterInterfacePort(String router_id, String port_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public boolean removeRouterInterfaceSubnet(String router_id, String subnet_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public boolean removeRouterInterfacePort(String router_id, String port_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
}
