package com.ivucenter.cloud.api.openstack.interfaces;

import java.util.List;

import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;

public interface VmwareLibraryIF {


	public List<String> getLibrary(String string, String token)
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;


	public List<String> getLibraries()
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;


	public List<String> getDetailItem(String libraryId, String token)
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;




}
