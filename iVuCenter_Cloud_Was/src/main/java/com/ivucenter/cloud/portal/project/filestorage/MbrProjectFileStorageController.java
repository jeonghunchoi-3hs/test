package com.ivucenter.cloud.portal.project.filestorage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ivucenter.cloud.portal.cmm.cloud.OssCloudService;
import com.ivucenter.cloud.portal.login.UserSession;
import com.ivucenter.cloud.portal.oss.project.CustomOssProjectVO;

@Controller
@RequestMapping(value="/mbr/project/filestorage")
public class MbrProjectFileStorageController {

	@Autowired
  	private OssCloudService ossCloudService;

	/**
	 *	PAGE
	 */
	@RequestMapping(value="/")
	public String MbrProjectPv(Model model) {

		return "mbr/project/filestorage/projectFs_list";
	}

	@RequestMapping(value="/view")
	public String MbrProjectPvView(Model model, CustomOssProjectVO req) {
		UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		model.addAttribute("apprvPass", userSession.getApprvPass());
		model.addAttribute("req", req);
		return "mbr/project/filestorage/projectFs_view";
	}
}
