package com.ivucenter.cloud.api.vmware.object;
import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class VmwareDetailsItemJsonObject {
	
	
	
	@JsonProperty("value")
	private VmwareItemJsonObject value;
	
}
