package com.ivucenter.cloud.entity;

import java.util.Date;

public class MeteringMeasureVO extends DataTableVO{
	private String metricId;
	private Date meteringDatetime;
	private double meteringValue;
	private Date regDatetime;
	private String regDateTimeToString;

	private String tableName;
	private int limit;

	
	
	/**
	 * @return the tableName
	 */
	public String getTableName() {
		return tableName;
	}
	/**
	 * @param tableName the tableName to set
	 */
	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	/**
	 * @return the limit
	 */
	public int getLimit() {
		return limit;
	}
	/**
	 * @param limit the limit to set
	 */
	public void setLimit(int limit) {
		this.limit = limit;
	}
	public String getMetricId() {
		return metricId;
	}
	public void setMetricId(String metricId) {
		this.metricId = metricId;
	}
	public Date getMeteringDatetime() {
		return meteringDatetime;
	}
	public void setMeteringDatetime(Date meteringDatetime) {
		this.meteringDatetime = meteringDatetime;
	}
	public double getMeteringValue() {
		return meteringValue;
	}
	public void setMeteringValue(double meteringValue) {
		this.meteringValue = meteringValue;
	}
	public Date getRegDatetime() {
		return regDatetime;
	}
	public void setRegDatetime(Date regDatetime) {
		this.regDatetime = regDatetime;
	}
	public String getRegDateTimeToString() {
		return regDateTimeToString;
	}
	public void setRegDateTimeToString(String regDateTimeToString) {
		this.regDateTimeToString = regDateTimeToString;
	}
	
	@Override
	public String toString() {
		return "MeteringMeasureVO [metricId=" + metricId + ", meteringDatetime=" + meteringDatetime + ", meteringValue="
				+ meteringValue + ", regDatetime=" + regDatetime + "]";
	}
	
	
}
