package com.ivucenter.cloud.entity;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CmmDepartmentVO extends DataTableVO {
		
	private String deptCode;
	private String deptName;
	private String upCode;
	private String deptOrder;
	private String manager;
	private String delFlag = "N";
}
