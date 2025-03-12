package com.ivucenter.cloud.portal.project.persistentvolume;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ivucenter.cloud.portal.cmm.cloud.OssCloudService;
import com.ivucenter.cloud.portal.oss.application.OssAppService;
import com.ivucenter.cloud.portal.oss.persistentvolume.OssPvService;
import com.ivucenter.cloud.portal.oss.project.CustomOssProjectVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value="/mng/project/persistentvolume")
public class MngProjectPersistentVolumeController {

	@Autowired
	OssAppService service;

	@Autowired
	OssPvService pvService;

	@Autowired
	OssCloudService ossCloudService;

	@RequestMapping(value="/")
	public String MngProjectPv(ModelMap model) {
		return "mng/project/persistentvolume/persistentVolume_list";
	}

	@RequestMapping(value="/view")
	public String MngProjectPvView(Model model, CustomOssProjectVO req) {
		model.addAttribute("req", req);
		return "mng/project/persistentvolume/persistentVolume_view";
	}

	@RequestMapping(value="/write")
	public String MngProjectPvWrite(Model model, CustomOssProjectVO req) {
		model.addAttribute("req", req);
//		model.addAttribute("projectId", req.getProjectId());
		//model.addAttribute("projectName", req.getProjectName());

		return "mng/project/persistentvolume/persistentVolume_write";
	}
}
