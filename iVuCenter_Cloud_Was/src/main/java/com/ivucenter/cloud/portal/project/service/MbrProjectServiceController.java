package com.ivucenter.cloud.portal.project.service;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ivucenter.cloud.portal.oss.project.CustomOssProjectVO;

@Controller
@RequestMapping(value="/mbr/project/service")
public class MbrProjectServiceController {


	@RequestMapping(value="/")
	public String MngProjectService(Model model) {

		return "mbr/project/service/projectService_list";
	}
	
	@RequestMapping(value="/serviceView")
	public String MngProjectServiceView(Model model, CustomOssProjectVO req) {
		model.addAttribute("req", req);
		return "mbr/project/service/projectService_view";
	}
	
	@RequestMapping(value="/serviceWrite")
	public String MngProjectServiceWrite(Model model, CustomOssProjectVO req) {
		model.addAttribute("req", req);
		return "mbr/project/service/projectService_write";
	}
}
