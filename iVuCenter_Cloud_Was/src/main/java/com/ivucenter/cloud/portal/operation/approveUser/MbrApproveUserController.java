package com.ivucenter.cloud.portal.operation.approveUser;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;
import com.ivucenter.cloud.portal.cmm.cloud.OssCloudService;
import com.ivucenter.cloud.portal.login.UserSession;
import com.ivucenter.cloud.portal.req.catalogue.ReqCatalogueService;
import com.ivucenter.cloud.portal.req.customer.CustomReqCustomerVO;

@Controller
@RequestMapping(value="/mbr/operation/approveUser")
public class MbrApproveUserController {
	
	@Autowired
	private ApproveUserService service;
		
	@Autowired
	private ReqCatalogueService reqCatalogueService;
	
	@Autowired
	OssCloudService cloudService;
	
//	@Autowired	private ReqProductService reqProductService;
	
	/**
	 *	PAGE 
	 */
	@RequestMapping(value="/approve.do")
	public String MngadminUserList(Model model){		
		return "mbr/operation/approveUser/operationApproveUser-list";
	}
	@RequestMapping(value="/view")
	public String MngAdminUserView(CustomApproveUserVO req, Model model){
		model.addAttribute("req", req);
		return "mbr/operation/approveUser/operationApproveUser-view";		
	}
	
	//프로젝트 결재자 지정화면
	@RequestMapping(value="/projectView")
	public String MbrProjectApproveUserView(CustomApproveUserVO req, Model model){
		model.addAttribute("req", req);
		return "mbr/operation/approveUser/operationApproveUserProject-view";		
	}
	
	/**
	 *	ACTION 
	 */
	@RequestMapping(value="/list", produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> MngAdminUserList(CustomApproveUserVO req, Model model){
		return new ResponseEntity<Object>(service.list(req), HttpStatus.OK);
	}
		
	@RequestMapping(value="/projectList", produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> MngProjectUserList(CustomApproveUserVO req, Model model){
		return new ResponseEntity<Object>(service.projectList(req), HttpStatus.OK);
	}
	@RequestMapping(value="/projectManagerList", produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> MngProjectManagerUserList(CustomApproveUserVO req, Model model){
		return new ResponseEntity<Object>(service.projectManagerList(req), HttpStatus.OK);
	}
	@RequestMapping(value="/projectManagerWriteList", produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> projectManagerWriteList(CustomApproveUserVO req, Model model){
		return new ResponseEntity<Object>(service.projectManagerWriteList(req), HttpStatus.OK);
	}
	@RequestMapping(value="/ossProjectManagerList", produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> ossProjectManagerList(CustomApproveUserVO req, Model model){
		return new ResponseEntity<Object>(service.ossProjectManagerList(req), HttpStatus.OK);
	}
	@RequestMapping(value="/addList")
	public ResponseEntity<Object> MngAdminUserAddList(CustomApproveUserVO req, Model model){
		return new ResponseEntity<Object>(service.addList(req), HttpStatus.OK);
	}
	//프로젝트 결재자 지정팝업  
	@RequestMapping(value="/addProjectApproveList" , produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> MbrAdminUserAddList(CustomApproveUserVO req, Model model){
		 UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();		
	     req.setUserId(userSession.getUsername());
	     CustomOssCloudVO cloudRoles = cloudService.getCloudroles();
	     String cloudRole[] = cloudRoles.getCloudRoles().split(",");
	     for(int i = 0; i < cloudRole.length; i++) {
	    	 if(cloudRole[i].equals(req.getCloudId())) {
	    		 req.setSearchCloud(i+1);
	    	 }
	     }
		return new ResponseEntity<Object>(service.addProjectApproveList(req), HttpStatus.OK);
	}
	//프로젝트 결재자 지정팝업  
	@RequestMapping(value="/addProjectApprove2List" , produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> MbrAdminUserAdd2List(CustomApproveUserVO req, Model model){
		UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();		
		req.setUserId(userSession.getUsername());
		
		return new ResponseEntity<Object>(service.addProjectApprove2List(req), HttpStatus.OK);
	}
	
	//프로젝트 관리자 지정팝업 
	@RequestMapping(value="/addProjectManageList" , produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> MbrAdminManageAddList(CustomApproveUserVO req, Model model){
        UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();		
        req.setUserId(userSession.getUsername());
        req.setDeptCode(userSession.getDeptCode());
		
		return new ResponseEntity<Object>(service.addProjectManageList(req), HttpStatus.OK);
	}
	
	@RequestMapping(value="/addOssProjectManageList" , produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> addOssProjectManageList(CustomApproveUserVO req, Model model){
        UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();	
        req.setUserId(userSession.getUsername());
        req.setDeptCode(userSession.getDeptCode());
		return new ResponseEntity<Object>(service.addOssProjectManageList(req), HttpStatus.OK);
	}
		
	@RequestMapping(value="/auth")
	public ResponseEntity<Object> MngAdminUserAuth(CustomApproveUserVO req, Model model){
		return new ResponseEntity<Object>(service.auth(req), HttpStatus.OK);
	}
	@RequestMapping(value = "/excel")
	public ModelAndView MngAdminUserExcel(CustomApproveUserVO req, ModelMap map) {
		map.addAttribute("excel_gbn", "adminUser");
		map.addAttribute("excel_title", "부서별권한관리");
		map.addAttribute("excel_list", service.excel(req));
		
		return new ModelAndView("operationExcelView", map);
	}	
	
	@RequestMapping(value="/insertAdmin")
	public ResponseEntity<Object> MbrAdminUserInsertAdmin(CustomApproveUserVO req, Model model){
		
        // 승인자 지정시 프로젝트 승인스탭 입력 시작

				
//		List<CustomReqProductVO> list = reqProductService.stepIdList(CodeUtil.APPROVAL_MODEL_STEP_WF3000A0);

		List<CustomReqCustomerVO> getApprovalModelSteplist = reqCatalogueService.getApprovalModelSteplistProject();
		for(int i=0;i<getApprovalModelSteplist.size();i++){			
			CustomReqCustomerVO appmodelstep = new CustomReqCustomerVO();
			appmodelstep.setRequestSeq(req.getProgramSeq());
			appmodelstep.setStepId(getApprovalModelSteplist.get(i).getStepId());
		if(!appmodelstep.getStepId().equals(""))
			{
						
			}
			appmodelstep.setModelId(getApprovalModelSteplist.get(i).getModelId());
			appmodelstep.setStepName(getApprovalModelSteplist.get(i).getStepName());
			appmodelstep.setStepLevel(getApprovalModelSteplist.get(i).getStepLevel());
			appmodelstep.setLeftStepId(getApprovalModelSteplist.get(i).getLeftStepId());
			appmodelstep.setRightStepId(getApprovalModelSteplist.get(i).getRightStepId());
		if(appmodelstep.getStepLevel().equals("1")){
			appmodelstep.setApprvState("APPRV_PROCESSING");
		}else{
			appmodelstep.setApprvState("APPRV_WAITING");
		}
		        int projectStepcount = reqCatalogueService.projectStepCheck(appmodelstep);
		        if(projectStepcount == 0) {
				  reqCatalogueService.setSrApprovalStepinsertProject(appmodelstep);
		        }
		}
				
		// 프로젝트 신청시 결재라인 등록
//		CustomReqCatalogueVO getProjectId = reqCatalogueService.getProjectId(req.getProgramSeq());
		// 프로젝트 결재자 리스트
		List<CustomReqCustomerVO> getApprovalModelMemberlist = reqCatalogueService.getApproveModelMemberlistProject(req.getUserId());
		for(int i=0;i<getApprovalModelMemberlist.size();i++){				
			CustomReqCustomerVO appmember = new CustomReqCustomerVO();
			appmember.setRequestSeq(req.getProgramSeq());
			appmember.setStepId(getApprovalModelMemberlist.get(i).getStepId());
			appmember.setUserId(getApprovalModelMemberlist.get(i).getUserId());
			appmember.setApprvAuthFlag(getApprovalModelMemberlist.get(i).getApprvAuthFlag());
			appmember.setMailRecvFlag(getApprovalModelMemberlist.get(i).getMailRecvFlag());
			appmember.setSmsRecvFlag(getApprovalModelMemberlist.get(i).getSmsRecvFlag());
			appmember.setPushRecvFlag(getApprovalModelMemberlist.get(i).getPushRecvFlag());
		
			int memberCount = reqCatalogueService.projectMemberCheck(appmember);
			if(memberCount == 0) {
				reqCatalogueService.setSrApprovalMemberinsert2(appmember);
			}

			// 프로젝트 1차 결재자 2차 결재자 디폴트 로직 구현
			if(appmember.getStepId().equals("WF3000A0") || appmember.getStepId().equals("WF3000B0")) {
			reqCatalogueService.updateProjectApprovalMemberInsert(appmember);
			}
		}
		return new ResponseEntity<Object>(service.insertPm(req), HttpStatus.OK);
	}
	
	
	@RequestMapping(value="/insertUserAdmin")
	public ResponseEntity<Object> MngAdminUserInsert(CustomApproveUserVO req, Model model){
		return new ResponseEntity<Object>(service.insertAdmin(req), HttpStatus.OK);
	}	
	
	@RequestMapping(value="/insertManager")
	public ResponseEntity<String> MngAdminUserInsertManager(CustomApproveUserVO req, Principal principal){
		
		String res = "";
		int projectManagerCount = service.projectManagerCount(req);
		int projectManagerCheck = service.projectManagerCheck(req);
		
		if(projectManagerCheck < 5) {
			if(projectManagerCount == 0) {
				service.insertManager(req);
				res = "1";
				return new ResponseEntity<String>(res, HttpStatus.OK); 
			}else {
				service.updateManager(req);
				res = "1";
				return new ResponseEntity<String>(res, HttpStatus.OK);
			}
		}
	    
		res = "4";
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
	
	
	@RequestMapping(value="/ossInsertManager")
	public ResponseEntity<String> ossInsertManager(CustomApproveUserVO req, Principal principal){
		
        UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();		
        req.setRegUserId(userSession.getUsername());    
		
		String res = "";
		
		int projectManagerCheck = service.ossProjectManagerCheck(req);
		
		
		if(projectManagerCheck < 4) {
				service.ossInsertManager(req);
				res = "1";
				return new ResponseEntity<String>(res, HttpStatus.OK); 
		}
		    res = "2";
		return new ResponseEntity<String>(res, HttpStatus.OK);
				
	}
		
	@RequestMapping(value="/updateAdmin")
	public ResponseEntity<Object> MngAdminUserUpdateAdmin(CustomApproveUserVO req, Model model){
		return new ResponseEntity<Object>(service.updateAdmin(req), HttpStatus.OK);
	}
	
}
