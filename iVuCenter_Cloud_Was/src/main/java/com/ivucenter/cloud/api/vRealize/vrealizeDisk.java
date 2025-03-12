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
import com.ivucenter.cloud.api.vRealize.interfaces.vraDiskIF;
import com.ivucenter.cloud.api.vRealize.object.vraAttachDisk;
import com.ivucenter.cloud.api.vRealize.object.vraBlockDevice;
import com.ivucenter.cloud.api.vRealize.object.vraDataStoreContent;
import com.ivucenter.cloud.api.vRealize.object.vraJsonObject;
import com.ivucenter.cloud.api.vRealize.object.vraMachineDisks;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;

public class vrealizeDisk extends vrealizeShared implements vraDiskIF{
	
	private String API_SERVER;
	
	public vrealizeDisk(CustomOssCloudVO cloudVo) {
		super.cloudVo = cloudVo;
		this.API_SERVER = cloudVo.getApiGatewayServer();
	}

	@Override
	public vraMachineDisks getDiskInfo(String machineId)
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		
		Map<String, String> headers = new HashMap<String, String>();

		String contentType = "application/json";
		String url = API_SERVER+"/iaas/api/machines/" + machineId + "/disks";
		String payLoad = "";
		vraRestResponse output = vraRestConnector.doRequest(HttpMethod.GET, url, headers, contentType, payLoad,getAdminToken(super.cloudVo));
		vraMachineDisks Disks = JsonUtils.getJsonVraMachineDiskObject(output.getMessage());
		return Disks;
	}

	@Override
	public vraJsonObject createBlockDevice(vraBlockDevice blockDevice)
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {

		vraBlockDevice inJson = blockDevice;
		Map<String, String> headers = new HashMap<String, String>();

		String contentType = "application/json";
		String url = API_SERVER+"/iaas/api/block-devices";
		String payLoad = JsonUtils.alwaysJsonFormatString(inJson);
		vraRestResponse output = vraRestConnector.doRequest(HttpMethod.POST, url, headers, contentType, payLoad,getAdminToken(super.cloudVo));
		vraJsonObject res = JsonUtils.vraGetJsonObject(output.getMessage());
		return res;
	}

	@Override
	public vraJsonObject blockTracker(String trackerId)
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		
		Map<String, String> headers = new HashMap<String, String>();

		String contentType = "application/json";
		String url = API_SERVER+"/iaas/api/request-tracker/"+trackerId;
		String payLoad = "";
		vraRestResponse output = vraRestConnector.doRequest(HttpMethod.GET, url, headers, contentType, payLoad,getAdminToken(super.cloudVo));
		vraJsonObject res = JsonUtils.vraGetJsonObject(output.getMessage());
		
		return res;
	}

	@Override
	public vraJsonObject attachDisk(vraAttachDisk vraAttachDisk,String MachineId)
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		vraAttachDisk inJson = vraAttachDisk;
		Map<String, String> headers = new HashMap<String, String>();

		String contentType = "application/json";
		String url = API_SERVER+"/iaas/api/machines/"+MachineId+"/disks";
		String payLoad = JsonUtils.alwaysJsonFormatString(inJson);
		vraRestResponse output = vraRestConnector.doRequest(HttpMethod.POST, url, headers, contentType, payLoad,getAdminToken(super.cloudVo));
		vraJsonObject res = JsonUtils.vraGetJsonObject(output.getMessage());
		return res;
	}

	@Override
	public vraBlockDevice getBlockDevice(String deviceId)
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		
		Map<String, String> headers = new HashMap<String, String>();

		String contentType = "application/json";
		String url = API_SERVER+"/iaas/api/block-devices";
		if(!deviceId.equals("")) {
			url += "/"+deviceId;
		}
		String payLoad = "";
		vraRestResponse output = vraRestConnector.doRequest(HttpMethod.GET, url, headers, contentType, payLoad,getAdminToken(super.cloudVo));
		vraBlockDevice res = JsonUtils.getJsonVrablockDeviceObject(output.getMessage());
		
		return res;
	}

	@Override
	public vraDataStoreContent getDataStores()
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		
		Map<String, String> headers = new HashMap<String, String>();

		String contentType = "application/json";
		String url = API_SERVER+"/iaas/api/fabric-vsphere-datastores";
		String payLoad = "";
		vraRestResponse output = vraRestConnector.doRequest(HttpMethod.GET, url, headers, contentType, payLoad,getAdminToken(super.cloudVo));
		vraDataStoreContent res = JsonUtils.getJsonVraDataStoreObject(output.getMessage());
		
		return res;
	}
	
	@Override
	public vraDataStoreContent getDataStore(String id)
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		
		Map<String, String> headers = new HashMap<String, String>();

		String contentType = "application/json";
		String url = API_SERVER+"/iaas/api/fabric-vsphere-datastores/"+id;
		String payLoad = "";
		vraRestResponse output = vraRestConnector.doRequest(HttpMethod.GET, url, headers, contentType, payLoad,getAdminToken(super.cloudVo));
		vraDataStoreContent res = JsonUtils.getJsonVraDataStoreObject(output.getMessage());
		
		return res;
	}

	@Override
	public vraJsonObject changeDisk(String diskId, String diskGb)
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();

		String contentType = "application/json";
		String url = API_SERVER+"/iaas/api/block-devices/"+diskId+"?capacityInGB="+diskGb;
		String payLoad = "";
		vraRestResponse output = vraRestConnector.doRequest(HttpMethod.POST, url, headers, contentType, payLoad,getAdminToken(super.cloudVo));
		vraJsonObject res = JsonUtils.vraGetJsonObject(output.getMessage());
		return res;
	}

	@Override
	public vraJsonObject deleteDisk(String diskId)
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		
		String contentType = "application/json";
		String url = API_SERVER+"/iaas/api/block-devices/"+diskId;
		String payLoad = "";
		vraRestResponse output = vraRestConnector.doRequest(HttpMethod.DELETE, url, headers, contentType, payLoad,getAdminToken(super.cloudVo));
		vraJsonObject res = JsonUtils.vraGetJsonObject(output.getMessage());
		return res;
	}

	@Override
	public vraJsonObject detachDisk(String diskId, String machineId)
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		
		Map<String, String> headers = new HashMap<String, String>();

		String contentType = "application/json";
		String url = API_SERVER+"/iaas/api/machines/"+machineId+"/disks/"+diskId;
		String payLoad = "";
		vraRestResponse output = vraRestConnector.doRequest(HttpMethod.DELETE, url, headers, contentType, payLoad,getAdminToken(super.cloudVo));
		vraJsonObject res = JsonUtils.vraGetJsonObject(output.getMessage());
		return res;
	}

}
