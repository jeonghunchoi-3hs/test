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
import com.ivucenter.cloud.api.openstack.interfaces.ListenerIF;
import com.ivucenter.cloud.api.openstack.object.Listener;
import com.ivucenter.cloud.api.openstack.object.OpenStackJsonObject;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;

import lombok.AccessLevel;
import lombok.NoArgsConstructor;

@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class OpenStackListener extends OpenStackShared implements ListenerIF {

	private String projectName;
	private String API_GATEWAY_SERVER;

	public OpenStackListener(String projectName,CustomOssCloudVO cloudVo) {
		this.projectName = projectName;
		super.cloudVo = cloudVo;
		this.API_GATEWAY_SERVER = cloudVo.getApiGatewayServer();
	}

	@Override
	public List<Listener> getListeners()
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getProjectToken(projectName, super.cloudVo));

		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.GET, API_GATEWAY_SERVER+"/api/network/1.0" + "/lbaas/listeners", headers);

		OpenStackJsonObject obj = JsonUtils.getJsonObject(output.getMessage());
		return obj.getListeners();
	}

	@Override
	public Listener getListener(String loadBalancerListener_id)
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getProjectToken(projectName, super.cloudVo));
		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.GET, API_GATEWAY_SERVER+"/api/network/1.0"+"/lbaas/listeners/"+loadBalancerListener_id, headers);

		OpenStackJsonObject obj = JsonUtils.getJsonObject(output.getMessage());

		return obj.getListener();
	}

	@Override
	public Listener createListener(Listener loadBalancerListener)
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		OpenStackJsonObject inJson = new OpenStackJsonObject();
		inJson.setListener(loadBalancerListener);

		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getProjectToken(projectName,super.cloudVo));
		String contentType = "application/json";
		String payLoad = JsonUtils.getJsonFormatString(inJson);
		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.POST, API_GATEWAY_SERVER+"/api/network/1.0"+"/lbaas/listeners", headers, contentType, payLoad);
		OpenStackJsonObject obj = JsonUtils.getJsonObject(output.getMessage());
		return obj.getListener();
	}

	@Override
	public Listener updateListener(Listener loadBalancerListener)
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		String loadBalancerListener_id = loadBalancerListener.getId();
		loadBalancerListener.setId(null);

		OpenStackJsonObject inJson = new OpenStackJsonObject();
		inJson.setListener(loadBalancerListener);

		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getProjectToken(projectName, super.cloudVo));
		String contentType = "application/json";
		String payLoad = JsonUtils.getJsonFormatString(inJson);
		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.PUT, API_GATEWAY_SERVER+"/api/network/1.0"+"/lbaas/listeners/"+loadBalancerListener_id, headers, contentType, payLoad);
		OpenStackJsonObject obj = JsonUtils.getJsonObject(output.getMessage());
		return obj.getListener();
	}

	@Override
	public boolean deleteListener(String loadBalancerListener_id)
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getProjectToken(projectName,super.cloudVo));
		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.DELETE, API_GATEWAY_SERVER+"/api/network/1.0"+"/lbaas/listeners/"+loadBalancerListener_id, headers, true);
		if (output.getStatusCode() == 204)
			return true;
		return false;
	}

	@Override
	public boolean isExist(String name)
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		List<Listener> listeners = getListeners();
		for (Listener listener : listeners) {
			if (listener.getName().equals(name))
				return true;
		}
		return false;
	}


}
