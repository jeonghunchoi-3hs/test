package com.ivucenter.cloud.api.vmware.object;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class VmHardwareCustomization {
	
	@JsonProperty("cpu_update")
	private VmCpuUpdate cpuUpdate;
	
	@JsonProperty("memory_update")
	private VmMemoryUpdate memoryUpdate;
	
	@JsonProperty("disks_to_update")
	private List<VmDiskToUpdate> diskToUpdate;
	
}
