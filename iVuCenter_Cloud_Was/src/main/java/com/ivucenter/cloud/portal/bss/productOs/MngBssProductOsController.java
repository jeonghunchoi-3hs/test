package com.ivucenter.cloud.portal.bss.productOs;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value="/mng/bss/productOs")
public class MngBssProductOsController {

	@Autowired
	private MngBssProductOsService mngBssProductOsService;
	
	/**
	 * 이미지 관리 페이지 (화면)
	 */	
	@RequestMapping(value="/")
	public String mngBbsFaqList() {
		log.debug("MngBssProductOsController:mngBbsFaqList()");
		return "mng/bss/productOs/bssProductOsList";		
	}
	
	/**
	 * 이미지 관리 리스트
	 */
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public ResponseEntity<Object> bssProductList(CustomBssProductOsVO req){
		String res = mngBssProductOsService.list(req);
		
		if(res.equals("")){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}
	
	/**
	 * 이미지 관리 상세보기(화면)
	 */	
	@RequestMapping(value="/view", produces="text/plain;charset=UTF-8")
	public String mngReqProjectView(Model model, CustomBssProductOsVO req) {			
		String  productSeq =req.getProductSeq();
		model.addAttribute("productSeq", productSeq);
		
		return "mng/bss/productOs/bssProductOsView";
	}
	
	/**
	 * 이미지 상세 값 불러오기
	 */
	@RequestMapping(value = "/productView", method = RequestMethod.POST)
	public ResponseEntity<Object> mngBbsNoticeDetail(String productSeq) {
		log.debug("detail 상제 불러오기");
		log.debug("=== mngBbsNoticeDetail Controller ===");
		
		CustomBssProductOsVO res = mngBssProductOsService.view(productSeq);
		
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}
	
	/**
	 * 이미지 상세 값 삭제
	 */
	@Transactional
	@RequestMapping(value="/delete", method=RequestMethod.POST)
	public ResponseEntity<Object> mngBbsNoticeDelete(Model model, CustomBssProductOsVO req) {
		log.debug("image 삭제");
		
		String imageRes, productRes = "";
		
		String productImageSeq = req.getProductSeq();
		model.addAttribute("productSeq", productImageSeq);
		
		//imageRes = mngBssProductOsService.delete(productImageSeq);
		productRes = mngBssProductOsService.productDelete(productImageSeq);
		
		if(productRes==null){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(productRes, HttpStatus.OK);
	}
	
	/**
	 * 이미지 수정 상세 페이지
	 */
	@RequestMapping(value = "/update", method=RequestMethod.GET)
	public String catalog(CustomBssProductOsVO req, Model model){
		model.addAttribute("productSeq",req.getProductSeq());
		return "mng/bss/productOs/bssProductOsUpdate";
	}
	
	/**
	 * 이미지  등록
	 */
	@Transactional
	@RequestMapping(value="/insert", method=RequestMethod.POST, produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> bssProductInsert(HttpServletRequest request, CustomBssProductOsVO req) {
		log.info("=== bssProductImageInsert Controller1 ===");
		
		String resProduct = "";
		String resImage = "";
		String productCategory ="PRODCATE_OS";
		
		if(req.getProductSeq() != null){
			//update
			resImage = mngBssProductOsService.osUpdate(req);
			if( resImage == null ) {
				return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
			}
			return new ResponseEntity<Object>(resImage, HttpStatus.OK);
		} else {
			//insert
			Date requestSeqdate = new Date();
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
			String productSeq = dateFormat.format(requestSeqdate);
			req.setProductSeq(productSeq);
			req.setProductCategory(productCategory);
			
			String regUserId = request.getUserPrincipal().getName();
			req.setRegUserId(regUserId);
			

			resProduct = mngBssProductOsService.productInsert(req);
			resImage = mngBssProductOsService.osInsert(req);
				
			if(resProduct == null || resImage==null){
				return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
			}
			return new ResponseEntity<Object>(resImage, HttpStatus.OK);
		}
		
	}

	/**
	 *이미지 수정
	 */
	@RequestMapping(value="/productUpdate", method={RequestMethod.GET, RequestMethod.POST})
	public ResponseEntity<String> mngBbsNoticeUpdate(CustomBssProductOsVO req) {
		String res = "";
		res = mngBssProductOsService.productUpdate(req);

		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
	
	/**
	 * 이미지 등록 페이지
	 */
	@RequestMapping(value = "/write", method={RequestMethod.GET, RequestMethod.POST}, produces="text/plain;charset=UTF-8")
	public String bssProductWrite(Model model, CustomBssProductOsVO req) {
		String productSeq = req.getProductSeq();
		model.addAttribute("productSeq", productSeq);
		
		return "mng/bss/productOs/bssProductOsWrite";
	}
	
}
