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
import com.ivucenter.cloud.api.openstack.interfaces.ImageIF;
import com.ivucenter.cloud.api.openstack.object.Image;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;
import com.ivucenter.cloud.portal.cmm.cloud.OssCloudService;

import lombok.extern.slf4j.Slf4j;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { 
		"file:WebContent/WEB-INF/spring/application-context.xml",
		"classpath:mybatis-context.xml" 
		})
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
@Slf4j
public class OpenStackImageTest {

	@Autowired
	private OssCloudService ossCloudService;
	
	@Test
	public void test1GetImages() {

		log.info(" ==============> start test1GetImages() ");
		List<CustomOssCloudVO> getCloudList = ossCloudService.getCloudList();
	  	getCloudList.forEach(cloudVo -> {
	  		ImageIF apiIF = AbstractFactory.getImageIF(cloudVo);
			assertNotNull("RouterIF 객체 생성 실패", apiIF);
			
			try {
				List<Image> imageList = apiIF.getImages();
				assertNotNull("이미지 정보 리스트를 가져오지 못함", imageList);
				imageList.forEach(obj -> { log.info(" Image : {}", obj.toString()); });
			
			} catch (NotConnectGatewayException|NotSupportGatewayException|InvaildOpenStackException e) {
				log.error(e.getMessage());
			}
	  	});
		
		log.info(" ==============< end   test1GetImages() ");
	}
}
