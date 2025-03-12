package com.ivucenter.cloud.api.openstack.object;

import java.util.LinkedList;
import java.util.List;

import com.ivucenter.cloud.api.openstack.OpenStackInfo;

public class Alarm {
	
	private String description;
	private String type;
	private Boolean repeat_actions;
	private Boolean enabled;
	private String name;
	private List<String> ok_actions;
	private List<String> alarm_actions;
	private ResourcesThresholdRule gnocchi_resources_threshold_rule;
	private String alarm_id;
	private String severity;
	private String timestamp;
	private String user_id;
	private String project_id;
	private String state;
	private String state_timestamp;

	// List<String> time_constraints;
	// List<String> insufficient_data_actions;

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Boolean getRepeat_actions() {
		return repeat_actions;
	}

	public void setRepeat_actions(Boolean repeat_actions) {
		this.repeat_actions = repeat_actions;
	}

	public Boolean getEnabled() {
		return enabled;
	}

	public void setEnabled(Boolean enabled) {
		this.enabled = enabled;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public List<String> getOk_actions() {
		if (this.ok_actions == null) {
			this.ok_actions = new LinkedList<String>();
			this.ok_actions.add(getAlarmClearURL());
		}
		return this.ok_actions;
	}

	public void setOk_actions(List<String> ok_actions) {
		this.ok_actions = ok_actions;
	}

	public List<String> getAlarm_actions() {
		if (this.alarm_actions == null) {
			this.alarm_actions = new LinkedList<String>();
			this.alarm_actions.add(getAlarmOccurredURL());
		}
		return alarm_actions;
	}

	public void setAlarm_actions(List<String> alarm_actions) {
		this.alarm_actions = alarm_actions;
	}

	public ResourcesThresholdRule getGnocchi_resources_threshold_rule() {
		return gnocchi_resources_threshold_rule;
	}

	public void setGnocchi_resources_threshold_rule(ResourcesThresholdRule gnocchi_resources_threshold_rule) {
		this.gnocchi_resources_threshold_rule = gnocchi_resources_threshold_rule;
	}

	public String getAlarm_id() {
		return alarm_id;
	}

	public void setAlarm_id(String alarm_id) {
		this.alarm_id = alarm_id;
	}

	public String getSeverity() {
		return severity;
	}

	public void setSeverity(String severity) {
		this.severity = severity;
	}

	public String getTimestamp() {
		return timestamp;
	}

	public void setTimestamp(String timestamp) {
		this.timestamp = timestamp;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getProject_id() {
		return project_id;
	}

	public void setProject_id(String project_id) {
		this.project_id = project_id;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getState_timestamp() {
		return state_timestamp;
	}

	public void setState_timestamp(String state_timestamp) {
		this.state_timestamp = state_timestamp;
	}
	
	private String getAlarmOccurredURL() {
		return OpenStackInfo.getInstance().getAlarmOccurredURL()
				.replaceAll("\\$\\{instance_id\\}", this.gnocchi_resources_threshold_rule.getResource_id())
				.replaceAll("\\$\\{type\\}", this.name)
				.replaceAll("\\$\\{threadhold\\}", this.gnocchi_resources_threshold_rule.getThreshold().toString());
	}

	private String getAlarmClearURL() {
		return OpenStackInfo.getInstance().getAlarmClearURL()
				.replaceAll("\\$\\{instance_id\\}", this.gnocchi_resources_threshold_rule.getResource_id())
				.replaceAll("\\$\\{type\\}", this.name)
				.replaceAll("\\$\\{threadhold\\}", this.gnocchi_resources_threshold_rule.getThreshold().toString());
	}
	
	public void setDefaultCpuUtil(String resource_id) {
		this.description = "instance running busy";
		this.type = "gnocchi_resources_threshold";
		this.repeat_actions = false;
		this.enabled = true;
		this.name = "cpu_hi";
		this.gnocchi_resources_threshold_rule = new ResourcesThresholdRule();
		this.gnocchi_resources_threshold_rule.setResource_type("instance");
		this.gnocchi_resources_threshold_rule.setComparison_operator("ge");
		this.gnocchi_resources_threshold_rule.setThreshold(80.0);
		this.gnocchi_resources_threshold_rule.setGranularity(300l);
		this.gnocchi_resources_threshold_rule.setAggregation_method("mean");
		this.gnocchi_resources_threshold_rule.setResource_id(resource_id);
		this.gnocchi_resources_threshold_rule.setMetric("cpu_util");
		this.gnocchi_resources_threshold_rule.setEvaluation_periods(3);
	}

	public void setDefaultMemUtil(String resource_id) {
		this.description = "instance running busy";
		this.type = "gnocchi_resources_threshold";
		this.repeat_actions = false;
		this.enabled = true;
		this.name = "memory_hi";
		this.gnocchi_resources_threshold_rule = new ResourcesThresholdRule();
		this.gnocchi_resources_threshold_rule.setResource_type("instance");
		this.gnocchi_resources_threshold_rule.setComparison_operator("ge");
		this.gnocchi_resources_threshold_rule.setThreshold(80.0);
		this.gnocchi_resources_threshold_rule.setGranularity(300l);
		this.gnocchi_resources_threshold_rule.setAggregation_method("mean");
		this.gnocchi_resources_threshold_rule.setResource_id(resource_id);
		this.gnocchi_resources_threshold_rule.setMetric("memory.usage");
		this.gnocchi_resources_threshold_rule.setEvaluation_periods(3);
	}

}
