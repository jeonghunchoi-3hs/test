package com.ivucenter.cloud.batch.entity;

import java.util.Date;

import com.ivucenter.cloud.entity.MeteringMeasureVO;

public class BatchMeteringMeasureVO extends MeteringMeasureVO {
	
	private Date startRegDatetime;
	private Date endRegDatetime;
	private String serviceType;
	
	public String getServiceType() {
		return serviceType;
	}
	public void setServiceType(String serviceType) {
		this.serviceType = serviceType;
	}
	public Date getStartRegDatetime() {
		return startRegDatetime;
	}
	public void setStartRegDatetime(Date startRegDatetime) {
		this.startRegDatetime = startRegDatetime;
	}
	public Date getEndRegDatetime() {
		return endRegDatetime;
	}
	public void setEndRegDatetime(Date endRegDatetime) {
		this.endRegDatetime = endRegDatetime;
	}
	
	
}
