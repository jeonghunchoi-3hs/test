package com.ivucenter.cloud.api.openstack.object;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

import lombok.Getter;
import lombok.Setter;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
"links",
"projects"
})

@Getter
@Setter
public class Projects {

@JsonProperty("links")
public Links links;
@JsonProperty("projects")
public List<Project> projects = null;

}