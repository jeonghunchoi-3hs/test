package com.ivucenter.cloud.api.vmware.object;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class VmHardwareMemSpecVO {
	
	private boolean hot_add_enabled;
	private long size_MiB;

}
