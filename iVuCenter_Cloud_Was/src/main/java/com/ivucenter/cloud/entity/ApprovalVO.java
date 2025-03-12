package com.ivucenter.cloud.entity;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ApprovalVO extends DataTableVO {
	
	private String stepId;              
	private String requestSeq;       
	private String flowId;             
	private String stepName;          
	private String stepLevel;        
	private String leftStepId;       
	private String rightStepId;      
	private String apprvState;       
	private String apprvUserId;       
	private String apprvUserName;   
	private String apprvDatetime;     
	private String apprvDescription;
	
	private String userId;        
	private String apprvAuthFlag;
	private String mailRecvFlag; 
	private String smsRecvFlag;  
	private String pushRecvFlag; 

	private String modelId;
	private String cloudId;

}
