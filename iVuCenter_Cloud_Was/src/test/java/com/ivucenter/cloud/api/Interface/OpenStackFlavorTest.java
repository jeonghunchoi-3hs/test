package com.ivucenter.cloud.api.Interface;

import static org.junit.Assert.assertNotEquals;
import static org.junit.Assert.assertNotNull;

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
import com.ivucenter.cloud.api.openstack.interfaces.FlavorIF;
import com.ivucenter.cloud.api.openstack.interfaces.FloatingipIF;
import com.ivucenter.cloud.api.openstack.object.Flavor;
import com.ivucenter.cloud.api.openstack.object.Floatingip;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;
import com.ivucenter.cloud.portal.cmm.cloud.OssCloudService;

import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
		"file:WebContent/WEB-INF/spring/application-context.xml",
		"classpath:mybatis-context.xml"	})
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
@Slf4j
public class OpenStackFlavorTest {	
		
	@Autowired
	private OssCloudService ossCloudService;	

	private static String flavorId = "";
	private static String flavorNm = "";

	@Test
	public void T1_GetFlavors() {
		
		log.info(" ==============> start test1GetFlavors() ");
		
		List<CustomOssCloudVO> getCloudList = ossCloudService.getCloudList();
	  	getCloudList.forEach(cloudVo -> {
	  		FlavorIF apiIF = AbstractFactory.getFlavorIF(cloudVo);
			assertNotNull("FlavorIF 객체 생성 실패",apiIF);
			
			try {
				List<Flavor> flavorList = apiIF.getFlavors();
				assertNotNull("flavor정보를 가져오지 못함",flavorList);		
				for (Flavor obj : flavorList) {
					log.info(" User : {}", obj.toString());
				}
			} catch (NotConnectGatewayException|NotSupportGatewayException|InvaildOpenStackException e) {
				log.error(e.getMessage());
			}
	  	});
	  	log.info(" ==============> end   test1GetFlavors() ");
	}
	
	@Test
	public void T2_CreateFlavor() {
		log.info(" ==============> start test2CreateFlavor() ");

		// 새로 생성할 라우터 정보
		OpenStackFlavorTest.flavorNm = "JUnit_" + RandomStringUtils.randomAlphabetic(7);

		log.info(" flavorNm Name : {}", OpenStackFlavorTest.flavorNm);
		assertNotEquals("flavorNm name을 생성하지 못함", "", OpenStackFlavorTest.flavorNm);
		Flavor flavor = new Flavor();
		flavor.setName(OpenStackFlavorTest.flavorNm);
		flavor.setRam(1);		
		flavor.setVcpus(2);		
		flavor.setDisk(10);		
				
		// api를 사용한 openstack 객체 생성
		List<CustomOssCloudVO> getCloudList = ossCloudService.getCloudList();
	  	getCloudList.forEach(cloudVo -> {
	  		FloatingipIF apiIF = AbstractFactory.getFloatingipIF(cloudVo.getAdminProject(), cloudVo);
			assertNotNull("RouterIF 객체 생성 실패", apiIF);
			try {
				Floatingip resultFloatingip = apiIF.createFloatingip(OpenStackFlavorTest.flavorNm, true, "testFloat");
				log.info("new router : {} ", resultFloatingip.toString());

				OpenStackFlavorTest.flavorId = resultFloatingip.getId();
				assertNotEquals("Router ID 정보 없음", "", OpenStackFlavorTest.flavorId);
			} catch (NotConnectGatewayException|NotSupportGatewayException|InvaildOpenStackException e) {			
				log.error(e.getMessage());
			}
	  	});

		log.info(" ==============< end   test2CreateFlavor() ");
	}
	
	@Test
	public void T3_GetFlavor() {
		log.info(" ==============> start test3GetFlavor() ");
		List<CustomOssCloudVO> getCloudList = ossCloudService.getCloudList();
	  	getCloudList.forEach(cloudVo -> {
	  		FlavorIF apiIF = AbstractFactory.getFlavorIF(cloudVo);
			assertNotNull("FlavorIF 객체 생성 실패",apiIF);
			Flavor flavor = null;
			try {
				flavor =  apiIF.getFlavor(OpenStackFlavorTest.flavorId);
				assertNotNull("flavor정보를 가져오지 못함",flavor);
			} catch (NotConnectGatewayException|NotSupportGatewayException|InvaildOpenStackException e) {
				log.error(e.getMessage());
			}					

			log.info(" ==============>"+flavor.toString());	  		
	  	});
		
		log.info(" ==============> end   test3GetFlavor() ");
	}
}
