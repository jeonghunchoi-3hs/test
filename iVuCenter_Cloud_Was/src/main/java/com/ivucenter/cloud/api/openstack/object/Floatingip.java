package com.ivucenter.cloud.api.openstack.object;

import com.fasterxml.jackson.annotation.JsonPropertyOrder;

@JsonPropertyOrder({ "router_id", "status", "description", "tenant_id", "created_at", "updated_at",
		"floating_network_id", "fixed_ip_address", "floating_ip_address", "revision_number", "project_id", "port_id",
		"id" })
public class Floatingip {
	private String router_id;
	private String status;
	private String description;
	private String tenant_id;
	private String created_at;
	private String updated_at;
	private String floating_network_id;
	private String fixed_ip_address;
	private String floating_ip_address;
	private Integer revision_number;
	private String project_id;
	private String port_id;
	private String id;

	public String getRouter_id() {
		return router_id;
	}

	public void setRouter_id(String router_id) {
		this.router_id = router_id;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getTenant_id() {
		return tenant_id;
	}

	public void setTenant_id(String tenant_id) {
		this.tenant_id = tenant_id;
	}

	public String getCreated_at() {
		return created_at;
	}

	public void setCreated_at(String created_at) {
		this.created_at = created_at;
	}

	public String getUpdated_at() {
		return updated_at;
	}

	public void setUpdated_at(String updated_at) {
		this.updated_at = updated_at;
	}

	public String getFloating_network_id() {
		return floating_network_id;
	}

	public void setFloating_network_id(String floating_network_id) {
		this.floating_network_id = floating_network_id;
	}

	public String getFixed_ip_address() {
		return fixed_ip_address;
	}

	public void setFixed_ip_address(String fixed_ip_address) {
		this.fixed_ip_address = fixed_ip_address;
	}

	public String getFloating_ip_address() {
		return floating_ip_address;
	}

	public void setFloating_ip_address(String floating_ip_address) {
		this.floating_ip_address = floating_ip_address;
	}

	public Integer getRevision_number() {
		return revision_number;
	}

	public void setRevision_number(Integer revision_number) {
		this.revision_number = revision_number;
	}

	public String getProject_id() {
		return project_id;
	}

	public void setProject_id(String project_id) {
		this.project_id = project_id;
	}

	public String getPort_id() {
		return port_id;
	}

	public void setPort_id(String port_id) {
		this.port_id = port_id;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

}
