package com.ivucenter.cloud.portal.project.network;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ivucenter.cloud.portal.oss.network.CustomOssNetworkVO;
import com.ivucenter.cloud.portal.oss.project.CustomOssProjectVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value="/mng/project/network")
public class MngProjectNetworkController {

	/**
	 *	PAGE 
	 */
	@RequestMapping(value="/")
	public String MngProjectNetwork() {
		log.debug("MngProjectNetworkController:MngProjectNetwork()");
		return "mng/project/network/projectNetwork_list";
	}
	
	@RequestMapping(value="/view")
	public String MngProjectNetworkView(Model model, CustomOssProjectVO req) {
		model.addAttribute("req", req);
		return "mng/project/network/projectNetwork_view";
	}

	@RequestMapping(value="/viewDetail")
	public String MngProjectNetworkViewDetail(Model model, CustomOssNetworkVO req) {
		model.addAttribute("req", req);
		return "mng/project/network/projectNetwork_view_detail";
	}
	
	@RequestMapping(value="/write")
	public String MngProjectNetworkWrite(Model model, CustomOssProjectVO req) {
		model.addAttribute("req", req);
//		model.addAttribute("projectId", req.getProjectId());
		//model.addAttribute("projectName", req.getProjectName());
		
		return "mng/project/network/projectNetwork_write";
	}
}
