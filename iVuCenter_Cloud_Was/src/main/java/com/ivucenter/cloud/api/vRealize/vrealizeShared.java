package com.ivucenter.cloud.api.vRealize;

import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.api.vRealize.object.vraTokenJsonObject;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;

public class vrealizeShared {
	protected CustomOssCloudVO cloudVo;

	public String getAdminToken(CustomOssCloudVO cloudVo) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		
		vraTokenJsonObject token = vrealizeTokenManager.getToken(cloudVo);
	
		return token.getToken();
		
	}
}
