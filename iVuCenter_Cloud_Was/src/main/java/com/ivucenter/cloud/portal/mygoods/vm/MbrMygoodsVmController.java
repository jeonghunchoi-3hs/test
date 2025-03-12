package com.ivucenter.cloud.portal.mygoods.vm;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value="/mbr/myGoods/vm")
public class MbrMygoodsVmController {
	
	@Autowired
	private MygoodsVmService service;


	// 나의상품 VM 목록 화면
	@RequestMapping(value="/")
	@Secured( {"ROLE_CUSTOM_ADMIN", "ROLE_CUSTOM_USER", "ROLE_CUSTOM_PM"} )
	public String myVmListPage(Model model){
		log.debug("MbrMygoodsVmController:myVmListPage()");
		return "mbr/myGoods/vm/myVmList";
	}
	
	
	// 나의상품 VM 목록 조회
	@RequestMapping(value="/myVmList", method = RequestMethod.GET)
	public ResponseEntity<String> getMyVmList(CustomMygoodsVmVO req, Principal principal){		
		
		req.setUserId(principal.getName());
		String res = service.list(req);
		
		if(res.equals("")){
			return new ResponseEntity<String>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
	
	
	// 나의상품 VM 상세 화면
	@RequestMapping(value="/view")
	public String myVmView(Model model, CustomMygoodsVmVO req){
		
		return "";
	}
	
	
}
