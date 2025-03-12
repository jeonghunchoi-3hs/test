package com.ivucenter.cloud.portal.alarms.template.reservedword;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping(value="/mng/template/reserved/word")
public class MngTemplateReservedWordController{
	
	@Autowired
	private TemplateReservedWordService service;
	
	/**
	 *	ACTION 
	 */	
	@RequestMapping(value="/list", method = RequestMethod.GET)
	public ResponseEntity<List<CustomTemplateReservedWordVO>> mngSmsTemplateList(CustomTemplateReservedWordVO req) {
		List<CustomTemplateReservedWordVO> res = service.list(req);
		return new ResponseEntity<List<CustomTemplateReservedWordVO>>(res, HttpStatus.OK);
	}	
}
