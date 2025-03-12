package com.ivucenter.cloud.api.nas.object;

import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class NasObjectVO {


	private String virtualVolumeName;
	private String virtualServerId;
	private String filesystemId;
	private String filesystemPath;
	private String createPathIfNotExists;


	private String diskUsageLimit;
	private String diskUsageIsHard;
	private String diskUsageReset;
	private String diskUsageWarning;
	private String diskUsageSevere;
	private String fileCountLimit;
	private String fileCountIsHard;
	private String fileCountReset;
	private String fileCountWarning;
	private String fileCountSevere;
	private String logEvent;


	private String nfsName;
	private String nfsVirtaulServerId;
	private String nfsFilesystemId;
	private String nfsFilesystemPath;
	private String nfsAccessConfig;
	private String nfsSnapshotOption;
	private String nfsLocalReadCacheOption;
	private String nfsTransferToReplicationTargetSetting;


	private String nfsObjectId;
	private String ObjectId;
	private String path;
	private String name;
	private int nasGb;
	private String fixedIps;
	private String nasId;
	private String nasNfsObjectId;




	//netapp api
	private String svmUUID;
	private String policyName;
	private String exportPolicyID;
	private String exportPolicyName;
	private String clientIp;
	private String ruleId;
	private String newclinetIp;
	private String volumeName;
	private int volumeSize;
	private String jobUUID;
	private String mountPath;
	private int newSize;
	private String volumeUUID;

}
