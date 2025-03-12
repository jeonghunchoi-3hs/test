package com.ivucenter.cloud.entity;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.Date;

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
public class CmmUserVO extends DataTableVO{

    private static final Logger logger = LoggerFactory.getLogger(CmmUserVO.class);

	private String userId;
	private String managerId;
	private String userName;
	private String userPassword;
	private String customerId;		// 회원사 ID
	private String deptCode;		// 부서
//	private String levelNm;			// 직급 (삭제)
	private String userLevel;		// 직급
	private String userPhone;		// 핸드폰
	private String userTel;			// 전화번호 (국선 )
	private String userTelEx;		// 전화번호 (사선)
	private String userMail;		// 이메일
	private String smsRecvFlag;		// SMS 수신여부 (Y/N)
	private String mailRecvFlag;	// 메일 수신여부 (Y/N)
	private String nhwithRecvFlag;  // 농협 수신여부 (Y/N)
	private Date   pwdModDatetime;	// 패스워드 변경일
	private String pwdInitFlag;		// 패스워드 변경여부
	private String userStatus;		// 사용자 상태
	private String userAuthority;	// 사용자 권한
	private String regDatetime;		// 등록일
	private String regUserId;		// 등록 ID
	private String modDatetime;		// 변경일
	private String modUserId;		// 변경 ID
	private String delFlag = "N";	// 비활성화 여부 (Y/N)
	private String lastLoginDatetime;// 마지막 로그인시간
	private int    passwordFailCnt;	// 로그인 실패 카운트
	private String userCloudAuthority;


	@JsonIgnore	public String getUserPhoneEnc(){ return getEnc(userPhone); }
	@JsonIgnore public String getUserPhoneEnc2() { return getEnc(userPhone.replaceAll("-", "")); }
	@JsonIgnore	public String getUserPhoneDec(){ return getDec(userPhone); }
	@JsonIgnore	public String getUserTelEnc()  { return getEnc(userTel); }
	@JsonIgnore	public String getUserTelDec()  { return getDec(userTel); }
	@JsonIgnore	public String getUserTelExEnc(){ return getEnc(userTelEx); }
	@JsonIgnore	public String getUserTelExDec(){ return getDec(userTelEx); }
	@JsonIgnore	public String getUserMailEnc() { return getEnc(userMail); }
	@JsonIgnore	public String getUserMailDec() { return getDec(userMail); }

	@JsonIgnore
	public String getEnc(String param){
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
	public String getDec(String param){
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
