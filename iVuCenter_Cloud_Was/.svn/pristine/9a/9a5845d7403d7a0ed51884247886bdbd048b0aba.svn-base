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
import com.ivucenter.cloud.api.openstack.interfaces.PoolIF;
import com.ivucenter.cloud.api.openstack.object.OpenStackJsonObject;
import com.ivucenter.cloud.api.openstack.object.Pool;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;

import lombok.AccessLevel;
import lombok.NoArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class OpenStackPool extends OpenStackShared implements PoolIF {

	private String projectName;
	private String API_NETWORK_SERVER;

	public OpenStackPool(String projectName,CustomOssCloudVO cloudVo) {
		this.projectName = projectName;
		super.cloudVo = cloudVo;
		this.API_NETWORK_SERVER = cloudVo.getApiNetworkServer();
	}

	@Override
	public List<Pool> getPools() throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
//		headers.put("X-Auth-Token", getProjectToken(projectName));
		headers.put("X-Auth-Token", getAdminToken(super.cloudVo));

		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.GET, API_NETWORK_SERVER + "/floatingip_pools", headers);

		OpenStackJsonObject obj = JsonUtils.getJsonObject(output.getMessage());
		log.debug(JsonUtils.getJsonFormatString(obj));
		return obj.getPools();
	}

	@Override
	public Pool getPool(String pool_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getProjectToken(projectName,super.cloudVo));
		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.GET, API_NETWORK_SERVER+"/lbaas/pools/"+pool_id, headers);

		OpenStackJsonObject obj = JsonUtils.getJsonObject(output.getMessage());

		return obj.getPool();
	}

	@Override
	public Pool createPool(Pool pool) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		OpenStackJsonObject inJson = new OpenStackJsonObject();
		inJson.setPool(pool);

		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getProjectToken(projectName,super.cloudVo));
		String contentType = "application/json";
		String payLoad = JsonUtils.getJsonFormatString(inJson);
		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.POST, API_NETWORK_SERVER+"/lbaas/pools", headers, contentType, payLoad);
		OpenStackJsonObject obj = JsonUtils.getJsonObject(output.getMessage());
		return obj.getPool();
	}

	@Override
	public Pool updatePool(Pool pool) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		String pool_id = pool.getId();
		pool.setId(null);

		OpenStackJsonObject inJson = new OpenStackJsonObject();
		inJson.setPool(pool);

		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getProjectToken(projectName,super.cloudVo));
		String contentType = "application/json";
		String payLoad = JsonUtils.getJsonFormatString(inJson);
		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.PUT, API_NETWORK_SERVER+"/lbaas/pools/"+pool_id, headers, contentType, payLoad);
		OpenStackJsonObject obj = JsonUtils.getJsonObject(output.getMessage());
		return obj.getPool();
	}

	@Override
	public boolean deletePool(String pool_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getProjectToken(projectName,super.cloudVo));
		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.DELETE, API_NETWORK_SERVER+"/lbaas/pools/"+pool_id, headers, true);
		if (output.getStatusCode() == 204)
			return true;
		return false;
	}

	@Override
	public boolean isExist(String name) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		List<Pool> pools = getPools();
		for (Pool pool : pools) {
			if (pool.getName().equals(name))
				return true;
		}
		return false;
	}

}
