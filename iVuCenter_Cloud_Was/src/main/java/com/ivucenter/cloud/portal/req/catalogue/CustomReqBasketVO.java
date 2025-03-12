package com.ivucenter.cloud.portal.req.catalogue;

import com.ivucenter.cloud.entity.ReqBasketVO;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CustomReqBasketVO extends ReqBasketVO{

	private String nasFileSystemPath;
	private String nasNfsObjectId;
	private String nasOption;
	private String nasVmList;
	private String nasVmServer;
	private String nasVmIp;
	private String nasName;
	private String nasAlias;
	private String cloudType;
	private String vmUuid;
	private String fixedIps;
	private String basketSeq;

	private String vmdkFile;
	private String codeId;
	private String codeName;
	private String networkChk;

	//서비스 상품 seq
	private String productSeq;
	private String requestName;
	private String projectAlias;
	private String vmDiskGb;

	private String methodName;
	private String protocolName;
	private String catalogSeq;
	private String imageName;
	private String monitorTypeName;
	private String networkAlias;
	private String serviceTypeName;
	/**
	 * 변경 요청시 사용되는 값
	 */
	private String beforeFlavorId;
	private String beforeVcpus;
	private String beforeMemGb;

	//2017.08.05 이윤준 추가
	private String backupId;
	private String serviceId;

	private String diskId;
	private String loadbalancerId;
	private String mcaId;
	private String nasId;
	private String publicipId;
	private String scmId;
	private String securityId;
	private String serviceType;
	private String serviceName;



	private String beforeNasGb="0";
	private String vmCatalogSeq;
	private String nasCatalogSeq;
	private String viewVcpus;

	private String viewMemGb;
	private String diskTypeCode;
	private String diskTypeName;
	private String changeVcpus;
	private String changeMemGb;
	private String changeDiskGb;
	private String diskProductName;
	private String vmImageName;

	private String osProductName;
	private String cloudId;
	private String cloudName;

	private String loadbalancerVm;

	private String publicipCatalogSeq;
	private String backupCatalogSeq;
	private String mcaCatalogSeq;
	private String scmCatalogSeq;
	private String securityCatalogSeq;

	private String datastoreId;

	private String instanceType;
}
