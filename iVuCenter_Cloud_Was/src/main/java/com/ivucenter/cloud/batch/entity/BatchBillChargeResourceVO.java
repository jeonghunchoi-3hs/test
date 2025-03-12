package com.ivucenter.cloud.batch.entity;

import com.ivucenter.cloud.entity.BillChargeResourceVO;

import lombok.Getter;
import lombok.Setter;


@Getter
@Setter
public class BatchBillChargeResourceVO extends BillChargeResourceVO {
	
	private String hourlyFlag;
}
