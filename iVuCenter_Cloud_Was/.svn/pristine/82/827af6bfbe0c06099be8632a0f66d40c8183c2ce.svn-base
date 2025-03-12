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
public class ReqUserVO extends DataTableVO{

    private static final Logger logger = LoggerFactory.getLogger(ReqUserVO.class);

	private String reqUserSeq;
	private String userId;
	private String userName;
	private String userPassword;
	private String userPhone;
	private String userTel;    		// 회사 전번 외부
	private String userTelEx;		// 회사 전번 내부
	private String userMail;

	private String customerId;		// 회원사 Id
	private String companyId;		// 계열사 Id
	private String deptCode;		// 부서 Id
//	private String levelNm;			// 직급 (문자열)(삭제)
	private String userLevel;		// 직급 (문자열)

	private String smsRecvFlag;		// 문자 전송 여부
	private String mailRecvFlag;	// 메일 전송 여부
	private String nhwithRecvFlag;	// 농협 알림 여부

	private String regUserId;		// 가입요청자 id
	private String regDatetime;		// 가입요청 시간
	private String modUserId;		// 변경자 id
	private String modDatetime;		// 변경 시간

	private String apprvUserId;		// 승인자 id
	private String apprvDatetime;	// 승인 시간
	private String apprvFlag; 		// N : 신청 (default), Y : 승인, J : 거절
	private String description;		// 거절사유

	private String delFlag = "N";	// N : 사용(default), Y : 삭제


	@JsonIgnore	public String getUserPhoneEnc(){ return getEnc(userPhone); }
	@JsonIgnore	public String getUserPhoneDec(){ return getDec(userPhone); }
	@JsonIgnore	public String getUserTelEnc()  { return getEnc(userTel); }
	@JsonIgnore	public String getUserTelDec()  { return getDec(userTel); }
	@JsonIgnore	public String getUserTelExEnc(){ return getEnc(userTelEx); }
	@JsonIgnore	public String getUserTelExDec(){ return getDec(userTelEx); }
	@JsonIgnore public String getUserMailEnc() { return getEnc(userMail); }
	@JsonIgnore	public String getUserMailDec() { return getDec(userMail); }

	@JsonIgnore
	public String getEnc(String param){
		if(StringUtils.isBlank(param)){ return ""; }
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
		if(StringUtils.isBlank(param)) {
			return "";
		}
		try {
			AES256Util aes = new AES256Util(CodeUtil.KEY_SPEC);
			return aes.decrypt(param);
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {

            logger.error("getEnc Exception");

            return "";
		}
	}
}