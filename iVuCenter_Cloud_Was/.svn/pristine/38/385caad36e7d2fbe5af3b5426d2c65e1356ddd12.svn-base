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
import com.ivucenter.cloud.api.vmware.interfaces.VmDiskIF;
import com.ivucenter.cloud.api.vmware.object.DiskSpec;
import com.ivucenter.cloud.api.vmware.object.VmDisks;
import com.ivucenter.cloud.api.vmware.object.VmwareTokenJsonObject;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;
import com.ivucenter.cloud.portal.req.product.CustomReqProductVO;

public class VMWareDisk extends VMWareShared implements VmDiskIF {

	private String vmUuid;
	private String API_SERVER;
	private String diskId;
	
	public VMWareDisk(CustomReqProductVO req,CustomOssCloudVO cloudVo) {
		this.vmUuid = req.getVmUuid();
		this.diskId = req.getDiskId();
		super.cloudVo = cloudVo;
		this.API_SERVER = cloudVo.getAdminDomain();
	}
	

	@Override
	public DiskSpec createDisk(DiskSpec spec,String libraryId)
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {

		Map<String, String> headers = new HashMap<String, String>();
		headers.put("vmware-api-session-id", getToken(cloudVo));

		
		String contentType = "application/json";
		String url = API_SERVER+"/rest/vcenter/vm/"+vmUuid+"/hardware/disk";
		String payLoad = JsonUtils.getJsonFormatString(spec);

		VmRestResponse output = VmWareRestConnector.doRequest(HttpMethod.POST, url, headers, contentType, payLoad);
		
		VmwareTokenJsonObject obj = JsonUtils.getJsonObjectVmware(output.getMessage());
		spec.setValue(obj.getValue());
		return spec;
	}
	
	@Override
	public DiskSpec deleteDisk(DiskSpec spec,String libraryId)
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {

		Map<String, String> headers = new HashMap<String, String>();
		headers.put("vmware-api-session-id", getToken(cloudVo));

		
		String contentType = "application/json";
		String url = API_SERVER+"/rest/vcenter/vm/"+vmUuid+"/hardware/disk/"+ diskId;

		VmRestResponse output = VmWareRestConnector.doRequest(HttpMethod.DELETE, url, headers, contentType);
		
		
		spec.setValue(output.getValue());
		return spec;
	}
	
	
	@Override
	public VmDisks getDisk()
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {

		Map<String, String> headers = new HashMap<String, String>();
		headers.put("vmware-api-session-id", getToken(cloudVo));
		String contentType = "application/json";
		String url = API_SERVER+"/rest/vcenter/vm/"+vmUuid+"/hardware/disk/"+ diskId;
		VmRestResponse output = VmWareRestConnector.doRequest(HttpMethod.GET, url, headers, contentType);
		VmDisks obj = JsonUtils.getJsonGetDiskObject(output.getMessage());
		return obj;
	}
	
}
