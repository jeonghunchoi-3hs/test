package com.ivucenter.cloud.api.ansible;

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

@Setter
@Getter
@Slf4j
public class AnsibleObject {

	private AnsibleType type = AnsibleType.RESULT;
	private JsonObject json;
	private Gson gson = new GsonBuilder().setPrettyPrinting().create();

	public AnsibleObject(AnsibleType type, String jsonString) {
		this.type = type;
		if (jsonString == null || jsonString.isEmpty()) {
			this.json = new JsonObject();
		} else {
			this.json = JsonParser.parseString(jsonString).getAsJsonObject();
		}
	}

	public AnsibleObject(String jsonString) {
		if (jsonString == null || jsonString.isEmpty()) {
			this.json = new JsonObject();
		} else {
			this.json = JsonParser.parseString(jsonString).getAsJsonObject();
		}
	}

	public List<AnsibleObject> getProjects() {
		return getArray("results", AnsibleType.PROJECT);
	}

	public List<AnsibleObject> getJobTemplates() {
		return getArray("results", AnsibleType.JOB_TEMPLATE);
	}

	public List<AnsibleObject> getInventorys() {
		return getArray("results", AnsibleType.INVENTORY);
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
			log.debug(key + " is array ");
		} else if (element.isJsonObject()) {
			return new AnsibleObject(AnsibleType.PROPERTIES, element.toString());
		} else if (element.isJsonNull()) {
			log.debug(key + " is null");
		}
		return null;
	}

	public AnsibleObject getObject(String key) {
		JsonElement element = this.json.get(key);
		if (element == null)
			return new AnsibleObject(AnsibleType.PROPERTIES, "{}");
		if (element.isJsonObject()) {
			return new AnsibleObject(AnsibleType.PROPERTIES, element.toString());
		}
		return new AnsibleObject(AnsibleType.PROPERTIES, "{}");
	}

	public List<AnsibleObject> getArray(String key, AnsibleType type) {
		JsonElement element = this.json.get(key);
		if (element.isJsonArray()) {
			JsonArray array = element.getAsJsonArray();
            List<AnsibleObject> list = new ArrayList<AnsibleObject>();
            for (int i = 0; i < array.size(); ++i) {
                list.add(new AnsibleObject(type, array.get(i).toString()));
            }
			return list;
		}
		return new ArrayList<AnsibleObject>();
	}

	public Set<String> keySet() {
		return json.keySet();
	}

	@Override
	public String toString() {
		return "-----------------------------------\n["+type+"]\n"+gson.toJson(json);
	}
}
