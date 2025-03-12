package com.ivucenter.cloud.entity;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BssProductOsVO extends DataTableVO{
	
	//bss_product
	private String productSeq;
	private String productName;
	private String productCategory;
	private String regDatetime;
	private String regUserId;
	private String modDatetime;
	private String modUserId;
	private String delFlag = "N";
	private String cloudId;
	
	//bss_product_os
	private String itemId; 					//
	private String vmImageId;				// (OpenStack) id
	private String vmImageName;				// (OpenStack) name
	private String imageAlias;				// Alias
	private String imageContent;			// Content
	private String imageType;				// Type
	private String imagePath;				// (OpenStack) file
	private String imageRange;				// (OpenStack) visibility
	private String imageSize;				// (OpenStack) size
	private String imageFormat;				// (OpenStack) disk_format
	private String containerFormat;	// (OpenStack) container_format
	
	//bss_product_vm
	private String vcpus;
	private String memGb;
	private String diskGb;
	
	//상품 카테고리 종류
	private String parentCodeId;
	private String codeName;
	private String codeId;	
	private String codeValue1;
	
}
