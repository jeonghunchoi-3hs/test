package com.ivucenter.cloud.api.nutanix;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import lombok.Getter;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Setter
@Getter
public class NutanixObject {

	private NutanixType type = NutanixType.RESULT;
	private JsonObject json;
	private Gson gson = new GsonBuilder().setPrettyPrinting().create();

	public NutanixObject(NutanixType type, String jsonString) {
		this.type = type;
		this.json = JsonParser.parseString(jsonString).getAsJsonObject();
	}
	
	public NutanixObject(String jsonString) {
		this.json = JsonParser.parseString(jsonString).getAsJsonObject();
	}
	
	public List<NutanixObject> getVMs() {
		return getArray("entities", NutanixType.VM);
	}
	
	public List<NutanixObject> getProjects() {
		return getArray("entities", NutanixType.PROJECT);
	}
	
	public List<NutanixObject> getEnvironments() {
		return getArray("entities", NutanixType.ENVIRONMENT);
	}
	
	public List<NutanixObject> getVDisks() {
		return getArray("vm_disk_info", NutanixType.VM_DISK);
	}
	
	public List<NutanixObject> getVNics() {
		return getArray("vm_nics", NutanixType.VM_NIC);
	}
	
	public List<NutanixObject> getBlueprints() {
		return getArray("entities", NutanixType.BLUEPRINT);
	}
	
	public List<NutanixObject> getSubnets() {
		return getArray("entities", NutanixType.SUBNET);
	}
	
	public List<NutanixObject> getAccounts() {
		return getArray("entities", NutanixType.ACCOUNT);
	}
	
	public List<NutanixObject> getApps() {
		return getArray("entities", NutanixType.APP);
	}
	
	public List<NutanixObject> getBlueprintResources() {
		return getArray("resources", NutanixType.BLUEPRINT_RESOURCE);
	}
	
	public List<NutanixObject> getMarketplaceItems() {
		return getArray("entities", NutanixType.MARKETPLACE_ITEM);
	}
	
	public List<NutanixObject> getAccountReferences() {
		return getObject("spec").getObject("resources").getArray("account_reference_list", NutanixType.ACCOUNT);
	}
	
	public List<NutanixObject> getPeojectReferences() {
		return getObject("spec").getObject("resources").getArray("project_reference_list", NutanixType.PROJECT);
	}

	public List<NutanixObject> getSubnetReferences() {
		return getObject("spec").getObject("resources").getArray("subnet_reference_list", NutanixType.SUBNET);
	}
	
	public NutanixObject getDefaultSubnetReference() {
		return getObject("spec").getObject("resources").getObject("default_subnet_reference", NutanixType.SUBNET);
	}

	public String getState() {
		return getObject("status").getValue("state").toString();
	}
	
	public String getRequestId() {
		return getObject("status").getValue("request_id").toString();
	}
	
	public String getUuid() {
		return getObject("metadata").getValue("uuid").toString();
	}
	
	public String getStatus() {
		return getValue("status").toString();
	}
	
	public String getErrorDetail() {
		return getValue("error_detail").toString();
	}
	
	public String getTaskUuid() {
		return getObject("status").getObject("execution_context").getValue("task_uuid").toString();
	}
	
	public String getVmName() {
		return getObject("status").getObject("resources").getArray("deployment_list").get(0).getObject("substrate_configuration").getArray("element_list").get(0).getValue("instance_name").toString();
	}
	
	public String getVmUuid() {
		return getObject("status").getObject("resources").getArray("deployment_list").get(0).getObject("substrate_configuration").getArray("element_list").get(0).getValue("instance_id").toString();
	}

	public Object getValue(String key) {
		JsonElement element = this.json.get(key);
		if (element == null)
			return null;
		if (element.isJsonPrimitive()) {
			if (element.getAsJsonPrimitive().isString()) {
				return element.getAsString();
			} else if (element.getAsJsonPrimitive().isNumber()) {
				String valueStr = element.getAsString();

				try {
					return Integer.parseInt(valueStr);
				} catch (Exception e) {
				}
				try {
					return Long.parseLong(valueStr);
				} catch (Exception e) {
				}
				try {
					return Double.parseDouble(valueStr);
				} catch (Exception e) {
				}
				return valueStr;
			} else if (element.getAsJsonPrimitive().isBoolean()) {
				return element.getAsBoolean();
			}
		} else if (element.isJsonArray()) {
			log.warn(key + " is array ");
		} else if (element.isJsonObject()) {
			return new NutanixObject(NutanixType.PROPERTIES, element.toString());
		} else if (element.isJsonNull()) {
			log.warn(key + " is null");
		}
		return null;
	}

	public NutanixObject getObject(String key, NutanixType type) {
		JsonElement element = this.json.get(key);
		if (element == null)
			return new NutanixObject(type, "{}");
		if (element.isJsonObject()) {
			return new NutanixObject(type, element.toString());
		}
		return new NutanixObject(type, "{}");
	}
	
	public NutanixObject getObject(String key) {
		JsonElement element = this.json.get(key);
		if (element == null)
			return new NutanixObject(NutanixType.PROPERTIES, "{}");
		if (element.isJsonObject()) {
			return new NutanixObject(NutanixType.PROPERTIES, element.toString());
		}
		return new NutanixObject(NutanixType.PROPERTIES, "{}");
	}
	
	public List<NutanixObject> getArray(String key) {
		return getArray(key, NutanixType.PROPERTIES);
	}
	
	public List<NutanixObject> getArray(String key, NutanixType type) {
		JsonElement element = this.json.get(key);
		if (element.isJsonArray()) {
			JsonArray array = element.getAsJsonArray();
            List<NutanixObject> list = new ArrayList<NutanixObject>();
            for (int i = 0; i < array.size(); ++i) {
                list.add(new NutanixObject(type, array.get(i).toString()));
            }
			return list;
		}
		return new ArrayList<NutanixObject>();
	}

	public Set<String> keySet() {
		return json.keySet();
	}

	@Override
	public String toString() {
		return gson.toJson(json);
	}
}
