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
import com.ivucenter.cloud.api.openstack.interfaces.NetworkQuotaIF;
import com.ivucenter.cloud.api.openstack.object.NetworkQuota;
import com.ivucenter.cloud.api.openstack.object.OpenStackJsonObject;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;

import lombok.AccessLevel;
import lombok.NoArgsConstructor;

@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class OpenStackNetworkQuota extends OpenStackShared implements NetworkQuotaIF {

	private String API_NETWORK_SERVER;

	public OpenStackNetworkQuota(CustomOssCloudVO cloudVo) {
		super.cloudVo = cloudVo;
		this.API_NETWORK_SERVER = cloudVo.getApiNetworkServer();
	}

	@Override
	public List<NetworkQuota> getNetworkQuotas() throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getAdminToken(super.cloudVo));

		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.GET, API_NETWORK_SERVER + "/quotas", headers);

		OpenStackJsonObject obj = JsonUtils.getJsonObject(output.getMessage());
		return obj.getQuotas();
	}

	@Override
	public NetworkQuota getNetworkQuota(String project_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getAdminToken(super.cloudVo));
		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.GET, API_NETWORK_SERVER+"/quotas/"+project_id, headers);
		OpenStackJsonObject obj = JsonUtils.getJsonObject(output.getMessage());
		return obj.getQuota();
	}

	@Override
	public NetworkQuota createNetworkQuota(String name, boolean enabled, String description) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
//		JsonObject param = new JsonObject();
//		JsonObject json = new JsonObject();
//		param.add("root", json);
//		JsonObject tenant = new JsonObject();
//		tenant.addProperty("description", description);
//		tenant.addProperty("enabled", enabled);
//		tenant.addProperty("name", name);
//		json.add("tenant", tenant);
//
//		Map<String, String> headers = new HashMap<String, String>();
//		headers.put("X-Auth-Token", getX_AUTH_TOKEN());
//		String contentType = "application/json";
//		String url = API_BASE+"/tenants";
//		String payLoad = json.toString();
//		RestResponse output = OpenStackRestConnector.doPost(url, headers, contentType, payLoad);
//		ReturnJsonObject obj = JsonUtils.getJsonObject(output.getMessage());
//		logger.debug(JsonUtils.getJsonFormatString(obj));
//		return obj.getTenant();
		return null;
	}

	@Override
	public NetworkQuota updateNetworkQuota(String project_id, NetworkQuota networkQuota) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		OpenStackJsonObject inJson = new OpenStackJsonObject();
		inJson.setQuota(networkQuota);

		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getAdminToken(super.cloudVo));
		String contentType = "application/json";
		String payLoad = JsonUtils.getJsonFormatString(inJson);
		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.PUT, API_NETWORK_SERVER+"/quotas/"+project_id, headers, contentType, payLoad);
		OpenStackJsonObject obj = JsonUtils.getJsonObject(output.getMessage());
		return obj.getQuota();
	}

	@Override
	public boolean deleteNetworkQuota(String network_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
//		Map<String, String> headers = new HashMap<String, String>();
//		headers.put("X-Auth-Token", getX_AUTH_TOKEN());
//		String url = API_BASE+"/tenants/"+tenent_id;
//		RestResponse output = OpenStackRestConnector.doDelete(url, headers);
//		if (output.getStatusCode() == 204)
//			return true;
		return false;
	}

	@Override
	public boolean isExist(String name) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
//		ProjectIF projectIF = AbstractFactory.getProject();
//		List<Project> projects = projectIF.getProjects();
//		for (Project project : projects) {
//			if (project.getName().equals(name))
//				return true;
//		}
		return false;
	}


}
