package com.ivucenter.cloud.portal.application.management;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.ivucenter.cloud.portal.oss.application.CustomOssAppVO;
import com.ivucenter.cloud.portal.oss.application.OssAppService;
import com.ivucenter.cloud.portal.oss.project.CustomOssProjectVO;


//@Slf4j
@Controller
@RequestMapping(value="/mbr/application/management")
public class mbrManagementAppController {

	@Autowired
	OssAppService service;

	@RequestMapping(value="/")
	public String mbrManagementList() {
		return "mbr/application/management/appManagemenet_List";
	}

	@RequestMapping(value="/status")
	public String mbrApplicationStatus(Model model, CustomOssProjectVO req) {
		model.addAttribute("req", req);
		return "mbr/application/management/appManagement_Status";
	}

	@RequestMapping(value="/list", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public ResponseEntity<String> MbrOssVmList(CustomOssAppVO req) {
		String res = service.list(req);
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}

	@RequestMapping(value="/detail", produces="text/plain;charset=UTF-8")
	public ResponseEntity<String> MbrOssAppDetail(CustomOssAppVO req) {
		String res = service.detail(req);
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}

	@RequestMapping(value = "/viewExcel")
	public ModelAndView MngOssVmExcel(CustomOssAppVO req, ModelMap map) {
		req.setProjectBoxId(req.getProjectBoxId());

		map.addAttribute("excel_gbn", "application");
		map.addAttribute("excel_title", "자원 현황_어플리케이션");
		map.addAttribute("excel_list", service.viewExcel(req));

		return new ModelAndView("productExcelView", map);
	}

}
