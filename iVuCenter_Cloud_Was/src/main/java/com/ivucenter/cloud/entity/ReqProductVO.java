package com.ivucenter.cloud.entity;

import java.util.List;
import java.util.Map;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ReqProductVO extends DataTableVO{

	private String vmdkFile;
	//bss_order 주문서
	private String orderNo;
	private String orderUserId;
	private String orderName;
	private String description;
	private String apprvState;

	//bss_order_product 주문서 상품
	private String orderProductSeq;
	private String requestType;
	private String requestName;
	private String productCategory;
	private String orderSummary;
	private String hourlyFlag;
	private String amount;

	//bss_order_product_vm  주문서 상품 가상머신(oss_vm에 저장)
	private String onDemandFlag;
	private String applyDatetime;
	private String projectId;
	private String defaultNetworkId;
	private String defaultNetworkIp;
	private String hostname;
	private String hostnameAlias;
	private String vcpus;
	private String beforeVcpus;
	private String memGb;
	private String memMb;

	private String beforeMemGb;
	private String diskGb;
	private String vmProductSeq;
	private String osProductSeq;
	private String osProductName;
	private String vmCatalogSeq;
	private String regUserId;

	private String backupNetworkFlag;
	private String backupNetworkId;
	private String backupNetworkName;
	private String backupNetworkIp;
	private String imageId;
	private String imageName;
	private String imageScale;
	private String flavorId;
	private String azName;
	private String reqMessage;
	private String volumeType;

	//bss_order_product_disk
	private String vmUuid;
	private String diskName;
	private String diskType;
	private String beforeDiskGb;
	private String diskCatalogSeq;
	private String diskProductSeq;
	private String diskId;

	//bss_orderProduct_service
	private String serviceId;
	private String serviceCatalogSeq;
	private String serviceProductSeq;
	private String serviceEa;

	private String imageType;



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
	private int volume;
	private String label;
	private String params;
	private String templateVcpus;
	private String templateMem;
	private String templatePod;
	private String templateId;
	private String templateName;
	private String templateNameSpace;
	private String appNameSpace;
	private String appUid;
	private String kind;
	private String apiVersion;
	private String pod;
	private String appVersion;







	// 컨테이너 자원 사용현황
	private int serviceCnt;
	private int routesCnt;
	private int buildsCnt;
	private int deploymentConfigCnt;

	private String appAlias;
	private String pvcYn;


	//2017-07-29 박현오 추가
	private String orderUserName;
	private String totalAmount;

	// 결재라인
	private List<Map<String, String>> approvalStepList;
	private List<Map<String, String>> bssOrderProductVmUpdateList;
	private List<Map<String, String>> bssOrderProductNasUpdateList;

}
