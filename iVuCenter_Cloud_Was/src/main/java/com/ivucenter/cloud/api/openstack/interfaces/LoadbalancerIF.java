package com.ivucenter.cloud.api.openstack.interfaces;

import java.util.List;

import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.api.openstack.object.Loadbalancer;

public interface LoadbalancerIF {
	
	public Loadbalancer createLoadbalancer(Loadbalancer loadbalancer) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public Loadbalancer getLoadbalancer(String loadbalancer_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public Loadbalancer updateLoadbalancer(Loadbalancer loadbalancer) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public boolean deleteLoadbalancer(String loadbalancer_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public List<Loadbalancer> getLoadbalancers() throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
}
