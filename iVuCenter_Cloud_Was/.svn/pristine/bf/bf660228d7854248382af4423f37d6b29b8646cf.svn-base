package com.ivucenter.cloud.api.openstack;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpMethod;

import com.ivucenter.cloud.api.common.utils.JsonUtils;
import com.ivucenter.cloud.api.openstack.connector.OpenStackRestConnector;
import com.ivucenter.cloud.api.openstack.connector.RestResponse;
import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.api.openstack.interfaces.SecurityGroupRuleIF;
import com.ivucenter.cloud.api.openstack.object.OpenStackJsonObject;
import com.ivucenter.cloud.api.openstack.object.SecurityGroupRule;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;

import lombok.AccessLevel;
import lombok.NoArgsConstructor;

@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class OpenStackSecurityGroupRule extends OpenStackShared implements SecurityGroupRuleIF {

	private String projectName;
	private String API_NETWORK_SERVER;
	
	public OpenStackSecurityGroupRule(String projectName,CustomOssCloudVO cloudVo) {
		this.projectName = projectName;
		super.cloudVo = cloudVo;
		this.API_NETWORK_SERVER = cloudVo.getApiNetworkServer();
	}

	@Override
	public SecurityGroupRule createSecurityGroupRule(SecurityGroupRule securityGroupRule, CustomOssCloudVO cloudVo)
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		OpenStackJsonObject inJson = new OpenStackJsonObject();
		inJson.setSecurity_group_rule(securityGroupRule);

		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getProjectToken(projectName, cloudVo));
		String contentType = "application/json";
		String url = API_NETWORK_SERVER+"/security-group-rules";
		String payLoad = JsonUtils.getJsonFormatString(inJson);
		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.POST, url, headers, contentType, payLoad);
		OpenStackJsonObject obj = JsonUtils.getJsonObject(output.getMessage());
		return obj.getSecurity_group_rule();
	}

	@Override
	public List<SecurityGroupRule> getSecurityGroupRules(String tenant_id, CustomOssCloudVO cloudVo)
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
//		headers.put("X-Auth-Token", getAdminToken());
//		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.GET, API_BASE + "/security-groups", headers);


		headers.put("X-Auth-Token", getProjectToken(projectName,cloudVo));
		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.GET, API_NETWORK_SERVER+"/security-group-rules?tenant_id="+tenant_id, headers);
		//log.debug(output.getMessage());
		OpenStackJsonObject obj = JsonUtils.getJsonObject(output.getMessage());
		return obj.getSecurity_group_rules();
	}

}
