package com.ivucenter.cloud.portal.bill.policy;

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

import com.ivucenter.cloud.portal.cmm.cloud.OssCloudService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value="/mng/bill/policy")
public class MngBillPolicyController {

	@Autowired
	private BillPolicyService service;

	@Autowired
	private OssCloudService ossCloudService;

	@RequestMapping(value="/")
	public String main() {
		return "mng/bill/policy/billPolicyList";
	}

	//가격정책관리 목록 페이지
	@RequestMapping(value = "/billPolicyList")
	public String billPolicyList(Model model) {
		return "mng/bill/policy/billPolicyList";
	}

	//가격정책관리 목록 조회
	@RequestMapping(value = "/list", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public ResponseEntity<String> billPolicyStatusList(CustomBillPolicyVO req){
		return new ResponseEntity<String>(service.getBillPolicyList(req), HttpStatus.OK);
	}
	@RequestMapping(value="/excel")
	public ModelAndView billPolicyStatusExcel(CustomBillPolicyVO req, ModelMap map){
		String cloudName = req.getCloudName();

		map.addAttribute("excel_gbn", "billPolicy");
		map.addAttribute("excel_title", "정책관리_과금항목정보");
		map.addAttribute("excel_list", service.excel(req));

		return new ModelAndView("productExcelView", map);
	}
	
	@RequestMapping(value="/viewExcel")
	public ModelAndView viewExcel(CustomBillPolicyVO req, ModelMap map){

		map.addAttribute("excel_gbn", "billDetailPolicy");
		map.addAttribute("excel_title", "상품관리_가격정책관리");
		map.addAttribute("excel_list", service.detailExcel(req));

		return new ModelAndView("productExcelView", map);
	}

	//가격정책관리 내용 페이지
	@RequestMapping(value = "/billPolicyView")
	public String billPolicyView(CustomBillPolicyVO req,Model model){

		model.addAttribute("policySeq",req.getPolicySeq());
		
		CustomBillPolicyVO getBillPolicyView = service.getBillPolicyView(req);
		model.addAttribute("getBillPolicyView", getBillPolicyView);

		List<CustomBillPolicyVO> getBillItemList = service.getBillItemList(req);
		model.addAttribute("getBillItemList", getBillItemList);
		

		List<CustomBillPolicyVO> getBillTypeList = service.getBillTypeList(req);
		model.addAttribute("getBillTypeList", getBillTypeList);
		

		return "mng/bill/policy/billPolicyView";
	}
	

	//가격정책관리 등록 페이지
	@RequestMapping(value = "/billPolicyWrite")
	public String billPolicyWrite(){
		return "mng/bill/policy/billPolicyWrite";
	}

	//가격정책관리 복사 페이지
	@RequestMapping(value = "/billPolicyCopy")
	public String billPolicyCopy(CustomBillPolicyVO req, Model model){

		CustomBillPolicyVO getBillPolicyInfo = service.getBillPolicyInfo(req);
		model.addAttribute("getBillPolicyInfo", getBillPolicyInfo);

		return "mng/bill/policy/billPolicyCopy";
	}

	//가격정책관리 등록 수정 페이지
	@RequestMapping(value = "/billPolicyEdit")
	public String billPolicyEdit(CustomBillPolicyVO req, Model model){

		CustomBillPolicyVO getBillPolicyInfo = service.getBillPolicyInfo(req);
		model.addAttribute("getBillPolicyInfo", getBillPolicyInfo);

		return "mng/bill/policy/billPolicyEdit";
	}

	//가격정책관리 수정
//	@RequestMapping(value = "/billPolicyEditok")
//	public ResponseEntity<Object> billPolicyEditok(HttpServletRequest request,HttpServletResponse response,CustomBillPolicyVO req){
//
//		String res = "";
//		req.setModUserId(mngDetails.getId());
//		res = service.setBillPolicyEdit(req);
//
//		return new ResponseEntity<Object>(res, HttpStatus.OK);
//	}

	//가격정책관리 삭제
//	@RequestMapping(value = "/billPolicyDelchkok")
//	public ResponseEntity<Object> billPolicyDelchkok(HttpServletRequest request,HttpServletResponse response,CustomBillPolicyVO req) throws ParseException{
//
//		String res = "";
//		req.setModUserId(mngDetails.getId());
//
//		Date nowdate = new Date();
//		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
//		Date applyDate = dateFormat.parse(req.getApplyDate());
//		if(nowdate.after(applyDate)){
//			//현재보다 이전
//			//log.debug("현재보다 이전 applyDate : " + req.getApplyDate());
//			//현재보다 이전이면 del_flag변경
//			res = service.billPolicyDelchgok(req);
//		}else{
//			//현재보다 이후
//			//log.debug("현재보다 이후 applyDate : " + req.getApplyDate());
//			//현재보다 이후이면 삭제
//			res = service.billPolicyDelok(req);
//		}
//
//		//
//
//		return new ResponseEntity<Object>(res, HttpStatus.OK);
//	}
//
//	//가격정책관리 등록
//	@RequestMapping(value = "/billPolicyWriteok")
//	public ResponseEntity<Object> billPolicyWriteok(HttpServletRequest request,HttpServletResponse response,CustomBillPolicyVO req){
//
//
//		String res = "";
//		//기존 가격정책관리 아이템 정보 가져오기
//		//Date nowdate = new Date();
//		//SimpleDateFormat applydateFormat = new SimpleDateFormat("yyyy-MM-dd");
//		//String applyDate = applydateFormat.format(nowdate);
//		CustomBillPolicyVO billPolicyvo = new CustomBillPolicyVO();
//		List<CustomBillPolicyVO> getOldBillPolicyInfo = null;
//		log.debug("req.getPolicySeq() : " + req.getPolicySeq());
//		if(req.getPolicySeq()!=null){
//			billPolicyvo.setPolicySeq(req.getPolicySeq());
//			getOldBillPolicyInfo = service.getCopyBillPolicyInfo(billPolicyvo);
//		}else{
//			billPolicyvo.setApplyDate(req.getApplyDate());
//			getOldBillPolicyInfo = service.getOldBillPolicyInfo(billPolicyvo);
//		}
//
//		log.debug("getOldBillPolicyInfo.size() : " + getOldBillPolicyInfo.size());
//
//		Date requestSeqdate = new Date();
//		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
//		String policySeq = dateFormat.format(requestSeqdate);
//
//		req.setPolicySeq(policySeq);
//		req.setRegUserId(mngDetails.getId());
//		req.setModUserId(mngDetails.getId());
//
//		int getBillPolicyCnt = service.getBillPolicyCnt(req);
//		log.debug("getBillPolicyCnt : " + getBillPolicyCnt);
//		if(getBillPolicyCnt==0){
//			String resBillPolicy = service.setBillPolicy(req);
//
//			for(int i=0;i<getOldBillPolicyInfo.size();i++){
//
//				CustomBillPolicyVO setBillPolicyItemvo = new CustomBillPolicyVO();
//				setBillPolicyItemvo.setPolicySeq(policySeq);
//				setBillPolicyItemvo.setItemId(getOldBillPolicyInfo.get(i).getItemId());
//				setBillPolicyItemvo.setHourlyPrice(getOldBillPolicyInfo.get(i).getHourlyPrice());
//				setBillPolicyItemvo.setMonthlyPrice(getOldBillPolicyInfo.get(i).getMonthlyPrice());
//
//				String setBillPolicyItem = service.setBillPolicyItem(setBillPolicyItemvo);
//
//				if(setBillPolicyItem.equals("1")){
//					String setBillPolicyItemPrice = service.setBillPolicyItemPrice(setBillPolicyItemvo);
//									}
//
//			}
//			res = "1";
//		}else{
//			res = "0";
//		}
//
//
//		return new ResponseEntity<Object>(res, HttpStatus.OK);
//	}

	//가격정책관리 item 등록 페이지
	@RequestMapping(value = "/billItemWrite")
	public String billItemWrite(CustomBillPolicyVO req,Model model){

		model.addAttribute("policySeq", req.getPolicySeq());
		return "mng/bill/policy/billItemWrite";
	}

	//가격정책관리 item 가격수정 페이지 (ajax : billitemeditok)
//	@RequestMapping(value = "/billItemEdit")
//	public String billItemEdit(HttpServletRequest request,HttpServletResponse response,CustomBillPolicyVO req,Model model){
//
//		CustomBillPolicyVO getBillItemEditVo = service.getBillItemEditVo(req);
//		model.addAttribute("getBillItemEditVo", getBillItemEditVo);
//		model.addAttribute("policySeq", req.getPolicySeq());
//		return "mng/bill/policy/billItemEdit";
//	}


	//가격정책관리 item 검색 페이지
	@RequestMapping(value = "/billItemSearch")
	public String billItemSearch(CustomBillPolicyVO req, Model model){

		log.debug("req.getItemName() : " + req.getItemName());
		List<CustomBillPolicyVO> getBillItemSearchList = service.getBillItemSearchList(req);
		model.addAttribute("getBillItemSearchList", getBillItemSearchList);
		model.addAttribute("policySeq", req.getPolicySeq());
		return "mng/bill/policy/billItemSearch";
	}

	//가격정책관리 item 검색 모달팝업용
	@RequestMapping(value = "/billItemSearchPopup")
	public ResponseEntity<Object> billItemSearchPopup(CustomBillPolicyVO req, Model model){

		log.debug("req.getItemName() : " + req.getItemName());
		List<CustomBillPolicyVO> res = service.getBillItemSearchList(req);

		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	//가격정책관리 아이템 수정
	@RequestMapping(value = "/billitemeditok")
	public ResponseEntity<Object> billitemeditok(CustomBillPolicyVO req){

		String res = "";
		String setBillPolicyItemEdit = service.setBillPolicyItemEdit(req);
		if(setBillPolicyItemEdit.equals("1")){
			res = setBillPolicyItemEdit;
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}
	
	
	// 과금항목 수정
	@RequestMapping(value = "/billitemeInsert")
	public ResponseEntity<Object> billitemeInsert(CustomBillPolicyVO req){
		 String res = "";
		int chk =  service.billProductCheck(req);
		if(chk < 1) {
			service.billProductInsert(req);
		}
		 service.billPolicyItemInsert(req);
		 service.billProductCatalogItemInsert(req);
		 res = "1";
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}
	
	

	//가격정책관리 아이템 등록
//	@RequestMapping(value = "/billitemwriteok")
//	public ResponseEntity<Object> billitemwriteok(HttpServletRequest request,HttpServletResponse response,CustomBillPolicyVO req){
//		mngDetails = (MngSession)SecurityContextHolder.getContext().getAuthentication().getDetails();
//
//		String res = "";
//		String setBillPolicyItem = service.setBillPolicyItem(req);
//		if(setBillPolicyItem.equals("1")){
//			String setBillPolicyItemPrice = service.setBillPolicyItemPrice(req);
//			if(setBillPolicyItemPrice.equals("1")){
//				res = setBillPolicyItemPrice;
//			}
//		}
//		return new ResponseEntity<Object>(res, HttpStatus.OK);
//	}
}
