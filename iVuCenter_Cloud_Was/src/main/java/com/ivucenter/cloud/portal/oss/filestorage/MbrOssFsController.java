package com.ivucenter.cloud.portal.oss.filestorage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping(value="/mbr/oss/filestorage")
public class MbrOssFsController {

	@Autowired
	private OssFsService service;

	/**
	 *	ACTION
	 */
	@RequestMapping(value="/list", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> MbrPvList(CustomOssFsVO req){
		String res = service.list(req);
		//log.debug(res);
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	@RequestMapping(value="/fsList", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> MbrOssfsList(CustomOssFsVO req){
		String res = service.fsList(req);
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	@RequestMapping(value="/pvDetachList", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> MbrOssPvDetachList(CustomOssFsVO req){
		String res = service.pvDetachList(req);
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	@RequestMapping(value="/detach", method = RequestMethod.GET)
	public ResponseEntity<CustomOssFsVO> MbrOssPvcDetach(CustomOssFsVO req){
		CustomOssFsVO res = service.detach(req);

		return new ResponseEntity<CustomOssFsVO>(res, HttpStatus.OK);
	}
	@RequestMapping(value="/attach", method = RequestMethod.GET)
	public ResponseEntity<CustomOssFsVO> MbrOssPvcAttach(CustomOssFsVO req){
		CustomOssFsVO res = service.attach(req);

		return new ResponseEntity<CustomOssFsVO>(res, HttpStatus.OK);
	}

	@RequestMapping(value = "/pvcStatusUpdate")
	public ResponseEntity<String> pvcStatusUpdate(CustomOssFsVO req) {
		String res = service.pvcStatusUpdate(req);

		return new ResponseEntity<String>(res, HttpStatus.OK);
	}

	@RequestMapping(value = "/pvcPathUpdate")
	public ResponseEntity<String> pvcPathUpdate(CustomOssFsVO req) {
		String res = service.pvcPathUpdate(req);

		return new ResponseEntity<String>(res, HttpStatus.OK);
	}

	@RequestMapping(value = "/excel")
	public ModelAndView MngOssDiskExcel(CustomOssFsVO req, ModelMap map) {
		map.addAttribute("excel_gbn", "pv");
		map.addAttribute("excel_title", "프로젝트_pv 목록");
		map.addAttribute("excel_list", service.excel(req));
		return new ModelAndView("productExcelView", map);
	}
}
