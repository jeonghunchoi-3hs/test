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
import com.ivucenter.cloud.api.openstack.interfaces.MemberIF;
import com.ivucenter.cloud.api.openstack.object.Member;
import com.ivucenter.cloud.api.openstack.object.OpenStackJsonObject;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;

import lombok.AccessLevel;
import lombok.NoArgsConstructor;

@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class OpenStackMember extends OpenStackShared implements MemberIF {

	private String projectName;
	private String API_GATEWAY_SERVER;

	public OpenStackMember(String projectName,CustomOssCloudVO cloudVo) {
		this.projectName = projectName;
		super.cloudVo = cloudVo;
		this.API_GATEWAY_SERVER = cloudVo.getApiGatewayServer();
	}

	@Override
	public List<Member> getMembers(String pool_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getProjectToken(projectName,super.cloudVo));

		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.GET, API_GATEWAY_SERVER+"/api/network/1.0" + "/lbaas/pools/"+pool_id+"/members", headers);

		OpenStackJsonObject obj = JsonUtils.getJsonObject(output.getMessage());
		return obj.getMembers();
	}

	@Override
	public Member getMember(String pool_id, String member_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getProjectToken(projectName,super.cloudVo));
		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.GET, API_GATEWAY_SERVER+"/api/network/1.0"+"/lbaas/pools/"+pool_id+"/members/"+member_id, headers);

		OpenStackJsonObject obj = JsonUtils.getJsonObject(output.getMessage());

		return obj.getMember();
	}

	@Override
	public Member createMember(String pool_id, Member member) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		OpenStackJsonObject inJson = new OpenStackJsonObject();
		inJson.setMember(member);

		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getProjectToken(projectName,super.cloudVo));
		String contentType = "application/json";
		String payLoad = JsonUtils.getJsonFormatString(inJson);
		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.POST, API_GATEWAY_SERVER+"/api/network/1.0"+"/lbaas/pools/"+pool_id+"/members", headers, contentType, payLoad);
		OpenStackJsonObject obj = JsonUtils.getJsonObject(output.getMessage());
		return obj.getMember();
	}

	@Override
	public Member updateMember(String pool_id, Member member) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		String member_id = member.getId();
		member.setId(null);

		OpenStackJsonObject inJson = new OpenStackJsonObject();
		inJson.setMember(member);

		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getProjectToken(projectName,super.cloudVo));
		String contentType = "application/json";
		String payLoad = JsonUtils.getJsonFormatString(inJson);
		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.PUT, API_GATEWAY_SERVER+"/api/network/1.0"+"/lbaas/pools/"+pool_id+"/members/"+member_id, headers, contentType, payLoad);
		OpenStackJsonObject obj = JsonUtils.getJsonObject(output.getMessage());
		return obj.getMember();
	}

	@Override
	public boolean deleteMember(String pool_id, String member_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getProjectToken(projectName,super.cloudVo));
		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.DELETE, API_GATEWAY_SERVER+"/api/network/1.0"+"/lbaas/pools/"+pool_id+"/members/"+member_id, headers, true);
		if (output.getStatusCode() == 204)
			return true;
		return false;
	}

	@Override
	public boolean isExist(String pool_id, String name) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		List<Member> members = getMembers(pool_id);
		for (Member member : members) {
			if (member.getName().equals(name))
				return true;
		}
		return false;
	}

}
