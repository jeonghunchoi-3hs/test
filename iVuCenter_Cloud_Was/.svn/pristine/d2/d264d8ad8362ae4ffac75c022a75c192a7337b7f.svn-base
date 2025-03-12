package com.ivucenter.cloud.portal.monitor.event;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping(value="/mbr/monitor/event")
@Controller
public class MbrMonitorEventController{

	@Autowired
	MonitorEventService service;

	@RequestMapping(value="/")
	@Secured( {"ROLE_CUSTOM_ADMIN","ROLE_CUSTOM_USER", "ROLE_CUSTOM_PM"} )
	public String MbrMonitorEvent() {
		log.debug("MbrMonitorEventController:MbrMonitorEvent()");
		return "mbr/monitor/event/monitorEventList";
	}

	@RequestMapping(value="/smsEvent")
	@Secured( {"ROLE_CUSTOM_ADMIN","ROLE_CUSTOM_USER", "ROLE_CUSTOM_PM"} )
	public String smsEvent() {
		return "mbr/monitor/event/monitorSmsEvent";
	}

	@RequestMapping(value="/smsAnal")
	@Secured( {"ROLE_CUSTOM_ADMIN","ROLE_CUSTOM_USER", "ROLE_CUSTOM_PM"} )
	public String smsAnal() {
		return "mbr/monitor/event/monitorSmsAnal";
	}

	@RequestMapping(value="/view")
	@Secured( {"ROLE_CUSTOM_ADMIN","ROLE_CUSTOM_USER", "ROLE_CUSTOM_PM"} )
	public String MbrMonitorEventView(Model model, CustomMonitorEventVO req) {
		Map<String, String> map = service.getMetrics(req);

		model.addAttribute("hostname", req.getHostname());
		model.addAttribute("hostnameAlias", req.getHostnameAlias());
		if(map != null){
			service.measuresData(req, map.get("cpu_util"), model, "CPU");
			service.measuresData(req, map.get("memory.usage"), model, "MEM");
		}

		return "mbr/monitor/event/monitorEventView";
	}

	/**
	 *	ACTION
	 */
	@RequestMapping(value="/list", method = RequestMethod.GET)
	public ResponseEntity<Object> MbrMonitorEventList(CustomMonitorEventVO req){

		String res = service.list(req);

		if(res.equals("")){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}
}
