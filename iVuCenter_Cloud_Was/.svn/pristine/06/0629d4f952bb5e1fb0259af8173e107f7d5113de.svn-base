package com.ivucenter.cloud.portal.bbs.download;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ivucenter.cloud.portal.cmm.file.CmmFileService;
import com.ivucenter.cloud.portal.cmm.file.CustomCmmFileVO;
import com.ivucenter.cloud.portal.util.CodeUtil;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
@RequestMapping(value="/mbr/bbs/download")
public class MbrBbsDownloadController {

	@Autowired
	private BbsDownloadService service;

	@Autowired
	private CmmFileService cmmFileService;

	@RequestMapping(value="/")
	@Secured( {"ROLE_CUSTOM_ADMIN","ROLE_CUSTOM_USER", "ROLE_CUSTOM_PM"} )
	public String mbrBbsDownload() {
		log.debug("MbrBbsDownloadController:mbrBbsDownload()");
		return "mbr/bbs/download/bbsDownloadList";
	}

	@RequestMapping(value="/view")
	@Secured( {"ROLE_CUSTOM_ADMIN","ROLE_CUSTOM_USER", "ROLE_CUSTOM_PM"} )
	public String mbrBbsDownloadView(Model model, CustomBbsDownloadVO req) {
		try {
			CustomCmmFileVO vo = new CustomCmmFileVO();
			vo.setProgramName(CodeUtil.FILE_PROGRAM_NAME1);
			vo.setProgramSeq(req.getDownloadNo()+"");

			model.addAttribute("file", cmmFileService.list(vo));
			model.addAttribute("downloadNo", req.getDownloadNo());

			return "mbr/bbs/download/bbsDownloadView";
		} catch (Exception e) {
			log.error("Exception : " + e.getMessage());
			return "redirect:j_spring_security_logout";
		}
	}


	/**
	 * 목록
	 */
	@RequestMapping(value="/list", method = RequestMethod.GET , produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> mbrBbsDownloadList(CustomBbsDownloadVO req){
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
	public ResponseEntity<Object> mbrBbsDownloadDetail(CustomBbsDownloadVO req) {
		CustomBbsDownloadVO res = service.detail(req);

		if(res == null){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

}
