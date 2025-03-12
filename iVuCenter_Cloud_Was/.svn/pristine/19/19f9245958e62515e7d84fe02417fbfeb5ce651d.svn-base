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
import com.ivucenter.cloud.api.openstack.interfaces.PortIF;
import com.ivucenter.cloud.api.openstack.object.OpenStackJsonObject;
import com.ivucenter.cloud.api.openstack.object.Port;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;

import lombok.AccessLevel;
import lombok.NoArgsConstructor;

@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class OpenStackPort extends OpenStackShared implements PortIF {

	private String API_NETWORK_SERVER;

	public OpenStackPort(CustomOssCloudVO cloudVo) {
		super.cloudVo = cloudVo;
		this.API_NETWORK_SERVER = cloudVo.getApiNetworkServer();
	}

	@Override
	public List<Port> getPorts() throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getAdminToken(super.cloudVo));

		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.GET, API_NETWORK_SERVER + "/ports", headers);

		OpenStackJsonObject obj = JsonUtils.getJsonObject(output.getMessage());
		return obj.getPorts();
	}

	@Override
	public Port getPort(String port_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getAdminToken(super.cloudVo));
		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.GET, API_NETWORK_SERVER+"/ports/"+port_id, headers);
		OpenStackJsonObject obj = JsonUtils.getJsonObject(output.getMessage());
		return obj.getPort();
	}

	@Override
	public Port createPort(Port port) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		OpenStackJsonObject inJson = new OpenStackJsonObject();
		inJson.setPort(port);

		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getAdminToken(super.cloudVo));
		String contentType = "application/json";
		String payLoad = JsonUtils.getJsonFormatString(inJson);

		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.POST, API_NETWORK_SERVER + "/ports" , headers, contentType, payLoad);
		OpenStackJsonObject obj = JsonUtils.getJsonObject(output.getMessage());
		return obj.getPort();
	}

	@Override
	public Boolean deletePort(Port port) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getAdminToken(super.cloudVo));
		String url = API_NETWORK_SERVER + "/ports/" + port.getId();
		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.DELETE, url, headers, true);
		if (output.getStatusCode() == 204)
			return true;
		return false;
	}

}
