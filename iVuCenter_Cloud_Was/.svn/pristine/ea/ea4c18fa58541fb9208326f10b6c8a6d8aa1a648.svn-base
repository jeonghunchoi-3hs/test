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
import com.ivucenter.cloud.api.vRealize.interfaces.vraServerIF;
import com.ivucenter.cloud.api.vRealize.object.vraJsonObject;
import com.ivucenter.cloud.api.vRealize.object.vraMachine;
import com.ivucenter.cloud.api.vRealize.object.vraServer;
import com.ivucenter.cloud.api.vRealize.object.vraServerObject;
import com.ivucenter.cloud.api.vRealize.object.vraServerRequest;
import com.ivucenter.cloud.api.vRealize.object.vraZone;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;

public class vrealizeServer extends vrealizeShared implements vraServerIF{

	private String API_SERVER;
	
	public vrealizeServer(CustomOssCloudVO cloudVo) {
		super.cloudVo = cloudVo;
		this.API_SERVER = cloudVo.getApiGatewayServer();
	}

		
	@Override
	public vraRestResponse createServer(vraServerObject VraServerObject,String catalogId)
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		
		vraServerObject inJson = VraServerObject;
		Map<String, String> headers = new HashMap<String, String>();

		String contentType = "application/json";
		String url = API_SERVER+"/catalog/api/items/" + catalogId + "/request";
		String payLoad = JsonUtils.alwaysJsonFormatString(inJson);
		vraRestResponse output = vraRestConnector.doRequest(HttpMethod.POST, url, headers, contentType, payLoad,getAdminToken(super.cloudVo));
		return output;
	}


	@Override
	public vraServer getServer(String depId)
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();

		String contentType = "application/json";
		String url = API_SERVER+"/deployment/api/deployments/" + depId;
		String payLoad = "";
		vraRestResponse output = vraRestConnector.doRequest(HttpMethod.GET, url, headers, contentType, payLoad,getAdminToken(super.cloudVo));
		vraServer server = JsonUtils.getJsonVraServerObject(output.getMessage());

		return server;
	}


	@Override
	public vraServer getDepInfo(String depId)
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();

		String contentType = "application/json";
		String url = API_SERVER+"/deployment/api/deployments/" + depId + "/resources";
		String payLoad = "";
		vraRestResponse output = vraRestConnector.doRequest(HttpMethod.GET, url, headers, contentType, payLoad,getAdminToken(super.cloudVo));
		vraServer server = JsonUtils.getJsonVraServerObject(output.getMessage());

		return server;
	}


	@Override
	public vraJsonObject actionServer(String vmUuid, String action)
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		String contentType = "application/json";
		String url = "";
		String payLoad = "";
		if(action.equals("stop")) {
			url = API_SERVER+"/iaas/api/machines/"+vmUuid+"/operations/power-off";
		} else if (action.equals("reset")){
			url = API_SERVER+"/iaas/api/machines/"+vmUuid+"/operations/restart";
		}	else {
			url = API_SERVER+"/iaas/api/machines/"+vmUuid+"/operations/power-on";
		}
		vraRestResponse output = vraRestConnector.doRequest(HttpMethod.POST, url, headers, contentType, payLoad,getAdminToken(super.cloudVo));
		vraJsonObject vraJsonObject = JsonUtils.vraGetJsonObject(output.getMessage());
		return vraJsonObject;
	}
	
	@Override
	public vraJsonObject tracker(String trackerId)
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		
		Map<String, String> headers = new HashMap<String, String>();

		String contentType = "application/json";
		String url = API_SERVER+"/iaas/api/request-tracker/"+trackerId;
		String payLoad = "";
		vraRestResponse output = vraRestConnector.doRequest(HttpMethod.GET, url, headers, contentType, payLoad,getAdminToken(super.cloudVo));
		vraJsonObject res = JsonUtils.vraGetJsonObject(output.getMessage());
		
		return res;
	}


	@Override
	public vraMachine getMachine(String machineId)
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		String contentType = "application/json";
		String url = API_SERVER+"/iaas/api/machines/"+machineId;
		String payLoad = "";
		vraRestResponse output = vraRestConnector.doRequest(HttpMethod.GET, url, headers, contentType, payLoad,getAdminToken(super.cloudVo));
		vraMachine res = JsonUtils.getJsonVraMachineObject(output.getMessage());
		return res;
	}


	@Override
	public vraJsonObject changeMachine(String machineId,String flavorId)
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		String contentType = "application/json";
		String url = API_SERVER+"/iaas/api/machines/"+machineId+"/operations/resize?name="+flavorId;
		String payLoad = "";
		vraRestResponse output = vraRestConnector.doRequest(HttpMethod.POST, url, headers, contentType, payLoad,getAdminToken(super.cloudVo));
		vraJsonObject res = JsonUtils.vraGetJsonObject(output.getMessage());
		
		return res;
	}


	@Override
	public vraJsonObject detachDisk(String machineId, String diskId)
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		String contentType = "application/json";
		String url = API_SERVER+"/iaas/api/machines/"+machineId+"/disks/"+diskId;
		String payLoad = "";
		vraRestResponse output = vraRestConnector.doRequest(HttpMethod.DELETE, url, headers, contentType, payLoad,getAdminToken(super.cloudVo));
		vraJsonObject res = JsonUtils.vraGetJsonObject(output.getMessage());
		
		return res;
	}


	@Override
	public vraJsonObject deleteVm(String vmUuid)
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		String contentType = "application/json";
		String url = API_SERVER+"/deployment/api/deployments/"+vmUuid;
		String payLoad = "";
		vraRestResponse output = vraRestConnector.doRequest(HttpMethod.DELETE, url, headers, contentType, payLoad,getAdminToken(super.cloudVo));
		vraJsonObject res = JsonUtils.vraGetJsonObject(output.getMessage());
		return res;
	}


	@Override
	public vraServer getServers(String projectId)
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();

		String contentType = "application/json";
		String url = API_SERVER+"/deployment/api/deployments";
		if(!projectId.equals("")) {
			url += "?projects=" + projectId;
		}
		String payLoad = "";
		vraRestResponse output = vraRestConnector.doRequest(HttpMethod.GET, url, headers, contentType, payLoad,getAdminToken(super.cloudVo));
		vraServer server = JsonUtils.getJsonVraServerObject(output.getMessage());

		return server;
	}


	@Override
	public vraMachine getMachines()
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		String contentType = "application/json";
		String url = API_SERVER+"/iaas/api/machines";
		String payLoad = "";
		vraRestResponse output = vraRestConnector.doRequest(HttpMethod.GET, url, headers, contentType, payLoad,getAdminToken(super.cloudVo));
		vraMachine res = JsonUtils.getJsonVraMachineObject(output.getMessage());
		return res;
	}


	@Override
	public vraServerRequest getServerRequest(String depId,String requestId)
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();

		String contentType = "application/json";
		String url = API_SERVER+"/deployment/api/deployments/" + depId+"/requests";
		if(!requestId.equals("")) {
			url += "/"+requestId;
		}
		String payLoad = "";
		vraRestResponse output = vraRestConnector.doRequest(HttpMethod.GET, url, headers, contentType, payLoad,getAdminToken(super.cloudVo));
		vraServerRequest server = JsonUtils.getJsonVraServerRequestObject(output.getMessage());

		return server;
	}


	@Override
	public vraServer deleteServer()
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();

		String contentType = "application/json";
		String url = API_SERVER+"/deployment/api/deployments?deleted=true";
		String payLoad = "";
		vraRestResponse output = vraRestConnector.doRequest(HttpMethod.GET, url, headers, contentType, payLoad,getAdminToken(super.cloudVo));
		vraServer server = JsonUtils.getJsonVraServerObject(output.getMessage());

		return server;
	}


	@Override
	public vraZone getZones() throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();

		String contentType = "application/json";
		String url = API_SERVER+"/iaas/api/zones";
		String payLoad = "";
		vraRestResponse output = vraRestConnector.doRequest(HttpMethod.GET, url, headers, contentType, payLoad,getAdminToken(super.cloudVo));
		vraZone server = JsonUtils.getJsonVraZoneObject(output.getMessage());

		return server;
	}

}
