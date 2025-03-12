package com.ivucenter.cloud.portal.home;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ivucenter.cloud.portal.login.UserSession;
import com.ivucenter.cloud.portal.monitoring.event.CustomMonitoringEventVO;
import com.ivucenter.cloud.portal.monitoring.event.MonitoringRealtimeEventService;
import com.ivucenter.cloud.portal.monitoring.status.CustomMonitoringStatusVO;
import com.ivucenter.cloud.portal.monitoring.status.MonitoringRealtimeStatusService;
import com.ivucenter.cloud.portal.oss.vm.CustomOssVmVO;
import com.ivucenter.cloud.portal.oss.vm.OssVmService;
import com.ivucenter.cloud.portal.req.catalogue.CustomReqCatalogueVO;
import com.ivucenter.cloud.portal.req.catalogue.ReqCatalogueService;
import com.ivucenter.cloud.portal.req.product.CustomReqProductVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value="/mbr/mbrhome")
public class MbrPotalHomeController {

	@Autowired
	private PotalHomeService potalHomeService;

	@Autowired
	MonitoringRealtimeEventService eventService;

	@Autowired
	MonitoringRealtimeStatusService performanceService;

	@Autowired
	OssVmService ossVmService;

	@Autowired
	private ReqCatalogueService reqCatalogueService;

	@RequestMapping(value="/timer", method = RequestMethod.POST)
	public ResponseEntity<Object> MbrServicelist(){
		String res = potalHomeService.timer();
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}


	@RequestMapping(value="/dashboard")
	@Secured( {"ROLE_CUSTOM_ADMIN","ROLE_CUSTOM_USER", "ROLE_CUSTOM_PM", "ROLE_CUSTOM_USER"} )
	public String moveMbrHome(HttpServletRequest request, Model model, CustomReqCatalogueVO req) {

		CustomMbrHomeVO homeVO = new CustomMbrHomeVO();
		homeVO.setLoginUserId(request.getUserPrincipal().getName());


		String rolechk="";
		if     (request.isUserInRole("ROLE_CUSTOM_ADMIN")) { rolechk="custom"; }
		else if(request.isUserInRole("ROLE_CUSTOM_USER")) { rolechk="custom"; }
		else if(request.isUserInRole("ROLE_CUSTOM_PM")) { rolechk="pm";	}

		homeVO.setRolechk(rolechk);




		if(req.getProjectBoxId() != null) {
			homeVO.setProjectBoxId(req.getProjectBoxId());
			model.addAttribute("projectBoxId", req.getProjectBoxId());

		}else {
			model.addAttribute("projectBoxId", "");
		}


		if(!rolechk.equals("")){
			// 프로젝트 신청
			CustomMbrHomeVO mbrProjectReq = potalHomeService.mbrProjectReq(homeVO);
			model.addAttribute("mbrProjectReq", mbrProjectReq);
			// 프로젝트 승인
			CustomMbrHomeVO mbrProjectApprove = potalHomeService.mbrProjectApprove(homeVO);
			model.addAttribute("mbrProjectApprove", mbrProjectApprove);
			// 자원 신청
			CustomMbrHomeVO mbrProductReq = potalHomeService.mbrProductReq(homeVO);
			model.addAttribute("mbrProductReq", mbrProductReq);
			// 자원 승인
			CustomMbrHomeVO mbrProductApprove = potalHomeService.mbrProductApprove(homeVO);
			model.addAttribute("mbrProductApprove", mbrProductApprove);
			// 프로젝트 자원현황
			List<CustomMbrHomeVO> mbrProjectResources = potalHomeService.mbrProjectResources(homeVO);
			model.addAttribute("mbrProjectResources", mbrProjectResources);
			// 서비스 현황
			List<CustomMbrHomeVO> mbrServiceResources = potalHomeService.mbrServiceResources(homeVO);
			model.addAttribute("mbrServiceResources", mbrServiceResources);




			UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			CustomOssVmVO customOssVmVO = new CustomOssVmVO();
			customOssVmVO.setUserId(userSession.getUsername());

			List<CustomOssVmVO> osList = ossVmService.vmListProjectUser(customOssVmVO);

		    Map map = new HashMap();
		    map.put("list", osList);

			// 이벤트 현황
		    //CustomMonitoringEventVO eventCnt = eventService.getEventSummaryCnt(map);
		    //model.addAttribute("eventCnt", eventCnt);
			// 성능 TOP 현황
		    //List<CustomMonitoringStatusVO> cpuTopX = performanceService.getCpuTopX(map);
			//model.addAttribute("cpuTopX", cpuTopX);
			//List<CustomMonitoringStatusVO> memTopX = performanceService.getMemTopX(map);
			//model.addAttribute("memTopX", memTopX);

			//현재월
			Date dt = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
			log.debug("이번달 : " +sdf.format(dt));

			homeVO.setBillYyyymm(sdf.format(dt));
			List<CustomMbrHomeVO> preDashboardInfo = potalHomeService.userDashboardInfo(homeVO);
			for (CustomMbrHomeVO customMbrHomeVO : preDashboardInfo) {
				if(customMbrHomeVO.getResourceType().equals("VM")) model.addAttribute("nowVM", customMbrHomeVO);
				if(customMbrHomeVO.getResourceType().equals("NAS")) model.addAttribute("nowNAS", customMbrHomeVO);
				if(customMbrHomeVO.getResourceType().equals("LOADBALANCER")) model.addAttribute("nowLOADBALANCER", customMbrHomeVO);
				if(customMbrHomeVO.getResourceType().equals("BACKUP")) model.addAttribute("nowBACKUP", customMbrHomeVO);
				if(customMbrHomeVO.getResourceType().equals("PUBLICIP")) model.addAttribute("nowPUBLICIP", customMbrHomeVO);
				if(customMbrHomeVO.getResourceType().equals("DISK")) model.addAttribute("nowDISK", customMbrHomeVO);
				if(customMbrHomeVO.getResourceType().equals("MCA")) model.addAttribute("nowMCA", customMbrHomeVO);
				if(customMbrHomeVO.getResourceType().equals("SCM")) model.addAttribute("nowSCM", customMbrHomeVO);
				if(customMbrHomeVO.getResourceType().equals("SECURITY")) model.addAttribute("nowSECURITY", customMbrHomeVO);
			}

//			loginUserId.setBillYyyymm("201710");
			Calendar cal = Calendar.getInstance();
			cal.setTime(dt);
			cal.add(Calendar.MONTH, -1);
			homeVO.setBillYyyymm(sdf.format(cal.getTime()));
			List<CustomMbrHomeVO> nowDashboardInfo = potalHomeService.userDashboardInfo(homeVO);
			for (CustomMbrHomeVO customMbrHomeVO : nowDashboardInfo) {
				if(customMbrHomeVO.getResourceType().equals("VM")) model.addAttribute("preVM", customMbrHomeVO);
				if(customMbrHomeVO.getResourceType().equals("NAS")) model.addAttribute("preNAS", customMbrHomeVO);
				if(customMbrHomeVO.getResourceType().equals("LOADBALANCER")) model.addAttribute("preLOADBALANCER", customMbrHomeVO);
				if(customMbrHomeVO.getResourceType().equals("BACKUP")) model.addAttribute("preBACKUP", customMbrHomeVO);
				if(customMbrHomeVO.getResourceType().equals("PUBLICIP")) model.addAttribute("prePUBLICIP", customMbrHomeVO);
				if(customMbrHomeVO.getResourceType().equals("DISK")) model.addAttribute("preDISK", customMbrHomeVO);
				if(customMbrHomeVO.getResourceType().equals("MCA")) model.addAttribute("preMCA", customMbrHomeVO);
				if(customMbrHomeVO.getResourceType().equals("SCM")) model.addAttribute("preSCM", customMbrHomeVO);
				if(customMbrHomeVO.getResourceType().equals("SECURITY")) model.addAttribute("preSECURITY", customMbrHomeVO);
			}

//			//자원현황
//			CustomMbrHomeVO userReVO = potalHomeService.userReVO(homeVO);
//			model.addAttribute("userReVO", userReVO);
//
//			//자원현황 리스트
//			List<CustomMbrHomeVO> userReVOList = potalHomeService.userReVOList(homeVO);
//			model.addAttribute("userReVOList", userReVOList);
//
//			//공지사항 리스트
//			List<CustomMbrHomeVO> userNoticeList = potalHomeService.userNoticeList();
//			model.addAttribute("userNoticeList", userNoticeList);
//
//			//Q&A 최근 한건 조회
//			log.debug(homeVO.getLoginUserId());
//
//			List<CustomMbrHomeVO> userQnaList = potalHomeService.userQnaLast(homeVO);
//			model.addAttribute("userQnaList", userQnaList);

			List<CustomMbrHomeVO> userBillTwoMonth = potalHomeService.userBillTwoMonth(homeVO);
			StringBuffer sb = new StringBuffer();
			StringBuffer sb2 = new StringBuffer();
			String str = "";
			String str2 = "";
			log.debug("userBillTwoMonth.size() : " + userBillTwoMonth.size());

			SimpleDateFormat df = new SimpleDateFormat("MM");
			log.debug("이번달 : " +df.format(dt));
			log.debug("이전달 : " +df.format(cal.getTime()));



			if(userBillTwoMonth.size()!=0){
				sb.append("[");
				sb2.append("[");
				for(int n=0; n<userBillTwoMonth.size(); n++){
					sb.append(userBillTwoMonth.get(n).getAmount() + ",");
					sb2.append(userBillTwoMonth.get(n).getMonth() + ",");
				}
				str = sb.toString().substring(0, sb.toString().length()-1);
				str2 = sb2.toString().substring(0, sb2.toString().length()-1);
			}else{
				str = "[0,0";
				str2 = "["+df.format(cal.getTime())+","+df.format(dt);
			}

			model.addAttribute("billTwoMonthChart", str+"]");
			model.addAttribute("billTwoMonthCate", str2+"]");
			model.addAttribute("userBillTwoMonth", userBillTwoMonth);
			int i=0;

			if(userBillTwoMonth.size() !=0){
				for (CustomMbrHomeVO customMbrHomeVO : userBillTwoMonth) {
					i++;
					if(i==1) model.addAttribute("preBill", customMbrHomeVO);
					else if (i==2) model.addAttribute("nowBill", customMbrHomeVO);
				}
			}else{
				CustomMbrHomeVO emptyVo = new CustomMbrHomeVO();
				emptyVo.setMonth(df.format(cal.getTime()));
				emptyVo.setAmount("0");
				log.debug("preBill : " + emptyVo.getMonth());
				model.addAttribute("preBill", emptyVo);
				CustomMbrHomeVO emptyVo2 = new CustomMbrHomeVO();
				emptyVo2.setMonth(df.format(dt).toString());
				emptyVo2.setAmount("0");
				log.debug("nowBill : " + emptyVo2.getMonth());
				model.addAttribute("nowBill", emptyVo2);
			}


			req.setRegUserId(request.getUserPrincipal().getName());

			List<CustomReqCatalogueVO> getProjectList = reqCatalogueService.getProjectList(req);

			model.addAttribute("getProjectList", getProjectList);



//			//신청현황 승인처리중
//			CustomMbrHomeVO userProcessVO = potalHomeService.userProcessVO(loginUserId);
//			model.addAttribute("userProcessVO", userProcessVO);
//
//			//신청현황 작업 진행 중
//			CustomMbrHomeVO userWorkProcessVO = potalHomeService.userWorkProcessVO(loginUserId);
//			model.addAttribute("userWorkProcessVO", userWorkProcessVO);
//
//			//신청현황 승인 완료
//			CustomMbrHomeVO userCompletedVO = potalHomeService.userCompletedVO(loginUserId);
//			model.addAttribute("userCompletedVO", userCompletedVO);
//
//			//신청현황 승인 반려
//			CustomMbrHomeVO userRejectedVO = potalHomeService.userRejectedVO(loginUserId);
//			model.addAttribute("userRejectedVO", userRejectedVO);
//
//			//신청현황 사용자 목록
//			List<CustomMbrHomeVO> userApprvstateList = potalHomeService.userApprvstateList(loginUserId);
//			model.addAttribute("userApprvstateList", userApprvstateList);

			//loginFlag
			log.debug(request.getParameter("loginFlag"));
			model.addAttribute("loginFlag",request.getParameter("loginFlag"));

			//차트
			potalHomeService.higtChart(model, homeVO);
		}else{
			model.addAttribute("billInvoiceByCategory", "[]");
			model.addAttribute("billInvoiceByall", "[]");
			model.addAttribute("billInvoiceByproject", "[]");
		}
		return "mbr/mbrhome/dashboard";
	}

	/*
	 * 프로젝트 자원 상세
	 */
	@RequestMapping(value = "/mbrProjectResourcesList", method = { RequestMethod.GET, RequestMethod.POST })
	public ResponseEntity<Object> cloudUsageProject(HttpServletRequest request, HttpServletResponse response, CustomReqProductVO req) {

		CustomMbrHomeVO homeVO = new CustomMbrHomeVO();
		homeVO.setLoginUserId(request.getUserPrincipal().getName());
		List<CustomMbrHomeVO> res = potalHomeService.mbrProjectResourcesList(homeVO);

		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}
	/*
	 * 프로젝트 자원 상세
	 */
	@RequestMapping(value = "/mbrProjectResourcesListTotal", method = { RequestMethod.GET, RequestMethod.POST })
	public ResponseEntity<Object> cloudUsageProject1(HttpServletRequest request, HttpServletResponse response, CustomReqProductVO req) {

		CustomMbrHomeVO homeVO = new CustomMbrHomeVO();
		homeVO.setLoginUserId(request.getUserPrincipal().getName());
		List<CustomMbrHomeVO> res = potalHomeService.mbrProjectResourcesListTotal(homeVO);

		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}


}
