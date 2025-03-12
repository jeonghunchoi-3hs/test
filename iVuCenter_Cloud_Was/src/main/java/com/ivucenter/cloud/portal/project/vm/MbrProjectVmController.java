package com.ivucenter.cloud.portal.project.vm;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ivucenter.cloud.portal.cmm.cloud.OssCloudService;
import com.ivucenter.cloud.portal.oss.project.CustomOssProjectVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value="/mbr/project/vm")
public class MbrProjectVmController {

	@Autowired
	private OssCloudService ossCloudService;

	/**
	 *	PAGE
	 */
	@RequestMapping(value="/")
	public String MngProjectVm(Model model, CustomOssProjectVO req) {
		model.addAttribute("req", req);
		return "mbr/project/vm/projectVm_list";
	}

	@RequestMapping(value="/view" , produces="text/plain;charset=UTF-8")
	public String MngProjectVmView(Model model, CustomOssProjectVO req) {
		model.addAttribute("req", req);
		return "mbr/project/vm/projectVm_view";
	}

	@RequestMapping(value="/write")
	public String MngProjectVmWrite(Model model, CustomOssProjectVO req) {
		model.addAttribute("req", req);
		return "mbr/project/vm/projectVm_write";
	}
}
