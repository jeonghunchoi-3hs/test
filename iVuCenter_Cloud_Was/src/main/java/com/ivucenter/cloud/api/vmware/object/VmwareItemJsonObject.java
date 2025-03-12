package com.ivucenter.cloud.api.vmware.object;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
	"creation_time",
	"last_modified_time",
	"description",
	"type",
	"version",
	"content_version",
	"library_id",
	"size",
	"cached",
	"name",
	"id",
	"metadata_version"
})
@Getter
@Setter

@ToString
public class VmwareItemJsonObject {

	@JsonProperty("creation_time")
	private String creationTime;
	@JsonProperty("last_modified_time")
	private String lastModifiedTime;
	
	
	
	@JsonProperty("description")
	private String description;
	@JsonProperty("type")
	private String type;
	@JsonProperty("version")
	private String version;
	@JsonProperty("content_version")
	private String contentVersion;
	@JsonProperty("library_id")
	private String libraryId;
	@JsonProperty("size")
	private long size;
	@JsonProperty("cached")
	private boolean cached;
	@JsonProperty("name")
	private String name;
	@JsonProperty("id")
	private String id;
	@JsonProperty("metadata_version")
	private String metadataVersion;
	
	private String cloudId;
	
	private VmwareItemJsonObject value;
	private List<VmCdroms> cdroms;
	private VmMemory memory;
	private List<VmDisks> disks;
	private List<VmNics> nics;
	@JsonProperty("power_state")
	private String powerState;



	
}