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
import com.ivucenter.cloud.api.openstack.interfaces.SecurityGroupIF;
import com.ivucenter.cloud.api.openstack.object.OpenStackJsonObject;
import com.ivucenter.cloud.api.openstack.object.SecurityGroup;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;

import lombok.AccessLevel;
import lombok.NoArgsConstructor;

@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class OpenStackSecurityGroup extends OpenStackShared implements SecurityGroupIF {

	private String projectName;
	private String API_NETWORK_SERVER;

	public OpenStackSecurityGroup(String projectName,CustomOssCloudVO cloudVo) {
		this.projectName = projectName;
		super.cloudVo = cloudVo;
		this.API_NETWORK_SERVER = cloudVo.getApiNetworkServer();
	}

	@Override
	public List<SecurityGroup> getSecurityGroups(CustomOssCloudVO cloudVo) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
//		headers.put("X-Auth-Token", getAdminToken());
		headers.put("X-Auth-Token", getProjectToken(projectName,cloudVo));

		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.GET, API_NETWORK_SERVER + "/security-groups", headers);

		OpenStackJsonObject obj = JsonUtils.getJsonObject(output.getMessage());
		return obj.getSecurity_groups();
	}

	@Override
	public List<SecurityGroup> getSecurityGroup(String tenant_id,CustomOssCloudVO cloudVo) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
//		headers.put("X-Auth-Token", getAdminToken());
		headers.put("X-Auth-Token", getProjectToken(projectName,cloudVo));

		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.GET, API_NETWORK_SERVER+"/security-groups?tenant_id="+tenant_id, headers);
		OpenStackJsonObject obj = JsonUtils.getJsonObject(output.getMessage());
		return obj.getSecurity_groups();
	}

}
