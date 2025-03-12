package com.ivucenter.cloud.api.Interface;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.fail;

import java.util.List;

import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.ivucenter.cloud.api.openstack.interfaces.AbstractFactory;
import com.ivucenter.cloud.api.openstack.interfaces.PoolIF;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;
import com.ivucenter.cloud.portal.cmm.cloud.OssCloudService;

import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { 
		"file:WebContent/WEB-INF/spring/application-context.xml",
		"classpath:mybatis-context.xml"})
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
@Slf4j
public class OpenStackPortTest {
	
	@Autowired
	private OssCloudService ossCloudService;
	
	@Test
	public void test1GetPorts() {

		log.info(" ==============> start testGetPorts() ");

		List<CustomOssCloudVO> getCloudList = ossCloudService.getCloudList();
	  	getCloudList.forEach(cloudVo -> {
			PoolIF apiIF = AbstractFactory.getPoolIF(cloudVo.getAdminProject(), cloudVo);
			assertNotNull("RouterIF 객체 생성 실패", apiIF);
	
//			try {
//				List<Alarm> alarmList = apiIF.getPool(cloudVo);
//				assertNotNull("라우터 정보 리스트를 가져오지 못함", alarmList);		
//				alarmList.forEach(obj -> { log.info(" Router : {}", obj.toString()); });
//				
//			} catch (NotConnectGatewayException|NotSupportGatewayException|InvaildOpenStackException e) {
//				log.error(e.getMessage());
//			}
		});

		log.info(" ==============< end   testGetPorts() ");
	}

	@Test
	public void test2GetPort() {
		fail("Not yet implemented");
	}

}
