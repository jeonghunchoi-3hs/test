package com.ivucenter.cloud.api.openstack.object;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonPropertyOrder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@JsonPropertyOrder({ "status", "external_gateway_info", "availability_zone_hints", "availability_zones", "description",
		"admin_state_up", "tenant_id", "created_at", "distributed", "updated_at", "project_id", "flavor_id",
		"revision_number", "routes", "ha", "id", "name" })
public class Router {
	private String status;
	private GatewayInfo external_gateway_info;
	private List<String> availability_zone_hints;
	private List<String> availability_zones;
	private String description;
	private Boolean admin_state_up;
	private String tenant_id;
	private String created_at;
	private Boolean distributed;
	private String updated_at;
	private String project_id;
	private String flavor_id;
	private Integer revision_number;
	private List<String> routes;
	private Boolean ha;
	private String id;
	private String name;
}
