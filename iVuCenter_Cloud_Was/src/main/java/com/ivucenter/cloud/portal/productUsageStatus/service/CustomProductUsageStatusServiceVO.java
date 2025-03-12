package com.ivucenter.cloud.portal.productUsageStatus.service;

import com.ivucenter.cloud.entity.DataTableVO;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CustomProductUsageStatusServiceVO extends DataTableVO{

	/**
	 * list search param
	 */
	private String searchKind;
	private String keyword = "";

	private String searchKey0;
	private String searchKey1;
	private String searchKey2;
	private String searchKey3;

	private String cloudId;
	private String cloudName;


	/**
	 * oss_service 컬럼
	 */
	private String sercieId;           //백업서비스ID
	private String projectId;          //프로젝트ID
	private String serviceEa;
	private String serviceType;
	private String serviceTypeName;
	private String serviceName;

	private String description;        //비고
	private String createDatetime;     //생성일시
	private String expireDatetime;     //해지일시
	private String deleteDatetime;     //삭제일시
	private String regDatetime;        //등록일시
	private String regUserId;          //등록자
	private String modDatetime;        //수정일시
	private String modUserId;          //수정자
	private String delFlag = "N";      //삭제여부
	private String backupCatalogSeq;   //백업카탈로그SEQ
	private String backupProductSeq;   //백업서비스상품SEQ
	private String hourlyFlag;         //시간단위과금여부
	private String vmUuid;             //가상서버UUID
	private String resourceName;


	/**
	 * addition
	 */
	private String companyName;
	private String customerId;
	private String customerName;
	private String projectName;
	private String projectAlias;
	private String hostname;
	private String hostnameAlias;

	private String accountCnt;
	private String securityCnt;
	private String backupCnt;
	private String swCnt;
	private String diskCnt;
	private String containerTerminalCnt;

	private String autoscaleCnt;
	private String applicationRedistributionCnt;


}
