package com.ivucenter.cloud.portal.req.customer;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.ivucenter.cloud.entity.ReqCustomerVO;
import com.ivucenter.cloud.portal.util.AES256Util;
import com.ivucenter.cloud.portal.util.CodeUtil;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CustomReqCustomerVO extends ReqCustomerVO{

    private static final Logger logger = LoggerFactory.getLogger(CustomReqCustomerVO.class);

	private String searchKind;
	private String appvKind;
	private String keyword = "";

	private String codeId;
	private String apprvCodeKeyId;
	private String requestCodeKeyId;
	private String requestApprvState;




	//승인 메일 발송 추가 2017.08.24 이윤준
	private String userName;
	private String userPhone;
	private String userTel;
	private String userTelEx;
	private String userMail;
	private String orderUserId;
	private String deptName;
	private String deptName2;
	private String upCompanyName;
	private String adminName;
	private String orderNo;
	private String apprvScheduleUserId;
	private String apprvScheduleUserName;
	private String projectManagerType;
	private String projectManagerTypeName;
	private String apprvPass;
	private String userNameLevel;
	private String managerType;



	@JsonIgnore	public String getUserPhoneEnc() { return getEnc(userPhone); }
	@JsonIgnore	public String getUserPhoneDec() { return getDec(userPhone); }
	@JsonIgnore	public String getUserTelDec() { return getDec(userTel); }
	@JsonIgnore	public String getUserTelEnc() { return getEnc(userTel); }
	@JsonIgnore	public String getUserMailEnc() { return getEnc(userMail); }
	@JsonIgnore	public String getUserMailDec(){ return getDec(userMail); }

	@JsonIgnore	public String getUserTelExDec(){ return getDec(userTelEx); }
	@JsonIgnore	public String getUserTelExEnc() { return getEnc(userTel); }




	@JsonIgnore
	private String getEnc(String param){
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
	private String getDec(String param){
		if(StringUtils.isBlank(param)){ return ""; }
		try {
			AES256Util aes = new AES256Util(CodeUtil.KEY_SPEC);
			return aes.decrypt(param);
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			logger.error("getEnc Exception");
			return "";
		}
	}
}
