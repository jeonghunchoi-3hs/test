package com.ivucenter.cloud.portal.oss.disk;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping(value="/mbr/oss/disk")
public class MbrOssDiskController {
	
	@Autowired
	private OssDiskService service;
	
	/**
	 *	ACTION 
	 */
	@RequestMapping(value="/list", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> MbrOssDiskList(CustomOssDiskVO req){
		String res = service.list(req);
		//log.debug(res);
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}
	@RequestMapping(value="/catalogueList", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> MbrOssDiskCatalogueList(CustomOssDiskVO req){
		req.setDiskType("block");
		String res = service.catalogueList(req);
		
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}	
	
	@RequestMapping(value="/detach", method = RequestMethod.GET)
	public ResponseEntity<CustomOssDiskVO> MbrOssDiskDetach(CustomOssDiskVO req){
		CustomOssDiskVO res = service.detach(req);
		
		return new ResponseEntity<CustomOssDiskVO>(res, HttpStatus.OK);
	}	
	@RequestMapping(value="/attach", method = RequestMethod.GET)
	public ResponseEntity<CustomOssDiskVO> MbrOssDiskattach(CustomOssDiskVO req){
		CustomOssDiskVO res = service.attach(req);
		
		return new ResponseEntity<CustomOssDiskVO>(res, HttpStatus.OK);
	}		
	@RequestMapping(value = "/detail")
	public ResponseEntity<CustomOssDiskVO> MbrOssDiskDetail(CustomOssDiskVO req) {
		CustomOssDiskVO res = service.detail(req);
		
		return new ResponseEntity<CustomOssDiskVO>(res, HttpStatus.OK);
	}

	@RequestMapping(value = "/updateAlias")
	public ResponseEntity<String> MbrOssDiskUpdateAlias(CustomOssDiskVO req) {
		String res = service.updateAlias(req);
			
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/excel")
	public ModelAndView MngOssDiskExcel(CustomOssDiskVO req, ModelMap map) {
		map.addAttribute("excel_gbn", "disk");
		map.addAttribute("excel_title", "프로젝트_블록디스크 목록");
		map.addAttribute("excel_list", service.excel(req));
		return new ModelAndView("productExcelView", map);
	}
	
	@RequestMapping(value="/snapshotDiskList", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> snapshotDiskList(CustomOssDiskVO req){
		req.setDiskType("block");
		String res = service.snapshotDiskList(req);
		
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}
	
}
