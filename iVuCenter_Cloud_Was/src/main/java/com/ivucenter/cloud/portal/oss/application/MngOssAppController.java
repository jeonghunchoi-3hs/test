package com.ivucenter.cloud.portal.oss.application;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping(value="/mng/oss/app")
public class MngOssAppController {

	@Autowired
	private OssAppService service;

	/**
	 *	ACTION
	 */
	@RequestMapping(value="/list", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> MngOssAppList(CustomOssAppVO req){
		String res = service.list(req);
		//log.debug(res);
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	@RequestMapping(value="/pvAppList", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> MngOssPvAppList(CustomOssAppVO req){
		String res = service.pvAppList(req);
		//log.debug(res);
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

}
