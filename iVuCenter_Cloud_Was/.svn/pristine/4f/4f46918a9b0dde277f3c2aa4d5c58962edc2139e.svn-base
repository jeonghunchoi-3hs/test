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
import com.ivucenter.cloud.api.openstack.interfaces.RouterIF;
import com.ivucenter.cloud.api.openstack.object.OpenStackJsonObject;
import com.ivucenter.cloud.api.openstack.object.Router;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;

import lombok.AccessLevel;
import lombok.NoArgsConstructor;

@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class OpenStackRouter extends OpenStackShared implements RouterIF {

	private String projectName;
	private String API_NETWORK_SERVER;

	public OpenStackRouter(String projectName,CustomOssCloudVO cloudVo) {
		this.projectName = projectName;
		super.cloudVo = cloudVo;
		this.API_NETWORK_SERVER = cloudVo.getApiNetworkServer();
	}

	@Override
	public List<Router> getRouters() throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getProjectToken(projectName,cloudVo));

		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.GET, API_NETWORK_SERVER + "/routers", headers);

		OpenStackJsonObject obj = JsonUtils.getJsonObject(output.getMessage());
		return obj.getRouters();
	}

	@Override
	public Router getRouter(String router_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getProjectToken(projectName,cloudVo));
		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.GET, API_NETWORK_SERVER+"/routers/"+router_id, headers);
		OpenStackJsonObject obj = JsonUtils.getJsonObject(output.getMessage());
		return obj.getRouter();
	}

	@Override
	public Router createRouter(Router router) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		OpenStackJsonObject inJson = new OpenStackJsonObject();
		inJson.setRouter(router);

		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getProjectToken(projectName,cloudVo));

		String contentType = "application/json";
		String payLoad = JsonUtils.getJsonFormatString(inJson);
		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.POST, API_NETWORK_SERVER+"/routers", headers, contentType, payLoad);
		OpenStackJsonObject obj = JsonUtils.getJsonObject(output.getMessage());
		return obj.getRouter();
	}

	@Override
	public Router updateRouter(Router router) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getProjectToken(projectName,cloudVo));

		String router_id = router.getId();
		OpenStackJsonObject inJson = new OpenStackJsonObject();
		inJson.setRouter(router);
		router.setId(null);

		String contentType = "application/json";
		String payLoad = JsonUtils.getJsonFormatString(inJson);
		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.PUT, API_NETWORK_SERVER+"/routers/"+router_id, headers, contentType, payLoad);
		OpenStackJsonObject obj = JsonUtils.getJsonObject(output.getMessage());
		return obj.getRouter();
	}

	@Override
	public boolean deleteRouter(String router_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getProjectToken(projectName,cloudVo));

		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.DELETE, API_NETWORK_SERVER+"/routers/"+router_id, headers, true);
		if (output.getStatusCode() == 204)
			return true;
		return false;
	}

	@Override
	public boolean isExist(String name) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		List<Router> routers = getRouters();
		for (Router router : routers) {
			if (router.getName().equals(name))
				return true;
		}
		return false;
	}

	@Override
	public boolean addRouterInterfaceSubnet(String router_id, String subnet_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		String payLoad = "{ \"subnet_id\": \""+subnet_id+"\" }";
		return addRouterInterface(router_id, payLoad);
	}

	@Override
	public boolean addRouterInterfacePort(String router_id, String port_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		String payLoad = "{ \"subnet_id\": \""+port_id+"\" }";
		return addRouterInterface(router_id, payLoad);
	}

	private boolean addRouterInterface(String router_id, String payLoad) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getProjectToken(projectName, super.cloudVo));

		String contentType = "application/json";
		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.PUT, API_NETWORK_SERVER+"/routers/"+router_id+"/add_router_interface", headers, contentType, payLoad);
		if (output.getStatusCode() < 300) return true;
		return false;
	}

	@Override
	public boolean removeRouterInterfaceSubnet(String router_id, String subnet_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		String payLoad = "{ \"subnet_id\": \""+subnet_id+"\" }";
		return removeRouterInterface(router_id, payLoad);
	}

	@Override
	public boolean removeRouterInterfacePort(String router_id, String port_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		String payLoad = "{ \"subnet_id\": \""+port_id+"\" }";
		return removeRouterInterface(router_id, payLoad);
	}

	private boolean removeRouterInterface(String router_id, String payLoad) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getProjectToken(projectName,super.cloudVo));

		String contentType = "application/json";
		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.PUT, API_NETWORK_SERVER+"/routers/"+router_id+"/remove_router_interface", headers, contentType, payLoad);
		if (output.getStatusCode() < 300) return true;
		return false;
	}

}
