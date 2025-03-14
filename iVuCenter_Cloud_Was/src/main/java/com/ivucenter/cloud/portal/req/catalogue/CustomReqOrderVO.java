package com.ivucenter.cloud.portal.req.catalogue;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.json.JSONArray;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.ivucenter.cloud.entity.ReqOrderVO;
import com.ivucenter.cloud.entity.ReqUserVO;
import com.ivucenter.cloud.portal.util.AES256Util;
import com.ivucenter.cloud.portal.util.CodeUtil;
import com.ivucenter.cloud.portal.util.JsonUtil;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CustomReqOrderVO extends ReqOrderVO {

	private static final Logger logger = LoggerFactory.getLogger(ReqUserVO.class);

	private String searchKind;
	private String keyword = "";
	private String productAt;

	private String cloudType;
	private String nasFileSystemPath;
	private String nasNfsObjectId;
	private String nasOption;
	private String vmNetworkList;
	private String vmIpList;
	private String vmUuidList;

	private String userId;
	private String vmdkFile;
	private String viewFlag;
	private String defaultNetworkName;
	private String defaultNetworkAlias;

	private String networkAlias;
	private String defaultNetworkIp;
	private String backupNetworkIp;
	private String codeId;
	private String codeName;
	private String networkChk;
	private String serviceName;

	//서비스 상품 seq
	private String productSeq;
	private String catalogSeq;
	private String loadbalancerVm;
	private String userName;
	private String requestName;
	private String imageName;
	private String vmImageType;
	private String vmDiskGb;

	private String methodName;
	private String protocolName;
	private String monitorTypeName;

	//2017.07.27 박현오 추가
	private String vmNetworkName;
	private String loadBalancerName;
	private String loadbalancerProductName;
	private String productName;


	private String orderUserName;
	private String orderUserDeptName;
	private String orderCount;
	private String apprvStateName;

	//2017.08.03 박현오 추가
	private String vmNetwork;
	private String vmNetworkChk;

	//2017.08.05 이윤준 추가
	private String backupId;
	private String loadbalancerId;
	private String mcaId;
	private String nasId;
	private String publicipId;
	private String scmId;
	private String securityId;
	private String beforeNasGb="0";
	private String serviceId;

	private String newCnt;
	private String changeCnt;
	private String exprCnt;
	private String stepName;
	private String stepLevel;

	private String newCntTotal;
	private String changeCntTotal;
	private String exprCntTotal;

	private String customerName;
	private String customerId;

	private String deptName;
	private String userPw;
	private String userTel;
	private String userMail;
	private String envId;
	private String modDatetime;
	private String modUserId;
	private String regDatetime;

	private String hiddenUserIdReview;
	private String hiddenUserIdApprove;
	private String serviceTypeName;
	private String diskAlias;
	private String changeVcpus;
	private String changeMemGb;
	private String changeDiskGb;
	private String changeNasGb;
	private String vmImageName;
	private String serviceProductName;
	private String bakupFixedIps;
	private String fixedIps;


	//200605추가
	private String networkId;

	private String cpucnt;
	private String memcnt;

	private String diskcnt;

	private String cloudId;
	private String cloudName;
	private String cloudImgPath;
	private String datastoreId;

	private String apprvPass;
	private String selectApprv;

	private String ip;
	private String port;

	//스냅샷
	private String snapshotName;
	private String snapshotId;
	private String snapshotProductSeq;
	private String snapshotCatalogSeq;

	private String envType;
	private String bastionEnvType;
	private String ansibleStatus;
	private String ansibleStatusMessage;
	private String bastionVmUserId;
	private String bastionVmUserPassword;
	private String beforeOrderProductSeq;
	private String beforeCpuLimit;
	private String beforeMemLimit;
	private String beforePodCnt;

	// bss_order_product_env(개발환경)
	private String envName;
	private String envAlias;
	private String envPlatformId;
	private String envProductSeq;
	private String envCatalogSeq;
	private String envVisibilityLevel;
	private String envGroupUrl;
	private String envGroupName;
	private String visibility;
	private String productCategoryName;

	// oss_env_user(개발자 저장 테이블)
	private String envUserId;
	private String envUserName;
	private String envUserEmail;
	private String envUserPassword;
	private String envUserFlag;
	private String regUserId;
	private String envAccessLevel;
	private String envUserGroupRole;
	private String cicdProjectId;
	private String cicdRequestType;
	private String appVersion;
	private String envApplicationVersion;

	//App
	private String templateProductSeq;
	private String appName;
	private String gitRepository;
	private String gitReference;
	private int cpuReq;
	private int cpuLimit;
	private int memReq;
	private int memLimit;
	private int podCnt;
	private int appCnt;
	private int volume;
	private String label;
	private String params;
	private String appNameProject;
	private String appUid;
	private String templateCatalogSeq;
	private int afterPodCount;

	private String instanceType;

	@JsonIgnore	public String getUserTelEnc()  { return getEnc(userTel); }
	@JsonIgnore	public String getUserTelDec()  { return getDec(userTel); }
	@JsonIgnore public String getUserMailEnc() { return getEnc(userMail); }
	@JsonIgnore	public String getUserMailDec() { return getDec(userMail); }

	@JsonIgnore public String getEnvUserEmailEnc() { return getEnc(envUserEmail); }
	@JsonIgnore	public String getEnvUserEmailDec() { return getDec(envUserEmail); }
	@JsonIgnore public String getEnvUserPasswordEnc() { return getEnc(envUserPassword); }
	@JsonIgnore	public String getEnvUserPasswordDec() { return getDec(envUserPassword); }

	@JsonIgnore
	public String getEnc(String param){
		if(StringUtils.isBlank(param)){ return ""; }
		try {
			AES256Util aes = new AES256Util(CodeUtil.KEY_SPEC);
			return aes.encrypt(param);
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {

            logger.error("getEnc Exception");

			return "";
		}
	}
	@JsonIgnore
	public String getDec(String param){
		if(StringUtils.isBlank(param)) {
			return "";
		}
		try {
			AES256Util aes = new AES256Util(CodeUtil.KEY_SPEC);
			return aes.decrypt(param);
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {

            logger.error("getEnc Exception");

            return "";
		}
	}

	// 결재라인
	private String approvalStepListString;
	private List<Map<String, Object>> approvalStepList;

	public void setApprovalStepList(String str) {
//		str = XssPreventer.unescape(str);
		if(str.length() != 0) {
			this.approvalStepList = new ArrayList<>();
			JSONArray jsonArray = new JSONArray(str);
			for (int i = 0; i < jsonArray.length(); i++) {
				jsonArray.getJSONObject(i);
				this.approvalStepList.add(JsonUtil.toMap(jsonArray.getJSONObject(i)));
			}
		}
	};

	// 개발자 라인
	private String devUserListString;
	private List<Map<String, Object>> devUserList;
	public void setDevUserList(String str) {
		if(str.length() != 0) {
			this.devUserList = new ArrayList<>();
			JSONArray jsonArray = new JSONArray(str);
			for (int i = 0; i < jsonArray.length(); i++) {
				jsonArray.getJSONObject(i);
				this.devUserList.add(JsonUtil.toMap(jsonArray.getJSONObject(i)));
			}
		}
	};

	private List<Map<String, Object>> receiverVmList;
	public void setReceiverVmList(String str) {
//		str = XssPreventer.unescape(str);
		if(str.length() != 0) {
			this.receiverVmList = new ArrayList<>();
			JSONArray jsonArray = new JSONArray(str);
			for (int i = 0; i < jsonArray.length(); i++) {
				jsonArray.getJSONObject(i);
				this.receiverVmList.add(JsonUtil.toMap(jsonArray.getJSONObject(i)));
			}
		}
	};

	private String pvcYn;
	private String appAlias;

	private String hpaDivision;
	private String hpaMax;
	private String hpaContinue;
	private String hpaMinPod;
	private String hpaMaxPod;
	private String hpaIncrePod;

	private String templateName;
	private String templateNameSpace;
	private String appOsProductSeq;
	private String provisioningStatus;
	private String provisioningStatusMessage;

	private String deploysName;
	private String gitRepo;
	private String branchId;
	private String deploysDirectory;
	private String deploysProductSeq;
	private String deploysCatalogSeq;
	private String domainUrl;
	private String deploymentPort;
	private String deploymentType;
	private String exportType;

}


