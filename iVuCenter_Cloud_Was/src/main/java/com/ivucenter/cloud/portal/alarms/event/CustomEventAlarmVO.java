package com.ivucenter.cloud.portal.alarms.event;

import com.ivucenter.cloud.entity.EventAlarmVO;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CustomEventAlarmVO extends EventAlarmVO{
	
	private String searchKind;
	private String keyword = "";
	
}
