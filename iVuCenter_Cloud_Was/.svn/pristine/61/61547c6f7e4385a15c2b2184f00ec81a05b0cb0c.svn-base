package com.ivucenter.cloud.portal.req.project;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.ivucenter.cloud.api.openstack.connector.OpenStackRestConnector;
import com.ivucenter.cloud.entity.ReqProjectVO;
import com.ivucenter.cloud.portal.util.AES256Util;
import com.ivucenter.cloud.portal.util.CodeUtil;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CustomReqProjectVO extends ReqProjectVO {

    private static final Logger logger = LoggerFactory.getLogger(CustomReqProjectVO.class);

	private String searchKind;
	private String keyword = "";

	private String searchAll;
    private String projectAt;
	private String ossProjectName;
	private String reqProjectName;
	private String reqProjectDescription;
	private String projectManagerDeptName;
	private String codeId;
	private String codeName;
	private String reqNetworkSeq;
	private String netDfltKind;
	private String netDfltKindName;
	private String selectFlag;
	private String networkName;
	private String networkAlias;

	private String appvKind;
	private String roles;
	private String rolesName;
	private String projectManagerType;
	List<Map<String, Object>> jsonValues2;

	// 2017.08.24. 이윤준 추가 (프로젝트 작업완료후 메일 발송)
	private String receiverId;
	private String receiverName;
	private String receiverMail;

	// pho ������Ʈ insert����
	private String projectId;
	private String companyId;
	private String companyName;
	private String projectManagerId;
	private String regUserName;
	private String projectManagerName;
	private String projectStartDatetime;
	private String projectEndDatetime;

	// �ű�,����,���� Ÿ�� �߰�
	private String requestApprvState;
	private String requestCodeKeyId;
	private String apprvCodeKeyId;
	private String disabled;

	// 회사명 계열사명 수정 대응
	private String upCompanyName;
	private String adminName;
	private String pmName;

	private String hiddenUserIdReview;
	private String hiddenUserNameReview;
	private String hiddenUserIdApprove;
	private String hiddenUserNameApprove;
	private String userIdReview;
	private String userIdApprove;

	private String projectCustomerId;
	private String projectCustomerName;
	private String projectDeptCode;
	private String projectDeptName;
	private String projectRegDatetime;
	private String deptCode;
	private String deptName;
	private String deptName2;
	private String managerId;
	private String managerName;
	private String managerDeptName;
	private String managerTel;
	private String managerTelEx;
	private String managerPhone;
	private String userTel;
	private String adminiStratorId;
	private String projectAdminiStratorId;
	private String projectAdminiStratorName;
	private String projectAdminiStratorDeptName;
	private String projectAdminiStratorInfo;
	private Boolean roleYn;
    private String cloudName;
    private String cloudType;
    private String apprvPass;
    private String selectApprv;
    private String cloudImgPath;
    private String apprvUserId;
    private String paas;
    private String cpuLimit;
    private String memLimit;
    private String cpuReq;
    private String memReq;
    private String podReq;
    private String storageReq;
    private String volumeReq;
    private String quotaYn;
    private String cloudIds;
    private String appUuid;
    private String srApprovalStepHisCount;

    private String podCpuMin;
    private String podCpuMax;
    private String podMemMin;
    private String podMemMax;


	private String limitRangeCpuMin;
	private String limitRangeCpuMax;
	private String limitRangeMemMin;
	private String limitRangeMemMax;
	private String limitRangeCpuDefault;
	private String limitRangeMemDefault;
	private String limitRangeCpuDefaultRequest;
	private String limitRangeMemDefaultRequest;
	private String limitRangeCpuLimitRequestRatio;
	private String limitRangeMemLimitRequestRatio;

	private List<Map<String, String>> reqProjectCloudQuotaList;
	private List<Map<String, String>> reqProjectCloudQuotaNutanixList;

	private String subnetId;
	private String subnetName;
	private String subnetAlias;
	private String defaultSubnetYn;
	private String hApprvDatetime;


	@JsonIgnore	public String getManagerTelDec(){ return getDec(managerTel); }
	@JsonIgnore	public String getUserTelDec() 	{ return getDec(userTel); }

	@JsonIgnore
	public String getEnc(String param) {
		if (StringUtils.isEmpty(param)) {
			return "";
		}
		try {
			AES256Util aes = new AES256Util(CodeUtil.KEY_SPEC);
			return aes.encrypt(param);
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			logger.error("getEnc Exception");
			return "";
		}
	}

	@JsonIgnore
	public String getDec(String param) {
		if (StringUtils.isEmpty(param)) {
			return "";
		}
		try {
			AES256Util aes = new AES256Util(CodeUtil.KEY_SPEC);
			return aes.decrypt(param);
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			logger.error("getDec Exception");
			return "";
		}
	}

}
