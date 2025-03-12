package com.ivucenter.cloud.portal.cmm.code;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value="/mbr/cmm/code")
public class MbrCmmCodeController{
	
	@Autowired
	CmmCodeService service;
	
	@RequestMapping(value="/")
	@Secured( {"ROLE_CUSTOM_ADMIN","ROLE_CUSTOM_USER", "ROLE_CUSTOM_PM"} )
	public String mbrCmmCode() {
		
		return "mbr/operation/code/code"; 
	}

	@RequestMapping(value = "/list", produces="text/plain;charset=UTF-8")
	public ResponseEntity<String> mbrCmmCodeList(CustomCmmCodeVO req) {
		String res = service.list(req);
		
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}

	@RequestMapping(value = "/detail")
	public ResponseEntity<CustomCmmCodeVO> mbrCmmCodeDetail(CustomCmmCodeVO req) {
		CustomCmmCodeVO params = service.detail(req);
		
		return new ResponseEntity<CustomCmmCodeVO>(params, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/insert")
	public ResponseEntity<String> mbrCmmCodeInsert(CustomCmmCodeVO req) {
		String res = service.insert(req);
		
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/update")
	public ResponseEntity<String> mbrCmmCodeUpdate(CustomCmmCodeVO req) {
		String res = service.update(req);
		
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/delete")
	public ResponseEntity<String> mbrCmmCodeDelete(CustomCmmCodeVO req) {
		String res = service.delete(req);
		
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
	
}
