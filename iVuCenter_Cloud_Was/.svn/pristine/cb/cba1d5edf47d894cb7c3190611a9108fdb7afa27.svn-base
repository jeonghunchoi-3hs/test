package com.ivucenter.cloud.portal.oss.vm;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.ArrayList;
import java.util.Date;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.ivucenter.cloud.entity.OssVmVO;
import com.ivucenter.cloud.portal.util.AES256Util;
import com.ivucenter.cloud.portal.util.CodeUtil;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CustomOssVmVO extends OssVmVO{

    private static final Logger logger = LoggerFactory.getLogger(CustomOssVmVO.class);

	/**	 * list search param	 */
	private String searchKind;
	private String keyword = "";
	private String volumeType;

	/**	 * IF param	 */
	// oss_project
	private String projectName;
	private String projectAlias;

	// cmm_customer
	private String customerName;

	private String ipAddr;
	private String backUpIpAddr;
	private String status;
	private String power;
	private String error;
	private String action;

	private String networkAlias;
	private String networkName;
	private String networkId;
	private String passWord;

	// oss_disk
	private String sizeGb;

	// oss_port
	private Object fixedIps;
	private String bakupFixedIps;

	private String ip;
	// cmm_user
	private String userId;
	private String userName;
	private String userTel;
	private String actionType;
	private Date action_datetime;


	private ArrayList<String> addrList;
	private int blockSize =0 ;


	private Integer network;
	private Integer ram;
	private Integer cores;
	private Integer volumes;
	private Integer instances;
	private String deptName;

	private String workKind;
	private String workNetKind;
	private String createDatetime2;
	private String cloudId;
	private String cloudType;
	private String cloudName;

	//public String getRegDatetimeToString(){	return DateFormatUtils.format(getRegDatetime(), "yyyy-MM-dd HH:mm:ss");	}

	@JsonIgnore	public String getUserTelEnc() { return getEnc(userTel); }
	@JsonIgnore	public String getUserTelDec() { return getDec(userTel); }
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
