package com.ivucenter.cloud.api.openshift.object;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class OpsProjectMetadata {
	private String name;
	private String selfLink;
	private String uid;
	private String resourceVersion;
	private String creationTimestamp;
}
