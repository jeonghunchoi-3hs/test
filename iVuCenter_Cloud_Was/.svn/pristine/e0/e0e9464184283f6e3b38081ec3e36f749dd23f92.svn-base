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
public class MailQueueVO extends DataTableVO{

    private static final Logger logger = LoggerFactory.getLogger(MailQueueVO.class);

	private String mailSeq;
	private String templateId;
	private String title;
	private String content;
	private String senderName;
	private String senderMail;
	private String receiverFlg;		// 수신자 구분 (U: 사용자/USERRECEIVERFLG, C: 회원사/CUSTOMERRECEIVERFLG)
	private String receiverId;
	private String receiverName;
	private String receiverMail;
	private int    retryCount;
	private String regDatetime;
	private String regUserId;
	private String resultFlg;		// 전송 결과 (Y: 성공, N or null: 실패)
	private String redirectUrl;

	@JsonIgnore	public String getSenderNameEnc()  { return getEnc(senderName); }
	@JsonIgnore	public String getSenderNameDec()  { return getDec(senderName); }
	@JsonIgnore	public String getSenderMailEnc()  { return getEnc(senderMail); }
	@JsonIgnore	public String getSenderMailDec()  { return getDec(senderMail); }
	@JsonIgnore	public String getReceiverIdEnc()  { return getEnc(receiverId); }
	@JsonIgnore	public String getReceiverIdDec()  { return getDec(receiverId); }
	@JsonIgnore	public String getReceiverNameEnc(){ return getEnc(receiverName); }
	@JsonIgnore	public String getReceiverNameDec(){ return getDec(receiverName); }
	@JsonIgnore	public String getReceiverMailEnc(){ return getEnc(receiverMail); }
	@JsonIgnore	public String getReceiverMailDec(){ return getDec(receiverMail); }

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
