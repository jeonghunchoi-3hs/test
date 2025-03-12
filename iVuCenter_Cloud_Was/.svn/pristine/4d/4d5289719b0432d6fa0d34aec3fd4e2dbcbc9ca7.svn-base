package com.ivucenter.cloud.portal.monitoring.kvm;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ivucenter.cloud.batch.sendStatus.SendStatusService;
import com.ivucenter.cloud.portal.alarms.template.AlarmsTemplateService;
import com.ivucenter.cloud.portal.cmm.user.CustomCmmUserVO;
import com.ivucenter.cloud.portal.home.PotalHomeService;
import com.ivucenter.cloud.portal.login.UserSession;
import com.ivucenter.cloud.portal.pss.server.CustomPssServerVO;
import com.ivucenter.cloud.portal.pss.server.PssServerService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping(value="/mng/kvm/status")
@Controller
public class MngKvmStatusController{
	
	@Autowired
	MonitoringKvmStatusService service;
	
	@Autowired
	PssServerService pssServerService;
	
	@Autowired
	private PotalHomeService potalHomeService;
	
	@Autowired
	private AlarmsTemplateService alarmsTemplateService;
	
	@Autowired
    private SendStatusService sendStatusService;
	
	
	@RequestMapping(value="/")
	@Secured( {"ROLE_CUSTOM_ADMIN","ROLE_CUSTOM_USER", "ROLE_CUSTOM_PM"} )
	public String MngMonitoringStatus() {
		log.debug("MbrMonitoringStatusController:MbrMonitoringStatus()");
		return "mng/monitoring/kvm/kvmStatusList";
	}
	
	@RequestMapping(value="/list", method = RequestMethod.GET)
	public ResponseEntity<Object> MbrMonitorEventList(CustomMonitoringKvmStatusVO req){
		
		UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		List<CustomPssServerVO> pssServerList = pssServerService.pssServerList();

		Map map = new HashMap();
		map.put("list", pssServerList);
	    map.put("searchKind", req.getSearchKind());
	    map.put("keyword", req.getKeyword());
	    map.put("start", req.getStart());
	    map.put("length", req.getLength());
	    map.put("size", 1);
	    String res = "";
	    if(pssServerList.size() !=0 ) {
	    	res = service.list(map);
	    }
		
		if(res.equals("")){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}
	
	@RequestMapping(value="/sendMail", method = RequestMethod.GET)
	public ResponseEntity<String> sendMail(CustomCmmUserVO req){
		String result = alarmsTemplateService.mail(70, req.getUserId(), sendStatusService.getContent());
		return new ResponseEntity<String>(result, HttpStatus.OK);
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
	public String MbrMonitorEventView(Model model, CustomMonitoringStatusVO req) {
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

}
