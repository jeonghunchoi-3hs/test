package com.ivucenter.cloud.entity;

import java.math.BigInteger;

public class QuartzJobInfoVO extends DataTableVO {
	private String schedName;     
	private String jobName;       
	private String jobGroup;      
	private String jobClassName; 
	private String triggerName;   
	private String triggerGroup;  
	private BigInteger prevFireTime; 
	private BigInteger nextFireTime; 
	private String triggerState;  
	private String triggerType;   
	private String cronExpression;
	
	public String getSchedName() {
		return schedName;
	}
	public void setSchedName(String schedName) {
		this.schedName = schedName;
	}
	public String getJobName() {
		return jobName;
	}
	public void setJobName(String jobName) {
		this.jobName = jobName;
	}
	public String getJobGroup() {
		return jobGroup;
	}
	public void setJobGroup(String jobGroup) {
		this.jobGroup = jobGroup;
	}
	public String getJobClassName() {
		return jobClassName;
	}
	public void setJobClassName(String jobClassName) {
		this.jobClassName = jobClassName;
	}
	public String getTriggerName() {
		return triggerName;
	}
	public void setTriggerName(String triggerName) {
		this.triggerName = triggerName;
	}
	public String getTriggerGroup() {
		return triggerGroup;
	}
	public void setTriggerGroup(String triggerGroup) {
		this.triggerGroup = triggerGroup;
	}
	public BigInteger getPrevFireTime() {
		return prevFireTime;
	}
	public void setPrevFireTime(BigInteger prevFireTime) {
		this.prevFireTime = prevFireTime;
	}
	public BigInteger getNextFireTime() {
		return nextFireTime;
	}
	public void setNextFireTime(BigInteger nextFireTime) {
		this.nextFireTime = nextFireTime;
	}
	public String getTriggerState() {
		return triggerState;
	}
	public void setTriggerState(String triggerState) {
		this.triggerState = triggerState;
	}
	public String getTriggerType() {
		return triggerType;
	}
	public void setTriggerType(String triggerType) {
		this.triggerType = triggerType;
	}
	public String getCronExpression() {
		return cronExpression;
	}
	public void setCronExpression(String cronExpression) {
		this.cronExpression = cronExpression;
	}
	@Override
	public String toString() {
		return "QuartzJobInfoVO [schedName=" + schedName + ", jobName=" + jobName + ", jobGroup=" + jobGroup
				+ ", jobClassName=" + jobClassName + ", triggerName=" + triggerName + ", triggerGroup=" + triggerGroup
				+ ", prevFireTime=" + prevFireTime + ", nextFireTime=" + nextFireTime + ", triggerState=" + triggerState
				+ ", triggerType=" + triggerType + ", cronExpression=" + cronExpression + "]";
	}
	
	
}

