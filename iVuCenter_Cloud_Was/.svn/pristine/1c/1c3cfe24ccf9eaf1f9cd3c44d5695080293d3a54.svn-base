package com.ivucenter.cloud.portal.alarms.withkepco.template;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ivucenter.cloud.portal.alarms.withkepco.CustomWithKepcoVO;
import com.ivucenter.cloud.portal.alarms.withkepco.WithKepcoService;

@Controller
@RequestMapping(value="/mng/kepco/template")
public class WithKepcoTemplateController {
	
	@Autowired
	WithKepcoService service;
	
	@RequestMapping(value = "/detail")
	public ResponseEntity<CustomWithKepcoVO> mngMailTemplateDetail(@RequestParam String alarmSeq) {
		CustomWithKepcoVO res = service.detail(alarmSeq);
		return new ResponseEntity<CustomWithKepcoVO>(res, HttpStatus.OK);
	}
	
	

}
