package com.ivucenter.cloud.portal.bbs.qna;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.ivucenter.cloud.portal.alarms.template.AlarmsTemplateService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value="/mng/bbs/qna")
public class MngBbsQnaController {
	
	@Autowired
	private BbsQnaService service;
	
	
	@Autowired
	private AlarmsTemplateService alarmsTemplateService;
	

	/**
	 * QNA 리스트페이지
	 */
	@RequestMapping(value="/")
	public String MngBbsQnaList(Model model) {
			
		return "mng/bbs/qna/bbsQnaList"; 
		
	}
	
	@RequestMapping(value="/view")
	public String MngBbsQnaView(Model model,CustomBbsQnaVO req) {
		try{			
			
			model.addAttribute("qnaNo", req.getQnaNo());
			String codeKeyId="QNA_TYPE";
			
			List<CustomBbsQnaVO> getNoticeBbscodeList = service.getNoticeBbscodeList(codeKeyId);
			model.addAttribute("code", getNoticeBbscodeList);
			
			return "mng/bbs/qna/bbsQnaView";
		} catch (Exception e) {
			return "redirect:j_spring_security_logout";
		}
	}
	
	@RequestMapping(value="/replywrite")
	public String MngBbsQnaReplyWrite(Model model, CustomBbsQnaVO req) {
		try{
			log.info("=== MngBbsQnaReplyWrite Controller ===");			
			
			String codeKeyId="QNA_TYPE";
			List<CustomBbsQnaVO> getNoticeBbscodeList = service.getNoticeBbscodeList(codeKeyId);
			model.addAttribute("code", getNoticeBbscodeList);
			model.addAttribute("parentQnaNo", req.getParentQnaNo());
	
			return "mng/bbs/qna/bbsQnaReplyWrite";
		} catch (Exception e) {
			return "redirect:j_spring_security_logout";
		}
	}
	//qna ����Ʈ
	@RequestMapping(value="/list", method = RequestMethod.POST, produces="text/plain;charset=UTF-8")
	public ResponseEntity<String> MngBbsQnaList(CustomBbsQnaVO req) {
		log.info("=== MngBbsQnaList Controller ===");
		String res = service.mngList(req);
		
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}	
	
	@RequestMapping(value = "/detail")
	public ResponseEntity<Object> MngBbsQnaDetail(CustomBbsQnaVO req) {
		CustomBbsQnaVO res = service.detail(req);
		
		if(res == null){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/detailReply")
	public ResponseEntity<Object> MbrBbsQnaDetailReply(CustomBbsQnaVO req) {
		CustomBbsQnaVO res = service.detailReply(req);
		if(res == null){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/insert")
	public ResponseEntity<String> MngBbsQnaInsert(CustomBbsQnaVO req) {
		//log.debug("=== req.getSecretFlag() ===" + req.getSecretFlag());
		String res ="";
		if(req.getQnaNo()>0){
			req.setModUserId(req.getRegUserId());
			res = service.update(req); 
		}else{
			res = service.insert(req);
		}
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/insertReply")
	public ResponseEntity<String> MngBbsQnaReplyInsert(CustomBbsQnaVO req) {
		log.debug("=== req.getParentQnaNo() ===" + req.getParentQnaNo());
		String res ="";
		if(req.getQnaNo()>0){
			req.setModUserId(req.getRegUserId());
			res = service.update(req); 
		}else{
			res = service.insert(req);			
		}
		
		Map<String,String> keywordMap = new HashMap<>();
		keywordMap = new HashMap<>();
		keywordMap.put("gbn","60");
		keywordMap.put("url","http://k-cloud.kepco.co.kr/mbr");
		alarmsTemplateService.alarms(60, req.getQnaWriteRegUserId(), keywordMap);
		
		//String res = service.insert(req);
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/update")
	public ResponseEntity<String> MngBbsQnaUpdate(CustomBbsQnaVO req) {
		String res = service.update(req);
		
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/delete")
	public ResponseEntity<String> MngBbsQnaDelete(CustomBbsQnaVO req) {
		String res = service.delete(req);
		
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}	

	@RequestMapping(value = "/noReplyCount", method = { RequestMethod.GET, RequestMethod.POST })
	public ResponseEntity<Object> MngNoReplyCount(CustomBbsQnaVO req) {
		CustomBbsQnaVO res = service.getNoReplyCount(req);
		
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/excel")
	public ModelAndView MngBssQnaExcel(CustomBbsQnaVO req, ModelMap map) {
		map.addAttribute("excel_gbn", "qna");
		map.addAttribute("excel_title", "고객센터_Q&A");
		map.addAttribute("excel_list", service.excel(req));
		return new ModelAndView("bBsMenuExcelView", map);
	}	
}
