package com.ivucenter.cloud.portal.cmm.license;

import java.util.Date;

import org.apache.commons.lang.RandomStringUtils;
import org.apache.commons.lang.time.DateFormatUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ivucenter.cloud.portal.cmm.customer.CustomCmmCustomerVO;
import com.ivucenter.cloud.portal.login.UserSession;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value="/mng/cmm/license")
public class MngOssLicenseController {
	
	
	@Autowired
	OssLicenseService service;
	
	@RequestMapping(value="/")
	public String MngLicense() {
		try {
			return "mng/cmm/license/licenseList";

		} catch (Exception e) {
			return "redirect:j_spring_security_logout";
		}
	}
	
	@RequestMapping(value="/list", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> MngLicenseList(CustomOssLicenseVO req){

		String res = service.list(req);

		if(res.equals("")){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}
	
	@RequestMapping(value="/detailList", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> MngLicenseDetailList(CustomOssLicenseVO req){

		String res = service.detailList(req);

		if(res.equals("")){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}
	
	@RequestMapping(value="/write")
	public String licenseWrite(Model model, CustomOssLicenseVO req) {
		try{
			CustomOssLicenseVO res = new CustomOssLicenseVO();
			if(!StringUtils.isEmpty(req.getLicenseId())) {
				res = service.view(req);
			}
			
			model.addAttribute("licenseInfo", res);
			return "mng/cmm/license/licenseWrite";
		} catch (Exception e) {
			return "redirect:j_spring_security_logout";
		}
	}
	
	@RequestMapping(value="/insert", method=RequestMethod.POST)
	public ResponseEntity<String> licenseInsert(CustomOssLicenseVO req) {
		CustomCmmCustomerVO customCmmCustomerVO = new CustomCmmCustomerVO();
		
		
		String res = "";
		
        UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        final String seq = DateFormatUtils.format(new Date(), "yyyyMMddHH") + RandomStringUtils.randomNumeric(5);
        req.setRegUserId(userSession.getUsername());
        req.setLicenseId(seq);
		res = service.insert(req);	
 		
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
	
	@RequestMapping(value="/view")
	public String licenseView(Model model, CustomOssLicenseVO req) {
		try{
			CustomOssLicenseVO res = service.view(req);
			model.addAttribute("licenseInfo", res);
			model.addAttribute("licenseId", req.getLicenseId());
			
			return "mng/cmm/license/licenseView";
		} catch (Exception e) {
			return "redirect:j_spring_security_logout";
		}
	}
	
	@RequestMapping(value="/detailView")
	public String licenseDetailView(Model model, CustomOssLicenseVO req) {
		try{
			CustomOssLicenseVO res = service.detailView(req);
			model.addAttribute("licenseInfo", res);
			model.addAttribute("licenseDetailId", req.getLicenseDetailId());
			
			return "mng/cmm/license/licenseDetailView";
		} catch (Exception e) {
			return "redirect:j_spring_security_logout";
		}
	}
	
	@RequestMapping(value="/detailWrite")
	public String detailWrite(Model model, CustomOssLicenseVO req) {
		try {
			CustomOssLicenseVO res = new CustomOssLicenseVO();
			if(!StringUtils.isEmpty(req.getLicenseDetailId())) {
				res = service.detailView(req);
			}
			model.addAttribute("licenseId", req.getLicenseId());
			model.addAttribute("licenseDetailId", req.getLicenseDetailId());
			model.addAttribute("licenseInfo", res);
			return "mng/cmm/license/licenseDetailWrite";
		} catch(Exception e) {
			return "redirect:j_spring_security_logout";
		}
	}
	
	@RequestMapping(value="/detailInsert")
	public ResponseEntity<String> licenseDetailInsert(CustomOssLicenseVO req) {
		CustomCmmCustomerVO customCmmCustomerVO = new CustomCmmCustomerVO();
		String res = "";
        UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        final String seq = DateFormatUtils.format(new Date(), "yyyyMMddHH") + RandomStringUtils.randomNumeric(5);
        req.setDetailRegUserId(userSession.getUsername());
        req.setLicenseDetailId(seq);
        
		res = service.detailInsert(req);	
 		
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
	
	@RequestMapping(value="/update", method=RequestMethod.POST)
	public ResponseEntity<String> MngLicenseUpdate(CustomOssLicenseVO req) {
		String res = "";
        UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
  		req.setModUserId(userSession.getUsername());
		res = service.update(req);

		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
	
	@RequestMapping(value="/detailUpdate", method=RequestMethod.POST)
	public ResponseEntity<String> MngLicenseDetailUpdate(CustomOssLicenseVO req) {
		String res = "";
        UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
  		req.setDetailRegUserId(userSession.getUsername());
		res = service.detailUpdate(req);

		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
	
	@RequestMapping(value="/delete", method=RequestMethod.POST)
	public ResponseEntity<String> MngLicenseDelete(CustomOssLicenseVO req) {

        UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
  		req.setModUserId(userSession.getUsername());
		String res = service.delete(req);

		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
	
	@RequestMapping(value="/detailDelete", method=RequestMethod.POST)
	public ResponseEntity<String> MngLicenseDetailDelete(CustomOssLicenseVO req) {

        UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
  		req.setModUserId(userSession.getUsername());
		String res = service.detailDelete(req);

		return new ResponseEntity<String>(res, HttpStatus.OK);
	}

}
