package com.ivucenter.cloud.api.openstack.interfaces;

import java.util.List;

import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.api.openstack.object.QuotaSet;
import com.ivucenter.cloud.api.openstack.object.StoragePool;
import com.ivucenter.cloud.api.openstack.object.Volume;

public interface VolumeIF {

	public List<StoragePool> getStoregPools() throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public List<Volume> getVolumes() throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public List<Volume> getAllVolumes(String filter) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public Volume getVolume(String volume_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public Volume createVolume(Volume volume) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public boolean deleteVolume(String volume_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public boolean attachVolume(String server_id, String volume_id, String mountpoint) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public boolean detachVolume(String volume_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public boolean extendVolume(String volume_id, int resize_gigabyte) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public QuotaSet getVolumeQuota(String admin_project_id, String project_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public QuotaSet updateVolumeQuota(String admin_project_id, String project_id, QuotaSet quotaSet) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
}
