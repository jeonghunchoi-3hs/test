package com.ivucenter.cloud.api.openstack.object;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

@JsonPropertyOrder({"OS-EXT-IPS-MAC:mac_addr","version","addr","OS-EXT-IPS:type"})
public class Address {

	@JsonProperty("OS-EXT-IPS-MAC:mac_addr")
	private String mac_addr;
	private Integer version;
	private String addr;
	@JsonProperty("OS-EXT-IPS:type")
	private String type;
	
	@JsonProperty("OS-EXT-IPS-MAC:mac_addr")
	public String getMac_addr() {
		return mac_addr;
	}
	@JsonProperty("OS-EXT-IPS-MAC:mac_addr")
	public void setMac_addr(String mac_addr) {
		this.mac_addr = mac_addr;
	}
	public Integer getVersion() {
		return version;
	}
	public void setVersion(Integer version) {
		this.version = version;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	
	@JsonProperty("OS-EXT-IPS:type")
	public String getType() {
		return type;
	}
	@JsonProperty("OS-EXT-IPS:type")
	public void setType(String type) {
		this.type = type;
	}
	
	
	
}
