package com.ivucenter.cloud.api;

import static org.junit.Assert.assertEquals;

import org.junit.Test;

import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.api.openstack.interfaces.AbstractFactory;
import com.ivucenter.cloud.api.openstack.object.OpenStackJsonObject;
import com.ivucenter.cloud.api.openstack.object.RequestAuth;

public class getIdentity {
	
	private final AbstractFactory abstractFactory = new AbstractFactory();
	

	@Test
	public void getIdentity() throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException{
		RequestAuth auth = new RequestAuth("admin", "admin", "483af1cbe4f6421b");
		//assertAll(auth, ()->assertEquals("admin", auth.getIdentity()))
		OpenStackJsonObject inJson = new OpenStackJsonObject();
		assertEquals(0,1);
		inJson.setAuth(auth);
	}

}
