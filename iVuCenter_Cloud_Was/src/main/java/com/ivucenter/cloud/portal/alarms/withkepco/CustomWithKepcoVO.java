package com.ivucenter.cloud.portal.alarms.withkepco;

import com.ivucenter.cloud.entity.WithKepcoVO;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CustomWithKepcoVO extends WithKepcoVO {
	private String searchKind;
	private String keyword = "";
	
	private String startYm;
	private String endYm;
	
	private String regDateTime2; // '%Y-%m-%d %H:%i'
}
