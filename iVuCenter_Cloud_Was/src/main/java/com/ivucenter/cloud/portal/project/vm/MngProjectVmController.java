package com.ivucenter.cloud.portal.project.vm;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ivucenter.cloud.portal.cmm.cloud.OssCloudService;
import com.ivucenter.cloud.portal.oss.project.CustomOssProjectVO;

@Controller
@RequestMapping(value="/mng/project/vm")
public class MngProjectVmController {

	/**
	 *	PAGE
	 */
	@Autowired
	private OssCloudService ossCloudService;

	@RequestMapping(value="/")
	public String MngProjectVm(Model model,CustomOssProjectVO req) {
		model.addAttribute("instanceType", req.getInstanceType());
		return "mng/project/vm/projectVm_list";
	}

	@RequestMapping(value="/view")
	public String MngProjectVmView(Model model, CustomOssProjectVO req) {
		model.addAttribute("req", req);
		return "mng/project/vm/projectVm_view";
	}

	@RequestMapping(value="/write")
	public String MngProjectVmWrite(Model model, CustomOssProjectVO req) {
		model.addAttribute("req", req);
		return "mng/project/vm/projectVm_write";
	}


}
