package com.ivucenter.cloud.api.vmware;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpMethod;

import com.ivucenter.cloud.api.VmwareLibraryIF;
import com.ivucenter.cloud.api.common.utils.JsonUtils;
import com.ivucenter.cloud.api.openstack.connector.OpenStackRestConnector;
import com.ivucenter.cloud.api.openstack.connector.RestResponse;
import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.api.vmware.object.VmwareDetailsItemJsonObject;
import com.ivucenter.cloud.api.vmware.object.VmwareItemJsonObject;
import com.ivucenter.cloud.api.vmware.object.VmwareLibrariesJsonObject;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;

import lombok.AccessLevel;
import lombok.NoArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class VmwareLibraries extends VMWareShared implements VmwareLibraryIF {
	
	private String API_IDENTITY_SERVER;
	private String VMWARE_ADMIN_USERNAME;
	private String VMWARE_ADMIN_PASSWORD;
	private String VMWARE_TOKEN;
	
	// Constractors	
	public VmwareLibraries(CustomOssCloudVO cloudVo) {
		super.cloudVo = cloudVo;
		this.API_IDENTITY_SERVER = cloudVo.getAdminDomain();
		this.VMWARE_ADMIN_USERNAME = cloudVo.getAdminUsername();
		this.VMWARE_ADMIN_PASSWORD = cloudVo.getAdminPassword();
	}
	
	@Override
	public List<String> getLibraries() 	throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("Accept", "application/json");
		headers.put("vmware-api-session-id", getToken(cloudVo));
		String contentType = "application/json";
		
		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.GET, API_IDENTITY_SERVER +"/rest/com/vmware/content/library", 
				                                                                            headers, contentType, null,VMWARE_ADMIN_USERNAME+ ":"+VMWARE_ADMIN_PASSWORD);
		
		VmwareLibrariesJsonObject obj = JsonUtils.getJsonLibrariesObject(output.getMessage());
		log.debug(JsonUtils.getJsonFormatString(obj));
		
		
		return obj.getValue();
	}
	
	
	@Override
	public List<String> getLibrary(String libraryId) 
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("Accept", "application/json");
		headers.put("vmware-api-session-id", getToken(cloudVo));
		String contentType = "application/json";
		
		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.GET, API_IDENTITY_SERVER +"/rest/com/vmware/content/library/item?library_id="+libraryId, 
				                                                                            headers, contentType, null);
		
		VmwareLibrariesJsonObject obj = JsonUtils.getJsonLibrariesObject(output.getMessage());
		log.debug(JsonUtils.getJsonFormatString(obj));
		
		
		return obj.getValue();
	
	}
	
	@Override
	public VmwareItemJsonObject getDetailItem(String id) 
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("Accept", "application/json");
		headers.put("vmware-api-session-id", getToken(cloudVo));
		String contentType = "application/json";
		
		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.GET, API_IDENTITY_SERVER +"/rest/com/vmware/content/library/item/id:"+id, 
				                                                                            headers, contentType, null);
		
		VmwareDetailsItemJsonObject obj = JsonUtils.getJsonDetailsItemObject(output.getMessage());
		log.debug(JsonUtils.getJsonFormatString(obj));
		
		
		return obj.getValue();
	
	}


	
}
