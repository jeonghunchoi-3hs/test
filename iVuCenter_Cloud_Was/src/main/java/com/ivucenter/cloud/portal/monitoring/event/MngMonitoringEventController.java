package com.ivucenter.cloud.portal.monitoring.event;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ivucenter.cloud.portal.cmm.cloud.OssCloudService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping(value="/mng/monitoring/event")
@Controller
public class MngMonitoringEventController{

	@Autowired
	MonitoringRealtimeEventService service;

	@Autowired
	private OssCloudService ossCloudService;

	@RequestMapping(value="/")
	@Secured( {"ROLE_CUSTOM_ADMIN","ROLE_CUSTOM_USER", "ROLE_CUSTOM_PM"} )
	public String MngMonitoringEvent(Model model) {
		log.debug("MbrMonitoringEventController:MbrMonitorEvent()");

		return "mng/monitoring/event/realtimeEventList";
	}
	/*
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
	public String MbrMonitorEventView(Model model, CustomMonitoringEventVO req) {
		Map<String, String> map = service.getMetrics(req);

		model.addAttribute("hostname", req.getHostname());
		model.addAttribute("hostnameAlias", req.getHostnameAlias());
		if(map != null){
			service.measuresData(req, map.get("cpu_util"), model, "CPU");
			service.measuresData(req, map.get("memory.usage"), model, "MEM");
		}

		return "mbr/monitor/event/monitorEventView";
	}
	*/
	/**
	 *	ACTION
	 */
	/*
	@RequestMapping(value="/list", method = RequestMethod.GET)
	public ResponseEntity<Object> MbrMonitorEventList(CustomMonitoringEventVO req){

		String res = service.list(req);

		if(res.equals("")){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}
	*/
}
