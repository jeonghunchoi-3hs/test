package com.ivucenter.cloud.api.nas;

public enum NasType {

    SVM_UUID,              // SVM UUID 가져오기
    EXPORT_POLICY,         // Export Policy 생성
    EXPORT_POLICY_ID,      // Export Policy ID 가져오기
    EXPORT_POLICY_RULE,    // Export Policy Rule 설정
    EXPORT_POLICY_UPDATE,    // Export Policy Rule update 설정
    EXPORT_POLICY_DELETE,    // Export Policy Rule delete 설정
    VOLUME_CREATION,       // 볼륨 생성
    VOLUME_JOB_STATUS,     // 볼륨 생성 상태 체크
    VOLUME_UUID,           // 생성된 볼륨 UUID 가져오기
    MOUNT_PATH,            // 볼륨 마운트 경로 설정
    RESULT,                // 기본 결과 타입
    PROPERTIES,             // 속성 타입
    VOLUME_RESIZE,
    VOLUME_DELETION,
    VOLUME_LIST,
    VOLUME_STATUS
}
