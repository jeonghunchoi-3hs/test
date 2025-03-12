package com.ivucenter.cloud.api;

import java.util.List;

import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.api.vmware.object.VmwareItemJsonObject;

public interface VmwareLibraryIF {


	public List<String> getLibrary(String string)
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;


	public List<String> getLibraries()
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;


	public VmwareItemJsonObject getDetailItem(String libraryId)
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;






}
