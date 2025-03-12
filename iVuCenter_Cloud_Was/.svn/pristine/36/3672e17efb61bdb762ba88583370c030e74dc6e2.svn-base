package com.ivucenter.cloud.portal.alarms.event;

import java.util.Date;
import java.util.UUID;

import org.apache.commons.lang.time.DateFormatUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class EventAlarmController {

	@Autowired
	EventAlarmService service;
	
	@RequestMapping(value="/alarm/{state}/{vmId}/{itemType}/{threadhold}")
	public void alarmAlert(@PathVariable("state") String state
			, @PathVariable("vmId") String vmId
			, @PathVariable("itemType") String itemType
			, @PathVariable("threadhold") String threadhold){
		
		CustomEventAlarmVO req = new CustomEventAlarmVO();
		req.setEventId(DateFormatUtils.format(new Date(), "yyyyMMdd-")+UUID.randomUUID());
		req.setVmId(vmId);
		req.setItemType(itemType);
		req.setThreadhold(threadhold);
		req.setState(state.toUpperCase());
		
		service.insertHistory(req);
		
		if(service.cnt(req) > 0){
			service.update(req);
		}else{
			service.insert(req);
		}
	}
	
}
