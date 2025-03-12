package com.ivucenter.cloud.portal.bbs.download;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.ivucenter.cloud.portal.cmm.code.CmmCodeService;
import com.ivucenter.cloud.portal.cmm.code.CustomCmmCodeVO;
import com.ivucenter.cloud.portal.cmm.file.CmmFileService;
import com.ivucenter.cloud.portal.cmm.file.CustomCmmFileVO;
import com.ivucenter.cloud.portal.util.CodeUtil;

import lombok.extern.slf4j.Slf4j;


/**
 * 박진우
 */
@Slf4j
@Controller
@RequestMapping(value="/mng/bbs/download")
public class MngBbsDownloadController {
	
	@Autowired
	private BbsDownloadService service;
	
	@Autowired
	private CmmCodeService cmmCodeService;
	
	@Autowired
	private CmmFileService cmmFileService;
		
	@RequestMapping(value="/")
	public String mngBbsDownload() {			
		return "mng/bbs/download/bbsDownloadList";
		
	}
	
	@RequestMapping(value="/view")
	public String mngBbsDownloadView(Model model, CustomBbsDownloadVO req) {
		try {			
			
			CustomCmmFileVO vo = new CustomCmmFileVO();
			vo.setProgramName(CodeUtil.FILE_PROGRAM_NAME1);
			vo.setProgramSeq(req.getDownloadNo()+"");
			
			model.addAttribute("file", cmmFileService.list(vo));
			model.addAttribute("downloadNo", req.getDownloadNo());
			
			return "mng/bbs/download/bbsDownloadView";
		} catch (Exception e) {
			return "redirect:j_spring_security_logout";
		}
	}
	
	@RequestMapping(value="/write")
	public String mngBbsDownloadWrite(Model model, CustomBbsDownloadVO req) {
		try {
			
			CustomCmmCodeVO vo = new CustomCmmCodeVO();
			vo.setDelFlag("N");
			vo.setParentCodeId(CodeUtil.CMM_CODE_DOWNLOAD);
			model.addAttribute("code", cmmCodeService.listDetail(vo));
			
			CustomCmmFileVO vo2 = new CustomCmmFileVO();
			vo2.setProgramName(CodeUtil.FILE_PROGRAM_NAME1);
			vo2.setProgramSeq(req.getDownloadNo()+"");
			
			model.addAttribute("file", cmmFileService.list(vo2));
			model.addAttribute("downloadNo", req.getDownloadNo());
			model.addAttribute("programName", CodeUtil.FILE_PROGRAM_NAME1);
			
			return "mng/bbs/download/bbsDownloadWrite"; 
		} catch (Exception e) {
			return "redirect:j_spring_security_logout";
		}
	}
	
	/**
	 * 목록
	 */
	@RequestMapping(value="/list", method = RequestMethod.POST, produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> mngBbsDownloadList(CustomBbsDownloadVO req){
		log.debug(this.getClass().toString());
		
		String res = service.list(req);
		
		if(res.equals("")){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	/**
	 * 상세 정보
	 */
	@RequestMapping(value = "/detail")
	public ResponseEntity<Object> mngBbsDownloadDetail(CustomBbsDownloadVO req) {
		log.debug(this.getClass().toString());
		
		CustomBbsDownloadVO res = service.detail(req);		
		if(res == null){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}	
	
	/**
	 * 등록
	 */
	@RequestMapping(value="/insert", method=RequestMethod.POST)
	public ResponseEntity<String> mngBbsDownloadInsert(CustomBbsDownloadVO req) {
		String res = service.insert(req);
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
	
	@RequestMapping(value="/updateFilesCnt", method=RequestMethod.POST)
	public ResponseEntity<String> mbrBbsDownloadUpdateFilesCnt(CustomCmmFileVO req) {
		String res = service.updateFilesCnt(req);
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
	
	/**
	 * 삭제
	 */
	@RequestMapping(value="/delete", method=RequestMethod.POST)
	public ResponseEntity<String> mngBbsDownloadDelete(CustomBbsDownloadVO req) {		
		String res = service.delete(req);
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}

	@RequestMapping(value = "/excel")
	public ModelAndView MngBssDownloadExcel(CustomBbsDownloadVO req, ModelMap map) {
		map.addAttribute("excel_gbn", "download");
		map.addAttribute("excel_title", "고객센터_자료실");
		map.addAttribute("excel_list", service.excel(req));
		return new ModelAndView("bBsMenuExcelView", map);
	}	
}
