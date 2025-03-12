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
import com.ivucenter.cloud.api.vRealize.interfaces.vraCatalogIF;
import com.ivucenter.cloud.api.vRealize.object.vraCatalogObject;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;

public class vrealizeCatalogue extends vrealizeShared implements vraCatalogIF{
	private String VRA_USER_NAME;
	private String VRA_USER_PASSWORD;
	private String VRA_DOMAIN;
	private String API_SERVER;
	
	// Constractors	
	public vrealizeCatalogue(CustomOssCloudVO cloudVo) {
		super.cloudVo = cloudVo;
		this.VRA_DOMAIN = cloudVo.getAdminDomain();;
		this.API_SERVER = cloudVo.getApiGatewayServer();
		this.VRA_USER_NAME = cloudVo.getAdminUsername();
		this.VRA_USER_PASSWORD = cloudVo.getAdminPassword();
	}

	@Override
	public vraCatalogObject vraGetCatalogue()
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		String contentType = "application/json";
		String url = API_SERVER+"/catalog/api/items";
		String payLoad = "";
		vraRestResponse output = vraRestConnector.doRequest(HttpMethod.GET, url, headers, contentType, payLoad,getAdminToken(super.cloudVo));
		vraCatalogObject obj = JsonUtils.vraGetCatalogObject(output.getMessage());
		return obj; 
	}
}
