package com.ivucenter.cloud.home;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.ivucenter.cloud.portal.bbs.faq.BbsFaqService;
import com.ivucenter.cloud.portal.bbs.faq.CustomBbsFaqVO;
import com.ivucenter.cloud.portal.bbs.notice.BbsNoticeService;
import com.ivucenter.cloud.portal.bbs.notice.CustomBbsNoticeVO;
import com.ivucenter.cloud.portal.bbs.qna.BbsQnaService;
import com.ivucenter.cloud.portal.bbs.qna.CustomBbsQnaVO;
import com.ivucenter.cloud.portal.req.catalogue.CustomReqCatalogueVO;
import com.ivucenter.cloud.portal.req.catalogue.ReqCatalogueService;

@Controller
@RequestMapping(value="/homepage")
public class HomeController {
	
	@Autowired
	private BbsFaqService mbrservice;
	
	@Autowired
	private BbsNoticeService service;
	
	@Autowired
	private BbsQnaService qnaService;
	
	@Autowired
	private ReqCatalogueService reqCatalogueService;
	
	@RequestMapping(value="/intro")
	public String goIntroPage(HttpServletRequest req, HttpServletResponse res){
		
		return "home/intro";
	}
	
	@RequestMapping(value="/useinfo")
	public String goUseinfoPage(HttpServletRequest req, HttpServletResponse res){
		
		return "home/useinfo";
	}
	
	@RequestMapping(value="/point")
	public String goPointPage(HttpServletRequest req, HttpServletResponse res){
		
		return "home/point";
	}
	
	@RequestMapping(value="/effect")
	public String goEffectPage(HttpServletRequest req, HttpServletResponse res){
		
		return "home/effect";
	}
	
	
	
	@RequestMapping(value="/basic")
	public String goBasicPage(HttpServletRequest req, HttpServletResponse res){
		
		return "home/p_basic";
	}
	
	@RequestMapping(value="/plus")
	public String goPlusPage(HttpServletRequest req, HttpServletResponse res){
		
		return "home/p_plus";
	}
	@RequestMapping(value="/plusDisk")
	public String goPlusDiskPage(HttpServletRequest req, HttpServletResponse res){
		
		return "home/p_plus_disk";
	}
	@RequestMapping(value="/plusIp")
	public String goPlusIpPage(HttpServletRequest req, HttpServletResponse res){
		
		return "home/p_plus_ip";
	}
	@RequestMapping(value="/plusLoad")
	public String goPlusLoadPage(HttpServletRequest req, HttpServletResponse res){
		
		return "home/p_plus_load";
	}
	@RequestMapping(value="/plusNas")
	public String goPlusNasPage(HttpServletRequest req, HttpServletResponse res){
		
		return "home/p_plus_nas";
	}
	
	
	@RequestMapping(value="/service")
	public String goServicePage(HttpServletRequest req, HttpServletResponse res){
		
		return "home/p_service";
	}
	@RequestMapping(value="/serviceBackup")
	public String goServiceBackupPage(HttpServletRequest req, HttpServletResponse res){
		
		return "home/p_service_backup";
	}
	@RequestMapping(value="/serviceOut")
	public String goServiceOutPage(HttpServletRequest req, HttpServletResponse res){
		
		return "home/p_service_out";
	}
	@RequestMapping(value="/serviceSec")
	public String goServiceSecPage(HttpServletRequest req, HttpServletResponse res){
		
		return "home/p_service_sec";
	}
	@RequestMapping(value="/serviceVer")
	public String goServiceVerPage(HttpServletRequest req, HttpServletResponse res){
		
		return "home/p_service_ver";
	}
	
	@RequestMapping(value="/change")
	public String goChangePage(HttpServletRequest req, HttpServletResponse res){
		
		return "home/change";
	}
	
	
	
	@RequestMapping(value="/cal")
	public String goCalPage(HttpServletRequest req, HttpServletResponse res,Model model){
		
		Date nowdate = new Date();
		String hourlyFlag =  "N";//월단위
		
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		String applyDate = dateFormat.format(nowdate);
		CustomReqCatalogueVO projectvo = new CustomReqCatalogueVO();
		projectvo.setApplyDate(applyDate);
		
		CustomReqCatalogueVO getCatalogueItempric = reqCatalogueService.getCatalogueItempric(projectvo);
		model.addAttribute("getCatalogueItempric", getCatalogueItempric);

		List<CustomReqCatalogueVO> getCatalogueOslist = reqCatalogueService.getCatalogueOslist(projectvo);				
		model.addAttribute("getCatalogueOslist", getCatalogueOslist);
		
		CustomReqCatalogueVO getCatalogueSelectView = reqCatalogueService.getCatalogueSelectBasicView(projectvo);
		
		model.addAttribute("getCatalogueSelectView", getCatalogueSelectView);
		
		return "home/p_cal";
	}
	
	@RequestMapping(value="/policy_service")
	public String goPolicyServicePage(HttpServletRequest req, HttpServletResponse res){
		
		return "home/policy_service";
	}
	
	@RequestMapping(value="/policy_product")
	public String goPolicyProductCalPage(HttpServletRequest req, HttpServletResponse res){
		
		return "home/policy_product";
	}
	
	@RequestMapping(value="/policy_personal")
	public String goPolicyPersonalCalPage(HttpServletRequest req, HttpServletResponse res){
		
		return "home/policy_personal";
	}
	
	@RequestMapping(value="/policy_sla")
	public String goPolicyslaCalPage(HttpServletRequest req, HttpServletResponse res){
		
		return "home/policy_sla";
	}
	
	@RequestMapping(value="/notice")
	public String goNoticeCalPage(HttpServletRequest req, HttpServletResponse res, Model model){
		
		
		model.addAttribute("noticeNo", req.getParameter("noticeNo"));
		
		return "home/notice_list";
	}
	
	/**
	 * 공지사항 목록 조회
	 */
	@RequestMapping(value="/list", method = RequestMethod.POST, produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> mbrBbsNoticeList(CustomBbsNoticeVO req){
		
		String res = service.list(req);
		
		if(res == ""){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}
	

	@RequestMapping(value="/noticeView")
	public String goNoticeViewPage(HttpServletRequest req, HttpServletResponse res, Model model){
		
		
		model.addAttribute("noticeNo", req.getParameter("noticeNo"));
		
		return "home/notice_view";
	}
	
	/**
	 * 공지사항 상세조회
	 */
	@RequestMapping(value = "/detail", method = RequestMethod.GET)
	public ResponseEntity<Object> mbrBbsNoticeDetail(CustomBbsNoticeVO req) {
		
		CustomBbsNoticeVO res = service.detail(req);
		service.updateHitCount(req);
		
		if(res == null){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}	
	
	@RequestMapping(value="/faq")
	public String goFaqPage(HttpServletRequest req, HttpServletResponse res, Model model){
		
		String delflag = "N";
	
		List<CustomBbsFaqVO> customBbsFaqVO = mbrservice.faqList(delflag);
		model.addAttribute("faqList", customBbsFaqVO);
		
		return "home/faq_list";
	}
	
	@RequestMapping(value="/qna")
	public String goQnaPage(HttpServletRequest req, HttpServletResponse res){
		
		return "home/qna_list";
	}
	
	@RequestMapping(value="/qnaView")
	public String goQnaPage(HttpServletRequest req, HttpServletResponse res, Model model){
		
		model.addAttribute("qnaNo", req.getParameter("qnaNo"));
		
		return "home/qna_view";
	}
	
	@RequestMapping(value="/qnaList", method = RequestMethod.POST, produces="text/plain;charset=UTF-8")
	public ResponseEntity<String> MbrBbsQnaList(CustomBbsQnaVO req) {
		String res = qnaService.list(req);
		
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}	
	
	@RequestMapping(value = "/qnaDetail")
	public ResponseEntity<Object> MbrBbsQnaDetail(CustomBbsQnaVO req) {
		CustomBbsQnaVO res = qnaService.detail(req);
		
		if(res == null){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/detailReply")
	public ResponseEntity<Object> MbrBbsQnaDetailReply(CustomBbsQnaVO req) {
		CustomBbsQnaVO res = qnaService.detailReply(req);
		if(res == null){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}
	
	@RequestMapping(value="/guideDown")
	public ModelAndView fileDownload(ModelAndView mv,HttpServletRequest req) throws Exception {
		String getFile = req.getParameter("file");
		
		if (getFile == null || !isValidFileName(getFile)) {
			mv.setViewName("error404");
			return mv;
		}
		
		List<String> allowedExtensions = Arrays.asList(".doc", ".pdf", ".txt");
		boolean isAllowedExtensions = allowedExtensions.stream().anyMatch(getFile::endsWith);
		
		if (!isAllowedExtensions) {
			mv.setViewName("error404");
			return mv;
		}
		
		String basePath = req.getSession().getServletContext().getRealPath("/WEB-INF/resources");
		File file = new File(basePath, getFile);
		
		
		if (!file.exists() || !file.getCanonicalPath().startsWith(basePath)) {
			mv.setViewName("error404"); 
			return mv;
		}
		
		mv.setViewName("fileDownload");
		mv.addObject("DownloadFile",file);
		return mv;		
	}
	
	private boolean isValidFileName(String fileName) {
		return fileName.matches("^[a-zA-z0-9._-]+$") && !fileName.contains("..") && !fileName.contains("/");
	}
}
