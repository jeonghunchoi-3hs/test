package com.ivucenter.cloud.api.vRealize.interfaces;

import java.util.List;

import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.api.vRealize.object.vraComputeNetwork;
import com.ivucenter.cloud.api.vRealize.object.vraFabricNetworkVsphere;
import com.ivucenter.cloud.api.vRealize.object.vraFabricNetworks;
import com.ivucenter.cloud.api.vRealize.object.vraNetwork;
import com.ivucenter.cloud.api.vRealize.object.vraNetworkInterfaces;

public interface vraNetworkIF {
	public List<vraNetwork> getNetworks() 
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	
	public vraNetworkInterfaces getNetworks(String machineId,String interfaceId) 
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	
	public vraFabricNetworks getFabricNetworks() 
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	
	public vraFabricNetworkVsphere getFabricNetworksVsphere() 
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;

	public vraComputeNetwork getComputeNetworks(String network)
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;;
}
