package com.ivucenter.cloud.portal.application.env;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.ivucenter.cloud.portal.oss.application.OssAppService;
import com.ivucenter.cloud.portal.oss.project.CustomOssProjectVO;
import com.ivucenter.cloud.portal.req.product.CustomReqProductVO;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
@RequestMapping(value="/mng/application/env")
public class mngEnvAppController {

	@Autowired
	OssAppService service;

	@RequestMapping(value="/envList")
	public String MngProjectEnv(Model model) {
		return "mng/application/env/projectEnv_list";
	}

	@RequestMapping(value="/envView")
	public String MngProjectServiceView(Model model, CustomOssProjectVO req) {
		model.addAttribute("req", req);
		return "mng/application/env/projectEnv_view";
	}

	@RequestMapping(value = "/envViewExcel")
	public ModelAndView MngEnvViewExcel(CustomReqProductVO req, ModelMap map) {
		map.addAttribute("excel_gbn", "envView");
		map.addAttribute("excel_title", "개발환경_상세");
		map.addAttribute("excel_list", service.envViewExcel(req));
		return new ModelAndView("productExcelView", map);
	}

	@RequestMapping(value="/prodList")
	public String MngProdList(Model model) {
		return "mng/application/env/prodEnv_list";
	}

	@RequestMapping(value="/projectEnvList", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> MbrUserOssProjectEnvList(CustomReqProductVO req){
		String res = service.projectEnvList(req);
		if(res.equals("")){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

}
