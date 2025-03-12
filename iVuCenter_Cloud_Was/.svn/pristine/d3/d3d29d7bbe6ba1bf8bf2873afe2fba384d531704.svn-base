package com.ivucenter.cloud.portal.req.project;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.time.DateFormatUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;
import com.ivucenter.cloud.portal.cmm.cloud.OssCloudService;
import com.ivucenter.cloud.portal.cmm.file.CmmFileService;
import com.ivucenter.cloud.portal.cmm.file.CustomCmmFileVO;
import com.ivucenter.cloud.portal.cmm.user.CmmUserService;
import com.ivucenter.cloud.portal.cmm.user.CustomCmmUserVO;
import com.ivucenter.cloud.portal.login.UserSession;
import com.ivucenter.cloud.portal.oss.project.CustomOssProjectVO;
import com.ivucenter.cloud.portal.req.customer.CustomReqCustomerVO;
import com.ivucenter.cloud.portal.req.product.CustomReqProductVO;
import com.ivucenter.cloud.portal.req.product.ReqProductService;
import com.ivucenter.cloud.portal.util.CodeUtil;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value="/mbr/req/project")
public class MbrOkProjectController {

	@Autowired
	private ReqProjectService reqProjectService;

	@Autowired
	private CmmFileService cmmFileService;

	@Autowired
	private 	CmmUserService cmmUserService;

	@Autowired
	private ReqProductService reqProductService;

	@Autowired
	private OssCloudService ossCloudService;


	//프로젝트 신청현황 목록 화면
	@RequestMapping(value = "/projectStatusListPage")
	public String projectStatusListPage(){

		return "mbr/req/project/projectStatusList";
	}


	//프로젝트 신청 내용
	@RequestMapping(value = "/projectWrite.do",params="!type")
	public String projectWrite(HttpServletRequest request, ModelMap model) {

		String loginUserId = request.getUserPrincipal().getName();

		// 로그인 유저 정보 (한전 특화)
		CustomCmmUserVO cmmUserInfo = new CustomCmmUserVO();
		cmmUserInfo.setUserId(loginUserId);
		cmmUserInfo = cmmUserService.userInfoDetail(cmmUserInfo);
		model.addAttribute("userLevelCode", cmmUserInfo.getUserLevelCode());

		String reqProjectSeq =  request.getParameter("reqProjectSeq");
		model.addAttribute("orderNo", reqProjectSeq);

		Map<String, String> param = new HashMap<String, String>();
		param.put("userId", loginUserId);
		param.put("orderNo", reqProjectSeq);

		// 승인스텝멤버 불러오기
		String stepId = reqProductService.getStepId(param);
		model.addAttribute("stepId", stepId);

		String userApprvState ="";
		userApprvState = reqProductService.getUserApprvState(param);
		model.addAttribute("userApprvState", userApprvState);

		List<CustomReqProductVO> approvalList = reqProductService.approvalList(param);
		for (int i = 0; i < approvalList.size(); i++) {
			if(approvalList.get(i).getApprvState().equals("APPRV_REJECTED") || approvalList.get(i).getApprvState().equals("APPRV_CANCELLED")){
				String inject ="Y";
				model.addAttribute("inject",inject);
			}
		}
		model.addAttribute("getProjectAppSteplist", approvalList);

		//프로젝트 신청 정보
		CustomReqProjectVO getProjectView = reqProjectService.getProjectView(reqProjectSeq);
		model.addAttribute("getProjectView", getProjectView);


		List<CustomOssCloudVO> ossCloudList = ossCloudService.getCloudList();
		model.addAttribute("ossCloudList", ossCloudList);

		CustomCmmFileVO vo = new CustomCmmFileVO();
		vo.setProgramName(CodeUtil.FILE_PROGRAM_NAME4);
		vo.setProgramSeq(reqProjectSeq+"");
		model.addAttribute("file", cmmFileService.list(vo));
		model.addAttribute("downloadNo", reqProjectSeq);


		return "mbr/req/project/projectWrite";
	}


	// REQ 프로젝트 신청화면
	@RequestMapping(value = {"/", "/projectInsert.do"},params="!type")
	@Secured( {"ROLE_CUSTOM_USER"} )
	public String projectInsert(HttpServletRequest request, Model model, CustomReqProjectVO vo){

		UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		model.addAttribute("apprvPass", userSession.getApprvPass());
		//userSession.getRoles();

		// boolean check = userSession.getAuthorities().contains(new SimpleGrantedAuthority("ROLE_CLOUD_OPERATION"));

		String loginUserId = request.getUserPrincipal().getName();
		vo.setRegUserId(loginUserId);

		CustomCmmUserVO cmmUserInfo = new CustomCmmUserVO();
		cmmUserInfo.setUserId(request.getUserPrincipal().getName());
		cmmUserInfo = cmmUserService.userInfoDetail(cmmUserInfo);
		model.addAttribute("userDeptCode", cmmUserInfo.getDeptCode());
		model.addAttribute("userDeptName", cmmUserInfo.getDeptNameOnly());
		model.addAttribute("userCustomerName", cmmUserInfo.getCustomerName());
		model.addAttribute("userCustomerId", cmmUserInfo.getCustomerId());
		model.addAttribute("userLevelCode", cmmUserInfo.getUserLevelCode());


		List<CustomOssCloudVO> ossCloudList = ossCloudService.getCloudList();
		model.addAttribute("ossCloudList", ossCloudList);

		model.addAttribute("programName", CodeUtil.FILE_PROGRAM_NAME4);

		// projectSeq 생성
		String reqProjectSeq = DateFormatUtils.format(new Date(), "yyyyMMddHHmmss");
		model.addAttribute("programSeq", reqProjectSeq);

		return "mbr/req/project/projectInsert";
	}


	@RequestMapping(value = "/projectList.do",params="!type")
	@Secured( {"ROLE_CUSTOM_USER"} )
	public String projectList(){

		return "mbr/req/project/projectList";
	}

	@RequestMapping(value = "/projectApproveList.do",params="!type")
	@Secured( {"ROLE_CUSTOM_USER"} )
	public String projectApproveList(){

		return "mbr/req/project/projectApproveList";
	}

	// 승인 프로젝트 정보 수정화면 상세조회
	@RequestMapping(value = "/okProjectDetail")
	public ResponseEntity<Object> okProjectDetail(ModelMap model, CustomReqProjectVO req) {
		CustomReqProjectVO res = reqProjectService.getOkProjectView(req.getProjectBoxId());
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	// 프로젝트 > 프로젝트 현황(신청)
	@RequestMapping(value = "/okprojectList.do",params="!type")
	@Secured( {"ROLE_CUSTOM_USER"} )
	public String okprojectList(ModelMap model){
		//네트워크 목록
		//String codeKeyId="NET_DFLT_KIND";
		//List<CustomReqProjectVO> getProjectNetList = reqProjectService.getProjectNetList(codeKeyId);
		//model.addAttribute("code", getProjectNetList);

//		String userId =  mbrDetails.getId();
//		String sroles =  mbrDetails.getRoles(); // 아이디 구분 룰(회원사,사용자)
//		//프로젝트 목록
//		List<CustomReqProjectVO> getOkProjectList = null;
//		if(sroles.equals("00000000000001001")){
//			getOkProjectList = reqProjectService.getOkProjectCustomerList(userId);
//		}else{
//			getOkProjectList = reqProjectService.getOkProjectUserList(userId);
//		}
//
//		model.addAttribute("getOkProjectList", getOkProjectList);
//		model.addAttribute("userId", mbrDetails.getId());
//		model.addAttribute("roles", mbrDetails.getRoles());

		return "mbr/req/project/okprojectList";
	}

	// 프로젝트 > 프로젝트 승인(결재)
	@RequestMapping(value = "/projectOkList", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> projectOkList(CustomReqProjectVO req, HttpServletRequest request){
		log.info("=== projectOkList Controller ===");
		String res = "";

		String userId = request.getUserPrincipal().getName();
		req.setUserId(userId);

		res = reqProjectService.projectOkList(req);

		if(res.equals("")){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	// OSS 승인 프로젝트 상세
	@RequestMapping(value = "/okprojectView.do",params="!type", produces="text/plain;charset=UTF-8")
	@Secured( {"ROLE_CUSTOM_USER"} )
	public String okprojectView(HttpServletRequest request, Model model ){

		//프로젝트 상세
		String projectBoxId =  request.getParameter("projectBoxId");
		CustomReqProjectVO getOkProjectView = reqProjectService.getOkProjectView(projectBoxId);
		//log.debug("getProjectView.getProjectAlias : " + getProjectView.getProjectAlias());
		model.addAttribute("getOkProjectView", getOkProjectView);


		//프로젝트 첨부파일
		CustomCmmFileVO vo = new CustomCmmFileVO();
		vo.setProgramName(CodeUtil.FILE_PROGRAM_NAME4);
		vo.setProgramSeq(getOkProjectView.getProgramSeq()+"");

		model.addAttribute("file", cmmFileService.list(vo));
		model.addAttribute("downloadNo", getOkProjectView.getProgramSeq());

		CustomOssProjectVO projectVo = new CustomOssProjectVO();
		projectVo.setProjectBoxId(projectBoxId);
		projectVo.setCloudType("LaaS");
		List<CustomOssProjectVO> cloudProjectInfo = reqProjectService.cloudProjectInfoLass(projectVo);
		model.addAttribute("cloudProjectInfo",cloudProjectInfo);


		projectVo.setCloudType("PaaS");
		List<CustomOssProjectVO> cloudProjectInfoOpenShift = reqProjectService.cloudProjectInfoLass(projectVo);
		model.addAttribute("cloudProjectPassInfo",cloudProjectInfoOpenShift);

		//프로젝트 manager

		CustomReqCustomerVO customReqCustomerVO = new CustomReqCustomerVO();

		customReqCustomerVO.setProjectBoxId(projectBoxId);
		List<CustomReqCustomerVO> managerList = reqProjectService.managerList(customReqCustomerVO);
		for(CustomReqCustomerVO vo1 : managerList) {
			vo1.setUserPhone(vo1.getUserPhoneDec());
			vo1.setUserMail(vo1.getUserMailDec());
			vo1.setUserTel(vo1.getUserTelDec());
    	}
		model.addAttribute("managerList", managerList);

		CustomOssCloudVO CustomOssCloudVO = new CustomOssCloudVO();
		CustomOssCloudVO.setProjectBoxId(projectBoxId);

		List<CustomOssCloudVO> ossCloudList = ossCloudService.getCloudprojectList(CustomOssCloudVO);
		model.addAttribute("ossCloudList", ossCloudList);

		return "mbr/req/project/okprojectView";
	}


	// OSS 승인 프로젝트 수정
	@RequestMapping(value = "/okprojectWrite.do",params="!type", produces="text/plain;charset=UTF-8")
	public String okprojectWite(HttpServletRequest request, Model model ){

		UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	    model.addAttribute("apprvPass", userSession.getApprvPass());

		//프로젝트 상세
		String projectBoxId =  request.getParameter("projectBoxId");
		CustomReqProjectVO getOkProjectView = reqProjectService.getOkProjectView(projectBoxId);
		//log.debug("getProjectView.getProjectAlias : " + getProjectView.getProjectAlias());
		model.addAttribute("getOkProjectView", getOkProjectView);

		//프로젝트 첨부파일
		CustomCmmFileVO vo = new CustomCmmFileVO();
		vo.setProgramName(CodeUtil.FILE_PROGRAM_NAME4);
		vo.setProgramSeq(getOkProjectView.getProgramSeq()+"");

		model.addAttribute("file", cmmFileService.list(vo));
		model.addAttribute("downloadNo", getOkProjectView.getProgramSeq());


		CustomCmmUserVO cmmUserInfo = new CustomCmmUserVO();
		cmmUserInfo.setUserId(request.getUserPrincipal().getName());
		cmmUserInfo = cmmUserService.userInfoDetail(cmmUserInfo);
		model.addAttribute("userDeptCode", cmmUserInfo.getDeptCode());
		model.addAttribute("userDeptName", cmmUserInfo.getDeptNameOnly());
		model.addAttribute("userCustomerName", cmmUserInfo.getCustomerName());
		model.addAttribute("userCustomerId", cmmUserInfo.getCustomerId());
		model.addAttribute("userLevelCode", cmmUserInfo.getUserLevelCode());


		CustomReqCustomerVO customReqCustomerVO = new CustomReqCustomerVO();

		List<CustomReqCustomerVO> managerList = reqProjectService.managerList(customReqCustomerVO);
		for(CustomReqCustomerVO vo1 : managerList) {
			vo1.setUserPhone(vo1.getUserPhoneDec());
			vo1.setUserMail(vo1.getUserMailDec());
			vo1.setUserTel(vo1.getUserTelDec());
    	}
		model.addAttribute("managerList", managerList);

		CustomOssCloudVO CustomOssCloudVO = new CustomOssCloudVO();
		CustomOssCloudVO.setProjectBoxId(projectBoxId);

		List<CustomOssCloudVO> ossCloudList = ossCloudService.getCloudprojectList(CustomOssCloudVO);
		model.addAttribute("ossCloudList", ossCloudList);


		return "mbr/req/project/okprojectWrite";
	}

	@RequestMapping(value="/managerListGrid", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> ossProjectManagerList(CustomReqCustomerVO req, Model model){
		return new ResponseEntity<Object>(reqProjectService.managerListGrid(req), HttpStatus.OK);
	}

	//승인 프로젝트 해지 신청 화면
	@RequestMapping(value = "/okprojectExpr.do",params="!type")
	public String okprojectExpr(HttpServletRequest request, ModelMap model, Model md){

		String projectBoxId =  request.getParameter("projectBoxId");
		Assert.notNull(projectBoxId, "");

		CustomReqProjectVO getOkProjectView = reqProjectService.getOkProjectView(projectBoxId);
		model.addAttribute("getOkProjectView", getOkProjectView);

		return "mbr/req/project/okprojectExpr";
	}

	// REQ 프로젝트 신청 내용
	@RequestMapping(value = "/projectView.do",params="!type")
	public String projectView(HttpServletRequest request, ModelMap model) {

		String reqProjectSeq =  request.getParameter("reqProjectSeq");
		model.addAttribute("orderNo", reqProjectSeq);
		model.addAttribute("reqProjectSeq", reqProjectSeq);

		Map<String, String> param = new HashMap<String, String>();
		param.put("userId", request.getUserPrincipal().getName());
		param.put("orderNo", reqProjectSeq);

		// 승인스텝멤버 불러오기
		String stepId = reqProductService.getStepId(param);
		model.addAttribute("stepId", stepId);

		String userApprvState ="";
		userApprvState = reqProductService.getUserApprvState(param);
		model.addAttribute("userApprvState", userApprvState);
		String inject ="N";
		List<CustomReqProductVO> approvalList = reqProductService.approvalList(param);
		for (int i = 0; i < approvalList.size(); i++) {
			if(approvalList.get(i).getApprvState().equals("APPRV_REJECTED") || approvalList.get(i).getApprvState().equals("APPRV_CANCELLED")){
				inject ="Y";
			}
		}
		model.addAttribute("inject",inject);
		model.addAttribute("getProjectAppSteplist", approvalList);

		//프로젝트 신청 정보
		CustomReqProjectVO getProjectView = reqProjectService.getProjectView(reqProjectSeq);		//
		model.addAttribute("getProjectView", getProjectView);

		//프로젝트 manager
		List<CustomReqCustomerVO> managerList = reqProjectService.reqManagerList(reqProjectSeq);
		for(CustomReqCustomerVO vo1 : managerList) {
			vo1.setUserPhone(vo1.getUserPhoneDec());
			vo1.setUserMail(vo1.getUserMailDec());
			vo1.setUserTel(vo1.getUserTelDec());
    	}
		model.addAttribute("managerList", managerList);

		CustomCmmFileVO vo = new CustomCmmFileVO();
		vo.setProgramName(CodeUtil.FILE_PROGRAM_NAME4);
		vo.setProgramSeq(reqProjectSeq+"");
		model.addAttribute("file", cmmFileService.list(vo));
		model.addAttribute("downloadNo", reqProjectSeq);

		List<CustomOssCloudVO> reqProjectCloudList = ossCloudService.getReqProjectCloudListByReqProjectSeq(reqProjectSeq);
		model.addAttribute("reqProjectCloudList", reqProjectCloudList);

		return "mbr/req/project/projectView";
	}

	/**
	 * 프로젝트 신청 내용
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/projectApproveView.do",params="!type")
	public String projectApproveView(HttpServletRequest request, ModelMap model) {

		String reqProjectSeq =  request.getParameter("reqProjectSeq");
		model.addAttribute("orderNo", reqProjectSeq);
		model.addAttribute("reqProjectSeq", reqProjectSeq);

		Map<String, String> param = new HashMap<String, String>();
		param.put("userId", request.getUserPrincipal().getName());
		param.put("orderNo", reqProjectSeq);

		// 승인스텝멤버 불러오기
		String stepId = reqProductService.getStepId(param);
		model.addAttribute("stepId", stepId);

		String userApprvState ="";
		userApprvState = reqProductService.getUserApprvState(param);
		model.addAttribute("userApprvState", userApprvState);

		List<CustomReqProductVO> approvalList = reqProductService.approvalList(param);
		for (int i = 0; i < approvalList.size(); i++) {
			if(approvalList.get(i).getApprvState().equals("APPRV_REJECTED") || approvalList.get(i).getApprvState().equals("APPRV_CANCELLED")){
				String inject ="Y";
				model.addAttribute("inject",inject);
			}
		}
		model.addAttribute("getProjectAppSteplist", approvalList);

		//프로젝트 신청 정보
		CustomReqProjectVO getProjectView = reqProjectService.getProjectView(reqProjectSeq);
		model.addAttribute("getProjectView", getProjectView);

		//프로젝트 manager
		List<CustomReqCustomerVO> managerList = reqProjectService.reqManagerList(reqProjectSeq);
		for(CustomReqCustomerVO vo1 : managerList) {
			vo1.setUserPhone(vo1.getUserPhoneDec());
			vo1.setUserMail(vo1.getUserMailDec());
			vo1.setUserTel(vo1.getUserTelDec());
    	}
		model.addAttribute("managerList", managerList);

		CustomCmmFileVO vo = new CustomCmmFileVO();
		vo.setProgramName(CodeUtil.FILE_PROGRAM_NAME4);
		vo.setProgramSeq(reqProjectSeq+"");
		model.addAttribute("file", cmmFileService.list(vo));
		model.addAttribute("downloadNo", reqProjectSeq);

		List<CustomOssCloudVO> reqProjectCloudList = ossCloudService.getOssProjectCloudListByReqProjectSeq(reqProjectSeq);
		model.addAttribute("reqProjectCloudList", reqProjectCloudList);


		return "mbr/req/project/projectApproveView";
	}

}
