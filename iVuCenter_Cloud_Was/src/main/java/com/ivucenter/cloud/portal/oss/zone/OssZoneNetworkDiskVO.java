package com.ivucenter.cloud.portal.oss.zone;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class OssZoneNetworkDiskVO {

	private String zoneName;
	private String zoneAlias;
	private String networkId;
	private String networkName;
	private String networkAlias;
	private String volumeType;
	private String isAvailable;
	private String isBackup;
	private String cloudId;
	private String cloudType;
	private String cloudName;
	private String catalogSeq;
	private String vmImageType;
	private String zoneDisplayName;
	private String projectId;
	private String projectBoxId;
}

