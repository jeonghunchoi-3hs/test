package com.ivucenter.cloud.api.openstack.interfaces;

import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.api.openstack.object.QuotaSet;

public interface ServerQuotaIF {

	public QuotaSet getServerQuota(String project_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public QuotaSet updateServerQuota(String project_id, QuotaSet quotaSet) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
}
