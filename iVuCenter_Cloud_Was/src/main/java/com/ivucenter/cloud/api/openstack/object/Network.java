package com.ivucenter.cloud.api.openstack.object;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Network {
	@JsonProperty("provider:physical_network")
	private String provider_physical_network;
	private String ipv6_address_scope;
	private Integer revision_number;
	private Boolean port_security_enabled;
	private Integer mtu;
	private String id;
	@JsonProperty("router:external")
	private Boolean router_external;
	private List<String> availability_zone_hints;
	private List<String> availability_zones;
	@JsonProperty("provider:segmentation_id")
	private Integer provider_segmentation_id;
	private String ipv4_address_scope;
	private Boolean shared;
	private String project_id;
	private String status;
	private List<String> subnets;
	private String description;
	private List<String> tags;
	private String updated_at;
	private String qos_policy_id;
	private String name;
	private Boolean admin_state_up;

	private String tenant_id;
	private String created_at;
	@JsonProperty("provider:network_type")
	private String provider_network_type;
	private String uuid;
	
	private String port;
}
