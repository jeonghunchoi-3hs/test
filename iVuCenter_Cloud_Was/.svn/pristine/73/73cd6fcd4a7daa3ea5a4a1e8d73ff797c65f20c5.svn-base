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
public class SmsQueueHistoryVO extends DataTableVO{

    private static final Logger logger = LoggerFactory.getLogger(SmsQueueHistoryVO.class);

	private String smsSeq;			// now + UUID
	private String smsShortSeq; 	// 15 byte 숫자 고유번호  (kepco에서 필요)
	private String templateId;		// SMS00 + gbn (33,55,21,...)
	private String templateName;
	private String senderName;		// 발신자 이름
	private String senderNumber;	// 발신자 핸드폰
	private String receiverFlg;		// 수신자 구분  (U: 사용자/USERRECEIVERFLG, C: 회원사/CUSTOMERRECEIVERFLG)
	private String receiverId;		// 수신자 사번
	private String receiverName;	// 수신자 이름
	private String receiverNumber;	// 수신자 핸드폰
	private String message;			// 메시지
	private int    retryCount;
	private String resultFlg;		// 결과 : Y/N
	private String resultDatetime;

	@JsonIgnore	public String getSenderNameEnc()	{ return getEnc(senderName); }
	@JsonIgnore	public String getSenderNameDec()	{ return getDec(senderName); }
	@JsonIgnore	public String getSenderNumberEnc()	{ return getEnc(senderNumber); }
	@JsonIgnore	public String getSenderNumberDec()	{ return getDec(senderNumber); }
	@JsonIgnore	public String getReceiverIdEnc()	{ return getEnc(receiverId); }
	@JsonIgnore	public String getReceiverIdDec()	{ return getDec(receiverId); }
	@JsonIgnore	public String getReceiverNameEnc()	{ return getEnc(receiverName); }
	@JsonIgnore	public String getReceiverNameDec() 	{ return getDec(receiverName); }
	@JsonIgnore	public String getReceiverNumberEnc(){ return getEnc(receiverNumber); }
	@JsonIgnore	public String getReceiverNumberDec(){ return getDec(receiverNumber); }

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
