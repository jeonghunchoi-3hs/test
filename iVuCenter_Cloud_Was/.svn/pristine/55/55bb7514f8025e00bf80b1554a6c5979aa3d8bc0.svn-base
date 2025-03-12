package com.ivucenter.cloud.portal.bbs.faq;

import java.util.List;

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
@RequestMapping(value="/mbr/bbs/faq")
public class MbrBbsFaqController {
	
	@Autowired
	private BbsFaqService service;
	
		
	/**
	 * faq 화면
	 */
	@RequestMapping(value="/")
	@Secured( {"ROLE_CUSTOM_ADMIN","ROLE_CUSTOM_USER", "ROLE_CUSTOM_PM"} )
	public String mbrBbsFaqList(Model model) {
		try{	
			
		    String delflag = "N";
			List<CustomBbsFaqVO> customBbsFaqVO = service.faqList(delflag);
			
			
			model.addAttribute("faqList", customBbsFaqVO);
	
			String codeKeyId="FAQ_TYPE";
			List<CustomBbsFaqVO> getNoticeBbscodeList = service.getNoticeBbscodeList(codeKeyId);
			model.addAttribute("code", getNoticeBbscodeList);
			
			return "mbr/bbs/faq/faq";
		} catch (Exception e) {
			return "redirect:j_spring_security_logout";
		}
	}
	
	
	/**
	 * 상세 화면 
	 */
	@RequestMapping(value="/view")
	@Secured( {"ROLE_CUSTOM_ADMIN","ROLE_CUSTOM_USER", "ROLE_CUSTOM_PM"} )
	public String mbrBbsFaqView(Model model, CustomBbsFaqVO req) {
		try{
			String codeKeyId="FAQ_TYPE";
			List<CustomBbsFaqVO> getNoticeBbscodeList = service.getNoticeBbscodeList(codeKeyId);
			model.addAttribute("code", getNoticeBbscodeList);
			model.addAttribute("faqNo", req.getFaqNo());
			return "mbr/bbs/faq/faqView";
		} catch (Exception e) {
			log.error("Exception : " +e.getMessage());
			return "redirect:j_spring_security_logout";
		}
	}

	/**
	 * 목록조회
	 */
	@RequestMapping(value="/list", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> mbrBbsFaqList(CustomBbsFaqVO req){
		
		String res = service.list(req);
		
		if(res.equals("")){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	/**
	 * 상세
	 */
	@RequestMapping(value = "/detail")
	public ResponseEntity<Object> mbrBbsFaqDetail(CustomBbsFaqVO req) {
		CustomBbsFaqVO res = service.detail(req);
		
		if(res == null){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		
		//service.updateHitCount(req);
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}	
	
	/**
	 * 삭제
	 */
	@RequestMapping(value="/delete", method=RequestMethod.POST)
	public ResponseEntity<String> mbrBbsFaqDelete(CustomBbsFaqVO req) {
		String res = service.delete(req);
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}

}
