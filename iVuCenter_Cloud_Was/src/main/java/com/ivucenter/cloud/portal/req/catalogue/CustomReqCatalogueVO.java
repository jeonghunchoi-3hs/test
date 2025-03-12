package com.ivucenter.cloud.portal.req.catalogue;

import java.util.List;
import java.util.Map;

import com.ivucenter.cloud.entity.ReqCatalogueVO;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CustomReqCatalogueVO extends ReqCatalogueVO{

	private String searchKey; // 'project_name', 'project_alias', 'searchAll'
	private String searchValue;
	private String vmdkFile;

	private String reqProjectSeq;
	private String projectName;
	private String projectAlias;
	private String projectDescription;
	private String customerId;
	private String projectManagerId;
	private String projectId;
	private String serviceName;


	private String hourlyFlag="N"; // 카테고리 상품 과금 구분 값(월,시간)
	private String onDemandFlag="N";

	//2019.10.17 장중일
	private String enableRecommandFlag="Y";
	private List<String> conditionCategory;

	// 결재라인
	private String approvalStepListString;
	private List<Map<String, String>> approvalStepList;

	//바로주문시 vo
	private String applyTime;
	private String applyDatetime;

	private String hostname;
	private String hostnameAlias;
	private String totalPrice;
	private String cpucnt;
	private String memcnt;
	private String diskcnt;
	private String osProductSeq;

	private String requestSeq;
	private String flowId;

	private String networkId;
	private String defaultNetworkName;
	private String defaultNetworkAlias;
	private String defaultNetworkId;

	private String codeId;
	private String codeName;
	private String networkChk;

	private String cpuQuantity;
	private String memQuantity;

	//2017.07.17 이윤준 추가 수정
	private String vmDiskGb;
	private String vmDiskQuantity;
	private String vmDiskHourlyPrice;
	private String vmDiskMonthlyPrice;
	private String nasQuantity;
	private String nasHourlyPrice;
	private String nasMonthlyPrice;
	private String loadbalancerEa;
	private String loadbalancerQuantity;
	private String loadbalancerHourlyPrice;
	private String loadbalancerMonthlyPrice;
	private String publicipEa;
	private String publicipQuantity;
	private String publicipHourlyPrice;
	private String publicipMonthlyPrice;
	private String serviceId;
	private String serviceEa;
	private String serviceQuantity;
	private String serviceHourlyPrice;
	private String serviceMonthlyPrice;
	private String serviceType;
	private String catalogCategoryName;

	private String methodName;
	private String protocolName;
	private String monitorTypeName;

	//2017.07.20 박현오 추가
	private String fileId;

	private String diskQuantity;
	private String vmUuid;
	private String vmName;
	private String diskName;
	private String diskProductSeq;

	//2017.07.25 박현오 추가
	private String networkName;
	private String networkAlias;
	private String lowProjectName;

	//2017.07.26 박현오 추가
	private String vmNetwork;
	private String loadbalancerName;
	private String protocol;
	private String method;
	private String monitorType;
	private String loadbalancerProductSeq;

	//2017.08.03 박현오 추가
	private String vmNetworkName;
	private String vmNetworkChk;

	//2017.08.05 이윤준 추가
	private String backupId;
	private String diskId;
	private String loadbalancerId;
	private String mcaId;
	private String nasId;
	private String publicipId;
	private String scmId;
	private String securityId;
	private String requestType;
	private String beforeNasGb="0";

	private String backupNetworkFlag;
	private String backupNetworkId;
	private String backupNetworkName;
	private String flavorId;
	private String azName;
	private String reqMessage;
	private String vmImageType;
	private String imageType;
	private String volumeType;
	private String cloudType;
	private String userId;

	private String nasGb;
	private String nasName;
	private String nasAlias;
	private String nasNfsObjectId;
	private String nasFileSystemPath;

	private String datastoreId;
	private String projectBoxId;

	private String name;
	private String id;

	private String envType;
	private String envPath;
	private String envVisibilityLevel;
	private String envAlias;
	private String envName;
	private String envId;
	private String envGroupId;
	private String cicdUrl;

	private String instanceType;

}
