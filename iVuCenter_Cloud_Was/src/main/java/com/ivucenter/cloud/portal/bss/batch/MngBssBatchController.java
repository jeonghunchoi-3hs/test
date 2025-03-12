package com.ivucenter.cloud.portal.bss.batch;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value="/mng/bss/batch")
public class MngBssBatchController {
	
	@Autowired
	private BssBatchService service;
	
	/**
	 * 배치관리 목록화면
	 */
	@RequestMapping(value="/")
	public String getBatchListPage() {	
		log.debug("MngBssBatchController:getBatchListPage()");
		return "mng/bss/batch/batchList";
	}
	
	/**
	 * 배치관리 수정화면
	 */
	@RequestMapping(value="/updatePage")
	public String getBatchUpdatePage(HttpServletRequest request, Model model){
		model.addAttribute("jobName", request.getParameter("jobName"));		
		return "mng/bss/batch/batchUpdate";
	}

	/**
	 * 배치관리 등록화면
	 */
	@RequestMapping(value="/writePage")
	public String getBatchWritePage(){		
		return "mng/bss/batch/batchInsert";
	}
	
	/**
	 * 배치관리 목록조회
	 */
	@RequestMapping(value="/list")
	public ResponseEntity<Object> batchList(CustomBssBatchVO req){
		String res = service.bssBatchList(req);		
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	/**
	 * 배치관리 목록조회
	 */
	@RequestMapping(value="/detail")
	public ResponseEntity<Object> bssBatchDetail(CustomBssBatchVO req){
		CustomBssBatchVO res = service.bssBatchDetail(req);		
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}
	
	/**
	 * 배치관리 수정
	 */
	@RequestMapping(value="/update")
	public ResponseEntity<Object> batchUpdate(CustomBssBatchVO req){
		String res = service.bssBatchUpdate(req);		
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	/**
	 * 배치관리 등록
	 */
	@RequestMapping(value="/write")
	public ResponseEntity<Object> batchWrite(CustomBssBatchVO req){
		String res = service.bssBatchInsert(req);		
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	/**
	 * 배치관리 삭제
	 */
	@RequestMapping(value="/delete")
	public ResponseEntity<Object> batchDelete(CustomBssBatchVO req){
		String res = service.bssBatchDelete(req);
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}	
}
