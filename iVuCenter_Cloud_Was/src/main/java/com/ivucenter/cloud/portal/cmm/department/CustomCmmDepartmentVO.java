package com.ivucenter.cloud.portal.cmm.department;

import com.ivucenter.cloud.entity.CmmDepartmentVO;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CustomCmmDepartmentVO extends CmmDepartmentVO {

	private String searchKind = "";
	private String keyword = "";
	
	private String treeLevel;
	private boolean isLeaf;
	private boolean isExpanded;
}
