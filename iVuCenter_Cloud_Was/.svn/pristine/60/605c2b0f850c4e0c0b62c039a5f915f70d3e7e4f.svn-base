package com.ivucenter.cloud.portal.cmm.department;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value="/mng/cmm/department")
public class MngCmmDepartmentController {
	
	@Autowired
	private CmmDepartmentService service;
	
	@RequestMapping(value="/")
	public String MngCmmDepartment() {
		return "mng/cmm/department/cmmDepartment_list";
	}
	
	/**
	 * ACTION
	 */
	@RequestMapping(value = "/list")
	public ResponseEntity<String> MngCmmDepartmentList(CustomCmmDepartmentVO req) {
		return new ResponseEntity<String>(service.list(req), HttpStatus.OK);
	}
	
	@RequestMapping(value = "/listAll", produces="text/plain;charset=UTF-8")
	public ResponseEntity<String> MngCmmDepartmentListAll() {
		return new ResponseEntity<String>(service.listAll(), HttpStatus.OK);
	}
	
	@RequestMapping(value = "/TreeAll", produces="text/plain;charset=UTF-8")
	public ResponseEntity<String> MngCmmDepartmentTreeAll(CustomCmmDepartmentVO req) {
		String res = service.TreeAll(req);
		if(StringUtils.isBlank(res)) {
			return new ResponseEntity<String>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
}
