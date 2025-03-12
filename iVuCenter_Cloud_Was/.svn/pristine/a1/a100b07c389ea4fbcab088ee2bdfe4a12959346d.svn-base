package com.ivucenter.cloud.api.vRealize.object;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class vraProjectObject {
	private List<vraProjectObject> content;
	private String name;
	private String description;
	private String machineNamingTemplate;
	private String sharedResources;
	private String operationTimeout;
	private List<vraZoneAssignmentConfigurations> zoneAssignmentConfigurations;
	private List<vraAdministrators> administrators;
	private List<vraMembers> members;
	private List<vraZones> zones;
	@JsonProperty("_links")
	private vraLinks links;
	private String id;
	private String orgId;
	private String organizationId;
}
