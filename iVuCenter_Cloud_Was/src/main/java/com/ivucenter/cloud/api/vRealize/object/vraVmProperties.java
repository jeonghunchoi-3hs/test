package com.ivucenter.cloud.api.vRealize.object;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class vraVmProperties {
	private String resourceId;
	private String resourceDescLink;
	private String provisionGB;
	private String powerState;
	private String zone;
	private String environmentName;
	private String hasSnapshots;
	private String computeHostType;
	private String id;
	private String memoryGB;
	private String cpuCount;
	private String image;
	private String totalMemoryMB;
	private String endpointType;
	private String resourceName;
	private String flavor;
	private String softwareName;
	private String name;
	private String resourceLink;
	private String region;
	
	private vraStorage storage;
	private List<vraNetworks> networks;
	
	private String providerId;
	private String osType;
	private String instanceUUID;
	private String resourcePool;
	private String componentType;
	private String address;
	private String endpointId;
	private String datacenter;
	private String datastoreName;
	private String primaryMAC;
	private String computeHostRef;
	private String flavorMappingName;
	private String account;
	private String vcUuid;
}
