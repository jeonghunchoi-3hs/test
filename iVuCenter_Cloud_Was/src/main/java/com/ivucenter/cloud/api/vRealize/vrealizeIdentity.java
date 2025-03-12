package com.ivucenter.cloud.api.vRealize;

import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpMethod;

import com.ivucenter.cloud.api.common.utils.JsonUtils;
import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.api.vRealize.connector.vraRestConnector;
import com.ivucenter.cloud.api.vRealize.connector.vraRestResponse;
import com.ivucenter.cloud.api.vRealize.interfaces.vraIdentityIF;
import com.ivucenter.cloud.api.vRealize.object.vraJsonObject;
import com.ivucenter.cloud.api.vRealize.object.vraTokenJsonObject;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;

import lombok.AccessLevel;
import lombok.NoArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class vrealizeIdentity extends vrealizeShared implements vraIdentityIF{
	private String VRA_USER_NAME;
	private String VRA_USER_PASSWORD;
	private String VRA_DOMAIN;
	private String API_SERVER;
	
	// Constractors	
	public vrealizeIdentity(CustomOssCloudVO cloudVo) {
		super.cloudVo = cloudVo;
		this.VRA_DOMAIN = cloudVo.getAdminDomain();;
		this.API_SERVER = cloudVo.getApiGatewayServer();
		this.VRA_USER_NAME = cloudVo.getAdminUsername();
		this.VRA_USER_PASSWORD = cloudVo.getAdminPassword();
	}

	@Override
	public vraTokenJsonObject getToken(CustomOssCloudVO cloudVO)
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("Accept", "application/json");
		String contentType = "application/json";
		
		vraJsonObject inJson = new vraJsonObject();
		inJson.setDomain(VRA_DOMAIN);
		inJson.setUsername(VRA_USER_NAME);
		inJson.setPassword(VRA_USER_PASSWORD);
		
		String payLoad = JsonUtils.getJsonFormatString(inJson);
		vraRestResponse output = vraRestConnector.doRequest(HttpMethod.POST, API_SERVER +"/csp/gateway/am/api/login?access_token",headers, contentType, payLoad);
		vraTokenJsonObject obj = JsonUtils.getJsonObjectVra(output.getMessage());
		
		vraJsonObject inJson2 = new vraJsonObject();
		inJson2.setRefreshToken(obj.getRefreshToken());
		String payLoad2 = JsonUtils.getJsonFormatString(inJson2);
		vraRestResponse output2 = vraRestConnector.doRequest(HttpMethod.POST, API_SERVER +"/iaas/api/login",headers, contentType, payLoad2);
		vraTokenJsonObject obj2 = JsonUtils.getJsonObjectVra(output2.getMessage());
		obj.setToken(obj2.getToken());
		Calendar calendar = Calendar.getInstance(); // gets a calendar using the default time zone and locale.
		int expire = Integer.parseInt(obj.getExpiresIn());
		long nowDate = System.currentTimeMillis() / 1000 + expire;
		obj.setExpiresIn(Long.toString(nowDate * 1000));

		return obj;
	}

}
