package com.ivucenter.cloud.portal.alarms.mail.history;

import com.ivucenter.cloud.entity.MailQueueHistoryVO;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CustomMailQueueHistoryVO extends MailQueueHistoryVO{
	private String searchKind;
	private String keyword = "";
	
	private String resultDatetime2;
	
	private String startYm;
	private String endYm;
	
}
