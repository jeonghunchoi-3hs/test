package com.ivucenter.cloud.api.openstack.object;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

import lombok.Getter;
import lombok.Setter;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
"next",
"previous",
"self"
})
@Getter
@Setter
public class Links {

@JsonProperty("next")
public Object next;
@JsonProperty("previous")
public Object previous;
@JsonProperty("self")
public String self;

}