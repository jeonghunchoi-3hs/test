package com.ivucenter.cloud.portal.oss.subnet;

import com.ivucenter.cloud.entity.OssSubnetVO;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CustomOssSubnetVO extends OssSubnetVO{
	
	private String searchKind;
	private String keyword = "";
	
	private String projectName;
	//update시 gatewayIp 변경 유무 체크를 위한 값
	private String gatewayIpBak;
	
	/**
	 * IF
	 */
	private String cidr;
	private Integer ipVersion;
	private String gatewayIp;
	private String allocationPools;
	private String dnsNameservers;
	private String hostRoutes;
	private String error;
	
	/**
	 * PopList
	 */
	private String aClass;
	private String bClass;
	private String cClass;
	private String workKind;
	private String workNetKind;
	private String ruleNetworkId;
	private String ruleNetworkName;
	private String codeName;
	
	//nutanix
	private String name;
	private String uuid;
	private boolean isDefault = false;
	
}
