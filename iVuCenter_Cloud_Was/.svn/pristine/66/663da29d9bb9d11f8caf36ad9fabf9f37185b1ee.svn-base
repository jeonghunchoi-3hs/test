package com.ivucenter.cloud.api.vmware;

import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;

public class VMWareShared {
	protected CustomOssCloudVO cloudVo;

	public String getToken(CustomOssCloudVO cloudVo) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		
		String value = VMWareTokenManager.getToken(cloudVo);
		return value;
		
	}

}	
