package com.ivucenter.cloud.api.openstack;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpMethod;

import com.ivucenter.cloud.api.common.utils.JsonUtils;
import com.ivucenter.cloud.api.openstack.connector.OpenStackRestConnector;
import com.ivucenter.cloud.api.openstack.connector.RestResponse;
import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.api.openstack.interfaces.VolumeIF;
import com.ivucenter.cloud.api.openstack.object.OpenStackJsonObject;
import com.ivucenter.cloud.api.openstack.object.QuotaSet;
import com.ivucenter.cloud.api.openstack.object.StoragePool;
import com.ivucenter.cloud.api.openstack.object.Volume;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;

import lombok.AccessLevel;
import lombok.NoArgsConstructor;

@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class OpenStackVolume extends OpenStackShared implements VolumeIF {

	private String projectName;
	private String API_VOLUMEV3_SERVER;

	public OpenStackVolume(CustomOssCloudVO cloudVo) {
		super.cloudVo = cloudVo;
		this.API_VOLUMEV3_SERVER = cloudVo.getApiVolumeV3server();
	}
	public OpenStackVolume(String projectName,CustomOssCloudVO cloudVo) {
		this.projectName = projectName;
		super.cloudVo = cloudVo;
		this.API_VOLUMEV3_SERVER = cloudVo.getApiVolumeV3server();
	}

	@Override
	public List<StoragePool> getStoregPools() throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getAdminToken(super.cloudVo));

		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.GET, API_VOLUMEV3_SERVER + "/"+ current_project_id + "/scheduler-stats/get_pools?detail=true", headers);

		//OpenStackJsonObject obj = JsonUtils.getJsonObject(output.getMessage());
		// Network의 Pool 객체와 객체명이 겹쳐서 강제로 변경시킴
		OpenStackJsonObject obj = JsonUtils.getJsonObject(output.getMessage().replaceAll("pools", "storagePools"));

		return obj.getStoragePools();
	}

	@Override
	public List<Volume> getVolumes() throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getProjectToken(projectName, super.cloudVo));
//		headers.put("X-Auth-Token", getAdminToken());

		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.GET, API_VOLUMEV3_SERVER + "/"+ current_project_id + "/volumes/detail", headers);

		OpenStackJsonObject obj = JsonUtils.getJsonObject(output.getMessage());

//		List<Volume> volumes = new LinkedList<Volume>();
//		for (Volume volume : obj.getVolumes()) {
//			log.debug(volume.getId());
//			volumes.add(getVolume(volume.getId()));
//		}
		return obj.getVolumes();
	}

	@Override
	public List<Volume> getAllVolumes(String filter) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getAdminToken(super.cloudVo));

//		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.GET, API_BASE_COMPUTE + "/"+ current_project_id + "/volumes/detail?all_tenants=1", headers);
		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.GET, API_VOLUMEV3_SERVER + "/"+ current_project_id + "/volumes/detail?all_tenants=1" + filter, headers);
		OpenStackJsonObject obj = JsonUtils.getJsonObject(output.getMessage());
		return obj.getVolumes();
	}

	@Override
	public Volume getVolume(String volume_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getProjectToken(projectName,super.cloudVo));
//		headers.put("X-Auth-Token", getAdminToken());
		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.GET, API_VOLUMEV3_SERVER + "/"+ current_project_id + "/volumes/" + volume_id, headers);
//		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.GET, API_BASE_COMPUTE + "/volumes/" + volume_id, headers);

		OpenStackJsonObject obj = JsonUtils.getJsonObject(output.getMessage());
		return obj.getVolume();
	}

	@Override
	public Volume createVolume(Volume volume) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		OpenStackJsonObject inJson = new OpenStackJsonObject();
		inJson.setVolume(volume);

		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getProjectToken(projectName,super.cloudVo));
		String contentType = "application/json";
		String payLoad = JsonUtils.getJsonFormatString(inJson);
		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.POST, API_VOLUMEV3_SERVER + "/"+ current_project_id + "/volumes" , headers, contentType, payLoad);
		OpenStackJsonObject obj = JsonUtils.getJsonObject(output.getMessage());
		return obj.getVolume();
	}

	@Override
	public boolean deleteVolume(String volume_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getProjectToken(projectName, super.cloudVo));
		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.DELETE, API_VOLUMEV3_SERVER + "/"+ current_project_id + "/volumes/"+volume_id, headers, true);
		if (output.getStatusCode() == 202)
			return true;
		return false;
	}

	@Override
	public boolean attachVolume(String server_id, String volume_id, String mountpoint) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getProjectToken(projectName, super.cloudVo));
		String contentType = "application/json";
		String payLoad = "{ \"os-attach\" : { \"instance_uuid\": \"" + server_id + "\", \"mountpoint\": \"" + mountpoint + "\" } }";

		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.POST, API_VOLUMEV3_SERVER + "/"+ current_project_id + "/volumes/" + volume_id +"/action", headers, contentType, payLoad, true,null);
		return (output.getStatusCode() == 202) ? true : false;
	}

	@Override
	public boolean detachVolume(String volume_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getProjectToken(projectName, super.cloudVo));
		String contentType = "application/json";
		String payLoad = "{ \"os-detach\" : { \"attachment_id\": \"" + volume_id + "\" } }";

		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.POST, API_VOLUMEV3_SERVER + "/"+ current_project_id + "/volumes/" + volume_id +"/action", headers, contentType, payLoad, true,null);
		return (output.getStatusCode() == 202) ? true : false;
	}

	@Override
	public boolean extendVolume(String volume_id, int resize_gigabyte) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getProjectToken(projectName, super.cloudVo));
		String contentType = "application/json";
		String payLoad = "{ \"os-extend\" : { \"new_size\": \"" + resize_gigabyte + "\" } }";

		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.POST, API_VOLUMEV3_SERVER + "/"+ current_project_id + "/volumes/" + volume_id +"/action", headers, contentType, payLoad, true,null);
		return (output.getStatusCode() == 202) ? true : false;
	}

	@Override
	public QuotaSet getVolumeQuota(String admin_project_id, String project_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getAdminToken(super.cloudVo));


		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.GET, API_VOLUMEV3_SERVER + "/"+ admin_project_id + "/os-quota-sets/" + project_id, headers);
//		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.GET, API_COMPUTE_SERVER + "/os-quota-sets/" + project_id, headers);

		OpenStackJsonObject obj = JsonUtils.getJsonObject(output.getMessage());
		return obj.getQuota_set();
	}

	@Override
	public QuotaSet updateVolumeQuota(String admin_project_id, String project_id, QuotaSet quotaSet) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		OpenStackJsonObject inJson = new OpenStackJsonObject();
		inJson.setQuota_set(quotaSet);

		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getAdminToken(projectName,super.cloudVo));
		String contentType = "application/json";
		String payLoad = JsonUtils.getJsonFormatString(inJson);
		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.PUT, API_VOLUMEV3_SERVER + "/"+ project_id + "/os-quota-sets/" + project_id , headers, contentType, payLoad);
		OpenStackJsonObject obj = JsonUtils.getJsonObject(output.getMessage());
		return obj.getQuota_set();
	}

}
