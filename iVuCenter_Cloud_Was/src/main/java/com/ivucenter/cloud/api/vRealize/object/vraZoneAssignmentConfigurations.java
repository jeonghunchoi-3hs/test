package com.ivucenter.cloud.api.vRealize.object;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class vraZoneAssignmentConfigurations {
	private int storageLimitGB;
	private int cpuLimit;
	private int memoryLimitMB;
	private String zoneId;
	private int maxNumberInstances;
	private int priority;
}
