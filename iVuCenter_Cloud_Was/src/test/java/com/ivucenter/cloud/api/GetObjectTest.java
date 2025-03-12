package com.ivucenter.cloud.api;

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
import com.ivucenter.cloud.api.openstack.interfaces.FlavorIF;
import com.ivucenter.cloud.api.openstack.interfaces.HypervisorIF;
import com.ivucenter.cloud.api.openstack.interfaces.IdentityIF;
import com.ivucenter.cloud.api.openstack.interfaces.NetworkIF;
import com.ivucenter.cloud.api.openstack.interfaces.PoolIF;
import com.ivucenter.cloud.api.openstack.interfaces.PortIF;
import com.ivucenter.cloud.api.openstack.interfaces.ProjectIF;
import com.ivucenter.cloud.api.openstack.interfaces.RoleIF;
import com.ivucenter.cloud.api.openstack.interfaces.RouterIF;
import com.ivucenter.cloud.api.openstack.interfaces.ServerIF;
import com.ivucenter.cloud.api.openstack.interfaces.SubnetIF;
import com.ivucenter.cloud.api.openstack.interfaces.UserIF;
import com.ivucenter.cloud.api.openstack.object.Flavor;
import com.ivucenter.cloud.api.openstack.object.Hypervisor;
import com.ivucenter.cloud.api.openstack.object.Network;
import com.ivucenter.cloud.api.openstack.object.Pool;
import com.ivucenter.cloud.api.openstack.object.Port;
import com.ivucenter.cloud.api.openstack.object.Project;
import com.ivucenter.cloud.api.openstack.object.Role;
import com.ivucenter.cloud.api.openstack.object.Router;
import com.ivucenter.cloud.api.openstack.object.Server;
import com.ivucenter.cloud.api.openstack.object.Subnet;
import com.ivucenter.cloud.api.openstack.object.Token;
import com.ivucenter.cloud.api.openstack.object.User;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;
import com.ivucenter.cloud.portal.cmm.cloud.OssCloudService;

import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
		"file:WebContent/WEB-INF/spring/application-context.xml",
		"classpath:mybatis-context.xml"	})
/*
 * @TestPropertySource({ "classpath:application.properties" // ,
 * "classpath:log4sql.properties", "classpath:log4j.properties" })
 */
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
@Slf4j
public class GetObjectTest {
			
	
//	@Autowired
//	private SqlSessionFactory sqlSessionFactory;
//	
//	@Autowired
//	private OpenStackInfo openStackInfo;
//
//	@Value("${openStack.adminProject}")
//	private String projectName;
//	
//	@Value("${openStack.adminUsername}")
//	private String userName;
//	
//	@Value("${openStack.adminPassword}")
//	private String userPassword;
	
	@Autowired
	private OssCloudService ossCloudService;
	
	// Identity server
	@Test(timeout=2000)
	public void getToken() {		
		log.info(" ==============> start getToken() ");		
		
		List<CustomOssCloudVO> getCloudList = ossCloudService.getCloudList();
	  	getCloudList.forEach(cloudVo -> {
			IdentityIF identity = AbstractFactory.getIdentity(cloudVo);
			try {
				Token token = identity.getToken(cloudVo.getAdminProject(), cloudVo.getAdminUsername(), cloudVo.getAdminPassword());				
				log.info("Token value : {}", token.toString());
				
				assertNotNull(token);
				assertNotNull(token.getSubjectToken());		
				log.info(" ==============< end   getToken() ");	
			} catch (NotConnectGatewayException|NotSupportGatewayException|InvaildOpenStackException e) {
				log.error(e.getMessage());
			}
	  	});
	  	log.info(" ==============< end   getToken() ");	
	}
	
	@Test(timeout=2000)
	public void getUsers() {
		log.info(" ==============> start getUsers() ");
		List<CustomOssCloudVO> getCloudList = ossCloudService.getCloudList();
	  	getCloudList.forEach(cloudVo -> {
			UserIF apiIF = AbstractFactory.getUserIF(cloudVo);
			try {
				List<User> list = apiIF.getUsers();
				for (User obj : list) {
					log.info(" User : {}", obj.toString());
				}
				
				assertNotNull(apiIF);
		  	} catch (NotConnectGatewayException|NotSupportGatewayException|InvaildOpenStackException e) {
				log.error(e.getMessage());
			}
	  	});
		log.info(" ==============< end   getUsers() ");		
	}
	
	@Test(timeout=2000)
	public void getRoles() {
		log.info(" ==============> start getRoles() ");
		List<CustomOssCloudVO> getCloudList = ossCloudService.getCloudList();
	  	getCloudList.forEach(cloudVo -> {
			RoleIF apiIF = AbstractFactory.getRoleIF(cloudVo);
			try {
				List<Role> list = apiIF.getRoles();
				for (Role obj : list) {
					log.info(" Role : {}", obj.toString());
				}			
				assertNotNull(apiIF);
			} catch (NotConnectGatewayException|NotSupportGatewayException|InvaildOpenStackException e) {
				log.error(e.getMessage());
			}
	  	});
		log.info(" ==============< end   getRoles() ");
	}
	
	@Test(timeout=2000)
	public void getProjects() {
		log.info(" ==============> start getProjects() ");
		
		List<CustomOssCloudVO> getCloudList = ossCloudService.getCloudList();
	  	getCloudList.forEach(cloudVo -> {
			ProjectIF apiIF = AbstractFactory.getProject(cloudVo);
			try {
				List<Project> list = apiIF.getProjects();
				for (Project obj : list) {
					log.info(" Project : {}", obj.toString());
				}		
				assertNotNull(apiIF);
			
			} catch (NotConnectGatewayException|NotSupportGatewayException|InvaildOpenStackException e) {
				log.error(e.getMessage());
			}
	  	});
		log.info(" ==============< end   getProjects() ");	
	}
	
	// compute server
	@Test(timeout=2000)
	public void getServers() {
		log.info(" ==============> start getServers() ");
		List<CustomOssCloudVO> getCloudList = ossCloudService.getCloudList();
	  	getCloudList.forEach(cloudVo -> {
			ServerIF apiIF = AbstractFactory.getServerIF(cloudVo.getAdminProject(), cloudVo);
			try {
				List<Server> list = apiIF.getServers();
				for (Server obj : list) {
					log.info(" Server : {}", obj.toString());
				}			
				assertNotNull(apiIF);
			} catch (NotConnectGatewayException|NotSupportGatewayException|InvaildOpenStackException e) {
				log.error(e.getMessage());
			}	
	  	});
		log.info(" ==============< end   getServers() ");
	}	
	
	@Test(timeout=2000)
	public void getFlavors()  {
		log.info(" ==============> start getFlavors() ");
		List<CustomOssCloudVO> getCloudList = ossCloudService.getCloudList();
	  	getCloudList.forEach(cloudVo -> {
			FlavorIF apiIF = AbstractFactory.getFlavorIF(cloudVo);
			try {
				List<Flavor> list = apiIF.getFlavors();
				for (Flavor obj : list) {
					log.info(" Flavor : {}", obj.toString());
				}
			} catch (NotConnectGatewayException|NotSupportGatewayException|InvaildOpenStackException e) {
				log.error(e.getMessage());
			}
			assertNotNull(apiIF);
	  	});	
		log.info(" ==============< end   getFlavors() ");
	}
	
	@Test(timeout=2000)
	public void getHypervisors() {
		log.info(" ==============> start getHypervisors() ");
		List<CustomOssCloudVO> getCloudList = ossCloudService.getCloudList();
	  	getCloudList.forEach(cloudVo -> {
			HypervisorIF apiIF = AbstractFactory.getHypervisorIF(cloudVo);
			try {
				List<Hypervisor> list = apiIF.getHypervisors();
				for (Hypervisor obj : list) {
					log.info(" Hypervisor : {}", obj.toString());
				}
		  	} catch (NotConnectGatewayException|NotSupportGatewayException|InvaildOpenStackException e) {
				log.error(e.getMessage());
			}
			assertNotNull(apiIF);
	  	});
		log.info(" ==============< end   getHypervisors() ");
	}
	
	// network
	@Test(timeout=2000)
	public void getNetworks() {
		log.info(" ==============> start getNetworks() ");
		
		List<CustomOssCloudVO> getCloudList = ossCloudService.getCloudList();
	  	getCloudList.forEach(cloudVo -> {
			NetworkIF apiIF = AbstractFactory.getNetworkIF(cloudVo.getAdminProject(), cloudVo);
			try {
				List<Network> list = apiIF.getNetworks();
				for (Network obj : list) {
					log.info(" Network : {}", obj.toString());
				}
				assertNotNull(apiIF);
			} catch (NotConnectGatewayException|NotSupportGatewayException|InvaildOpenStackException e) {
				log.error(e.getMessage());
			}
	  	});
			
		log.info(" ==============< end   getNetworks() ");
	}
	
	@Test(timeout=2000)
	public void getSubnets() {
		log.info(" ==============> start getSubnets() ");
		List<CustomOssCloudVO> getCloudList = ossCloudService.getCloudList();
	  	getCloudList.forEach(cloudVo -> {
			SubnetIF apiIF = AbstractFactory.getSubnetIF(cloudVo.getAdminProject(), cloudVo);
			try {
				List<Subnet> list = apiIF.getSubnets();
				for (Subnet obj : list) {
					log.info(" Subnet : {}", obj.toString());
				}
				
				assertNotNull(apiIF);
			} catch (NotConnectGatewayException|NotSupportGatewayException|InvaildOpenStackException e) {
				log.error(e.getMessage());
			}
	  	});
		log.info(" ==============< end   getSubnets() ");
	}
	
	@Test(timeout=2000)
	public void getPorts() {
		log.info(" ==============> start getPorts() ");
		List<CustomOssCloudVO> getCloudList = ossCloudService.getCloudList();
	  	getCloudList.forEach(cloudVo -> {
			PortIF apiIF = AbstractFactory.getPortIF(cloudVo);
			try {
				List<Port> list = apiIF.getPorts();
				for (Port obj : list) {
					log.info(" Port : {}", obj.toString());
				}
				
				assertNotNull(apiIF);
			} catch (NotConnectGatewayException|NotSupportGatewayException|InvaildOpenStackException e) {
				log.error(e.getMessage());
			}
	  	});
		log.info(" ==============< end   getPorts() ");
	}
	
	@Test(timeout=2000)
	public void getPools() {
		log.info(" ==============> start getPools() ");
		List<CustomOssCloudVO> getCloudList = ossCloudService.getCloudList();
	  	getCloudList.forEach(cloudVo -> {
			PoolIF apiIF = AbstractFactory.getPoolIF(cloudVo.getAdminProject(), cloudVo);
			try {
				List<Pool> list = apiIF.getPools();
				for (Pool obj : list) {
					log.info(" Pool : {}", obj.toString());
				}
				
				assertNotNull(apiIF);
			} catch (NotConnectGatewayException|NotSupportGatewayException|InvaildOpenStackException e) {
				log.error(e.getMessage());
			}
	  	});
		log.info(" ==============< end   getPools() ");		
	}
	
	@Test(timeout=2000)
	public void getRouters() {
		log.info(" ==============> start getRouters() ");
		List<CustomOssCloudVO> getCloudList = ossCloudService.getCloudList();
	  	getCloudList.forEach(cloudVo -> {
			RouterIF apiIF = AbstractFactory.getRouterIF(cloudVo.getAdminProject(), cloudVo);
			try {
				List<Router> list = apiIF.getRouters();
				for (Router obj : list) {
					log.info(" Pool : {}", obj.toString());
				}
				
				assertNotNull(apiIF);
			} catch (NotConnectGatewayException|NotSupportGatewayException|InvaildOpenStackException e) {
				log.error(e.getMessage());
			}
	  	});
		log.info(" ==============< end   getRouters() ");
	}
	
}
