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
import com.ivucenter.cloud.api.openstack.interfaces.ServerIF;
import com.ivucenter.cloud.api.openstack.object.OpenStackJsonObject;
import com.ivucenter.cloud.api.openstack.object.PortAttachment;
import com.ivucenter.cloud.api.openstack.object.Resize;
import com.ivucenter.cloud.api.openstack.object.Server;
import com.ivucenter.cloud.api.openstack.object.VolumeAttachment;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;

import lombok.AccessLevel;
import lombok.NoArgsConstructor;

@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class OpenStackServer extends OpenStackShared implements ServerIF {

	private String projectName;
	private String API_COMPUTE_SERVER;

	public OpenStackServer(String projectName,CustomOssCloudVO cloudVo) {
		this.projectName = projectName;
		super.cloudVo = cloudVo;
		this.API_COMPUTE_SERVER = cloudVo.getApiComputeServer();
	}

	@Override
	public List<Server> getAllServers(String filter) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getAdminToken(cloudVo));

//		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.GET, API_BASE + "/servers/detail"+filter,headers);
		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.GET, API_COMPUTE_SERVER + "/servers/detail?all_tenants=True"+filter, headers);

		OpenStackJsonObject obj = JsonUtils.getJsonObject(output.getMessage());
		return obj.getServers();
	}

	@Override
	public List<Server> getServers() throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getProjectToken(projectName,cloudVo));

		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.GET, API_COMPUTE_SERVER + "/servers/detail", headers);
		OpenStackJsonObject obj = JsonUtils.getJsonObject(output.getMessage());
		return obj.getServers();
	}

	@Override
	public Server getServer(String server_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getProjectToken(projectName,cloudVo));
		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.GET, API_COMPUTE_SERVER+"/servers/"+server_id, headers);

		OpenStackJsonObject obj = JsonUtils.getJsonObject(output.getMessage());
		return obj.getServer();
	}

	@Override
	public Server createServer(Server server) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		OpenStackJsonObject inJson = new OpenStackJsonObject();
		inJson.setServer(server);

		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getProjectToken(projectName,cloudVo));
		String contentType = "application/json";
		String url = API_COMPUTE_SERVER+"/servers";
		String payLoad = JsonUtils.getJsonFormatString(inJson);
		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.POST, url, headers, contentType, payLoad);
		OpenStackJsonObject obj = JsonUtils.getJsonObject(output.getMessage());
		return obj.getServer();
	}

	@Override
	public Server updateServer(Server server) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
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
//		String url = API_BASE+"/servers/"+server_id;
//		String payLoad = json.toString();
//		RestResponse output = OpenStackRestConnector.doPost(url, headers, contentType, payLoad);
//		ReturnJsonObject obj = JsonUtils.getJsonObject(output.getMessage());
//		logger.debug(JsonUtils.getJsonFormatString(obj));
//		return obj.getTenant();
		return null;
	}

	@Override
	public boolean deleteServer(String server_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getProjectToken(projectName,cloudVo));
		String url = API_COMPUTE_SERVER+"/servers/"+server_id;
		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.DELETE, url, headers, true);
		if (output.getStatusCode() == 204)
			return true;
		return false;
	}

	@Override
	public boolean isExist(String name) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		List<Server> servers = getServers();
		for (Server server : servers) {
			if (server.getName().equals(name))
				return true;
		}
		return false;
	}

	@Override
	public List<VolumeAttachment> getVolumeAttachments(String server_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getProjectToken(projectName,cloudVo));

		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.GET, API_COMPUTE_SERVER + "/servers/"+server_id+"/os-volume_attachments", headers);

		OpenStackJsonObject obj = JsonUtils.getJsonObject(output.getMessage());
		return obj.getVolumeAttachments();
	}

	@Override
	public VolumeAttachment attachVolumeAttachments(String server_id, String volume_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getProjectToken(projectName,cloudVo));
		String contentType = "application/json";
		String payLoad = "{ \"volumeAttachment\" : {  \"volumeId\": \""+volume_id+"\"  } }";

		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.POST, API_COMPUTE_SERVER + "/servers/"+server_id+"/os-volume_attachments", headers, contentType, payLoad, true,null);

		OpenStackJsonObject obj = JsonUtils.getJsonObject(output.getMessage());
		return obj.getVolumeAttachment();
	}

	@Override
	public boolean detachVolumeAttachments(String server_id, String volume_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getProjectToken(projectName,cloudVo));
		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.DELETE, API_COMPUTE_SERVER + "/servers/"+server_id+"/os-volume_attachments/"+volume_id, headers, true);
		if (output.getStatusCode() == 202)
			return true;
		return false;
	}

	@Override
	public boolean actionServer(String server_id, String action) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getProjectToken(projectName,cloudVo));
		String contentType = "application/json";
		String url = API_COMPUTE_SERVER+"/servers/"+server_id+"/action";
		String payLoad = null;
		if (action.equalsIgnoreCase("stop")) payLoad = "{ \"os-stop\" : null }";
		else if (action.equalsIgnoreCase("start")) payLoad = "{ \"os-start\" : null }";
		else if (action.equalsIgnoreCase("reboot")) payLoad = "{ \"reboot\" : { \"type\" : \"HARD\" }}";
		else if (action.equalsIgnoreCase("confirmResize")) payLoad = "{ \"confirmResize\" : null }";
		else if (action.equalsIgnoreCase("revertResize")) payLoad = "{ \"revertResize\" : null }";
		else if (action.equalsIgnoreCase("forceDelete")) payLoad = "{ \"forceDelete\" : null }";

		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.POST, url, headers, contentType, payLoad, true,null);
		if (output.getStatusCode() == 202) {
			return true;
		}
		return false;
	}

	@Override
	public boolean resizeServer(Resize resize) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {

		OpenStackJsonObject inJson = new OpenStackJsonObject();
		inJson.setResize(resize);

		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getProjectToken(projectName,cloudVo));
		String contentType = "application/json";
		String url = API_COMPUTE_SERVER+"/servers/"+resize.getServer_id()+"/action";
		String payLoad = JsonUtils.getJsonFormatString(inJson);

		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.POST, url, headers, contentType, payLoad);
		if (output.getStatusCode() == 202) {
			return true;
		}
		return false;
	}

	@Override
	public PortAttachment attachPortAttachment(String server_id, String port_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getProjectToken(projectName,cloudVo));
		String contentType = "application/json";
		String payLoad = "{ \"interfaceAttachment\" : {  \"port_id\": \""+port_id+"\"  } }";

		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.POST, API_COMPUTE_SERVER + "/servers/"+server_id+"/os-interface", headers, contentType, payLoad, true,null);

		OpenStackJsonObject obj = JsonUtils.getJsonObject(output.getMessage());
		return obj.getPortAttachment();
	}

	@Override
	public boolean detachPortAttachment(String server_id, String port_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getProjectToken(projectName,cloudVo));
		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.DELETE, API_COMPUTE_SERVER + "/servers/"+server_id+"/os-interface/"+port_id, headers, true);
		if (output.getStatusCode() == 202)
			return true;
		return false;
	}
}
