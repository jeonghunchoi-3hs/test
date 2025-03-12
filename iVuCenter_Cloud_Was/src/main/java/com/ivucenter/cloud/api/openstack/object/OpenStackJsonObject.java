package com.ivucenter.cloud.api.openstack.object;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class OpenStackJsonObject {

	private String value;
	private RequestAuth auth;
	private Token token;

	//private Access access;
	private Network network;
	private Subnet subnet;
	private Server server;
	private Flavor flavor;
	private Port port;
	private Router router;
	private Floatingip floatingip;
	private NetworkQuota quota;
	private QuotaSet quota_set;
	private Volume volume;
	private User user;
	private Role role;
	private Image image;
	private Resize resize;
	private Loadbalancer loadbalancer;
	private Listener listener;
	private Member member;
	private Pool pool;
	private VolumeAttachment volumeAttachment;
	private PortAttachment PortAttachment;
	private SecurityGroup securitygroup;
	private SecurityGroupRule security_group_rule;
	private Project project;

	private List<Project> Projects;
	private List<Network> networks;
	private List<String> tenants_links;
	private List<Subnet> subnets;
	private List<Server> servers;
	private List<Flavor> flavors;
	private List<Port> ports;
	private List<Router> routers;
	private List<Floatingip> floatingips;
	private List<NetworkQuota> quotas;
	private List<Volume> volumes;
	private List<Image> images;
	private List<SecurityGroup> security_groups;
	private List<SecurityGroupRule> security_group_rules;
	private List<VolumeAttachment> volumeAttachments;
	private List<User> users;
	private List<Role> roles;
	private List<Loadbalancer> loadbalancers;
	private List<Listener> listeners;
	private List<Member> members;
	private List<Hypervisor> hypervisors;

	private List<StoragePool> StoragePools;
	private List<StoragePoolCapabilities> storagePoolCapabilities;

	private List<Pool> pools;

}
