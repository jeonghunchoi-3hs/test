package com.ivucenter.cloud.portal.bss.discount;

import com.ivucenter.cloud.entity.BssDiscountVO;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CustomBssDiscountVO extends BssDiscountVO{
	
	private String searchKind;
	private String keyword = "";
	
	
	private String companyName;
	private String customerName;
	private String projectAlias;
	private String gbn;
	
	private String regUserName;

	
}
