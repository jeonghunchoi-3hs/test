package com.ivucenter.cloud.api.vmware.object;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class VmNicsBacking {
	@JsonProperty("network_name")
	private String networkName;
	@JsonProperty("type")
	private String type;
	private String network;
}
