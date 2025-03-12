package com.ivucenter.cloud.api.nas;

import java.util.List;

import com.ivucenter.cloud.api.common.utils.SystemCalculatorInfo;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class NasTest {

    public static void main(String[] args) {
        try {
            SystemCalculatorInfo systemCalculatorInfo = new SystemCalculatorInfo();

            systemCalculatorInfo.setNashost("http://100.1.221.68:8000/nasApi");
            systemCalculatorInfo.setNasusername("admin");
            systemCalculatorInfo.setNaspassword("qordjq1029!");
            systemCalculatorInfo.setNastoken("YWRtaW46cW9yZGpxMTAyOSE=");
            systemCalculatorInfo.setSvmUuid("8b2541d8-957c-11ec-ac48-d039ea4cd102");
            systemCalculatorInfo.setAggregatesName("aggr_n2");

            // 1. SVM UUID 가져오기
//            NasObject svmObject = NasUtils.getSvmUUID(systemCalculatorInfo);
//            System.out.println(svmObject);

            // 2. EXPORT-POLICY 생성
//            String policyName = "gitlab_data_export_policy";
//            NasObject exportPolicyObject = NasUtils.createExportPolicy(systemCalculatorInfo, svmUUID, policyName);
//            log.debug("Export Policy Created: " + exportPolicyObject.toString());
//
//            // 3. 생성한 EXPORT-POLICY ID 가져오기
//            NasObject exportPolicyIDObject = NasUtils.getExportPolicyID(systemCalculatorInfo, "nastest1107_export_policy");
//            List<NasObject> list = exportPolicyIDObject.getArray("records", NasType.RESULT);
//            for (NasObject record : list) {
//            	String id = record.getValue("id").toString();
//            	String name = record.getValue("name").toString();
//            	System.out.println(id);
//            	System.out.println(name);
//            }
//            System.out.println(exportPolicyIDObject);
//            String exportPolicyID = exportPolicyIDObject.getValue("id").toString();
//            String exportPolicyName = exportPolicyIDObject.getValue("name").toString();
//            System.out.println(exportPolicyName);
//            log.debug("Export Policy ID: " + exportPolicyID);
//
//            // 4. EXPORT-POLICY RULE 설정
//            String clientIP = "90.1.1.225";
//            NasObject exportPolicyRuleObject = NasUtils.setExportPolicyRule(systemCalculatorInfo, exportPolicyID, clientIP);
//            log.debug("Export Policy Rule Set: " + exportPolicyRuleObject.toString());
//
//            // 5. 볼륨 생성
//            String volumeName = "nastest1107";
//            String policyName = volumeName + "_export_policy";
//            int volumeSize = 100; // 사이즈 설정
//            NasObject volumeObject = NasUtils.createVolume(systemCalculatorInfo, volumeName, volumeSize, policyName);
//            log.debug("Volume Created: " + volumeObject.toString());
//            System.out.println(volumeObject);
//            System.out.println(volumeObject.toString());

//
//            // 6. 볼륨 생성 상태 체크 URL
//            String jobUUID = volumeObject.getValue("job").toString(); // 실제 응답에서 받아온 job UUID를 사용
//            NasObject jobStatusObject = NasUtils.checkVolumeCreationJobStatus(systemCalculatorInfo, jobUUID);
//            log.debug("Checked Job Status: " + jobStatusObject.toString());
//
//            // 7. 생성된 볼륨 UUID 가져오기
//            NasObject volumeUUIDObject = NasUtils.getVolumeUUID(systemCalculatorInfo, volumeName);
//            String volumeUUID = volumeUUIDObject.getValue("uuid").toString();
//            log.debug("Volume UUID: " + volumeUUID);
//
//            // 8. 생성한 볼륨 마운트 PATH 적용
//            String mountPath = "/mountPath"; // 중복 체크 필요 (예: 나스명)
//            NasObject mountPathObject = NasUtils.applyMountPath(systemCalculatorInfo, volumeUUID, mountPath);
//
//            // 9. 볼륨 사이즈 변경
//            int newSize = 200; // 새 크기 설정 (GB)
//            NasObject resizedVolumeObject = NasUtils.resizeVolume(systemCalculatorInfo, volumeUUID, newSize);
//            log.debug("Volume Resized: " + resizedVolumeObject.toString());
//
//            // 10. 볼륨 삭제
//            NasObject deletedVolumeObject = NasUtils.deleteVolume(systemCalculatorInfo, volumeUUID);
//            log.debug("Volume Deleted: " + deletedVolumeObject.toString());
//
//            // 11.볼륨 목록 조회
//            NasObject volumesListObject = NasUtils.listVolumes(systemCalculatorInfo);
//            log.debug("Volumes List: " + volumesListObject.toString());
//
//            // 12.볼륨 상태 조회
//            NasObject volumeStatusObject = NasUtils.getVolumeStatus(systemCalculatorInfo, volumeUUID);
//            log.debug("Volume Status: " + volumeStatusObject.toString());
//


        } catch (Exception e) {
            log.error("An error occurred: ", e);
        }
    }
}
