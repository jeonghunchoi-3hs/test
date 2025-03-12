package com.ivucenter.cloud.api.openshift.connector;

import java.util.HashMap;

import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;

import io.fabric8.kubernetes.client.Config;
import io.fabric8.kubernetes.client.ConfigBuilder;
import io.fabric8.kubernetes.client.KubernetesClientBuilder;
import io.fabric8.openshift.client.OpenShiftClient;

public class OpenShiftClientManager {
	public static HashMap<String, AccessTokenDetail> tokenMap = new HashMap<String, AccessTokenDetail>();

	public static String getToken(String masterUrl, String userName, String password) {

		String key = masterUrl + "~" + userName;

		if (tokenMap.containsKey(key)) {
			AccessTokenDetail atd = tokenMap.get(key);
			if (atd.isValidToken()) {
				return atd.getToken();
			}
		}

		AccessTokenDetail newAtd = AuthorizationUtils.authorize(masterUrl, userName, password);
		tokenMap.put(key, newAtd);

		return newAtd.getToken();
	}

	public static OpenShiftClient getClient(CustomOssCloudVO cloudVo) {
//		String token = OpenShiftClientManager.getToken(cloudVo.getApiGatewayServer(), cloudVo.getAdminUsername(), cloudVo.getAdminPassword());
		String token = "sha256~hyOT02fifToszJDbSP9QmXL9ZoiMYij5oZ_kd4KMips"; // openshift indetity server 통신 오류로 인한 하드코딩       지워야함

		Config config = new ConfigBuilder()
			    .withMasterUrl(cloudVo.getApiGatewayServer())
			    .withOauthToken(token)
			    .withTrustCerts(true)
			    .build();

		OpenShiftClient osClient = new KubernetesClientBuilder()
			    .withConfig(config)
			    .build().adapt(OpenShiftClient.class);

		return osClient;
	}
}
