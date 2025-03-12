package com.ivucenter.cloud.api.gitlab;

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
public class GitlabObject {

    private GitlabType type = GitlabType.RESULT;
    private JsonObject json;
    private JsonArray jsonArray;
    private boolean isArray = false;  // 배열 여부 확인 플래그
    private Gson gson = new GsonBuilder().setPrettyPrinting().create();

    // JSON 객체나 배열을 처리하는 생성자
    public GitlabObject(GitlabType type, String jsonString) {
        this.type = type;
        JsonElement jsonElement = JsonParser.parseString(jsonString);

        if (jsonElement.isJsonObject()) {
            this.json = jsonElement.getAsJsonObject();
            this.isArray = false;
        } else if (jsonElement.isJsonArray()) {
            this.jsonArray = jsonElement.getAsJsonArray();
            this.isArray = true;
        }
    }

    // 배열인 경우 배열 항목을 반환 (projects, results 같은 배열 처리)
    public List<GitlabObject> getArray(String key, GitlabType type) {
        JsonElement element = this.json.get(key);
        List<GitlabObject> list = new ArrayList<>();
        if (element != null && element.isJsonArray()) {
            JsonArray array = element.getAsJsonArray();
            for (JsonElement item : array) {
                list.add(new GitlabObject(type, item.toString()));
            }
        }
        return list;
    }

    // 공통적으로 배열을 직접 처리할 때 사용하는 메서드 (예: projects 등)
    public List<GitlabObject> getProjects() {
        List<GitlabObject> list = new ArrayList<>();
        if (isArray) {
            for (JsonElement element : jsonArray) {
                list.add(new GitlabObject(GitlabType.PROJECT, element.toString()));
            }
        }
        return list;
    }

    // 값 가져오기 메서드 (객체일 경우)
    public Object getValue(String key) {
        if (!isArray && json != null) {
            JsonElement element = this.json.get(key);
            if (element == null)
                return null;
            if (element.isJsonPrimitive()) {
                if (element.getAsJsonPrimitive().isString()) {
                    return element.getAsString();
                } else if (element.getAsJsonPrimitive().isNumber()) {
                    return element.getAsNumber();
                } else if (element.getAsJsonPrimitive().isBoolean()) {
                    return element.getAsBoolean();
                }
            } else if (element.isJsonArray()) {
                log.debug(key + " is array ");
            } else if (element.isJsonObject()) {
                return new GitlabObject(GitlabType.PROPERTIES, element.toString());
            } else if (element.isJsonNull()) {
                log.debug(key + " is null");
            }
        }
        return null;
    }

    // JSON 객체 내 다른 객체 가져오기
    public GitlabObject getObject(String key) {
        if (!isArray && json != null) {
            JsonElement element = this.json.get(key);
            if (element == null)
                return new GitlabObject(GitlabType.PROPERTIES, "{}");
            if (element.isJsonObject()) {
                return new GitlabObject(GitlabType.PROPERTIES, element.toString());
            }
        }
        return new GitlabObject(GitlabType.PROPERTIES, "{}");
    }

    @Override
    public String toString() {
        if (isArray) {
            return "-----------------------------------\n[" + type + "]\n" + gson.toJson(jsonArray);
        } else {
            return "-----------------------------------\n[" + type + "]\n" + gson.toJson(json);
        }
    }
}
