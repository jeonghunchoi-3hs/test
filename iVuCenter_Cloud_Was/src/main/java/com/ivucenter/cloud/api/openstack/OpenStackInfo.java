package com.ivucenter.cloud.api.openstack;

import org.springframework.stereotype.Component;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
@Getter
@Setter
@Component
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class OpenStackInfo {
	// Attributes	
	private String adminDomain;
	private String adminProject;
	private String adminUsername;
	private String adminPassword;
	private String projectUsername;
	private String projectPassword;
	private String apiGatewayMode;
	private String apiGatewayServer;
	private String apiIdentityServer;
	private String apiNetworkServer;
	private String apiComputeServer;
	private String apiMetricsServer;
	private String apiVolumev3Server;
	private String apiImagesServer;
	private String apiAlarmsServer;  
	private String alarmOccurredURL;
	private String alarmClearURL;
	
	private static class OpenStackInfoSingletonHolder {
		static OpenStackInfo instance = new OpenStackInfo();
	}

	public static OpenStackInfo getInstance() {
		return OpenStackInfoSingletonHolder.instance;
	}	
}
