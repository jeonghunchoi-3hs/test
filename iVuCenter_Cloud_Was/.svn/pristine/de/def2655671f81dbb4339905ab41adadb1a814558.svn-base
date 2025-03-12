package com.ivucenter.cloud.api.openstack.object;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

import lombok.Getter;
import lombok.Setter;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({ "domain", "id", "name"})
@Getter
@Setter
public class TokenProject {

	@JsonProperty("domain")
	public TokenProjectDomain domain;
	@JsonProperty("id")
	public String id;
	@JsonProperty("name")
	public String name;

}