package com.ivucenter.cloud.api.vRealize.interfaces;

import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.api.vRealize.object.vraEntitlementsObject;
import com.ivucenter.cloud.api.vRealize.object.vraJsonObject;
import com.ivucenter.cloud.api.vRealize.object.vraProjectObject;

public interface vraProjectIF {
	public vraProjectObject createProject(vraProjectObject project) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public vraJsonObject setEntitlements(vraEntitlementsObject entitlementsObject) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	
	public vraProjectObject getProjects() throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public vraProjectObject getProject(String projectId) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	
	public vraProjectObject updateQuota(vraProjectObject project,String projectId) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
}
