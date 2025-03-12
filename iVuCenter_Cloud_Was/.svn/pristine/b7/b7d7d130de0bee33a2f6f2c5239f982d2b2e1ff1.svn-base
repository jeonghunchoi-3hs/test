package com.ivucenter.cloud.api.openstack;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpMethod;

import com.ivucenter.cloud.api.common.utils.JsonUtils;
import com.ivucenter.cloud.api.openstack.connector.OpenStackRestConnector;
import com.ivucenter.cloud.api.openstack.connector.RestResponse;
import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.api.openstack.interfaces.UserIF;
import com.ivucenter.cloud.api.openstack.object.OpenStackJsonObject;
import com.ivucenter.cloud.api.openstack.object.Role;
import com.ivucenter.cloud.api.openstack.object.User;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;

import lombok.AccessLevel;
import lombok.NoArgsConstructor;

@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class OpenStackUser extends OpenStackShared implements UserIF {

	private String API_IDENTITY_SERVER;

	public OpenStackUser(CustomOssCloudVO cloudVo) {
		super.cloudVo = cloudVo;
		this.API_IDENTITY_SERVER = cloudVo.getApiIdentityServer();
	}

	@Override
	public List<User> getUsers() throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getAdminToken(super.cloudVo));

		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.GET, API_IDENTITY_SERVER + "/users", headers);

		OpenStackJsonObject obj = JsonUtils.getJsonObject(output.getMessage());

		return obj.getUsers();
	}

	@Override
	public User getUser(String user_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getAdminToken(super.cloudVo));
		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.GET, API_IDENTITY_SERVER+"/users/"+user_id, headers);

		OpenStackJsonObject obj = JsonUtils.getJsonObject(output.getMessage());

		return obj.getUser();
	}

	@Override
	public User getUserByName(String name) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		List<User> users = getUsers();
		for (User user : users) {
			if (user.getName().equals(name))
				return user;
		}
		return null;
	}

//	@Override
//	public List<User> getUsers(String user_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
//		Map<String, String> headers = new HashMap<String, String>();
//		headers.put("X-Auth-Token", getAdminToken());
//
//		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.GET, API_BASE + "/users/"+user_id+"/projects", headers);
//
//		OpenStackJsonObject obj = JsonUtils.getJsonObject(output.getMessage());
//
//		return obj.getUsers();
//	}

	@Override
	public List<Role> getRoles(String project_id, String user_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getAdminToken(super.cloudVo));

		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.GET, API_IDENTITY_SERVER + "/projects/"+project_id+"/users/"+user_id+"/roles", headers);
		OpenStackJsonObject obj = JsonUtils.getJsonObject(output.getMessage());
		return obj.getRoles();
	}

	@Override
	public boolean assignUserRole(String project_id, String user_id, String role_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getAdminToken(super.cloudVo));

		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.PUT, API_IDENTITY_SERVER + "/projects/"+project_id+"/users/"+user_id+"/roles/"+role_id, headers);
		if(output !=null) {return true;}
		return false;
	}

}
