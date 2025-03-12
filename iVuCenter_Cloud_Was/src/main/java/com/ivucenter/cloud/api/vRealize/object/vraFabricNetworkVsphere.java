package com.ivucenter.cloud.api.vRealize.object;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class vraFabricNetworkVsphere {
	private List<vraFabricNetworkVsphere> content;
	private String owner;
	private String externalRegionId;
	private String defaultIpv6Gateway;
	private String externalId;
	private String defaultGateway;
	private String orgId;
	private String organizationId;
	private String createdAt;
	private String ipv6Cidr;
	private String isDefault;
	private String domain;
	private String dnsServerAddresses[];
	private String name;
	private String isPublic;
	private String cidr;
	private String id;
	private String dnsSearchDomains[];
}
