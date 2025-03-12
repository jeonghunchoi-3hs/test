package com.ivucenter.cloud.api.Interface;

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
import com.ivucenter.cloud.api.openstack.interfaces.LoadbalancerIF;
import com.ivucenter.cloud.api.openstack.object.Loadbalancer;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;
import com.ivucenter.cloud.portal.cmm.cloud.OssCloudService;

import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
		"file:WebContent/WEB-INF/spring/application-context.xml",
		"classpath:mybatis-context.xml"	})
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
@Slf4j
public class OpenStackLoadbalancerTest {

	@Autowired
	private OssCloudService ossCloudService;
	
	public String projectName = "admin";
	public String projectId = "98519874d66e456c975abf607a0614df ";
	public String loadbalancerId = "";
	public String loadbalancerNm = "";
	
	@Test
	public void test1GetLoadbalancers() {

		log.info(" ==============> start testGetLoadbalancers() ");
		List<CustomOssCloudVO> getCloudList = ossCloudService.getCloudList();
	  	getCloudList.forEach(cloudVo -> {
			LoadbalancerIF apiIF = AbstractFactory.getLoadBalancerIF(this.projectName, cloudVo);
			assertNotNull("LoadbalancerIF 객체 생성 실패",apiIF);
	
			try {
				List<Loadbalancer> LoadbalancerList = apiIF.getLoadbalancers();
				assertNotNull("Loadbalancer정보를 가져오지 못함",LoadbalancerList);	
				LoadbalancerList.forEach(obj -> { log.info(" Loadbalancer : {}", obj.toString()); });
				
			} catch (NotConnectGatewayException|NotSupportGatewayException|InvaildOpenStackException e) {
				log.error(e.getMessage());
			}
	  	});

		log.info(" ==============> end   testGetLoadbalancers() ");
	}
	
	@Test
	public void test2CreateLoadbalancer() {
		
		log.info(" ==============> start testCreateLoadbalancer() ");
		
		Loadbalancer new_loadbalancer = new Loadbalancer();		
		loadbalancerNm = "JUnit_" + RandomStringUtils.randomAlphabetic(7);
		new_loadbalancer.setName(loadbalancerNm);
		
		List<CustomOssCloudVO> getCloudList = ossCloudService.getCloudList();
	  	getCloudList.forEach(cloudVo -> {
	  		LoadbalancerIF apiIF = AbstractFactory.getLoadBalancerIF(projectName, cloudVo);
			assertNotNull("testCreateLoadbalancerIF 객체 생성 실패",apiIF);
			try {
				Loadbalancer loadbalancer  = apiIF.createLoadbalancer(new_loadbalancer);
				assertNotNull("testCreateLoadbalancer정보를 가져오지 못함",loadbalancer);
				this.loadbalancerId = loadbalancer.getId();				
			} catch (NotConnectGatewayException|NotSupportGatewayException|InvaildOpenStackException e) {
				log.error(e.getMessage());
			}
					
			log.info(" testCreateLoadbalancer : {}", this.loadbalancerId);	  		
	  	});
		
		log.info(" ==============> end   testCreateLoadbalancer() ");		
	}

	
	@Test
	public void test3GetLoadbalancer() {

		log.info(" ==============> start testGetLoadbalancer() ");
		
		List<CustomOssCloudVO> getCloudList = ossCloudService.getCloudList();
	  	getCloudList.forEach(cloudVo -> {
	  		LoadbalancerIF apiIF = AbstractFactory.getLoadBalancerIF(projectName, cloudVo);
			assertNotNull("LoadbalancerIF 객체 생성 실패",apiIF);
			try {
				Loadbalancer loadbalancer = apiIF.getLoadbalancer(this.loadbalancerId);
				assertNotNull("Loadbalancer정보를 가져오지 못함",loadbalancer);
				log.info(" Loadbalancer : {}", loadbalancer.toString());
		  	} catch (NotConnectGatewayException|NotSupportGatewayException|InvaildOpenStackException e) {
				log.error(e.getMessage());
			}
	  	});
		
		log.info(" ==============> end   testGetLoadbalancer() ");
	}

//    @Ignore
//	@Test
//	public void test4UpdateLoadbalancer() {
//		
//	}

	@Test
	public void test5DeleteLoadbalancer() {
        
		log.info(" ==============> start testDeleteLoadbalancer() ");
 
		List<CustomOssCloudVO> getCloudList = ossCloudService.getCloudList();
	  	getCloudList.forEach(cloudVo -> {
	  		LoadbalancerIF apiIF = AbstractFactory.getLoadBalancerIF("newProject", cloudVo);
			assertNotNull("testDeleteLoadbalancerIF 객체 생성 실패",apiIF);
			try {
				boolean loadbalancer  = apiIF.deleteLoadbalancer(this.loadbalancerId);
				assertNotNull("testDeleteLoadbalancer정보를 가져오지 못함",loadbalancer);		
				log.info(" testDeleteLoadbalancer : {}", loadbalancer);				
			} catch (NotConnectGatewayException|NotSupportGatewayException|InvaildOpenStackException e) {
				log.error(e.getMessage());
			}
	  	});

		log.info(" ==============> end   testDeleteLoadbalancer() ");
	}
}
