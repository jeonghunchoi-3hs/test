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
import com.ivucenter.cloud.api.vmware.interfaces.VmDataStoreIF;
import com.ivucenter.cloud.api.vmware.object.VmDataStoreObject;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;

public class VmDataStore extends VMWareShared implements VmDataStoreIF {
	
	private String API_SERVER;
	
	public VmDataStore(CustomOssCloudVO cloudVo) {
		super.cloudVo = cloudVo;
		this.API_SERVER = cloudVo.getApiIdentityServer();
	}

	@Override
	public VmDataStoreObject getDataStore()
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("vmware-api-session-id", getToken(cloudVo));

		String contentType = "application/json";
		String url = API_SERVER+"/rest/vcenter/datastore";
		String payLoad = "";
		VmRestResponse output = VmWareRestConnector.doRequest(HttpMethod.GET, url, headers, contentType);
	
		VmDataStoreObject obj = JsonUtils.getVmWareDataStoreObject(output.getMessage());
		//VmWareJsonObject obj = null;
	
		return obj;
	}
}
