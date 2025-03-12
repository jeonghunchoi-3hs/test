package com.ivucenter.cloud.api.openstack.interfaces;

import java.util.List;

import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.api.openstack.object.Role;

public interface RoleIF {
	public List<Role> getRoles() throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public Role getRole(String role_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public Role getRoleByName(String name) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	
}
