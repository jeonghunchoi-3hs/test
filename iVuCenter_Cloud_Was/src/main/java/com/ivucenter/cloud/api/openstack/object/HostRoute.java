package com.ivucenter.cloud.api.openstack.object;

public class HostRoute {
	private String nexthop;
	private String destination;

	public String getNexthop() {
		return nexthop;
	}

	public void setNexthop(String nexthop) {
		this.nexthop = nexthop;
	}

	public String getDestination() {
		return destination;
	}

	public void setDestination(String destination) {
		this.destination = destination;
	}

}
