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
import com.ivucenter.cloud.api.vmware.interfaces.VmServerIF;
import com.ivucenter.cloud.api.vmware.object.VmSpec;
import com.ivucenter.cloud.api.vmware.object.VmWareJsonObject;
import com.ivucenter.cloud.api.vmware.object.VmwareTokenJsonObject;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;

public class VMWareServer extends VMWareShared implements VmServerIF {

	private String projectName;
	private String API_SERVER;
	
	// floder를 openstack의 project처럼 쓸수 없다면 바껴야 할듯?
	public VMWareServer(String projectName,CustomOssCloudVO cloudVo) {
		this.projectName = projectName;
		super.cloudVo = cloudVo;
		this.API_SERVER = cloudVo.getAdminDomain();
	}
	
	public VMWareServer(CustomOssCloudVO cloudVo) {
		super.cloudVo = cloudVo;
		this.API_SERVER = cloudVo.getAdminDomain();
	}
	
	@Override
	public VmWareJsonObject getServer(String VmUuid) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException{
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("vmware-api-session-id", getToken(cloudVo));

		String contentType = "application/json";
		String url = API_SERVER+"/rest/vcenter/vm/"+VmUuid;
		String payLoad = "";
		VmRestResponse output = VmWareRestConnector.doRequest(HttpMethod.GET, url, headers, contentType);
	
		VmWareJsonObject obj = JsonUtils.getVmWareJsonObject(output.getMessage());
		//VmWareJsonObject obj = null;
	
		return obj;
	}


	@Override
	public VmSpec createServer(VmSpec spec,String libraryId)
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {

		Map<String, String> headers = new HashMap<String, String>();
		headers.put("vmware-api-session-id", getToken(cloudVo));

		String contentType = "application/json";
		String url = API_SERVER+"/rest/vcenter/vm-template/library-items/"+libraryId+"?action=deploy";
		String payLoad = JsonUtils.getJsonFormatString(spec);

		VmRestResponse output = VmWareRestConnector.doRequest(HttpMethod.POST, url, headers, contentType, payLoad);
		
		VmwareTokenJsonObject obj = JsonUtils.getJsonObjectVmware(output.getMessage());
		spec.setValue(obj.getValue());
		return spec;
	}

	@Override
	public int actionServer(String vmUuid, String action) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		// TODO Auto-generated method stub
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("vmware-api-session-id", getToken(cloudVo));

		String contentType = "application/json";
		String url = "";
		if(action.equals("stop")) {
			url = API_SERVER+"/rest/vcenter/vm/"+vmUuid+"/power/stop";
		} else if (action.equals("reset")){
			url = API_SERVER+"/rest/vcenter/vm/"+vmUuid+"/power/reset";
		}	else {
			url = API_SERVER+"/rest/vcenter/vm/"+vmUuid+"/power/start";
		}
		VmRestResponse output = VmWareRestConnector.doRequest(HttpMethod.POST, url, headers, contentType);
		return output.getStatusCode();
	}

	@Override
	public boolean deleteServer(String vmId) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("vmware-api-session-id", getToken(cloudVo));

		String contentType = "application/json";
		String url = API_SERVER+"/rest/vcenter/vm/" + vmId;
		
		VmRestResponse output = VmWareRestConnector.doRequest(HttpMethod.DELETE, url, headers, contentType);
		return (output.getStatusCode() == 202) ? true : false;
	}
	

}
