package com.ivucenter.cloud.api.openstack.interfaces;

import java.util.List;

import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.api.openstack.object.SecurityGroupRule;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;

public interface SecurityGroupRuleIF {
	public SecurityGroupRule createSecurityGroupRule(SecurityGroupRule securityGroupRule,CustomOssCloudVO cloudVo) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public List<SecurityGroupRule> getSecurityGroupRules(String tenant_id,CustomOssCloudVO cloudVo) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
}
