package com.ivucenter.cloud.batch.entity;

import com.ivucenter.cloud.entity.OssPublicipVO;

public class BatchOssPublicipVO extends OssPublicipVO {
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
				"BatchOssPublicipVO [apiDeletedStatus=" + apiDeletedStatus + "]";
	}
	
	
}
