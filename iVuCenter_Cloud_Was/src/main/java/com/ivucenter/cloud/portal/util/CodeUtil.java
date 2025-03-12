package com.ivucenter.cloud.portal.util;

public class CodeUtil {

	public static String KEY_SPEC = "NHIS_nhcloud_potal_20171023";


	/**
	 * cmm_code / parent_code_id
	 */
	public static String[] CMM_CODE_PARENT_CODE_ID = { "*", "NOTICE_TYPE", "FAQ_TYPE", "QNA_TYPE", "DOWNLOAD_TYPE", "APPRV_STATE", "APPRV_FLOW" };
	public static String CMM_CODE_DOWNLOAD = "DOWNLOAD_TYPE";
	public static String CMM_CODE_PROVISIONING_READY = "PROVISIONING_READY";

	/**
	 * login
	 */
	public static String LOGIN_FAIL_MESSAGE = "가입되지 않은 사번입니다.";
	public static String LOGIN_PASSWORD_MESSAGE = "비밀번호를 확인해주세요.";

	public static String LOGIN_FAIL_MESSAGE2 = "사번 또는 비밀번호를 확인해주세요.";

	public static String LOGIN_FAIL_MESSAGE3 = "관리자에게 문의해주세요 (061-5366)";

	public static String LOGIN_AUTHFAIL_MESSAGE = "접근 권한이 없습니다.";

	public static String LOGIN_ABSENCE_MESSAGE = "최근 1년동안 접속하지않아 잠금상태로 변경되었습니다.";
	public static String LOGIN_USER_STATUS_ABSENCE = "USER_ABSENCE";

	public static String LOGIN_WITHDRAWAL_MESSAGE = "탈퇴한 사번입니다.";
	public static String LOGIN_USER_STATUS_WITHDRAWAL = "USER_WITHDRAWAL";

	public static String LOGIN_RETIREMENT_MESSAGE = "퇴사한 사번입니다.";
	public static String LOGIN_USER_STATUS_RETIREMENT = "USER_RETIREMENT";

	public static String LOGIN_PASSWORDFAIL_MESSAGE = "비밀번호를 5회이상 틀려 잠금상태로 변경되었습니다.";

	public static String LOGIN_IPCHECK_MESSAGE = "등록되지 않은 IP입니다.";

	/**
	 * file upload
	 */
	public static String FILE_PATH = "/appfile/portalFile";
//	public static String FILE_URL = "http://10.220.110.26:8080/file/";
	public static String FILE_PROGRAM_NAME1 = "bbs_download";
//	public static String FILE_PROGRAM_NAME2 = "company";
//	public static String FILE_PROGRAM_NAME3 = "projectApproval";
	public static String FILE_PROGRAM_NAME4 = "projectFile";
	public static String FILE_PROGRAM_CATALOG_ITEM = "catalog_item";

	/**
	 * req_user join
	 */
	public static String ID_CHK_SUCCES = "사용 가능한 사번 입니다.";
	public static String ID_CHK_FAIL = "이미 사용중인 아이디 입니다.";

	/**
	 * req project
	 */
	public static String NAME_CHK_SUCCESS = "사용 가능한 이름 입니다.";
	public static String NAME_CHK_FAIL = "이미 사용중인 이름 입니다.";


//	public static String MANAGER_CHK_SUCCESS = "사용 가능한 이름 입니다.";
//	public static String APPROVE1_CHK_SUCCESS = "사용 가능한 이름 입니다.";
//	public static String APPROVE2_CHK_SUCCESS = "사용 가능한 이름 입니다.";
//	public static String MANAGER_CHK_FAIL = "프로젝트 관리자를 입력해주세요";
//	public static String APPROVE1_CHK_FAIL = "1차 승인자를 입력해주세요";
//	public static String APPROVE2_CHK_FAIL = "2차 승인자를 입력해주세요";



	public static String CMM_CODE_APPRV_COMPLETED = "APPRV_COMPLETED"; //승인 완료
	public static String CMM_CODE_APPRV_PROCESSING = "APPRV_PROCESSING"; //승인 처리중
	public static String CMM_CODE_APPRV_WAITING = "APPRV_WAITING"; // 승인 대기
	public static String CMM_CODE_APPRV_REJECT = "APPRV_REJECTED"; //승인 반려
	public static String CMM_CODE_APPRV_UNASSIGNED = "APPRV_UNASSIGNED"; //승인 반려
	public static String CMM_CODE_APPRV_CANCELLED = "APPRV_CANCELLED"; //상신 취소

	public static String CMM_CODE_REQTYPE_CHANGE = "REQTYPE_CHANGE"; //변경
	public static String CMM_CODE_REQTYPE_EXPR = "REQTYPE_EXPR";	//해지
	public static String CMM_CODE_REQTYPE_NEW = "REQTYPE_NEW";		//신규

	public static String CMM_CODE_REQTYPE_DEV = "REQTYPE_DEV";		//개발배포
	public static String CMM_CODE_REQTYPE_PROD = "REQTYPE_PROD";		//운영배포

	public static String CMM_CODE_PRODCATE_VM = "PRODCATE_VM";		//VM
	public static String CMM_CODE_PRODCATE_APP = "PRODCATE_APP";		//APP
	public static String CMM_CODE_PRODCATE_ENV = "PRODCATE_ENV";		//APP
//	public static String CMM_CODE_UPDATE_APP = "ITEMCATE_APP";
	public static String CMM_CODE_PRODCATE_DISK = "PRODCATE_DISK";
	public static String CMM_CODE_PRODCATE_NAS = "PRODCATE_NAS";
	public static String CMM_CODE_PRODCATE_PUBLICIP = "PRODCATE_PUBLICIP";
	public static String CMM_CODE_PRODCATE_SERVICE = "PRODCATE_SERVICE";
//	public static String CMM_CODE_PRODCATE_BACKUP = "PRODCATE_BACKUP";
//	public static String CMM_CODE_PRODCATE_MCA = "PRODCATE_MCA";
//	public static String CMM_CODE_PRODCATE_SCM = "PRODCATE_SCM";
//	public static String CMM_CODE_PRODCATE_SECURITY = "PRODCATE_SECURITY";

	public static String SYNC_ADMIN = "SYNC_ADMIN";
	/**
	 * delete user
	 */
	public static String USER_IS_PM = "PM 은 권한변경 후 탈퇴가 가능합니다.";
	public static String USER_IS_NOT_PM = "탈퇴하시겠습니까?";

	/**
	 * 사용자 아이디찾기,패스워드 찾기
	 */
//	public static String TEMPLATEIDSEARCHSMS = "SMS0050";
//	public static String TEMPLATEIDSEARCHWITH = "WITH0050";
//	public static String TEMPLATEPWSEARCH = "MAL0042";

	public static String MAILIDTITLE = "요청하신 ID 정보입니다.";
	public static String MAILIDCONTENT = "요청하신 아이디는 ID 입니다.";
	public static String MAILPWTITLE = "요청하신 PW 정보입니다.";
	public static String MAILPWCONTENT = "요청하신 임시 패스워드는 PW 입니다.";

	// mail 전송
	public static String SENDERNAME = "K-Cloud";
	public static String SENDERMAIL = "K-Cloud@kepco.co.kr";
	public static String USERRECEIVERFLG = "U";
	public static String CUSTOMERRECEIVERFLG = "C";
	public static String MAIL_SMTP_HOST = "127.0.0.1";

	// sms 전송
	public static String SMSSENDERID = "K-Cloud";
	public static String SMSSENDERNUMBER = "061-345-5366";
	public static String SMS_HOST = "100.1.6.75";
	public static int 	 SMS_PORT = 7904;

	// nhwith sms 전송
	public static String NHWITHSENDERID = "K-Cloud";	//CLOUDADMIN
	public static String NHWITHSENDERNAME = "클라우드관리자";	//클라우드관리자

	// sendKepco 전송
	public static String KEPCO_HOST = "100.1.6.152";
	//public static String KEPCO_HOST = "127.0.0.1";
	public static int KEPCO_PORT = 7781;
//	public static String ORDER_VM_CNT_MSG = "해당 가상서버의 변경은 이미 접수 되어 있습니다.";

	/**
	 * 네트워크 정책관리
	 */
	public static String [][] NETWORKS = {
			{"WORKKIND_OP",		"WORKNET_DMZ",	"1",	"/24"}
			,{"WORKKIND_OP",	"WORKNET_INT",	"2",	"/23"}
			,{"WORKKIND_VERFY",	"WORKNET_DMZ",	"4",	"/24"}
			,{"WORKKIND_VERFY",	"WORKNET_INT",	"5",	"/24"}
			,{"WORKKIND_DEV",	"WORKNET_DMZ",	"7",	"/24"}
			,{"WORKKIND_DEV",	"WORKNET_INT",	"8",	"/23"}
			,{"WORKKIND_MGT",	"WORKNET_INT",	"10",	"/24"}
	};

	/**
	 * 권한관리 코드
	 */
	public static String APPROVAL_MODEL_STEP_WF1000A0 = "WF1000A0";
	public static String APPROVAL_MODEL_STEP_WF1000B0 = "WF1000B0";
	public static String APPROVAL_MODEL_STEP_WF1000C0 = "WF1000C0";
	public static String APPROVAL_MODEL_STEP_WF1000D0 = "WF1000D0";
	public static String APPROVAL_MODEL_STEP_WF1000E0 = "WF1000E0";
	public static String APPROVAL_MODEL_STEP_WF2000A0 = "WF2000A0";
	public static String APPROVAL_MODEL_STEP_WF2000B0 = "WF2000B0";
	public static String APPROVAL_MODEL_STEP_WF2000C0 = "WF2000C0";
	public static String APPROVAL_MODEL_STEP_WF2000D0 = "WF2000D0";
	public static String APPROVAL_MODEL_STEP_WF2000E0 = "WF2000E0";
	public static String APPROVAL_MODEL_STEP_WF3000A0 = "WF3000A0";
	public static String APPROVAL_MODEL_STEP_WF3000B0 = "WF3000B0";
	public static String APPROVAL_MODEL_STEP_WF3000C0 = "WF3000C0";
	public static String APPROVAL_MODEL_STEP_WF3000D0 = "WF3000D0";
	public static String APPROVAL_MODEL_STEP_WF3000E0 = "WF3000E0";
	public static String APPROVAL_MODEL_STEP_WF4000A0 = "WF4000A0";


	public static String MAL0020 = "MAL0020";
	public static String MAL0021 = "MAL0021";
	public static String MAL0030 = "MAL0030";
	public static String MAL0031 = "MAL0031";
	public static String MAL0032 = "MAL0032";
	public static String MAL0033 = "MAL0033";
	public static String MAL0034 = "MAL0034";
	public static String MAL0035 = "MAL0035";
	public static String MAL0036 = "MAL0036";
	public static String MAL0037 = "MAL0037";
	public static String MAL0040 = "MAL0040";
	public static String MAL0041 = "MAL0041";
	public static String MAL0042 = "MAL0042";
	public static String MAL0050 = "MAL0050";
	public static String MAL0051 = "MAL0051";
	public static String MAL0052 = "MAL0052";
	public static String MAL0053 = "MAL0053";

	public static String SMS0020 = "SMS0020";
	public static String SMS0021 = "SMS0021";
	public static String SMS0030 = "SMS0030";
	public static String SMS0031 = "SMS0031";
	public static String SMS0032 = "SMS0032";
	public static String SMS0033 = "SMS0033";
	public static String SMS0034 = "SMS0034";
	public static String SMS0035 = "SMS0035";
	public static String SMS0036 = "SMS0036";
	public static String SMS0037 = "SMS0037";
	public static String SMS0040 = "SMS0040";
	public static String SMS0041 = "SMS0041";
	public static String SMS0042 = "SMS0042";
	public static String SMS0050 = "SMS0050";
	public static String SMS0051 = "SMS0051";
	public static String SMS0052 = "SMS0052";
	public static String SMS0053 = "SMS0053";

	public static String WITH0020 = "WITH0020";
	public static String WITH0021 = "WITH0021";
	public static String WITH0030 = "WITH0030";
	public static String WITH0031 = "WITH0031";
	public static String WITH0032 = "WITH0032";
	public static String WITH0033 = "WITH0033";
	public static String WITH0034 = "WITH0034";
	public static String WITH0035 = "WITH0035";
	public static String WITH0036 = "WITH0036";
	public static String WITH0037 = "WITH0037";
	public static String WITH0040 = "WITH0040";
	public static String WITH0041 = "WITH0041";
	public static String WITH0042 = "WITH0042";
	public static String WITH0050 = "WITH0050";
	public static String WITH0051 = "WITH0051";
	public static String WITH0052 = "WITH0052";
	public static String WITH0053 = "WITH0053";

	// CI/CD PAAS
	public static int CREATE_PAAS_ENV_PROJECT_COUNT = 2;
	public static String CREATE_PAAS_PORD_ENV = "-prod";
	public static String CREATE_PAAS_DEV_ENV = "-dev";

	public static String PROD_ENV_TYPE_CODE_ID = "PROD";
	public static String DEV_ENV_TYPE_CODE_ID  = "DEV";

	public static String PROJECT_LABEL = "zone";

	public static String CMM_CODE_CICD_REQTYPE_NEW_DEPLOY = "CICD_REQTYPE_NEW_DEPLOY";
	public static String CMM_CODE_CICD_REQTYPE_REDEPLOY = "CICD_REQTYPE_REDEPLOY";
	public static String CMM_CODE_SYNC_APP_FAIL = "SYNC_APP_FAIL";
	public static String CMM_CODE_SYNC_APP_ONGOING = "SYNC_APP_ONGOING";
	public static String CMM_CODE_SYNC_APP_READY = "SYNC_APP_READY";
	public static String CMM_CODE_SYNC_APP_STATUS = "SYNC_APP_STATUS";
	public static String CMM_CODE_SYNC_APP_SUCCESS= "SYNC_APP_SUCCESS";

	public static String CICD_PIPELINE_JOB_STATUS_STAGE = "deploy_staging";
	public static String CICD_PIPELINE_JOB_STATUS_COPY = "copy_staging_to_prod";
	public static String CICD_PIPELINE_JOB_STATUS_PORD = "deploy_production";

	public static int CICD_REQTYPE_NEW_VERSION = 1;

	public static String CMM_CODE_PV_NAS_TYPE = "PV";
	public static String CMM_CODE_FS_NAS_TYPE = "FS";

	public static String getClass(String string) {
		return string+"test";
	}

}
