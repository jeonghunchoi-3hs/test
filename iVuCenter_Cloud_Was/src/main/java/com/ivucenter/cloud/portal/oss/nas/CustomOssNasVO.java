package com.ivucenter.cloud.portal.oss.nas;

import com.ivucenter.cloud.entity.OssVO;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CustomOssNasVO extends OssVO{

	private String searchKind;
	private String keyword = "";

	private String searchKey;
	private String searchValue;

	private String hourlyPrice;
	private String monthlyPrice;
	private String nasQuantity;
	private String nasHourlyPrice;
	private String nasMonthlyPrice;
	private String vmName;
	private String vmAliasList;
	private String cloudType;
	private String vmNetworkList;
	private String vmUuidList;
	private String vmIpList;
	private String azName;

	private String createDatetime2;

}
