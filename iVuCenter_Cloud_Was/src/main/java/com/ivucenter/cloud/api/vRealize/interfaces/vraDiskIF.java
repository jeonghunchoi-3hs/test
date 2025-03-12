package com.ivucenter.cloud.api.vRealize.interfaces;

import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.api.vRealize.object.vraAttachDisk;
import com.ivucenter.cloud.api.vRealize.object.vraBlockDevice;
import com.ivucenter.cloud.api.vRealize.object.vraDataStoreContent;
import com.ivucenter.cloud.api.vRealize.object.vraJsonObject;
import com.ivucenter.cloud.api.vRealize.object.vraMachineDisks;

public interface vraDiskIF {
	public vraMachineDisks getDiskInfo(String machineId) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public vraJsonObject createBlockDevice(vraBlockDevice blockDevice)  throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public vraJsonObject blockTracker(String trackerId)  throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public vraJsonObject attachDisk(vraAttachDisk vraAttachDisk,String MachineId) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public vraBlockDevice getBlockDevice(String deviceId) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public vraDataStoreContent getDataStores() throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public vraDataStoreContent getDataStore(String id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public vraJsonObject changeDisk(String diskId, String diskGb) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public vraJsonObject deleteDisk(String diskId) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public vraJsonObject detachDisk(String diskId,String machineId) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
}
