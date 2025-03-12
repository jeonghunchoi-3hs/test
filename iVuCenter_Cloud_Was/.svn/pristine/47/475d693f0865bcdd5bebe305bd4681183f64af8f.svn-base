package com.ivucenter.cloud.api.Interface;

import static org.junit.Assert.assertNotNull;

import java.util.List;

import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.api.openstack.interfaces.AbstractFactory;
import com.ivucenter.cloud.api.openstack.interfaces.MetricIF;
import com.ivucenter.cloud.api.openstack.object.Measure;
import com.ivucenter.cloud.api.openstack.object.OpenStackMetricData;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;
import com.ivucenter.cloud.portal.cmm.cloud.OssCloudService;

import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
		"file:WebContent/WEB-INF/spring/application-context.xml",
		"classpath:mybatis-context.xml"	})
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
@Slf4j
public class OpenStackMetricTest {

	@Autowired
	private OssCloudService ossCloudService;
	
//	private String metric;
	
	@Test
	public void testGetMetric() {
		
		log.info(" ==============> start testGetMetric() ");
		List<CustomOssCloudVO> getCloudList = ossCloudService.getCloudList();
	  	getCloudList.forEach(cloudVo -> {
	  		MetricIF apiIF = AbstractFactory.getMetricIF(cloudVo);
			assertNotNull("FlavorIF 객체 생성 실패",apiIF);
			OpenStackMetricData openStackMetricData = null;
			try {
				openStackMetricData =  apiIF.getMetric(null);
				assertNotNull("flavor정보를 가져오지 못함",openStackMetricData);		
				log.info(" ==============>"+openStackMetricData.toString());
			} catch (NotConnectGatewayException|NotSupportGatewayException|InvaildOpenStackException e) {
				log.error(e.getMessage());
			}
	  		
	  	});
		log.info(" ==============> end   testGetMetric() ");
		
	}

	@Test
	public void testGetMetricFilter() {
		log.info(" ==============> start testGetMetricFilter() ");
		List<CustomOssCloudVO> getCloudList = ossCloudService.getCloudList();
	  	getCloudList.forEach(cloudVo -> {
			MetricIF apiIF = AbstractFactory.getMetricIF(cloudVo);
			assertNotNull("MetricIF 객체 생성 실패",apiIF);
			try {
				List<OpenStackMetricData> openStackMetricData =  apiIF.getMetricFilter(null);
				assertNotNull("Metric정보를 가져오지 못함",openStackMetricData);
				openStackMetricData.forEach(obj -> { log.info(" testGetMetricFilter : {}", obj.toString()); });				
				
			} catch (NotConnectGatewayException|NotSupportGatewayException|InvaildOpenStackException e) {
				log.error(e.getMessage());
			}
	  	});
		log.info(" ==============> end testGetMetricFilter() ");

	}

	@Test
	public void testGetMeasures() {

		log.info(" ==============> start testGetMeasures() ");
		List<CustomOssCloudVO> getCloudList = ossCloudService.getCloudList();
	  	getCloudList.forEach(cloudVo -> {
			MetricIF apiIF = AbstractFactory.getMetricIF(cloudVo);
			assertNotNull("MetricIF 객체 생성 실패",apiIF);
	//		List<Measure> openStackMetricData =  apiIF.getMeasures(metric_id, filter));
			try {
				List<Measure> openStackMetricData =  apiIF.getMeasures(null, null);
				assertNotNull("Metric정보를 가져오지 못함",openStackMetricData);		
				openStackMetricData.forEach(obj -> { log.info(" testGetMeasures : {}", obj.toString()); });
		  	} catch (NotConnectGatewayException|NotSupportGatewayException|InvaildOpenStackException e) {
				log.error(e.getMessage());
			}
	  	});
		log.info(" ==============> end testGetMeasures() ");
		
	}

}
