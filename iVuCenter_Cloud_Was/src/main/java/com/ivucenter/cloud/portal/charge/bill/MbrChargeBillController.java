package com.ivucenter.cloud.portal.charge.bill;

import java.io.UnsupportedEncodingException;
import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;
import com.ivucenter.cloud.portal.cmm.cloud.OssCloudService;
import com.ivucenter.cloud.portal.cmm.customer.CmmCustomerService;
import com.ivucenter.cloud.portal.cmm.customer.CustomCmmCustomerVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value="/mbr/charge/bill")
public class MbrChargeBillController {
	
	@Autowired
	private ChargeBillService service;
	
	@Autowired
	private CmmCustomerService customerService;
	
	@Autowired
	private OssCloudService ossCloudService;
	
	/**
	 * 요금 청구서 목록화면
	 */ 
	@RequestMapping(value="/")
	//@Secured( {"ROLE_CUSTOM_ADMIN", "ROLE_CUSTOM_PM"} )
	public String getBillListPage(Model model, CustomChargeBillVO req, Principal principal){
		
		CustomChargeBillVO res = new CustomChargeBillVO();
		String userId = principal.getName();
		
		req.setUserId(userId);
		res = service.getCustomerId(req);
		model.addAttribute("customerId", res.getCustomerId());
		
		List<CustomOssCloudVO> getCloudList = ossCloudService.getCloudList();
		model.addAttribute("cloudList", getCloudList);

		return "mbr/charge/bill/billList";
	}
	
	/**
	 * 요금 청구서 상세화면
	 */ 
	@RequestMapping(value="/view")
	//@Secured( {"ROLE_CUSTOM_ADMIN", "ROLE_CUSTOM_PM"} )
	public String getBillDetailPage(Model model, CustomChargeBillVO req, HttpServletRequest request) throws UnsupportedEncodingException{
			
		String userId = request.getUserPrincipal().getName();
		req.setUserId(userId);
		req.setCustomerId(service.getUserCustomerId(req).getCustomerId());
		req.setCloudId(request.getParameter("cloudId"));
		
		// 고객사에서 당월사용금액 자세히
		if(request.getParameter("currentBillYyyymm")==null){
			// 청구서 조회
			if(req.getBillYyyymm()==null){		
				Date dt = new Date();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
				req.setBillYyyymm(sdf.format(dt));
//					req.setBillYyyymm("201709");
				model.addAttribute("cloudId", req.getCloudId());
				model.addAttribute("customerId", req.getCustomerId());
				model.addAttribute("billYyyymm", req.getBillYyyymm());
				model.addAttribute("fromPage", "billView");
			}else{
				model.addAttribute("cloudId", req.getCloudId());
				model.addAttribute("customerId", req.getCustomerId());
				model.addAttribute("billYyyymm", req.getBillYyyymm());
				model.addAttribute("fromPage", "billView");
			}
		}else{
			req.setBillYyyymm(request.getParameter("currentBillYyyymm"));
			model.addAttribute("cloudId", req.getCloudId());
			model.addAttribute("customerId", req.getCustomerId());
			model.addAttribute("billYyyymm", req.getBillYyyymm());
			model.addAttribute("fromPage", "customerView");
		}
		
		
		//model.addAttribute("customerName", URLDecoder.decode(req.getCustomerName(),"UTF-8"));
		CustomCmmCustomerVO customerVo = new CustomCmmCustomerVO();
		customerVo.setCustomerId(req.getCustomerId());
		customerVo.setBillYyyymm(req.getBillYyyymm());
		customerVo.setCloudId(req.getCloudId());
		
		//Chart 최근3개월 청구금액
		List<CustomCmmCustomerVO> get3MonthAmountList = customerService.get3MonthAmount2(customerVo, model);
		for (int i = get3MonthAmountList.size(); i < 3; i++) {
			CustomCmmCustomerVO tmp = new CustomCmmCustomerVO();
			tmp.setAmount("0");
			get3MonthAmountList.add(tmp);
		}
		// 당월 사용금액
		CustomCmmCustomerVO currentAmount =  customerService.getCurrentAmount(customerVo);
		customerService.get3MonthAmount3(customerVo, model);
		CustomChargeBillVO billVo = service.getBillDate(req);
		
		if(billVo!=null){
			log.debug("billVo.getBillStartDatetime() : " + billVo.getBillStartDatetime());
			log.debug("billVo.getBillEndDatetime() : " + billVo.getBillEndDatetime());
			model.addAttribute("billStartDatetime", billVo.getBillStartDatetime());
			model.addAttribute("billEndDatetime", billVo.getBillEndDatetime());
			model.addAttribute("customerName", billVo.getCustomerName());
			model.addAttribute("get3MonthAmountList", get3MonthAmountList);
		}
			
		return "mbr/charge/bill/billView";
		
	}
	
	/**
	 * 요금 청구서 프린트
	 */ 
	@RequestMapping(value="/print")
	//@Secured( {"ROLE_CUSTOM_ADMIN","ROLE_CUSTOM_USER", "ROLE_CUSTOM_PM"} )
	public String getBillDetailPrint(Model model, CustomChargeBillVO req, Principal principal) throws UnsupportedEncodingException{
			
		String userId = principal.getName(); 
		req.setUserId(userId);
		req.setCustomerId(service.getUserCustomerId(req).getCustomerId());
		log.debug("customerId : " + req.getCustomerId());
		if(req.getBillYyyymm()==null){
			Date dt = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
			req.setBillYyyymm(sdf.format(dt));
//				req.setBillYyyymm("201709");
			model.addAttribute("customerId", req.getCustomerId());
			model.addAttribute("billYyyymm", req.getBillYyyymm());
		}else{
			model.addAttribute("customerId", req.getCustomerId());
			model.addAttribute("billYyyymm", req.getBillYyyymm());
		}
			
			
//		model.addAttribute("customerName", URLDecoder.decode(req.getCustomerName(),"UTF-8"));
		CustomCmmCustomerVO customerVo = new CustomCmmCustomerVO();
		customerVo.setCustomerId(req.getCustomerId());
		//Chart 최근3개월 청구금액
		List<CustomCmmCustomerVO> get3MonthAmountList = customerService.get3MonthAmount2(customerVo, model);
		for (int i = get3MonthAmountList.size(); i < 3; i++) {
			CustomCmmCustomerVO tmp = new CustomCmmCustomerVO();
			tmp.setAmount("0");
			get3MonthAmountList.add(tmp);
		}
		customerService.get3MonthAmount(customerVo, model);
		CustomChargeBillVO billVo = service.getBillDate(req);
		
		if(billVo!=null){
			log.debug("billVo.getBillStartDatetime() : " + billVo.getBillStartDatetime());
			log.debug("billVo.getBillEndDatetime() : " + billVo.getBillEndDatetime());
			model.addAttribute("billStartDatetime", billVo.getBillStartDatetime());
			model.addAttribute("billEndDatetime", billVo.getBillEndDatetime());
			model.addAttribute("customerName", billVo.getCustomerName());
			model.addAttribute("get3MonthAmountList", get3MonthAmountList);
		}
			
		return "mbr/charge/bill/billPrint";
		
	}
	/**
	 *  회원사 소속 프로젝트별 청구내역 상세 화면
	 */ 
	@RequestMapping(value="/billDetailListPage")
	//@Secured( {"ROLE_CUSTOM_ADMIN", "ROLE_CUSTOM_PM"} )
	public String billDetailListPage(Model model, CustomChargeBillVO req){
		log.info("=== customerBillDetailListPage Controller ===");
		
		model.addAttribute("cloudId", req.getCloudId());
		model.addAttribute("customerId", req.getCustomerId());
		model.addAttribute("billYyyymm", req.getBillYyyymm());
		
		return "mbr/charge/bill/billCustomerDetail";
	}
	
	
	/**
	 * 요금 청구서 목록조회
	 */ 
	@RequestMapping(value="/list", produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> getBillList(CustomChargeBillVO req, Model model, Principal principal){
		log.info("=== getBillList Controller ===");
		
		req.setUserId(principal.getName());
		String res = service.list(req);
		
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}
	
	/**
	 * 요금 청구서 상세조회
	 */ 
	@RequestMapping(value="/detail")
	public ResponseEntity<Object> getBillView(CustomChargeBillVO req, Model model, Principal principal){
		log.info("=== getBillDetail Controller ===");
		
		req.setUserId(principal.getName());
		
		List<CustomChargeBillVO> res = service.view(req);
		HashMap<String, String> map = service.view2(req, model);
		
		CustomCmmCustomerVO customerVo = new CustomCmmCustomerVO();
		customerVo.setBillYyyymm(req.getBillYyyymm());
		customerVo.setCloudId(req.getCloudId());
		customerVo.setCustomerId(req.getCustomerId());
		HashMap<String, String> map2 = customerService.get3MonthAmount3(customerVo, model);
		List<CustomCmmCustomerVO> get3MonthList = customerService.get3MonthAmount2(customerVo, model);
		
		ModelMap mm = new ModelMap();
		mm.addAttribute("detail", res);
		mm.addAttribute("popCategory", map.get("getCategory"));
		mm.addAttribute("popProduct", map.get("getProduct"));
		mm.addAttribute("get3MonthList", get3MonthList);

		mm.addAttribute("get3MonthAmount", map2.get("get3MonthAmount"));
		mm.addAttribute("get3Yyyymm", map2.get("get3Yyyymm"));
		
		model.addAttribute("popCategory",  map.get("getCategory"));
		model.addAttribute("popProduct",  map.get("getProduct"));
		
		return new ResponseEntity<Object>(mm, HttpStatus.OK);
	}
	
	/**
	 * 프로젝트 요금 청구서 목록조회
	 */ 
	@RequestMapping(value="/projectBillList", produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> getProjectBillList(CustomChargeBillVO req, Model model, Principal principal){
		log.info("=== getProjectBillList Controller ===");
		
		req.setUserId(principal.getName());
		String res = service.getProjectBillList(req);
		
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}
	
	/**
	 *  프로젝트 요금 청구서 상세조회
	 */ 
	@RequestMapping(value="/projectBillDetail")
	public ResponseEntity<Object> getProjectBillView(CustomChargeBillVO req, Model model, Principal principal){
		log.info("=== getProjectBillView Controller ===");
		ModelMap mm = new ModelMap();

		req.setUserId(principal.getName());
		log.debug(req.getProjectId());
		List<CustomChargeBillVO> res = service.projectBillView(req);
		
		mm.addAttribute("detail", res);
		
		return new ResponseEntity<Object>(mm, HttpStatus.OK);
	}
	
	
	/**
	 *  회원사 소속 프로젝트별 청구내역 상세 조회
	 */ 
	@RequestMapping(value="/billDetailList")
	public ResponseEntity<Object> billDetailList(Model model, CustomChargeBillVO req){
		log.info("=== billDetailList Controller ===");
		
		List<CustomChargeBillVO> projectList = service.invoiceProjectList(req);
		
		List<CustomChargeBillVO> detailList = new ArrayList<CustomChargeBillVO>();
		List<CustomChargeBillVO> vmResourceList = new ArrayList<CustomChargeBillVO>();
		
		List<CustomChargeBillVO> diskResourceList = new ArrayList<CustomChargeBillVO>();
		List<CustomChargeBillVO> nasResourceList = new ArrayList<CustomChargeBillVO>();
		List<CustomChargeBillVO> ipResourceList = new ArrayList<CustomChargeBillVO>();
		List<CustomChargeBillVO> loadbalancerResourceList = new ArrayList<CustomChargeBillVO>();
		
		List<CustomChargeBillVO> serviceResourceList = new ArrayList<CustomChargeBillVO>();
		List<CustomChargeBillVO> dcAdList = new ArrayList<CustomChargeBillVO>();
		
		CustomChargeBillVO vo = new CustomChargeBillVO();
		
		for(int i=0; i< projectList.size(); i++){
			vo.setProjectId(projectList.get(i).getProjectId());
			vo.setCloudId(projectList.get(i).getCloudId());
			vo.setBillYyyymm(projectList.get(i).getBillYyyymm());
			
			//기본상품
			for(CustomChargeBillVO vo1 : service.billDetailList(vo)){
				detailList.add(vo1);
			}
			for(CustomChargeBillVO vo2 : service.vmResource(vo)){
				vmResourceList.add(vo2);
			}
			
			//부가상품
			vo.setResourceDbTable("bill_charge_disk_resource_detail");
			for(CustomChargeBillVO vo3 : service.resourceDetail2(vo)){
				diskResourceList.add(vo3);
			}
			vo.setResourceDbTable("bill_charge_nas_resource_detail");
			for(CustomChargeBillVO vo4 : service.resourceDetail2(vo)){
				nasResourceList.add(vo4);
			}
			vo.setResourceDbTable("bill_charge_publicip_resource_detail");
			for(CustomChargeBillVO vo5 : service.resourceDetail2(vo)){
				ipResourceList.add(vo5);
			}
			vo.setResourceDbTable("bill_charge_loadbalancer_resource_detail");
			for(CustomChargeBillVO vo6 : service.resourceDetail2(vo)){
				loadbalancerResourceList.add(vo6);
			}
			
			//서비스
			vo.setResourceDbTable("bill_charge_service_resource_detail");
			for(CustomChargeBillVO vo7 : service.resourceDetail2(vo)) {
				serviceResourceList.add(vo7);
			}
			
			/*
			** 서비스 테이블 통합됨. 2020.08.11 - 장중일
//			vo.setResourceDbTable("bill_charge_backup_resource_detail");
//			for(CustomChargeBillVO vo7 : service.resourceDetail2(vo)){
//				backupResourceList.add(vo7);
//			}
//			vo.setResourceDbTable("bill_charge_mca_resource_detail");
//			for(CustomChargeBillVO vo8 : service.resourceDetail2(vo)){
//				mcaResourceList.add(vo8);
//			}
//			vo.setResourceDbTable("bill_charge_scm_resource_detail");
//			for(CustomChargeBillVO vo9 : service.resourceDetail2(vo)){
//				scmResourceList.add(vo9);
//			}
//			vo.setResourceDbTable("bill_charge_security_resource_detail");
//			for(CustomChargeBillVO vo10 : service.resourceDetail2(vo)){
//				securityResourceList.add(vo10);
//			}
			*/
			// 할인 보정률 상세
			for(CustomChargeBillVO vo11 : service.dcAdDetail(vo)){
				dcAdList.add(vo11);
			}

		}
		
		ModelMap mm = new ModelMap();
		mm.addAttribute("projectList", projectList);
		mm.addAttribute("detailList", detailList);
		mm.addAttribute("vmResourceList", vmResourceList);
		
		mm.addAttribute("diskResourceList", diskResourceList);
		mm.addAttribute("nasResourceList", nasResourceList);
		mm.addAttribute("ipResourceList", ipResourceList);
		mm.addAttribute("loadbalancerResourceList", loadbalancerResourceList);
		
		mm.addAttribute("serviceResourceList", serviceResourceList);
		
		/*
//		mm.addAttribute("backupResourceList", backupResourceList);
//		mm.addAttribute("mcaResourceList", mcaResourceList);
//		mm.addAttribute("scmResourceList", scmResourceList);
//		mm.addAttribute("securityResourceList", securityResourceList);
		 
		 */
		mm.addAttribute("dcAdList", dcAdList);
		
		mm.addAttribute("cloudId", req.getCloudId());
		mm.addAttribute("customerId", req.getCustomerId());
		mm.addAttribute("billYyyymm", req.getBillYyyymm());
		
		log.debug("detailList : " + detailList);
		
		return new ResponseEntity<Object>(mm, HttpStatus.OK);
	}
	
	
	
	
	/**
	 *  회원사 소속 프로젝트별 청구내역 상세 조회
	 */ 
	@RequestMapping(value="/billCustomerDetailList")
	public ResponseEntity<Object> billProjectDetailList(Model model, CustomChargeBillVO req){
		log.info("=== billDetailList Controller ===");
		
		List<CustomChargeBillVO> projectList = service.invoiceProjectBillDetailList(req);
		
		List<CustomChargeBillVO> detailList = new ArrayList<CustomChargeBillVO>();
		List<CustomChargeBillVO> vmResourceList = new ArrayList<CustomChargeBillVO>();
		
		List<CustomChargeBillVO> diskResourceList = new ArrayList<CustomChargeBillVO>();
		List<CustomChargeBillVO> nasResourceList = new ArrayList<CustomChargeBillVO>();
		List<CustomChargeBillVO> ipResourceList = new ArrayList<CustomChargeBillVO>();
		List<CustomChargeBillVO> loadbalancerResourceList = new ArrayList<CustomChargeBillVO>();
		
		List<CustomChargeBillVO> serviceResourceList = new ArrayList<CustomChargeBillVO>();
		
		List<CustomChargeBillVO> dcAdList = new ArrayList<CustomChargeBillVO>();
		
		
		CustomChargeBillVO vo = new CustomChargeBillVO();
		
		for(int i=0; i< projectList.size(); i++){
			vo.setProjectId(projectList.get(i).getProjectId());
			vo.setCloudId(projectList.get(i).getCloudId());
			vo.setBillYyyymm(projectList.get(i).getBillYyyymm());
			
			//기본상품
			for(CustomChargeBillVO vo1 : service.billCustomerDetailList(vo)){
				detailList.add(vo1);
			}
			for(CustomChargeBillVO vo2 : service.vmCustomerResource(vo)){
				vmResourceList.add(vo2);
			}
			
			//부가상품
			vo.setResourceDbTable("bill_charge_disk_resource_detail");
			for(CustomChargeBillVO vo3 : service.resourceCustomerDetail(vo)){
				diskResourceList.add(vo3);
			}
			vo.setResourceDbTable("bill_charge_nas_resource_detail");
			for(CustomChargeBillVO vo4 : service.resourceCustomerDetail(vo)){
				nasResourceList.add(vo4);
			}
			vo.setResourceDbTable("bill_charge_publicip_resource_detail");
			for(CustomChargeBillVO vo5 : service.resourceCustomerDetail(vo)){
				ipResourceList.add(vo5);
			}
			vo.setResourceDbTable("bill_charge_loadbalancer_resource_detail");
			for(CustomChargeBillVO vo6 : service.resourceCustomerDetail(vo)){
				loadbalancerResourceList.add(vo6);
			}
			
			//서비스
			vo.setResourceDbTable("bill_charge_service_resource_detail");
			for(CustomChargeBillVO vo7 : service.resourceCustomerDetail(vo)) {
				serviceResourceList.add(vo7);
			}
			
			// 할인 보정률 상세
			for(CustomChargeBillVO vo11 : service.dcAdDetail(vo)){
				dcAdList.add(vo11);
			}

		}
		
		ModelMap mm = new ModelMap();
		mm.addAttribute("projectList", projectList);
		mm.addAttribute("detailList", detailList);
		mm.addAttribute("vmResourceList", vmResourceList);
		
		mm.addAttribute("diskResourceList", diskResourceList);
		mm.addAttribute("nasResourceList", nasResourceList);
		mm.addAttribute("ipResourceList", ipResourceList);
		mm.addAttribute("loadbalancerResourceList", loadbalancerResourceList);
		
		mm.addAttribute("serviceResourceList", serviceResourceList);
		mm.addAttribute("dcAdList", dcAdList);
		
		mm.addAttribute("cloudId", req.getCloudId());
		mm.addAttribute("customerId", req.getCustomerId());
		mm.addAttribute("billYyyymm", req.getBillYyyymm());
		
		log.debug("detailList : " + detailList);
		
		return new ResponseEntity<Object>(mm, HttpStatus.OK);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/**
	 *  회원사 소속 프로젝트별 청구내역 상세 조회
	 */ 
	@RequestMapping(value="/projectBill", produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> projectBill(Model model, CustomChargeBillVO req){
		log.info("=== billDetailList Controller ===");
		List<CustomChargeBillVO> detailList = new ArrayList<CustomChargeBillVO>();
//		detailList = service.billDetailList(req);
		detailList = service.vmResource(req);
		ModelMap mm = new ModelMap();
		log.debug("detailList : " +detailList.size());
		mm.addAttribute("detailList", detailList);
		
		return new ResponseEntity<Object>(mm, HttpStatus.OK);
	}
	
	
}
