package com.ivucenter.cloud.api.Interface;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
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
import com.ivucenter.cloud.api.openstack.interfaces.ProjectIF;
import com.ivucenter.cloud.api.openstack.object.Project;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;
import com.ivucenter.cloud.portal.cmm.cloud.OssCloudService;

import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
		"file:WebContent/WEB-INF/spring/application-context.xml",
		"classpath:mybatis-context.xml"})
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
@Slf4j
public class OpenStackProjectTest {
	
	@Autowired
	private OssCloudService ossCloudService;
	
	public static String projectName = "";
	public static String projectId = "";
	
	public String userId = "a8b66dd09bd448be8d4fe6ab45561e62";
		
	@Test
	public void T1_GetProjects() {
		log.info(" ==============> start testGetProjects() ");
				
		List<CustomOssCloudVO> getCloudList = ossCloudService.getCloudList();
	  	getCloudList.forEach(cloudVo -> {
	  		ProjectIF apiIF = AbstractFactory.getProject(cloudVo);
			assertNotNull("ProjectIF 객체 생성 실패", apiIF);
			
			try {
				List<Project> projectList = apiIF.getProjects();
				assertNotNull("유저정보를 가져오지 못함", projectList);
				
				projectList.forEach(obj -> { log.info(" Project : {}", obj.toString()); });					
				
		  	} catch (NotConnectGatewayException|NotSupportGatewayException|InvaildOpenStackException e) {
				log.error(e.getMessage());
			}
	  	});		

		log.info(" ==============< end   testGetProjects() ");
	}

	@Test
	public void T2_CreateProject() {
		log.info(" ==============> start testCreateProject() ");
		
		List<CustomOssCloudVO> getCloudList = ossCloudService.getCloudList();
	  	getCloudList.forEach(cloudVo -> {
			ProjectIF apiIF = AbstractFactory.getProject(cloudVo);
			assertNotNull("ProjectIF 객체 생성 실패", apiIF);
			
			OpenStackProjectTest.projectName = "JUnit_" + RandomStringUtils.randomAlphabetic(7);
			log.info(" Project Name : {}", OpenStackProjectTest.projectName);
			assertNotEquals("project name을 생성하지 못함", "", OpenStackProjectTest.projectName);
			
			Project oriProject = new Project();
			oriProject.setName(OpenStackProjectTest.projectName);
			log.info("orignal Project : {} ", oriProject);
			try {
				Project newProject = apiIF.createProject(oriProject);
				log.info("new     Project : {} ", newProject);
				assertNotNull("Project 생성 실패 ", newProject);			
				OpenStackProjectTest.projectId = newProject.getId();
		  	} catch (NotConnectGatewayException|NotSupportGatewayException|InvaildOpenStackException e) {
				log.error(e.getMessage());
			} 
	  	});
		
		log.info(" ==============< end   testCreateProject() ");
	}

	@Test
	public void T3_GetProject() {
		
		log.info(" ==============> start testGetProject() ");
		
		assertNotEquals("Project ID 없음","", OpenStackProjectTest.projectId);		
		List<CustomOssCloudVO> getCloudList = ossCloudService.getCloudList();
	  	getCloudList.forEach(cloudVo -> {
			ProjectIF apiIF = AbstractFactory.getProject(cloudVo);
			assertNotNull("ProjectIF 객체 생성 실패", apiIF);
			try {
				assertNotNull("projectId is null", OpenStackProjectTest.projectId);
				Project getProject = apiIF.getProject(OpenStackProjectTest.projectId);
				assertNotNull("Project get 실패 ", getProject);
				
				log.info("Project : {} ", getProject);
		  	} catch (NotConnectGatewayException|NotSupportGatewayException|InvaildOpenStackException e) {
				log.error(e.getMessage());
			}
	  	});
		log.info(" ==============< end   testGetProject() ");
	}

	@Test
	public void T4_UpdateProject() {
		
		log.info(" ==============> start testGetProject() ");
		
		List<CustomOssCloudVO> getCloudList = ossCloudService.getCloudList();
	  	getCloudList.forEach(cloudVo -> {
			ProjectIF apiIF = AbstractFactory.getProject(cloudVo);
			assertNotNull("ProjectIF 객체 생성 실패", apiIF);
			try {
				Project getProject = apiIF.getProject(OpenStackProjectTest.projectId);
				assertNotNull("Project 생성 실패 ", getProject);		
				
				String desc = getProject.getDescription() + RandomStringUtils.randomAlphabetic(2);
				getProject.setDescription(desc);
				
				Project resultProject = apiIF.updateProject(getProject);
				assertEquals("Project 객체가 일치하지 않음", getProject, resultProject);
				log.info("Project : {} ", resultProject);
			} catch (NotConnectGatewayException|NotSupportGatewayException|InvaildOpenStackException e) {
				log.error(e.getMessage());
			}
	  	});
		log.info(" ==============< end   testGetProject() ");
	}

	@Test
	public void T5_DeleteProject() {
		
		log.info(" ==============> start testDeleteProject() ");
		
		List<CustomOssCloudVO> getCloudList = ossCloudService.getCloudList();
	  	getCloudList.forEach(cloudVo -> {
			ProjectIF apiIF = AbstractFactory.getProject(cloudVo);
			assertNotNull("ProjectIF 객체 생성 실패", apiIF);
			try {	
				Boolean result = apiIF.deleteProject(OpenStackProjectTest.projectId);
				assertTrue("Project 삭제 실패 ", result);
		  	} catch (NotConnectGatewayException|NotSupportGatewayException|InvaildOpenStackException e) {
				log.error(e.getMessage());
			}
		});
		log.info(" ==============< end   testDeleteProject() ");
	}

	
	@Test
	public void T6_UsersByProject() {
		
		log.info(" ==============< start   testUsersByProject() ");
		List<CustomOssCloudVO> getCloudList = ossCloudService.getCloudList();
	  	getCloudList.forEach(cloudVo -> {
			ProjectIF apiIF = AbstractFactory.getProject(cloudVo);
			// 프로젝트가 없는 userId 호출시 404 에러
			try {
				List<Project> userProjectList = apiIF.getUsersByProject(userId);
				
				userProjectList.forEach(obj->{ log.info(" Project : {}", obj.toString()); });
		  	} catch (NotConnectGatewayException|NotSupportGatewayException|InvaildOpenStackException e) {
				log.error(e.getMessage());
			}
	  	});
		log.info(" ==============< end   testUsersByProject() ");
	 }
	
	@Test
	public void T7_IsExist() {

		log.info(" ==============> start testIsExist() ");
		List<CustomOssCloudVO> getCloudList = ossCloudService.getCloudList();
	  	getCloudList.forEach(cloudVo -> {
			ProjectIF apiIF = AbstractFactory.getProject(cloudVo);
			assertNotNull("ProjectIF 객체 생성 실패", apiIF);
		
			try {
				Boolean result = apiIF.isExist(OpenStackProjectTest.projectName);
				assertFalse("삭제 후 프로젝트 존재함", result);
		  	} catch (NotConnectGatewayException|NotSupportGatewayException|InvaildOpenStackException e) {
				log.error(e.getMessage());
			}
	  	});
		log.info(" ==============< end   testIsExist() ");
	}
}
