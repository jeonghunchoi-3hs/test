package com.ivucenter.cloud.portal.project.loadbalancer;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ivucenter.cloud.portal.login.UserSession;
import com.ivucenter.cloud.portal.oss.loadbalancer.CustomOssLbVO;
import com.ivucenter.cloud.portal.oss.project.CustomOssProjectVO;

@Controller
@RequestMapping(value="/mbr/project/lb")
public class MbrProjectLbController {
	
	@RequestMapping(value="/")
	public String MngProjectLb(Model model) {
		return "mbr/project/lb/projectLb_list";
	}
	@RequestMapping(value="/view")
	public String MngProjectLbView(Model model,CustomOssProjectVO req) {
		model.addAttribute("req", req);
		return "mbr/project/lb/projectLb_view";
	}
	
	@RequestMapping(value="/detail")
	public String MngProjectLbDetail(Model model, CustomOssLbVO req) {
		UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		model.addAttribute("apprvPass", userSession.getApprvPass());
		model.addAttribute("req", req);
		return "mbr/project/lb/projectLb_detail";
	}

	
}
