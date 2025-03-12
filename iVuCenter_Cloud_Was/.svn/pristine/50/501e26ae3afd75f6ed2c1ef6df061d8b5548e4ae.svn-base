package com.ivucenter.cloud.api.nutanix;

import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.UUID;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.ivucenter.cloud.api.nutanix.connector.NutanixClientManager;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;

import lombok.extern.slf4j.Slf4j;
import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

@Slf4j
public class NutanixUtils {
	private Gson gson = new GsonBuilder().setPrettyPrinting().create();

	public static NutanixObject request(OkHttpClient client, Request request, NutanixType type)
			throws IOException, NutanixException {
		NutanixObject nutanixObject = null;
		log.debug(request.url().toString() + " (" + request.method() + ")");
		try (Response response = client.newCall(request).execute()) {
			if (response.isSuccessful() && response.body() != null) {
				String json_text = (response.body().string());
				nutanixObject = new NutanixObject(type, json_text);
				log.debug(nutanixObject.toString());
			} else {
				String json_text = response.body() != null ? response.body().string() : "body is null";
				nutanixObject = new NutanixObject(type, json_text);
				log.warn(nutanixObject.toString());
				throw new NutanixException(response.code(), response.message());
			}
		}
		return nutanixObject;
	}

	public static NutanixObject getVmList(CustomOssCloudVO cloudVo) throws NutanixException {
		try {
			String path = "/PrismGateway/services/rest/v2.0/vms";
			URL url = new URL(cloudVo.getApiGatewayServer() + path);

			Request request = new Request.Builder().url(url).get().build();
			OkHttpClient client = NutanixClientManager.getPrismClient(cloudVo);

			return request(client, request, NutanixType.VM_LIST);
			
		} catch (MalformedURLException e) {
			log.error(e.getMessage());
			throw new NutanixException(400, e.getMessage());
		} catch (IOException e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		}
	}

	public static NutanixObject getVmDetail(CustomOssCloudVO cloudVo, String uuid) throws NutanixException {
		try {
			String path = "/PrismGateway/services/rest/v2.0/vms/" + uuid + "?include_vm_disk_config=true"
					+ "&include_vm_nic_config=true";
			URL url = new URL(cloudVo.getApiGatewayServer() + path);

			Request request = new Request.Builder().url(url).get().build();
			OkHttpClient client = NutanixClientManager.getPrismClient(cloudVo);

			return request(client, request, NutanixType.VM);
		} catch (MalformedURLException e) {
			log.error(e.getMessage());
			throw new NutanixException(400, e.getMessage());
		} catch (IOException e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		}
	}

	public static NutanixObject attachDisk(CustomOssCloudVO cloudVo, String vm_uuid, String storage_container_uuid,
			long mb_size) throws NutanixException {
		try {
			String path = "/PrismGateway/services/rest/v2.0/vms/" + vm_uuid + "/disks/attach";
			URL url = new URL(cloudVo.getApiGatewayServer() + path);

			long size = 1024l * 1024l * mb_size;

			JsonObject bodyJson = new JsonObject();

			bodyJson.addProperty("uuid", vm_uuid);

			JsonArray array = new JsonArray();
			bodyJson.add("vm_disks", array);

			JsonObject disk = new JsonObject();

			disk.addProperty("is_cdrom", false);
			disk.addProperty("is_empty", false);
			disk.addProperty("is_scsi_pass_through", false);
			disk.addProperty("is_thin_provisioned", false);

			JsonObject vm_disk_create = new JsonObject();
			vm_disk_create.addProperty("storage_container_uuid", storage_container_uuid);
			vm_disk_create.addProperty("size", size);
			disk.add("vm_disk_create", vm_disk_create);

			array.add(disk);
			log.debug(new NutanixObject(NutanixType.APP, bodyJson.toString()).toString());
			RequestBody body = RequestBody.create(bodyJson.toString(), MediaType.parse("application/json"));

			Request request = new Request.Builder().url(url).post(body).build();
			OkHttpClient client = NutanixClientManager.getPrismClient(cloudVo);
			return request(client, request, NutanixType.RESULT);
		} catch (MalformedURLException e) {
			log.error(e.getMessage());
			throw new NutanixException(400, e.getMessage());
		} catch (IOException e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		}
	}

	public static NutanixObject detachDisk(CustomOssCloudVO cloudVo, String vm_uuid, String vmdisk_uuid,
			String device_uuid) throws NutanixException {
		try {
			String path = "/PrismGateway/services/rest/v2.0/vms/" + vm_uuid + "/disks/detach";
			URL url = new URL(cloudVo.getApiGatewayServer() + path);

			JsonObject bodyJson = new JsonObject();
			bodyJson.addProperty("uuid", vm_uuid);

			JsonArray array = new JsonArray();
			bodyJson.add("vm_disks", array);

			JsonObject disk = new JsonObject();

			JsonObject disk_address = new JsonObject();
			disk_address.addProperty("vmdisk_uuid", vmdisk_uuid);
			disk_address.addProperty("device_uuid", device_uuid);
			disk.add("disk_address", disk_address);

			array.add(disk);

			RequestBody body = RequestBody.create(bodyJson.toString(), MediaType.parse("application/json"));
			log.debug(new NutanixObject(NutanixType.RESULT, bodyJson.toString()).toString());
			Request request = new Request.Builder().url(url).post(body).build();
			OkHttpClient client = NutanixClientManager.getPrismClient(cloudVo);

			return request(client, request, NutanixType.RESULT);
		} catch (MalformedURLException e) {
			log.error(e.getMessage());
			throw new NutanixException(400, e.getMessage());
		} catch (IOException e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		}
	}

	public static NutanixObject updateDisk(CustomOssCloudVO cloudVo, String vm_uuid, String vmdisk_uuid,
			String device_uuid, String storage_container_uuid, long mb_size) throws NutanixException {
		try {
			String path = "/PrismGateway/services/rest/v2.0/vms/" + vm_uuid + "/disks/update";
			URL url = new URL(cloudVo.getApiGatewayServer() + path);

			long size = 1024l * 1024l * mb_size;

			JsonObject bodyJson = new JsonObject();

			JsonArray array = new JsonArray();
			bodyJson.add("vm_disks", array);

			JsonObject disk = new JsonObject();

			JsonObject disk_address = new JsonObject();
			disk_address.addProperty("vmdisk_uuid", vmdisk_uuid);
			disk_address.addProperty("device_uuid", device_uuid);
			disk.add("disk_address", disk_address);

			JsonObject vm_disk_create = new JsonObject();
			vm_disk_create.addProperty("storage_container_uuid", storage_container_uuid);
			vm_disk_create.addProperty("size", size);
			disk.add("vm_disk_create", vm_disk_create);

			array.add(disk);

			RequestBody body = RequestBody.create(bodyJson.toString(), MediaType.parse("application/json"));

			Request request = new Request.Builder().url(url).put(body).build();
			OkHttpClient client = NutanixClientManager.getPrismClient(cloudVo);

			return request(client, request, NutanixType.RESULT);
		} catch (MalformedURLException e) {
			log.error(e.getMessage());
			throw new NutanixException(400, e.getMessage());
		} catch (IOException e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		}
	}

	public static NutanixObject updateVmVcpus(CustomOssCloudVO cloudVo, String vm_uuid, Integer num_vcpus)
			throws NutanixException {
		try {
			String path = "/PrismGateway/services/rest/v2.0/vms/" + vm_uuid;
			URL url = new URL(cloudVo.getApiGatewayServer() + path);

			JsonObject bodyJson = new JsonObject();
			bodyJson.addProperty("num_vcpus", num_vcpus);

			RequestBody body = RequestBody.create(bodyJson.toString(), MediaType.parse("application/json"));

			Request request = new Request.Builder().url(url).put(body).build();
			OkHttpClient client = NutanixClientManager.getPrismClient(cloudVo);

			return request(client, request, NutanixType.RESULT);
		} catch (MalformedURLException e) {
			log.error(e.getMessage());
			throw new NutanixException(400, e.getMessage());
		} catch (IOException e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		}
	}

	public static NutanixObject updateVmMemory(CustomOssCloudVO cloudVo, String vm_uuid, int memory_mb)
			throws NutanixException {
		try {
			String path = "/PrismGateway/services/rest/v2.0/vms/" + vm_uuid;
			URL url = new URL(cloudVo.getApiGatewayServer() + path);

			JsonObject bodyJson = new JsonObject();
			bodyJson.addProperty("memory_mb", memory_mb);

			RequestBody body = RequestBody.create(bodyJson.toString(), MediaType.parse("application/json"));

			Request request = new Request.Builder().url(url).put(body).build();
			OkHttpClient client = NutanixClientManager.getPrismClient(cloudVo);

			return request(client, request, NutanixType.RESULT);
		} catch (MalformedURLException e) {
			log.error(e.getMessage());
			throw new NutanixException(400, e.getMessage());
		} catch (IOException e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		}
	}

	public static NutanixObject updateVmPowerState(CustomOssCloudVO cloudVo, String vm_uuid, String host_uuid,
			NutanixPowerState power_state) throws NutanixException {
		try {
			String path = "/PrismGateway/services/rest/v2.0/vms/" + vm_uuid + "/set_power_state";
			URL url = new URL(cloudVo.getApiGatewayServer() + path);

			JsonObject bodyJson = new JsonObject();
			bodyJson.addProperty("host_uuid", host_uuid);
			bodyJson.addProperty("uuid", vm_uuid);
			bodyJson.addProperty("transition", power_state.toString());

			RequestBody body = RequestBody.create(bodyJson.toString(), MediaType.parse("application/json"));

			Request request = new Request.Builder().url(url).post(body).build();
			OkHttpClient client = NutanixClientManager.getPrismClient(cloudVo);

			return request(client, request, NutanixType.RESULT);
		} catch (MalformedURLException e) {
			log.error(e.getMessage());
			throw new NutanixException(400, e.getMessage());
		} catch (IOException e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		}
	}

	@Deprecated
	public static NutanixObject getTaskStatus(CustomOssCloudVO cloudVo, String task_uuid) throws NutanixException {
		try {
			String path = "/PrismGateway/services/rest/v2.0/tasks/" + task_uuid;
			URL url = new URL(cloudVo.getApiGatewayServer() + path);

			Request request = new Request.Builder().url(url).get().build();
			OkHttpClient client = NutanixClientManager.getPrismClient(cloudVo);

			return request(client, request, NutanixType.TASK);
		} catch (MalformedURLException e) {
			log.error(e.getMessage());
			throw new NutanixException(400, e.getMessage());
		} catch (IOException e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		}
	}

	public static NutanixObject getBlueprintList(CustomOssCloudVO cloudVo) throws NutanixException {
		try {
			String path = "/api/nutanix/v3/blueprints/list";
			URL url = new URL(cloudVo.getCalmServer() + path);

			JsonObject bodyJson = new JsonObject();
			bodyJson.addProperty("kind", "blueprint");
//		bodyJson.addProperty("filter", "state==ACTIVE");

			RequestBody body = RequestBody.create(bodyJson.toString(), MediaType.parse("application/json"));

			Request request = new Request.Builder().url(url).post(body).build();
			OkHttpClient client = NutanixClientManager.getCalmClient(cloudVo);

			return request(client, request, NutanixType.BLUEPRINT_LIST);
		} catch (MalformedURLException e) {
			log.error(e.getMessage());
			throw new NutanixException(400, e.getMessage());
		} catch (IOException e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		}
	}

	public static NutanixObject getBlueprint(CustomOssCloudVO cloudVo, String blueprint_uuid) throws NutanixException {
		try {
			String path = "/api/nutanix/v3/blueprints/" + blueprint_uuid;
			URL url = new URL(cloudVo.getCalmServer() + path);

			Request request = new Request.Builder().url(url).get().build();
			OkHttpClient client = NutanixClientManager.getCalmClient(cloudVo);

			return request(client, request, NutanixType.BLUEPRINT);
		} catch (MalformedURLException e) {
			log.error(e.getMessage());
			throw new NutanixException(400, e.getMessage());
		} catch (IOException e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		}
	}

	public static NutanixObject deleteBlueprint(CustomOssCloudVO cloudVo, String blueprint_uuid) throws NutanixException {
		try {
			String path = "/api/nutanix/v3/blueprints/" + blueprint_uuid;
			URL url = new URL(cloudVo.getCalmServer() + path);

			Request request = new Request.Builder().url(url).delete().build();
			OkHttpClient client = NutanixClientManager.getCalmClient(cloudVo);

			return request(client, request, NutanixType.BLUEPRINT);
		} catch (MalformedURLException e) {
			log.error(e.getMessage());
			throw new NutanixException(400, e.getMessage());
		} catch (IOException e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		}
	}

	public static NutanixObject getBlueprintRuntimeEditables(CustomOssCloudVO cloudVo, String blueprint_uuid)
			throws NutanixException {
		try {
			String path = "/api/nutanix/v3/blueprints/" + blueprint_uuid + "/runtime_editables";
			URL url = new URL(cloudVo.getCalmServer() + path);

			Request request = new Request.Builder().url(url).get().build();
			OkHttpClient client = NutanixClientManager.getCalmClient(cloudVo);

			return request(client, request, NutanixType.BLUEPRINT_RUNTIME_EDITABLES);
		} catch (MalformedURLException e) {
			log.error(e.getMessage());
			throw new NutanixException(400, e.getMessage());
		} catch (IOException e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		}
	}

	public static NutanixObject launchBlueprint(CustomOssCloudVO cloudVo, String blueprint_uuid,
			String app_profile_reference_name, String app_profile_reference_uuid, String app_profile_reference_kind,
			String app_name, String app_description) throws NutanixException {

		try {
			String path = "/api/nutanix/v3/blueprints/" + blueprint_uuid + "/simple_launch";
			URL url = new URL(cloudVo.getCalmServer() + path);

			JsonObject bodyJson = new JsonObject();
			JsonObject spec = new JsonObject();
			bodyJson.add("spec", spec);

			spec.addProperty("app_name", app_name);
			spec.addProperty("app_description", app_description);

			JsonObject app_profile_reference = new JsonObject();
			spec.add("app_profile_reference", app_profile_reference);
			app_profile_reference.addProperty("kind", app_profile_reference_kind);
			app_profile_reference.addProperty("name", app_profile_reference_name);
			app_profile_reference.addProperty("uuid", app_profile_reference_uuid);

			RequestBody body = RequestBody.create(bodyJson.toString(), MediaType.parse("application/json"));
			Request request = new Request.Builder().url(url).post(body).build();

			OkHttpClient client = NutanixClientManager.getCalmClient(cloudVo);

			return request(client, request, NutanixType.RESULT);
		} catch (MalformedURLException e) {
			log.error(e.getMessage());
			throw new NutanixException(400, e.getMessage());
		} catch (IOException e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		}
	}

	public static NutanixObject getBlueprintStatus(CustomOssCloudVO cloudVo, String blueprint_uuid, String request_id)
			throws NutanixException {
		try {
			String path = "/api/nutanix/v3/blueprints/" + blueprint_uuid + "/pending_launches/" + request_id;
			URL url = new URL(cloudVo.getCalmServer() + path);

			Request request = new Request.Builder().url(url).get().build();
			OkHttpClient client = NutanixClientManager.getCalmClient(cloudVo);

			return request(client, request, NutanixType.BLUEPRINT_STATUS);
		} catch (MalformedURLException e) {
			log.error(e.getMessage());
			throw new NutanixException(400, e.getMessage());
		} catch (IOException e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		}
	}

	public static NutanixObject getAppList(CustomOssCloudVO cloudVo) throws NutanixException {
		try {
			String path = "/api/nutanix/v3/apps/list";
			URL url = new URL(cloudVo.getCalmServer() + path);

			JsonObject bodyJson = new JsonObject();
			bodyJson.addProperty("kind", "app");
			bodyJson.addProperty("length", 250);

			RequestBody body = RequestBody.create(bodyJson.toString(), MediaType.parse("application/json"));

			Request request = new Request.Builder().url(url).post(body).build();
			OkHttpClient client = NutanixClientManager.getCalmClient(cloudVo);

			return request(client, request, NutanixType.RESULT);
		} catch (MalformedURLException e) {
			log.error(e.getMessage());
			throw new NutanixException(400, e.getMessage());
		} catch (IOException e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		}
	}

	public static NutanixObject getAppByName(CustomOssCloudVO cloudVo, String name) throws NutanixException {
		try {
			String path = "/api/nutanix/v3/apps/list";
			URL url = new URL(cloudVo.getCalmServer() + path);

			JsonObject bodyJson = new JsonObject();
			bodyJson.addProperty("kind", "app");
			bodyJson.addProperty("filter", "name==" + name);

			RequestBody body = RequestBody.create(bodyJson.toString(), MediaType.parse("application/json"));

			Request request = new Request.Builder().url(url).post(body).build();
			OkHttpClient client = NutanixClientManager.getCalmClient(cloudVo);

			return request(client, request, NutanixType.RESULT);
		} catch (MalformedURLException e) {
			log.error(e.getMessage());
			throw new NutanixException(400, e.getMessage());
		} catch (IOException e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		}
	}

	public static NutanixObject getApp(CustomOssCloudVO cloudVo, String app_uuid) throws NutanixException {
		try {
			String path = "/api/nutanix/v3/apps/" + app_uuid;
			URL url = new URL(cloudVo.getCalmServer() + path);

			Request request = new Request.Builder().url(url).get().build();
			OkHttpClient client = NutanixClientManager.getCalmClient(cloudVo);

			return request(client, request, NutanixType.APP);
		} catch (MalformedURLException e) {
			log.error(e.getMessage());
			throw new NutanixException(400, e.getMessage());
		} catch (IOException e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		}
	}

	public static NutanixObject getVm(CustomOssCloudVO cloudVo, String vm_uuid) throws NutanixException {
		try {
			String path = "/api/nutanix/v3/vms/" + vm_uuid;
			URL url = new URL(cloudVo.getCalmServer() + path);

			Request request = new Request.Builder().url(url).get().build();
			OkHttpClient client = NutanixClientManager.getCalmClient(cloudVo);

			return request(client, request, NutanixType.VM);
		} catch (MalformedURLException e) {
			log.error(e.getMessage());
			throw new NutanixException(400, e.getMessage());
		} catch (IOException e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		}
	}

	@Deprecated
	public static NutanixObject getAppDetail(CustomOssCloudVO cloudVo, String app_uuid) throws NutanixException {
		try {
			String path = "/api/nutanix/v3/apps/" + app_uuid;
			URL url = new URL(cloudVo.getCalmServer() + path);

			Request request = new Request.Builder().url(url).get().build();
			OkHttpClient client = NutanixClientManager.getCalmClient(cloudVo);

			return request(client, request, NutanixType.APP);
		} catch (MalformedURLException e) {
			log.error(e.getMessage());
			throw new NutanixException(400, e.getMessage());
		} catch (IOException e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		}
	}

	public static NutanixObject deleteProject(CustomOssCloudVO cloudVo, String project_uuid) throws NutanixException {
		try {
			String path = "/api/nutanix/v3/projects/" + project_uuid;
			URL url = new URL(cloudVo.getCalmServer() + path);

			Request request = new Request.Builder().url(url).delete().build();
			OkHttpClient client = NutanixClientManager.getCalmClient(cloudVo);

			return request(client, request, NutanixType.RESULT);
		} catch (MalformedURLException e) {
			log.error(e.getMessage());
			throw new NutanixException(400, e.getMessage());
		} catch (IOException e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		}
	}

	public static NutanixObject deleteApp(CustomOssCloudVO cloudVo, String app_uuid) throws NutanixException {
		try {
			String path = "/api/nutanix/v3/apps/" + app_uuid;
			URL url = new URL(cloudVo.getCalmServer() + path);

			Request request = new Request.Builder().url(url).delete().build();
			OkHttpClient client = NutanixClientManager.getCalmClient(cloudVo);

			return request(client, request, NutanixType.RESULT);
		} catch (MalformedURLException e) {
			log.error(e.getMessage());
			throw new NutanixException(400, e.getMessage());
		} catch (IOException e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		}
	}

	public static NutanixObject getProjectList(CustomOssCloudVO cloudVo) throws NutanixException {
		try {
			String path = "/api/nutanix/v3/projects/list";
			URL url = new URL(cloudVo.getCalmServer() + path);

			JsonObject bodyJson = new JsonObject();
			bodyJson.addProperty("kind", "project");

			RequestBody body = RequestBody.create(bodyJson.toString(), MediaType.parse("application/json"));

			Request request = new Request.Builder().url(url).post(body).build();
			OkHttpClient client = NutanixClientManager.getCalmClient(cloudVo);

			return request(client, request, NutanixType.RESULT);
		} catch (MalformedURLException e) {
			log.error(e.getMessage());
			throw new NutanixException(400, e.getMessage());
		} catch (IOException e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		}
	}

	public static NutanixObject getProjectDefault(CustomOssCloudVO cloudVo) throws NutanixException {
		try {
			String path = "/api/nutanix/v3/projects/list";
			URL url = new URL(cloudVo.getCalmServer() + path);

			JsonObject bodyJson = new JsonObject();
			bodyJson.addProperty("kind", "project");
			bodyJson.addProperty("filter", "name==default");

			RequestBody body = RequestBody.create(bodyJson.toString(), MediaType.parse("application/json"));

			Request request = new Request.Builder().url(url).post(body).build();
			OkHttpClient client = NutanixClientManager.getCalmClient(cloudVo);

			return request(client, request, NutanixType.RESULT);
		} catch (MalformedURLException e) {
			log.error(e.getMessage());
			throw new NutanixException(400, e.getMessage());
		} catch (IOException e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		}
	}

	public static NutanixObject getProject(CustomOssCloudVO cloudVo, String project_uuid) throws NutanixException {
		try {
			String path = "/api/nutanix/v3/projects/" + project_uuid;
			URL url = new URL(cloudVo.getCalmServer() + path);

			Request request = new Request.Builder().url(url).get().build();
			OkHttpClient client = NutanixClientManager.getCalmClient(cloudVo);

			return request(client, request, NutanixType.PROJECT);
		} catch (MalformedURLException e) {
			log.error(e.getMessage());
			throw new NutanixException(400, e.getMessage());
		} catch (IOException e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		}
	}

	public static NutanixObject getTask(CustomOssCloudVO cloudVo, String task_uuid) throws NutanixException {
		try {
			String path = "/api/nutanix/v3/tasks/" + task_uuid;
			URL url = new URL(cloudVo.getCalmServer() + path);

			Request request = new Request.Builder().url(url).get().build();
			OkHttpClient client = NutanixClientManager.getCalmClient(cloudVo);

			return request(client, request, NutanixType.PROJECT);
		} catch (MalformedURLException e) {
			log.error(e.getMessage());
			throw new NutanixException(400, e.getMessage());
		} catch (IOException e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		}
	}

	public static NutanixObject createProject(CustomOssCloudVO cloudVo, String name, String description, int vCpu,
			int memory, int storage, String account_uuid, String default_subnet_uuid, String subnet_uuid,
			String cluster_uuid) throws NutanixException {
		try {
			String path = "/api/nutanix/v3/projects";
			URL url = new URL(cloudVo.getCalmServer() + path);

			long memoryByte = 1024l * 1024l * 1024l * memory;
			long storageByte = 1024l * 1024l * 1024l * storage;

			JsonObject bodyJson = new JsonObject();
			JsonObject spec = new JsonObject();
			bodyJson.add("spec", spec);

			spec.addProperty("name", name);
			spec.addProperty("description", description);

			JsonObject resources = new JsonObject();
			spec.add("resources", resources);

			JsonArray account_reference_list = new JsonArray();
			resources.add("account_reference_list", account_reference_list);

			JsonObject account_reference = new JsonObject();
			account_reference.addProperty("kind", "account");
			account_reference.addProperty("uuid", account_uuid);
			account_reference_list.add(account_reference);

			JsonObject resource_domain = new JsonObject();

			JsonArray resources_list = new JsonArray();
			resource_domain.add("resources", resources_list);

			JsonObject vcpu_limit = new JsonObject();
			vcpu_limit.addProperty("limit", vCpu);
			vcpu_limit.addProperty("resource_type", "VCPUS");
			resources_list.add(vcpu_limit);

			JsonObject memory_limit = new JsonObject();
			memory_limit.addProperty("limit", memoryByte);
			memory_limit.addProperty("resource_type", "MEMORY");
			resources_list.add(memory_limit);

			JsonObject storate_limit = new JsonObject();
			storate_limit.addProperty("limit", storageByte);
			storate_limit.addProperty("resource_type", "STORAGE");
			resources_list.add(storate_limit);

			JsonObject default_subnet = new JsonObject();
			default_subnet.addProperty("kind", "subnet");
			default_subnet.addProperty("uuid", default_subnet_uuid);
			resources.add("default_subnet_reference", default_subnet);

			JsonArray subnet_reference_list = new JsonArray();
			resources.add("subnet_reference_list", subnet_reference_list);

			JsonObject subnet_reference = new JsonObject();
			subnet_reference.addProperty("kind", "subnet");
			subnet_reference.addProperty("uuid", subnet_uuid);
			subnet_reference_list.add(subnet_reference);

			JsonArray cluster_reference_list = new JsonArray();
			resources.add("cluster_reference_list", cluster_reference_list);

			JsonObject cluster_reference = new JsonObject();
			cluster_reference.addProperty("kind", "cluster");
			cluster_reference.addProperty("uuid", cluster_uuid);
			cluster_reference_list.add(cluster_reference);

			JsonObject metadata = new JsonObject();
			metadata.addProperty("kind", "project");
			bodyJson.add("metadata", metadata);

			NutanixObject no = new NutanixObject(NutanixType.PROJECT, bodyJson.toString());
			log.debug(no.toString());
			RequestBody body = RequestBody.create(bodyJson.toString(), MediaType.parse("application/json"));

			Request request = new Request.Builder().url(url).post(body).build();
			OkHttpClient client = NutanixClientManager.getCalmClient(cloudVo);

			return request(client, request, NutanixType.RESULT);
		} catch (MalformedURLException e) {
			log.error(e.getMessage());
			throw new NutanixException(400, e.getMessage());
		} catch (IOException e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		}
	}

	public static NutanixObject createProjectInternal(CustomOssCloudVO cloudVo, String name, String description,
			int vCpu, int memory, int storage, String account_uuid, String default_subnet_uuid, String subnet_uuid,
			String cluster_uuid) throws NutanixException {
		try {
			String path = "/api/nutanix/v3/projects_internal";
			URL url = new URL(cloudVo.getCalmServer() + path);

			long memoryByte = 1024l * 1024l * 1024l * memory;
			long storageByte = 1024l * 1024l * 1024l * storage;

			JsonObject bodyJson = new JsonObject();
			JsonObject spec = new JsonObject();
			bodyJson.add("spec", spec);

			JsonObject project_detail = new JsonObject();
			spec.add("project_detail", project_detail);

			project_detail.addProperty("name", name);
			project_detail.addProperty("description", description);

			JsonObject resources = new JsonObject();
			project_detail.add("resources", resources);

			JsonArray account_reference_list = new JsonArray();
			resources.add("account_reference_list", account_reference_list);

			JsonObject account_reference = new JsonObject();
			account_reference.addProperty("kind", "account");
			account_reference.addProperty("uuid", account_uuid);
			account_reference_list.add(account_reference);

			JsonObject resource_domain = new JsonObject();

			JsonArray resources_list = new JsonArray();
			resource_domain.add("resources", resources_list);

			JsonObject vcpu_limit = new JsonObject();
			vcpu_limit.addProperty("limit", vCpu);
			vcpu_limit.addProperty("resource_type", "VCPUS");
			resources_list.add(vcpu_limit);

			JsonObject memory_limit = new JsonObject();
			memory_limit.addProperty("limit", memoryByte);
			memory_limit.addProperty("resource_type", "MEMORY");
			resources_list.add(memory_limit);

			JsonObject storate_limit = new JsonObject();
			storate_limit.addProperty("limit", storageByte);
			storate_limit.addProperty("resource_type", "STORAGE");
			resources_list.add(storate_limit);

			JsonObject default_subnet = new JsonObject();
			default_subnet.addProperty("kind", "subnet");
			default_subnet.addProperty("uuid", default_subnet_uuid);
			resources.add("default_subnet_reference", default_subnet);

			JsonArray subnet_reference_list = new JsonArray();
			resources.add("subnet_reference_list", subnet_reference_list);

			JsonObject subnet_reference = new JsonObject();
			subnet_reference.addProperty("kind", "subnet");
			subnet_reference.addProperty("uuid", subnet_uuid);
			subnet_reference_list.add(subnet_reference);

			JsonArray cluster_reference_list = new JsonArray();
			resources.add("cluster_reference_list", cluster_reference_list);

			JsonObject cluster_reference = new JsonObject();
			cluster_reference.addProperty("kind", "cluster");
			cluster_reference.addProperty("uuid", cluster_uuid);
			cluster_reference_list.add(cluster_reference);

			bodyJson.addProperty("api_version", "3.1");

			JsonObject metadata = new JsonObject();
			metadata.addProperty("kind", "project");
			bodyJson.add("metadata", metadata);

			NutanixObject no = new NutanixObject(NutanixType.PROJECT, bodyJson.toString());
			log.debug(no.toString());
			RequestBody body = RequestBody.create(bodyJson.toString(), MediaType.parse("application/json"));

			Request request = new Request.Builder().url(url).post(body).build();
			OkHttpClient client = NutanixClientManager.getCalmClient(cloudVo);

			return request(client, request, NutanixType.RESULT);
		} catch (MalformedURLException e) {
			log.error(e.getMessage());
			throw new NutanixException(400, e.getMessage());
		} catch (IOException e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		}
	}

	public static NutanixObject createProject(CustomOssCloudVO cloudVo, String name, String description, int vCpu,
			int memory, int storage, String account_uuid, String default_subnet_uuid, String[] subnets)
			throws NutanixException {
		try {
			String path = "/api/nutanix/v3/projects";
			URL url = new URL(cloudVo.getCalmServer() + path);

			long memoryByte = 1024l * 1024l * 1024l * memory;
			long storageByte = 1024l * 1024l * 1024l * storage;

			JsonObject bodyJson = new JsonObject();
			JsonObject spec = new JsonObject();
			bodyJson.add("spec", spec);

			spec.addProperty("name", name);
			spec.addProperty("description", name);
			//디스크립션 프로젝트 name 으로 저장되도록 수정
			//spec.addProperty("description", description);

			JsonObject resources = new JsonObject();
			spec.add("resources", resources);

			JsonArray account_reference_list = new JsonArray();
			resources.add("account_reference_list", account_reference_list);

			JsonObject account_reference = new JsonObject();
			account_reference.addProperty("kind", "account");
			account_reference.addProperty("uuid", account_uuid);
			account_reference_list.add(account_reference);

			JsonObject resource_domain = new JsonObject();
			resources.add("resource_domain", resource_domain);

			JsonArray resources_list = new JsonArray();
			resource_domain.add("resources", resources_list);

			JsonObject vcpu_limit = new JsonObject();
			vcpu_limit.addProperty("limit", vCpu);
			vcpu_limit.addProperty("resource_type", "VCPUS");
			resources_list.add(vcpu_limit);

			JsonObject memory_limit = new JsonObject();
			memory_limit.addProperty("limit", memoryByte);
			memory_limit.addProperty("resource_type", "MEMORY");
			resources_list.add(memory_limit);

			JsonObject storate_limit = new JsonObject();
			storate_limit.addProperty("limit", storageByte);
			storate_limit.addProperty("resource_type", "STORAGE");
			resources_list.add(storate_limit);

			JsonObject default_subnet = new JsonObject();
			default_subnet.addProperty("kind", "subnet");
			default_subnet.addProperty("uuid", default_subnet_uuid);
			resources.add("default_subnet_reference", default_subnet);

			JsonArray subnet_reference_list = new JsonArray();
			resources.add("subnet_reference_list", subnet_reference_list);

			for (String subnet_uuid : subnets) {
				JsonObject subnet_reference = new JsonObject();
				subnet_reference.addProperty("kind", "subnet");
				subnet_reference.addProperty("uuid", subnet_uuid);
				subnet_reference_list.add(subnet_reference);
			}

			JsonObject metadata = new JsonObject();
			metadata.addProperty("kind", "project");
			bodyJson.add("metadata", metadata);

			NutanixObject no = new NutanixObject(NutanixType.PROJECT, bodyJson.toString());
			log.debug(no.toString());

			RequestBody body = RequestBody.create(bodyJson.toString(), MediaType.parse("application/json"));

			Request request = new Request.Builder().url(url).post(body).build();
			OkHttpClient client = NutanixClientManager.getCalmClient(cloudVo);

			return request(client, request, NutanixType.RESULT);
		} catch (MalformedURLException e) {
			log.error(e.getMessage());
			throw new NutanixException(400, e.getMessage());
		} catch (IOException e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		}
	}

	public static NutanixObject getEnvironmentList(CustomOssCloudVO cloudVo) throws NutanixException {
		try {
			String path = "/api/nutanix/v3/environments/list";

			URL url = new URL(cloudVo.getCalmServer() + path);

			JsonObject bodyJson = new JsonObject();
			bodyJson.addProperty("kind", "environment");

			RequestBody body = RequestBody.create(bodyJson.toString(), MediaType.parse("application/json"));

			Request request = new Request.Builder().url(url).post(body).build();
			OkHttpClient client = NutanixClientManager.getCalmClient(cloudVo);

			return request(client, request, NutanixType.RESULT);
		} catch (MalformedURLException e) {
			log.error(e.getMessage());
			throw new NutanixException(400, e.getMessage());
		} catch (IOException e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		}
	}

	public static NutanixObject getEnvironmentDefault(CustomOssCloudVO cloudVo) throws NutanixException {
		try {
			String path = "/api/nutanix/v3/environments/list";

			URL url = new URL(cloudVo.getCalmServer() + path);

			JsonObject bodyJson = new JsonObject();
			bodyJson.addProperty("kind", "environment");
			bodyJson.addProperty("filter", "name==Default_env");

			RequestBody body = RequestBody.create(bodyJson.toString(), MediaType.parse("application/json"));

			Request request = new Request.Builder().url(url).post(body).build();
			OkHttpClient client = NutanixClientManager.getCalmClient(cloudVo);

			return request(client, request, NutanixType.RESULT);
		} catch (MalformedURLException e) {
			log.error(e.getMessage());
			throw new NutanixException(400, e.getMessage());
		} catch (IOException e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		}
	}

	public static NutanixObject getEnvironmentByFilter(CustomOssCloudVO cloudVo, String filter) throws NutanixException {
		try {
			String path = "/api/nutanix/v3/environments/list";

			URL url = new URL(cloudVo.getCalmServer() + path);

			JsonObject bodyJson = new JsonObject();
			bodyJson.addProperty("kind", "environment");
			bodyJson.addProperty("filter", filter);

			RequestBody body = RequestBody.create(bodyJson.toString(), MediaType.parse("application/json"));

			Request request = new Request.Builder().url(url).post(body).build();
			OkHttpClient client = NutanixClientManager.getCalmClient(cloudVo);

			return request(client, request, NutanixType.RESULT);
		} catch (MalformedURLException e) {
			log.error(e.getMessage());
			throw new NutanixException(400, e.getMessage());
		} catch (IOException e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		}
	}

	public static NutanixObject getEnvironment(CustomOssCloudVO cloudVo, String environment_uuid) throws NutanixException {
		try {
			String path = "/api/nutanix/v3/environments/" + environment_uuid;
			URL url = new URL(cloudVo.getCalmServer() + path);

			Request request = new Request.Builder().url(url).get().build();
			OkHttpClient client = NutanixClientManager.getCalmClient(cloudVo);

			return request(client, request, NutanixType.ENVIRONMENT);
		} catch (MalformedURLException e) {
			log.error(e.getMessage());
			throw new NutanixException(400, e.getMessage());
		} catch (IOException e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		}
	}

	public static NutanixObject getSubnetList(CustomOssCloudVO cloudVo) throws NutanixException {
		try {
			String path = "/api/nutanix/v3/subnets/list";

			URL url = new URL(cloudVo.getCalmServer() + path);

			JsonObject bodyJson = new JsonObject();
			bodyJson.addProperty("kind", "subnet");

			RequestBody body = RequestBody.create(bodyJson.toString(), MediaType.parse("application/json"));

			Request request = new Request.Builder().url(url).post(body).build();
			OkHttpClient client = NutanixClientManager.getCalmClient(cloudVo);

			return request(client, request, NutanixType.RESULT);
		} catch (MalformedURLException e) {
			log.error(e.getMessage());
			throw new NutanixException(400, e.getMessage());
		} catch (IOException e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		}
	}

	public static NutanixObject getSubnet(CustomOssCloudVO cloudVo, String uuid) throws NutanixException {
		try {
			String path = "/api/nutanix/v3/subnets/" + uuid;
			URL url = new URL(cloudVo.getCalmServer() + path);

			Request request = new Request.Builder().url(url).get().build();
			OkHttpClient client = NutanixClientManager.getCalmClient(cloudVo);

			return request(client, request, NutanixType.SUBNET);
		} catch (MalformedURLException e) {
			log.error(e.getMessage());
			throw new NutanixException(400, e.getMessage());
		} catch (IOException e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		}
	}

	public static NutanixObject getAccountList(CustomOssCloudVO cloudVo) throws NutanixException {
		try {
			String path = "/api/nutanix/v3/accounts/list";

			URL url = new URL(cloudVo.getCalmServer() + path);

			JsonObject bodyJson = new JsonObject();
			bodyJson.addProperty("kind", "account");

			RequestBody body = RequestBody.create(bodyJson.toString(), MediaType.parse("application/json"));

			Request request = new Request.Builder().url(url).post(body).build();
			OkHttpClient client = NutanixClientManager.getCalmClient(cloudVo);

			return request(client, request, NutanixType.RESULT);
		} catch (MalformedURLException e) {
			log.error(e.getMessage());
			throw new NutanixException(400, e.getMessage());
		} catch (IOException e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		}
	}

	public static NutanixObject getAccountByFilter(CustomOssCloudVO cloudVo, String filter) throws NutanixException {
		try {
			String path = "/api/nutanix/v3/accounts/list";

			URL url = new URL(cloudVo.getCalmServer() + path);

			JsonObject bodyJson = new JsonObject();
			bodyJson.addProperty("kind", "account");
			bodyJson.addProperty("filter", filter);

			RequestBody body = RequestBody.create(bodyJson.toString(), MediaType.parse("application/json"));

			Request request = new Request.Builder().url(url).post(body).build();
			OkHttpClient client = NutanixClientManager.getCalmClient(cloudVo);

			return request(client, request, NutanixType.RESULT);
		} catch (MalformedURLException e) {
			log.error(e.getMessage());
			throw new NutanixException(400, e.getMessage());
		} catch (IOException e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		}
	}

	public static NutanixObject getAccount(CustomOssCloudVO cloudVo, String uuid) throws NutanixException {
		try {
			String path = "/api/nutanix/v3/accounts/" + uuid;
			URL url = new URL(cloudVo.getCalmServer() + path);

			Request request = new Request.Builder().url(url).get().build();
			OkHttpClient client = NutanixClientManager.getCalmClient(cloudVo);

			return request(client, request, NutanixType.ACCOUNT);
		} catch (MalformedURLException e) {
			log.error(e.getMessage());
			throw new NutanixException(400, e.getMessage());
		} catch (IOException e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		}
	}

	public static NutanixObject getMarketplaceItemList(CustomOssCloudVO cloudVo) throws NutanixException {
		try {
			String path = "/api/nutanix/v3/calm_marketplace_items/list";

			URL url = new URL(cloudVo.getCalmServer() + path);

			JsonObject bodyJson = new JsonObject();
			bodyJson.addProperty("kind", "marketplace_item");
			bodyJson.addProperty("filter", "app_state==PUBLISHED");

			RequestBody body = RequestBody.create(bodyJson.toString(), MediaType.parse("application/json"));

			Request request = new Request.Builder().url(url).post(body).build();
			OkHttpClient client = NutanixClientManager.getCalmClient(cloudVo);

			return request(client, request, NutanixType.RESULT);
		} catch (MalformedURLException e) {
			log.error(e.getMessage());
			throw new NutanixException(400, e.getMessage());
		} catch (IOException e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		}
	}

	public static NutanixObject getMarketplaceItem(CustomOssCloudVO cloudVo, String uuid) throws NutanixException {
		try {
			String path = "/api/nutanix/v3/calm_marketplace_items/" + uuid;
			URL url = new URL(cloudVo.getCalmServer() + path);

			Request request = new Request.Builder().url(url).get().build();
			OkHttpClient client = NutanixClientManager.getCalmClient(cloudVo);

			return request(client, request, NutanixType.MARKETPLACE_ITEM);
		} catch (MalformedURLException e) {
			log.error(e.getMessage());
			throw new NutanixException(400, e.getMessage());
		} catch (IOException e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		}
	}

//	Project 에 Environment 할당
	public static NutanixObject createEnvironment(CustomOssCloudVO cloudVo, String default_env_uuid,
			String project_name, String project_uuid, String default_subnet_uuid, String[] subnets) throws NutanixException {
		try {
			String path = "/api/nutanix/v3/environments";
			URL url = new URL(cloudVo.getCalmServer() + path);

			NutanixObject bodyJson = getEnvironment(cloudVo, default_env_uuid);
			// status 이하 삭제
			bodyJson.getJson().remove("status");
			// 이름변경
			bodyJson.getJson().getAsJsonObject("spec").addProperty("name", project_name + "-env");
			// Default Subnet 변경
			bodyJson.getJson().getAsJsonObject("spec").getAsJsonObject("resources").getAsJsonArray("infra_inclusion_list")
					.get(0).getAsJsonObject().getAsJsonObject("default_subnet_reference")
					.addProperty("uuid", default_subnet_uuid);
			// 사용가능한 Subnet 지정

			bodyJson.getJson().getAsJsonObject("spec").getAsJsonObject("resources").getAsJsonArray("infra_inclusion_list")
					.get(0).getAsJsonObject().remove("subnet_references");
			JsonArray subnet_references = new JsonArray();
			bodyJson.getJson().getAsJsonObject("spec").getAsJsonObject("resources").getAsJsonArray("infra_inclusion_list")
					.get(0).getAsJsonObject().add("subnet_references", subnet_references);

			for (int i = 0; i < subnets.length; i++) {
				JsonObject subnetObj = new JsonObject();
				subnetObj.addProperty("uuid", subnets[i]);
				subnet_references.add(subnetObj);
			}

			// Quick launch BP SPEC 의 VM NIC Subnet 지정
			bodyJson.getJson().getAsJsonObject("spec").getAsJsonObject("resources")
					.getAsJsonArray("substrate_definition_list").get(0).getAsJsonObject().getAsJsonObject("create_spec")
					.getAsJsonObject("resources").getAsJsonArray("nic_list").get(0).getAsJsonObject()
					.getAsJsonObject("subnet_reference").addProperty("uuid", default_subnet_uuid);
			bodyJson.getJson().getAsJsonObject("spec").getAsJsonObject("resources")
					.getAsJsonArray("substrate_definition_list").get(1).getAsJsonObject().getAsJsonObject("create_spec")
					.getAsJsonObject("resources").getAsJsonArray("nic_list").get(0).getAsJsonObject()
					.getAsJsonObject("subnet_reference").addProperty("uuid", default_subnet_uuid);
			// Quick Launch BP SPEC 의 BP UUID 변경 (Windows VM, Linux VM)
			bodyJson.getJson().getAsJsonObject("spec").getAsJsonObject("resources")
					.getAsJsonArray("substrate_definition_list").get(0).getAsJsonObject()
					.addProperty("uuid", UUID.randomUUID().toString());
			bodyJson.getJson().getAsJsonObject("spec").getAsJsonObject("resources")
					.getAsJsonArray("substrate_definition_list").get(1).getAsJsonObject()
					.addProperty("uuid", UUID.randomUUID().toString());
			// Credential UUID 변경
			bodyJson.getJson().getAsJsonObject("spec").getAsJsonObject("resources")
					.getAsJsonArray("credential_definition_list").get(0).getAsJsonObject()
					.addProperty("uuid", UUID.randomUUID().toString());
			// metadata 삭제
			bodyJson.getJson().remove("metadata");

			// metadata 추가
			JsonObject metadata = new JsonObject();
			bodyJson.getJson().add("metadata", metadata);
			metadata.addProperty("kind", "environment");
			JsonObject project_reference = new JsonObject();
			metadata.add("project_reference", project_reference);
			project_reference.addProperty("kind", "project");
			project_reference.addProperty("name", project_name);
			project_reference.addProperty("uuid", project_uuid);

			log.info(bodyJson.toString());

			RequestBody body = RequestBody.create(bodyJson.toString(), MediaType.parse("application/json"));

			Request request = new Request.Builder().url(url).post(body).build();
			OkHttpClient client = NutanixClientManager.getCalmClient(cloudVo);

			return request(client, request, NutanixType.ENVIRONMENT);
		} catch (MalformedURLException e) {
			log.error(e.getMessage());
			throw new NutanixException(400, e.getMessage());
		} catch (IOException e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		}

	}

	public static NutanixObject attachEnvironment(CustomOssCloudVO cloudVo, String project_uuid,
			String environment_uuid) throws NutanixException {
		try {
			String path = "/api/nutanix/v3/projects/" + project_uuid;
			URL url = new URL(cloudVo.getCalmServer() + path);

			NutanixObject bodyJson = getProject(cloudVo, project_uuid);
			// status 이하 삭제
			bodyJson.getJson().remove("status");
			// metadata 추가
			JsonObject default_environment_reference = new JsonObject();
			bodyJson.getJson().getAsJsonObject("spec").getAsJsonObject("resources").add("default_environment_reference",
					default_environment_reference);
			default_environment_reference.addProperty("kind", "environment");
			default_environment_reference.addProperty("uuid", environment_uuid);

			JsonArray environment_reference_list = new JsonArray();
			bodyJson.getJson().getAsJsonObject("spec").getAsJsonObject("resources").add("environment_reference_list",
					environment_reference_list);
			JsonObject environment_list1 = new JsonObject();
			environment_list1.addProperty("kind", "environment");
			environment_list1.addProperty("uuid", environment_uuid);
			environment_reference_list.add(environment_list1);

			RequestBody body = RequestBody.create(bodyJson.toString(), MediaType.parse("application/json"));

			Request request = new Request.Builder().url(url).put(body).build();
			OkHttpClient client = NutanixClientManager.getCalmClient(cloudVo);

			return request(client, request, NutanixType.PROJECT);
		} catch (MalformedURLException e) {
			log.error(e.getMessage());
			throw new NutanixException(400, e.getMessage());
		} catch (IOException e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		}

	}

	public static NutanixObject attachProjectMarketPlaceItem(CustomOssCloudVO cloudVo, String marketplace_item_uuid,
			String project_name, String project_uuid) throws NutanixException {
		try {
			String path = "/api/nutanix/v3/calm_marketplace_items/" + marketplace_item_uuid;
			URL url = new URL(cloudVo.getCalmServer() + path);

			NutanixObject bodyJson = getMarketplaceItem(cloudVo, marketplace_item_uuid);
			// status 이하 삭제
			bodyJson.getJson().remove("status");
			// project_reference_list 추가
			JsonObject attach_project = new JsonObject();
			attach_project.addProperty("kind", "project");
			attach_project.addProperty("name", project_name);
			attach_project.addProperty("uuid", project_uuid);
			bodyJson.getJson().getAsJsonObject("spec").getAsJsonObject("resources").getAsJsonArray("project_reference_list")
					.add(attach_project);

			RequestBody body = RequestBody.create(bodyJson.toString(), MediaType.parse("application/json"));

			Request request = new Request.Builder().url(url).put(body).build();
			OkHttpClient client = NutanixClientManager.getCalmClient(cloudVo);

			return request(client, request, NutanixType.MARKETPLACE_ITEM);
		} catch (MalformedURLException e) {
			log.error(e.getMessage());
			throw new NutanixException(400, e.getMessage());
		} catch (IOException e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		}

	}

	public static NutanixObject convertMarketplaceItemToBluePrint(CustomOssCloudVO cloudVo,
			String marketplace_item_uuid, String project_uuid, String environment_uuid) throws NutanixException {
		try {
			String path = "/api/nutanix/v3/blueprints/marketplace_launch";
			URL url = new URL(cloudVo.getCalmServer() + path);

			NutanixObject mpiJson = getMarketplaceItem(cloudVo, marketplace_item_uuid);
			String mpi_name = mpiJson.getObject("metadata").getValue("name").toString();
			// app_blueprint_template 내용만 spec로 따로 추출
			JsonObject jobj = new JsonObject();
			jobj.add("spec", mpiJson.getJson().getAsJsonObject("spec").getAsJsonObject("resources")
					.getAsJsonObject("app_blueprint_template").getAsJsonObject("spec"));

			NutanixObject bodyJson = new NutanixObject(NutanixType.BLUEPRINT, jobj.toString());

			bodyJson.getJson().addProperty("api_version", "3.0");
			// String blueprint_name = mpi_name + "_" + UUID.randomUUID().toString();

			// JHC 수정 나중에 이미지 정보 즉 MPI 정보를 가져다가 bss_product_os sequence 번호를 업데이트하기 위해
			// __로 파싱하기 위해 사용 필요
			String blueprint_name = mpi_name + "__" + UUID.randomUUID().toString();

			bodyJson.getJson().getAsJsonObject("spec").addProperty("app_blueprint_name", blueprint_name);
			bodyJson.getJson().getAsJsonObject("spec").remove("name");
			bodyJson.getJson().getAsJsonObject("spec").addProperty("environment_uuid", environment_uuid);

			JsonObject metadata = new JsonObject();
			bodyJson.getJson().add("metadata", metadata);
			metadata.addProperty("kind", "blueprint");

			JsonObject project_reference = new JsonObject();
			metadata.add("project_reference", project_reference);
			project_reference.addProperty("kind", "project");
			project_reference.addProperty("uuid", project_uuid);

			JsonObject categories = new JsonObject();
			metadata.add("categories", categories);
			categories.addProperty("TemplateType", "Vm");
			RequestBody body = RequestBody.create(bodyJson.toString(), MediaType.parse("application/json"));

			Request request = new Request.Builder().url(url).post(body).build();
			OkHttpClient client = NutanixClientManager.getCalmClient(cloudVo);

			return request(client, request, NutanixType.MARKETPLACE_ITEM);
		} catch (MalformedURLException e) {
			log.error(e.getMessage());
			throw new NutanixException(400, e.getMessage());
		} catch (IOException e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		}

	}

	public static NutanixObject simpleLaunch(CustomOssCloudVO cloudVo, String blueprint_uuid, String vm_name,
			String ipaddress, String gatewayadress, String dns1, String dns2, int vcpu, int mem_mb, int disk_gb,
			String subnet_uuid) throws NutanixException {
		try {
			String path = "/api/nutanix/v3/blueprints/" + blueprint_uuid + "/simple_launch";
			URL url = new URL(cloudVo.getCalmServer() + path);

			NutanixObject mpiJson = getBlueprintRuntimeEditables(cloudVo, blueprint_uuid);

			int disk_mb = disk_gb * 1024;

			// runtime_editables의 리소스 배열의 첫번째 내용만 spec로 따로 추출
			JsonObject jobj = new JsonObject();
			jobj.add("spec", mpiJson.getJson().getAsJsonArray("resources").get(0));
//		
			NutanixObject bodyJson = new NutanixObject(NutanixType.BLUEPRINT, jobj.toString());

			// app name set
			bodyJson.getJson().getAsJsonObject("spec").addProperty("app_name", vm_name);
			// vm name set
			bodyJson.getJson().getAsJsonObject("spec").getAsJsonObject("runtime_editables").getAsJsonArray("substrate_list")
					.get(0).getAsJsonObject().getAsJsonObject("value").getAsJsonObject("spec").addProperty("name", vm_name);
			// vm vcpu set
			bodyJson.getJson().getAsJsonObject("spec").getAsJsonObject("runtime_editables").getAsJsonArray("substrate_list")
					.get(0).getAsJsonObject().getAsJsonObject("value").getAsJsonObject("spec").getAsJsonObject("resources")
					.addProperty("num_sockets", vcpu);
			// vm memory mb set
			bodyJson.getJson().getAsJsonObject("spec").getAsJsonObject("runtime_editables").getAsJsonArray("substrate_list")
					.get(0).getAsJsonObject().getAsJsonObject("value").getAsJsonObject("spec").getAsJsonObject("resources")
					.addProperty("memory_size_mib", mem_mb);

			bodyJson.getJson().getAsJsonObject("spec").getAsJsonObject("runtime_editables").getAsJsonArray("substrate_list")
					.get(0).getAsJsonObject().getAsJsonObject("value").getAsJsonObject("spec").getAsJsonObject("resources")
					.getAsJsonObject("nic_list").getAsJsonObject("0").getAsJsonObject("subnet_reference")
					.addProperty("uuid", subnet_uuid);

			JsonArray variables = bodyJson.getJson().getAsJsonObject("spec").getAsJsonObject("runtime_editables")
					.getAsJsonArray("variable_list");
			for (int i = 0; i < variables.size(); i++) {
				JsonObject variable = variables.get(i).getAsJsonObject();
				String variable_name = variable.get("name").getAsString();

				if (variable_name.equals("IPADDRESS")) {
					variable.getAsJsonObject("value").addProperty("value", ipaddress);
				} else if (variable_name.equals("FQDN")) {
					variable.getAsJsonObject("value").addProperty("value", vm_name);
				} else if (variable_name.equals("HOSTNAME")) {
					variable.getAsJsonObject("value").addProperty("value", vm_name);
				} else if (variable_name.equals("GATEWAY")) {
					variable.getAsJsonObject("value").addProperty("value", gatewayadress);
				} 
				// HCI dns chlwjdgns
//			else if (variable_name.equals("DNS1")) {
//				variable.getAsJsonObject("value").addProperty("value", dns1);
//			} else if (variable_name.equals("DNS2")) {
//				variable.getAsJsonObject("value").addProperty("value", dns2);
//			}
			}

			RequestBody body = RequestBody.create(bodyJson.toString(), MediaType.parse("application/json"));

			Request request = new Request.Builder().url(url).post(body).build();
			OkHttpClient client = NutanixClientManager.getCalmClient(cloudVo);

			return request(client, request, NutanixType.MARKETPLACE_ITEM);
		} catch (MalformedURLException e) {
			log.error(e.getMessage());
			throw new NutanixException(400, e.getMessage());
		} catch (IOException e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		}

	}

	public static NutanixObject createProjectBatch(CustomOssCloudVO cloudVo, String project_name,
			String project_description, String default_subnet, String[] subnets, int vCpu, int memory_gb,
			int storage_gb) throws NutanixException {

		// 계정 이름이 NTNX_LOCAL_AZ 이어야 함
		try {
			NutanixObject account = NutanixUtils.getAccountByFilter(cloudVo, "name==NTNX_LOCAL_AZ");
			String account_uuid = account.getAccounts().get(0).getObject("metadata").getValue("uuid").toString();
			log.info("account : " + account_uuid);

			NutanixObject result = createProject(cloudVo, project_name, project_description, vCpu, memory_gb, storage_gb,
					account_uuid, default_subnet, subnets);

			String project_uuid = result.getObject("metadata").getValue("uuid").toString();
			String task_uuid = result.getTaskUuid();
			log.info("project_uuid : " + project_uuid);
			log.info("task_uuid : " + task_uuid);

			if (!waitSucceeded(cloudVo, task_uuid, project_name + " create ")) {
				log.warn("생성시간초과시 처리 ");
			}

			// default env 이름이 Default_env 이어야 함
			NutanixObject default_environment = getEnvironmentByFilter(cloudVo, "name==default").getEnvironments().get(0);
			String default_env_uuid = default_environment.getObject("metadata").getValue("uuid").toString();
			log.info("default_env_uuid : " + default_env_uuid);

			NutanixObject environment = createEnvironment(cloudVo, default_env_uuid, project_name, project_uuid,
					default_subnet, subnets);
			String environment_uuid = environment.getObject("metadata").getValue("uuid").toString();
			log.info("environment_uuid : " + environment_uuid);

			for (int i = 0; i < 60; i++) {
				NutanixObject check = getEnvironment(cloudVo, environment_uuid);
				log.info(check.getObject("metadata").getValue("name") + " environment state " + check.getState());
				if (check.getState().equals("ACTIVE"))
					break;
				Thread.sleep(2000);
			}

			result = attachEnvironment(cloudVo, project_uuid, environment_uuid);

			task_uuid = result.getTaskUuid();

			if (!waitSucceeded(cloudVo, task_uuid, project_name + " attach enviroment ")) {
				log.warn("생성시간초과시 처리 ");
			}

			NutanixObject marketPlaceItemList = getMarketplaceItemList(cloudVo);
			for (NutanixObject marketPlaceItem : marketPlaceItemList.getMarketplaceItems()) {
				String marketplace_item_uuid = marketPlaceItem.getObject("metadata").getValue("uuid").toString();

				log.info("marketplace_item (" + marketPlaceItem.getObject("metadata").getValue("name") + ") attach project "
						+ project_name);
				attachProjectMarketPlaceItem(cloudVo, marketplace_item_uuid, project_name, project_uuid);
			}

			return getProject(cloudVo, project_uuid);
		} catch (NutanixException e) {
			log.error(e.getMessage());
			throw new NutanixException(400, e.getMessage());
		} catch (InterruptedException e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		}
	}

	@Deprecated
	public static NutanixObject createProjectByDefaultBatch(CustomOssCloudVO cloudVo, String project_name,
			String project_description, int vCpu, int memory_gb, int storage_gb) throws NutanixException {

		try {
			NutanixObject result = createProjectByDefault(cloudVo, project_name, project_description, vCpu, memory_gb,
					storage_gb);

			String project_uuid = result.getObject("metadata").getValue("uuid").toString();
			String task_uuid = result.getTaskUuid();
			log.info("project_uuid : " + project_uuid);
			log.info("task_uuid : " + task_uuid);

			if (!waitSucceeded(cloudVo, task_uuid, project_name + " create ")) {
				log.warn("생성시간초과시 처리 ");
			}

			NutanixObject project = getProject(cloudVo, project_uuid);
			String default_subnet_uuid = project.getObject("spec").getObject("resources")
					.getObject("default_subnet_reference").getValue("uuid").toString();
			String[] subnet_uuid = { project.getObject("spec").getObject("resources").getArray("subnet_reference_list")
					.get(0).getValue("uuid").toString() };
			log.info("default_subnet_uuid : " + default_subnet_uuid);
			log.info("subnet_uuid : " + subnet_uuid);

			NutanixObject default_environment = getEnvironmentDefault(cloudVo).getProjects().get(0);
			String default_env_uuid = default_environment.getObject("metadata").getValue("uuid").toString();
			log.info("default_env_uuid : " + default_env_uuid);

			NutanixObject environment = createEnvironment(cloudVo, default_env_uuid, project_name, project_uuid,
					default_subnet_uuid, subnet_uuid);
			String environment_uuid = environment.getObject("metadata").getValue("uuid").toString();
			log.info("environment_uuid : " + environment_uuid);

			for (int i = 0; i < 60; i++) {
				NutanixObject check = getEnvironment(cloudVo, environment_uuid);
				log.info(check.getObject("metadata").getValue("name") + " environment state " + check.getState());
				if (check.getState().equals("ACTIVE"))
					break;
				Thread.sleep(2000);
			}

			result = attachEnvironment(cloudVo, project_uuid, environment_uuid);

			task_uuid = result.getTaskUuid();

			if (!waitSucceeded(cloudVo, task_uuid, project_name + " attach enviroment ")) {
				log.warn("생성시간초과시 처리 ");
			}

			NutanixObject marketPlaceItemList = getMarketplaceItemList(cloudVo);
			for (NutanixObject marketPlaceItem : marketPlaceItemList.getMarketplaceItems()) {
				String marketplace_item_uuid = marketPlaceItem.getObject("metadata").getValue("uuid").toString();

				log.info("marketplace_item (" + marketPlaceItem.getObject("metadata").getValue("name") + ") attach project "
						+ project_name);
				attachProjectMarketPlaceItem(cloudVo, marketplace_item_uuid, project_name, project_uuid);
			}

			return getProject(cloudVo, project_uuid);
		} catch (NutanixException e) {
			log.error(e.getMessage());
			throw new NutanixException(400, e.getMessage());
		} catch (InterruptedException e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		}
	}

	public static NutanixObject simpleLaunchBatch(CustomOssCloudVO cloudVo, String marketplace_item_uuid,
			String project_uuid, String vm_name, String ipaddress, String gatewayadress, String dns1, String dns2,
			int vcpu, int mem_mb, int disk_gb, String subnet_uuid) throws NutanixException {

		try {
			NutanixObject project = getProject(cloudVo, project_uuid);

			String environment_uuid = project.getObject("spec").getObject("resources")
					.getObject("default_environment_reference").getValue("uuid").toString();
			log.info("environment_uuid : " + environment_uuid);
			NutanixObject blueprint = convertMarketplaceItemToBluePrint(cloudVo, marketplace_item_uuid, project_uuid,
					environment_uuid);

			String blueprint_uuid = blueprint.getObject("metadata").getValue("uuid").toString();
			log.info("blueprint_name : " + blueprint.getObject("metadata").getValue("name"));
			log.info("blueprint_uuid : " + blueprint_uuid);

			for (int i = 0; i < 60; i++) {
				NutanixObject check = getBlueprint(cloudVo, blueprint_uuid);
				log.info("blueprint state " + check.getState());
				if (check.getState().equals("ACTIVE"))
					break;
				Thread.sleep(2000);
			}

			NutanixObject app = simpleLaunch(cloudVo, blueprint_uuid, vm_name, ipaddress, gatewayadress, dns1, dns2, vcpu,
					mem_mb, disk_gb, subnet_uuid);
			log.info("app launch request id : " + app.getRequestId());

			String request_id = app.getRequestId();
			if (!waitSucceeded(cloudVo, request_id, "blueprint launch ")) {
				log.warn("simple launch 시간초과시 처리 ");
			}

			app = getAppByName(cloudVo, vm_name).getVMs().get(0);
			String app_uuid = app.getUuid();
			log.info("app_uuid : " + app_uuid);

			for (int i = 0; i < 60; i++) {
				app = getApp(cloudVo, app_uuid);
				log.info("app state " + app.getState());
				if (app.getState().equals("running"))
					break;
				Thread.sleep(10000);
			}

			log.info("vm_uuid : " + app.getVmUuid());
			log.info("vm_name : " + app.getVmName());

			NutanixObject res = updateOsDiskSize(cloudVo, app.getVmUuid(), disk_gb);

			if (!waitSucceeded(cloudVo, res.getTaskUuid(), " disk size change ")) {
				log.warn("디스크 사이즈 변경 처리 ");
			}

			return getApp(cloudVo, app_uuid);
		} catch (NutanixException e) {
			log.error(e.getMessage());
			throw new NutanixException(400, e.getMessage());
		} catch (InterruptedException e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		}
	}

	public static boolean waitSucceeded(CustomOssCloudVO cloudVo, String task_uuid, String msg) throws NutanixException {
		try {
			for (int i = 0; i < 60; i++) {
				NutanixObject check = getTask(cloudVo, task_uuid);
				log.info(msg + check.getValue("status"));
				if (check.getStatus().equals("QUEUED") || check.getStatus().equals("RUNNING"))
					continue;
				if (check.getStatus().equals("SUCCEEDED"))
					return true;
				if (check.getStatus().equals("FAILED")) {
					throw new NutanixException(400, check.getErrorDetail());
				}
				Thread.sleep(2000);
			}
			return false;
		} catch (NutanixException e) {
			log.error(e.getMessage());
			throw new NutanixException(400, e.getMessage());
		} catch (InterruptedException e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		}
	}

	// defaut 프로젝트에 할당된 default subnet, subnet list, account 정보등을 그대로 사용함
	public static NutanixObject createProjectByDefault(CustomOssCloudVO cloudVo, String project_name,
			String project_description, int vCpu, int memory_gb, int storage_gb) throws NutanixException {
		try {
			String path = "/api/nutanix/v3/projects";
			URL url = new URL(cloudVo.getCalmServer() + path);

			long memoryByte = 1024l * 1024l * 1024l * memory_gb;
			long storageByte = 1024l * 1024l * 1024l * storage_gb;

			NutanixObject bodyJson = getProjectDefault(cloudVo).getProjects().get(0);

			String def_subnet_uuid = bodyJson.getObject("spec").getObject("resources").getObject("default_subnet_reference")
					.getValue("uuid").toString();

			NutanixObject defSubnet = getSubnet(cloudVo, def_subnet_uuid);
			String def_subnet_name = defSubnet.getObject("spec").getValue("name").toString();
			String cluster_uuid = defSubnet.getObject("spec").getObject("cluster_reference").getValue("uuid").toString();

			// json 본문에 status, metadata 삭제
			bodyJson.getJson().remove("status");
			bodyJson.getJson().remove("metadata");

			// project name set
			bodyJson.getJson().getAsJsonObject("spec").addProperty("name", project_name);

			bodyJson.getJson().getAsJsonObject("spec").getAsJsonObject("resources").remove("environment_reference_list");
			bodyJson.getJson().getAsJsonObject("spec").getAsJsonObject("resources").remove("default_environment_reference");
			bodyJson.getJson().getAsJsonObject("spec").getAsJsonObject("resources").remove("user_reference_list");

			JsonObject cluster_reference = new JsonObject();
			cluster_reference.addProperty("kind", "cluster");
			cluster_reference.addProperty("uuid", cluster_uuid);
			bodyJson.getJson().getAsJsonObject("spec").getAsJsonObject("resources").remove("cluster_reference_list");
			JsonArray cluster_reference_list = new JsonArray();
			cluster_reference_list.add(cluster_reference);
			bodyJson.getJson().getAsJsonObject("spec").getAsJsonObject("resources").add("cluster_reference_list",
					cluster_reference_list);

			JsonObject resource_domain = new JsonObject();

			JsonArray resources_list = new JsonArray();
			resource_domain.add("resources", resources_list);

			JsonObject vcpu_limit = new JsonObject();
			vcpu_limit.addProperty("limit", vCpu);
			vcpu_limit.addProperty("resource_type", "VCPUS");
			resources_list.add(vcpu_limit);

			JsonObject memory_limit = new JsonObject();
			memory_limit.addProperty("limit", memoryByte);
			memory_limit.addProperty("resource_type", "MEMORY");
			resources_list.add(memory_limit);

			JsonObject storate_limit = new JsonObject();
			storate_limit.addProperty("limit", storageByte);
			storate_limit.addProperty("resource_type", "STORAGE");
			resources_list.add(storate_limit);

			bodyJson.getJson().getAsJsonObject("spec").getAsJsonObject("resources").add("resource_domain", resource_domain);

			// metadata set
			JsonObject metadata = new JsonObject();
			metadata.addProperty("kind", "project");
			bodyJson.getJson().add("metadata", metadata);

			RequestBody body = RequestBody.create(bodyJson.toString(), MediaType.parse("application/json"));

			Request request = new Request.Builder().url(url).post(body).build();
			OkHttpClient client = NutanixClientManager.getCalmClient(cloudVo);

			return request(client, request, NutanixType.PROJECT);
		} catch (MalformedURLException e) {
			log.error(e.getMessage());
			throw new NutanixException(400, e.getMessage());
		} catch (IOException e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		}

	}

	// defaut 프로젝트에 할당된 default subnet, subnet list, account 정보등을 그대로 사용함
	public static NutanixObject updateOsDiskSize(CustomOssCloudVO cloudVo, String vm_uuid, int disk_gb)
			throws NutanixException {
		try {
			String path = "/api/nutanix/v3/vms/" + vm_uuid;
			URL url = new URL(cloudVo.getCalmServer() + path);

			int disk_size_mib = 1024 * disk_gb;

			NutanixObject bodyJson = getVm(cloudVo, vm_uuid);
			;

			// json 본문에 status, metadata 삭제
			bodyJson.getJson().remove("status");

			bodyJson.getJson().getAsJsonObject("spec").getAsJsonObject("resources").getAsJsonArray("disk_list").get(0)
					.getAsJsonObject().addProperty("disk_size_mib", disk_size_mib);

			RequestBody body = RequestBody.create(bodyJson.toString(), MediaType.parse("application/json"));

			Request request = new Request.Builder().url(url).put(body).build();
			OkHttpClient client = NutanixClientManager.getCalmClient(cloudVo);

			return request(client, request, NutanixType.VM);
		} catch (MalformedURLException e) {
			log.error(e.getMessage());
			throw new NutanixException(400, e.getMessage());
		} catch (IOException e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
			throw new NutanixException(500, e.getMessage());
		}

	}
}
