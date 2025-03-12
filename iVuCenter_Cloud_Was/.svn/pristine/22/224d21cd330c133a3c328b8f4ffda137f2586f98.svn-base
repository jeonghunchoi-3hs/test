package com.ivucenter.cloud.portal.oss.scaleOut;


import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;

import org.apache.commons.lang.StringUtils;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.ivucenter.cloud.entity.OssScaleOutVO;
import com.ivucenter.cloud.portal.util.AES256Util;
import com.ivucenter.cloud.portal.util.CodeUtil;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CustomScaleOutVO extends OssScaleOutVO{

	private String projectBoxId;
	private String projectName;
	private String projectAlias;
	private String cloudName;
	private String cpuMinMax;
	private String memMinMax;
	private String regUserName;
	private String projectCustomerName;
	private String deptName;
	private String managerId;
	private String managerName;
	private String managerTel;
	private String managerPhone;
	private String deptName2;
	private String appAlias;
	private String appImageName;
	private String userId;
	private String dcIdName;
	private String cloudId;
	private String appName;
	private String nameSpace;
	private String projectId;
	private String serviceId;



	@JsonIgnore	public String getManagerTelEnc() { return getEnc(managerTel); }
	@JsonIgnore	public String getManagerTelDec() { return getDec(managerTel); }
	@JsonIgnore
	private String getEnc(String param){
		if(StringUtils.isEmpty(param)){ return ""; }
		try {
			AES256Util aes = new AES256Util(CodeUtil.KEY_SPEC);
			return aes.encrypt(param);
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
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
			e.printStackTrace();
			return "";
		}
	}

}
