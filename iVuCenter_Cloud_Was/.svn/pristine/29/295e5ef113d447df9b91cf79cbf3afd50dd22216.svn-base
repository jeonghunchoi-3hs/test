package com.ivucenter.cloud.portal.home;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ivucenter.cloud.portal.cmm.cloud.OssCloudService;
import com.ivucenter.cloud.portal.login.UserSession;
import com.ivucenter.cloud.portal.monitoring.event.CustomMonitoringEventVO;
import com.ivucenter.cloud.portal.monitoring.event.MonitoringRealtimeEventService;
import com.ivucenter.cloud.portal.monitoring.status.CustomMonitoringStatusVO;
import com.ivucenter.cloud.portal.monitoring.status.MonitoringRealtimeStatusService;
import com.ivucenter.cloud.portal.oss.disk.CustomStorageVO;
import com.ivucenter.cloud.portal.oss.vm.CustomOssVmVO;
import com.ivucenter.cloud.portal.oss.vm.OssVmService;

@Controller
@RequestMapping(value="/mng/mnghome")
public class MngPotalHomeController {

	@Autowired
	private PotalHomeService potalHomeService;

	@Autowired
	MonitoringRealtimeEventService eventService;

	@Autowired
	MonitoringRealtimeStatusService performanceService;

	@Autowired
	OssVmService ossVmService;

	@Autowired
	private OssCloudService ossCloudService;

	@RequestMapping(value="/dashboard")
	public String moveMngHome(HttpServletRequest request, Model model){

		CustomMbrHomeVO loginUserId = new CustomMbrHomeVO();
		loginUserId.setLoginUserId(request.getUserPrincipal().getName());

//		String rolechk="";


		// 프로젝트 승인탭 (처리중, 반려, 승인완료)
		CustomMbrHomeVO mngProjectApprove = potalHomeService.mngProjectApprove();
		model.addAttribute("mngProjectApprove", mngProjectApprove);

		// 자원 승인탭 (처리중, 반려, 승인완료)
		CustomMbrHomeVO mngProductApprove = potalHomeService.mngProductApprove();
		model.addAttribute("mngProductApprove", mngProductApprove);

		// 작업 승인탭 (처리중, 승인완료)
		CustomMbrHomeVO mngMyWork = potalHomeService.mngMyWork();
		model.addAttribute("mngMyWork", mngMyWork);

		// 사용자 승인탭 (가입요청, 가입승인)
		CustomMbrHomeVO mngUserApprove = potalHomeService.mngUserApprove();
		model.addAttribute("mngUserApprove", mngUserApprove);

		// 나의 할일 (프로젝트 승인, 상품 승인, 사용자 승인, 작업)
		List<CustomMbrHomeVO> myAllWork = potalHomeService.myAllWork(loginUserId);
		model.addAttribute("myAllWork", myAllWork);

		// 클라우드 서비스 현황 (회원사, 프로젝트, server vCpu, 메모리, OS DISK수량, OS 용량, DATA DISK 수량, DATA DISK 용량, 서비스(계정관리, 보안관제, 백업, sw 설치, 디스크관리))
		List<CustomMbrHomeVO> mngCloudProduct = potalHomeService.mngCloudProduct();
		model.addAttribute("mngCloudProduct", mngCloudProduct);

		// 클라우드 포탈 당월 매출 현황 (전체, 가상서버, 블록디스크, 계정관리, 백업서비스, 보안관제서비스, SW설치, 디스크 관리)

		CustomMbrHomeVO mngCloudAmount = potalHomeService.mngCloudAmount();
		model.addAttribute("mngCloudAmount", mngCloudAmount);

		List<CustomMbrHomeVO> mngProductAvr = potalHomeService.mngProductAvr();
		for(CustomMbrHomeVO productAvr : mngProductAvr) {
			List<CustomStorageVO> storageList = potalHomeService.getStorageList(productAvr.getCloudId());
			productAvr.setStorageList(storageList);
		}
		model.addAttribute("mngProductAvr", mngProductAvr);

		List<CustomMbrHomeVO> mngQnaList = potalHomeService.mngQnaList(loginUserId);
		model.addAttribute("mngQnaList", mngQnaList);

		//CustomMbrHomeVO cloudUsage = potalHomeService.cloudUsage(loginUserId);
		//model.addAttribute("cloudUsage", cloudUsage);

		CustomMbrHomeVO mngCloudService = potalHomeService.mngCloudService(loginUserId);
		model.addAttribute("mngCloudService", mngCloudService);

		CustomMbrHomeVO mngCustomerCount = potalHomeService.mngCustomerCount(loginUserId);
		model.addAttribute("mngCustomerCount", mngCustomerCount);

		CustomMbrHomeVO mngCustomerAmount = potalHomeService.mngCustomerAmount(loginUserId);
		model.addAttribute("mngCustomerAmount", mngCustomerAmount);

		List<CustomMbrHomeVO> mngCustomerAmount6month = potalHomeService.mngCustomerAmount6month(loginUserId);
		model.addAttribute("mngCustomerAmount6month", mngCustomerAmount6month);

		CustomMbrHomeVO myJobCount = potalHomeService.myJobCount(loginUserId);
		model.addAttribute("myJobCount", myJobCount);

		CustomMbrHomeVO totGoodCount = potalHomeService.totGoodCount(loginUserId);
		model.addAttribute("totGoodCount", totGoodCount);

		CustomMbrHomeVO totBillCount = potalHomeService.totBillCount(loginUserId);
		model.addAttribute("totBillCount", totBillCount);

		List<CustomMbrHomeVO> monthVm = potalHomeService.monthVm();
		model.addAttribute("monthVm",monthVm);

		UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		CustomOssVmVO customOssVmVO = new CustomOssVmVO();
		customOssVmVO.setUserId(userSession.getUsername());

		List<CustomOssVmVO> osList = ossVmService.vmListProjectUser(customOssVmVO);

	    Map map = new HashMap();
	    map.put("list", osList);

		// 이벤트 현황
//	    CustomMonitoringEventVO eventCnt = eventService.getEventSummaryCnt(map);
//	    model.addAttribute("eventCnt", eventCnt);
		//성능 TOP 현황
//	    List<CustomMonitoringStatusVO> cpuTopX = performanceService.getCpuTopX(map);
//		model.addAttribute("cpuTopX", cpuTopX);
//		List<CustomMonitoringStatusVO> memTopX = performanceService.getMemTopX(map);
//		model.addAttribute("memTopX", memTopX);


		//loginFlag
		model.addAttribute("loginFlag",request.getParameter("loginFlag"));

		return "mng/mnghome/dashboard";
	}

//	@RequestMapping(value = "/myJobCount", method = { RequestMethod.GET, RequestMethod.POST })
//	public ResponseEntity<Object> myJobCount(CustomMbrHomeVO req) {
//		CustomMbrHomeVO res = potalHomeService.myJobCount(req);
//		log.debug("loginUserId : "+res.getLoginUserId());
//		return new ResponseEntity<Object>(res, HttpStatus.OK);
//	}
}
