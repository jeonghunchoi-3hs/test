package com.ivucenter.cloud.api.vmware.object;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class VmNicsValue {
	@JsonProperty("start_connected")
	private String startConnected;
	@JsonProperty("pci_slot_number")
	private String pciSlotNumber;
	private VmNicsBacking backing; 
	@JsonProperty("mac_address")
	private String macAddress;
	@JsonProperty("mac_type")
	private String macType;
	@JsonProperty("allow_guest_control")
	private String allowGuestControl;
	@JsonProperty("wake_on_lan_enabled")
	private String wakeOnLanEnabled;
	private String label;
	private String state;
	private String type;
	@JsonProperty("upt_compatibility_enabled")
	private String uptCompatibilityEnabled;
}
