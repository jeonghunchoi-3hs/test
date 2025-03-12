package com.ivucenter.cloud.portal.oss.application;

import com.ivucenter.cloud.entity.DataTableVO;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CustomOssAppVO extends DataTableVO{

	private String searchKind;
	private String keyword;
	private String appUid;
	private String projectId;
	private String serviceId;
	private String projectName;
	private String projectAlias;
	private String appName;
	private String appNameSpace;
	private String pvcName;
	private String pvName;
	private String appAlias;
	private String pod;
	private int cpuLimit;
	private int cpuReq;
	private int memLimit;
	private int memReq;
	private String createDatetime;
	private String deleteDatetime;
	private String regDatetime;
	private String regUserId;
	private String modDatetime;
	private String modUserId;
	private String userId;
	private String delFlag;
	private String hourlyFlag;
	private String kind;
	private String apiVersion;
	private String cloudType;
	private String cloudId;
	private String cloudName;
//	private String regDatetime2;
	private String createDatetime2;
	private String templateName;
	private String templateProductSeq;
	private String templateCatalogSeq;
	private String label;
	private String status;
	private String autoscalerUuid;
	private String autoscalerName;
	private String osProductSeq;
	private String spacReplicas;

	private String managerName;
	private String deptName;
	private String customerName;

	private int podTotal;
	private int volumeTotal;
	private int serviceTotal;
	private int routesTotal;
	private int buildsTotal;
	private int deploymentConfigTotal;

	private String imageType;
	private String productSeq;

	// oss_scale_out
	private String scaleOutUid;
	private String scaleOutName;
	private String hpaDivision;
	private int hpaMin;
	private int hpaMax;
	private int hpaIncrePod;
	private int hpaMinPod;
	private int hpaMaxPod;
	private int hpaContinue;

	private String projectBoxId;
	private String nameSpace;
	private String appImageName;
	private String envType;


}
