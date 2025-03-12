package com.ivucenter.cloud.portal.monitor.event;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping(value="/mng/monitor/event")
@Controller
public class MngMonitorEventController{

	@Autowired
	MonitorEventService service;

	@RequestMapping(value="/")
	@PreAuthorize("isAuthenticated()")
	public String MngMonitorEvent() {
		log.debug("MngMonitorEventController:MngMonitorEvent()");
		return "mng/monitor/event/monitorEventList";
	}

	/**
	 *	ACTION
	 */
	@RequestMapping(value="/list", method = RequestMethod.GET)
	public ResponseEntity<Object> MngMonitorEventList(CustomMonitorEventVO req){

		String res = service.list(req);

		if(res.equals("")){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

}
