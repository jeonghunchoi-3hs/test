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
import com.ivucenter.cloud.api.openstack.interfaces.ProjectIF;
import com.ivucenter.cloud.api.openstack.object.OpenStackJsonObject;
import com.ivucenter.cloud.api.openstack.object.Project;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;

import lombok.AccessLevel;
import lombok.NoArgsConstructor;

@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class OpenStackProject extends OpenStackShared implements ProjectIF {
	
	private String API_IDENTITY_SERVER;
	
	public OpenStackProject(CustomOssCloudVO cloudVo) {
		super.cloudVo = cloudVo;
		this.API_IDENTITY_SERVER = cloudVo.getApiIdentityServer();
	}

	@Override
	public List<Project> getProjects() throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getAdminToken(super.cloudVo));
		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.GET, API_IDENTITY_SERVER+"/projects", headers);
		//log.debug(output.getMessage());
		OpenStackJsonObject obj = JsonUtils.getJsonObject(output.getMessage());
		return obj.getProjects();
	}

	@Override
	public Project createProject(Project project) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {

		OpenStackJsonObject inJson = new OpenStackJsonObject();
		inJson.setProject(project);

		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getAdminToken(super.cloudVo));
		String contentType = "application/json";
		String url = API_IDENTITY_SERVER+"/projects";
		String payLoad = JsonUtils.getJsonFormatString(inJson);
		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.POST, url, headers, contentType, payLoad);
		OpenStackJsonObject obj = JsonUtils.getJsonObject(output.getMessage());
		return obj.getProject();
	}

	@Override
	public Project getProject(String projectId) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getAdminToken(super.cloudVo));
		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.GET, API_IDENTITY_SERVER+"/projects/"+projectId, headers);
		OpenStackJsonObject obj = JsonUtils.getJsonObject(output.getMessage());
		return obj.getProject();
	}

	@Override
	public Project updateProject(Project project) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		String project_id = project.getId();
		project.setProject(null);

		OpenStackJsonObject inJson = new OpenStackJsonObject();
		inJson.getProject();

		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getAdminToken(super.cloudVo));
		String contentType = "application/json";
		String url = API_IDENTITY_SERVER+"/projects/"+project_id;
		String payLoad = JsonUtils.getJsonFormatString(inJson);
		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.PATCH, url, headers, contentType, payLoad);
		OpenStackJsonObject obj = JsonUtils.getJsonObject(output.getMessage());
		return obj.getProject();
	}

	@Override
	public boolean deleteProject(String project_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getAdminToken(this.cloudVo));
		String url = API_IDENTITY_SERVER+"/projects/"+project_id;
		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.DELETE, url, headers, true);
		if (output.getStatusCode() == 204)
			return true;
		return false;
	}


	@Override
	public List<Project> getUsersByProject(String user_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getAdminToken(super.cloudVo));
		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.GET, API_IDENTITY_SERVER + "/users/"+user_id+"/projects", headers);
		OpenStackJsonObject obj = JsonUtils.getJsonObject(output.getMessage());
		return obj.getProjects();
	}


	@Override
	public boolean isExist(String name) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		List<Project> projects = getProjects();
		for (Project project : projects) {
			if (project.getName().equals(name)) { return true; }
		}
		return false;
	}
}
