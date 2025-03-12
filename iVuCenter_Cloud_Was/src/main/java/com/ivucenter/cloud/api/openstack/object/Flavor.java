package com.ivucenter.cloud.api.openstack.object;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

import lombok.ToString;
@ToString
@JsonPropertyOrder({"name","links","ram","OS-FLV-DISABLED:disabled","vcpus","swap","os-flavor-access:is_public","rxtx_factor","OS-FLV-EXT-DATA:ephemeral","disk","id"})
public class Flavor {
	private String name;
	private List<Link> links;
	private Integer ram;
	@JsonProperty("OS-FLV-DISABLED:disabled")
	private Boolean OS_FLV_DISABLED_disabled;
	private Integer vcpus;
	private String swap;
	@JsonProperty("os-flavor-access:is_public")
	private Boolean os_flavor_access_is_public;
	private Float rxtx_factor;
	@JsonProperty("OS-FLV-EXT-DATA:ephemeral")
	private Integer OS_FLV_EXT_DATA_ephemeral;
	private Integer disk;
	private String id;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public List<Link> getLinks() {
		return links;
	}

	public void setLinks(List<Link> links) {
		this.links = links;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getRam() {
		return ram;
	}

	public void setRam(Integer ram) {
		this.ram = ram;
	}

	@JsonProperty("OS-FLV-DISABLED:disabled")
	public Boolean getOS_FLV_DISABLED_disabled() {
		return OS_FLV_DISABLED_disabled;
	}

	@JsonProperty("OS-FLV-DISABLED:disabled")
	public void setOS_FLV_DISABLED_disabled(Boolean oS_FLV_DISABLED_disabled) {
		OS_FLV_DISABLED_disabled = oS_FLV_DISABLED_disabled;
	}

	public Integer getVcpus() {
		return vcpus;
	}

	public void setVcpus(Integer vcpus) {
		this.vcpus = vcpus;
	}

	public String getSwap() {
		return swap;
	}

	public void setSwap(String swap) {
		this.swap = swap;
	}

	@JsonProperty("os-flavor-access:is_public")
	public Boolean getOs_flavor_access_is_public() {
		return os_flavor_access_is_public;
	}

	@JsonProperty("os-flavor-access:is_public")
	public void setOs_flavor_access_is_public(Boolean os_flavor_access_is_public) {
		this.os_flavor_access_is_public = os_flavor_access_is_public;
	}

	public Float getRxtx_factor() {
		return rxtx_factor;
	}

	public void setRxtx_factor(Float rxtx_factor) {
		this.rxtx_factor = rxtx_factor;
	}

	@JsonProperty("OS-FLV-EXT-DATA:ephemeral")
	public Integer getOS_FLV_EXT_DATA_ephemeral() {
		return OS_FLV_EXT_DATA_ephemeral;
	}

	@JsonProperty("OS-FLV-EXT-DATA:ephemeral")
	public void setOS_FLV_EXT_DATA_ephemeral(Integer oS_FLV_EXT_DATA_ephemeral) {
		OS_FLV_EXT_DATA_ephemeral = oS_FLV_EXT_DATA_ephemeral;
	}

	public Integer getDisk() {
		return disk;
	}

	public void setDisk(Integer disk) {
		this.disk = disk;
	}

}
