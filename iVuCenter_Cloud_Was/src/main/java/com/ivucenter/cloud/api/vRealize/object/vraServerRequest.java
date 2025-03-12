package com.ivucenter.cloud.api.vRealize.object;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class vraServerRequest {
	List<vraServerRequest> content;
	
	private String id;
	private String name;
	private String requestedBy;
	private String blueprintId;
	private vraInputs inputs;
	private String status;
	private String details;
	private String createdAt;
	private String updatedAt;
	private String totalTasks;
	private String completedTasks;
	private String dismissed;
	private String cancelable;
}
