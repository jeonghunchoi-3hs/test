package com.ivucenter.cloud.portal.charge.bill;

import java.io.UnsupportedEncodingException;
import java.security.Principal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.batch.core.JobExecution;
import org.springframework.batch.core.JobParameter;
import org.springframework.batch.core.JobParameters;
import org.springframework.batch.core.configuration.JobLocator;
import org.springframework.batch.core.launch.JobLauncher;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ivucenter.cloud.portal.approval.ApprovalService;
import com.ivucenter.cloud.portal.approval.CustomApprovalVO;
import com.ivucenter.cloud.portal.cmm.cloud.OssCloudService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value="/mng/charge/bill")
public class MngChargeBillController {

    private static final Logger logger = LoggerFactory.getLogger(MngChargeBillController.class);

	@Autowired
	private ChargeBillService service;
	@Autowired
	private ApprovalService approvalService;
	@Autowired
	private OssCloudService ossCloudService;

	/**
	 * 요금 청구서 목록화면
	 */
	@RequestMapping(value="/")
	public String getBillListPage(Model model){
		return "mng/bss/bill/billList";
	}


	/**
	 * 요금 청구서 상세화면
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value="/view")
	public String getBillDetailPage(Model model, CustomChargeBillVO req) throws UnsupportedEncodingException{

		model.addAttribute("customerId", req.getCustomerId());
		model.addAttribute("projectId", req.getProjectId());
		model.addAttribute("billYyyymm", req.getBillYyyymm());
		model.addAttribute("startDt", req.getStartDt());
		model.addAttribute("endDt", req.getEndDt());

		/*
//		model.addAttribute("customerName", URLDecoder.decode(req.getCustomerName(),"UTF-8"));

		CustomChargeBillVO billVo = service.getBillDate(req);

		if(billVo!=null){
			model.addAttribute("billStartDatetime", billVo.getBillStartDatetime());
			model.addAttribute("billEndDatetime", billVo.getBillEndDatetime());
			model.addAttribute("customerName", billVo.getCustomerName());
		}else{
			return "mng/bss/bill/billNoData";
		}
		//청구년월
		String year = req.getBillYyyymm().substring(0, 4);
		String month = req.getBillYyyymm().substring(4, 6);

		model.addAttribute("year", year);
		model.addAttribute("month", month);*/

		return "mng/bss/bill/billView";

	}

	/**
	 *  회원사 소속 프로젝트별 청구내역 상세 화면
	 */
	@RequestMapping(value="/billDetailListPage")
	public String billDetailListPage(Model model, CustomChargeBillVO req){
		log.debug("=== customerBillDetailListPage Controller ===");

		model.addAttribute("customerId", req.getCustomerId());
		model.addAttribute("billYyyymm", req.getBillYyyymm());

//		req.setStepId("WF2000A0");
//		req.setUserId(principal.getName());
//		int stepCnt = service.getStepAuth(req);
//
//		model.addAttribute("stepCnt", stepCnt);

		return "mng/bss/bill/billCustomerDetail";
	}

	/**
	 *  회원사 소속 프로젝트별 청구내역 상세 조회
	 */
	@RequestMapping(value="/billDetailList")
	public ResponseEntity<Object> billDetailList(Model model, CustomChargeBillVO req){
		log.debug("=== billDetailList Controller ===");

		CustomChargeBillVO vo = new CustomChargeBillVO();

		vo.setStartDt(req.getStartDt());
		vo.setEndDt(req.getEndDt());
		vo.setCloudId(req.getCloudId());

		List<CustomChargeBillVO> projectList = service.invoiceProjectList(req);

		List<CustomChargeBillVO> detailList = new ArrayList<CustomChargeBillVO>();
		List<CustomChargeBillVO> vmResourceList = new ArrayList<CustomChargeBillVO>();

		List<CustomChargeBillVO> diskResourceList = new ArrayList<CustomChargeBillVO>();
		List<CustomChargeBillVO> nasResourceList = new ArrayList<CustomChargeBillVO>();
		List<CustomChargeBillVO> ipResourceList = new ArrayList<CustomChargeBillVO>();
		List<CustomChargeBillVO> loadbalancerResourceList = new ArrayList<CustomChargeBillVO>();

//		List<CustomChargeBillVO> backupResourceList = new ArrayList<CustomChargeBillVO>();
//		List<CustomChargeBillVO> mcaResourceList = new ArrayList<CustomChargeBillVO>();
//		List<CustomChargeBillVO> scmResourceList = new ArrayList<CustomChargeBillVO>();
//		List<CustomChargeBillVO> securityResourceList = new ArrayList<CustomChargeBillVO>();
		List<CustomChargeBillVO> dcAdList = new ArrayList<CustomChargeBillVO>();

        // 서비스 상품추가
		List<CustomChargeBillVO> serviceResourceList = new ArrayList<CustomChargeBillVO>();


		for(int i=0; i< projectList.size(); i++){
			vo.setProjectId(projectList.get(i).getProjectId());
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
			for(CustomChargeBillVO vo11 : service.dcAdDetail(vo)){
				dcAdList.add(vo11);
			}

			vo.setResourceDbTable("bill_charge_service_resource_detail");
			for(CustomChargeBillVO vo12 : service.resourceDetail2(vo)){
				serviceResourceList.add(vo12);
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

//		mm.addAttribute("backupResourceList", backupResourceList);
//		mm.addAttribute("mcaResourceList", mcaResourceList);
//		mm.addAttribute("scmResourceList", scmResourceList);
//		mm.addAttribute("securityResourceList", securityResourceList);
		mm.addAttribute("serviceResourceList", serviceResourceList);


		mm.addAttribute("dcAdList", dcAdList);



		model.addAttribute("customerId", req.getCustomerId());
		model.addAttribute("billYyyymm", req.getBillYyyymm());


		return new ResponseEntity<Object>(mm, HttpStatus.OK);
	}

	/**
	 *  프로젝트별 청구내역 상세 조회
	 */
	@RequestMapping(value="/billProjectDetailList")
	public ResponseEntity<Object> billprojectDetailList(Model model, CustomChargeBillVO req){

		final String projectId = req.getProjectId();
		final String BillYyyymm = req.getBillYyyymm();
		//List<CustomChargeBillVO> projectList = service.invoiceProjectList(req);

		List<CustomChargeBillVO> detailList = new ArrayList<CustomChargeBillVO>();
		List<CustomChargeBillVO> vmResourceList = new ArrayList<CustomChargeBillVO>();

		List<CustomChargeBillVO> diskResourceList = new ArrayList<CustomChargeBillVO>();
		List<CustomChargeBillVO> nasResourceList = new ArrayList<CustomChargeBillVO>();
		List<CustomChargeBillVO> ipResourceList = new ArrayList<CustomChargeBillVO>();
		List<CustomChargeBillVO> loadbalancerResourceList = new ArrayList<CustomChargeBillVO>();

//		List<CustomChargeBillVO> backupResourceList = new ArrayList<CustomChargeBillVO>();
//		List<CustomChargeBillVO> mcaResourceList = new ArrayList<CustomChargeBillVO>();
//		List<CustomChargeBillVO> scmResourceList = new ArrayList<CustomChargeBillVO>();
//		List<CustomChargeBillVO> securityResourceList = new ArrayList<CustomChargeBillVO>();
		List<CustomChargeBillVO> dcAdList = new ArrayList<CustomChargeBillVO>();

		CustomChargeBillVO vo = new CustomChargeBillVO();
		vo.setProjectId(projectId);
		vo.setBillYyyymm(BillYyyymm);

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
//		vo.setResourceDbTable("bill_charge_backup_resource_detail");
//		for(CustomChargeBillVO vo7 : service.resourceDetail2(vo)){
//			backupResourceList.add(vo7);
//		}
//		vo.setResourceDbTable("bill_charge_mca_resource_detail");
//		for(CustomChargeBillVO vo8 : service.resourceDetail2(vo)){
//			mcaResourceList.add(vo8);
//		}
//		vo.setResourceDbTable("bill_charge_scm_resource_detail");
//		for(CustomChargeBillVO vo9 : service.resourceDetail2(vo)){
//			scmResourceList.add(vo9);
//		}
//		vo.setResourceDbTable("bill_charge_security_resource_detail");
//		for(CustomChargeBillVO vo10 : service.resourceDetail2(vo)){
//			securityResourceList.add(vo10);
//		}
		for(CustomChargeBillVO vo11 : service.dcAdDetail(vo)){
			dcAdList.add(vo11);
		}

		ModelMap mm = new ModelMap();
		mm.addAttribute("projectId", projectId);
		mm.addAttribute("detailList", detailList);
		mm.addAttribute("vmResourceList", vmResourceList);

		mm.addAttribute("diskResourceList", diskResourceList);
		mm.addAttribute("nasResourceList", nasResourceList);
		mm.addAttribute("ipResourceList", ipResourceList);
		mm.addAttribute("loadbalancerResourceList", loadbalancerResourceList);

//		mm.addAttribute("backupResourceList", backupResourceList);
//		mm.addAttribute("mcaResourceList", mcaResourceList);
//		mm.addAttribute("scmResourceList", scmResourceList);
//		mm.addAttribute("securityResourceList", securityResourceList);
		mm.addAttribute("dcAdList", dcAdList);
		return new ResponseEntity<Object>(mm, HttpStatus.OK);
	}

	/**
	 * 요금 청구서 목록조회
	 */
	@RequestMapping(value="/list")
	public ResponseEntity<Object> getBillList(CustomChargeBillVO req, Model model, Principal principal){
		log.debug("=== getBillList Controller ===");

		req.setUserId(principal.getName());
		String res = service.list(req);

		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	/**
	 * 요금 청구서 목록조회
	 */
	@RequestMapping(value="/listMng", produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> getBillListMng(CustomChargeBillVO req, Model model, Principal principal) {

		req.setUserId(principal.getName());
		String res = service.listMng(req);

		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}
	@RequestMapping(value="/listMngProject", produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> getBillListMngProject(CustomChargeBillVO req, Model model, Principal principal) {

		req.setUserId(principal.getName());
		String res = service.listMngProject(req);

		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}
	@RequestMapping(value = "/excel")
	public ModelAndView getBillListMngExcel(CustomChargeBillVO req, ModelMap map) {
		map.addAttribute("excel_gbn", "chargeBill");
		map.addAttribute("excel_title", "요금조회_청구요금");
		map.addAttribute("excel_list", service.excel(req));
		return new ModelAndView("billInvoiceCustomerExcelView", map);
	}

	/**
	 * 요금 청구서 상세조회
	 */
	@RequestMapping(value="/detail")
	public ResponseEntity<Object> getBillView(CustomChargeBillVO req, Model model, Principal principal) {
		log.debug("=== getBillList Controller ===");

		ModelMap mm = new ModelMap();
		req.setUserId(principal.getName());
		List<CustomChargeBillVO> res = service.view(req);

		mm.addAttribute("detail", res);

		return new ResponseEntity<Object>(mm, HttpStatus.OK);
	}

	/**
	 * 프로젝트 요금 청구서 목록조회
	 */
	@RequestMapping(value="/projectBillList")
	public ResponseEntity<Object> getProjectBillList(CustomChargeBillVO req, Model model, Principal principal) {
		log.debug("=== getProjectBillList Controller ===");

		req.setUserId(principal.getName());
		String res = service.getProjectBillList(req);

		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	/**
	 *  프로젝트 요금 청구서 상세조회
	 */
	@RequestMapping(value="/projectBillDetail")
	public ResponseEntity<Object> getProjectBillView(CustomChargeBillVO req, Model model, Principal principal) {
		log.debug("=== getProjectBillView Controller ===");

		ModelMap mm = new ModelMap();
		req.setUserId(principal.getName());
		log.debug(req.getProjectId());
		List<CustomChargeBillVO> res = service.projectBillView(req);

		mm.addAttribute("detail", res);

		return new ResponseEntity<Object>(mm, HttpStatus.OK);
	}


	/**
	 *  매출현황조회화면
	 */
	@RequestMapping(value="/salesListPage")
	public String salesListPage(Model model){
		return "mng/bss/sales/salesList";
	}

	/**
	 *  매출현황조회
	 */
	@RequestMapping(value="/salesList", produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> getSalesList(CustomChargeBillVO req, Model model){
		log.debug("=== getSalesList Controller ===");

		String res = service.salesList(req);

		if(res.equals("")){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	/**
	 *  매출현황 상세화면
	 */
	@RequestMapping(value="/salesViewPage")
	public String salesViewPage(CustomChargeBillVO req, Model model){
		log.debug("=== salesListPage Controller ===");

		model.addAttribute("projectId", req.getProjectId());
		model.addAttribute("billYyyymm", req.getBillYyyymm());

		return "mng/bss/sales/salesView";
	}

	/**
	 *  매출현황 상세조회
	 */
	@RequestMapping(value="/salesView")
	public ResponseEntity<Object> salesView(CustomChargeBillVO req, Model model){
		log.debug("=== salesView Controller ===");

		CustomChargeBillVO res = service.salesView(req);
		res.setManagerTel(res.getManagerTelDec());

		if(res.equals("")){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}


	@RequestMapping(value = "/salesViewExcel")
	public ModelAndView getSalesViewMngExcel(CustomChargeBillVO req, ModelMap map) {
		map.addAttribute("excel_gbn", "chargeBill");
		map.addAttribute("excel_title", "매출현황 상세");
		map.addAttribute("excel_list", service.salesViewExcel(req));
		return new ModelAndView("billInvoiceCustomerDetailExcelView", map);
	}

	/**
	 *  정산 조회 화면
	 */
	@RequestMapping(value="/calculateListPage")
	public String calculateListPage(CustomChargeBillVO req, Model model, Principal principal) {
		log.debug("=== calculateListPage Controller ===");

		model.addAttribute("yearList", approvalService.billYearList(req));

		// 승인요청권한 체크
		CustomApprovalVO apprvVo = new CustomApprovalVO();
		apprvVo.setStepId("WF4000A0");
		apprvVo.setUserId(principal.getName());
		int approvalMemberCnt = approvalService.checkApprovalAuth(apprvVo);
		log.debug("approvalMemberCnt : " + approvalMemberCnt);
		String approvalMemberCheck="";

		if(approvalMemberCnt==0){
			approvalMemberCheck = "N";
		}else{
			approvalMemberCheck = "Y";
		}
		model.addAttribute("approvalMemberCheck", approvalMemberCheck);

		return "mng/bss/calculate/calculateList";
	}

	/**
	 *  정산 조회
	 */
	@RequestMapping(value="/calculateList", produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> getcalculateList(CustomChargeBillVO req, Model model){
		log.debug("=== getcalculateList Controller ===");

		String res = service.calculateList(req);

		if(res.equals("")){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	/**
	 *  정산 상세 화면
	 */
	@RequestMapping(value="/calculateView")
	public String calculateViewPage(CustomChargeBillVO req, Model model){
		log.debug("=== calculateListPage Controller ===");

		model.addAttribute("billYyyymm", req.getBillYyyymm());

		return "mng/bss/calculate/calculateView";
	}

	/**
	 *  정산상세조회
	 */
	@RequestMapping(value="/calculateDetailList")
	public ResponseEntity<Object> calculateDetailList(CustomChargeBillVO req, Model model){
		log.debug("=== calculateDetailList Controller ===");

		List<CustomChargeBillVO> res = service.calculateDetailList(req);

		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	/**
	 *  정산확정
	 */
	@RequestMapping(value="/updateConfirmFlag")
	public ResponseEntity<Object> updateConfirmFlag(CustomChargeBillVO req, Model model){
		log.debug("=== updateConfirmFlag Controller ===");

		String res = service.updateConfirmFlag(req);

		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	/**
	 *  재정산
	 */
	@RequestMapping(value="/billing")
	public ResponseEntity<Object> rebill(CustomChargeBillVO req, Model model )throws Exception{

        ApplicationContext applicationContext = com.ivucenter.cloud.batch.common.ApplicationContextUtil.getApplicationContext();
        JobLocator jobLocator = (JobLocator) applicationContext.getBean("jobRegistry");
        JobLauncher jobLauncher = (JobLauncher) applicationContext.getBean("jobLauncher");

		long runtime = new Timestamp(System.currentTimeMillis()).getTime();
		String billYM = req.getBillYyyymm();
		log.debug("req.getBillYyyymm() : " + req.getBillYyyymm());
		log.debug("billYM : " + billYM);
		String procUserId = req.getUserId();
		String runForce = "Y";

		try {
            Map<String, JobParameter> parameters = new HashMap<String, JobParameter>();
            parameters.put("runtime", new JobParameter(runtime));
            parameters.put("billYM", new JobParameter(billYM));
            parameters.put("procUserId", new JobParameter(procUserId));
            parameters.put("runForce", new JobParameter(runForce));

			JobExecution execution = jobLauncher.run(jobLocator.getJob("billingJob"), new JobParameters(parameters));

			log.debug("[SpringBatchJobLauncher] " + "Exit Status : " + execution.getStatus());
		} catch (Exception e) {
			log.error("[QuartzJobExecutor] " + "Job could not be executed");
		}

		log.info("Finished Execution of Batch Job");
		String res = "1";

		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

}
