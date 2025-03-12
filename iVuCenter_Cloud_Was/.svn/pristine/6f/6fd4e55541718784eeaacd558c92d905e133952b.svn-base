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
import com.ivucenter.cloud.api.openstack.interfaces.RoleIF;
import com.ivucenter.cloud.api.openstack.object.OpenStackJsonObject;
import com.ivucenter.cloud.api.openstack.object.Role;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;

import lombok.AccessLevel;
import lombok.NoArgsConstructor;

@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class OpenStackRole extends OpenStackShared implements RoleIF {

	private  String API_IDENTITY_SERVER;

	public OpenStackRole(CustomOssCloudVO cloudVo) {
		super.cloudVo = cloudVo;
		this.API_IDENTITY_SERVER = cloudVo.getApiIdentityServer();
	}

	@Override
	public List<Role> getRoles() throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getAdminToken(super.cloudVo));

		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.GET, API_IDENTITY_SERVER + "/roles", headers);

		OpenStackJsonObject obj = JsonUtils.getJsonObject(output.getMessage());
		return obj.getRoles();
	}

	@Override
	public Role getRole(String role_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getAdminToken(super.cloudVo));
		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.GET, API_IDENTITY_SERVER+"/roles/"+role_id, headers);

		OpenStackJsonObject obj = JsonUtils.getJsonObject(output.getMessage());

		return obj.getRole();
	}

	@Override
	public Role getRoleByName(String name) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		List<Role> roles = getRoles();
		for (Role role : roles) {
			if (role.getName().equals(name))
				return role;
		}
		return null;
	}

}
