package com.ivucenter.cloud.portal.bbs.qna;

import java.security.Principal;
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
@RequestMapping(value="/mbr/bbs/qna")
public class MbrBbsQnaController {

	@Autowired
	private BbsQnaService service;
	
	@RequestMapping(value="/")
	@Secured( {"ROLE_CUSTOM_ADMIN", "ROLE_CUSTOM_USER", "ROLE_CUSTOM_PM"} )
	public String MbrBbsQnaList(Model model,CustomBbsQnaVO req) {
		try{
			
			String codeKeyId="QNA_TYPE";
			List<CustomBbsQnaVO> getNoticeBbscodeList = service.getNoticeBbscodeList(codeKeyId);
			model.addAttribute("qnaType", getNoticeBbscodeList);
			model.addAttribute("qnaNo", req.getQnaNo());
			
			return "mbr/bbs/qna/qnaList";
		} catch (Exception e) {
			log.error(e.getMessage());
			return "redirect:j_spring_security_logout";
		}
	}
	
	@RequestMapping(value="/view")
	@Secured( {"ROLE_CUSTOM_ADMIN", "ROLE_CUSTOM_USER", "ROLE_CUSTOM_PM"} )
	public String MbrBbsQnaView(Model model,CustomBbsQnaVO req) {
		try{
			String codeKeyId="QNA_TYPE";
			List<CustomBbsQnaVO> getNoticeBbscodeList = service.getNoticeBbscodeList(codeKeyId);
	//		CustomBbsQnaVO qnaVo = service.detailReply(req);
			
			
			CustomBbsQnaVO res = service.detail(req);
			model.addAttribute("code", getNoticeBbscodeList);
			model.addAttribute("qnaNo", req.getQnaNo());
			model.addAttribute("regUserId", res.getRegUserId());
	//		model.addAttribute("replyRegId", qnaVo.getRegUserId());
			
	//		if(!qnaVo.getRegUserId().equals(null)||!qnaVo.getRegUserId().equals("")){
	//			model.addAttribute("regUserId", qnaVo.getRegUserId());
	//		}
			
			return "mbr/bbs/qna/qnaView";
		} catch (Exception e) {
			log.error(e.getMessage());
			return "redirect:j_spring_security_logout";
		}
	}

	@RequestMapping(value="/write")
	public String MbrBbsQnaWrite(Model model, CustomBbsQnaVO req) {
		try{
			
			String codeKeyId="QNA_TYPE";
			List<CustomBbsQnaVO> getNoticeBbscodeList = service.getNoticeBbscodeList(codeKeyId);
			model.addAttribute("code", getNoticeBbscodeList);
			model.addAttribute("qnaNo", req.getQnaNo());
			log.debug("=== qnaform ===");
	
			return "mbr/bbs/qna/qnaWrite"; 
		} catch (Exception e) {
			log.error(e.getMessage());
			return "redirect:j_spring_security_logout";
		}
	}
	
	@RequestMapping(value="/replywrite")
	public String MbrBbsQnaReplyWrite(Model model, CustomBbsQnaVO req) {
		try{
			
			String codeKeyId="QNA_TYPE";
			List<CustomBbsQnaVO> getNoticeBbscodeList = service.getNoticeBbscodeList(codeKeyId);
			model.addAttribute("code", getNoticeBbscodeList);
			model.addAttribute("parentQnaNo", req.getQnaNo());
			log.debug("=== qnaform ===");
	
			return "mbr/bbs/qna/qnaReplyWrite"; 
		} catch (Exception e) {
			log.error(e.getMessage());
			return "redirect:j_spring_security_logout";
		}
	}
	
	
	//qna ����Ʈ
	@RequestMapping(value="/list", method = RequestMethod.GET , produces="text/plain;charset=UTF-8")
	public ResponseEntity<String> MbrBbsQnaList(CustomBbsQnaVO req) {
		String res = service.list(req);
		
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}	
	
	@RequestMapping(value = "/detail")
	public ResponseEntity<Object> MbrBbsQnaDetail(CustomBbsQnaVO req) {
		CustomBbsQnaVO res = service.detail(req);
		
		if(res == null){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/detailReply")
	public ResponseEntity<Object> MbrBbsQnaDetailReply(CustomBbsQnaVO req) {
		//log.debug("=== getParentQnaNo ==="+req.getParentQnaNo());
		
		CustomBbsQnaVO res = service.detailReply(req);
		if(res == null){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/insert")
	public ResponseEntity<String> MbrBbsQnaInsert(CustomBbsQnaVO req) {
		//log.debug("=== req.getSecretFlag() ===" + req.getSecretFlag());
		String res ="";
		if(req.getQnaNo()>0){
			req.setModUserId(req.getRegUserId());
			res = service.update(req); 
		}else{
			res = service.insert(req);
			//res = service.update(req);
		}
		//String res = service.insert(req);
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/insertReply")
	public ResponseEntity<String> MbrBbsQnaReplyInsert(CustomBbsQnaVO req, Principal principal) {
		log.debug("=== req.getParentQnaNo() ===" + req.getParentQnaNo());
		
		req.setRegUserId(principal.getName());
		String res ="";
		if(req.getQnaNo()>0){
			req.setModUserId(req.getRegUserId());
			res = service.update(req); 
		}else{
			res = service.insert(req);			
		}
		//String res = service.insert(req);
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/update")
	public ResponseEntity<String> MbrBbsQnaUpdate(CustomBbsQnaVO req, Model model) {
		String res = service.update(req);
		
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/delete")
	public ResponseEntity<String> MbrBbsQnaDelete(CustomBbsQnaVO req) {
		String res = service.delete(req);
		
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}	

}
