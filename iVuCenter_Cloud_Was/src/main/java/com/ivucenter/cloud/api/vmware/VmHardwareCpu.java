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
import com.ivucenter.cloud.api.vmware.interfaces.VmHardwareCpuIF;
import com.ivucenter.cloud.api.vmware.object.VmHardwareCpuVO;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;

public class VmHardwareCpu extends VMWareShared implements VmHardwareCpuIF {

	private String API_SERVER;
	
	public VmHardwareCpu(CustomOssCloudVO cloudVo) {
		super.cloudVo = cloudVo;
		this.API_SERVER = cloudVo.getAdminDomain();
	}

	@Override
	public boolean updateCpu(VmHardwareCpuVO spec, String vmId) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {

		Map<String, String> headers = new HashMap<String, String>();
		headers.put("vmware-api-session-id", getToken(cloudVo));

		String contentType = "application/json";
		String url = API_SERVER+"/rest/vcenter/vm/"+vmId+"/hardware/cpu";
		String payLoad = JsonUtils.getJsonFormatString(spec);
		System.out.print(payLoad);
		VmRestResponse output = VmWareRestConnector.doRequest(HttpMethod.PATCH, url, headers, contentType, payLoad);
		return (output.getStatusCode() == 202) ? true : false;
	}

	
}
