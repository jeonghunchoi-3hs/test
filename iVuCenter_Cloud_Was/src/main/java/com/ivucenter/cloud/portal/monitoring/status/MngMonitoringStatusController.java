package com.ivucenter.cloud.portal.monitoring.status;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ivucenter.cloud.portal.cmm.cloud.OssCloudService;
import com.ivucenter.cloud.portal.login.UserSession;
import com.ivucenter.cloud.portal.oss.vm.CustomOssVmVO;
import com.ivucenter.cloud.portal.oss.vm.OssVmService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping(value="/mng/monitoring/status")
@Controller
public class MngMonitoringStatusController{

	@Autowired
	MonitoringRealtimeStatusService service;

	@Autowired
	OssVmService ossVmService;

	@Autowired
	private OssCloudService ossCloudService;

	@RequestMapping(value="/")
	@Secured( {"ROLE_CUSTOM_ADMIN","ROLE_CUSTOM_USER", "ROLE_CUSTOM_PM"} )
	public String MngMonitoringStatus(Model model) {
		log.debug("MbrMonitoringStatusController:MbrMonitoringStatus()");
		return "mng/monitoring/status/realtimeStatusList";
	}

	@RequestMapping(value="/list", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> MbrMonitorEventList(CustomMonitoringStatusVO req){

		UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		CustomOssVmVO customOssVmVO = new CustomOssVmVO();
		customOssVmVO.setUserId(userSession.getUsername());
		customOssVmVO.setCloudId(req.getCloudId());

		List<CustomOssVmVO> osList = ossVmService.vmListProjectUser(customOssVmVO);

	    Map map = new HashMap();
	    map.put("list", osList);
	    map.put("searchKind", req.getSearchKind());
	    map.put("keyword", req.getKeyword());

	    String res = "";
		if(osList.size() !=0 ) {
			res = service.list(map);
		}

		if(res.equals("")){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
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
