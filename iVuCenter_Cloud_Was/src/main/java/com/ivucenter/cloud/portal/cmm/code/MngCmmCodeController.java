package com.ivucenter.cloud.portal.cmm.code;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value="/mng/cmm/code")
public class MngCmmCodeController{
	
	@Autowired
	CmmCodeService service;
	
	@RequestMapping(value="/")
	public String mngCmmCodeList() {
		
		return "mng/cmm/code/codeList";
	}
	
	@RequestMapping(value="/view")
	public String mngCmmCodeView() {		
		return "mng/cmm/code/codeView";
	}

	@RequestMapping(value="/write")
	public String mngCmmCodeWrite() {	
			
		return "mng/cmm/code/codeWrite";	
	}
	
	@RequestMapping(value="/list", method = RequestMethod.GET)
	public ResponseEntity<String> mngCmmCodeList(CustomCmmCodeVO req) {
		String res = service.list(req);
		
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
	@RequestMapping(value = "/listDetail")
	public ResponseEntity<List<CustomCmmCodeVO>> mngCmmCodelistDetail(CustomCmmCodeVO req) {
		List<CustomCmmCodeVO> res = service.listDetail(req);
		
		return new ResponseEntity<List<CustomCmmCodeVO>>(res, HttpStatus.OK);
	}
	@RequestMapping(value = "/detail")
	public ResponseEntity<CustomCmmCodeVO> mngCmmCodeDetail(CustomCmmCodeVO req) {
		CustomCmmCodeVO res = service.detail(req);
		
		return new ResponseEntity<CustomCmmCodeVO>(res, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/insert")
	public ResponseEntity<String> mngCmmCodeInsert(CustomCmmCodeVO req) {
		String res = service.insert(req);
		
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/update")
	public ResponseEntity<String> mngCmmCodeUpdate(@RequestBody CustomCmmCodeVO req) {
		String res = service.update(req);
		
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/delete")
	public ResponseEntity<String> mngCmmCodeDelete(@RequestBody CustomCmmCodeVO req) {
		String res = service.delete(req);
		
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
	
}
