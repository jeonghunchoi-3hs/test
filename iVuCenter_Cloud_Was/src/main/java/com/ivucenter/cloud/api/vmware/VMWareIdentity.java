package com.ivucenter.cloud.api.vmware;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpMethod;

import com.ivucenter.cloud.api.common.utils.JsonUtils;
import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.api.vmware.connector.VmRestResponse;
import com.ivucenter.cloud.api.vmware.connector.VmWareRestConnector;
import com.ivucenter.cloud.api.vmware.interfaces.VmIdentityIF;
import com.ivucenter.cloud.api.vmware.object.VmwareTokenJsonObject;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class VMWareIdentity extends VMWareShared implements VmIdentityIF {

	private String VMWARE_ADMIN_USERNAME;
	private String VMWARE_ADMIN_PASSWORD;
	private String API_SERVER;
	
	// Constractors	
	public VMWareIdentity(CustomOssCloudVO cloudVo) {
		super.cloudVo = cloudVo;
		this.API_SERVER = cloudVo.getApiIdentityServer();;
		this.VMWARE_ADMIN_USERNAME = cloudVo.getProjectUsername();
		this.VMWARE_ADMIN_PASSWORD = cloudVo.getProjectPassword();
	}

	@Override
	public String getToken(CustomOssCloudVO cloudVO)
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("Accept", "application/json");
		String contentType = "application/json";
		
		VmRestResponse output = VmWareRestConnector.doRequest(HttpMethod.POST, API_SERVER +"/rest/com/vmware/cis/session",headers, contentType, null, VMWARE_ADMIN_USERNAME+ ":"+VMWARE_ADMIN_PASSWORD);
		VmwareTokenJsonObject obj = JsonUtils.getJsonObjectVmware(output.getMessage());
		log.debug(JsonUtils.getJsonFormatString(obj));

		return obj.getValue();
	}

	

}
