package com.ivucenter.cloud.portal.cmm.network;

import com.ivucenter.cloud.entity.CmmNetworkVO;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CustomCmmNetworkVO extends CmmNetworkVO{
	
	private String searchKind;
	private String keyword = "";	
	
	private String customerId;
	private String customerHeardName;
	private String workKindName;
	private String workNetKindName;
	private String regUserName;
	private String ipAddr;
	private String gateway;
	
	private String companyName;
	
}
