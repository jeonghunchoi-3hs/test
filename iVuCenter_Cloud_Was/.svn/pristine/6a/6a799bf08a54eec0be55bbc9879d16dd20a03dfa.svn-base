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
import com.ivucenter.cloud.api.vRealize.interfaces.vraFlavorIF;
import com.ivucenter.cloud.api.vRealize.object.vraFlavor;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;

public class vrealizeFlavor extends vrealizeShared implements vraFlavorIF{
	private String API_SERVER;
	
	public vrealizeFlavor(CustomOssCloudVO cloudVo) {
		super.cloudVo = cloudVo;
		this.API_SERVER = cloudVo.getApiGatewayServer();
	}

	@Override
	public vraFlavor getFlavors()
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		String contentType = "application/json";
		String url = API_SERVER+"/iaas/api/flavors";
		String payLoad = "";
		vraRestResponse output = vraRestConnector.doRequest(HttpMethod.GET, url, headers, contentType, payLoad,getAdminToken(super.cloudVo));
		vraFlavor obj = JsonUtils.vraGetFlavorObject(output.getMessage());
		return obj; 
	}

}
