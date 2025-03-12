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
import com.ivucenter.cloud.api.openstack.interfaces.RoleIF;
import com.ivucenter.cloud.api.openstack.object.Role;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;
import com.ivucenter.cloud.portal.cmm.cloud.OssCloudService;

import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
		"file:WebContent/WEB-INF/spring/application-context.xml",
		"classpath:mybatis-context.xml"})
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
@Slf4j
public class OpenStackRoleTest {
	
	@Autowired
	private OssCloudService ossCloudService;
	
	private static String roleId = "";

	@Test
	public void test1GetRoles() {
		
		log.info(" ==============> start testGetRoles() ");
		List<CustomOssCloudVO> getCloudList = ossCloudService.getCloudList();
	  	getCloudList.forEach(cloudVo -> {
			RoleIF apiIF = AbstractFactory.getRoleIF(cloudVo);
			assertNotNull("RolesIF 객체 생성 실패",apiIF);
			try {
				List<Role> RoleList = apiIF.getRoles();
				assertNotNull("Roles정보를 가져오지 못함",RoleList);		
				
				RoleList.forEach(obj -> { log.info(" Roles : {}", obj.toString()); });
				OpenStackRoleTest.roleId = RoleList.get(0).getId();
		  	} catch (NotConnectGatewayException|NotSupportGatewayException|InvaildOpenStackException e) {
				log.error(e.getMessage());
			}
	  	});
		log.info(" ==============> end   testGetRoles() ");
	}

	@Test
	public void test2GetRole() {

		log.info(" ==============> start testGetRole() ");
		List<CustomOssCloudVO> getCloudList = ossCloudService.getCloudList();
	  	getCloudList.forEach(cloudVo -> {
			RoleIF apiIF = AbstractFactory.getRoleIF(cloudVo);
			assertNotNull("RoleIF 객체 생성 실패",apiIF);
			try {	
				List<Role> RoleList = apiIF.getRoles();
				assertNotNull("Roles정보를 가져오지 못함",RoleList);		
				
				Role role = apiIF.getRole(OpenStackRoleTest.roleId);
				log.info(" RoleIF : {}", role.toString());
		  	} catch (NotConnectGatewayException|NotSupportGatewayException|InvaildOpenStackException e) {
				log.error(e.getMessage());
			}
		});
		log.info(" ==============> end   testGetRole() ");
	}
}
