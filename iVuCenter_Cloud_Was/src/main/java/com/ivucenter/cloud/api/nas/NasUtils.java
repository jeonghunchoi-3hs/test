package com.ivucenter.cloud.api.nas;

import java.io.IOException;
import java.net.URL;
import java.util.List;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.ivucenter.cloud.api.common.utils.SystemCalculatorInfo;
import com.ivucenter.cloud.api.nas.connector.NasClientManager;

import lombok.extern.slf4j.Slf4j;
import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

@Slf4j
public class NasUtils {

    public static NasObject request(OkHttpClient client, Request request, NasType type) throws IOException, NasException {
        NasObject nasObject = null;
        log.debug("Request URL: " + request.url().toString());
        try (Response response = client.newCall(request).execute()) {
            if (response.isSuccessful() && response.body() != null) {
                String jsonText = response.body().string();
                nasObject = new NasObject(type, jsonText);
                log.debug("Response JSON: " + jsonText);
            } else {
                throw new NasException(response.code(), response.message());
            }
        }
        return nasObject;
    }

    public static NasObject getSvmUUID(SystemCalculatorInfo systemCalculatorInfo) throws Exception { // 고정값으로 사용 안함
        String path = "/api/svm/svms";
        URL url = new URL(systemCalculatorInfo.getNashost() + path);

        Request request = new Request.Builder()
            .url(url)
            .header("Authorization", "Basic " + systemCalculatorInfo.getNastoken())
            .addHeader("Accept", "application/json")
            .get()
            .build();

        OkHttpClient client = NasClientManager.getNasClient(systemCalculatorInfo);
        return request(client, request, NasType.SVM_UUID);
    }

    public static NasObject createExportPolicy(SystemCalculatorInfo systemCalculatorInfo, String policyName, String cloudZone) throws Exception {
    	String nasHost ="";
    	String svmUuid ="";
    	String nasToken = "";

    	if ("OA".equals(cloudZone)) {
    		nasHost = systemCalculatorInfo.getNashost();
    		svmUuid = systemCalculatorInfo.getSvmUuid();
    		nasToken = systemCalculatorInfo.getNastoken();
    	} else if ("DMZ".equals(cloudZone)) {
    		nasHost = systemCalculatorInfo.getDmznashost();
    		svmUuid = systemCalculatorInfo.getDmzsvmUuid();
    		nasToken = systemCalculatorInfo.getDmznastoken();
    	}

        String path = "/api/protocols/nfs/export-policies";
        URL url = new URL(nasHost + path);

        JsonObject bodyJson = new JsonObject();
        bodyJson.addProperty("name", policyName);
        JsonObject svmJson = new JsonObject();
        svmJson.addProperty("uuid", svmUuid);
        bodyJson.add("svm", svmJson);

        RequestBody body = RequestBody.create(bodyJson.toString(), MediaType.parse("application/json"));
        Request request = new Request.Builder()
            .url(url)
            .header("Authorization", "Basic " + nasToken)
            .post(body)
            .build();

        OkHttpClient client = NasClientManager.getNasClient(systemCalculatorInfo);
        return request(client, request, NasType.EXPORT_POLICY);
    }

    public static NasObject getExportPolicyID(SystemCalculatorInfo systemCalculatorInfo, String policyName, String cloudZone) throws Exception { // test완료
    	String nasHost ="";
    	String nasToken = "";

    	if ("OA".equals(cloudZone)) {
    		nasHost = systemCalculatorInfo.getNashost();
    		nasToken = systemCalculatorInfo.getNastoken();
    	} else if ("DMZ".equals(cloudZone)) {
    		nasHost = systemCalculatorInfo.getDmznashost();
    		nasToken = systemCalculatorInfo.getDmznastoken();
    	}

        String path = "/api/protocols/nfs/export-policies?name=" + policyName;
        URL url = new URL(nasHost + path);

        Request request = new Request.Builder()
            .url(url)
            .header("Authorization", "Basic " + nasToken)
            .addHeader("Accept", "application/json")
            .get()
            .build();

        OkHttpClient client = NasClientManager.getNasClient(systemCalculatorInfo);
        return request(client, request, NasType.EXPORT_POLICY_ID);
    }

    public static NasObject setExportPolicyRule(SystemCalculatorInfo systemCalculatorInfo, String exportPolicyID, String clientIPList, String cloudZone) throws Exception {
    	String nasHost ="";
    	String nasToken = "";

    	if ("OA".equals(cloudZone)) {
    		nasHost = systemCalculatorInfo.getNashost();
    		nasToken = systemCalculatorInfo.getNastoken();
    	} else if ("DMZ".equals(cloudZone)) {
    		nasHost = systemCalculatorInfo.getDmznashost();
    		nasToken = systemCalculatorInfo.getDmznastoken();
    	}

        String path = "/api/protocols/nfs/export-policies/" + exportPolicyID + "/rules";
        URL url = new URL(nasHost + path);

        JsonObject bodyJson = new JsonObject();

        JsonArray clientsArray = new JsonArray();
        for (String ip : clientIPList.split(",")) {
            JsonObject clientJson = new JsonObject();
            clientJson.addProperty("match", ip);
            clientsArray.add(clientJson);
        }
        bodyJson.add("clients", clientsArray);

        JsonArray roRule = new JsonArray();
        roRule.add("sys");
        bodyJson.add("ro_rule", roRule);

        JsonArray rwRule = new JsonArray();
        rwRule.add("sys");
        bodyJson.add("rw_rule", rwRule);

        JsonArray protocols = new JsonArray();
        protocols.add("nfs3");
        protocols.add("nfs4");
        bodyJson.add("protocols", protocols);

        JsonArray superuser = new JsonArray();
        superuser.add("sys");
        bodyJson.add("superuser", superuser);

        RequestBody body = RequestBody.create(bodyJson.toString(), MediaType.parse("application/json"));
        Request request = new Request.Builder()
            .url(url)
            .header("Authorization", "Basic " + nasToken)
            .post(body)
            .build();

        OkHttpClient client = NasClientManager.getNasClient(systemCalculatorInfo);
        return request(client, request, NasType.EXPORT_POLICY_RULE);
    }

    public static NasObject deleteExportPolicy(SystemCalculatorInfo systemCalculatorInfo, String exportPolicyId, String cloudZone) throws Exception {
    	String nasHost ="";
    	String nasToken = "";

    	if ("OA".equals(cloudZone)) {
    		nasHost = systemCalculatorInfo.getNashost();
    		nasToken = systemCalculatorInfo.getNastoken();
    	} else if ("DMZ".equals(cloudZone)) {
    		nasHost = systemCalculatorInfo.getDmznashost();
    		nasToken = systemCalculatorInfo.getDmznastoken();
    	}

    	String path = "/api/protocols/nfs/export-policies/" +exportPolicyId;
    	URL url = new URL(nasHost + path);

        Request request = new Request.Builder()
                .url(url)
                .header("Authorization", "Basic " + nasToken)
                .delete()
                .build();

        OkHttpClient client = NasClientManager.getNasClient(systemCalculatorInfo);
        return request(client, request, NasType.EXPORT_POLICY_DELETE);
    }

    public static NasObject updateExportPolicy(SystemCalculatorInfo systemCalculatorInfo, String exportPolicyId, String ruleId, String newClientIp, String cloudZone) throws Exception {
    	String nasHost ="";
    	String nasToken = "";

    	if ("OA".equals(cloudZone)) {
    		nasHost = systemCalculatorInfo.getNashost();
    		nasToken = systemCalculatorInfo.getNastoken();
    	} else if ("DMZ".equals(cloudZone)) {
    		nasHost = systemCalculatorInfo.getDmznashost();
    		nasToken = systemCalculatorInfo.getDmznastoken();
    	}

    	String path = "/api/protocols/nfs/export-policies/" + exportPolicyId + "/rules/" + ruleId;
    	URL url = new URL(nasHost + path);

        JsonObject bodyJson = new JsonObject();
        JsonArray clientsArray = new JsonArray();

        JsonObject clientObject = new JsonObject();
        clientObject.addProperty("match", newClientIp);
        clientsArray.add(clientObject);

        JsonArray roRule = new JsonArray();
        roRule.add("sys");
        bodyJson.add("ro_rule", roRule);

        JsonArray rwRule = new JsonArray();
        rwRule.add("sys");
        bodyJson.add("rw_rule", rwRule);

        JsonArray protocols = new JsonArray();
        protocols.add("nfs3");
        protocols.add("nfs4");
        bodyJson.add("protocols", protocols);

        JsonArray superuser = new JsonArray();
        superuser.add("sys");
        bodyJson.add("superuser", superuser);

        bodyJson.add("clients", clientsArray);

        RequestBody body = RequestBody.create(bodyJson.toString(), MediaType.parse("application/json"));


        Request request = new Request.Builder()
                .url(url)
                .header("Authorization", "Basic " + nasToken)
                .patch(body)
                .build();

        OkHttpClient client = NasClientManager.getNasClient(systemCalculatorInfo);
        return request(client, request, NasType.EXPORT_POLICY_UPDATE);
    }

    public static NasObject createVolume(SystemCalculatorInfo systemCalculatorInfo, String volumeName, int volumeSize, String exportPolicyName, String cloudZone) throws Exception { // test완료
    	String nasHost ="";
    	String svmUuid ="";
    	String nasToken = "";

    	if ("OA".equals(cloudZone)) {
    		nasHost = systemCalculatorInfo.getNashost();
    		svmUuid = systemCalculatorInfo.getSvmUuid();
    		nasToken = systemCalculatorInfo.getNastoken();
    	} else if ("DMZ".equals(cloudZone)) {
    		nasHost = systemCalculatorInfo.getDmznashost();
    		svmUuid = systemCalculatorInfo.getDmzsvmUuid();
    		nasToken = systemCalculatorInfo.getDmznastoken();
    	}

        String path = "/api/storage/volumes";
        URL url = new URL(nasHost + path);

        JsonObject bodyJson = new JsonObject();
        bodyJson.addProperty("name", volumeName);
        bodyJson.addProperty("size", volumeSize + "GB");

        JsonObject svmJson = new JsonObject();
        svmJson.addProperty("uuid", svmUuid);
        bodyJson.add("svm", svmJson);

        JsonObject aggregateJson = new JsonObject();
        aggregateJson.addProperty("name", systemCalculatorInfo.getAggregatesName());

        JsonArray aggregateArray = new JsonArray();
        aggregateArray.add(aggregateJson);
        bodyJson.add("aggregates", aggregateArray);

        JsonObject nasJson = new JsonObject();
        nasJson.addProperty("security_style", "unix");
        JsonObject exportPolicyJson = new JsonObject();
        exportPolicyJson.addProperty("name", exportPolicyName);
        nasJson.add("export_policy", exportPolicyJson);
        bodyJson.add("nas", nasJson);

        RequestBody body = RequestBody.create(bodyJson.toString(), MediaType.parse("application/json"));
        Request request = new Request.Builder()
            .url(url)
            .header("Authorization", "Basic " + nasToken)
            .post(body)
            .build();
        OkHttpClient client = NasClientManager.getNasClient(systemCalculatorInfo);
        return request(client, request, NasType.VOLUME_CREATION);
    }

    public static NasObject checkVolumeCreationJobStatus(SystemCalculatorInfo systemCalculatorInfo, String jobUUID, String cloudZone) throws Exception {
    	String nasHost ="";
    	String nasToken = "";

    	if ("OA".equals(cloudZone)) {
    		nasHost = systemCalculatorInfo.getNashost();
    		nasToken = systemCalculatorInfo.getNastoken();
    	} else if ("DMZ".equals(cloudZone)) {
    		nasHost = systemCalculatorInfo.getDmznashost();
    		nasToken = systemCalculatorInfo.getDmznastoken();
    	}

        String path = "/api/cluster/jobs/" + jobUUID;
        URL url = new URL(nasHost + path);

        Request request = new Request.Builder()
            .url(url)
            .header("Authorization", "Basic " + nasToken)
            .get()
            .build();

        OkHttpClient client = NasClientManager.getNasClient(systemCalculatorInfo);
        return request(client, request, NasType.VOLUME_JOB_STATUS);
    }

    public static NasObject getVolumeUUID(SystemCalculatorInfo systemCalculatorInfo, String volumeName, String cloudZone) throws Exception {
    	String nasHost ="";
    	String nasToken = "";

    	if ("OA".equals(cloudZone)) {
    		nasHost = systemCalculatorInfo.getNashost();
    		nasToken = systemCalculatorInfo.getNastoken();
    	} else if ("DMZ".equals(cloudZone)) {
    		nasHost = systemCalculatorInfo.getDmznashost();
    		nasToken = systemCalculatorInfo.getDmznastoken();
    	}

        String path = "/api/storage/volumes?name=" + volumeName;
        URL url = new URL(nasHost + path);

        Request request = new Request.Builder()
            .url(url)
            .header("Authorization", "Basic " + nasToken)
            .get()
            .build();

        OkHttpClient client = NasClientManager.getNasClient(systemCalculatorInfo);
        return request(client, request, NasType.VOLUME_UUID);
    }

    public static NasObject resizeVolume(SystemCalculatorInfo systemCalculatorInfo, String volumeUUID, int newSize, String cloudZone) throws Exception {
    	String nasHost ="";
    	String nasToken = "";

    	if ("OA".equals(cloudZone)) {
    		nasHost = systemCalculatorInfo.getNashost();
    		nasToken = systemCalculatorInfo.getNastoken();
    	} else if ("DMZ".equals(cloudZone)) {
    		nasHost = systemCalculatorInfo.getDmznashost();
    		nasToken = systemCalculatorInfo.getDmznastoken();
    	}

        String path = "/api/storage/volumes/" + volumeUUID;
        URL url = new URL(nasHost + path);

        JsonObject bodyJson = new JsonObject();
        bodyJson.addProperty("size", newSize + "GB");

        RequestBody body = RequestBody.create(bodyJson.toString(), MediaType.parse("application/json"));
        Request request = new Request.Builder()
            .url(url)
            .header("Authorization", "Basic " + nasToken)
            .patch(body)
            .build();

        OkHttpClient client = NasClientManager.getNasClient(systemCalculatorInfo);
        return request(client, request, NasType.VOLUME_RESIZE);
    }

    public static NasObject deleteVolume(SystemCalculatorInfo systemCalculatorInfo, String volumeUUID, String cloudZone) throws Exception {
    	String nasHost ="";
    	String nasToken = "";

    	if ("OA".equals(cloudZone)) {
    		nasHost = systemCalculatorInfo.getNashost();
    		nasToken = systemCalculatorInfo.getNastoken();
    	} else if ("DMZ".equals(cloudZone)) {
    		nasHost = systemCalculatorInfo.getDmznashost();
    		nasToken = systemCalculatorInfo.getDmznastoken();
    	}

        String path = "/api/storage/volumes/" + volumeUUID;
        URL url = new URL(nasHost + path);

        Request request = new Request.Builder()
            .url(url)
            .header("Authorization", "Basic " + nasToken)
            .delete()
            .build();

        OkHttpClient client = NasClientManager.getNasClient(systemCalculatorInfo);
        return request(client, request, NasType.VOLUME_DELETION);
    }


    public static NasObject listVolumes(SystemCalculatorInfo systemCalculatorInfo, String cloudZone) throws Exception {
    	String nasHost ="";
    	String nasToken = "";

    	if ("OA".equals(cloudZone)) {
    		nasHost = systemCalculatorInfo.getNashost();
    		nasToken = systemCalculatorInfo.getNastoken();
    	} else if ("DMZ".equals(cloudZone)) {
    		nasHost = systemCalculatorInfo.getDmznashost();
    		nasToken = systemCalculatorInfo.getDmznastoken();
    	}

        String path = "/api/storage/volumes";
        URL url = new URL(nasHost + path);

        Request request = new Request.Builder()
            .url(url)
            .header("Authorization", "Basic " + nasToken)
            .addHeader("Accept", "application/json")
            .get()
            .build();

        OkHttpClient client = NasClientManager.getNasClient(systemCalculatorInfo);
        return request(client, request, NasType.VOLUME_LIST);
    }


    public static NasObject getVolumeStatus(SystemCalculatorInfo systemCalculatorInfo, String volumeUUID, String cloudZone) throws Exception {
    	String nasHost ="";
    	String nasToken = "";

    	if ("OA".equals(cloudZone)) {
    		nasHost = systemCalculatorInfo.getNashost();
    		nasToken = systemCalculatorInfo.getNastoken();
    	} else if ("DMZ".equals(cloudZone)) {
    		nasHost = systemCalculatorInfo.getDmznashost();
    		nasToken = systemCalculatorInfo.getDmznastoken();
    	}

        String path = "/api/storage/volumes/" + volumeUUID + "/status";
        URL url = new URL(nasHost + path);

        Request request = new Request.Builder()
            .url(url)
            .header("Authorization", "Basic " + nasToken)
            .get()
            .build();

        OkHttpClient client = NasClientManager.getNasClient(systemCalculatorInfo);
        return request(client, request, NasType.VOLUME_STATUS);
    }

    public static NasObject applyMountPath(SystemCalculatorInfo systemCalculatorInfo, String volumeUUID, String mountPath, String cloudZone) throws Exception {
    	String nasHost ="";
    	String nasToken = "";

    	if ("OA".equals(cloudZone)) {
    		nasHost = systemCalculatorInfo.getNashost();
    		nasToken = systemCalculatorInfo.getNastoken();
    	} else if ("DMZ".equals(cloudZone)) {
    		nasHost = systemCalculatorInfo.getDmznashost();
    		nasToken = systemCalculatorInfo.getDmznastoken();
    	}

        String path = "/api/storage/volumes/" + volumeUUID;
        URL url = new URL(nasHost + path);

        JsonObject bodyJson = new JsonObject();
        JsonObject nasJson = new JsonObject();
        nasJson.addProperty("path", mountPath);
        bodyJson.add("nas", nasJson);

        RequestBody body = RequestBody.create(bodyJson.toString(), MediaType.parse("application/json"));
        Request request = new Request.Builder()
            .url(url)
            .header("Authorization", "Basic " + nasToken)
            .patch(body)
            .build();

        OkHttpClient client = NasClientManager.getNasClient(systemCalculatorInfo);
        return request(client, request, NasType.MOUNT_PATH);
    }

    public static NasObject checkMountPath(SystemCalculatorInfo systemCalculatorInfo, String volumeUUID, String cloudZone) throws Exception {
    	String nasHost ="";
    	String nasToken = "";

    	if ("OA".equals(cloudZone)) {
    		nasHost = systemCalculatorInfo.getNashost();
    		nasToken = systemCalculatorInfo.getNastoken();
    	} else if ("DMZ".equals(cloudZone)) {
    		nasHost = systemCalculatorInfo.getDmznashost();
    		nasToken = systemCalculatorInfo.getDmznastoken();
    	}

        String path = "/api/storage/volumes/" + volumeUUID + "?fields=nas.path,status";
        URL url = new URL(nasHost + path);

        Request request = new Request.Builder()
            .url(url)
            .header("Authorization", "Basic " + nasToken)
            .get()
            .build();

        OkHttpClient client = NasClientManager.getNasClient(systemCalculatorInfo);
        return request(client, request, NasType.VOLUME_STATUS);
    }

    public static void main(String[] args) {
		SystemCalculatorInfo systemCalculatorInfo = new SystemCalculatorInfo();

		try {
			NasObject svm = NasUtils.getSvmUUID(systemCalculatorInfo);

			System.out.println("uuid :" + svm);
		} catch (Exception e) {
			e.printStackTrace();
		}



	}

}
