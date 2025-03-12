package com.ivucenter.cloud.entity;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MonitoringEventVO extends DataTableVO{

	private String omrowid;
	private String identifier;
	private String node;
	private String manager;
	private String agent;
	private String alertgroup;
	private String alertkey;
	private int severity;
	private String severityName;
	private String summary;
	private String firstoccurrence;
	private String firstoccurtime;
	private String lastoccurrence;
	private String lastoccurtime;
	private int acknowledged;
	private String itmdisplayitem;
	private String isFault;

	private int fatalCnt;
	private int criticalCnt;
	private int majorCnt;
	private int minorCnt;
	private int waringCnt;
	private int indeterminateCnt;
	private int clearCnt;

}
