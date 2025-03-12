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
import com.ivucenter.cloud.api.openstack.interfaces.NetworkIF;
import com.ivucenter.cloud.api.openstack.object.Network;
import com.ivucenter.cloud.api.openstack.object.OpenStackJsonObject;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;

import lombok.AccessLevel;
import lombok.NoArgsConstructor;

@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class OpenStackNetwork extends OpenStackShared implements NetworkIF {

	private String projectName;
	private  String API_NETWORK_SERVER;

	public OpenStackNetwork(String projectName,CustomOssCloudVO cloudVo) {
		this.projectName = projectName;
		this.API_NETWORK_SERVER = cloudVo.getApiNetworkServer();
		super.cloudVo = cloudVo;
	}

	@Override
	public List<Network> getNetworks() throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getProjectToken(projectName,super.cloudVo));
		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.GET, API_NETWORK_SERVER + "/networks", headers);

		OpenStackJsonObject obj = JsonUtils.getJsonObject(output.getMessage());
		return obj.getNetworks();
	}

	@Override
	public Network getNetwork(String network_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getProjectToken(projectName,super.cloudVo));
		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.GET, API_NETWORK_SERVER+"/networks/"+network_id, headers);

		OpenStackJsonObject obj = JsonUtils.getJsonObject(output.getMessage());

		return obj.getNetwork();
	}

	@Override
	public Network createNetwork(Network network) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		OpenStackJsonObject inJson = new OpenStackJsonObject();
		inJson.setNetwork(network);

		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getProjectToken(projectName,this.cloudVo));
		// 네트워크 생성시 공유체크 부분
//		headers.put("X-Auth-Token", getAdminToken());
		String contentType = "application/json";
		String url = API_NETWORK_SERVER+"/networks";
		String payLoad = JsonUtils.getJsonFormatString(inJson);
		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.POST, url, headers, contentType, payLoad);
		OpenStackJsonObject obj = JsonUtils.getJsonObject(output.getMessage());
		return obj.getNetwork();
	}

	@Override
	public Network updateNetwork(Network network) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		String network_id = network.getId();
		network.setId(null);

		OpenStackJsonObject inJson = new OpenStackJsonObject();
		inJson.setNetwork(network);

		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getProjectToken(projectName,super.cloudVo));
		String contentType = "application/json";
		String url = API_NETWORK_SERVER+"/networks/"+network_id;
		String payLoad = JsonUtils.getJsonFormatString(inJson);
		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.PUT, url, headers, contentType, payLoad);
		OpenStackJsonObject obj = JsonUtils.getJsonObject(output.getMessage());
		return obj.getNetwork();
	}

	@Override
	public boolean deleteNetwork(String network_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getProjectToken(projectName,super.cloudVo));
		String url = API_NETWORK_SERVER+"/networks/"+network_id;
		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.DELETE, url, headers, true);
		if (output.getStatusCode() == 204)
			return true;
		return false;
	}

	@Override
	public boolean isExist(String name) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		return false;
	}

}
