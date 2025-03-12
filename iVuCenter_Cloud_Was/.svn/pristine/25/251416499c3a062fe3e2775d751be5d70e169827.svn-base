package com.ivucenter.cloud.entity;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.ivucenter.cloud.portal.util.AES256Util;
import com.ivucenter.cloud.portal.util.CodeUtil;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CmmCustomerVO extends DataTableVO{

    private static final Logger logger = LoggerFactory.getLogger(CmmCustomerVO.class);

	private String customerId;
	private String customerName;
	private String companyName;
	private String corporationNo;
	private String companyNo;
	private String companyRep;
	private String bizCondition;
	private String bizType;
	private String managerId;
	private String regDatetime;
	private String regUserId;
	private String modDatetime;
	private String modUserId;
	private String delFlag = "N";

	//테이블 변경 추가 2017-07-07 이윤준
	private String corporationNo1;
	private String corporationNo2;
	private String corporationNo3;

	private String companyNo1;
	private String companyNo2;
	private String companyNo3;

	private String vatRate;

	// 회원사 관리자 설정 2017-07-07 이윤준
	private String userId;
	private String userName;

	private String userPhone;
	private String userTel;

	private String userMail;
	private String userAuthority;
	private String authority0; // 고객사 관리자
	private String authority1; // 프로젝트 관리자
	private String authority2; // 회계담당
	private String authority3; // 일반사용자

	private String managerName;
	private String managerPhone;	// 핸드폰
	private String managerTel;		// 외부 전화번호 국선
	private String managerTelEx;   	// 내선전화 번호 - Extension
	private String managerMail;
	private String regUserName;

	private String userIdPattern;  // 아이디 앞 고유명사 ex) 한전 - KE

	private String managerDeptCode;  // 부서 코드
	private String managerDeptName;  // 부서 이름

	@JsonIgnore	public String getCompanyRepEnc() { return getEnc(companyRep); }
	@JsonIgnore	public String getCompanyRepDec() { return getDec(companyRep); }
	@JsonIgnore	public String getManagerPhoneEnc() { return getEnc(managerPhone); }
	@JsonIgnore	public String getManagerPhoneDec() { return getDec(managerPhone); }
	@JsonIgnore	public String getManagerTelEnc() { return getEnc(managerTel); }
	@JsonIgnore	public String getManagerTelDec() { return getDec(managerTel); }
	@JsonIgnore	public String getManagerTelExEnc() { return getEnc(managerTelEx); }
	@JsonIgnore	public String getManagerTelExDec() { return getDec(managerTelEx); }
	@JsonIgnore	public String getManagerMailEnc() { return getEnc(managerMail); }
	@JsonIgnore	public String getManagerMailDec() { return getDec(managerMail); }
	@JsonIgnore	public String getUserPhoneEnc() { return getEnc(userPhone); }
	@JsonIgnore	public String getUserPhoneDec() { return getDec(userPhone); }
	@JsonIgnore	public String getUserTelEnc() { return getEnc(userTel); }
	@JsonIgnore	public String getUserTelDec() { return getDec(userTel); }
	@JsonIgnore	public String getUserMailEnc() { return getEnc(userMail); }
	@JsonIgnore	public String getUserMailDec() { return getDec(userMail); }

	@JsonIgnore
	private String getEnc(String param) {
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
