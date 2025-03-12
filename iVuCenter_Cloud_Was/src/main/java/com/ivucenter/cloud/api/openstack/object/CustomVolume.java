package com.ivucenter.cloud.api.openstack.object;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CustomVolume {

	private String volume_id;
	private String display_name;
	private String project_id;
	private String size;
	private String attach_status;
	private String created_at;
	private String deleted_at;
	private String deleted;


}
