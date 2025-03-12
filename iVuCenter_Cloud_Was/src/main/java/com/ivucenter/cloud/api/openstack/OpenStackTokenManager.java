package com.ivucenter.cloud.api.openstack;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;
import java.util.TimeZone;

import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.api.openstack.interfaces.AbstractFactory;
import com.ivucenter.cloud.api.openstack.interfaces.IdentityIF;
import com.ivucenter.cloud.api.openstack.object.Token;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;

public class OpenStackTokenManager {
	
	private static int EXPIRE_BEFORE_MIN = 10;	
	
	// Admin token
	private static Map<String, Token> ADMIN_TOKEN = new HashMap<String, Token>();
	public static synchronized Token getAdminToken(CustomOssCloudVO cloudVo) 
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		if (isAdminExpired(cloudVo.getCloudId())) {
			IdentityIF identity = AbstractFactory.getIdentity(cloudVo);
			
			ADMIN_TOKEN.put(cloudVo.getCloudId(), 
					identity.getToken(cloudVo.getAdminProject(), 
									  cloudVo.getAdminUsername(),
									  cloudVo.getAdminPassword()));
		}
		return ADMIN_TOKEN.get(cloudVo.getCloudId());
	}	
	private static boolean isAdminExpired(String key) {		
		if (!ADMIN_TOKEN.containsKey(key)) { return true; }
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'hh:mm:ss.SSS'Z'");
		sdf.setTimeZone(TimeZone.getTimeZone("GMT"));
		long expireDate;
		try {			
			expireDate = sdf.parse(ADMIN_TOKEN.get(key).getExpires_at()).getTime();
		} catch (ParseException e) {
			return true;
		}
		long nowDate = System.currentTimeMillis();
		long limitTime = expireDate - nowDate - (EXPIRE_BEFORE_MIN * 60000);
		return ( limitTime < 0 );
	}
	
	
	// admin project token
	private static Map<String, Token> PROJECT_ADMIN_TOKEN = new HashMap<String, Token>();
	public static synchronized Token getAdminToken(CustomOssCloudVO cloudVo, String project_name) 
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		
		final String key = cloudVo.getCloudId()+project_name;
		if (isProjectAdminExpired(key)) {
			IdentityIF identity = AbstractFactory.getIdentity(cloudVo);
			
			PROJECT_ADMIN_TOKEN.put(key, 
					identity.getToken(project_name, 
							cloudVo.getAdminUsername(),
							cloudVo.getAdminPassword()));
		}
		return PROJECT_ADMIN_TOKEN.get(key);
	}
	private static boolean isProjectAdminExpired(String key) {		
		if (!PROJECT_ADMIN_TOKEN.containsKey(key)) {return true; }
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'hh:mm:ss.SSS'Z'");
		sdf.setTimeZone(TimeZone.getTimeZone("GMT"));
		long expireDate;
		try {
			expireDate = sdf.parse(PROJECT_ADMIN_TOKEN.get(key).getExpires_at()).getTime();
		} catch (ParseException e) {
			return true;
		}
		long nowDate = System.currentTimeMillis();
		long limitTime = expireDate - nowDate - (EXPIRE_BEFORE_MIN * 60000);
		return ( limitTime < 0 );
	}
	
	private static Map<String, Token> PROJECT_TOKEN = new HashMap<String, Token>();
	public static synchronized Token getProjectToken(CustomOssCloudVO cloudVo, String project_name) 
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		
		final String key = cloudVo.getCloudId() + project_name;		
		if (isProjectExpired(key)) {						
			IdentityIF identity = AbstractFactory.getIdentity(cloudVo);			
			PROJECT_TOKEN.put(key, 
					identity.getToken(project_name, 
							cloudVo.getProjectUsername(), 
							cloudVo.getProjectPassword()));
		}
		return PROJECT_TOKEN.get(key);
	}
	private static boolean isProjectExpired(String key) {		
		if (!PROJECT_TOKEN.containsKey(key)) { return true; }
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'hh:mm:ss.SSS'Z'");
		sdf.setTimeZone(TimeZone.getTimeZone("GMT"));
		long expireDate;
		try {
			expireDate = sdf.parse(PROJECT_TOKEN.get(key).getExpires_at()).getTime();
		} catch (ParseException e) {
			return true;
		}
		long nowDate = System.currentTimeMillis();
		long limitTime = expireDate - nowDate - (EXPIRE_BEFORE_MIN * 60000);
		return ( limitTime < 0 );
	}
}
