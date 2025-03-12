package com.ivucenter.cloud.portal.operation.approveLine;

import com.ivucenter.cloud.entity.ApprovalVO;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CustomApproveLineVO  extends ApprovalVO{
	
	private String cloudName;
	private String codeName;
	private String stepLevelMax;
	private String stepType;
	private String approvalCount;
	private String stepTypeCount;
	
	
}
