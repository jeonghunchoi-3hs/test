package com.ivucenter.cloud.api.openstack.object;

import java.util.Map;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@Getter
@Setter
@ToString
public class OpenStackMetricData {
	private String created_by_user_id;
	private String started_at;
	private String user_id;
	private String revision_end;
	private String created_by_project_id;
	private String id;
	private Map<String, String> metrics;
	private String original_resource_id;
	private String revision_start;
	private String project_id;
	private String type;
	private String ended_at;
}
