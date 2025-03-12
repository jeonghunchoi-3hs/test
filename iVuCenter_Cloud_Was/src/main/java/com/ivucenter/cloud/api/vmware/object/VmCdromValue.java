package com.ivucenter.cloud.api.vmware.object;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class VmCdromValue {
	@JsonProperty("start_connected")
	private String startConnected;
	private VmCdromBacking backing;
	@JsonProperty("allow_guest_control")
	private String allowGuestControl;
	private String label;
	private String type;
}
