package com.ivucenter.cloud.api.openstack.object;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

import lombok.ToString;

@ToString
@JsonPropertyOrder({ "status", "binding:host_id", "description", "allowed_address_pairs", "extra_dhcp_opts",
		"updated_at", "device_owner", "revision_number", "binding:profile", "fixed_ips", "id", "security_groups",
		"device_id", "name", "admin_state_up", "network_id", "tenant_id", "binding:vif_details", "binding:vnic_type",
		"binding:vif_type", "mac_address", "project_id", "created_at" })
public class Port {
	private String status;
	@JsonProperty("binding:host_id")
	private String binding_host_id;
	private String description;
	@JsonIgnore
	private List<String> allowed_address_pairs;
	private List<String> extra_dhcp_opts;
	private String updated_at;
	private String device_owner;
	private Integer revision_number;
	@JsonProperty("binding:profile")
	private Profile binding_profile;
	private List<FixedIPS> fixed_ips;
	private String id;
	private List<String> security_groups;
	private String device_id;
	private String name;
	private Boolean admin_state_up;
	private String network_id;
	private String tenant_id;
	@JsonProperty("binding:vif_details")
	private BindingInterfaceDetail binding_vif_details;
	@JsonProperty("binding:vnic_type")
	private String binding_vnic_type;
	@JsonProperty("binding:vif_type")
	private String binding_vif_type;
	private String mac_address;
	private String project_id;
	private String created_at;

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@JsonProperty("binding:host_id")
	public String getBinding_host_id() {
		return binding_host_id;
	}

	@JsonProperty("binding:host_id")
	public void setBinding_host_id(String binding_host_id) {
		this.binding_host_id = binding_host_id;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public List<String> getAllowed_address_pairs() {
		return allowed_address_pairs;
	}

	public void setAllowed_address_pairs(List<String> allowed_address_pairs) {
		this.allowed_address_pairs = allowed_address_pairs;
	}

	public List<String> getExtra_dhcp_opts() {
		return extra_dhcp_opts;
	}

	public void setExtra_dhcp_opts(List<String> extra_dhcp_opts) {
		this.extra_dhcp_opts = extra_dhcp_opts;
	}

	public String getUpdated_at() {
		return updated_at;
	}

	public void setUpdated_at(String updated_at) {
		this.updated_at = updated_at;
	}

	public String getDevice_owner() {
		return device_owner;
	}

	public void setDevice_owner(String device_owner) {
		this.device_owner = device_owner;
	}

	public Integer getRevision_number() {
		return revision_number;
	}

	public void setRevision_number(Integer revision_number) {
		this.revision_number = revision_number;
	}

	@JsonProperty("binding:profile")
	public Profile getBinding_profile() {
		return binding_profile;
	}

	@JsonProperty("binding:profile")
	public void setBinding_profile(Profile binding_profile) {
		this.binding_profile = binding_profile;
	}

	public List<FixedIPS> getFixed_ips() {
		return fixed_ips;
	}

	public void setFixed_ips(List<FixedIPS> fixed_ips) {
		this.fixed_ips = fixed_ips;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public List<String> getSecurity_groups() {
		return security_groups;
	}

	public void setSecurity_groups(List<String> security_groups) {
		this.security_groups = security_groups;
	}

	public String getDevice_id() {
		return device_id;
	}

	public void setDevice_id(String device_id) {
		this.device_id = device_id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Boolean getAdmin_state_up() {
		return admin_state_up;
	}

	public void setAdmin_state_up(Boolean admin_state_up) {
		this.admin_state_up = admin_state_up;
	}

	public String getNetwork_id() {
		return network_id;
	}

	public void setNetwork_id(String network_id) {
		this.network_id = network_id;
	}

	public String getTenant_id() {
		return tenant_id;
	}

	public void setTenant_id(String tenant_id) {
		this.tenant_id = tenant_id;
	}

	@JsonProperty("binding:vif_details")
	public BindingInterfaceDetail getBinding_vif_details() {
		return binding_vif_details;
	}

	@JsonProperty("binding:vif_details")
	public void setBinding_vif_details(BindingInterfaceDetail binding_vif_details) {
		this.binding_vif_details = binding_vif_details;
	}

	@JsonProperty("binding:vnic_type")
	public String getBinding_vnic_type() {
		return binding_vnic_type;
	}

	@JsonProperty("binding:vnic_type")
	public void setBinding_vnic_type(String binding_vnic_type) {
		this.binding_vnic_type = binding_vnic_type;
	}

	@JsonProperty("binding:vif_type")
	public String getBinding_vif_type() {
		return binding_vif_type;
	}

	@JsonProperty("binding:vif_type")
	public void setBinding_vif_type(String binding_vif_type) {
		this.binding_vif_type = binding_vif_type;
	}

	public String getMac_address() {
		return mac_address;
	}

	public void setMac_address(String mac_address) {
		this.mac_address = mac_address;
	}

	public String getProject_id() {
		return project_id;
	}

	public void setProject_id(String project_id) {
		this.project_id = project_id;
	}

	public String getCreated_at() {
		return created_at;
	}

	public void setCreated_at(String created_at) {
		this.created_at = created_at;
	}

}
