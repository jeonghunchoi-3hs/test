package com.ivucenter.cloud.api.openstack.interfaces;

import java.util.List;

import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.api.openstack.object.Role;
import com.ivucenter.cloud.api.openstack.object.User;

public interface UserIF {

	public User getUser(String user_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public User getUserByName(String name) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public List<User> getUsers() throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
//	public List<User> getUsers(String project_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public List<Role> getRoles(String project_id, String user_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public boolean assignUserRole(String project_id, String user_id, String role_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
}
