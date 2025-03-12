package com.ivucenter.cloud.api.vRealize;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpMethod;

import com.ivucenter.cloud.api.common.utils.JsonUtils;
import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.api.vRealize.connector.vraRestConnector;
import com.ivucenter.cloud.api.vRealize.connector.vraRestResponse;
import com.ivucenter.cloud.api.vRealize.interfaces.vraProjectIF;
import com.ivucenter.cloud.api.vRealize.object.vraEntitlementsObject;
import com.ivucenter.cloud.api.vRealize.object.vraJsonObject;
import com.ivucenter.cloud.api.vRealize.object.vraProjectObject;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;

public class vrealizeProject extends vrealizeShared implements vraProjectIF{
	private String API_SERVER;
	
	public vrealizeProject(CustomOssCloudVO cloudVo) {
		super.cloudVo = cloudVo;
		this.API_SERVER = cloudVo.getApiGatewayServer();
	}

	@Override
	public vraProjectObject createProject(vraProjectObject project) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {

		vraProjectObject inJson = project;


		Map<String, String> headers = new HashMap<String, String>();

		String contentType = "application/json";
		String url = API_SERVER+"/iaas/api/projects";
		String payLoad = JsonUtils.getJsonFormatString(inJson);
		vraRestResponse output = vraRestConnector.doRequest(HttpMethod.POST, url, headers, contentType, payLoad,getAdminToken(super.cloudVo));
		vraJsonObject obj = JsonUtils.vraGetJsonObject(output.getMessage());
		project.setId(obj.getId());
		return project; 
	}

	@Override
	public vraJsonObject setEntitlements(vraEntitlementsObject entitlementsObject)
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		
		vraEntitlementsObject inJson = entitlementsObject;
		Map<String, String> headers = new HashMap<String, String>();

		String contentType = "application/json";
		String url = API_SERVER+"/catalog/api/admin/entitlements";
		String payLoad = JsonUtils.getJsonFormatString(inJson);
		vraRestResponse output = vraRestConnector.doRequest(HttpMethod.POST, url, headers, contentType, payLoad,getAdminToken(super.cloudVo));
		vraJsonObject obj = JsonUtils.vraGetJsonObject(output.getMessage());

		return obj;
	}

	@Override
	public vraProjectObject getProjects()
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();

		String contentType = "application/json";
		String url = API_SERVER+"/iaas/api/projects";
		String payLoad = "";
		vraRestResponse output = vraRestConnector.doRequest(HttpMethod.GET, url, headers, contentType, payLoad,getAdminToken(super.cloudVo));
		vraProjectObject obj = JsonUtils.getJsonVraProjectsObject(output.getMessage());
		return obj;
	}
	
	@Override
	public vraProjectObject getProject(String projectId)
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();

		String contentType = "application/json";
		String url = API_SERVER+"/iaas/api/projects/"+projectId;
		String payLoad = "";
		vraRestResponse output = vraRestConnector.doRequest(HttpMethod.GET, url, headers, contentType, payLoad,getAdminToken(super.cloudVo));
		vraProjectObject obj = JsonUtils.getJsonVraProjectsObject(output.getMessage());
		return obj;
	}
	
	@Override
	public vraProjectObject updateQuota(vraProjectObject project,String projectId) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {

		vraProjectObject inJson = project;


		Map<String, String> headers = new HashMap<String, String>();

		String contentType = "application/json";
		String url = API_SERVER+"/iaas/api/projects/"+projectId;
		String payLoad = JsonUtils.getJsonFormatString(inJson);
		vraRestResponse output = vraRestConnector.doRequest(HttpMethod.PATCH, url, headers, contentType, payLoad,getAdminToken(super.cloudVo));
		vraJsonObject obj = JsonUtils.vraGetJsonObject(output.getMessage());
		project.setId(obj.getId());
		return project; 
	}

}
