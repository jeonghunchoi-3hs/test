package com.ivucenter.cloud.api.vRealize.object;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class vraHostCustomProperties {
	private String nics;
	private String cpuGHZ;
	private String vcUuid;
	private int memoryGB;
	private String modelName;
	private String isPhysical;
	private String cpuPkgCount;
	private String manufacturer;
	private String cpuDescription;
	@JsonProperty("HOST__PNIC_COUNT")
	private String HostPnicCount;
	private String hyperThreadActive;
	@JsonProperty("MaxVCPUperInstance")
	private int maxVCPUperInstance;
	@JsonProperty("MemoryAvailableBytes")
	private Long memoryAvailableBytes;
	private String hyperThreadAvailable;
}
	
