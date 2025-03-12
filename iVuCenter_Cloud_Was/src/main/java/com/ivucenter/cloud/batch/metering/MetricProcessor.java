package com.ivucenter.cloud.batch.metering;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import org.springframework.batch.item.ItemProcessor;
import org.springframework.beans.factory.annotation.Autowired;

import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.api.openstack.interfaces.AbstractFactory;
import com.ivucenter.cloud.api.openstack.interfaces.MetricIF;
import com.ivucenter.cloud.api.openstack.object.OpenStackMetricData;
import com.ivucenter.cloud.batch.entity.BatchOssVmVO;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;
import com.ivucenter.cloud.portal.cmm.cloud.OssCloudService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class MetricProcessor implements ItemProcessor<BatchOssVmVO, Map<String, Object>> {

	@Autowired
	private OssCloudService ossCloudService;

	@Override
	public Map<String, Object> process(BatchOssVmVO ossVmVO) throws Exception {

        /******************************************************
		 *** Metric ID 목록 가져오기
		 ******************************************************/
		String serverId = ossVmVO.getVmUuid();
		String cloudId  = ossVmVO.getCloudId();
		String cloudType = ossVmVO.getCloudType();
		
		Map<String, Object> metricMap = new HashMap<String, Object>();
		if(cloudType.equals("openstack")) {
			
		    CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo(cloudId);
			
	        MetricIF metricIf = AbstractFactory.getMetricIF(cloudVo);
			Map<String, String> metrics = new HashMap<String, String>();
			try {
				OpenStackMetricData metric = metricIf.getMetric(serverId);
				metrics = metric.getMetrics();
			} catch (InvaildOpenStackException | NotConnectGatewayException | NotSupportGatewayException e) {
				log.debug("MetricProcessor Error=" + e.toString());
			}

			if (metrics != null) {
				metricMap.put(serverId, metrics);
			}
			
		}else if(cloudType.equals("vmware")) {
			   try {
				   Map<String, String> metrics = new HashMap<String, String>();
				   metrics.put("vcpus", UUID.randomUUID().toString());
				   metrics.put("memory", UUID.randomUUID().toString());
				   if (metrics != null) {
					   metricMap.put(serverId, metrics);
				   }
				   
			   }catch (Exception e) {
					log.debug("MetricProcessor Error=" + e.toString());
			}
		}
			
		return metricMap;
	}
}
