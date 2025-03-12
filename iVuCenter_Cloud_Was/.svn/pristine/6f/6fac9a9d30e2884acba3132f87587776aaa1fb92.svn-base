package com.ivucenter.cloud.api.vmware;

import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.api.vmware.interfaces.VmAbstractFactory;
import com.ivucenter.cloud.api.vmware.interfaces.VmIdentityIF;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;

public class VMWareTokenManager {
private static int EXPIRE_BEFORE_MIN = 10;	
	
	// Admin token
	private static String token;
	
	public static synchronized String getToken(CustomOssCloudVO cloudVo) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		VmIdentityIF Vmidentity = VmAbstractFactory.getIdentity(cloudVo);
		token = Vmidentity.getToken(cloudVo);
		
		return token;
	}	
	/*private static boolean isAdminExpired(String key) {		
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
	}*/
}
