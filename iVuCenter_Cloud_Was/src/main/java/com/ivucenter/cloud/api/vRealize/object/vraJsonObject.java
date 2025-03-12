package com.ivucenter.cloud.api.vRealize.object;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class vraJsonObject {
	private String username;
	private String password;
	private String domain;
	private String refreshToken;
	private vraProjectObject vraProjectObject;
	private String id;
	private String projectId;
	private vraDefinition definition;
	
	//server
	private String deploymentId;
	private String deploymentName;
	
	//block Tracker
	private String progress;
	private String message;
	private String FINISHED;
	private String[] resources;
	private String name;
	private String selfLink;
	private String deplomentId;
	
	//block Devices
	private String capacityInGB;
	private String description;
	private String status;
	
	//delete vm
	private String actionId;
	private String approvedAt;
	private String blueprintId;
	private String cancelable;
	private String catalogItemId;
	private String completedAt;
	private String details;
	private String dismissed;
	private String initializedAt;
	private String requestedBy;
	private String resourceName;
	private String totalTasks;
	private String updatedAt;
	
	private String statusCode;
	private String errorCode;
}
