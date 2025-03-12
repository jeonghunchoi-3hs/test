package com.ivucenter.cloud.portal.oss.persistentvolume;

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
@RequestMapping(value="/mng/oss/persistentvolume")
public class MngOssPvController {

	@Autowired
	private OssPvService service;

	/**
	 *	ACTION
	 */
	@RequestMapping(value="/list", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> MbrOssDiskList(CustomOssPvVO req){
		String res = service.list(req);
		//log.debug(res);
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	@RequestMapping(value="/nasList", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> MbrOssNasList(CustomOssPvVO req){
		String res = service.nasList(req);
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	@RequestMapping(value="/pvDetachList", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> MbrOssPvDetachList(CustomOssPvVO req){
		String res = service.pvDetachList(req);
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	@RequestMapping(value="/detach", method = RequestMethod.GET)
	public ResponseEntity<CustomOssPvVO> MbrOssPvcDetach(CustomOssPvVO req){
		CustomOssPvVO res = service.detach(req);

		return new ResponseEntity<CustomOssPvVO>(res, HttpStatus.OK);
	}
	@RequestMapping(value="/attach", method = RequestMethod.GET)
	public ResponseEntity<CustomOssPvVO> MbrOssPvcAttach(CustomOssPvVO req){
		CustomOssPvVO res = service.attach(req);

		return new ResponseEntity<CustomOssPvVO>(res, HttpStatus.OK);
	}

	@RequestMapping(value = "/pvcStatusUpdate")
	public ResponseEntity<String> pvcStatusUpdate(CustomOssPvVO req) {
		String res = service.pvcStatusUpdate(req);

		return new ResponseEntity<String>(res, HttpStatus.OK);
	}

	@RequestMapping(value = "/pvcPathUpdate")
	public ResponseEntity<String> pvcPathUpdate(CustomOssPvVO req) {
		String res = service.pvcPathUpdate(req);

		return new ResponseEntity<String>(res, HttpStatus.OK);
	}

	@RequestMapping(value = "/excel")
	public ModelAndView MngOssDiskExcel(CustomOssPvVO req, ModelMap map) {
		map.addAttribute("excel_gbn", "pv");
		map.addAttribute("excel_title", "프로젝트_pv 목록");
		map.addAttribute("excel_list", service.excel(req));
		return new ModelAndView("productExcelView", map);
	}
}
