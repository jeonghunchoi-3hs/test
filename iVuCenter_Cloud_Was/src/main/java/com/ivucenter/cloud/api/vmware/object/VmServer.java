package com.ivucenter.cloud.api.vmware.object;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class VmServer {
	private String name;
	@JsonProperty("disk_storage")
	private VmDiskStorage diskStorage;
	private VmPlacement placement;
	@JsonProperty("hardware_customization")
	private VmHardwareCustomization hardwareCustomization;
	@JsonProperty("powered_on")
	private boolean poweredOn;
	
	
}
