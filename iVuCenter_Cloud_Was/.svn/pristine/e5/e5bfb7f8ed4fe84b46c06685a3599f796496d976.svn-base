package com.ivucenter.cloud.api.openstack.object;

import java.util.List;
import java.util.Map;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

import lombok.ToString;

@ToString
@JsonPropertyOrder({ "OS-EXT-STS:task_state", "addresses", "links", "image", "OS-EXT-STS:vm_state",
		"OS-EXT-SRV-ATTR:instance_name", "OS-SRV-USG:launched_at", "flavor", "id", "security_groups", "user_id",
		"OS-DCF:diskConfig", "accessIPv4", "accessIPv6", "progress", "OS-EXT-STS:power_state",
		"OS-EXT-AZ:availability_zone", "metadata", "status", "updated", "hostId", "OS-EXT-SRV-ATTR:host",
		"OS-SRV-USG:terminated_at", "key_name", "OS-EXT-SRV-ATTR:hypervisor_hostname", "name", "created", "tenant_id",
		"os-extended-volumes:volumes_attached", "config_drive" })
public class Server {
	@JsonProperty("OS-EXT-STS:task_state")
	private String OS_EXT_STS_task_state;
	// addresses
	private List<Link> links;
	// private Image image;

	@JsonProperty("OS-EXT-STS:vm_state")
	private String OS_EXT_STS_vm_state;

	@JsonProperty("OS-EXT-SRV-ATTR:instance_name")
	private String OS_EXT_SRV_ATTR_instance_name;

	@JsonProperty("OS-SRV-USG:launched_at")
	private String OS_SRV_USG_launched_at;

	// flavor
	private String id;
	// security_groups
	private String user_id;
	@JsonProperty("OS-DCF:diskConfig")
	private String OS_DCF_diskConfig;
	private String accessIPv4;
	private String accessIPv6;
	private Integer progress;

	@JsonProperty("OS-EXT-STS:power_state")
	private Integer OS_EXT_STS_power_state;

	@JsonProperty("OS-EXT-AZ:availability_zone")
	private String OS_EXT_AZ_availability_zone;
	private Map<String, String> metadata;
	private String status;
	private String updated;
	private String hostId;

	@JsonProperty("OS-EXT-SRV-ATTR:host")
	private String OS_EXT_SRV_ATTR_host;

	@JsonProperty("OS-SRV-USG:terminated_at")
	private String OS_SRV_USG_terminated_at;

	private String key_name;

	@JsonProperty("OS-EXT-SRV-ATTR:hypervisor_hostname")
	private String OS_EXT_SRV_ATTR_hypervisor_hostname;

	private String name;
	private String created;
	private String tenant_id;
	// os-extended-volumes:volumes_attached
	private String config_drive;

	private List<SecurityGroup> security_groups;

	private String imageRef;
	private String flavorRef;
	private List<Network> networks;
	
	private String availability_zone;
	private String vCpu;
	private String memory;
	private String disk;
	private OpenStackFault fault;

	private String imageId;
	private String flavorId;
	
	private List<BlockDeviceStorageMapping> block_device_mapping_v2;

	public List<BlockDeviceStorageMapping> getBlock_device_mapping_v2() {
		return block_device_mapping_v2;
	}

	public void setBlock_device_mapping_v2(List<BlockDeviceStorageMapping> block_device_mapping_v2) {
		this.block_device_mapping_v2 = block_device_mapping_v2;
	}

	public OpenStackFault getFault() {
		return fault;
	}

	public void setFault(OpenStackFault fault) {
		this.fault = fault;
	}

	public String getImageRef() {
		return imageRef;
	}

	public void setImageRef(String imageRef) {
		this.imageRef = imageRef;
	}

	public String getFlavorRef() {
		return flavorRef;
	}

	public void setFlavorRef(String flavorRef) {
		this.flavorRef = flavorRef;
	}

	public List<Network> getNetworks() {
		return networks;
	}

	public void setNetworks(List<Network> networks) {
		this.networks = networks;
	}

	public Map<String, String> getMetadata() {
		return metadata;
	}

	public void setMetadata(Map<String, String> metadata) {
		this.metadata = metadata;
	}

	@JsonProperty("os-extended-volumes:volumes_attached")
	private List<VolumnAttached> os_extended_volumes_volumes_attached;

	private Flavor flavor;

	public Map<String, List<Address>> addresses;

	public Map<String, List<Address>> getAddresses() {
		return addresses;
	}

	public void setAddresses(Map<String, List<Address>> addresses) {
		this.addresses = addresses;
	}

	public Flavor getFlavor() {
		return flavor;
	}

	public void setFlavor(Flavor flavor) {
		this.flavor = flavor;
	}

	@JsonProperty("os-extended-volumes:volumes_attached")
	public List<VolumnAttached> getOs_extended_volumes_volumes_attached() {
		return os_extended_volumes_volumes_attached;
	}

	@JsonProperty("os-extended-volumes:volumes_attached")
	public void setOs_extended_volumes_volumes_attached(List<VolumnAttached> os_extended_volumes_volumes_attached) {
		this.os_extended_volumes_volumes_attached = os_extended_volumes_volumes_attached;
	}

	public List<SecurityGroup> getSecurity_groups() {
		return security_groups;
	}

	public void setSecurity_groups(List<SecurityGroup> security_groups) {
		this.security_groups = security_groups;
	}

	public String getOS_EXT_STS_task_state() {
		return OS_EXT_STS_task_state;
	}

	public void setOS_EXT_STS_task_state(String oS_EXT_STS_task_state) {
		OS_EXT_STS_task_state = oS_EXT_STS_task_state;
	}

	public List<Link> getLinks() {
		return links;
	}

	public void setLinks(List<Link> links) {
		this.links = links;
	}

	// public Image getImage() {
	// return image;
	// }
	//
	// public void setImage(Image image) {
	// this.image = image;
	// }

	@JsonProperty("OS-EXT-STS:vm_state")
	public String getOS_EXT_STS_vm_state() {
		return OS_EXT_STS_vm_state;
	}

	@JsonProperty("OS-EXT-STS:vm_state")
	public void setOS_EXT_STS_vm_state(String oS_EXT_STS_vm_state) {
		OS_EXT_STS_vm_state = oS_EXT_STS_vm_state;
	}

	@JsonProperty("OS-EXT-SRV-ATTR:instance_name")
	public String getOS_EXT_SRV_ATTR_instance_name() {
		return OS_EXT_SRV_ATTR_instance_name;
	}

	@JsonProperty("OS-EXT-SRV-ATTR:instance_name")
	public void setOS_EXT_SRV_ATTR_instance_name(String oS_EXT_SRV_ATTR_instance_name) {
		OS_EXT_SRV_ATTR_instance_name = oS_EXT_SRV_ATTR_instance_name;
	}

	@JsonProperty("OS-SRV-USG:launched_at")
	public String getOS_SRV_USG_launched_at() {
		return OS_SRV_USG_launched_at;
	}

	@JsonProperty("OS-SRV-USG:launched_at")
	public void setOS_SRV_USG_launched_at(String oS_SRV_USG_launched_at) {
		OS_SRV_USG_launched_at = oS_SRV_USG_launched_at;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	@JsonProperty("OS-DCF:diskConfig")
	public String getOS_DCF_diskConfig() {
		return OS_DCF_diskConfig;
	}

	@JsonProperty("OS-DCF:diskConfig")
	public void setOS_DCF_diskConfig(String value) {
		OS_DCF_diskConfig = value;
	}

	public String getAccessIPv4() {
		return accessIPv4;
	}

	public void setAccessIPv4(String accessIPv4) {
		this.accessIPv4 = accessIPv4;
	}

	public String getAccessIPv6() {
		return accessIPv6;
	}

	public void setAccessIPv6(String accessIPv6) {
		this.accessIPv6 = accessIPv6;
	}

	public Integer getProgress() {
		return progress;
	}

	public void setProgress(Integer progress) {
		this.progress = progress;
	}

	@JsonProperty("OS-EXT-STS:power_state")
	public Integer getOS_EXT_STS_power_state() {
		return OS_EXT_STS_power_state;
	}

	@JsonProperty("OS-EXT-STS:power_state")
	public void setOS_EXT_STS_power_state(Integer oS_EXT_STS_power_state) {
		OS_EXT_STS_power_state = oS_EXT_STS_power_state;
	}

	@JsonProperty("OS-EXT-AZ:availability_zone")
	public String getOS_EXT_AZ_availability_zone() {
		return OS_EXT_AZ_availability_zone;
	}

	@JsonProperty("OS-EXT-AZ:availability_zone")
	public void setOS_EXT_AZ_availability_zone(String oS_EXT_AZ_availability_zone) {
		OS_EXT_AZ_availability_zone = oS_EXT_AZ_availability_zone;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getUpdated() {
		return updated;
	}

	public void setUpdated(String updated) {
		this.updated = updated;
	}

	public String getHostId() {
		return hostId;
	}

	public void setHostId(String hostId) {
		this.hostId = hostId;
	}

	@JsonProperty("OS-EXT-SRV-ATTR:host")
	public String getOS_EXT_SRV_ATTR_host() {
		return OS_EXT_SRV_ATTR_host;
	}

	@JsonProperty("OS-EXT-SRV-ATTR:host")
	public void setOS_EXT_SRV_ATTR_host(String oS_EXT_SRV_ATTR_host) {
		OS_EXT_SRV_ATTR_host = oS_EXT_SRV_ATTR_host;
	}

	@JsonProperty("OS-SRV-USG:terminated_at")
	public String getOS_SRV_USG_terminated_at() {
		return OS_SRV_USG_terminated_at;
	}

	@JsonProperty("OS-SRV-USG:terminated_at")
	public void setOS_SRV_USG_terminated_at(String oS_SRV_USG_terminated_at) {
		OS_SRV_USG_terminated_at = oS_SRV_USG_terminated_at;
	}

	public String getKey_name() {
		return key_name;
	}

	public void setKey_name(String key_name) {
		this.key_name = key_name;
	}

	@JsonProperty("OS-EXT-SRV-ATTR:hypervisor_hostname")
	public String getOS_EXT_SRV_ATTR_hypervisor_hostname() {
		return OS_EXT_SRV_ATTR_hypervisor_hostname;
	}

	@JsonProperty("OS-EXT-SRV-ATTR:hypervisor_hostname")
	public void setOS_EXT_SRV_ATTR_hypervisor_hostname(String oS_EXT_SRV_ATTR_hypervisor_hostname) {
		OS_EXT_SRV_ATTR_hypervisor_hostname = oS_EXT_SRV_ATTR_hypervisor_hostname;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCreated() {
		return created;
	}

	public void setCreated(String created) {
		this.created = created;
	}

	public String getTenant_id() {
		return tenant_id;
	}

	public void setTenant_id(String tenant_id) {
		this.tenant_id = tenant_id;
	}

	public String getConfig_drive() {
		return config_drive;
	}

	public void setConfig_drive(String config_drive) {
		this.config_drive = config_drive;
	}

	public String getAvailability_zone() {
		return availability_zone;
	}

	public void setAvailability_zone(String availability_zone) {
		this.availability_zone = availability_zone;
	}

	public String getvCpu() {
		return vCpu;
	}

	public void setvCpu(String vCpu) {
		this.vCpu = vCpu;
	}

	public String getMemory() {
		return memory;
	}

	public void setMemory(String memory) {
		this.memory = memory;
	}

	public String getDisk() {
		return disk;
	}

	public void setDisk(String disk) {
		this.disk = disk;
	}

	public String getImageId() {
		return imageId;
	}

	public void setImageId(String imageId) {
		this.imageId = imageId;
	}

	public String getFlavorId() {
		return flavorId;
	}

	public void setFlavorId(String flavorId) {
		this.flavorId = flavorId;
	}

}
