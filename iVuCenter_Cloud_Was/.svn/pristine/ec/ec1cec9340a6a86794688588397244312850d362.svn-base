package com.ivucenter.cloud.api.Interface;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import java.util.List;

import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.ivucenter.cloud.api.openstack.OpenStackShared;
import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.api.openstack.interfaces.AbstractFactory;
import com.ivucenter.cloud.api.openstack.interfaces.ProjectIF;
import com.ivucenter.cloud.api.openstack.interfaces.RoleIF;
import com.ivucenter.cloud.api.openstack.interfaces.UserIF;
import com.ivucenter.cloud.api.openstack.object.Project;
import com.ivucenter.cloud.api.openstack.object.Role;
import com.ivucenter.cloud.api.openstack.object.User;
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
public class OpenStackUserTest {
	
	@Autowired
	private OssCloudService ossCloudService;
	
	@Test//(timeout=10000)
	public void testGetUsers() {		
		log.info(" ==============> start testGetUsers() ");
		List<CustomOssCloudVO> getCloudList = ossCloudService.getCloudList();
	  	getCloudList.forEach(cloudVo -> {	  		
	  	
			UserIF apiIF = AbstractFactory.getUserIF(cloudVo);
			assertNotNull("UserIF 객체 생성 실패",apiIF);
			try {
				List<User> userList = apiIF.getUsers();
				assertNotNull("유저정보를 가져오지 못함",userList);		
				
				userList.forEach(obj-> { log.info(" User : {}", obj.toString()); });
			} catch (NotConnectGatewayException|NotSupportGatewayException|InvaildOpenStackException e) {
				log.error(e.getMessage());
			}
	  	});
		log.info(" ==============> end   testGetUsers() ");
	}

	@Test//(timeout=10000)
	public void testGetUser() {
		log.info(" ==============> start testGetUser() ");
		List<CustomOssCloudVO> getCloudList = ossCloudService.getCloudList();
	  	getCloudList.forEach(cloudVo -> {
			UserIF apiIF = AbstractFactory.getUserIF(cloudVo);
			assertNotNull("UserIF 객체 생성 실패",apiIF);
			try {
				List<User> userList = apiIF.getUsers();
				assertNotNull("유저정보를 가져오지 못함",userList);
				
				userList.forEach(obj->{
					try {
						User getUser = apiIF.getUser(obj.getId());
						assertEquals("유저정보가 동일하지 않음", obj, getUser);
					} catch (NotConnectGatewayException|NotSupportGatewayException|InvaildOpenStackException e) {
						log.error(e.getMessage());
					}
				});		
			} catch (NotConnectGatewayException|NotSupportGatewayException|InvaildOpenStackException e) {
				log.error(e.getMessage());
			}
	  	});
		log.info(" ==============< end   testGetUser() ");
	}

	@Test//(timeout=10000)
	public void testGetUserByName() {
		log.info(" ==============> start testGetUserByName() ");
		
		List<CustomOssCloudVO> getCloudList = ossCloudService.getCloudList();
	  	getCloudList.forEach(cloudVo -> {
			UserIF apiIF = AbstractFactory.getUserIF(cloudVo);
			assertNotNull("UserIF 객체 생성 실패",apiIF);
			try {
				List<User> userList = apiIF.getUsers();
				assertNotNull("유저정보를 가져오지 못함",userList);
				
				for (User obj : userList) {
					User getUser = apiIF.getUser(obj.getId());
					assertEquals(obj, getUser);
				}	
		  	} catch (NotConnectGatewayException|NotSupportGatewayException|InvaildOpenStackException e) {
				log.error(e.getMessage());
			}
	  	});
		log.info(" ==============< end   testGetUserByName() ");
	}

	

	@Test//(timeout=10000)
	public void testGetRoles() {
		log.info(" ==============> start testGetRoles() ");
		
		List<CustomOssCloudVO> getCloudList = ossCloudService.getCloudList();
	  	getCloudList.forEach(cloudVo -> {
			UserIF apiIF = AbstractFactory.getUserIF(cloudVo);
			assertNotNull("UserIF 객체 생성 실패",apiIF);
			try {
				List<User> userList = apiIF.getUsers();
				assertNotNull("유저정보를 가져오지 못함",userList);
				
				OpenStackShared adminInfo = new OpenStackShared();
				String token = adminInfo.getAdminToken(cloudVo);		
				assertNotNull("admin token을 가져오지 못함", token);		
				
				for(User user : userList) {
					List<Role> roles = apiIF.getRoles(adminInfo.getProjectId(), user.getId());
					assertNotNull("유저의 Role 정보를 가져오지 못함", roles);
					for(Role role : roles) {
						log.info(role.toString());
					}
				}
			} catch (NotConnectGatewayException|NotSupportGatewayException|InvaildOpenStackException e) {
				log.error(e.getMessage());
			}
	  	});
		log.info(" ==============< end   testGetRoles() ");
	}

	@Test//(timeout=10000)
	public void testAssignUserRole() {
		
		log.info(" ==============> start testAssignUserRole() ");

		List<CustomOssCloudVO> getCloudList = ossCloudService.getCloudList();
	  	getCloudList.forEach(cloudVo -> {
			ProjectIF projectApiIF = AbstractFactory.getProject(cloudVo);
			UserIF userApiIF = AbstractFactory.getUserIF(cloudVo);
			RoleIF roleApiIF = AbstractFactory.getRoleIF(cloudVo);
			assertNotNull("projectApiIF 객체 생성 실패",projectApiIF);
			assertNotNull("userApiIF 객체 생성 실패",userApiIF);
			assertNotNull("roleApiIF 객체 생성 실패",roleApiIF);
			
			try {
				Project Project = projectApiIF.getProject(cloudVo.getAdminProject());
				User member_user = userApiIF.getUserByName("demo");
				Role admin_role = roleApiIF.getRoleByName("admin");
				
				boolean assignUserRole = userApiIF.assignUserRole(Project.getId(), member_user.getId(), admin_role.getId());
			
				log.info(" ==============<" + assignUserRole);
			} catch (NotConnectGatewayException|NotSupportGatewayException|InvaildOpenStackException e) {
				log.error(e.getMessage());
			}
	  	});
		log.info(" ==============< end   testAssignUserRole() ");
	}
}
