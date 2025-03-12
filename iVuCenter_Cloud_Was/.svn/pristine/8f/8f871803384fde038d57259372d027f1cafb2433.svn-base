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
import com.ivucenter.cloud.api.openstack.interfaces.CustomIF;
import com.ivucenter.cloud.api.openstack.object.CustomVolume;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;

import lombok.AccessLevel;
import lombok.NoArgsConstructor;

@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class OpenStackCustom extends OpenStackShared implements CustomIF {

	private String API_METRICS_SERVER;

	public OpenStackCustom(CustomOssCloudVO cloudVo) {
		super.cloudVo = cloudVo;
		this.API_METRICS_SERVER = cloudVo.getApiMetricsServer();
	}

	@Override
	public List<CustomVolume> getAllVolumes() throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();

		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.GET, API_METRICS_SERVER + "/", headers);

		List<CustomVolume> metrics = JsonUtils.getJsonCustomVolumeDatas(output.getMessage());
		return metrics;
	}

	/*
	public static void main(String[] args) {

		try {
			CustomIF customIF = AbstractFactory.getCustomIF();
			List<CustomVolume> list = customIF.getAllVolumes();
			for (CustomVolume obj : list) {
				log.debug(obj.getProject_id()+" : "+obj.getVolume_id()+" : "+obj.getDeleted());
			}
		} catch (NotConnectGatewayException | NotSupportGatewayException | InvaildOpenStackException e) {
		}
	}
	*/
}
