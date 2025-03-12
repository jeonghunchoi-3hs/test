package com.ivucenter.cloud.portal.project.fee;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ivucenter.cloud.portal.oss.project.CustomOssProjectVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value="/mng/project/fee")
public class MngProjectFeeController {

	/**
	 *	PAGE 
	 */
	@RequestMapping(value="/")
	public String MngOssProjectFee() {
		log.debug("MngProjectFeeController:MngOssProjectFee()");
		return "mng/oss/fee/ossProjectFeeList";
	}
	
	@RequestMapping(value="/view")
	public String MngOssProjectFeeView(Model model, CustomOssProjectVO req) {
		model.addAttribute("projectId", req.getProjectId());
		model.addAttribute("projectName", req.getProjectName());
		
		return "mng/oss/fee/ossProjectFeeView";
	}

}
