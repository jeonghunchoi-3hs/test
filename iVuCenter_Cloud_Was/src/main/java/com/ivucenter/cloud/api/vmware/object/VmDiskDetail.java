package com.ivucenter.cloud.api.vmware.object;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class VmDiskDetail {
	private String label;
	private String type;
	private String capacity;
	private VmDiskBacking backing;
}
