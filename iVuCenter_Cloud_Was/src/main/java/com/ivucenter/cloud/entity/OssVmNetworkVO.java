package com.ivucenter.cloud.entity;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class OssVmNetworkVO extends DataTableVO{
	
	private String networkId;
	private String vmUuid;
	private String portNetworkId;
	private String backupNetworkId;
	private String portBackupNetworkId;
	private String regUserId;
	private String regDatetime;
	
}
