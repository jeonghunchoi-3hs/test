package com.ivucenter.cloud.api.openstack.object;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class VolumeAttachment {

	private String device;
	private String serverId;
	private String id;
	private String volumeId;

	private String server_id;
	private String attachment_id;
	private String attached_at;
	private String host_name;
	private String volume_id;

}
