package com.ivucenter.cloud.entity;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class OssAvailabilityVO extends DataTableVO {

	private String projectId;

	private int vmTotal;
	private int vmUsed;
	private int vmAvail;

	private int vCpuTotal;
	private int vCpuUsed;
	private int vCpuAvail;

	private int memTotal;
	private int memUsed;
	private int memAvail;

	private int diskTotal;
	private int diskUsed;
	private int diskAvail;

	private int nasTotal;
	private int nasUsed;
	private int nasAvail;

	private Date collDatetime;
	private String cloudId;

}
