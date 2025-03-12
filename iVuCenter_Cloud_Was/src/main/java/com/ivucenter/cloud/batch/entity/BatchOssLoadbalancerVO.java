package com.ivucenter.cloud.batch.entity;

import com.ivucenter.cloud.entity.OssLoadbalancerVO;

public class BatchOssLoadbalancerVO extends OssLoadbalancerVO {
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
				"BatchOssLoadbalancerVO [apiDeletedStatus=" + apiDeletedStatus + "]";
	}
	
	
}
