package com.ivucenter.cloud.api.vmware.interfaces;

import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.api.vmware.object.VmHardwareCpuVO;


public interface VmHardwareCpuIF {
	
	public boolean updateCpu(VmHardwareCpuVO spec, String vmId) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	
}
