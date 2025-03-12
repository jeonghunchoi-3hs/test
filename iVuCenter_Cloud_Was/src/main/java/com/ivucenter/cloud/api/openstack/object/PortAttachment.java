package com.ivucenter.cloud.api.openstack.object;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PortAttachment {

	private String portId;
	private String networkId;
	private String fixedIp;
	private String serverId;

	/////////// openstack api
	private String id;
	private String net_id;
	private String ip_address;
	private String mac_address;

}
