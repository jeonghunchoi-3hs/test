package com.ivucenter.cloud.portal.monitoring.status;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

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
@RequestMapping(value="/mbr/monitoring/status")
@Controller
public class MbrMonitorRealtimeStatusController{

	@Autowired
	MonitoringRealtimeStatusService service;

	@Autowired
	OssVmService ossVmService;

	@Autowired
	private OssCloudService ossCloudService;

	@RequestMapping(value="/")
	@Secured( {"ROLE_CUSTOM_ADMIN","ROLE_CUSTOM_USER", "ROLE_CUSTOM_PM"} )
	public String MbrMonitorEvent(Model model) {
		log.debug("MbrMonitoringStatusController:MbrMonitoringStatus()");

		return "mbr/monitoring/status/realtimeStatusList";
	}

	@RequestMapping(value="/detail")
	@Secured( {"ROLE_CUSTOM_ADMIN","ROLE_CUSTOM_USER", "ROLE_CUSTOM_PM"} )
	public String MbrMonitorEventDetail(Model model, HttpServletRequest request, CustomOssVmVO req ) {
		log.debug("MbrMonitoringStatusController:MbrMonitorEventDetail()");

		//String hostname = request.getParameter("hostname");

		CustomOssVmVO vmDetailInfo = ossVmService.vmDetailByHostname(req);
		vmDetailInfo.setUserTel(vmDetailInfo.getUserTelDec());
		model.addAttribute("vmDetailInfo", vmDetailInfo);

		//CPU Line Chart
		List<CustomMonitoringStatusVO> cpuUsage = service.getCpuUsaged(req);
		String[] cpuUsageDatetime = new String[cpuUsage.size()];
		Float[] cpuUsageValue = new Float[cpuUsage.size()];
		int tmpCnt = 0;
		for (CustomMonitoringStatusVO customMonitoringStatusVO : cpuUsage) {
			cpuUsageDatetime[tmpCnt] = customMonitoringStatusVO.getDatetime();
			cpuUsageValue[tmpCnt] = customMonitoringStatusVO.getCpuUsedPct();
			tmpCnt++;
		}
		model.addAttribute("cpuUsageDatetime", cpuUsageDatetime );
		model.addAttribute("cpuUsageValue", cpuUsageValue );

		//MEM Line Chart
		List<CustomMonitoringStatusVO> memUsage = service.getMemUsaged(req);

		String[] memUsageDatetime = new String[memUsage.size()];
		Float[] memUsageValue = new Float[memUsage.size()];
		tmpCnt = 0;
		for (CustomMonitoringStatusVO customMonitoringStatusVO : memUsage) {
			memUsageDatetime[tmpCnt] = customMonitoringStatusVO.getDatetime();
			memUsageValue[tmpCnt] = customMonitoringStatusVO.getMemUsedPct();
			tmpCnt++;
		}

		model.addAttribute("memUsageDatetime", memUsageDatetime );
		model.addAttribute("memUsageValue", memUsageValue );

		//DISK Line Chart
		List<CustomMonitoringStatusVO> diskUsage = service.getDiskUsaged(req);

		String[] diskUsageDatetime = new String[diskUsage.size()];
		String[] fsNameValue = new String[diskUsage.size()];
		Float[] spaceUsageValue = new Float[diskUsage.size()];
		tmpCnt = 0;
		for (CustomMonitoringStatusVO customMonitoringStatusVO : diskUsage) {
			diskUsageDatetime[tmpCnt] = customMonitoringStatusVO.getDatetime();
			fsNameValue[tmpCnt] = customMonitoringStatusVO.getFsName();
			spaceUsageValue[tmpCnt] = customMonitoringStatusVO.getSpaceUsedPct();
			tmpCnt++;
		}

		model.addAttribute("diskUsageDatetime", diskUsageDatetime );
		model.addAttribute("fsNameValue", fsNameValue );
		model.addAttribute("spaceUsageValue", spaceUsageValue );


		//NETWORK Line Chart
		List<CustomMonitoringStatusVO> networkUsage = service.getNetworkUsaged(req);

		String[] networkUsageDatetime = new String[networkUsage.size()];
		Float[] sendUsageValue = new Float[networkUsage.size()];
		Float[] reciveUsageValue = new Float[networkUsage.size()];
		tmpCnt = 0;
		for (CustomMonitoringStatusVO customMonitoringStatusVO : networkUsage) {
			networkUsageDatetime[tmpCnt] = customMonitoringStatusVO.getDatetime();
			sendUsageValue[tmpCnt] = customMonitoringStatusVO.getSentMb();
			reciveUsageValue[tmpCnt] = customMonitoringStatusVO.getReceivedMb();
			tmpCnt++;
		}

		model.addAttribute("networkUsageDatetime", networkUsageDatetime );
		model.addAttribute("sendUsageValue", sendUsageValue );
		model.addAttribute("reciveUsageValue", reciveUsageValue );



		return "mbr/monitoring/status/realtimeStatusDetail";
	}

	/**
	 *	ACTION
	 */
	@RequestMapping(value="/list", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> MbrMonitorEventList(HttpServletRequest request, CustomOssVmVO req){

		UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		CustomOssVmVO customOssVmVO = new CustomOssVmVO();
		customOssVmVO.setUserId(userSession.getUsername());


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

}
