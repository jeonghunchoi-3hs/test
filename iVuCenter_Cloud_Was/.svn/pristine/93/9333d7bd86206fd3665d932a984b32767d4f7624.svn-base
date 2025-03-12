package com.ivucenter.cloud.batch.entity;

import com.ivucenter.cloud.entity.BillChargeResourceDetailVO;
import com.ivucenter.cloud.portal.util.DateUtils;

public class BatchBillChargeResourceDetailVO extends BillChargeResourceDetailVO {
	private String hourlyFlag;

	
	public String getHourlyFlag() {
		return hourlyFlag;
	}
	public void setHourlyFlag(String hourlyFlag) {
		this.hourlyFlag = hourlyFlag;
	}
	
	@Override
	public String toString() {
		return "BatchBillChargeVmResourceDetailVO " 
				+ "[billYyyymm=" + this.getBillYyyymm() 
				+ ", cloudId=" + this.getCloudId()
				+ ", customerId=" + this.getCustomerId() 
				+ ", projectId=" + this.getProjectId() 
				+ ", resourceId=" + this.getResourceId()
				+ ", resourceItem=" + this.getResourceItem() 
				+ ", measureValue=" + this.getMeasureValue()
				+ ", chargeStartDatetime=" + DateUtils.convertDateToString(this.getChargeStartDatetime(), "Asia/Seoul", "yyyy-MM-dd HH:mm:ss")
				+ ", chargeEndDatetime=" + DateUtils.convertDateToString(this.getChargeEndDatetime(), "Asia/Seoul", "yyyy-MM-dd HH:mm:ss") 
				+ ", hourlyFlag=" + this.getHourlyFlag()
				+ ", duration=" + this.getDuration()
				+ ", serviceType=" + this.getServiceType()
				+ ", volumeType=" + this.getVolumeType()
				+ ", imageItemId=" + this.getImageItemId()
				+ ", price=" + getPrice()
				+ "]";
	}

	
}
