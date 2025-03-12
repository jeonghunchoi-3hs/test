package com.ivucenter.cloud.api.ansible;

import java.io.IOException;
import java.net.URL;

import com.google.gson.JsonObject;
import com.ivucenter.cloud.api.ansible.connector.AnsibleClientManager;
import com.ivucenter.cloud.api.common.utils.SystemCalculatorInfo;

import lombok.extern.slf4j.Slf4j;
import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

@Slf4j
public class AnsibleUtils {

	static boolean isDebug = true;

	public static AnsibleObject request(OkHttpClient client, Request request, AnsibleType type) throws IOException, AnsibleException {
		AnsibleObject absibleObejct = null;
		log.debug("Ansible url : "+request.url().toString());
		try (Response response = client.newCall(request).execute()) {
			if (response.isSuccessful() && response.body() != null) {
				String json_text = (response.body().string());
				absibleObejct = new AnsibleObject(type, json_text);
				log.debug(absibleObejct.toString());
			} else {
				throw new AnsibleException(response.code(), response.message());
			}
		}
		return absibleObejct;
	}

	public static AnsibleObject getProjects(SystemCalculatorInfo systemCalculatorInfo) throws Exception {
		String path = "/api/v2/projects/";
		URL url = new URL(systemCalculatorInfo.getAnsiblehost() + path);

		Request request = new Request.Builder().url(url).get().build();
		OkHttpClient client = AnsibleClientManager.getAnsibleClient(systemCalculatorInfo);

		return request(client, request, AnsibleType.PROJECT_LIST);
	}

	public static AnsibleObject getJobTemplates(SystemCalculatorInfo systemCalculatorInfo) throws Exception {
		String path = "/api/v2/job_templates/";
		URL url = new URL(systemCalculatorInfo.getAnsiblehost() + path);

		Request request = new Request.Builder().url(url).get().build();
		OkHttpClient client = AnsibleClientManager.getAnsibleClient(systemCalculatorInfo);

		return request(client, request, AnsibleType.JOB_TEMPLATE_LIST);
	}

	public static AnsibleObject getInventorys(SystemCalculatorInfo systemCalculatorInfo) throws Exception {
		String path = "/api/v2/inventories/";
		URL url = new URL(systemCalculatorInfo.getAnsiblehost() + path);

		Request request = new Request.Builder().url(url).get().build();
		OkHttpClient client = AnsibleClientManager.getAnsibleClient(systemCalculatorInfo);

		return request(client, request, AnsibleType.INVENTORY_LIST);
	}


	public static AnsibleObject getHosts(SystemCalculatorInfo systemCalculatorInfo) throws Exception {
		String path = "/api/v2/hosts/";
		URL url = new URL(systemCalculatorInfo.getAnsiblehost() + path);

		Request request = new Request.Builder().url(url).get().build();
		OkHttpClient client = AnsibleClientManager.getAnsibleClient(systemCalculatorInfo);

		return request(client, request, AnsibleType.INVENTORY_LIST);
	}


	public static AnsibleObject launchTemplates(SystemCalculatorInfo systemCalculatorInfo, String template_id) throws Exception {
		String path = "/api/v2/job_templates/"+ template_id + "/launch/";
		URL url = new URL(systemCalculatorInfo.getAnsiblehost() + path);

		JsonObject bodyJson = new JsonObject();

		RequestBody body = RequestBody.create(bodyJson.toString(), MediaType.parse("application/json"));
		Request request = new Request.Builder().url(url).post(body).build();

		OkHttpClient client = AnsibleClientManager.getAnsibleClient(systemCalculatorInfo);

		return request(client, request, AnsibleType.JOB_TEMPLATE_LAUNCH);
	}

	public static AnsibleObject addHost(SystemCalculatorInfo systemCalculatorInfo, String hostname, int inventory) throws Exception {
		String path = "/api/v2/hosts/";
		URL url = new URL(systemCalculatorInfo.getAnsiblehost() + path);

		JsonObject bodyJson = new JsonObject();
		bodyJson.addProperty("name", hostname);
		bodyJson.addProperty("inventory", inventory);
		bodyJson.addProperty("enabled", true);
		bodyJson.addProperty("variables", "{\"ansible_ssh_port\": 22002}");

		RequestBody body = RequestBody.create(bodyJson.toString(), MediaType.parse("application/json"));
		Request request = new Request.Builder().url(url).post(body).build();

		OkHttpClient client = AnsibleClientManager.getAnsibleClient(systemCalculatorInfo);

		return request(client, request, AnsibleType.JOB_TEMPLATE_LAUNCH);
	}

	public static AnsibleObject deleteHost(SystemCalculatorInfo systemCalculatorInfo, String hostId) throws Exception {
		String path = "/api/v2/hosts/"+hostId+"/";
		URL url = new URL(systemCalculatorInfo.getAnsiblehost() + path);


		Request request = new Request.Builder().url(url).delete().build();

		OkHttpClient client = AnsibleClientManager.getAnsibleClient(systemCalculatorInfo);

		return request(client, request, AnsibleType.JOB_TEMPLATE_LAUNCH);
	}


	public static AnsibleObject bastionUser(SystemCalculatorInfo systemCalculatorInfo, String userId, String password, String namespace) throws Exception {
		String path = "/api/v2/job_templates/23/launch/";
		URL url = new URL(systemCalculatorInfo.getAnsiblehost() + path);

		JsonObject extraVars = new JsonObject();
		JsonObject bodyJson = new JsonObject();

		bodyJson.addProperty("new_user", userId);
		bodyJson.addProperty("new_password", password);
		bodyJson.addProperty("target_project", namespace);

		extraVars.add("extra_vars", bodyJson);

		RequestBody body = RequestBody.create(extraVars.toString(), MediaType.parse("application/json"));
		Request request = new Request.Builder().url(url).post(body).build();

		OkHttpClient client = AnsibleClientManager.getAnsibleClient(systemCalculatorInfo);

		return request(client, request, AnsibleType.JOB_TEMPLATE_LAUNCH);
	}

	public static AnsibleObject nasSetIp(SystemCalculatorInfo systemCalculatorInfo, String macAddr, String ip4Addr) throws Exception {
		String path = "/api/v2/job_templates/19/launch/";
		URL url = new URL(systemCalculatorInfo.getAnsiblehost() + path);

		JsonObject extraVars = new JsonObject();
		JsonObject bodyJson = new JsonObject();

		bodyJson.addProperty("mac_addr", macAddr);
		bodyJson.addProperty("ip4_addr", ip4Addr);

		extraVars.add("extra_vars", bodyJson);

		RequestBody body = RequestBody.create(extraVars.toString(), MediaType.parse("application/json"));
		Request request = new Request.Builder().url(url).post(body).build();

		OkHttpClient client = AnsibleClientManager.getAnsibleClient(systemCalculatorInfo);

		return request(client, request, AnsibleType.JOB_TEMPLATE_LAUNCH);
	}

	public static AnsibleObject getStatus(SystemCalculatorInfo systemCalculatorInfo, String jobId) throws Exception {
		String path = "/api/v2/jobs/" + jobId;
		URL url = new URL(systemCalculatorInfo.getAnsiblehost() + path);

		Request request = new Request.Builder().url(url).get().build();
		OkHttpClient client = AnsibleClientManager.getAnsibleClient(systemCalculatorInfo);

		return request(client, request, AnsibleType.INVENTORY_LIST);
	}

}
