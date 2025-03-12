package com.ivucenter.cloud.portal.mng.req.work;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.ivucenter.cloud.entity.ReqWorkVO;
import com.ivucenter.cloud.portal.util.AES256Util;
import com.ivucenter.cloud.portal.util.CodeUtil;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CustomMngReqWorkVO extends ReqWorkVO{

    private static final Logger logger = LoggerFactory.getLogger(CustomMngReqWorkVO.class);

	private String searchKind;
	private String keyword = "";

	private String searchKey;
	private String searchValue;

	private String searchAll;


	private String serviceTypeName;
	private String hostnameAlias;

	private String userId;
	private String customerName;
	private String upCompanyName;
	private String productBigo;
	private String productBigoEnter;
	private String time;

	private String productName;

	private String orderNo;
	private String serviceType;
	private String serviceName;
	private String projectPrice;
	private String projectCustomerName;
	private String projectDeptName;
	private String projectManagerName;
	private String projectManagerTel;
	private String reqServiceProductSeq;
	private String vmUuid;
	private String ossHostnameAlias;
	private String cloudId;
	private String appName;
	private String cloudType;
	private String envType;
	//엔서블

//getProjects
	private String anProjectId;
	private String anProjectType;
	private String anProjectName;

//getJobTemplates
	private String anTemplateId;
	private String anTemplateType;
	private String anTemplateName;
	private String anTemplateJobType;
	private String anTemplateInventory;
	private String anTemplateProject;
	private String anTemplateplaybook;


//getInventorys
	private String anInventoryId;
	private String anInventoryType;
	private String anInventoryName;
	private String anInventoryJobType;
	private String anInventoryInventory;
	private String anInventoryProject;
	private String anInventoryPlaybook;
	private String IpAddr;
	private String fixedIps;

// openshift
	private String autoscalerName;
	private int minReplicas;
	private int maxReplicas;
	private String appUid;
	private String autoscalerUuid;

	private String serviceId;
	private String hpaDivision;
	private String hpaMin;
	private String hpaMax;
	private String hpaContinue;
	private String hpaMinPod;
	private String hpaMaxPod;
	private String hpaIncrePod;

	private String scaleOutName;
	private String orderUserName;
	private String orderUserId;

	@JsonIgnore public String getProjectManagerTelEnc() { return getEnc(projectManagerTel); }
	@JsonIgnore public String getProjectManagerTelDec() { return getDec(projectManagerTel); }

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
