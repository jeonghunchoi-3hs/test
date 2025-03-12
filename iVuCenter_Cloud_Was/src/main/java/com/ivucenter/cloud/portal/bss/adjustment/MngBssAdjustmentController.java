package com.ivucenter.cloud.portal.bss.adjustment;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping(value="/mng/bss/adjustment")
public class MngBssAdjustmentController {
	
	@Autowired
	private BssAdjustmentService bssAdjustmentService;
	
	
	@RequestMapping(value="/")
	public String MngBssAdjustment(Model model) {
		model.addAttribute("getBillYyyy", bssAdjustmentService.getBillYyyy());
		return "mng/bss/adjustment/bssAdjustment-list";
	}
	@RequestMapping(value = "/write")
	public String MngBssAdjustmentWrite(Model model){
		model.addAttribute("getBillMasterYyyymmList", bssAdjustmentService.getBillMasterYyyymmList());
		return "mng/bss/adjustment/bssAdjustment-write";
	}	
	@RequestMapping(value = "/view")
	public String MngBssAdjustmentView(Model model, CustomBssAdjustmentVO req){
		model.addAttribute("req", req);
		return "mng/bss/adjustment/bssAdjustment-view";
	}	
	@RequestMapping(value = "/edit")
	public String MngBssAdjustmentEdit(Model model, CustomBssAdjustmentVO req){
		model.addAttribute("req", req);
		return "mng/bss/adjustment/bssAdjustment-edit";
	}	
	@RequestMapping(value = "/list", method = RequestMethod.GET,produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> MngBssAdjustmentList(CustomBssAdjustmentVO req){
		String res = bssAdjustmentService.list(req);
		if(res.equals("")){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}
	@RequestMapping(value = "/excel")
	public ModelAndView MngBssAdjustmentExcel(CustomBssAdjustmentVO req, ModelMap map) {
		map.addAttribute("excel_gbn", "bssAdjustment");
		map.addAttribute("excel_title", "요금관리_보정");
		map.addAttribute("excel_list", bssAdjustmentService.excel(req));
		
		return new ModelAndView("bssAdjustmentExcelView", map);
	}
	@RequestMapping(value = "/insert")
	public ResponseEntity<String> MngBssAdjustmentInsert(CustomBssAdjustmentVO req,Model model){
		return new ResponseEntity<String>(bssAdjustmentService.insert(req), HttpStatus.OK);
	}
	@RequestMapping(value = "/delete")
	public ResponseEntity<String> MngBssAdjustmentDelete(CustomBssAdjustmentVO req,Model model){
		return new ResponseEntity<String>(bssAdjustmentService.delete(req), HttpStatus.OK);
	}	
	@RequestMapping(value = "/detail")
	public ResponseEntity<Object> MngBssAdjustmentDetail(CustomBssAdjustmentVO req) {
		CustomBssAdjustmentVO res = bssAdjustmentService.detail(req);
		if(res == null){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}
	@RequestMapping(value = "/update")
	public ResponseEntity<String> MngBssAdjustmentUpdate(CustomBssAdjustmentVO req,Model model){
		return new ResponseEntity<String>(bssAdjustmentService.update(req), HttpStatus.OK);
	}
	
	
	//보정 리스트
//	@RequestMapping(value = "/bssAdjustmentList")
//	public String bssAdjustmentList(Model model,ModelMap modelMap){
//		List<CustomBssAdjustmentVO> getBillYyyy = bssAdjustmentService.getBillYyyy();
//		modelMap.put("getBillYyyy", getBillYyyy);
//		
//		return "mng/bss/adjustment/bssAdjustmentList";
//	}
//	
//	//프로젝트 모달팝업 검색
//	@RequestMapping(value = "/projectPopList", method = RequestMethod.GET)
//	public ResponseEntity<Object> getprojectPopList(HttpServletRequest request,HttpServletResponse response){
//			HashMap<String, Object> map = new HashMap<>();
//			map.put("userId", request.getUserPrincipal().getName());
//			String searchValue =  request.getParameter("searchValue");
//			CustomBssAdjustmentVO projectvo = new CustomBssAdjustmentVO();			
//			//projectvo.setSearchKey(searchKey);
//			projectvo.setSearchValue(searchValue);
//			projectvo.setRegUserId(mngDetails.getId());
//			
//			List<CustomBssAdjustmentVO> getProjectList = bssAdjustmentService.getProjectList(projectvo);			
//		
//			map.put("getProjectList", getProjectList);
//			//model.addAttribute("searchKey", searchKey);
//			map.put("searchValue", searchValue);
//			return new ResponseEntity<Object>(map, HttpStatus.OK);
//	}
//	
//	//보정 내용
//	@RequestMapping(value = "/bssAdjustmentView")
//	public String bssAdjustmentView(HttpServletRequest request, Model model,ModelMap modelMap,CustomBssAdjustmentVO req){
//		
//		//log.debug("req.getAdjustSeq() : " + req.getAdjustSeq());
//		//log.debug("request.getParameter() : " + request.getParameter("adjustSeq"));
//				
//		CustomBssAdjustmentVO getBssAdjustmentView = bssAdjustmentService.getBssAdjustmentView(req);
//		
//		modelMap.put("getBssAdjustmentView", getBssAdjustmentView);
//		
//		return "mng/bss/adjustment/bssAdjustmentView";
//	}
//	
//	//보정 삭제
//	@RequestMapping(value="/bssAdjustmentDel", method = RequestMethod.GET)
//	public ResponseEntity<Object> bssAdjustmentDel(HttpServletRequest request, CustomBssAdjustmentVO req){
//		
//		String res = "";
//		log.debug("req.getAdjustSeq() : " + req.getAdjustSeq());
//		req.setModUserId(request.getUserPrincipal().getName());
//		req.setDelFlag("Y");	
//		res  = bssAdjustmentService.setBssAdjustmentDel(req);			
//				
//		return new ResponseEntity<Object>(res, HttpStatus.OK);
//	}
//	
//	
//	//보정 수정 등록
//	@RequestMapping(value = "/bssAdjustmenteditok")
//	public ResponseEntity<Object> bssAdjustmenteEitok(HttpServletRequest request, CustomBssAdjustmentVO req, Model model){
//		model.addAttribute("userId", request.getUserPrincipal().getName());
//		String res = "0";
//		String adjustAmount = "";
//		
//		String billYyyymm = req.getBillYyyymm().replace("-","");
//		log.debug("req.getSigntxt() : " + req.getSigntxt());
//		
//		adjustAmount = req.getSigntxt()+req.getAdjustAmount();
//		req.setAdjustAmount(adjustAmount);
//
//		req.setRegUserId(mngDetails.getId());
//		req.setModUserId(mngDetails.getId());
//		
//		req.setBillYyyymm(billYyyymm);
//		
//		res = bssAdjustmentService.setBssAdjustmenteEitok(req);
//			
//		return new ResponseEntity<Object>(res, HttpStatus.OK);
//	}	
}
