package com.ivucenter.cloud.portal.cmm.cloud;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ivucenter.cloud.portal.cmm.customer.CustomCmmCustomerVO;
import com.ivucenter.cloud.portal.cmm.user.CmmUserService;
import com.ivucenter.cloud.portal.cmm.user.CustomCmmUserVO;
import com.ivucenter.cloud.portal.login.UserSession;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value="/mng/cmm/cloud")
public class MngOssCloudController {

	@Autowired
	private OssCloudService service;
	@Autowired
	private CmmUserService userService;


	@RequestMapping(value="/")
	public String MngCloud() {
		try {
			log.debug("MngOssCloudController:mngCloudList()");

			return "mng/cmm/cloud/cloudList";

		} catch (Exception e) {
			return "redirect:j_spring_security_logout";
		}
	}

	@RequestMapping(value="/list", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> MngCloudList(CustomOssCloudVO req){

		String res = service.list(req);

		if(res.equals("")){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	@RequestMapping(value="/write")
	public String MngBbsFaqWrite(Model model, CustomOssCloudVO req) {
		try{
			model.addAttribute("cloudId", req.getCloudId());

			return "mng/cmm/cloud/cloudWrite";
		} catch (Exception e) {
			return "redirect:j_spring_security_logout";
		}
	}

	@RequestMapping(value="/insert", method=RequestMethod.POST)
	public ResponseEntity<String> MngBbsFaqInsert(CustomOssCloudVO req) {
		CustomCmmCustomerVO customCmmCustomerVO = new CustomCmmCustomerVO();
		
		
		String res = "";
        UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
  		req.setRegUserId(userSession.getUsername());
  		req.setCloudId(UUID.randomUUID().toString());
		res = service.insert(req);	
		
		List<CustomOssCloudVO> cloudList = service.getCloudList();

		StringBuffer subnetAllocationPoolStr = new StringBuffer();

 		for(int i = 0; i < cloudList.size(); i++) {
 			customCmmCustomerVO.setCloudCountSeq(i+1);
 			customCmmCustomerVO =	userService.selectUserCloudCuthority(customCmmCustomerVO);
	 			if(customCmmCustomerVO.getCloudUserAuthority() == null || customCmmCustomerVO.getCloudUserAuthority().equals("")) {
	 	 			subnetAllocationPoolStr.append("0");
	 			}
 		   }
 			String userCloudAuths = subnetAllocationPoolStr.toString();
 			CustomCmmUserVO customCmmUserVO = new CustomCmmUserVO();
 			customCmmUserVO.setUserCloudAuths(userCloudAuths);
 			userService.userCloudAuthupdate(customCmmUserVO);
 			
 		
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}


	@RequestMapping(value="/update", method=RequestMethod.POST)
	public ResponseEntity<String> MngCloudUpdate(CustomOssCloudVO req) {
		String res = "";
        UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
  		req.setModUserId(userSession.getUsername());
		res = service.update(req);

		return new ResponseEntity<String>(res, HttpStatus.OK);
	}


	@RequestMapping(value="/view")
	public String MngBbsFaqView(Model model, CustomOssCloudVO req) {
		try{

			model.addAttribute("cloudId", req.getCloudId());

			return "mng/cmm/cloud/cloudView";
		} catch (Exception e) {
			return "redirect:j_spring_security_logout";
		}
	}

	@RequestMapping(value = "/detail")
	public ResponseEntity<Object> MngBbsFaqDetail(CustomOssCloudVO req) {

		CustomOssCloudVO res = service.detail(req);

		if(res == null){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}

		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	@RequestMapping(value="/delete", method=RequestMethod.POST)
	public ResponseEntity<String> MngBbsFaqDelete(CustomOssCloudVO req) {

        UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
  		req.setModUserId(userSession.getUsername());
		String res = service.delete(req);

		return new ResponseEntity<String>(res, HttpStatus.OK);
	}

}
