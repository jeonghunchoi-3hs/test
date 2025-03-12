package com.ivucenter.cloud.portal.bbs.notice;

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
@RequestMapping(value="/mbr/bbs/notice")
public class MbrBbsNoticeController {
	
	private String codeKeyId = "NOTICE_TYPE";
	
	@Autowired
	private BbsNoticeService service;

	
	/**
	 * 공지사항 화면
	 */
	@RequestMapping(value="/")
	@Secured( {"ROLE_CUSTOM_ADMIN","ROLE_CUSTOM_USER", "ROLE_CUSTOM_PM"} )
	public String mbrBbsNotice(Model model, CustomBbsNoticeVO req) {
			
		model.addAttribute("noticeNo", req.getNoticeNo());
		return "mbr/bbs/notice/bbsNoticeList";
	}
	
	/**
	 * 공지사항 상세화면
	 */
	@RequestMapping(value="/view")
	@Secured( {"ROLE_CUSTOM_ADMIN","ROLE_CUSTOM_USER", "ROLE_CUSTOM_PM"} )
	public String mbrBbsNoticeView(Model model, CustomBbsNoticeVO req) {
		try{
			List<CustomBbsNoticeVO> bbsCodeList = service.getBbsCodeList(codeKeyId);
			model.addAttribute("code", bbsCodeList);
			model.addAttribute("noticeNo", req.getNoticeNo());
			
			return "mbr/bbs/notice/bbsNoticeView";
		} catch (Exception e) {
			return "redirect:j_spring_security_logout";
		}
	}
	
	/**
	 * 공지사항 조회수 update
	 */
	@RequestMapping(value="/updateHitCount")
	public ResponseEntity<String> updateHitCount(Model model, CustomBbsNoticeVO req) {

		String res = "1";
		try{
			service.updateHitCount(req);
		}catch(Exception e){
			res = "0";
		}
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
	
	/**
	 * 공지사항 목록 조회
	 */
	@RequestMapping(value="/list", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> mbrBbsNoticeList(CustomBbsNoticeVO req){
		
		String res = service.list(req);
		
		if(res.equals("")){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	/**
	 * 공지사항 상세조회
	 */
	@RequestMapping(value = "/detail", method = RequestMethod.GET)
	public ResponseEntity<Object> mbrBbsNoticeDetail(CustomBbsNoticeVO req) {
		log.info("=== bbsNoticeDetail Controller ===");
		log.info("noticeNo : " + req.getNoticeNo());
		
		CustomBbsNoticeVO res = service.detail(req);
		service.updateHitCount(req);
		
		if(res == null){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}	
	
	/**
	 * 공지사항 삭제
	 */
	@RequestMapping(value="/delete", method=RequestMethod.POST)
	public ResponseEntity<String> mbrBbsNoticeDelete(CustomBbsNoticeVO req) {
		log.info("delete"+req.getNoticeNo());
		String res = service.delete(req);
		
		log.debug("res : " + res);
		
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
	
	/**
	 * 대시보드 표시용 최근 공지사항조회
	 */
	@RequestMapping(value = "/getCurrentNotice")
	public ResponseEntity<Object> getCurrentNotice(CustomBbsNoticeVO req) {
		log.info("=== getCurrentNotice Controller ===");
		
		CustomBbsNoticeVO res = service.getCurrentNotice(req);
		
		if(res == null){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}
}
