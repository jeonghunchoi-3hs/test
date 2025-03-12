package com.ivucenter.cloud.portal.cmm.user;

import com.ivucenter.cloud.entity.CmmUserVO;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CustomCmmUserVO extends CmmUserVO{

	private String searchKind = "";
	private String keyword = "";
	private String keyword2 = "";

	private String customerName;		// 고객사 이름
	private String companyName;			// 계열사 이름
	private String deptName;			// 부서 이름
	private String userLevelCode;		// 부서 코드
	private String userLevelCodeName;

	/**
	 * 아이디 찾기 및 비밀번호 찾기
	 */
	private String mailSeq;
	private String templateId;
	private String title;
	private String content;
	private String senderName = "클라우드관리자";
	private String senderMail = "cloud@3hs.co.kr";
	private String receiverFlg;
	private String receiverId;
	private String receiverName;
	private String receiverMail;
	private String retryCount;
	private String resultFlg;

	// 이메일 코드 입력 수정 2017.07.13 이윤준
	private String codeId;
	private String codeName;

	private String mbrPhone1;
	private String mbrPhone2;
	private String mbrPhone3;
	private String mbrTel1;
	private String mbrTel2;
	private String mbrTel3;

	private String mbrTelEx1;
	private String mbrTelEx2;
	private String mbrTelEx3;

	private String mailDomain;
	private String recvFlag;	// SMS, NHWith, Mail

	private String projectId;
	private String projectName;
	private String projectMemberRole;
	private String projectManagerType;
	private String vmUuid;
	private String action;
	private String description;
	private String ip;
	private String projectRegDatetime;
	private String confirmAction;
	private String deptNameOnly;

	//KEPCO 추가 Column
	private String userCondition;
	private String userConditionText;
	private String userCloudAuths;
	private String apprvPass;

	private String userBlock;
	private String authFlag;
}
