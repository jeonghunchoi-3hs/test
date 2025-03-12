package com.ivucenter.cloud.api.gitlab;

import java.io.IOException;
import java.net.URL;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Base64;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.ivucenter.cloud.api.common.utils.SystemCalculatorInfo;
import com.ivucenter.cloud.api.gitlab.connector.GitlabClientManager;
import com.ivucenter.cloud.portal.req.product.CustomReqProductVO;

import lombok.extern.slf4j.Slf4j;
import okhttp3.FormBody;
import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

@Slf4j
public class GitlabUtils {

    // 공통 요청 처리 메서드
    public static GitlabObject request(OkHttpClient client, Request request, GitlabType type) throws IOException, GitlabException {
        GitlabObject gitlabObject = null;
        log.debug("GitLab API URL: " + request.url().toString());
        try (Response response = client.newCall(request).execute()) {
            if (response.isSuccessful() && response.body() != null) {
                String json_text = response.body().string();
                gitlabObject = new GitlabObject(type, json_text);
                log.debug(gitlabObject.toString());
            } else {
                throw new GitlabException(response.code(), response.message());
            }
        }
        return gitlabObject;
    }


    public static GitlabObject createPersonalAccessToken(SystemCalculatorInfo systemCalculatorInfo, String userId, String tokenName) throws Exception {
        String path = "/api/v4/users/" + userId + "/personal_access_tokens";
        URL url = new URL(systemCalculatorInfo.getGitlabhost() + path);

        // 현재 날짜로부터 1년 후의 날짜를 계산
        LocalDate oneYearLater = LocalDate.now().plusYears(1);
        String expiresAt = oneYearLater.format(DateTimeFormatter.ISO_LOCAL_DATE);

        // 요청에 포함할 JSON 형식 (토큰의 이름과 권한 범위)
        String bodyJson = "{"
                + "\"name\":\"" + tokenName + "\", "
                + "\"scopes\":[\"api\", \"read_api\", \"k8s_proxy\", \"read_repository\", \"write_repository\", \"read_registry\", \"write_registry\"], "
                + "\"expires_at\":\"" + expiresAt + "\"" // 동적으로 계산된 만료일
                + "}";


        RequestBody body = RequestBody.create(MediaType.parse("application/json"), bodyJson);
        Request request = new Request.Builder()
                .url(url)
                .post(body)
                .addHeader("Content-Type", "application/json")
                .addHeader("PRIVATE-TOKEN", systemCalculatorInfo.getGitlabtoken())
                .build();

        OkHttpClient client = GitlabClientManager.getGitLabClient(systemCalculatorInfo);
        return request(client, request, GitlabType.TOKEN);
    }

    // 사용자 추가
    public static GitlabObject createUser(SystemCalculatorInfo systemCalculatorInfo, String userId, String username, String email, String password) throws Exception {
        String path = "/api/v4/users";
        URL url = new URL(systemCalculatorInfo.getGitlabhost() + path);

        // 요청에 포함할 JSON 형식 수정
//        String bodyJson = "{\"username\":\"" + userId + "\", " +
//                          "\"email\":\"" + email + "\", " +
//                          "\"password\":\"" + password + "\", " +
//                          "\"name\":\"" + username + "\", " +
//                          "\"admin\":" + true + "}";
        String bodyJson = "{\"username\":\"" + userId + "\", " +
        		"\"email\":\"" + email + "\", " +
        		"\"password\":\"" + password + "\", " +
        		"\"name\":\"" + username + "\", " +
        		"\"can_create_group\":" + false + ", " +
		        "\"skip_confirmation\":" + true + "}";

        RequestBody body = RequestBody.create(MediaType.parse("application/json"), bodyJson);
        Request request = new Request.Builder()
                .url(url)
                .post(body)
                .addHeader("Content-Type", "application/json")
                .addHeader("PRIVATE-TOKEN", systemCalculatorInfo.getGitlabtoken())
                .build();

        OkHttpClient client = GitlabClientManager.getGitLabClient(systemCalculatorInfo);
        return request(client, request, GitlabType.USER);
    }


 // 그룹 생성 메서드 추가
    public static GitlabObject createGroup(SystemCalculatorInfo systemCalculatorInfo, String groupName, String groupPath) throws Exception {
        String path = "/api/v4/groups";
        URL url = new URL(systemCalculatorInfo.getGitlabhost() + path);

        // 요청에 포함할 JSON 형식
        String bodyJson = "{\"name\":\"" + groupName + "\", " +
                          "\"path\":\"" + groupPath + "\"}";

        RequestBody body = RequestBody.create(MediaType.parse("application/json"), bodyJson);
        Request request = new Request.Builder()
                .url(url)
                .post(body)
                .addHeader("Content-Type", "application/json")
                .addHeader("PRIVATE-TOKEN", systemCalculatorInfo.getGitlabtoken())
                .build();

        OkHttpClient client = GitlabClientManager.getGitLabClient(systemCalculatorInfo);
        return request(client, request, GitlabType.GROUP);
    }


    public static GitlabObject addUserToGroup(SystemCalculatorInfo systemCalculatorInfo, String groupId, String userId, String accessLevel) throws Exception {
        String path = "/api/v4/groups/" + groupId + "/members";
        URL url = new URL(systemCalculatorInfo.getGitlabhost() + path);

        // 요청에 포함할 JSON 형식
        String bodyJson = "{\"user_id\":\"" + userId + "\", \"access_level\":\"" + accessLevel + "\"}";

        RequestBody body = RequestBody.create(MediaType.parse("application/json"), bodyJson);
        Request request = new Request.Builder()
                .url(url)
                .post(body)
                .addHeader("Content-Type", "application/json")
                .addHeader("PRIVATE-TOKEN", systemCalculatorInfo.getGitlabtoken())
                .build();

        OkHttpClient client = GitlabClientManager.getGitLabClient(systemCalculatorInfo);
        return request(client, request, GitlabType.GROUP_MEMBER);
    }


 // 그룹에서 사용자 삭제 메서드
    public static GitlabObject removeUserFromGroup(SystemCalculatorInfo systemCalculatorInfo, String groupId, String userId) throws Exception {
        String path = "/api/v4/groups/" + groupId + "/members/" + userId;
        URL url = new URL(systemCalculatorInfo.getGitlabhost() + path);

        Request request = new Request.Builder()
                .url(url)
                .delete()
                .addHeader("PRIVATE-TOKEN", systemCalculatorInfo.getGitlabtoken())
                .build();

        OkHttpClient client = GitlabClientManager.getGitLabClient(systemCalculatorInfo);
        return request(client, request, GitlabType.GROUP_MEMBER);
    }

    // 사용자 삭제
    public static GitlabObject deleteUser(SystemCalculatorInfo systemCalculatorInfo, String userId) throws Exception {
        String path = "/api/v4/users/" + userId;
        URL url = new URL(systemCalculatorInfo.getGitlabhost() + path);
        Request request = new Request.Builder()
                .url(url)
                .delete()
                .addHeader("PRIVATE-TOKEN", systemCalculatorInfo.getGitlabtoken())
                .build();

        OkHttpClient client = GitlabClientManager.getGitLabClient(systemCalculatorInfo);
        return request(client, request, GitlabType.USER);
    }

    // 프로젝트 생성
    public static GitlabObject createProject(SystemCalculatorInfo systemCalculatorInfo, String projectName, String groupId) throws Exception {
        String path = "/api/v4/projects";
        URL url = new URL(systemCalculatorInfo.getGitlabhost() + path);
        String bodyJson = "{\"name\":\"" + projectName + "\", \"namespace_id\":\"" + groupId + "\"}";
        RequestBody body = RequestBody.create(MediaType.parse("application/json"), bodyJson);
        Request request = new Request.Builder()
                .url(url)
                .post(body)
                .addHeader("Content-Type", "application/json")
                .addHeader("PRIVATE-TOKEN", systemCalculatorInfo.getGitlabtoken())
                .build();

        OkHttpClient client = GitlabClientManager.getGitLabClient(systemCalculatorInfo);
        return request(client, request, GitlabType.PROJECT);
    }

    // 파이프라인 생성
    public static GitlabObject createPipeline(SystemCalculatorInfo systemCalculatorInfo, String projectId) throws Exception {
        String path = "/api/v4/projects/" + projectId + "/pipeline";
        URL url = new URL(systemCalculatorInfo.getGitlabhost() + path);
        String bodyJson = "{\"ref\":\"main\"}";  // 필요한 경우 다른 ref 설정 가능
        RequestBody body = RequestBody.create(MediaType.parse("application/json"), bodyJson);
        Request request = new Request.Builder()
                .url(url)
                .post(body)
                .addHeader("Content-Type", "application/json")
                .addHeader("PRIVATE-TOKEN", systemCalculatorInfo.getGitlabtoken())
                .build();

        OkHttpClient client = GitlabClientManager.getGitLabClient(systemCalculatorInfo);
        return request(client, request, GitlabType.PIPELINE);
    }

    // 파이프라인 업데이트 (재실행 또는 변경)
    public static GitlabObject updatePipeline(SystemCalculatorInfo systemCalculatorInfo, String projectId, String pipelineId) throws Exception {
        String path = "/api/v4/projects/" + projectId + "/pipelines/" + pipelineId;
        URL url = new URL(systemCalculatorInfo.getGitlabhost() + path);
        RequestBody body = RequestBody.create(MediaType.parse("application/json"), "{\"ref\":\"main\"}");  // 업데이트 내용
        Request request = new Request.Builder()
                .url(url)
                .put(body)
                .addHeader("Content-Type", "application/json")
                .addHeader("PRIVATE-TOKEN", systemCalculatorInfo.getGitlabtoken())
                .build();

        OkHttpClient client = GitlabClientManager.getGitLabClient(systemCalculatorInfo);
        return request(client, request, GitlabType.PIPELINE);
    }

    // 프로젝트에 사용자 권한 추가
    public static GitlabObject addUserToProject(SystemCalculatorInfo systemCalculatorInfo, String projectId, String userId, String accessLevel) throws Exception {
        String path = "/api/v4/projects/" + projectId + "/members";
        URL url = new URL(systemCalculatorInfo.getGitlabhost() + path);
//        String bodyJson = "{\"user_id\":\"" + userId + "\", \"access_level\":\"" + accessLevel + "\"}";
        String bodyJson = "{\"user_id\":" + userId + ", \"access_level\":" + accessLevel + "}";
        RequestBody body = RequestBody.create(MediaType.parse("application/json"), bodyJson);
        Request request = new Request.Builder()
                .url(url)
                .post(body)
                .addHeader("Content-Type", "application/json")
                .addHeader("PRIVATE-TOKEN", systemCalculatorInfo.getGitlabtoken())
                .build();

        OkHttpClient client = GitlabClientManager.getGitLabClient(systemCalculatorInfo);
        return request(client, request, GitlabType.PROJECT_MEMBER);
    }

    // 프로젝트에서 사용자 권한 삭제
    public static GitlabObject removeUserFromProject(SystemCalculatorInfo systemCalculatorInfo, String projectId, String userId) throws Exception {
        String path = "/api/v4/projects/" + projectId + "/members/" + userId;
        URL url = new URL(systemCalculatorInfo.getGitlabhost() + path);
        Request request = new Request.Builder()
                .url(url)
                .delete()
                .addHeader("PRIVATE-TOKEN", systemCalculatorInfo.getGitlabtoken())
                .build();

        OkHttpClient client = GitlabClientManager.getGitLabClient(systemCalculatorInfo);
        return request(client, request, GitlabType.PROJECT_MEMBER);
    }

    public static GitlabObject getUsers(SystemCalculatorInfo systemCalculatorInfo, String searchEmail, String searchName) throws Exception {
        // GitLab 사용자 검색 API 경로
        String path = "/api/v4/users";
        URL url;

        // 이메일로 특정 사용자를 검색하는 경우, URL에 파라미터 추가
        if (searchEmail != null && !searchEmail.isEmpty()) {
            url = new URL(systemCalculatorInfo.getGitlabhost() + path + "?search=" + searchEmail);
        } else {
            url = new URL(systemCalculatorInfo.getGitlabhost() + path);  // 전체 사용자 목록 조회
        }

        // HTTP 요청 생성
        Request request = new Request.Builder()
                .url(url)
                .get()
                .addHeader("Content-Type", "application/json")
                .addHeader("PRIVATE-TOKEN", systemCalculatorInfo.getGitlabtoken())
                .build();

        // OkHttpClient를 통해 요청 실행
        OkHttpClient client = GitlabClientManager.getGitLabClient(systemCalculatorInfo);
        return request(client, request, GitlabType.USER_LIST);
    }


    public static GitlabObject getUsersByExaxtMatch(SystemCalculatorInfo systemCalculatorInfo, String searchEmail, String searchName) throws Exception {
        // GitLab 사용자 검색 API 경로
        String path = "/api/v4/users";
        URL url;
        url = new URL(systemCalculatorInfo.getGitlabhost() + path + "?search=" + searchEmail);

        // HTTP 요청 생성
        Request request = new Request.Builder()
                .url(url)
                .get()
                .addHeader("Content-Type", "application/json")
                .addHeader("PRIVATE-TOKEN", systemCalculatorInfo.getGitlabtoken())
                .build();

        // OkHttpClient를 통해 요청 실행
        OkHttpClient client = GitlabClientManager.getGitLabClient(systemCalculatorInfo);
        Response  response = client.newCall(request).execute();

        if (!response.isSuccessful()) {
        	throw new Exception("Failed to fetch user: " + response.code());
        }

        String responseBody = response.body().toString();
        JsonArray jsonArray = JsonParser.parseString(responseBody).getAsJsonArray();

        for(JsonElement element : jsonArray) {

        	JsonObject user = element.getAsJsonObject();
        	String userEmail = user.get("email").getAsString();
        	String userName = user.get("username").getAsString();

        	if (searchEmail.equals(userEmail) && searchName.equals(userName)) {
        		return new GitlabObject(GitlabType.USER, user.toString());
        	}
        }
        return null;
    }



    // 프로젝트 목록 조회
    public static GitlabObject getProjects(SystemCalculatorInfo systemCalculatorInfo) throws Exception {
        String path = "/api/v4/projects";
        URL url = new URL(systemCalculatorInfo.getGitlabhost() + path);
        Request request = new Request.Builder()
                .url(url)
                .get()
                .addHeader("PRIVATE-TOKEN", systemCalculatorInfo.getGitlabtoken())
                .build();

        OkHttpClient client = GitlabClientManager.getGitLabClient(systemCalculatorInfo);
        return request(client, request, GitlabType.PROJECT_LIST);
    }

    // 프로젝트 삭제
    public static GitlabObject deleteProject(SystemCalculatorInfo systemCalculatorInfo, String projectId) throws Exception {
        String path = "/api/v4/projects/" + projectId;
        URL url = new URL(systemCalculatorInfo.getGitlabhost() + path);
        Request request = new Request.Builder()
                .url(url)
                .delete()
                .addHeader("PRIVATE-TOKEN", systemCalculatorInfo.getGitlabtoken())
                .build();

        OkHttpClient client = GitlabClientManager.getGitLabClient(systemCalculatorInfo);
        return request(client, request, GitlabType.PROJECT);
    }

    // 파이프라인 목록 조회
    public static GitlabObject getPipelines(SystemCalculatorInfo systemCalculatorInfo) throws Exception {
        String projectId = "7";  // 실제 프로젝트 ID 사용
        String path = "/api/v4/projects/" + projectId + "/pipelines";
        URL url = new URL(systemCalculatorInfo.getGitlabhost() + path);
        Request request = new Request.Builder()
                .url(url)
                .get()
                .addHeader("PRIVATE-TOKEN", systemCalculatorInfo.getGitlabtoken())
                .build();

        OkHttpClient client = GitlabClientManager.getGitLabClient(systemCalculatorInfo);
        return request(client, request, GitlabType.PIPELINE_LIST);
    }

    // 특정 파이프라인 조회
    public static GitlabObject getPipelineById(SystemCalculatorInfo systemCalculatorInfo, String projectId, String pipelineId) throws Exception {
        String path = "/api/v4/projects/" + projectId + "/pipelines/" + pipelineId;
        URL url = new URL(systemCalculatorInfo.getGitlabhost() + path);
        Request request = new Request.Builder()
                .url(url)
                .get()
                .addHeader("PRIVATE-TOKEN", systemCalculatorInfo.getGitlabtoken())
                .build();

        OkHttpClient client = GitlabClientManager.getGitLabClient(systemCalculatorInfo);
        return request(client, request, GitlabType.PIPELINE);
    }


 // 프로젝트 파이프라인 삭제 메서드
    public static GitlabObject deletePipelineFromProject(SystemCalculatorInfo systemCalculatorInfo, String projectId, String pipelineId) throws Exception {
        String path = "/api/v4/projects/" + projectId + "/pipelines/" + pipelineId;
        URL url = new URL(systemCalculatorInfo.getGitlabhost() + path);

        Request request = new Request.Builder()
                .url(url)
                .delete()
                .addHeader("PRIVATE-TOKEN", systemCalculatorInfo.getGitlabtoken())
                .build();

        OkHttpClient client = GitlabClientManager.getGitLabClient(systemCalculatorInfo);
        return request(client, request, GitlabType.PIPELINE);
    }


 // 프로젝트에 브랜치 생성
    public static GitlabObject createBranch(SystemCalculatorInfo systemCalculatorInfo, String projectId, String branchName, String ref) throws Exception {
        String path = "/api/v4/projects/" + projectId + "/repository/branches";
        URL url = new URL(systemCalculatorInfo.getGitlabhost() + path);

        // 브랜치를 만들 때 필요한 JSON 데이터 (브랜치 이름과 참조할 ref 정보)
        String bodyJson = "{\"branch\":\"" + branchName + "\", \"ref\":\"" + ref + "\"}";

        RequestBody body = RequestBody.create(MediaType.parse("application/json"), bodyJson);
        Request request = new Request.Builder()
                .url(url)
                .post(body)
                .addHeader("Content-Type", "application/json")
                .addHeader("PRIVATE-TOKEN", systemCalculatorInfo.getGitlabtoken())
                .build();

        OkHttpClient client = GitlabClientManager.getGitLabClient(systemCalculatorInfo);
        return request(client, request, GitlabType.BRANCH);
    }


    // 프로젝트의 브랜치 리스트 가져오기
    public static GitlabObject getBranches(SystemCalculatorInfo systemCalculatorInfo, String projectId) throws Exception {
        String path = "/api/v4/projects/" + projectId + "/repository/branches";
        URL url = new URL(systemCalculatorInfo.getGitlabhost() + path);

        Request request = new Request.Builder()
                .url(url)
                .get()
                .addHeader("PRIVATE-TOKEN", systemCalculatorInfo.getGitlabtoken())
                .build();

        OkHttpClient client = GitlabClientManager.getGitLabClient(systemCalculatorInfo);
        return request(client, request, GitlabType.BRANCH_LIST);
    }


    // GitLab 프로젝트에 .gitlab-ci.yml 파일을 업데이트하는 메서드
    public static GitlabObject updateGitlabCIPipelineFile(SystemCalculatorInfo systemCalculatorInfo, String projectId, String branchName, String content, String commitMessage) throws Exception {
        String path = "/api/v4/projects/" + projectId + "/repository/files/.gitlab-ci.yml";
        URL url = new URL(systemCalculatorInfo.getGitlabhost() + path);

        // 요청에 포함할 JSON 데이터 구성
        String bodyJson = "{"
            + "\"branch\":\"" + branchName + "\", "
            + "\"content\":\"" + content + "\", "
            + "\"commit_message\":\"" + commitMessage + "\"}";

        RequestBody body = RequestBody.create(MediaType.parse("application/json"), bodyJson);
        Request request = new Request.Builder()
                .url(url)
                .put(body)
                .addHeader("Content-Type", "application/json")
                .addHeader("PRIVATE-TOKEN", systemCalculatorInfo.getGitlabtoken())
                .build();

        OkHttpClient client = GitlabClientManager.getGitLabClient(systemCalculatorInfo);
        return request(client, request, GitlabType.FILE);
    }


    // GitLab 프로젝트에 .gitlab-ci.yml 파일을 추가하는 메서드
    public static GitlabObject insertGitlabCIPipelineFile(SystemCalculatorInfo systemCalculatorInfo, String projectId, String branchName, String content, String commitMessage, String ymlName) throws Exception {
        String path = "/api/v4/projects/" + projectId + "/repository/files/" + ymlName;
        log.info("insert Gitlab CI Pipeline File", path);
        URL url = new URL(systemCalculatorInfo.getGitlabhost() + path);

        String encodedContent = Base64.getEncoder().encodeToString(content.getBytes());
        String encodeType = "base64";

        // 요청에 포함할 JSON 데이터 구성
        String bodyJson = String.format("{ \"branch\":\"%s\", \"content\":\"%s\", \"commit_message\":\"%s\", \"encoding\":\"%s\"}", branchName, encodedContent, commitMessage, encodeType);
        log.info("insert Gitlab CI Pipeline File bodyJson", bodyJson);
        RequestBody body = RequestBody.create(MediaType.parse("application/json"), bodyJson);
        Request request = new Request.Builder()
                .url(url)
                .post(body)
                .addHeader("Content-Type", "application/json")
                .addHeader("PRIVATE-TOKEN", systemCalculatorInfo.getGitlabtoken())
                .build();

        OkHttpClient client = GitlabClientManager.getGitLabClient(systemCalculatorInfo);
        return request(client, request, GitlabType.FILE);
    }


    public static void addUserToProjectDevelopRole(SystemCalculatorInfo systemCalculatorInfo, String projectId, String userId) throws Exception {
        String path = "/api/v4/projects/" + projectId + "/members";
        String bodyJson = "{\"user_id\": \"" + userId + "\", \"access_level\": 30}"; // 30은 Develop 권한을 의미
        URL url = new URL(systemCalculatorInfo.getGitlabhost() + path);
        RequestBody body = RequestBody.create(MediaType.parse("application/json"), bodyJson);
        Request request = new Request.Builder()
                .url(url)
                .post(body)
                .addHeader("Content-Type", "application/json")
                .addHeader("PRIVATE-TOKEN", systemCalculatorInfo.getGitlabtoken())
                .build();

        OkHttpClient client = GitlabClientManager.getGitLabClient(systemCalculatorInfo);
        GitlabUtils.request(client, request, GitlabType.PROJECT_MEMBER);
    }

    public static void createTagAndTriggerPipeline(SystemCalculatorInfo systemCalculatorInfo, String projectId, String tagName, String ref, String variablesJson) throws Exception {
        // 태그 생성
        String tagPath = "/api/v4/projects/" + projectId + "/repository/tags";
        String tagBody = "{\"tag_name\": \"" + tagName + "\", \"ref\": \"" + ref + "\"}";
        URL tagUrl = new URL(systemCalculatorInfo.getGitlabhost() + tagPath);
        RequestBody tagRequestBody = RequestBody.create(MediaType.parse("application/json"), tagBody);
        Request tagRequest = new Request.Builder()
                .url(tagUrl)
                .post(tagRequestBody)
                .addHeader("Content-Type", "application/json")
                .addHeader("PRIVATE-TOKEN", systemCalculatorInfo.getGitlabtoken())
                .build();
        OkHttpClient client = GitlabClientManager.getGitLabClient(systemCalculatorInfo);
        GitlabUtils.request(client, tagRequest, GitlabType.TAG);

        // 파이프라인 호출
        String pipelinePath = "/api/v4/projects/" + projectId + "/trigger/pipeline";
        String pipelineBody = "{\"ref\": \"" + tagName + "\", \"variables\": " + variablesJson + "}";
        URL pipelineUrl = new URL(systemCalculatorInfo.getGitlabhost() + pipelinePath);
        RequestBody pipelineRequestBody = RequestBody.create(MediaType.parse("application/json"), pipelineBody);
        Request pipelineRequest = new Request.Builder()
                .url(pipelineUrl)
                .post(pipelineRequestBody)
                .addHeader("Content-Type", "application/json")
                .addHeader("PRIVATE-TOKEN", systemCalculatorInfo.getGitlabtoken())
                .build();
        GitlabUtils.request(client, pipelineRequest, GitlabType.PIPELINE);
    }

    public static GitlabObject createMergeRequest(SystemCalculatorInfo systemCalculatorInfo, String projectId, String sourceBranch, String targetBranch, String title, String description, String assigneeId, boolean removeSourceBranch) throws Exception {
        String path = "/api/v4/projects/" + projectId + "/merge_requests";
        String bodyJson = String.format("{\"source_branch\":\"%s\", \"target_branch\":\"%s\", \"title\":\"%s\", \"description\":\"%s\", \"assignee_id\":\"%s\", \"remove_source_branch\":%b}", sourceBranch, targetBranch, title, description, assigneeId, removeSourceBranch);
        URL url = new URL(systemCalculatorInfo.getGitlabhost() + path);
        RequestBody body = RequestBody.create(MediaType.parse("application/json"), bodyJson);
        Request request = new Request.Builder()
                .url(url)
                .post(body)
                .addHeader("Content-Type", "application/json")
                .addHeader("PRIVATE-TOKEN", systemCalculatorInfo.getGitlabtoken())
                .build();

        OkHttpClient client = GitlabClientManager.getGitLabClient(systemCalculatorInfo);
        return request(client, request, GitlabType.MERGE_REQUEST);
    }

    public static GitlabObject getOpenMergeRequests(SystemCalculatorInfo systemCalculatorInfo, String projectId) throws Exception {
        String path = "/api/v4/projects/" + projectId + "/merge_requests?state=opened";
        URL url = new URL(systemCalculatorInfo.getGitlabhost() + path);
        Request request = new Request.Builder()
                .url(url)
                .get()
                .addHeader("Content-Type", "application/json")
                .addHeader("PRIVATE-TOKEN", systemCalculatorInfo.getGitlabtoken())
                .build();

        OkHttpClient client = GitlabClientManager.getGitLabClient(systemCalculatorInfo);
        return request(client, request, GitlabType.MERGE_REQUEST_LIST);
    }

    public static void deleteMergeRequest(SystemCalculatorInfo systemCalculatorInfo, String projectId, String mergeRequestId) throws Exception {
        String path = "/api/v4/projects/" + projectId + "/merge_requests/" + mergeRequestId;
        URL url = new URL(systemCalculatorInfo.getGitlabhost() + path);
        Request request = new Request.Builder()
                .url(url)
                .delete()
                .addHeader("Content-Type", "application/json")
                .addHeader("PRIVATE-TOKEN", systemCalculatorInfo.getGitlabtoken())
                .build();

        OkHttpClient client = GitlabClientManager.getGitLabClient(systemCalculatorInfo);
        request(client, request, GitlabType.MERGE_REQUEST);
    }

    public static void performMergeRequest(SystemCalculatorInfo systemCalculatorInfo, String projectId, String mergeRequestId) throws Exception {
        String path = "/api/v4/projects/" + projectId + "/merge_requests/" + mergeRequestId + "/merge";
        URL url = new URL(systemCalculatorInfo.getGitlabhost() + path);
        Request request = new Request.Builder()
                .url(url)
                .put(RequestBody.create(null, new byte[0]))  // PUT with empty body
                .addHeader("Content-Type", "application/json")
                .addHeader("PRIVATE-TOKEN", systemCalculatorInfo.getGitlabtoken())
                .build();

        OkHttpClient client = GitlabClientManager.getGitLabClient(systemCalculatorInfo);
        request(client, request, GitlabType.MERGE_REQUEST);
    }


    public static GitlabObject setMergeRequestApprover(SystemCalculatorInfo systemCalculatorInfo, String projectId, String ruleName, int approvalsRequired, String userIds) throws Exception {
        String path = "/api/v4/projects/" + projectId + "/approval_rules";
        String bodyJson = String.format("{\"name\":\"%s\", \"approvals_required\":%d, \"user_ids\":\"%s\"}", ruleName, approvalsRequired, userIds);
        URL url = new URL(systemCalculatorInfo.getGitlabhost() + path);
        RequestBody body = RequestBody.create(MediaType.parse("application/json"), bodyJson);
        Request request = new Request.Builder()
                .url(url)
                .post(body)
                .addHeader("Content-Type", "application/json")
                .addHeader("PRIVATE-TOKEN", systemCalculatorInfo.getGitlabtoken())
                .build();

        OkHttpClient client = GitlabClientManager.getGitLabClient(systemCalculatorInfo);
        return request(client, request, GitlabType.APPROVAL_RULE);
    }

    public static GitlabObject getMergeRequestRules(SystemCalculatorInfo systemCalculatorInfo, String projectId) throws Exception {
        String path = "/api/v4/projects/" + projectId + "/approval_rules";
        URL url = new URL(systemCalculatorInfo.getGitlabhost() + path);
        Request request = new Request.Builder()
                .url(url)
                .get()
                .addHeader("Content-Type", "application/json")
                .addHeader("PRIVATE-TOKEN", systemCalculatorInfo.getGitlabtoken())
                .build();

        OkHttpClient client = GitlabClientManager.getGitLabClient(systemCalculatorInfo);
        return request(client, request, GitlabType.APPROVAL_RULE_LIST);
    }


    public static void deleteMergeRequestRule(SystemCalculatorInfo systemCalculatorInfo, String projectId, String ruleId) throws Exception {
        String path = "/api/v4/projects/" + projectId + "/approval_rules/" + ruleId;
        URL url = new URL(systemCalculatorInfo.getGitlabhost() + path);
        Request request = new Request.Builder()
                .url(url)
                .delete()
                .addHeader("Content-Type", "application/json")
                .addHeader("PRIVATE-TOKEN", systemCalculatorInfo.getGitlabtoken())
                .build();

        OkHttpClient client = GitlabClientManager.getGitLabClient(systemCalculatorInfo);
        request(client, request, GitlabType.APPROVAL_RULE);
    }

    public static void approveMergeRequest(SystemCalculatorInfo systemCalculatorInfo, String projectId, String mergeRequestId) throws Exception {
        String path = "/api/v4/projects/" + projectId + "/merge_requests/" + mergeRequestId + "/approve";
        URL url = new URL(systemCalculatorInfo.getGitlabhost() + path);
        Request request = new Request.Builder()
                .url(url)
                .post(RequestBody.create(null, new byte[0]))  // POST with empty body
                .addHeader("Content-Type", "application/json")
                .addHeader("PRIVATE-TOKEN", systemCalculatorInfo.getGitlabtoken())
                .build();

        OkHttpClient client = GitlabClientManager.getGitLabClient(systemCalculatorInfo);
        request(client, request, GitlabType.MERGE_REQUEST_APPROVE);
    }

    public static GitlabObject selectTag(SystemCalculatorInfo systemCalculatorInfo, String projectId, String tagName) throws Exception {
        String path = "/api/v4/projects/" + projectId + "/repository/tags/" + tagName;
        URL url = new URL(systemCalculatorInfo.getGitlabhost() + path);

        Request request = new Request.Builder()
                .url(url)
                .get()
                .addHeader("PRIVATE-TOKEN", systemCalculatorInfo.getGitlabtoken())
                .build();

        OkHttpClient client = GitlabClientManager.getGitLabClient(systemCalculatorInfo);
        return GitlabUtils.request(client, request, GitlabType.TAG);
    }

    public static void deleteTag(SystemCalculatorInfo systemCalculatorInfo, String projectId, String tagName) throws Exception {
        String path = "/api/v4/projects/" + projectId + "/repository/tags/" + tagName;
        URL url = new URL(systemCalculatorInfo.getGitlabhost() + path);

        Request request = new Request.Builder()
                .url(url)
                .delete()
                .addHeader("PRIVATE-TOKEN", systemCalculatorInfo.getGitlabtoken())
                .build();

        OkHttpClient client = GitlabClientManager.getGitLabClient(systemCalculatorInfo);
        GitlabUtils.request(client, request, GitlabType.TAG);
    }


    public static GitlabObject createTag(SystemCalculatorInfo systemCalculatorInfo, String projectId, String tagName, String ref, String message) throws Exception {
        String path = "/api/v4/projects/" + projectId + "/repository/tags";
        URL url = new URL(systemCalculatorInfo.getGitlabhost() + path);

        String bodyJson = "{"
                + "\"tag_name\": \"" + tagName + "\", "
                + "\"ref\": \"" + ref + "\", "
                + "\"message\": \"" + message + "\""
                + "}";

        RequestBody body = RequestBody.create(MediaType.parse("application/json"), bodyJson);
        Request request = new Request.Builder()
                .url(url)
                .post(body)
                .addHeader("Content-Type", "application/json")
                .addHeader("PRIVATE-TOKEN", systemCalculatorInfo.getGitlabtoken())
                .build();

        OkHttpClient client = GitlabClientManager.getGitLabClient(systemCalculatorInfo);
        return GitlabUtils.request(client, request, GitlabType.TAG);
    }

    public static GitlabObject createTag(SystemCalculatorInfo systemCalculatorInfo, String projectId, String tagName, String ref, String message, CustomReqProductVO projectUserInfo) throws Exception {
    	String path = "/api/v4/projects/" + projectId + "/repository/tags";
    	URL url = new URL(systemCalculatorInfo.getGitlabhost() + path);

    	String bodyJson = "{"
    			+ "\"tag_name\": \"" + tagName + "\", "
    			+ "\"ref\": \"" + ref + "\", "
    			+ "\"message\": \"" + message + "\""
    			+ "}";

    	RequestBody body = RequestBody.create(MediaType.parse("application/json"), bodyJson);
    	Request request = new Request.Builder()
    			.url(url)
    			.post(body)
    			.addHeader("Content-Type", "application/json")
//    			.addHeader("PRIVATE-TOKEN", systemCalculatorInfo.getGitlabtoken())
    			.addHeader("PRIVATE-TOKEN", projectUserInfo.getToken())
    			.build();

    	OkHttpClient client = GitlabClientManager.getGitLabClient(systemCalculatorInfo);
    	return GitlabUtils.request(client, request, GitlabType.TAG);
    }

    public static GitlabObject triggerPipeline(SystemCalculatorInfo systemCalculatorInfo, String projectId, String ref, Map<String, String> variables) throws Exception {
        String path = "/api/v4/projects/" + projectId + "/pipeline";
        URL url = new URL(systemCalculatorInfo.getGitlabhost() + path);

        // Manually build the JSON array for variables
        StringBuilder variablesJsonBuilder = new StringBuilder("[");
        for (Map.Entry<String, String> entry : variables.entrySet()) {
            variablesJsonBuilder.append("{\"key\":\"").append(entry.getKey()).append("\",\"value\":\"")
                    .append(entry.getValue()).append("\"},");
        }
        // Remove the trailing comma and close the JSON array
        if (variablesJsonBuilder.length() > 1) {
            variablesJsonBuilder.setLength(variablesJsonBuilder.length() - 1);
        }
        variablesJsonBuilder.append("]");

        // Construct the full JSON body
        String bodyJson = "{"
                + "\"ref\": \"" + ref + "\", "
                + "\"variables\": " + variablesJsonBuilder.toString()
                + "}";

        RequestBody body = RequestBody.create(MediaType.parse("application/json"), bodyJson);
        Request request = new Request.Builder()
                .url(url)
                .post(body)
                .addHeader("Content-Type", "application/json")
                .addHeader("PRIVATE-TOKEN", systemCalculatorInfo.getGitlabtoken())
                .build();

        OkHttpClient client = GitlabClientManager.getGitLabClient(systemCalculatorInfo);
        return GitlabUtils.request(client, request, GitlabType.PIPELINE);
    }

    public static GitlabObject triggerPipeline(SystemCalculatorInfo systemCalculatorInfo, String projectId, String ref, Map<String, String> variables, CustomReqProductVO projectUserInfo) throws Exception {
    	String path = "/api/v4/projects/" + projectId + "/pipeline";
    	URL url = new URL(systemCalculatorInfo.getGitlabhost() + path);

    	// Manually build the JSON array for variables
    	StringBuilder variablesJsonBuilder = new StringBuilder("[");
    	for (Map.Entry<String, String> entry : variables.entrySet()) {
    		variablesJsonBuilder.append("{\"key\":\"").append(entry.getKey()).append("\",\"value\":\"")
    		.append(entry.getValue()).append("\"},");
    	}
    	// Remove the trailing comma and close the JSON array
    	if (variablesJsonBuilder.length() > 1) {
    		variablesJsonBuilder.setLength(variablesJsonBuilder.length() - 1);
    	}
    	variablesJsonBuilder.append("]");

    	// Construct the full JSON body
    	String bodyJson = "{"
    			+ "\"ref\": \"" + ref + "\", "
    			+ "\"variables\": " + variablesJsonBuilder.toString()
    			+ "}";

    	// CICD 프로젝트 Maintainer Token 값으로 pipeline 실행
    	RequestBody body = RequestBody.create(MediaType.parse("application/json"), bodyJson);
    	Request request = new Request.Builder()
    			.url(url)
    			.post(body)
    			.addHeader("Content-Type", "application/json")
//    			.addHeader("PRIVATE-TOKEN", systemCalculatorInfo.getGitlabtoken())
    			.addHeader("PRIVATE-TOKEN", projectUserInfo.getToken())
    			.build();

    	OkHttpClient client = GitlabClientManager.getGitLabClient(systemCalculatorInfo);
    	return GitlabUtils.request(client, request, GitlabType.PIPELINE);
    }



    // Get the latest pipeline ID for a specific ref (branch or tag)
    public static GitlabObject getLatestPipelineId(SystemCalculatorInfo systemCalculatorInfo, String projectId, String ref) throws Exception {
        String path = "/api/v4/projects/" + projectId + "/pipelines?ref=" + ref + "&per_page=1";
        URL url = new URL(systemCalculatorInfo.getGitlabhost() + path);

        Request request = new Request.Builder()
                .url(url)
                .get()
                .addHeader("PRIVATE-TOKEN", systemCalculatorInfo.getGitlabtoken())
                .build();

        OkHttpClient client = GitlabClientManager.getGitLabClient(systemCalculatorInfo);

        return GitlabUtils.request(client, request, GitlabType.PIPELINE_LIST);

    }

    // Get the result of a specific pipeline
    public static GitlabObject getPipelineResult(SystemCalculatorInfo systemCalculatorInfo, String projectId, String pipelineId) throws Exception {
        String path = "/api/v4/projects/" + projectId + "/pipelines/" + pipelineId;
        URL url = new URL(systemCalculatorInfo.getGitlabhost() + path);

        Request request = new Request.Builder()
                .url(url)
                .get()
                .addHeader("PRIVATE-TOKEN", systemCalculatorInfo.getGitlabtoken())
                .build();

        OkHttpClient client = GitlabClientManager.getGitLabClient(systemCalculatorInfo);
        return GitlabUtils.request(client, request, GitlabType.PIPELINE);
    }


    // Job 목록 조회
    public static GitlabObject getJobs(SystemCalculatorInfo systemCalculatorInfo, String projectId, String pipelineId) throws Exception {

        String path = "/api/v4/projects/" + projectId + "/pipelines/" + pipelineId + "/jobs";
        URL url = new URL(systemCalculatorInfo.getGitlabhost() + path);
        Request request = new Request.Builder()
                .url(url)
                .get()
                .addHeader("PRIVATE-TOKEN", systemCalculatorInfo.getGitlabtoken())
                .build();

        OkHttpClient client = GitlabClientManager.getGitLabClient(systemCalculatorInfo);
        return GitlabUtils.request(client, request, GitlabType.PIPELINE_LIST);
    }

    // Context Dir 조회
    public static GitlabObject getGitlabContextDir(SystemCalculatorInfo systemCalculatorInfo, String projectId, String branceName) throws Exception {

        String path = "/api/v4/projects/" + projectId + "/repository/tree?ref=" + branceName;

        URL url = new URL(systemCalculatorInfo.getGitlabhost() + path);
        Request request = new Request.Builder()
                .url(url)
                .get()
                .addHeader("PRIVATE-TOKEN", systemCalculatorInfo.getGitlabtoken())
                .build();

        OkHttpClient client = GitlabClientManager.getGitLabClient(systemCalculatorInfo);
        return GitlabUtils.request(client, request, GitlabType.PIPELINE_LIST);
    }

    // environment 생성(prod)
    public static GitlabObject createProdEnvironment(SystemCalculatorInfo systemCalculatorInfo, String projectId) throws Exception {

    	String path = "/api/v4/projects/" + projectId + "/environments";
    	URL url = new URL(systemCalculatorInfo.getGitlabhost() + path);

        String environmentJobName = "prod_job";
        RequestBody body = new FormBody.Builder().add("name", environmentJobName).build();

    	Request request = new Request.Builder()
    			.url(url)
    			.post(body)
                .addHeader("Content-Type", "application/json")
    			.addHeader("PRIVATE-TOKEN", systemCalculatorInfo.getGitlabtoken())
    			.build();

    	OkHttpClient client = GitlabClientManager.getGitLabClient(systemCalculatorInfo);
    	return GitlabUtils.request(client, request, GitlabType.ENVIRONMENT);
    }

    // environment 확인
    public static GitlabObject environmentCheck(SystemCalculatorInfo systemCalculatorInfo, String projectId) throws Exception {

    	String path = "/api/v4/projects/" + projectId + "/environments";

    	URL url = new URL(systemCalculatorInfo.getGitlabhost() + path);
    	Request request = new Request.Builder()
    			.url(url)
    			.get()
    			.addHeader("PRIVATE-TOKEN", systemCalculatorInfo.getGitlabtoken())
    			.build();

    	OkHttpClient client = GitlabClientManager.getGitLabClient(systemCalculatorInfo);
    	return GitlabUtils.request(client, request, GitlabType.CHECK_ENVIRONMENT);
    }


//    curl --request POST
//    --header "PRIVATE-TOKEN: ADMIN_TOKEN_VALUE"
//    --header "Content-Type: application/json"
//    --data '{"name": "prod_job", "deploy_access_levels": [{"access_level": 40}], "approval_rules": [{"user_id": 1}]}'
//    "https://gitlabsvr.kepco.co.kr/api/v4/projects/PROJECT_ID/protected_environments"
    // Protected environment 설정
    public static GitlabObject protectedEnvironmentConfig(SystemCalculatorInfo systemCalculatorInfo, String projectId) throws Exception {

    	String path = "/api/v4/projects/" + projectId + "/protected_environments";
    	URL url = new URL(systemCalculatorInfo.getGitlabhost() + path);

    	JSONObject json = new JSONObject();
        String environmentJobName = "prod_job";
    	json.put("name", environmentJobName);

    	JSONArray deployAccessLevelsArray = new JSONArray();
    	JSONObject accessLevelObj = new JSONObject();

    	JSONArray approvalRulesArray = new JSONArray();
    	JSONObject approvalRulesObj = new JSONObject();

    	accessLevelObj.put("access_level", 40);
    	deployAccessLevelsArray.put(accessLevelObj);

    	approvalRulesObj.put("user_id", 1);
    	approvalRulesArray.put(approvalRulesObj);

    	json.put("deploy_access_levels", deployAccessLevelsArray);
    	json.put("approval_rules", approvalRulesArray);

    	MediaType MEDIA_TYPE_JSON = MediaType.parse("application/json");
    	RequestBody body = RequestBody.create(json.toString(), MEDIA_TYPE_JSON);

    	Request request = new Request.Builder()
    			.url(url)
    			.post(body)
                .addHeader("Content-Type", "application/json")
    			.addHeader("PRIVATE-TOKEN", systemCalculatorInfo.getGitlabtoken())
    			.build();

    	OkHttpClient client = GitlabClientManager.getGitLabClient(systemCalculatorInfo);
    	return GitlabUtils.request(client, request, GitlabType.PROTECTED_ENVIRONMENT);
    }

    //    curl --request GET --header "PRIVATE-TOKEN: ADMIN_TOKEN_VALUE" "https://gitlabsvr.kepco.co.kr/api/v4/projects/PROJECT_ID/protected_environments" | jq .
    // Protected environment 조회
    public static GitlabObject protectedEnvironmentCheck(SystemCalculatorInfo systemCalculatorInfo, String projectId) throws Exception {

    	String path = "/api/v4/projects/" + projectId + "/protected_environments";
    	URL url = new URL(systemCalculatorInfo.getGitlabhost() + path);

    	Request request = new Request.Builder()
    			.url(url)
    			.get()
    			.addHeader("PRIVATE-TOKEN", systemCalculatorInfo.getGitlabtoken())
    			.build();

    	OkHttpClient client = GitlabClientManager.getGitLabClient(systemCalculatorInfo);
    	return GitlabUtils.request(client, request, GitlabType.CHECK_PROTECTED_ENVIRONMENT);

    }

    // curl --request GET --header "PRIVATE-TOKEN: ADMIN_TOKEN_VALUE" "https://gitlabsvr.kepco.co.kr/api/v4/projects/PROJECT_ID/deployments"
    // |jq '.[] | select(.status=="blocked" and .ref=="copy.appname") | .id'
    // 승인대기중인 Deployment 확인
    public static GitlabObject waitingDeploymentCheck(SystemCalculatorInfo systemCalculatorInfo, String projectId) throws Exception {

    	String path = "/api/v4/projects/" + projectId + "/deployments";
    	URL url = new URL(systemCalculatorInfo.getGitlabhost() + path);

    	Request request = new Request.Builder()
    			.url(url)
    			.get()
    			.addHeader("PRIVATE-TOKEN", systemCalculatorInfo.getGitlabtoken())
    			.build();

    	OkHttpClient client = GitlabClientManager.getGitLabClient(systemCalculatorInfo);
    	return GitlabUtils.request(client, request, GitlabType.CHECK_DEPLOYMENT);
    }

    // curl --request POST --header "PRIVATE-TOKEN: ADMIN_TOKEN_VALUE" --data "status=approved"
    // "https://gitlabsvr.kepco.co.kr/api/v4/projects/PROJECT_ID/deployments/DEPLOYMENT_ID/approval"
    // 승인대기중인 Deployment 승인
    public static GitlabObject waitingDeploymentStart(SystemCalculatorInfo systemCalculatorInfo, String projectId, String deploymentId) throws Exception {

    	String path = "/api/v4/projects/" + projectId + "/deployments/" + deploymentId + "/approval";
    	URL url = new URL(systemCalculatorInfo.getGitlabhost() + path);

    	JSONObject jsonObj = new JSONObject();
    	jsonObj.put("status", "approved");

    	MediaType MEDIA_TYPE_JSON = MediaType.parse("application/json");
    	RequestBody body = RequestBody.create(jsonObj.toString(), MEDIA_TYPE_JSON);

    	Request request = new Request.Builder()
    			.url(url)
    			.post(body)
    			.addHeader("PRIVATE-TOKEN", systemCalculatorInfo.getGitlabtoken())
    			.build();

    	OkHttpClient client = GitlabClientManager.getGitLabClient(systemCalculatorInfo);
    	return GitlabUtils.request(client, request, GitlabType.DEPLOYMENT_START);
    }

    // curl --request GET --header "PRIVATE-TOKEN: ADMIN_TOKEN_VALUE"
    // "https://gitlabsvr.kepco.co.kr/api/v4/projects/PROJECT_ID/deployments/DEPLOYMENT_ID" |jq '.deployable|{id, status, name}'
    // 승인된 deployment에서 manual 상태인 job id 조회
    public static GitlabObject getManualStatusList(SystemCalculatorInfo systemCalculatorInfo, String projectId, String deploymentId) throws Exception {

    	String path = "/api/v4/projects/" + projectId + "/deployments/" + deploymentId;
    	URL url = new URL(systemCalculatorInfo.getGitlabhost() + path);
    	log.info("getManual StatusList {}", path);

    	Request request = new Request.Builder()
    			.url(url)
    			.get()
    			.addHeader("PRIVATE-TOKEN", systemCalculatorInfo.getGitlabtoken())
    			.build();

    	OkHttpClient client = GitlabClientManager.getGitLabClient(systemCalculatorInfo);
    	return GitlabUtils.request(client, request, GitlabType.CHECK_MENUAL_STATUS );
    }

    // curl --request POST --header "PRIVATE-TOKEN: ADMIN_TOKEN_VALUE" --data "status=approved"
    // "https://gitlabsvr.kepco.co.kr/api/v4/projects/PROJECT_ID/jobs/JOB_ID/play"
    // 승인된 후 manual 상태인 job 실행
    public static GitlabObject manualStatusJobStart(SystemCalculatorInfo systemCalculatorInfo, String projectId, String jobId) throws Exception {

    	String path = "/api/v4/projects/" + projectId + "/jobs/" + jobId +"/play";
    	URL url = new URL(systemCalculatorInfo.getGitlabhost() + path);

    	JSONObject jsonObj = new JSONObject();
    	jsonObj.put("status", "approved");

    	MediaType MEDIA_TYPE_JSON = MediaType.parse("application/json");
    	RequestBody body = RequestBody.create(jsonObj.toString(), MEDIA_TYPE_JSON);

    	Request request = new Request.Builder()
    			.url(url)
    			.post(body)
    			.addHeader("PRIVATE-TOKEN", systemCalculatorInfo.getGitlabtoken())
    			.build();

    	log.info("manualStatusJobStart req : {}", request);
    	log.info("manualStatusJobStart jsonObj : {}", jsonObj);
    	OkHttpClient client = GitlabClientManager.getGitLabClient(systemCalculatorInfo);
    	return GitlabUtils.request(client, request, GitlabType.MENUAL_STATUS_START);
    }

    // pipeline editor yml file download
    public static String getPipelineConfigYml(SystemCalculatorInfo systemCalculatorInfo, String projectId, String fileName, String branchName) throws Exception {

    	String path = "/api/v4/projects/" + projectId + "/repository/files/" + fileName + "/raw?ref=" + branchName;
    	URL url = new URL(systemCalculatorInfo.getGitlabhost() + path);

    	Request request = new Request.Builder()
    			.url(url)
    			.get()
    			.addHeader("PRIVATE-TOKEN", systemCalculatorInfo.getGitlabtoken())
    			.build();

    	String ymlText = "";
    	OkHttpClient client = GitlabClientManager.getGitLabClient(systemCalculatorInfo);
//    	return GitlabUtils.request(client, request, GitlabType.CHECK_PROTECTED_ENVIRONMENT)/;
        try (Response response = client.newCall(request).execute()) {
            if (response.isSuccessful() && response.body() != null) {
            	ymlText = response.body().string();
            }else {
                throw new GitlabException(response.code(), response.message());
            }
        }
    	return ymlText;
    }

}
