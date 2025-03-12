package com.ivucenter.cloud.portal.alarms.sms.queue;

import java.util.List;

import com.ivucenter.cloud.entity.SmsQueueVO;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CustomSmsQueueVO extends SmsQueueVO{
	
	private List<SmsQueueVO> receiverNumberList;

	
}
