package com.ivucenter.cloud.api.vmware.object;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class DiskBacking {
	@JsonProperty("type")
	private String type;
	@JsonProperty("vmdk_file")
	private String vmdkFile;

	
	
}
