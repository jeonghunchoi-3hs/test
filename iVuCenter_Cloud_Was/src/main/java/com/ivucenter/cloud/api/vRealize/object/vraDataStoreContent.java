package com.ivucenter.cloud.api.vRealize.object;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class vraDataStoreContent {
	private List<vraDataStoreContent> content;
	private int totalElements;
	private int numberOfElements;
	private String type;
	private String externalRegionId;
	private int freeSizeGB;
	private String[] cloudAccountIds;
	private String externalId;
	private String name;
	private String id;
	private String createdAt;
	private String updatedAt;
	private String organizationId;
	private String orgId;
	private List<vraDataStoreTag> tags;
}
