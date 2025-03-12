package com.ivucenter.cloud.api.vRealize;

import java.util.HashMap;
import java.util.Map;

import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.api.vRealize.interfaces.vraAbstractFactory;
import com.ivucenter.cloud.api.vRealize.interfaces.vraIdentityIF;
import com.ivucenter.cloud.api.vRealize.object.vraTokenJsonObject;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;

public class vrealizeTokenManager {
	
	private static int EXPIRE_BEFORE_MIN = 10;	
	
	//token
	private static Map<String, vraTokenJsonObject> ADMIN_TOKEN = new HashMap<String, vraTokenJsonObject>();
	
	public static synchronized vraTokenJsonObject getToken(CustomOssCloudVO cloudVo) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		if (isExpired(cloudVo.getCloudId())) {
			vraIdentityIF identity = vraAbstractFactory.getIdentity(cloudVo);
			ADMIN_TOKEN.put(cloudVo.getCloudId(),identity.getToken(cloudVo));
		}
		return ADMIN_TOKEN.get(cloudVo.getCloudId());
	}	
	
	private static boolean isExpired(String key) {		
		if (!ADMIN_TOKEN.containsKey(key)) { return true; }

		long expireDate = Long.parseLong(ADMIN_TOKEN.get(key).getExpiresIn());
		
		
		
		long nowDate = System.currentTimeMillis();
		
		long limitTime = expireDate - nowDate;
		return ( limitTime < 0 );
	}
}
