package com.ivucenter.cloud.api.openstack.object;

import java.util.List;
import java.util.Map;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@JsonPropertyOrder({ "migration_status","attachments","links","availability_zone","os-vol-host-attr:host","encrypted","updated_at","replication_status","snapshot_id","id","size","user_id","os-vol-tenant-attr:tenant_id","os-vol-mig-status-attr:migstat","metadata","status","volume_image_metadata","description","multiattach","source_volid","consistencygroup_id","os-vol-mig-status-attr:name_id","name","bootable","created_at","volume_type" })
public class Volume {
	private String id;
	private String name;
	private List<Link> links;
	private String migration_status;
	private List<VolumeAttachment> attachments;
	private String availability_zone;
	@JsonProperty("os-vol-host-attr:host")
	private String os_vol_host_attr_host;
	private Boolean encrypted;
	private String updated_at;
	private String replication_status;
	private String snapshot_id;
	private Integer size;
	private String user_id;
	@JsonProperty("os-vol-tenant-attr:tenant_id")
	private String os_vol_tenant_attr_tenant_id;
	@JsonProperty("os-vol-mig-status-attr:migstat")
	private String os_vol_mig_status_attr_migstat;
	private String status;
	private String description;
	private Boolean multiattach;
	private String source_volid;
	private String consistencygroup_id;
	@JsonProperty("os-vol-mig-status-attr:name_id")
	private String os_vol_mig_status_attr_name_id;
	private String bootable;
	private String created_at;
	private String volume_type;
	private Map<String, String> metadata;
	private VolumeImageMetadata volume_image_metadata;
	private String imageRef;

}
