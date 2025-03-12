package com.ivucenter.cloud.api.openstack;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpMethod;

import com.ivucenter.cloud.api.common.utils.JsonUtils;
import com.ivucenter.cloud.api.openstack.connector.OpenStackRestConnector;
import com.ivucenter.cloud.api.openstack.connector.RestResponse;
import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.api.openstack.interfaces.IdentityIF;
import com.ivucenter.cloud.api.openstack.object.OpenStackJsonObject;
import com.ivucenter.cloud.api.openstack.object.RequestAuth;
import com.ivucenter.cloud.api.openstack.object.Token;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;

import lombok.AccessLevel;
import lombok.NoArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class OpenStackIdentity extends OpenStackShared implements IdentityIF {
	
	private String API_IDENTITY_SERVER;
	// Constractors	
	public OpenStackIdentity(CustomOssCloudVO cloudVo) {
		super.cloudVo = cloudVo;
		this.API_IDENTITY_SERVER = cloudVo.getApiIdentityServer();
	}
	
	@Override
	public Token getToken(String project, String username, String password) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		
		RequestAuth auth = new RequestAuth(project, username, password);
		OpenStackJsonObject inJson = new OpenStackJsonObject();
		inJson.setAuth(auth);
		
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("Accept", "application/json");
		String contentType = "application/json";
		String payLoad = JsonUtils.getJsonFormatString(inJson);
		
		log.debug(JsonUtils.getJsonFormatString(payLoad));
		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.POST, API_IDENTITY_SERVER +"/auth/tokens", headers, contentType, payLoad);
		OpenStackJsonObject obj = JsonUtils.getJsonObject(output.getMessage());
		log.debug(JsonUtils.getJsonFormatString(obj));
		Token token = obj.getToken();
		token.setSubjectToken(output.getSubjectToken());
		return token;
		
	}

}
