package com.ivucenter.cloud.api.vRealize.interfaces;

import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.api.vRealize.object.vraTokenJsonObject;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;

public interface vraIdentityIF {
	public vraTokenJsonObject getToken(CustomOssCloudVO cloudVo) 
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
}
