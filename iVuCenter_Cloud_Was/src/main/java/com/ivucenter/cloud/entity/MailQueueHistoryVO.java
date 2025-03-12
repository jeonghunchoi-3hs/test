package com.ivucenter.cloud.entity;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;

import org.apache.commons.lang.StringUtils;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.ivucenter.cloud.portal.util.AES256Util;
import com.ivucenter.cloud.portal.util.CodeUtil;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Getter
@Setter
@ToString
public class MailQueueHistoryVO extends DataTableVO{
	private String templateId;
	private String templateName;
	private String mailSeq;
	private String title;
	private String content;
	private String senderName;
	private String senderMail;
	private String receiverFlg;
	private String receiverId;
	private String receiverName;
	private String receiverMail;
	private int retryCount;
	private String resultFlg;
	private String resultDatetime;
	private String redirectUrl;
	
	@JsonIgnore	public String getSenderNameEnc() 	{ return getEnc(senderName); }
	@JsonIgnore	public String getSenderNameDec() 	{ return getDec(senderName); }	
	@JsonIgnore	public String getSenderMailEnc() 	{ return getEnc(senderMail); }
	@JsonIgnore	public String getSenderMailDec() 	{ return getDec(senderMail); }	
	@JsonIgnore	public String getReceiverIdEnc() 	{ return getEnc(receiverId); }
	@JsonIgnore	public String getReceiverIdDec() 	{ return getDec(receiverId); }	
	@JsonIgnore	public String getReceiverNameEnc() 	{ return getEnc(receiverName); }
	@JsonIgnore	public String getReceiverNameDec() 	{ return getDec(receiverName); }		
	@JsonIgnore	public String getReceiverMailEnc()	{ return getEnc(receiverMail); }
	@JsonIgnore	public String getReceiverMailDec()	{ return getDec(receiverMail); }
	
	@JsonIgnore
	private String getEnc(String param){
		if(StringUtils.isEmpty(param)){ return ""; }
		try {
			AES256Util aes = new AES256Util(CodeUtil.KEY_SPEC);
			return aes.encrypt(param);
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			log.error(e.getMessage());
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
			log.error(e.getMessage());
			return "";
		}
	}
}
