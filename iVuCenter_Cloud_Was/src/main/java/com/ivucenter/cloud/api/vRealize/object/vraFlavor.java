package com.ivucenter.cloud.api.vRealize.object;

import java.util.List;
import java.util.Map;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class vraFlavor {
	private List<vraFlavor> content;
	private String totalElements;
	private String numberOfElements;
	private Map<String,vraFlavor> mapping;
	private String cpuCount;
	private String memoryInMB;
}
