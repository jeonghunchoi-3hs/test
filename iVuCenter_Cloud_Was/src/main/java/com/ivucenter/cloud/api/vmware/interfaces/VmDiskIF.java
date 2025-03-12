package com.ivucenter.cloud.api.vmware.interfaces;

import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.api.vmware.object.DiskSpec;
import com.ivucenter.cloud.api.vmware.object.VmDisks;


public interface VmDiskIF {


	public DiskSpec createDisk(DiskSpec spec, String libraryId)
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;

	public DiskSpec deleteDisk(DiskSpec spec, String libraryId)
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;

	public VmDisks getDisk()
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;

}
