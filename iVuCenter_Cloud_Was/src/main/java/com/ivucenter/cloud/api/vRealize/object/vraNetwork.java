package com.ivucenter.cloud.api.vRealize.object;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class vraNetwork {
	private String cidr;
	private List<vraNetworkTags> tags;
	private String externalRegionId;
	private String[] cloudAccountIds;
	private String externalId;
	private String name;
	private String id;
	private String updatedAt;
	private String organizationId;
	private String orgId;
	private List<vraNetwork> content;
}
