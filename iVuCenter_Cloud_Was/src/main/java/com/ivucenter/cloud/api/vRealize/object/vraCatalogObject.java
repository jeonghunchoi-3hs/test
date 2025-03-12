package com.ivucenter.cloud.api.vRealize.object;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class vraCatalogObject {
	private String id;
	private List<vraCatalogObject> content;
	private String name;
	private String description;
	private vraCatalogType type;
	private String[] projectIds;
	private String createdAt;
	private String createdBy;
	private String lastUpdatedAt;
	private String lastUpdatedBy;
	private String iconId;
	private String bulkRequestLimit;
}
