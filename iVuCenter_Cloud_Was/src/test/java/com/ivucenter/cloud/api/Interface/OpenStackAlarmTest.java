package com.ivucenter.cloud.api.Interface;

import static org.junit.Assert.assertNotEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.util.List;

import org.apache.commons.lang.RandomStringUtils;
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
import com.ivucenter.cloud.api.openstack.interfaces.AlarmIF;
import com.ivucenter.cloud.api.openstack.object.Alarm;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;
import com.ivucenter.cloud.portal.cmm.cloud.OssCloudService;

import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { 
		"file:WebContent/WEB-INF/spring/application-context.xml",
		"classpath:mybatis-context.xml" })
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
@Slf4j
public class OpenStackAlarmTest {
	
	@Autowired
	private OssCloudService ossCloudService;
	
	private static String alarmName = "";
	private static String alarmId = "";

	@Test
	public void T1_GetAlarms() {
		
		log.info(" ==============> start test02GetRouters() ");
		
	  	List<CustomOssCloudVO> getCloudList = ossCloudService.getCloudList();
	  	getCloudList.forEach(cloudVo -> {

			AlarmIF apiIF = AbstractFactory.getAlarmIF(cloudVo.getAdminProject(), cloudVo);
			assertNotNull("RouterIF 객체 생성 실패", apiIF);
	
			try {
				List<Alarm> alarmList = apiIF.getAlarms();
				assertNotNull("라우터 정보 리스트를 가져오지 못함", alarmList);
				alarmList.forEach(alarm -> {
					log.info(" Router : {}", alarm.toString());
				});				
			} catch (NotConnectGatewayException|NotSupportGatewayException|InvaildOpenStackException e) {
				log.error(e.getMessage());
			}
	
			log.info(" ==============< end   test02GetRouters() ");
	  	});
	}

	@Test
	public void T2_CreateAlarm() {

		log.info(" ==============> start test2CreateAlarm() ");

		// 새로 생성할 알람 정보
		OpenStackAlarmTest.alarmName = "JUnit_" + RandomStringUtils.randomAlphabetic(7);
		log.info(" Alarm Name : {}", OpenStackAlarmTest.alarmName);
		assertNotEquals("Alarm name을 생성하지 못함", "", OpenStackAlarmTest.alarmName);
		Alarm alarm = new Alarm();
		alarm.setName(OpenStackAlarmTest.alarmName);
		
		// api를 사용한 openstack 객체 생성
		List<CustomOssCloudVO> getCloudList = ossCloudService.getCloudList();
	  	getCloudList.forEach(cloudVo -> {
			AlarmIF apiIF = AbstractFactory.getAlarmIF(cloudVo.getAdminProject(), cloudVo);
			assertNotNull("AlarmIF 객체 생성 실패", apiIF);
			try {
				Alarm resultAlarm = apiIF.createAlarm(alarm);
				log.info("new alarm : {} ", resultAlarm.toString());
						
				OpenStackAlarmTest.alarmId = resultAlarm.getAlarm_id();
				assertNotEquals("Alarm ID 정보 없음", "", OpenStackAlarmTest.alarmId);
				
			} catch (NotConnectGatewayException|NotSupportGatewayException|InvaildOpenStackException e) {
				log.error(e.getMessage());
			}
	  	});
		log.info(" ==============< end   test2CreateAlarm() ");				
	}

	@Test
	public void T3_GetAlarm() {

		log.info(" ==============> start test3GetAlarm() ");
		
		List<CustomOssCloudVO> getCloudList = ossCloudService.getCloudList();
	  	getCloudList.forEach(cloudVo -> {
	  		AlarmIF apiIF = AbstractFactory.getAlarmIF(cloudVo.getAdminProject(), cloudVo);
			assertNotNull("RouterIF 객체 생성 실패", apiIF);

			try {
				Alarm getAlarm = apiIF.getAlarm(OpenStackAlarmTest.alarmId);
				assertNotNull("라우터 정보를 가져오지 못함", getAlarm);
				
				log.info(" Router : {}", getAlarm.toString());
				
			} catch (NotConnectGatewayException|NotSupportGatewayException|InvaildOpenStackException e) {
				log.error(e.getMessage());
			}
	  	});	  	

		log.info(" ==============< end   test3GetAlarm() ");
	}

//    @Ignore
//	@Test
//	public void T4_UpdateAlarm() {
//		fail("Not yet implemented");
//	}

    @Test
	public void T5_DeleteAlarm()  {
		log.info(" ==============> start test05DeleteRouter() ");
		
		List<CustomOssCloudVO> getCloudList = ossCloudService.getCloudList();
	  	getCloudList.forEach(cloudVo -> {
	  		AlarmIF apiIF = AbstractFactory.getAlarmIF(cloudVo.getAdminProject(), cloudVo);
			assertNotNull("RouterIF 객체 생성 실패", apiIF);

			try {
				Boolean result = apiIF.deleteAlarm(OpenStackAlarmTest.alarmId);
				assertTrue("라우터 삭제 실패", result);
			} catch (NotConnectGatewayException|NotSupportGatewayException|InvaildOpenStackException e) {
				log.error(e.getMessage());
			}
	  	});
		
		log.info(" ==============< end   test05DeleteRouter() ");
	}
}
