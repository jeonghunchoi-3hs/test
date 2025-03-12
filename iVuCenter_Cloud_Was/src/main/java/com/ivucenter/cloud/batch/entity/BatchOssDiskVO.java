package com.ivucenter.cloud.batch.entity;

import com.ivucenter.cloud.entity.OssDiskVO;

public class BatchOssDiskVO extends OssDiskVO {
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
				"BatchOssDiskVO [apiDeletedStatus=" + apiDeletedStatus + "]";
	}
	
	
}
