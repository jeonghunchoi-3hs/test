package com.ivucenter.cloud.api.Interface;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNotEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.fail;

import java.util.List;

import org.apache.commons.lang.RandomStringUtils;
import org.junit.FixMethodOrder;
import org.junit.Ignore;
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
import com.ivucenter.cloud.api.openstack.interfaces.RouterIF;
import com.ivucenter.cloud.api.openstack.object.Router;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;
import com.ivucenter.cloud.portal.cmm.cloud.OssCloudService;

import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { 
		"file:WebContent/WEB-INF/spring/application-context.xml"
		, "classpath:mybatis-context.xml" 
		})
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
@Slf4j
public class OpenStackRouterTest {

	@Autowired
	private OssCloudService ossCloudService;
	
	public static String routerId = "";
	public static String routerName = "";

	@Test
	public void test01GetRouters()
			{
		log.info(" ==============> start test02GetRouters() ");

		List<CustomOssCloudVO> getCloudList = ossCloudService.getCloudList();
		  	getCloudList.forEach(cloudVo -> {
			RouterIF apiIF = AbstractFactory.getRouterIF(cloudVo.getAdminProject(), cloudVo);
			assertNotNull("RouterIF 객체 생성 실패", apiIF);
			try {
				List<Router> routerList = apiIF.getRouters();
				assertNotNull("라우터 정보 리스트를 가져오지 못함", routerList);		
				routerList.forEach(obj-> {log.info(" Router : {}", obj.toString()); });
				
		  	} catch (NotConnectGatewayException|NotSupportGatewayException|InvaildOpenStackException e) {
				log.error(e.getMessage());
			}
		});
		log.info(" ==============< end   test02GetRouters() ");
	}

	@Test
	public void test02CreateRouter()
			{
		log.info(" ==============> start test02CreateRouter() ");

		// 새로 생성할 라우터 정보
		routerName = "JUnit_" + RandomStringUtils.randomAlphabetic(7);
		log.info(" Router Name : {}", routerName);
		assertNotEquals("router name을 생성하지 못함", "", routerName);
		Router newRouter = new Router();
		newRouter.setName(routerName);
		newRouter.setDescription("API JUnit Test");		
		
		List<CustomOssCloudVO> getCloudList = ossCloudService.getCloudList();
	  	getCloudList.forEach(cloudVo -> {
			// api를 사용한 openstack 객체 생성
			RouterIF apiIF = AbstractFactory.getRouterIF(cloudVo.getAdminProject(), cloudVo);
			assertNotNull("RouterIF 객체 생성 실패", apiIF);
			try {
				Router resultRouter = apiIF.createRouter(newRouter);
				log.info("new router : {} ", resultRouter.toString());
						
				OpenStackRouterTest.routerId = resultRouter.getId();
				assertNotEquals("Router ID 정보 없음", "", OpenStackRouterTest.routerId);
			} catch (NotConnectGatewayException|NotSupportGatewayException|InvaildOpenStackException e) {
				log.error(e.getMessage());
			}
	  	});
		log.info(" ==============< end   test02CreateRouter() ");
	}

	@Test
	public void test03GetRouter()
			{
		log.info(" ==============> start test03GetRouter() ");

		List<CustomOssCloudVO> getCloudList = ossCloudService.getCloudList();
	  	getCloudList.forEach(cloudVo -> {
	  				  	
			RouterIF apiIF = AbstractFactory.getRouterIF(cloudVo.getAdminProject(), cloudVo);
			assertNotNull("RouterIF 객체 생성 실패", apiIF);
	
			try {
				Router getRouter = apiIF.getRouter(OpenStackRouterTest.routerId);
				assertNotNull("라우터 정보를 가져오지 못함", getRouter);
				assertEquals("라우터 이름 정보가 틀림", OpenStackRouterTest.routerName, getRouter.getName());
				assertEquals("라우터 ID 정보가 틀림", OpenStackRouterTest.routerId, getRouter.getId());
				log.info(" Router : {}", getRouter.toString());
			} catch (NotConnectGatewayException|NotSupportGatewayException|InvaildOpenStackException e) {
				log.error(e.getMessage());
			}			
	  	});
		log.info(" ==============< end   test03GetRouter() ");
	}

	@Ignore
	@Test
	public void test04UpdateRouter()
			{
		log.info(" ==============> start test04UpdateRouter() ");

		List<CustomOssCloudVO> getCloudList = ossCloudService.getCloudList();
	  	getCloudList.forEach(cloudVo -> {
			RouterIF apiIF = AbstractFactory.getRouterIF(cloudVo.getAdminProject(), cloudVo);
			assertNotNull("RouterIF 객체 생성 실패", apiIF);
			try {
				Router getRouter = apiIF.getRouter(OpenStackRouterTest.routerId);
				assertNotNull("라우터 정보를 가져오지 못함", getRouter);
				assertEquals("라우터 이름 정보가 틀림", OpenStackRouterTest.routerName, getRouter.getName());
				assertEquals("라우터 ID 정보가 틀림", OpenStackRouterTest.routerId, getRouter.getId());
				
				String desc = getRouter.getDescription() + "_Mod";
				getRouter.setDescription(desc);
				
				Router modRouter = apiIF.updateRouter(getRouter);
				log.info(" Router : {}", modRouter.toString());
			} catch (NotConnectGatewayException|NotSupportGatewayException|InvaildOpenStackException e) {
				log.error(e.getMessage());
			}
	  	});
		log.info(" ==============< end   test04UpdateRouter() ");
	}

	@Test
	public void test05DeleteRouter()
			{
		log.info(" ==============> start test05DeleteRouter() ");

		List<CustomOssCloudVO> getCloudList = ossCloudService.getCloudList();
	  	getCloudList.forEach(cloudVo -> {
			RouterIF apiIF = AbstractFactory.getRouterIF(cloudVo.getAdminProject(), cloudVo);
			assertNotNull("RouterIF 객체 생성 실패", apiIF);
			try {
				Boolean result = apiIF.deleteRouter(OpenStackRouterTest.routerId);		
				assertTrue("라우터 삭제 실패", result);
			} catch (NotConnectGatewayException|NotSupportGatewayException|InvaildOpenStackException e) {
				log.error(e.getMessage());
			}
	  	});
		
		log.info(" ==============< end   test05DeleteRouter() ");
	}

	@Test
	public void test06IsExist()
			{
		log.info(" ==============> start test06IsExist() ");

		List<CustomOssCloudVO> getCloudList = ossCloudService.getCloudList();
	  	getCloudList.forEach(cloudVo -> {
			RouterIF apiIF = AbstractFactory.getRouterIF(cloudVo.getAdminProject(), cloudVo);
			assertNotNull("RouterIF 객체 생성 실패", apiIF);
	
			try {
				Boolean result = apiIF.isExist(OpenStackRouterTest.routerId);		
				assertFalse("라우터 삭제 실패", result);
			} catch (NotConnectGatewayException|NotSupportGatewayException|InvaildOpenStackException e) {
				log.error(e.getMessage());
			}
	  	});
		
		log.info(" ==============< end   test06IsExist() ");
	}

	@Ignore
	@Test
	public void test08AddRouterInterfaceSubnet()
			{
		fail("Not yet implemented");
	}

	@Ignore
	@Test
	public void test09AddRouterInterfacePort()
			{
		fail("Not yet implemented");
	}

	@Ignore
	@Test
	public void test10RemoveRouterInterfaceSubnet()
			{
		fail("Not yet implemented");
	}

	@Ignore
	@Test
	public void test11RemoveRouterInterfacePort()
			{
		fail("Not yet implemented");
	}
}
