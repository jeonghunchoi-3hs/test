package com.ivucenter.cloud.api.openstack.object;

import com.fasterxml.jackson.annotation.JsonPropertyOrder;

import lombok.Getter;
import lombok.Setter;

@JsonPropertyOrder({"name", "capabilities"})
@Getter
@Setter
public class StoragePool {

	private String name;
	private StoragePoolCapabilities capabilities;

}
