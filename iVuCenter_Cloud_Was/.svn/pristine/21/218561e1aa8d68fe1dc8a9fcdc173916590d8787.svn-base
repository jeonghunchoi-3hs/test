package com.ivucenter.cloud.entity;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.List;

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
public class MngNhwithVO extends DataTableVO{

    private static final Logger logger = LoggerFactory.getLogger(MngNhwithVO.class);

	//nhwith_template
	private String templateId;
	private String templateName;
	private String title;
	private String content;
	private String regDatetime;
	private String regUserId;
	private String modDatetime;
	private String modUserId;
	private String delFlag = "N";

	//nhwith_queue_history
	private String nhwithSeq;
	private String senderName;
	private String senderId;
	private String receiverId;
	private String receiverName;
	private String resultFlg;
	private String resultDatetime;
	private String receiverFlg;

	//nhwith queue
	private String SourceInfo;
	private List<String> receivers;
	private String result;
	private String nhwithUrl;
	private String pushMessage;
	private String useIds;

	private String orderNo;
	private String billYyyymm;

	@JsonIgnore public String getSenderNameEnc() 	{ return getEnc(senderName); }
	@JsonIgnore public String getSenderNameDec() 	{ return getDec(senderName); }
	@JsonIgnore public String getSenderIdEnc() 		{ return getEnc(senderId); }
	@JsonIgnore public String getSenderIdDec() 		{ return getDec(senderId); }
	@JsonIgnore public String getReceiverIdEnc() 	{ return getEnc(receiverId); }
	@JsonIgnore public String getReceiverIdDec() 	{ return getDec(receiverId); }
	@JsonIgnore public String getReceiverNameEnc() 	{ return getEnc(receiverName); }
	@JsonIgnore public String getReceiverNameDec() 	{ return getDec(receiverName); }

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
