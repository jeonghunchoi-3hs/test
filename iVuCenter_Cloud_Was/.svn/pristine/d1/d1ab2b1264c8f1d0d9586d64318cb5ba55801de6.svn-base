package com.ivucenter.cloud.portal.project.disk;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ivucenter.cloud.portal.cmm.cloud.OssCloudService;
import com.ivucenter.cloud.portal.login.UserSession;
import com.ivucenter.cloud.portal.oss.project.CustomOssProjectVO;

@Controller
@RequestMapping(value="/mbr/project/disk")
public class MbrProjectDiskController {

	@Autowired
  	private OssCloudService ossCloudService;
  
	/**
	 *	PAGE
	 */
	@RequestMapping(value="/")
	public String MngProjectDisk(Model model) {

		return "mbr/project/disk/projectDisk_list";
	}

	@RequestMapping(value="/view")
	public String MngProjectDiskView(Model model, CustomOssProjectVO req) {
		UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		model.addAttribute("apprvPass", userSession.getApprvPass());
		model.addAttribute("req", req);
		return "mbr/project/disk/projectDisk_view";
	}

	@RequestMapping(value="/write")
	public String MngProjectDiskWrite(Model model, CustomOssProjectVO req) {
		model.addAttribute("req", req);
//		model.addAttribute("projectId", req.getProjectId());
		//model.addAttribute("projectName", req.getProjectName());

		return "mbr/project/disk/projectDisk_write";
	}
}
