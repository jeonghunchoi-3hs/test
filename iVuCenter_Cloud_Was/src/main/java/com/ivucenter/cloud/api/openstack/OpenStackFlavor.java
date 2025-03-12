package com.ivucenter.cloud.api.openstack;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpMethod;

import com.ivucenter.cloud.api.common.utils.JsonUtils;
import com.ivucenter.cloud.api.openstack.connector.OpenStackRestConnector;
import com.ivucenter.cloud.api.openstack.connector.RestResponse;
import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.api.openstack.interfaces.FlavorIF;
import com.ivucenter.cloud.api.openstack.object.Flavor;
import com.ivucenter.cloud.api.openstack.object.OpenStackJsonObject;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;

import lombok.AccessLevel;
import lombok.NoArgsConstructor;

@NoArgsConstructor(access=AccessLevel.PROTECTED)
public class OpenStackFlavor extends OpenStackShared implements FlavorIF {

	private String API_COMPUTE_SERVER;

	public OpenStackFlavor(CustomOssCloudVO cloudVo) {

		super.cloudVo = cloudVo;
		this.API_COMPUTE_SERVER = cloudVo.getApiComputeServer();
	}

	@Override
	public List<Flavor> getFlavors() throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getAdminToken(super.cloudVo));

		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.GET, API_COMPUTE_SERVER + "/flavors", headers);

		OpenStackJsonObject obj = JsonUtils.getJsonObject(output.getMessage());

		List<Flavor> newFlavor = new LinkedList<Flavor>();
		for (Flavor flavor : obj.getFlavors()) {
			newFlavor.add(getFlavor(flavor.getId()));
		}
		return newFlavor;
//		return obj.getFlavors();
	}

	@Override
	public Flavor getFlavor(String flavor_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getAdminToken(super.cloudVo));

		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.GET, API_COMPUTE_SERVER+"/flavors/"+flavor_id, headers);

		OpenStackJsonObject obj = JsonUtils.getJsonObject(output.getMessage());
		return obj.getFlavor();
	}

	@Override
	public Flavor createFlavor(Flavor flavor) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		OpenStackJsonObject inJson = new OpenStackJsonObject();
		inJson.setFlavor(flavor);

		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getAdminToken(super.cloudVo));
		String contentType = "application/json";
		String url = API_COMPUTE_SERVER+"/flavors";
		String payLoad = JsonUtils.getJsonFormatString(inJson);

		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.POST, url, headers, contentType, payLoad);
		OpenStackJsonObject obj = JsonUtils.getJsonObject(output.getMessage());
		return obj.getFlavor();
	}

}
