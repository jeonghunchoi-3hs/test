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
import com.ivucenter.cloud.api.openstack.interfaces.MetricIF;
import com.ivucenter.cloud.api.openstack.object.Measure;
import com.ivucenter.cloud.api.openstack.object.OpenStackMetricData;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;

import lombok.AccessLevel;
import lombok.NoArgsConstructor;

@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class OpenStackMetric extends OpenStackShared implements MetricIF {

	private String API_METRICS_SERVER;

	public OpenStackMetric(CustomOssCloudVO cloudVo) {
		super.cloudVo = cloudVo;
		this.API_METRICS_SERVER = cloudVo.getApiMetricsServer();
	}

	@Override
	public OpenStackMetricData getMetric(String resource_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getAdminToken(super.cloudVo));
		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.GET, API_METRICS_SERVER+"/resource/generic/"+resource_id, headers);
		//RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.GET, API_BASE+"/v1/resource/generic/"+"ecc48eeb-afd8-41df-b7c9-f85eef844a0c", headers);
		OpenStackMetricData metric = JsonUtils.getJsonMetricData(output.getMessage());
		return metric;
	}

	@Override
	public List<OpenStackMetricData> getMetricFilter(String filter) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getAdminToken(super.cloudVo));
		String contentType = "application/json";
		String url = API_METRICS_SERVER+"/search/resource/generic";
		String payLoad = filter;
		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.POST, url, headers, contentType, payLoad);
		List<OpenStackMetricData> metrics = JsonUtils.getJsonMetricDatas(output.getMessage());
		return metrics;
	}

	@Override
	public List<Measure> getMeasures(String metric_id, String filter) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getAdminToken(this.cloudVo));
		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.GET, API_METRICS_SERVER+"/metric/"+metric_id+"/measures?"+filter, headers);
		List<Measure> metrics = JsonUtils.getJsonMeasuresData(output.getMessage());
		return metrics;
	}

}
