package com.ivucenter.cloud.api.vRealize.object;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class vraServer {
	private List<vraContent> content;
	private String deploymentId;
	private String deploymentName;
	private String id;
	private String name;
	private String description;
	private String orgId;
	private String blueprintId;
	private String createAt;
	private String createdBy;
	private String lastUpdatedAt;
	private String lastUpdatedBy;
	private String projectId;
	private String status;
	private String catalogItemId;
	private String statusCode;
	private String message;
	private String errorCode;
	private vraInputs inputs;
}
