package com.ivucenter.cloud.api.openstack.object;

import com.ivucenter.cloud.entity.DataTableVO;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class OpenStackComplexQuota  extends DataTableVO{
	private Integer metadata_items;
	private Integer cores;
	private Integer instances;
	private Integer injected_files;
	private Integer injected_file_content_bytes;
	private Integer ram;

	private Integer security_group;
	private Integer security_group_rule;
	private Integer floatingip;
	private Integer network;
	private Integer port;
	private Integer router;
	private Integer subnet;

	private Integer volumes;
	private Integer snapshots;
	private Integer gigabytes;
	
	
	//openShipt 사용
	private Integer statusHardLimitCpu;
	private String statusHardLimitMemory;
	private Integer statusHardPV;
	private Integer statusHardPod;
	private Integer statusHardRequestCpu;
	private String statusHardRequestMemory;
	
	private Integer statusUsedLimitCpu;
	private String statusUsedLimitMemory;
	private Integer statusUsedPV;
	private Integer statusUsedPod;
	private Integer statusUsedRequestCpu;
	private String statusUsedRequestMemory;
		
	private Integer specHardLimitCpu;
	private String specHardLimitMemory;
	private Integer specHardPV;
	private Integer specHardPod;
	private Integer specHardRequestCpu;
	private String specHardRequestMemory;
	
	private Integer resultLimitCpu;
	private String resultLimitMemory;
	private Integer resultPV;
	private Integer resultPod;
	private Integer resultRequestCpu;
	private String resultRequestMemory;
	
	private String paramLimitCpu;
	private String paramLimitMemory;
	private String paramLimitMemoryType;
	
	private String paramPv;
	private String paramPod;
	private String paramRequestCpu;
	private String paramRequestMemory;
	private String paramRequestMemoryType;
	
	
	// 포탈에서 사용
	private String projectId;
	private String projectBoxId;
	private String projectName;
	private String cloudId;	
	private String cloudName;
	private String cloudType;
	
	
	
	
}
