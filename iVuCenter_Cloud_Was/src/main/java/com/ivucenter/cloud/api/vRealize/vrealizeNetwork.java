package com.ivucenter.cloud.api.vRealize;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpMethod;

import com.ivucenter.cloud.api.common.utils.JsonUtils;
import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.api.vRealize.connector.vraRestConnector;
import com.ivucenter.cloud.api.vRealize.connector.vraRestResponse;
import com.ivucenter.cloud.api.vRealize.interfaces.vraNetworkIF;
import com.ivucenter.cloud.api.vRealize.object.vraComputeNetwork;
import com.ivucenter.cloud.api.vRealize.object.vraFabricNetworkVsphere;
import com.ivucenter.cloud.api.vRealize.object.vraFabricNetworks;
import com.ivucenter.cloud.api.vRealize.object.vraNetwork;
import com.ivucenter.cloud.api.vRealize.object.vraNetworkInterfaces;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;

public class vrealizeNetwork extends vrealizeShared implements vraNetworkIF{
	
	private String API_SERVER;
	
	// Constractors	
	public vrealizeNetwork(CustomOssCloudVO cloudVo) {
		super.cloudVo = cloudVo;
		this.API_SERVER = cloudVo.getApiGatewayServer();
	}

	@Override
	public List<vraNetwork> getNetworks()
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		
		Map<String, String> headers = new HashMap<String, String>();
		String contentType = "application/json";
		String url = API_SERVER+"/iaas/api/networks";
		String payLoad = "";
		vraRestResponse output = vraRestConnector.doRequest(HttpMethod.GET, url, headers, contentType, payLoad,getAdminToken(super.cloudVo));
		vraNetwork obj = JsonUtils.getVraNetworkJsonObject(output.getMessage());
		return obj.getContent();
	}

	@Override
	public vraNetworkInterfaces getNetworks(String machineId, String interfaceId)
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		
		Map<String, String> headers = new HashMap<String, String>();
		String contentType = "application/json";
		String url = API_SERVER+"/iaas/api/machines/"+machineId+"/network-interfaces/"+interfaceId;
		String payLoad = "";
		vraRestResponse output = vraRestConnector.doRequest(HttpMethod.GET, url, headers, contentType, payLoad,getAdminToken(super.cloudVo));
		vraNetworkInterfaces obj = JsonUtils.getVraNetworkInterfacesJsonObject(output.getMessage());
		return obj;
	}

	@Override
	public vraFabricNetworks getFabricNetworks()
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		String contentType = "application/json";
		String url = API_SERVER+"/iaas/api/fabric-networks";
		String payLoad = "";
		vraRestResponse output = vraRestConnector.doRequest(HttpMethod.GET, url, headers, contentType, payLoad,getAdminToken(super.cloudVo));
		vraFabricNetworks obj = JsonUtils.getVraFabricNetworksJsonObject(output.getMessage());
		return obj;
	}

	@Override
	public vraFabricNetworkVsphere getFabricNetworksVsphere()
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		String contentType = "application/json";
		String url = API_SERVER+"/iaas/api/fabric-networks-vsphere";
		String payLoad = "";
		vraRestResponse output = vraRestConnector.doRequest(HttpMethod.GET, url, headers, contentType, payLoad,getAdminToken(super.cloudVo));
		vraFabricNetworkVsphere obj = JsonUtils.getVraFabricNetworksVsphereJsonObject(output.getMessage());
		return obj;
	}

	@Override
	public vraComputeNetwork getComputeNetworks(String network)
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		
		vraComputeNetwork obj = null;
		
		String contentType = "application/json";
		String url = API_SERVER+network;
		String payLoad = "";
		vraRestResponse output = vraRestConnector.doRequest(HttpMethod.GET, url, headers, contentType, payLoad,getAdminToken(super.cloudVo));
		if(output !=  null) {
			
			 obj = JsonUtils.getVraComputeNetworkJsonObject(output.getMessage());
		}
		return obj;
	}
	
	
	
}
