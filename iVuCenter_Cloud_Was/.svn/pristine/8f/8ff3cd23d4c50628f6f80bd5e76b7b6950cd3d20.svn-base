package com.ivucenter.cloud.api.vmware.interfaces;

import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.api.vmware.object.VmSpec;
import com.ivucenter.cloud.api.vmware.object.VmWareJsonObject;


public interface VmServerIF {
	public VmWareJsonObject getServer(String VmUuid) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public VmSpec createServer(VmSpec spec,String libraryId) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public boolean deleteServer(String vmId) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public int actionServer(String vmUuid, String action) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
}
