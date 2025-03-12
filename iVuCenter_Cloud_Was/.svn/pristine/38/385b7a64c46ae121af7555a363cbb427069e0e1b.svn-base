package com.ivucenter.cloud.portal.oss.disk;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value="/mng/oss/disk")
public class MngOssDiskController {

	@Autowired
	private OssDiskService service;

	/**
	 *	ACTION
	 */
	@RequestMapping(value="/list", method = RequestMethod.GET , produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> MngOssDiskList(CustomOssDiskVO req){
		String res = service.list(req);
		if(res.equals("")){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		log.debug(res);
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	@RequestMapping(value = "/detail")
	public ResponseEntity<CustomOssDiskVO> MngOssDiskDetail(CustomOssDiskVO req) {
		CustomOssDiskVO res = service.detail(req);
		return new ResponseEntity<CustomOssDiskVO>(res, HttpStatus.OK);
	}

	@RequestMapping(value="/detach", method = RequestMethod.GET)
	public ResponseEntity<CustomOssDiskVO> MngOssDiskDetach(CustomOssDiskVO req){
		CustomOssDiskVO res = service.detach(req);
		return new ResponseEntity<CustomOssDiskVO>(res, HttpStatus.OK);
	}
	@RequestMapping(value="/attach", method = RequestMethod.GET)
	public ResponseEntity<CustomOssDiskVO> MngOssDiskattach(CustomOssDiskVO req){
		CustomOssDiskVO res = service.attach(req);
		return new ResponseEntity<CustomOssDiskVO>(res, HttpStatus.OK);
	}
	@RequestMapping(value="/update", method = RequestMethod.GET)
	public ResponseEntity<Object> MngOssDiskUpade(CustomOssDiskVO req){
		String res = service.updateAlias(req);
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	@RequestMapping(value = "/excel")
	public ModelAndView MngOssDiskExcel(CustomOssDiskVO req, ModelMap map) {
		map.addAttribute("excel_gbn", "disk");
		map.addAttribute("excel_title", "프로젝트_블록디스크 목록");
		map.addAttribute("excel_list", service.excel(req));
		return new ModelAndView("productExcelView", map);
	}

}
