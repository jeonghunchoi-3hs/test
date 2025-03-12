package com.ivucenter.cloud.portal.login;

import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import org.junit.Before;
import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = { 
		"file:WebContent/WEB-INF/spring/security-context.xml",
		"file:WebContent/WEB-INF/spring/application-context.xml",
		"file:WebContent/WEB-INF/spring/servlet-context.xml" })
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class MbrLoginControllerTest {
	
	@Autowired
	private WebApplicationContext wac;	
	
	private MockMvc mockMvc;
	
	
	@Before
	public void setupMockMvc() throws Exception {
		this.mockMvc = MockMvcBuilders
				.webAppContextSetup(this.wac)
				.build();
	}

	@Test
	public void test001MbrLoginPage() throws Exception {
		mockMvc.perform(MockMvcRequestBuilders.get("/mbr"))
			.andDo(print())
			.andExpect(status().isOk());
	}

}
