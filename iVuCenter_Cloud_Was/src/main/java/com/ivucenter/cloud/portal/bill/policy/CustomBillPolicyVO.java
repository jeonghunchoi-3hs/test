package com.ivucenter.cloud.portal.bill.policy;

import com.ivucenter.cloud.entity.ReqCatalogueVO;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CustomBillPolicyVO extends ReqCatalogueVO{

	private String searchKind;
	private String keyword = "";	
	private String testee;
	
	private String cloudName;
	private String cloudKind;
	//적용 정책 플래그 'NOW' 이면 적용 정책임
	private String flag;
	private String modUserName;
	private String modDatetime2;
	
	private String active;
	private String beforeCatalogSeq;
	
}
