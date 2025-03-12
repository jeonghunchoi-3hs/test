package com.ivucenter.cloud.portal.oss.disk;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CustomStorageVO {
	private String storageId;
	private String storageType;
	private String cloudId;
	private int usedSpace;
	private int totalSpace;
}
