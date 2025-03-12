package com.ivucenter.cloud.batch.entity;

import java.util.Date;

import com.ivucenter.cloud.entity.DataTableVO;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BatchCicdPipelineVO extends DataTableVO {

	private String pipelineId;
	private String cicdProjectId;
	private String appUid;
	private String ref;
	private String status;
	private String duration;
	private String appName;
	private String projectId;
	private String projectName;
	private String cicdRequestType; 		// CICD_REQTYPE_NEW_DEPLOY 신규, CICD_REQTYPE_REDEPLOY 재배포
	private String syncAppStatus;			// SYNC_APP_READY, SYNC_APP_ONGOING, SYNC_APP_FAIL, SYNC_APP_SUCCESS
	private String orderProductSeq;
	private String delFlag;

	private String regUserId;
	private String modUserId;
	private Date regDatetime;
	private Date modDatetime;

	private String cloudType;
	private String cloudId;
	private String envType;

	// bss_order_product_app
	private String templateProductSeq;
	private String templateCatalogSeq;
	private String osProductSeq;
	private String imageId;

}
