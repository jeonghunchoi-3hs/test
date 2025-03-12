package com.ivucenter.cloud.api.vRealize.object;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class vraBlockTracker {
	private String progress;
	private String message;
	private String FINISHED;
	private String[] resources;
	private String name;
	private String id;
	private String selfLink;
	private String deplomentId;
}
