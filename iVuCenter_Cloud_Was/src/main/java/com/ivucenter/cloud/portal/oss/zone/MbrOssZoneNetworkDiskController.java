package com.ivucenter.cloud.portal.oss.zone;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ivucenter.cloud.api.nutanix.NutanixObject;
import com.ivucenter.cloud.api.nutanix.NutanixUtils;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;
import com.ivucenter.cloud.portal.cmm.cloud.OssCloudService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value="/mbr/oss/zone")
public class MbrOssZoneNetworkDiskController {

	@Autowired
	OssZoneNetworkDiskService service;

	
	@RequestMapping(value="/list", method = RequestMethod.GET)
	public ResponseEntity<Object> MbrOssZoneNetworkDisk(HttpServletRequest request, Model model) throws Exception {
		
		String cloudId = request.getParameter("cloudId");
		
		List<OssZoneNetworkDiskVO> res = new ArrayList();
			String zoneName =  request.getParameter("zoneName");
			OssZoneNetworkDiskVO req = new OssZoneNetworkDiskVO();
			req.setZoneName(zoneName);
			req.setCloudId(cloudId);
			res = service.list(req);
	

		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}
	
	@RequestMapping(value="/listAll", method = RequestMethod.GET)
	public ResponseEntity<Object> MbrOssZoneNetworkListAll(HttpServletRequest request, Model model) {
		
		String zoneName =  request.getParameter("zoneName");
		OssZoneNetworkDiskVO req = new OssZoneNetworkDiskVO();
		req.setZoneName(zoneName);
		List<OssZoneNetworkDiskVO> res = service.list(req);

		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}
	
	
	@RequestMapping(value="/projectZoneList", method = RequestMethod.GET)
	public ResponseEntity<Object> ossZoneNetworkDiskservice(HttpServletRequest request, Model model) throws Exception {
		
		String projectBoxId = request.getParameter("projectBoxId");
		
		List<OssZoneNetworkDiskVO> res = new ArrayList();
			OssZoneNetworkDiskVO req = new OssZoneNetworkDiskVO();
			req.setProjectBoxId(projectBoxId);
			
		    res = service.list(req);
			

		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}
	
	
	
	
}
