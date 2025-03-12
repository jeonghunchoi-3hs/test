package com.ivucenter.cloud.portal.bss.discount;

import com.ivucenter.cloud.entity.BssDiscountVO;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CustomMngBssDiscountVO extends BssDiscountVO{
	
	private String searchKind;
	private String keyword = "";	
	
}
