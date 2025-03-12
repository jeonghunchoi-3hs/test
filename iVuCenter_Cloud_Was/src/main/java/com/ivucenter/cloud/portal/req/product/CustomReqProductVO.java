package com.ivucenter.cloud.portal.req.product;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.ivucenter.cloud.entity.ReqProductVO;
import com.ivucenter.cloud.portal.util.AES256Util;
import com.ivucenter.cloud.portal.util.CodeUtil;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CustomReqProductVO extends ReqProductVO{

	private String searchKind;
	private String keyword = "";
    private String searchKindStatus;
    private String endDescription;
    private String content;
	private String searchAll;
	private String modUserId;
	private String regDatetime;
	private String modDatetime;
	private String dnsNameservers;

	// 코드 관련
	private String requestApprvState;
	private String requestCodeKeyId;
	private String apprvCodeKeyId;
	private String companyId;
	private String vmImageId;
	private String vmImageName;

	// 프로젝트 관련
	private String projectName;
	private String projectAlias;
	private String projectBoxId;
	private String customerName;
	private String managerId;
	private String managerName;
	private String managerPhone;	// 핸드폰
	private String managerTel;		// 외부 전화번호 국선
	private String managerTelEx;   	// 내선전화 번호 - Extension
	private String managerMail;

	//승인 관련
	private String stepId;
	private String userId;
	private String stepName;
	private String stepLevel;
	private String leftStepId;
	private String rightStepId;
	private String apprvDescription;
	private String apprvDatetime;
	private String apprvUserName;
	private String apprvUserId;
	private String userName;
	private String deptName;
	private String deptName2;
	private String apprvScheduleUserId;
	private String isAdmin;
	private String apprvScheduleUserName;
	private String apprvScheduleUserDeptCode;
	private String apprvScheduleUserDeptName;


	private String reqProjectDescription;
	private String reqProjectName;

	// 승인스텝
	private String apprvUserDeptCode;
	private String apprvUserDeptName;

	// 고객사
	private String upCompanyName;
	private String companyName;
	private String companyNo;

	private String productType;
	private String apprvAuth;

	private String nasGb2;
	private String vcpus2;
	private String memGb2;
	private String diskGb2;
	private String beforeDiskGb2;
	private String bastionFlavorId;
	private String reqServiceProductSeq;
	private String ansibleStatus;
	private String ansibleStatusMessage;
	private String bastionVmUserId;
	private String bastionVmUserPassword;

	private String serviceName;
	private String serviceProductName;
	private String serviceType;
	private String serviceTypeName;
	private String productName;

	// network
	private String subnetId;
	private String portNetworkId;
	private String portBackupNetworkId;

	//임시로 받아오는 값
	private String requestSeq;

	private String defaultNetworkAlias;
	private String networkAlias;
	private String createDatetime;

	//2017.07.28 박현오 추가

	//bss_basket_vm 테이블
	private String defaultNetworkName;
	private String vmProductName;
	//bss_basket_vm_network 테이블
	private String sharedNetworkSeq;
	private String sharedNetworkId;

	private String sharedNetwork;
	private String sharedNetworkName;
	private String selectedFlag;

	//bss_basket_disk 테이블 2017-07-19 이윤준 추가
	private String vmName;

	//bss_basket_nas 테이블 2017-07-21 이윤준 추가
	private String workUserId;

	//bss_basket_publicip 테이블 2017-07-21 이윤준 추가
	private String publicipEa;
	private String publicipProductSeq;

	//bss_basket_loadbalancer 테이블 2017-07-21 이윤준 추가
	private String loadbalancerName;
	private String loadbalancerEa;
	private String method;
	private String protocol;
	private String monitorType;
	private String loadbalancerProductSeq;

	//bss_basket_backup 테이블 2017-07-25 이윤준 추가
//	private String backupGb;
//	private String backupProductSeq;

	//bss_basket_mca 테이블 2017-07-25 이윤준 추가
//	private String mcaEa;
//	private String mcaProductSeq;

	//bss_basket_scm 테이블 2017-07-25 이윤준 추가
//	private String scmEa;
//	private String scmProductSeq;

	//bss_basket_security 테이블 2017-07-25 이윤준 추가
//	private String securityEa;
//	private String securityProductSeq;

	//2017-07-28 박현오 추가
	private String protocolName;
	private String methodName;
	private String monitorTypeName;
	private String networkChk;
	private String loadbalancerVm;

	private String vmDiskGb;
	private String orderProductNo;


	//2017-07-29 김남요 추가
	private String customerId;
	private String apprvStateName;
	private String orderCount;
	private String orderDatetime;


	//2017-07-31 박현오 추가
	private String reqWorkSeq;
	private String workState;

	//2017-08-02 박현오 추가
	private String workUserName;

	private String networkId;

	private String newCnt;
	private String changeCnt;
	private String exprCnt;
	private String provisioningSeq;
	private String provisioningStatus;
	private String provisioningStatusMessage;
	private String datastoreId;

	// 2017-12-11 cloud usage 추가
	private int vmTotal;
	private int vmUsed;
	private int vmAvail;
	private int vcpuTotal;
	private int vcpuUsed;
	private int vcpuAvail;
	private int memTotal;
	private int memUsed;
	private int memAvail;
	private int diskTotal;
	private int diskUsed;
	private int diskAvail;
	private int nasTotal;
	private int nasUsed;
	private int nasAvail;

	private String collDatetime;
	private String cloudId;
	private String cloudName;
	private String cloudType;
	private String cloudZone;

	private boolean roleYn;
	private String step;

	private String apprvPass;
	private String selectApprv;
	private String processVcpu;
	private String processDisk;
	private String processMem;
	private String ip;
	private String port;
	private String backNetworkAlias;
    private String gatewayIp;

	private String snapshotId;
	private String snapshotName;
	private String snapshotCatalogSeq;
	private String snapshotProductSeq;
	private String snapshotProductName;

	private String diskAlias;
	private String templateCatalogSeq;
	private String hApprvDatetime;

	//nutanix
	private String deviceUuid;
	private String storageContainerUuid;
	private String applicationUuid;
	private String hostUuid;
	private String powerState;
	private String vmdiskUuid;
	private String sizeGb;
	private String device;

	private String nasName;
	private String nasAlias;
	private String nasVmList;
	private int nasGb;
	private String beforeNasGb;
	private String nasChange;
	private String nasProductSeq;
	private String fixedIps;
	private String nasType;

	private String nasId;
	private String expireDatetime;
	private String deleteDatetime;
	private String nasCatalogSeq;
	private String nasNfsObjectId;
	private String envType;
	private String mountPath;
	private String pvcName;
	private String pvName;
	private String connectModel;
	private String connectStatus;

	private String nasFileSystemPath;
	private String nasOption;
	private String appUuid;
	private String hpaDivision;
	private String hpaMin;
	private String hpaMax;
	private String hpaContinue;
	private String hpaMinPod;
	private String hpaMaxPod;
	private String hpaIncrePod;

	private String token;

	// oss_env(개발환경)

	private String envId;
	private String envName;
	private String envAlias;
	private String envProductSeq;
	private String envCatalogSeq;
	private String envVisibilityLevel;
	private String envGroupUrl;
	private String envGroupName;
	private String envUserId;
	private String envUserName;
	private String envUserPassword;
	private String envUserEmail;
	private String envUserGroupRole;
	private String envAccessLevel;
	private String envUserGroupId;
	private String envPlatformId;
	private String evnProdcutSeq;
	private String envProdcutSeq;
	private String evnCatalogSeq;
	private String envUserFlag;
	private String deploymentPort;
	private String environmentStatus;
	private String beforeOrderProductSeq;
	private String beforeCpuLimit;
	private String beforeMemLimit;
	private String beforePodCnt;
	private String afterVersion;

	private String domainUrl;

	private String groupId;
	private String branchId;
	private String pipelineId;
	private String ref;
	private String url;
	private String visibility;
	private String branchName;
	private String cicdProjectId;
	private String cicdUserId;
	private String userEmail;
	private String branchProtected;
	private String password;
	private String name;
	private String branchTagId;
	private String path;
    private String webUrl;
    private String protectedYn;
    private String accessLevel;
    private String alias;

    private String ossProjectId;
    private String status;
    private String duration;

    private String cicdRequestType;
    private String syncAppStatus;
    private String deploysDirectory;


    private String cicdGroupName;
    private String cicdGroupPath;
    private String cicdProjectName;
    private String exportType;
    private String envApplicationVersion;
    private String imageProductName;
    private String prodProjectId;
    private String devUserName;
    private String codeName;

    private String jobId;
    private String jobName;
    private String stage;

    // 어플리케이션 버전, 상태값
    private String redeployDevAppVersion;
    private String deployStatus;
    private String copyStatus;
    private String productionStatus;

    private String instanceType;

    private List<String> emailList;
    private List<String> nameList;

    @JsonIgnore public String getPasswordEnc() { return getEnc(password); }
	@JsonIgnore	public String getPasswordDec() { return getDec(password); }

	@JsonIgnore public String getEnvUserEmailEnc() { return getEnc(envUserEmail); }
	@JsonIgnore	public String getEnvUserEmailDec() { return getDec(envUserEmail); }
	@JsonIgnore public String getUserEmailEnc() { return getEnc(userEmail); }
	@JsonIgnore	public String getUserEmailDec() { return getDec(userEmail); }
	@JsonIgnore public String getEnvUserPasswordEnc() { return getEnc(envUserPassword); }
	@JsonIgnore	public String getEnvUserPasswordDec() { return getDec(envUserPassword); }
	@JsonIgnore public String getBastionVmUserPasswordEnc() { return getEnc(bastionVmUserPassword); }
	@JsonIgnore	public String getBastionVmUserPasswordDec() { return getDec(bastionVmUserPassword); }

	@JsonIgnore
	public String getEnc(String param){
		if(StringUtils.isBlank(param)){ return ""; }
		try {
			AES256Util aes = new AES256Util(CodeUtil.KEY_SPEC);
			return aes.encrypt(param);
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
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
            return "";
		}
	}

//	public List<String> getEmailList(){
//		return emailList;
//	}
//
//	public void setEmailList(List<String> emailList) {
//		this.emailList = emailList.stream().map(this::getEnc).collect(Collectors.toList());
//	}

}
