package com.ivucenter.cloud.api.nas;

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
public class NasObject {

    private NasType type = NasType.RESULT;
    private JsonObject json;
    private Gson gson = new GsonBuilder().setPrettyPrinting().create();

    // NasObject 생성자 (타입과 JSON 문자열을 받음)
    public NasObject(NasType type, String jsonString) {
        this.type = type;
        this.json = JsonParser.parseString(jsonString).getAsJsonObject();
    }

    // NasObject 생성자 (JSON 문자열만 받음)
    public NasObject(String jsonString) {
        this.json = JsonParser.parseString(jsonString).getAsJsonObject();
    }

    // 특정 키에 대한 값을 반환
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
            return new NasObject(NasType.PROPERTIES, element.toString());
        } else if (element.isJsonNull()) {
            log.debug(key + " is null");
        }
        return null;
    }

    // 특정 키에 대한 NasObject 반환
    public NasObject getObject(String key) {
        JsonElement element = this.json.get(key);
        if (element == null)
            return new NasObject(NasType.PROPERTIES, "{}");
        if (element.isJsonObject()) {
            return new NasObject(NasType.PROPERTIES, element.toString());
        }
        return new NasObject(NasType.PROPERTIES, "{}");
    }

    // 특정 키에 대한 배열 값을 리스트로 반환
    public List<NasObject> getArray(String key, NasType type) {
        JsonElement element = this.json.get(key);
        if (element.isJsonArray()) {
            JsonArray array = element.getAsJsonArray();
            List<NasObject> list = new ArrayList<NasObject>();
            for (int i = 0; i < array.size(); ++i) {
                list.add(new NasObject(type, array.get(i).toString()));
            }
            return list;
        }
        return new ArrayList<NasObject>();
    }

    // JSON 객체의 키 목록을 반환
    public Set<String> keySet() {
        return json.keySet();
    }

    // JSON 객체를 문자열로 반환
    @Override
    public String toString() {
        return "-----------------------------------\n[" + type + "]\n" + gson.toJson(json);
    }
}
