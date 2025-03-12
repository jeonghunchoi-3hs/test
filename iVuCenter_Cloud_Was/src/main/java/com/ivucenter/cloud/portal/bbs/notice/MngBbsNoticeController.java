package com.ivucenter.cloud.portal.bbs.notice;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value="/mng/bbs/notice")
public class MngBbsNoticeController {
	
	@Autowired
	private BbsNoticeService service;

	@RequestMapping(value="/")
	public String mngBbsNotice() {		
		return "mng/bbs/notice/bbsNoticeList";

		
	}
	
	@RequestMapping(value="/view")
	public String mngBbsNoticeView(Model model, CustomBbsNoticeVO req) {
		try{			
			model.addAttribute("noticeNo", req.getNoticeNo());
			
			String codeKeyId="NOTICE_TYPE";			
			List<CustomBbsNoticeVO> getNoticeBbscodeList = service.getNoticeBbscodeList(codeKeyId);
			model.addAttribute("code", getNoticeBbscodeList);
			
			return "mng/bbs/notice/bbsNoticeView";
		} catch (Exception e) {
			return "redirect:j_spring_security_logout";
		}
	}

	@RequestMapping(value="/write")
	public String mngBbsNoticeWrite(Model model, CustomBbsNoticeVO req) {
		try{
			String codeKeyId="NOTICE_TYPE";
			List<CustomBbsNoticeVO> getNoticeBbscodeList = service.getNoticeBbscodeList(codeKeyId);
			
			model.addAttribute("code", getNoticeBbscodeList);
			model.addAttribute("noticeNo", req.getNoticeNo());
			
			return "mng/bbs/notice/bbsNoticeWrite"; 
		} catch (Exception e) {
			return "redirect:j_spring_security_logout";
		}
	}
	
	@RequestMapping(value="/list", method = RequestMethod.POST, produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> mngBbsNoticeList(CustomBbsNoticeVO req){
		String res = service.list(req);
		
		if(res.equals("")){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	@RequestMapping(value = "/detail", method = RequestMethod.GET)
	public ResponseEntity<Object> mngBbsNoticeDetail(CustomBbsNoticeVO req) {
		log.debug("=== mngBbsNoticeDetail Controller ===");
		log.debug("noticeNo : " + req.getNoticeNo());
		
		CustomBbsNoticeVO res = service.detail(req);
		service.updateHitCount(req);
		
		if(res == null){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}	
	
	@RequestMapping(value="/insert", method=RequestMethod.POST)
	public ResponseEntity<String> mngBbsNoticeInsert(CustomBbsNoticeVO req) {
		log.debug("=== mngBbsNoticeInsert Controller ===");
		String res = "";
		
		if(req.getNoticeNo() > 0){
			req.setModUserId(req.getRegUserId());
			res = service.update(req);
		}else{
			
			res = service.insert(req); 
		}
		
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
	
	
	@RequestMapping(value="/delete", method=RequestMethod.POST)
	public ResponseEntity<String> mngBbsNoticeDelete(CustomBbsNoticeVO req) {
		log.debug("=== mngBbsNoticeDelete Controller ===");
		log.debug("delete"+req.getNoticeNo());
		String res = service.delete(req);
		
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
	
	/**
	 * 대시보드 표시용 최근 공지사항조회
	 */
	@RequestMapping(value = "/getCurrentNotice")
	public ResponseEntity<Object> getCurrentNotice(CustomBbsNoticeVO req) {
		log.debug("=== getCurrentNotice Controller ===");
		
		CustomBbsNoticeVO res = service.getCurrentNotice(req);
		
		if(res == null){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}	

	@RequestMapping(value = "/excel")
	public ModelAndView MngBssNoticeExcel(CustomBbsNoticeVO req, ModelMap map) {
		map.addAttribute("excel_gbn", "notice");
		map.addAttribute("excel_title", "고객센터_공지사항");
		map.addAttribute("excel_list", service.excel(req));
		return new ModelAndView("bBsMenuExcelView", map);
	}	
}
