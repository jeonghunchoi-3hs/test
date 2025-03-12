package com.ivucenter.cloud.portal.alarms.withkepco.history;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.ivucenter.cloud.portal.alarms.withkepco.CustomWithKepcoVO;
import com.ivucenter.cloud.portal.alarms.withkepco.WithKepcoService;


@Controller
@RequestMapping(value="/mng/kepco/history")
public class WithKepcoHistoryController {
	
	@Autowired
	WithKepcoService service;
	
	@RequestMapping(value="/list", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public ResponseEntity<String> mngKepcoQueueHistoryList(CustomWithKepcoVO req) {
		String res = service.list(req);		
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/excel")
	public ModelAndView mngMailQueueHistoryExcel(CustomWithKepcoVO req, ModelMap map) {
		map.addAttribute("excel_gbn", "kepcoHistory");
		map.addAttribute("excel_title", "알람관리_결재시스템 발송이력");
		map.addAttribute("excel_list", service.excel(req));
		return new ModelAndView("alarmsExcelView", map);
	}	
}
