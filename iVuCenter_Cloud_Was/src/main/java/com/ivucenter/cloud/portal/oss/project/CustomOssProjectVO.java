package com.ivucenter.cloud.portal.oss.project;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.ivucenter.cloud.entity.OssProjectVO;
import com.ivucenter.cloud.portal.util.AES256Util;
import com.ivucenter.cloud.portal.util.CodeUtil;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CustomOssProjectVO extends OssProjectVO{

    private static final Logger logger = LoggerFactory.getLogger(CustomOssProjectVO.class);

	private String searchKind;
	private String keyword = "";

	private String customerName;
	private String projectCustomerName;
	private String companyName;

	private String userName;
	private String upCompanyName;
	private String managerName;
	private String companyId;
	private String deptName;
	private String deptName2;


	private String vmCnt;
	private String diskCnt;
	private String appCnt;
	private String networkCnt;
	private String pvCnt;
	private String fsCnt;

	private String nasGb;

	/** 프로젝트 매니저 = user 개인 정보 영역**/
	private String userId;
	private String userTel;
	private String userPhone;
	private String userMail;

	private String managerId;
	private String managerTel;
	private String managerTelEx;
	private String managerPhone;
	private String managerMail;

	/**
	 * 프로젝트 정보 수정
	 */
	private String projectNameOrg;

	private String  networkAlias;
	private String  networkName;
	private String  subnetName;
	private String  ipAddr;
	private String  gateway;

	/* 서비스 리스트 */
	private String serviceName;
	private String orderProductSeq;
	private String hourlyFlag;
	private String createDatetime;
	private String hostname;
	private String hostnameAlias;
	private String diskGb;
	private String diskCn;
	private String serviceCnt;
	private String envCnt;

	private String diskUsed;
	private String vmUsed;
	private String memUsed;
	private String vcpuUsed;
	private String nasUsed;

	private String serviceTypeAccount;
	private String serviceTypeSecurity;
	private String serviceTypeBackup;
	private String serviceTypeSw;
	private String serviceTypeDisk;
	private String serviceTypeAutoscale;
	private String serviceTypeApplicationRedistribution;
	private String serviceTypeCt;

	private String programSeq;
	private String projectDeptCode;
	private String provisioningSeq;
	private String loadbalancerEa;
	private String paas;
	private String cpuLimit;
    private String memLimit;
    private String storageLimit;
    private String cpuReq;
    private String memReq;
    private String podReq;
    private String volumeReq;
    private String quotaYn;
    private String buildConfigName;
    private String instanceType;

    private String listZeroKind="";

    //OSS_ENV
    private String envPath="";
    private String envVisibilityLevel="";
    private String envAlias="";

	@JsonIgnore	public String getUserTelEnc() 		{ return getEnc(userTel); }
	@JsonIgnore	public String getUserTelDec() 		{ return getDec(userTel); }
	@JsonIgnore public String getUserPhoneEnc() 	{ return getEnc(userPhone); }
	@JsonIgnore public String getUserPhoneDec() 	{ return getDec(userPhone); }
	@JsonIgnore public String getUserMailEnc() 		{ return getEnc(userMail); }
	@JsonIgnore public String getUserMailDec() 		{ return getDec(userMail); }
	@JsonIgnore public String getManagerTelEnc() 	{ return getEnc(managerTel); }
	@JsonIgnore public String getManagerTelDec() 	{ return getDec(managerTel); }
	@JsonIgnore public String getManagerTelExEnc() 	{ return getEnc(managerTelEx); }
	@JsonIgnore public String getManagerTelExDec() 	{ return getDec(managerTelEx); }
	@JsonIgnore public String getManagerPhoneEnc() 	{ return getEnc(managerPhone); }
	@JsonIgnore public String getManagerPhoneDec() 	{ return getDec(managerPhone); }
	@JsonIgnore public String getManagerMailEnc() 	{ return getEnc(managerMail); }
	@JsonIgnore public String getManagerMailDec() 	{ return getDec(managerMail); }

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
	private String getDec(String param) {
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
