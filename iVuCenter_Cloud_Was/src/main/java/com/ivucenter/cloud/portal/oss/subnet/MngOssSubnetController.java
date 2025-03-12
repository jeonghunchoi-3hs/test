package com.ivucenter.cloud.portal.oss.subnet;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value="/mng/oss/subnet")
public class MngOssSubnetController{
	
	@Autowired
	private OssSubnetService service;
	
	@RequestMapping(value="/list", method = RequestMethod.GET)
	public ResponseEntity<String> MngOssSubnetList(CustomOssSubnetVO req) {
		String res = service.list(req);
		log.debug(res);
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}	
	
	@RequestMapping(value = "/detail")
	public ResponseEntity<CustomOssSubnetVO> MngOssSubnetDetail(CustomOssSubnetVO req) {
		CustomOssSubnetVO res = service.detail(req);
		
		return new ResponseEntity<CustomOssSubnetVO>(res, HttpStatus.OK);
	}
	@RequestMapping(value = "/detail2")
	public ResponseEntity<CustomOssSubnetVO> MngOssSubnetDetail2(CustomOssSubnetVO req) {
		CustomOssSubnetVO res = service.detail2(req);
		
		return new ResponseEntity<CustomOssSubnetVO>(res, HttpStatus.OK);
	}
	@RequestMapping(value = "/update")
	public ResponseEntity<String> MngOssSubnetUpdate(CustomOssSubnetVO req) {
		String res = service.update(req);
		
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/insert")
	public ResponseEntity<String> MngOssSubnetInsert(CustomOssSubnetVO req) {
		String res = service.insert(req);
		
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/delete")
	public ResponseEntity<String> MngOssSubnetDelete(CustomOssSubnetVO req) {
		String res = service.delete(req);
		
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
}
