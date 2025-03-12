package com.ivucenter.cloud.portal.oss.loadbalancer;

import com.ivucenter.cloud.entity.OssVO;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CustomOssLbVO extends OssVO{

	private String searchKind;
	private String keyword = "";
	
	private String searchKey;
	private String searchValue;
	
}
