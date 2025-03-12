package com.ivucenter.cloud.portal.project.filestorage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ivucenter.cloud.portal.cmm.cloud.OssCloudService;
import com.ivucenter.cloud.portal.oss.application.OssAppService;
import com.ivucenter.cloud.portal.oss.filestorage.OssFsService;
import com.ivucenter.cloud.portal.oss.project.CustomOssProjectVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value="/mng/project/filestorage")
public class MngProjectFileStorageController {

	@Autowired
	OssAppService service;

	@Autowired
	OssFsService fsService;

	@Autowired
	OssCloudService ossCloudService;

	@RequestMapping(value="/")
	public String MngProjectPv(ModelMap model) {
		return "mng/project/filestorage/filestorage_list";
	}

	@RequestMapping(value="/view")
	public String MngProjectPvView(Model model, CustomOssProjectVO req) {
		model.addAttribute("req", req);
		return "mng/project/filestorage/filestorage_view";
	}

}
