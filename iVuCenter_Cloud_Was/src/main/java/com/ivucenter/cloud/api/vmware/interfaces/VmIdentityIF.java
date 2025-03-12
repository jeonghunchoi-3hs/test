package com.ivucenter.cloud.api.vmware.interfaces;

import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;

public interface VmIdentityIF {
	public String getToken(CustomOssCloudVO cloudVo) 
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
}
