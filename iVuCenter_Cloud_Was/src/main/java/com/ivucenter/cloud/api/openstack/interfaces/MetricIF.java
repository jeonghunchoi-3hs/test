package com.ivucenter.cloud.api.openstack.interfaces;

import java.util.List;

import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.api.openstack.object.Measure;
import com.ivucenter.cloud.api.openstack.object.OpenStackMetricData;

public interface MetricIF {

	public OpenStackMetricData getMetric(String resource_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public List<OpenStackMetricData> getMetricFilter(String filter) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public List<Measure> getMeasures(String metric_id, String filter) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
}
