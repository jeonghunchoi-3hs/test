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
public class OssVO extends DataTableVO{

    private static final Logger logger = LoggerFactory.getLogger(OssVO.class);

	//oss_nas
	private String nasId;
	private String projectId;
	private String projectName;
	private String nasName;
	private String nasAlias;
	private String nasGb;
	private String description;
	private String createDatetime;
	private String expireDatetime;
	private String deleteDatetime;
	private String regDatetime;
	private String regUserId;
	private String modDatetime;
	private String modUserId;
	private String delFlag = "N";
	private String hourlyFlag;
	private String vmUuid;
	private String nasCatalogSeq;
	private String nasProductSeq;
	private String cloudId;
    private String nasFileSystemPath;
    private String nasNfsObjectId;
    private String nasType;

	//oss_backup
//	private String backupId;
//	private String backupGb;
//	private String backupProductSeq;
//	private String backupCatalogSeq;

	//oss_service

	private String serviceId;
	private String serviceEa;
	private String serviceType;
	private String serviceTypeName;
	private String serviceName;
	private String appUuid;


	private String serviceProductSeq;
	private String serviceCatalogSeq;

	//oss_loadbalancer
	private String loadbalancerId;
	private String networkId;
	private String loadbalancerName;
	private String protocol;
	private String method;
	private String monitorType;
	private String loadbalancerEa;
	private String loadbalancerCatalogSeq;
	private String loadbalancerProductSeq;
	private String networkAlias;
	private String loadbalancerVm;
	private String protocolName;
	private String methodName;
	private String monitorTypeName;
	private String projectCustomerName;
	private String regUserName;
	private String managerId;
	private String managerName;
	private String managerTel;
	private String managerPhone;
	private String managerTelEx;
	private String deptName;
	private String deptName2;
	//oss_mca
//	private String mcaId;
//	private String mcaEa;
//	private String mcaCatalogSeq;
//	private String mcaProductSeq;

	//oss_publicip
	private String publicipId;
	private String publicipEa;
	private String publicipCatalogSeq;
	private String publicipProductSeq;
	private String hostnameAlias;
	private String hostname;

	//oss_scm
//	private String scmId;
//	private String scmEa;
//	private String scmCatalogSeq;
//	private String scmProductSeq;

	//oss_security
//	private String securityId;
//	private String securityEa;
//	private String securityCatalogSeq;
//	private String securityProductSeq;

	//oss_snapshot
	private String snapshotId;
	private String snapshotName;
	private String snapshotCatalogSeq;
	private String snapshotProductSeq;
	private String diskId;
	private String diskAlias;

	private String imageName;
	private String productCategory;

	private String projectAlias;

	private String oldId;

	//oss_nas_history 2017.09.06 이윤준 추가
	private String requestType;
	private String applyDate;
	private String ip;
	private String port;
	private String projectBoxId;
	private String programSeq;
	private String vmCnt;

	@JsonIgnore public String getManagerTelEnc() 	{ return getEnc(managerTel); }
	@JsonIgnore public String getManagerTelDec() 	{ return getDec(managerTel); }
	@JsonIgnore public String getManagerTelExEnc() 	{ return getEnc(managerTelEx); }
	@JsonIgnore public String getManagerTelExDec() 	{ return getDec(managerTelEx); }
	@JsonIgnore public String getManagerPhoneEnc() 	{ return getEnc(managerPhone); }
	@JsonIgnore public String getManagerPhoneDec() 	{ return getDec(managerPhone); }


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

			logger.error("getEnc Exception");

			return "";
		}
	}

}
