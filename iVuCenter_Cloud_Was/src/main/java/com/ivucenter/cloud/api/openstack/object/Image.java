package com.ivucenter.cloud.api.openstack.object;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonProperty;

public class Image {
	private String status;
	private String name;
	private List<String> tags;
	private String container_format;
	private String created_at;
	private Long size;
	private String disk_format;
	private String updated_at;
	private String visibility;
	private String self;
	private Integer min_disk;
	@JsonProperty("protected")
	private Boolean protect;
	private String id;
	private String file;
	private String checksum;
	private String owner;
	private String virtual_size;
	private Integer min_ram;
	private String schema;
	private List<Link> links;

	
	public List<Link> getLinks() {
		return links;
	}

	public void setLinks(List<Link> links) {
		this.links = links;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public List<String> getTags() {
		return tags;
	}

	public void setTags(List<String> tags) {
		this.tags = tags;
	}

	public String getContainer_format() {
		return container_format;
	}

	public void setContainer_format(String container_format) {
		this.container_format = container_format;
	}

	public String getCreated_at() {
		return created_at;
	}

	public void setCreated_at(String created_at) {
		this.created_at = created_at;
	}

	public Long getSize() {
		return size;
	}

	public void setSize(Long size) {
		this.size = size;
	}

	public String getDisk_format() {
		return disk_format;
	}

	public void setDisk_format(String disk_format) {
		this.disk_format = disk_format;
	}

	public String getUpdated_at() {
		return updated_at;
	}

	public void setUpdated_at(String updated_at) {
		this.updated_at = updated_at;
	}

	public String getVisibility() {
		return visibility;
	}

	public void setVisibility(String visibility) {
		this.visibility = visibility;
	}

	public String getSelf() {
		return self;
	}

	public void setSelf(String self) {
		this.self = self;
	}

	public Integer getMin_disk() {
		return min_disk;
	}

	public void setMin_disk(Integer min_disk) {
		this.min_disk = min_disk;
	}

	@JsonProperty("protected")
	public Boolean getProtect() {
		return protect;
	}

	@JsonProperty("protected")
	public void setProtect(Boolean protect) {
		this.protect = protect;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getFile() {
		return file;
	}

	public void setFile(String file) {
		this.file = file;
	}

	public String getChecksum() {
		return checksum;
	}

	public void setChecksum(String checksum) {
		this.checksum = checksum;
	}

	public String getOwner() {
		return owner;
	}

	public void setOwner(String owner) {
		this.owner = owner;
	}

	public String getVirtual_size() {
		return virtual_size;
	}

	public void setVirtual_size(String virtual_size) {
		this.virtual_size = virtual_size;
	}

	public Integer getMin_ram() {
		return min_ram;
	}

	public void setMin_ram(Integer min_ram) {
		this.min_ram = min_ram;
	}

	public String getSchema() {
		return schema;
	}

	public void setSchema(String schema) {
		this.schema = schema;
	}

}
