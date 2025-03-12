package com.ivucenter.cloud.entity;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ReqCustomerVO  extends DataTableVO{

	//�����
	private String companyId;
	private String companyName;
	private String companyNo;
	private String companyRep;
	private String companyAddr;
	private String contactName;
	private String contactPhone;
	private String contactTel;
	private String contactMail;
	private String regDatetime;
	private String regUserId;
	private String modDatetime;
	private String userLevel;
	private String modUserId;
	private String delFlag = "N";
	//ȸ����
	private String requestSeq;
	private String customerId;
	private String customerName;
	private String smsRecvFlag;
	private String mailAuthFlag;

	//���θ� �ܰ� ������
	private String stepId;
	private String userId;
	private String apprvAuthFlag;
	private String mailRecvFlag;
	//private String smsRecvFlag;
	private String pushRecvFlag;

	//���θ� �ܰ�
	private String modelId;
	private String stepName;
	private String stepLevel;
	private String leftStepId;
	private String rightStepId;
	private String apprvDescription;
	private String apprvDatetime;
	private String apprvUserName;
	private String apprvUserId;

	private String projectId;
	private String projectBoxId;
	private String hostname;
	private String hostnameAlias;
	private String vcpus;
	private String memGb;
	private String diskGb;
	private String vmProductSeq;
	private String osProductSeq;

	//���� ���� pho
	private String apprvState;
	private String codeName;
	private String requestType;
}