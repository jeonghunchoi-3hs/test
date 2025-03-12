package com.ivucenter.cloud.api.openstack.interfaces;

import java.util.List;

import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.api.openstack.object.NetworkQuota;

public interface NetworkQuotaIF {

	public NetworkQuota createNetworkQuota(String name, boolean enabled, String description) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public NetworkQuota getNetworkQuota(String project_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public NetworkQuota updateNetworkQuota(String project_id, NetworkQuota networkQuota) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public boolean deleteNetworkQuota(String quota_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public List<NetworkQuota> getNetworkQuotas() throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public boolean isExist(String name) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
}
