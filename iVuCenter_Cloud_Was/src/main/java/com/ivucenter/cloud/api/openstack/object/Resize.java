package com.ivucenter.cloud.api.openstack.object;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;

public class Resize {
	@JsonIgnore
	private String server_id;
	
	@JsonProperty("OS-DCF:diskConfig")
	private String OS_DCF_diskConfig;
	private String flavorRef;
	private String confirmResize=null;

	public String getFlavorRef() {
		return flavorRef;
	}

	public void setFlavorRef(String flavorRef) {
		this.flavorRef = flavorRef;
	}

	public String getServer_id() {
		return server_id;
	}

	public void setServer_id(String server_id) {
		this.server_id = server_id;
	}

	@JsonProperty("OS-DCF:diskConfig")
	public String getOS_DCF_diskConfig() {
		return OS_DCF_diskConfig;
	}

	@JsonProperty("OS-DCF:diskConfig")
	public void setOS_DCF_diskConfig(String value) {
		OS_DCF_diskConfig = value;
	}

	public String getConfirmResize() {
		return confirmResize;
	}

	public void setConfirmResize(String confirmResize) {
		this.confirmResize = confirmResize;
	}
	
	

}
