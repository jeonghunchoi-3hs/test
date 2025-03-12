package com.ivucenter.cloud.api.vRealize.interfaces;

import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.api.vRealize.connector.vraRestResponse;
import com.ivucenter.cloud.api.vRealize.object.vraJsonObject;
import com.ivucenter.cloud.api.vRealize.object.vraMachine;
import com.ivucenter.cloud.api.vRealize.object.vraServer;
import com.ivucenter.cloud.api.vRealize.object.vraServerObject;
import com.ivucenter.cloud.api.vRealize.object.vraServerRequest;
import com.ivucenter.cloud.api.vRealize.object.vraZone;

public interface vraServerIF {
	public vraRestResponse createServer(vraServerObject VraServerObject,String catalogId) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public vraServer getServer(String depId) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public vraServer deleteServer() throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public vraServerRequest getServerRequest(String depId,String requestId) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public vraServer getDepInfo(String depId) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public vraJsonObject actionServer(String vmUuid, String action) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public vraJsonObject tracker(String trackerId)  throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public vraMachine getMachine(String machineId) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public vraMachine getMachines() throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public vraJsonObject changeMachine(String machineId,String flavorId) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public vraJsonObject detachDisk(String machineId, String diskId) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public vraJsonObject deleteVm(String vmUuid) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public vraServer getServers(String projectId) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public vraZone getZones() throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
}
