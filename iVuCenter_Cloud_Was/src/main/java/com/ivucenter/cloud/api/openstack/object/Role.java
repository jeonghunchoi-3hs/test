package com.ivucenter.cloud.api.openstack.object;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Role {
	private String id;
	private String name;
	private String domain_id;
}
