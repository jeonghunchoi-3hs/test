package com.ivucenter.cloud.batch.entity;

import com.ivucenter.cloud.entity.OssServiceVO;

public class BatchOssServiceVO extends OssServiceVO {
	private String apiDeletedStatus;

	public String getApiDeletedStatus() {
		return apiDeletedStatus;
	}
	public void setApiDeletedStatus(String apiDeletedStatus) {
		this.apiDeletedStatus = apiDeletedStatus;
	}

	@Override
	public String toString() {
		return super.toString() +
				"BatchOssServiceVO [apiDeletedStatus=" + apiDeletedStatus + "]";
	}
	
	
}
