package com.ivucenter.cloud.api.openstack.object;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({ "is_domain", "description", "domain_id", "enabled", "id", "links", "name", "parent_id", "tags" })
@Getter
@Setter
@ToString
public class Project {

	@JsonProperty("is_domain")
	public Boolean isDomain;
	@JsonProperty("description")
	public Object description;
	@JsonProperty("domain_id")
	public String domainId;
	@JsonProperty("enabled")
	public Boolean enabled;
	@JsonProperty("id")
	public String id;
	@JsonProperty("links")
	public Links_ links;
	@JsonProperty("name")
	public String name;
	@JsonProperty("parent_id")
	public Object parentId;
	@JsonProperty("tags")
	public List<Object> tags = null;
	private List<Project> project;
}