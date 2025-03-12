package com.ivucenter.cloud.portal.bbs.faq;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
@RequestMapping(value="/mng/bbs/faq")
public class MngBbsFaqController {
	
	@Autowired
	private BbsFaqService service;
	
	/**
	 * FAQ 목록페이지
	 */
	@RequestMapping(value="/")
	public String MngBbsFaqList() {
		return "mng/bbs/faq/bbsFaq";
	}
         
	/**
	 * FAQ 상세페이지
	 */
	@RequestMapping(value="/view")
	public String MngBbsFaqView(Model model, CustomBbsFaqVO req) {
		try{
			model.addAttribute("faqNo", req.getFaqNo());
			String codeKeyId="FAQ_TYPE";
			List<CustomBbsFaqVO> getNoticeBbscodeList = service.getNoticeBbscodeList(codeKeyId);
			model.addAttribute("code", getNoticeBbscodeList);
			
			service.updateHitCount(req);
			return "mng/bbs/faq/bbsFaqView";
		} catch (Exception e) {
			return "redirect:j_spring_security_logout";
		}
	}

	
	/**
	 * FAQ 등록페이지
	 */
	@RequestMapping(value="/write")
	public String MngBbsFaqWrite(Model model, CustomBbsFaqVO req) {
		try{
			String codeKeyId="FAQ_TYPE";
			List<CustomBbsFaqVO> getNoticeBbscodeList = service.getNoticeBbscodeList(codeKeyId);
			
			model.addAttribute("code", getNoticeBbscodeList);
			model.addAttribute("faqNo", req.getFaqNo());
			
			return "mng/bbs/faq/bbsFaqWrite"; 
		} catch (Exception e) {
			return "redirect:j_spring_security_logout";
		}
	}
	
	/**
	 * FAQ 목록조회
	 */
	@RequestMapping(value="/list", method = RequestMethod.POST, produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> MngBbsFaqList(CustomBbsFaqVO req){
		log.info("=== MngBbsFaqList Controller ===");
		
		String res = service.list(req);
		
		if(res.equals("")){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	/**
	 * FAQ 상세조회
	 */
	@RequestMapping(value = "/detail")
	public ResponseEntity<Object> MngBbsFaqDetail(CustomBbsFaqVO req) {
		log.info("=== MngBbsFaqDetail Controller ===");
		log.info("faqNo : " + req.getFaqNo());
		
		CustomBbsFaqVO res = service.detail(req);
		service.updateHitCount(req);

		
		if(res == null){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		
		/*service.updateHitCount(req);*/
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}	
	
	/**
	 * 
	 */
	@RequestMapping(value="/insert", method=RequestMethod.POST)
	public ResponseEntity<String> MngBbsFaqInsert(CustomBbsFaqVO req) {
		String res = "";
		
		if(req.getFaqNo() > 0){
			req.setModUserId(req.getRegUserId());
			res = service.update(req);
		}else{
			res = service.insert(req); 
		}
		
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
	
	
	/**
	 * ����
	 */
	@RequestMapping(value="/delete", method=RequestMethod.POST)
	public ResponseEntity<String> MngBbsFaqDelete(CustomBbsFaqVO req) {
		log.debug("delete"+req.getFaqNo());
		String res = service.delete(req);
		
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}

}
