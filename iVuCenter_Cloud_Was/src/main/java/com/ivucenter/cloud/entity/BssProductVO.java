package com.ivucenter.cloud.entity;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BssProductVO extends DataTableVO{

	//bss_product
	private String productSeq;
	private String productName;
	private String productCategory;
	private String regDatetime;
	private String regUserId;
	private String modDatetime;
	private String modUserId;
	private String delFlag = "N";
	private String monthlyPrice;
	private String vmdkFile;

	//bss_product_os
	private String itemId;
	private String vmImageId;
	private String vmImageName;

	//bss_product_vm
	private String vcpus;
	private String memGb;
	private String diskGb;
	private String imageType;

	//bss_product_app
	private String templateVcpus;
	private String templateMem;
	private String templatePod;
	private String templateId;
	private String templateName;
	private String templateNameSpace;
	private String templateProvider;

	//상품 카테고리 종류
	private String parentCodeId;
	private String codeName;
	private String codeId;
	private String diskType;

	//bss_product_app
	private String podCpu;
	private String podMem;
	private String podCnt;
	private String podPv;

}
