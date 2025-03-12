package com.ivucenter.cloud.portal.oss.vm;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value="/mbr/oss/vm")
public class MbrOssVmController{

	@Autowired
	OssVmService service;

	@RequestMapping(value="/list", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public ResponseEntity<String> MbrOssVmList(CustomOssVmVO req) {
		String res = service.list(req);

		return new ResponseEntity<String>(res, HttpStatus.OK);
	}

	@RequestMapping(value = "/detailSum")
	public ResponseEntity<CustomOssVmVO> MbrOssVmDetailSum(CustomOssVmVO req) {
		CustomOssVmVO res = service.detailSum(req);

		return new ResponseEntity<CustomOssVmVO>(res, HttpStatus.OK);
	}


	@RequestMapping(value="/catalogueVmlist", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public ResponseEntity<String> MbrOsscatalogueVmList(CustomOssVmVO req) {
		String res = service.catalogueVmlist(req);

		return new ResponseEntity<String>(res, HttpStatus.OK);
	}

	@RequestMapping(value="/catalogueNutanixVmlist", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public ResponseEntity<String> catalogueNutanixVmlist(CustomOssVmVO req) {
		String res = service.catalogueNutanixVmlist(req);

		return new ResponseEntity<String>(res, HttpStatus.OK);
	}

	@RequestMapping(value = "/detail")
	public ResponseEntity<CustomOssVmVO> MbrOssVmDetail(CustomOssVmVO req) {
		CustomOssVmVO res = service.detail(req);

		return new ResponseEntity<CustomOssVmVO>(res, HttpStatus.OK);
	}

	@RequestMapping(value = "/update")
	public ResponseEntity<String> MbrOssVmUpdate(CustomOssVmVO req, Model model) {
		String res = "";
		try {
			res = service.update(req);

			return new ResponseEntity<String>(res, HttpStatus.OK);
		} catch (Exception e) {
			log.error(e.getMessage());
		}
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}

	@RequestMapping(value = "/action")
	public ResponseEntity<String> MbrOssVmAction(CustomOssVmVO req) throws Exception {
		String res = service.action(req);

		return new ResponseEntity<String>(res, HttpStatus.OK);
	}

	@RequestMapping(value = "/excel")
	public ModelAndView MngOssVmExcel(CustomOssVmVO req, ModelMap map) {
		map.addAttribute("excel_gbn", "vm");
		map.addAttribute("excel_title", "프로젝트_가상서버 목록");
		map.addAttribute("excel_list", service.excel(req));

		return new ModelAndView("productExcelView", map);
	}
}
