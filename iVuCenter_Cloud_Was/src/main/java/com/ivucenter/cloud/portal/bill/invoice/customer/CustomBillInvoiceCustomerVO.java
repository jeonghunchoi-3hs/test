package com.ivucenter.cloud.portal.bill.invoice.customer;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.ivucenter.cloud.entity.ChargeBillVO;
import com.ivucenter.cloud.portal.util.AES256Util;
import com.ivucenter.cloud.portal.util.CodeUtil;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CustomBillInvoiceCustomerVO extends ChargeBillVO{

    private static final Logger logger = LoggerFactory.getLogger(CustomBillInvoiceCustomerVO.class);

	// 검색
	private String searchKind;
	private String keyword = "";

	// 추가 검색 조건
	private String searchKey0;
	private String searchKey1;

	private String billYear1;
	private String billYear2;
	private String billMonth1;
	private String billMonth2;

	private String companyNo;
	private String upCompanyName;
	private String upCompanyId;
	private String companyName;
	private String companyId;
	private String userName;
	private String userPhone;
	private String userTel;
	private String A000Amount; //클라우드상품
	private String LA00Amount; //부가가치

	@JsonIgnore	public String getUserPhoneEnc() { return getEnc(userPhone); }
	@JsonIgnore	public String getUserPhoneDec() { return getDec(userPhone); }
	@JsonIgnore	public String getUserTelEnc()   { return getEnc(userTel); }
	@JsonIgnore	public String getUserTelDec()   { return getDec(userTel); }

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
