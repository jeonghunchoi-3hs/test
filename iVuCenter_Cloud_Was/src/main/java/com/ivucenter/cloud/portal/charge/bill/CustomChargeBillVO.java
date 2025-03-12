package com.ivucenter.cloud.portal.charge.bill;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.ivucenter.cloud.entity.ChargeBillVO;
import com.ivucenter.cloud.portal.util.AES256Util;
import com.ivucenter.cloud.portal.util.CodeUtil;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CustomChargeBillVO extends ChargeBillVO{

    private static final Logger logger = LoggerFactory.getLogger(CustomChargeBillVO.class);

	private String searchKind = "";
	private String keyword = "";

	// 구분 고객사 프로젝트
	private String searchKey0 = ""; // cmm_company (계열사) 검색
	private String searchKey1 = ""; // cmm_customer (회원사) 검색
	private String searchKey2 = ""; // project_alias (프로젝트별칭) 검색

	private String userId;
	private String userName;
	private String roles;

	private String totAmount;	//총청구금액
	private String dcAmount;	//할인금액
	private String vatAmount;	//부가가치세

	private String AA00Amount;	//기본상품
	private String AE00Amount;	//부가상품
	private String AI00Amount;	//서비스
	private String A000Amount;	//클라우드상품
	private String LA00Amount;	//부가가치

	private String E000Amount;	//요금할인
	private String I000Amount;	//보정
	private String L000Amount;	//부가가치

	private String companyNo;
	private String userPhone;
	private String resourceDbTable;

	//bill_flag 2017.08.21 이윤준
	private String billFlag;

	private String diskAlias;
	private String apprvStat;

	private String loadbalancerName;
	private String nasName;

	//반려 카운트
	private String rejectCnt;
	private String stepCnt;


	private String companyName;
	private String usedAmount;

	private String stepId;

	private String deptName;
	private String managerDeptName;
	private String managerId;
	private String managerName;
	private String managerTel;
	private String serviceName;
	private String serviceType;
	private String serviceTypeName;
	private String serviceAccountAmount;
	private String serviceSecurityAmount;
	private String serviceBackupAmount;
	private String serviceSwAmount;
	private String serviceDiskAmount;
	private String cloudName;

	@JsonIgnore	public String getUserPhoneEnc() { return getEnc(userPhone); }
	@JsonIgnore	public String getUserPhoneDec() { return getDec(userPhone); }
	@JsonIgnore	public String getManagerTelEnc() { return getEnc(managerTel); }
	@JsonIgnore	public String getManagerTelDec() { return getDec(managerTel); }

	@JsonIgnore
	private String getEnc(String param){
		if(StringUtils.isEmpty(param)){ return ""; }
		try {
			AES256Util aes = new AES256Util(CodeUtil.KEY_SPEC);
			return aes.encrypt(param);
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
            logger.error("getEnc Exception");
			return "";
		}
	}
	@JsonIgnore
	private String getDec(String param){
		if(StringUtils.isEmpty(param)){ return ""; }
		try {
			AES256Util aes = new AES256Util(CodeUtil.KEY_SPEC);
			return aes.decrypt(param);
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			logger.error("getDec Exception");
			return "";
		}
	}

}
