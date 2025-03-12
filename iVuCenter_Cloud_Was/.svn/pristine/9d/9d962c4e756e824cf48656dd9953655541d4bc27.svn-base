package com.ivucenter.cloud.api.openstack.interfaces;

import java.util.List;

import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.api.openstack.object.PortAttachment;
import com.ivucenter.cloud.api.openstack.object.Resize;
import com.ivucenter.cloud.api.openstack.object.Server;
import com.ivucenter.cloud.api.openstack.object.VolumeAttachment;

public interface ServerIF {

	public Server createServer(Server server) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public Server getServer(String server_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public Server updateServer(Server server) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public boolean deleteServer(String server_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public List<Server> getServers() throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public List<Server> getAllServers(String filter) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public boolean isExist(String name) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public List<VolumeAttachment> getVolumeAttachments(String server_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public VolumeAttachment attachVolumeAttachments(String server_id, String volume_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public boolean detachVolumeAttachments(String server_id, String volume_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public boolean actionServer(String server_id, String action) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public boolean resizeServer(Resize resize) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public PortAttachment attachPortAttachment(String server_id, String port_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public boolean detachPortAttachment(String server_id, String port_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
}
