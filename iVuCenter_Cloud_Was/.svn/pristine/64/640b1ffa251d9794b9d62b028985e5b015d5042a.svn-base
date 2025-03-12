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
import com.ivucenter.cloud.api.openstack.interfaces.NetworkIF;
import com.ivucenter.cloud.api.openstack.object.Network;
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
public  class OpenStackNetworkTest  {	

	@Autowired
	private OssCloudService ossCloudService;
	
	public static String projectName = "admin";
	public static String projectId = "98519874d66e456c975abf607a0614df ";
	public static String networkId = "";
	public static String networkName = "";

	@Test
	public void test1GetNetworks() {

		log.info(" ==============> start testGetNetworks() ");
		List<CustomOssCloudVO> getCloudList = ossCloudService.getCloudList();
	  	getCloudList.forEach(cloudVo -> {
			NetworkIF apiIF = AbstractFactory.getNetworkIF(projectName, cloudVo);
			assertNotNull("NetworksIF 객체 생성 실패",apiIF);			
			try {
				List<Network> networkList = apiIF.getNetworks();			
				assertNotNull("Networks정보를 가져오지 못함",networkList);			
				networkList.forEach(obj -> { log.info(" Networks : {}", obj.toString()); });
			} catch (NotConnectGatewayException|NotSupportGatewayException|InvaildOpenStackException e) {
				log.error(e.getMessage());
			}
	  	});
	  	log.info(" ==============> end   testGetNetworks() ");
	}
	
	@Test
	public void test2CreateNetwork() {
		log.info(" ==============> start testCreateNetwork() ");
		
		Network new_network = new Network();		
		networkName = "JUnit_" + RandomStringUtils.randomAlphabetic(7);		
		new_network.setName(networkName);
		new_network.setAdmin_state_up(true);
		new_network.setProject_id(projectId);
		new_network.setTenant_id(projectId);
		
		List<CustomOssCloudVO> getCloudList = ossCloudService.getCloudList();
	  	getCloudList.forEach(cloudVo -> {
			NetworkIF apiIF = AbstractFactory.getNetworkIF(projectName, cloudVo);
			assertNotNull("network 객체 생성 실패",apiIF);
			
			try {
				Network Network  = apiIF.createNetwork(new_network);
				assertNotNull("network정보를 가져오지 못함",Network);
				networkId = Network.getId();
				log.info(" User : {}", Network.toString());
			} catch (NotConnectGatewayException|NotSupportGatewayException|InvaildOpenStackException e) {
				log.error(e.getMessage());
			}
	  	});
	  	
		log.info(" ==============> end   testCreateNetwork() ");
	}
	

	@Test
	public void test3GetNetwork() {
		log.info(" ==============> start testGetNetwork() ");
		List<CustomOssCloudVO> getCloudList = ossCloudService.getCloudList();
	  	getCloudList.forEach(cloudVo -> {
			NetworkIF apiIF = AbstractFactory.getNetworkIF(projectName, cloudVo);
			assertNotNull("NetworkIF 객체 생성 실패",apiIF);
			try {
				List<Network> networkList = apiIF.getNetworks();
				assertNotNull("Network정보를 가져오지 못함",networkList);		
				
				networkList.forEach(obj -> {
					try {
						Network network  = apiIF.getNetwork(obj.getId());
						assertNotNull("Network정보를 가져오지 못함",network);		
						log.info(" ==============>"+ network.toString());
					} catch (NotConnectGatewayException|NotSupportGatewayException|InvaildOpenStackException e) {
						log.error(e.getMessage());
					}
				});
			} catch (NotConnectGatewayException|NotSupportGatewayException|InvaildOpenStackException e) {
				log.error(e.getMessage());
			}
	  	});
		log.info(" ==============> end   testGetNetwork() ");
	}
	

	@Test
	public void test4DeleteNetwork() {

	    log.info(" ==============> start testDeleteNetwork() ");
	    List<CustomOssCloudVO> getCloudList = ossCloudService.getCloudList();
	  	getCloudList.forEach(cloudVo -> {
			NetworkIF apiIF = AbstractFactory.getNetworkIF(projectName, cloudVo);
			assertNotNull("network 객체 생성 실패",apiIF);
			try {
				boolean Network  = apiIF.deleteNetwork(networkId);
				assertNotNull("network정보를 가져오지 못함",Network);
				log.info(" Network : {}", Network);
		  	} catch (NotConnectGatewayException|NotSupportGatewayException|InvaildOpenStackException e) {
				log.error(e.getMessage());
			}
	  	});
		log.info(" ==============> end   testDeleteNetwork() ");		
	}
}
