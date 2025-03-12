package com.ivucenter.cloud.api.openstack.interfaces;

import java.util.List;

import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.api.openstack.object.Pool;

public interface PoolIF {
	
	public Pool createPool(Pool pool) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public Pool getPool(String pool_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public Pool updatePool(Pool pool) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public boolean deletePool(String pool_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public List<Pool> getPools() throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public boolean isExist(String name) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
}
