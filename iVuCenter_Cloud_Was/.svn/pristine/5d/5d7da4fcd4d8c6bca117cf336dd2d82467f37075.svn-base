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
import com.ivucenter.cloud.api.openstack.interfaces.LoadbalancerIF;
import com.ivucenter.cloud.api.openstack.object.Loadbalancer;
import com.ivucenter.cloud.api.openstack.object.OpenStackJsonObject;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;

import lombok.AccessLevel;
import lombok.NoArgsConstructor;

@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class OpenStackLoadbalancer extends OpenStackShared implements LoadbalancerIF {

	private String projectName;
	private String API_NETWORK_SERVER;

	public OpenStackLoadbalancer(String projectName,CustomOssCloudVO cloudVo) {
		this.projectName = projectName;
		super.cloudVo = cloudVo;
		this.API_NETWORK_SERVER = cloudVo.getApiNetworkServer();
	}

	@Override
	public List<Loadbalancer> getLoadbalancers() throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getProjectToken(projectName,super.cloudVo));

		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.GET, API_NETWORK_SERVER + "/lbaas/loadbalancers", headers);

		OpenStackJsonObject obj = JsonUtils.getJsonObject(output.getMessage());
		return obj.getLoadbalancers();
	}

	@Override
	public Loadbalancer getLoadbalancer(String loadbalancer_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getProjectToken(projectName,super.cloudVo));
		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.GET, API_NETWORK_SERVER+"/lbaas/loadbalancers/"+loadbalancer_id, headers);

		OpenStackJsonObject obj = JsonUtils.getJsonObject(output.getMessage());

		return obj.getLoadbalancer();
	}

	@Override
	public Loadbalancer createLoadbalancer(Loadbalancer loadbalancer) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		OpenStackJsonObject inJson = new OpenStackJsonObject();
		inJson.setLoadbalancer(loadbalancer);

		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getProjectToken(projectName, super.cloudVo));
		String contentType = "application/json";
		String payLoad = JsonUtils.getJsonFormatString(inJson);
		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.POST, API_NETWORK_SERVER+"/lbaas/loadbalancers", headers, contentType, payLoad);
		OpenStackJsonObject obj = JsonUtils.getJsonObject(output.getMessage());
		return obj.getLoadbalancer();
	}

	@Override
	public Loadbalancer updateLoadbalancer(Loadbalancer loadbalancer) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		String loadbalancer_id = loadbalancer.getId();
		loadbalancer.setId(null);

		OpenStackJsonObject inJson = new OpenStackJsonObject();
		inJson.setLoadbalancer(loadbalancer);

		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getProjectToken(projectName, super.cloudVo));
		String contentType = "application/json";
		String payLoad = JsonUtils.getJsonFormatString(inJson);
		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.PUT, API_NETWORK_SERVER+"/lbaas/loadbalancers/"+loadbalancer_id, headers, contentType, payLoad);
		OpenStackJsonObject obj = JsonUtils.getJsonObject(output.getMessage());
		return obj.getLoadbalancer();
	}

	@Override
	public boolean deleteLoadbalancer(String loadbalancer_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getProjectToken(projectName,super.cloudVo));
		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.DELETE, API_NETWORK_SERVER+"/lbaas/loadbalancers/"+loadbalancer_id, headers, true);
		if (output.getStatusCode() == 204)
			return true;
		return false;
	}


}
