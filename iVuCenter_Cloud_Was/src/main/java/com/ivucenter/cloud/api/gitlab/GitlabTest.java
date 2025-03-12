package com.ivucenter.cloud.api.gitlab;

import java.net.URL;

import org.json.JSONArray;
import org.json.JSONObject;

import com.google.gson.JsonElement;
import com.ivucenter.cloud.api.common.utils.SystemCalculatorInfo;
import com.ivucenter.cloud.api.gitlab.connector.GitlabClientManager;
import com.ivucenter.cloud.portal.req.product.CustomReqProductVO;
import com.ivucenter.cloud.portal.util.CodeUtil;

import lombok.extern.slf4j.Slf4j;
import okhttp3.FormBody;
import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

@Slf4j
public class GitlabTest {

    public static void main(String[] args) throws Exception {

    	String resource = "file:WebContent/WEB-INF/spring/application-context.xml";
//    	Reader reader = R

        // GitLab 연결 정보 설정
        SystemCalculatorInfo systemCalculatorInfo = new SystemCalculatorInfo();
        systemCalculatorInfo.setGitlabtoken("glpat-27swFiPQNX7AuAdyY4Yk");
        systemCalculatorInfo.setGitlabhost("https://100.1.223.231");
        systemCalculatorInfo.setGitlabusername("root");
        systemCalculatorInfo.setGitlabpassword("kepco123$");

		String orderProductSeq = "20241202202651";

        // 사용자 추가
        String newUsername = "root";
        String newUserEmail = "user5email@test.com";
        String newUserPassword = "kepco123$";
//        createUser(systemCalculatorInfo, newUsername, newUserEmail, newUserPassword);

        // git project name = gitproject88888
        String projectId = "137";
//        String pipelineId = "448";
        GitlabObject gitObj;

        String cloudId = "hgc2cb70-2293-48be-b131-8c5a3035e614";
		CustomReqProductVO res = new CustomReqProductVO();
//		SystemCalculatorInfo systemCalculatorInfo = new SystemCalculatorInfo();

		res.setCloudId(cloudId);

//		List<CustomReqProductVO> envUserList = sqlSessionTemplate.selectList(detailBssOrderProductEnvUserList,orderProductSeq);
//		CustomReqProductVO configTemplateInfo = this.sqlSessionTemplate.selectOne(detailConfigTemplate,"1");
//		CustomReqProductVO configTemplateInfo = new CustomReqProductVO();
//		String yamlContent = configTemplateInfo.getContent();

        String fileName = ".gitlab-ci.yml";
//        String fileName = "staging.yml";
//        String fileName = "production.yml";
        String branchName = "develop";

        String ymlText = "";
        ymlText = getPipelineConfigYml(systemCalculatorInfo, projectId, fileName, branchName);
		log.info("environment 생성 정보 : {}", ymlText);

//		log.info("environment 생성 정보 : {}", gitObj.getJsonArray());



//        getCicdPipelineJob();
        // 사용자 목록 조회
//        getUsers(systemCalculatorInfo, null);

        // 특정 사용자 목록 조회
//        getUsers(systemCalculatorInfo, newUserEmail);

        // 그룹 생성
//        String groupName = "new_group";
//        String groupPath = "new_group_path";
//        createGroup(systemCalculatorInfo, groupName, groupPath);[

//        String groupId = "123";  // 실제 그룹 ID
//        String userId = "456";   // 실제 사용자 ID
//        String accessLevel = "30";  // Developer 권한 수준 (30이 Developer 권한)

//        addUserToGroup(systemCalculatorInfo, groupId, userId, accessLevel);

        // 그룹에서 사용자 삭제
//        removeUserFromGroup(systemCalculatorInfo, groupId, userId);

        // 프로젝트 생성
//        String newProjectName = "new_project";
//        createProject(systemCalculatorInfo, newProjectName, groupId);

        // 생성된 프로젝트 목록 조회
//        getProjects(systemCalculatorInfo);

        // 파이프라인 생성
//        String projectId = "7";  // 실제 프로젝트 ID 사용
//        createPipeline(systemCalculatorInfo, projectId);

        // 파이프라인 목록 조회
//        getPipelines(systemCalculatorInfo);

        // 사용자 권한을 프로젝트에 추가
//        String newUserId = "new_user_id";  // 실제 사용자 ID 사용
//        String newAccessLevel = "30";  // 예: Developer 권한 수준
//        addUserToProject(systemCalculatorInfo, projectId, newUserId, newAccessLevel);

        // 특정 파이프라인 조회
//        String pipelineId = "123";  // 실제 파이프라인 ID 사용
//        getPipelineById(systemCalculatorInfo, projectId, pipelineId);

        // 파이프라인 변경 (재실행 예시)
//        updatePipeline(systemCalculatorInfo, projectId, pipelineId);

        // 특정 프로젝트 삭제
//        deleteProject(systemCalculatorInfo, projectId);

        // 사용자 삭제
//        deleteUser(systemCalculatorInfo, userId);

        // 프로젝트에서 사용자 권한 삭제
//        removeUserFromProject(systemCalculatorInfo, projectId, newUserId);

        // 프로젝트 파이프라인 삭제 메서드
//        deletePipelineFromProject(systemCalculatorInfo, projectId, pipelineId);

        // 브랜치 목록 조회
//        getBranches(systemCalculatorInfo, projectId);

        // 브랜치 생성
//        String branchName = "new-feature-branch";  // 생성할 브랜치 이름
//        String ref = "main";  // 브랜치를 생성할 기준이 되는 브랜치 (main 또는 master)
//        createBranch(systemCalculatorInfo, projectId, branchName, ref);
    }

    public static void getCicdPipelineJob() {
        SystemCalculatorInfo systemCalculatorInfo = new SystemCalculatorInfo();
        systemCalculatorInfo.setGitlabtoken("glpat-27swFiPQNX7AuAdyY4Yk");
        systemCalculatorInfo.setGitlabhost("https://100.1.223.231");
        systemCalculatorInfo.setGitlabusername("root");
        systemCalculatorInfo.setGitlabpassword("kepco123$");

        // 사용자 추가
        String newUsername = "root";
        String newUserEmail = "user5email@test.com";
        String newUserPassword = "kepco123$";
//        createUser(systemCalculatorInfo, newUsername, newUserEmail, newUserPassword);

//        String projectId = "124";
        String projectId = "135";
        String pipelineId = "448";
        GitlabObject obj;
		try {
			obj = getJobs(systemCalculatorInfo, projectId, pipelineId);
			log.info("job 정보 : {}", obj);
			log.info("job 정보 : {}", obj.getJsonArray());
			// stage, copy, prod
			for(JsonElement jsonElement : obj.getJsonArray()) {
				log.info("jsonObject : {}", jsonElement.getAsJsonObject().get("id")); // job id
				log.info("jsonObject : {}", jsonElement.getAsJsonObject().get("name")); // job name
				log.info("jsonObject : {}", jsonElement.getAsJsonObject().get("ref")); // tag name
				log.info("jsonObject : {}", jsonElement.getAsJsonObject().getAsJsonObject("pipeline"));
				log.info("jsonObject : {}", jsonElement.getAsJsonObject().getAsJsonObject("pipeline").get("project_id")); // project id
				log.info("jsonObject : {}", jsonElement.getAsJsonObject().getAsJsonObject("pipeline").get("id")); // pipeline id

				String resProjectId = jsonElement.getAsJsonObject().getAsJsonObject("pipeline").get("project_id").toString();
				String resPipelineId = jsonElement.getAsJsonObject().getAsJsonObject("pipeline").get("id").toString();
				String jobName = jsonElement.getAsJsonObject().get("name").toString().replaceAll("\"", "");

				log.info("job Name {}", jobName.getClass());
				log.info("job Name {}", jobName);
				log.info("job Name {}", CodeUtil.CICD_PIPELINE_JOB_STATUS_STAGE.getClass());
				log.info("job Name {}", CodeUtil.CICD_PIPELINE_JOB_STATUS_STAGE);

				if(resProjectId.equals(projectId) && resPipelineId.equals(pipelineId)) {

					if(jobName.equals(CodeUtil.CICD_PIPELINE_JOB_STATUS_STAGE)
							|| jobName.equals(CodeUtil.CICD_PIPELINE_JOB_STATUS_COPY)
							|| jobName.equals(CodeUtil.CICD_PIPELINE_JOB_STATUS_PORD))
					{
						log.info("jobName {}", jobName);
						CustomReqProductVO reqVO = new CustomReqProductVO();
						reqVO.setPipelineId(resPipelineId);
						reqVO.setJobId(jsonElement.getAsJsonObject().get("id").toString());
						reqVO.setStatus(jsonElement.getAsJsonObject().get("status").toString().replaceAll("\"", ""));
						reqVO.setJobName(jobName);
						reqVO.setRef(jsonElement.getAsJsonObject().get("ref").toString().replaceAll("\"", ""));
					}
				}
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}


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
        return GitlabUtils.request(client, request, GitlabType.JOB_LIST);
    }

    private static void getUsers(SystemCalculatorInfo systemCalculatorInfo, String searchEmail, String searchName) throws Exception {
        GitlabObject users = GitlabUtils.getUsers(systemCalculatorInfo, searchEmail, searchName);
        for (GitlabObject user : users.getProjects()) {
            System.out.println("User ID: " + user.getValue("id"));
            System.out.println("Name: " + user.getValue("name"));
            System.out.println("State: " + user.getValue("state"));
        }
    }

//    private static void createUser(SystemCalculatorInfo systemCalculatorInfo, String username, String email, String password) throws Exception {
//        GitlabObject userInfo = GitlabUtils.createUser(systemCalculatorInfo, username, email, password);
//        System.out.println("Created user: " + userInfo.getValue("id"));
//    }

    private static void addUserToGroup(SystemCalculatorInfo systemCalculatorInfo, String groupId, String userId, String accessLevel) throws Exception {
        GitlabObject groupInfo = GitlabUtils.addUserToGroup(systemCalculatorInfo, groupId, userId, accessLevel);
        System.out.println("Added user: " + groupInfo.getValue("id") + " to group: " + groupId);
    }

    private static void removeUserFromGroup(SystemCalculatorInfo systemCalculatorInfo, String groupId, String userId) throws Exception {
        GitlabObject groupInfo = GitlabUtils.removeUserFromGroup(systemCalculatorInfo, groupId, userId);
        System.out.println("Removed user: " + userId + " from group: " + groupId);
    }

    private static void createGroup(SystemCalculatorInfo systemCalculatorInfo, String groupName, String groupPath) throws Exception {
        GitlabObject groupInfo = GitlabUtils.createGroup(systemCalculatorInfo, groupName, groupPath);
        System.out.println("Created group: " + groupInfo.getValue("id"));
    }

    private static void deleteUser(SystemCalculatorInfo systemCalculatorInfo, String userId) throws Exception {
        GitlabUtils.deleteUser(systemCalculatorInfo, userId);
        System.out.println("Deleted User ID: " + userId);
    }

    private static void getProjects(SystemCalculatorInfo systemCalculatorInfo) throws Exception {
        GitlabObject projects = GitlabUtils.getProjects(systemCalculatorInfo);
        for (GitlabObject project : projects.getProjects()) {
            System.out.println("Project ID: " + project.getValue("id"));
            System.out.println("Project Name: " + project.getValue("name"));
            System.out.println("Description: " + project.getValue("description"));
            System.out.println("Default Branch: " + project.getValue("default_branch"));
            System.out.println("Visibility: " + project.getValue("visibility"));
            System.out.println("Created at: " + project.getValue("created_at"));
            System.out.println("Last Activity: " + project.getValue("last_activity_at"));
            System.out.println("Forks Count: " + project.getValue("forks_count"));
            System.out.println("Star Count: " + project.getValue("star_count"));
            System.out.println("Open Issues Count: " + project.getValue("open_issues_count"));
            System.out.println("Web URL: " + project.getValue("web_url"));
            System.out.println("SSH URL to Repo: " + project.getValue("ssh_url_to_repo"));
            System.out.println("HTTP URL to Repo: " + project.getValue("http_url_to_repo"));
            System.out.println("------------------------------");
        }
    }

    private static void createProject(SystemCalculatorInfo systemCalculatorInfo, String projectName, String groupId) throws Exception {
        GitlabObject project = GitlabUtils.createProject(systemCalculatorInfo, projectName, groupId);
        System.out.println("Created project: " + projectName);
        System.out.println("Project ID: " + project.getValue("id"));
    }

    private static void getPipelines(SystemCalculatorInfo systemCalculatorInfo) throws Exception {
        GitlabObject pipelines = GitlabUtils.getPipelines(systemCalculatorInfo);
        for (GitlabObject pipeline : pipelines.getProjects()) {
            System.out.println("Pipeline ID: " + pipeline.getValue("id"));
            System.out.println("Status: " + pipeline.getValue("status"));
            System.out.println("Ref: " + pipeline.getValue("ref"));
            System.out.println("SHA: " + pipeline.getValue("sha"));
            System.out.println("Web URL: " + pipeline.getValue("web_url"));
            System.out.println("Duration: " + pipeline.getValue("duration"));
            System.out.println("Created at: " + pipeline.getValue("created_at"));
            System.out.println("Updated at: " + pipeline.getValue("updated_at"));
            System.out.println("------------------------------");
        }
    }

    private static void createPipeline(SystemCalculatorInfo systemCalculatorInfo, String projectId) throws Exception {
        GitlabUtils.createPipeline(systemCalculatorInfo, projectId);
        System.out.println("Created pipeline for project ID: " + projectId);
    }

    private static void updatePipeline(SystemCalculatorInfo systemCalculatorInfo, String projectId, String pipelineId) throws Exception {
        GitlabUtils.updatePipeline(systemCalculatorInfo, projectId, pipelineId);
        System.out.println("Updated pipeline for project ID: " + projectId);
    }

    private static void getPipelineById(SystemCalculatorInfo systemCalculatorInfo, String projectId, String pipelineId) throws Exception {
        GitlabObject pipeline = GitlabUtils.getPipelineById(systemCalculatorInfo, projectId, pipelineId);
        System.out.println("Pipeline ID: " + pipeline.getValue("id"));
        System.out.println("Status: " + pipeline.getValue("status"));
        System.out.println("Web URL: " + pipeline.getValue("web_url"));
    }

    private static void deleteProject(SystemCalculatorInfo systemCalculatorInfo, String projectId) throws Exception {
        GitlabUtils.deleteProject(systemCalculatorInfo, projectId);
        System.out.println("Deleted Project ID: " + projectId);
    }

    private static void addUserToProject(SystemCalculatorInfo systemCalculatorInfo, String projectId, String userId, String accessLevel) throws Exception {
        GitlabUtils.addUserToProject(systemCalculatorInfo, projectId, userId, accessLevel);
        System.out.println("Added user ID: " + userId + " to project ID: " + projectId);
    }

    private static void removeUserFromProject(SystemCalculatorInfo systemCalculatorInfo, String projectId, String userId) throws Exception {
        GitlabUtils.removeUserFromProject(systemCalculatorInfo, projectId, userId);
        System.out.println("Removed user ID: " + userId + " from project ID: " + projectId);
    }

    private static void deletePipelineFromProject(SystemCalculatorInfo systemCalculatorInfo, String projectId, String userId) throws Exception {
        GitlabUtils.deletePipelineFromProject(systemCalculatorInfo, projectId, userId);
        System.out.println("Removed user ID: " + userId + " from project ID: " + projectId);
    }

    private static void getBranches(SystemCalculatorInfo systemCalculatorInfo, String projectId) throws Exception {
        GitlabObject branches = GitlabUtils.getBranches(systemCalculatorInfo, projectId);
        for (GitlabObject branch : branches.getProjects()) {
            System.out.println("Branch Name: " + branch.getValue("name"));
            System.out.println("------------------------------");
        }
    }

    private static void createBranch(SystemCalculatorInfo systemCalculatorInfo, String projectId, String branchName, String ref) throws Exception {
        GitlabObject newBranch = GitlabUtils.createBranch(systemCalculatorInfo, projectId, branchName, ref);
        System.out.println("Created branch: " + newBranch.getValue("name"));
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

    public static void createInvironment(SystemCalculatorInfo systemCalculatorInfo, String projectId) {
        // environment 생성(prod)
//      gitObj = createProdEnvironment(systemCalculatorInfo, projectId);
//		log.info("environment 생성 정보 : {}", gitObj);
//		log.info("environment 생성 정보 : {}", gitObj.getJsonArray());
//		log.info("environment 생성 정보 : {}", gitObj.getValue("state").toString());
//		log.info("parse data : {}", gitObj.getJsonArray().getAsJsonObject().toString().replaceAll("\"", "")) ;

      // environment 확인
//		gitObj = null;
//		gitObj = environmentCheck(systemCalculatorInfo, projectId);
//		log.info("environment 확인 정보 : {}", gitObj);
//		log.info("environment 확인 정보 : {}", gitObj.getJsonArray());

//		String environmentCheckStatus = "";
//		for(JsonElement jsonElement : gitObj.getJsonArray()) {
//			log.info("state : {}", jsonElement.getAsJsonObject().get("state"));
//			environmentCheckStatus = jsonElement.getAsJsonObject().get("state").toString().replaceAll("\"", "");
//			System.out.println(environmentCheckStatus);
//		}

      // Protected environment 설정
//		gitObj = null;
//		gitObj = protectedEnvironmentConfig(systemCalculatorInfo, projectId);
//		log.info("Protected environment 설정 정보 : {}", gitObj);
//		log.info("Protected environment 설정 정보 : {}", gitObj.getJsonArray());

      // Protected environment 조회
//		gitObj = null;
//		gitObj = protectedEnvironmentCheck(systemCalculatorInfo, projectId);
//		log.info("Protected environment 조회 정보 : {}", gitObj);
//		log.info("Protected environment 조회 정보 : {}", gitObj.getJsonArray());
    }

}
