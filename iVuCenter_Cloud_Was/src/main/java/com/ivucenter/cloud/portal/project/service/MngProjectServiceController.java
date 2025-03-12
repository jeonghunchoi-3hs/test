package com.ivucenter.cloud.portal.project.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ivucenter.cloud.portal.cmm.cloud.OssCloudService;
import com.ivucenter.cloud.portal.oss.project.CustomOssProjectVO;

@Controller
@RequestMapping(value="/mng/project/service")
public class MngProjectServiceController {
	
	@Autowired
	private OssCloudService ossCloudservice;
	
	@RequestMapping(value="/")
	public String MngProjectService(Model model) {
		return "mng/project/service/projectService_list";
	}
	
	@RequestMapping(value="/serviceView")
	public String MngProjectServiceView(Model model, CustomOssProjectVO req) {					
		model.addAttribute("req", req);
		return "mng/project/service/projectService_view";
	}
	
	@RequestMapping(value="/serviceWrite")
	public String MngProjectServiceWrite(Model model, CustomOssProjectVO req) {					
		model.addAttribute("req", req);
		return "mng/project/service/projectService_write";
	}	
	
}
