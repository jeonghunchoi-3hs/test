package com.ivucenter.cloud.portal.oss.project;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.ivucenter.cloud.portal.login.UserSession;

@Controller
@RequestMapping(value="/mbr/oss/project")
public class MbrOssProjectController {

	@Autowired
	private OssProjectService service;

	/**
	 *	ACTION
	 */
//	@RequestMapping(value="/servicelist", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
//	public ResponseEntity<Object> MbrServicelist(CustomOssProjectVO req){
//		String res = service.servicelist(req);
//
//		if(res.equals("")){
//			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
//		}
//		log.debug(res);
//		return new ResponseEntity<Object>(res, HttpStatus.OK);
//	}

	@RequestMapping(value="/projectServiceList", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> mbrProjectServiceList(CustomOssProjectVO req){

		UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		req.setUserId(userSession.getUsername());

		String res = service.mbrProjectServiceList(req);

		if(res.equals("")){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}


	/**
	 *	ACTION
	 */
	@RequestMapping(value="/mbrList", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> MbrUserOssProjectList(CustomOssProjectVO req){
		String res = service.mbrList(req);

		if(res.equals("")){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	/**
	 *	ACTION
	 */
	@RequestMapping(value="/mbrAppList", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> MbrUserOssProjectAppList(CustomOssProjectVO req){
		String res = service.mbrAppList(req);

		if(res.equals("")){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	/**
	 *	ACTION
	 */
	@RequestMapping(value="/mbrNasAppList", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> MbrUserOssProjectNasAppList(CustomOssProjectVO req){
		String res = service.mbrNasAppList(req);

		if(res.equals("")){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	@RequestMapping(value="/mbrFsList", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> MbrUserOssProjectFsList(CustomOssProjectVO req){
		String res = service.mbrFsList(req);

		if(res.equals("")){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	/**
	 *	ACTION
	 */
	@RequestMapping(value="/list", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> MbrOssProjectList(CustomOssProjectVO req){
		String res = service.list(req);

		if(res.equals("")){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}



	@RequestMapping(value = "/mbrOssVmExcel")
	public ModelAndView MbrOssVmExcel(CustomOssProjectVO req, ModelMap map) {

        UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		req.setUserId(userSession.getUsername());

		map.addAttribute("excel_gbn", "mbrVm");
		map.addAttribute("excel_title", "사용자포털_가상서버");
		map.addAttribute("excel_list", service.mbrExcel(req));

		return new ModelAndView("ossProjectExcelView", map);
	}

	@RequestMapping(value = "/mbrOssDiskExcel")
	public ModelAndView mbrOssDiskExcel(CustomOssProjectVO req, ModelMap map) {

        UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		req.setUserId(userSession.getUsername());

		map.addAttribute("excel_gbn", "mbrDisk");
		map.addAttribute("excel_title", "사용자포털_블록디스크");
		map.addAttribute("excel_list", service.mbrExcel(req));

		return new ModelAndView("ossProjectExcelView", map);
	}

	@RequestMapping(value = "/mbrOssServiceExcel")
	public ModelAndView mbrOssServiceExcel(CustomOssProjectVO req, ModelMap map) {

        UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		req.setUserId(userSession.getUsername());

		map.addAttribute("excel_gbn", "mbrService");
		map.addAttribute("excel_title", "사용자포털_서비스");
		map.addAttribute("excel_list", service.mbrServiceExcel(req));

		return new ModelAndView("ossProjectExcelView", map);
	}

	@RequestMapping(value = "/mbrOssPvExcel")
	public ModelAndView mbrOssPvExcel(CustomOssProjectVO req, ModelMap map) {

        UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		req.setUserId(userSession.getUsername());

		map.addAttribute("excel_gbn", "mbrPv");
		map.addAttribute("excel_title", "사용자포털_PV");
		map.addAttribute("excel_list", service.mbrPvExcel(req));

		return new ModelAndView("ossProjectExcelView", map);
	}


	@RequestMapping(value = "/detail")
	public ResponseEntity<Object> MbrOssProjectDetail(CustomOssProjectVO req, Model model) {
		CustomOssProjectVO res = service.boxDetail(req);

		res.setManagerPhone(res.getManagerPhoneDec());
		res.setManagerTel(res.getManagerTelDec());

		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}
}
