package com.ivucenter.cloud.api.vmware.object;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class VmWareJsonObject {
	
	private VmHardwareCpuVO VmHardwareCpu;
	private VmwareItemJsonObject value;
	private List<VmCdroms> cdroms;
	private VmMemory memory;
	private List<VmDisks> disks;
	@JsonProperty("power_state")
	private String powerState;
}
