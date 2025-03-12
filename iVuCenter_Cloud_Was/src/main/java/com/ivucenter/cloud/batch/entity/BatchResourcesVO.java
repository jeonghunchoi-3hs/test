package com.ivucenter.cloud.batch.entity;

import java.util.Date;

import com.ivucenter.cloud.entity.DataTableVO;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BatchResourcesVO extends DataTableVO {
	
	private String resourcesDate;
	private String projectId;
	private int servers;
	private int vcpus;
	private int memGb;
	private int diskGb;
	private int serversMin;
	private int serversMax;
	private int serversAvg;
	private int serversSum;	
	private int vcpusMin;
	private int vcpusMax;
	private int vcpusAvg;
	private int vcpusSum;	
	private int memGbMin;
	private int memGbMax;
	private int memGbAvg;
	private int memGbSum;	
	private int diskGbMin;
	private int diskGbMax;
	private int diskGbAvg;
	private int diskGbSum;
	private String regUserId;
	private Date regDatetime;

	
}
