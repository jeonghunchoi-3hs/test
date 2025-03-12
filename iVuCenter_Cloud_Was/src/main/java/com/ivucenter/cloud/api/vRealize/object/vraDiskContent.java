package com.ivucenter.cloud.api.vRealize.object;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class vraDiskContent {
	private String capacityInGB;
	private String status;
	private String type;
	private String persistent;
	private String projectId;
	private String externalZoneId;
	private String externalRegionId;
	private String[] cloudAccountIds;
	private String provisioningStatus;
	private vraCustomDiskProperties customProperties;
	private String externalId;
	private String name;
	private String id;
	private String createdAt;
	private String updatedAt;
	private String owner;
	private String organizationId;
	private String orgId;
}
