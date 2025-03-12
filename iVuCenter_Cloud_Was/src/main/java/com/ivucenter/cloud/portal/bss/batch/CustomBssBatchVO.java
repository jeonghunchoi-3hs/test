package com.ivucenter.cloud.portal.bss.batch;

import com.ivucenter.cloud.entity.BssBatchVO;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CustomBssBatchVO extends BssBatchVO{

	private String userId;
	private String userName;
	private String roles;	
	
	
}
