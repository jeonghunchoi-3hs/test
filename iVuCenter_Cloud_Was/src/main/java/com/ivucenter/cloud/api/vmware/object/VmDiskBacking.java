package com.ivucenter.cloud.api.vmware.object;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class VmDiskBacking {
	
	@JsonProperty("vmdk_file")
	private String vmdkFile;
	private String type;
	
}
