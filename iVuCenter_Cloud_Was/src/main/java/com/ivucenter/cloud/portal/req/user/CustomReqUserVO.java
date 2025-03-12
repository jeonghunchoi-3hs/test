package com.ivucenter.cloud.portal.req.user;

import com.ivucenter.cloud.entity.ReqUserVO;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CustomReqUserVO extends ReqUserVO{
	
	// 검색
	private String searchKind = "";
	private String keyword = "";
	
	private String mailDomain;
	private String recvFlag;
	
	private String mbrPhone1;
	private String mbrPhone2;
	private String mbrPhone3;
	private String mbrTel1;
	private String mbrTel2;
	private String mbrTel3;
	
	private String mbrTelEx1;
	private String mbrTelEx2;
	
	private String customerName;
	private String companyName;
	private String deptName;
	private String searchAll;
	
	private String apprvOperation = ""; // WF1000A0:요청부서(검토),  WF1000B0:요청부서(승인)
	
}
