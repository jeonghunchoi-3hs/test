package com.ivucenter.cloud.api.vmware;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpMethod;

import com.ivucenter.cloud.api.VmwareIdentityIF;
import com.ivucenter.cloud.api.common.utils.JsonUtils;
import com.ivucenter.cloud.api.openstack.OpenStackShared;
import com.ivucenter.cloud.api.openstack.connector.OpenStackRestConnector;
import com.ivucenter.cloud.api.openstack.connector.RestResponse;
import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.api.openstack.object.Value;
import com.ivucenter.cloud.api.vmware.object.VmwareTokenJsonObject;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;

import lombok.AccessLevel;
import lombok.NoArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class IdentityVmware extends OpenStackShared implements VmwareIdentityIF {
	
	private String API_IDENTITY_SERVER;
	private String VMWARE_ADMIN_USERNAME;
	private String VMWARE_ADMIN_PASSWORD;
	
	// Constractors	
	public IdentityVmware(CustomOssCloudVO cloudVo) {
		super.cloudVo = cloudVo;
		this.API_IDENTITY_SERVER = cloudVo.getAdminDomain();
		this.VMWARE_ADMIN_USERNAME = cloudVo.getAdminUsername();
		this.VMWARE_ADMIN_PASSWORD = cloudVo.getAdminPassword();
	}
	
	@Override
	public Value getToken() 
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("Accept", "application/json");
		String contentType = "application/json";
		
		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.POST, API_IDENTITY_SERVER +"/rest/com/vmware/cis/session", 
				                                                                            headers, contentType, null, VMWARE_ADMIN_USERNAME+ ":"+VMWARE_ADMIN_PASSWORD);
		VmwareTokenJsonObject obj = JsonUtils.getJsonObjectVmware(output.getMessage());

		Value value = new Value();
		value.setValue(obj.getValue());
		return value;
	}
	
	
}
