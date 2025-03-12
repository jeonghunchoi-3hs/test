package com.ivucenter.cloud.portal.cmm.cloud;


import com.ivucenter.cloud.entity.OssCloudVO;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CustomOssCloudVO extends OssCloudVO {
	
	private String searchKind;
	private String keyword = "";
	private String delFlag = "N";
	private String cloudRoles;
	private String rownum;
	private String projectYn;
	private String projectBoxId;
	private String subnetId;
	private String subnetName;
	private String subnetAlias;

}
