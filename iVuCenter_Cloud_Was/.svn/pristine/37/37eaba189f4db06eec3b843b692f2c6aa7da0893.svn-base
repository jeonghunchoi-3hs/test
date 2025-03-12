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
import com.ivucenter.cloud.api.openstack.interfaces.FloatingipIF;
import com.ivucenter.cloud.api.openstack.object.Floatingip;
import com.ivucenter.cloud.api.openstack.object.OpenStackJsonObject;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;

import lombok.AccessLevel;
import lombok.NoArgsConstructor;

@NoArgsConstructor(access=AccessLevel.PROTECTED)
public class OpenStackFloatingip extends OpenStackShared implements FloatingipIF {

	private String projectName;
	private String API_GATEWAY_SERVER;

	public OpenStackFloatingip(String projectName,CustomOssCloudVO cloudVo) {
		this.projectName = projectName;
		super.cloudVo = cloudVo;
		this.API_GATEWAY_SERVER = cloudVo.getApiGatewayServer() +"/api/network/1.0";
	}

	@Override
	public List<Floatingip> getFloatingips() throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getProjectToken(projectName, super.cloudVo));

		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.GET, API_GATEWAY_SERVER + "/floatingips", headers);

		OpenStackJsonObject obj = JsonUtils.getJsonObject(output.getMessage());
		return obj.getFloatingips();
	}

	@Override
	public Floatingip getFloatingip(String floatingIP_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getProjectToken(projectName, super.cloudVo));
		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.GET, API_GATEWAY_SERVER+"/floatingips/"+floatingIP_id, headers);
		OpenStackJsonObject obj = JsonUtils.getJsonObject(output.getMessage());
		return obj.getFloatingip();
	}

	@Override
	public Floatingip createFloatingip(String name, boolean enabled, String description) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
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
	public Floatingip updateFloatingip(String network_id, String name, boolean enabled, String description) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
//		JsonObject param = new JsonObject();
//		JsonObject json = new JsonObject();
//		param.add("root", json);
//		JsonObject tenant = new JsonObject();
//		tenant.addProperty("id", tenent_id);
//		tenant.addProperty("description", description);
//		tenant.addProperty("enabled", enabled);
//		tenant.addProperty("name", name);
//		json.add("tenant", tenant);
//
//		Map<String, String> headers = new HashMap<String, String>();
//		headers.put("X-Auth-Token", getX_AUTH_TOKEN());
//		String contentType = "application/json";
//		String url = API_BASE+"/tenants/"+tenent_id;
//		String payLoad = json.toString();
//		RestResponse output = OpenStackRestConnector.doPost(url, headers, contentType, payLoad);
//		ReturnJsonObject obj = JsonUtils.getJsonObject(output.getMessage());
//		logger.debug(JsonUtils.getJsonFormatString(obj));
//		return obj.getTenant();
		return null;
	}

	@Override
	public boolean deleteFloatingip(String network_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
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
