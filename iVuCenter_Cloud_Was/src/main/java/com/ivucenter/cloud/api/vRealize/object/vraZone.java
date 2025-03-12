package com.ivucenter.cloud.api.vRealize.object;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class vraZone {
	private List<vraZone> content; 
	private String externalRegionId;
	private String cloudAccountId;
	private String name;
	private String id;
	private String organizationId;
	private String orgId;
}
