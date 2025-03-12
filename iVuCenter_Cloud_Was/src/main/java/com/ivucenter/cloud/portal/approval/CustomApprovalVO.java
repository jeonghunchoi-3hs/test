package com.ivucenter.cloud.portal.approval;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.ivucenter.cloud.entity.ApprovalVO;
import com.ivucenter.cloud.portal.util.AES256Util;
import com.ivucenter.cloud.portal.util.CodeUtil;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CustomApprovalVO extends ApprovalVO{

    private static final Logger logger = LoggerFactory.getLogger(CustomApprovalVO.class);

	private String orderNo;
	private String userName;
	private String userMail;
	private String userPhone;

	private String billYyyy;
	private String apprvStat;

	private String billYyyymm;

	private String apprvAuth;

	private String billMasterApprvStat;

	@JsonIgnore
	public String getUserMailEnc(){
		if(StringUtils.isEmpty(userMail)){ return ""; }
		try {
			AES256Util aes = new AES256Util(CodeUtil.KEY_SPEC);
			return aes.encrypt(userMail);
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {

			logger.error("getUserMailEnc Exception");

			return "";
		}
	}
	@JsonIgnore
	public String getUserMailDec(){
		if(StringUtils.isEmpty(userMail)){ return ""; }
		try {
			AES256Util aes = new AES256Util(CodeUtil.KEY_SPEC);
			return aes.decrypt(userMail);
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {

			logger.error("getUserMailDec Exception");

			return "";
		}
	}
}
