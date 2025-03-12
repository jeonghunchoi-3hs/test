package com.ivucenter.cloud.api.vRealize.object;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class vraNetworkCustomProperties {
	private String network;
	@JsonProperty("mac_address")
	private String macAddress;
}
