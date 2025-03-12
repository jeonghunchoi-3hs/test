package com.ivucenter.cloud.entity;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MonitoringStatusVO extends DataTableVO{

	private String hostname;
	private String hostnameAlias;
	private String fixedIps;
	private String datetime;
	private float cpuUsedPct;
	private float memUsedPct;
	private String fsName;
	private float spaceUsedPct;
	private float receivedMb;
	private float sentMb;
	private float memCompUsedPct;
	private float readMb;
	private float writeMb;
	private float MemPagingUsedPct;
	private String cloudId;

	private String keyword;
	private String searchKind;


}
