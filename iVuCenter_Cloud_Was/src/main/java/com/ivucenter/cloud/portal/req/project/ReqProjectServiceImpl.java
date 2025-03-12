package com.ivucenter.cloud.portal.req.project;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;
import com.ivucenter.cloud.api.openstack.connector.OpenStackRestConnector;
import com.ivucenter.cloud.api.openstack.object.OpenStackComplexQuota;
import com.ivucenter.cloud.portal.alarms.template.AlarmsTemplateService;
import com.ivucenter.cloud.portal.approval.ApprovalService;
import com.ivucenter.cloud.portal.approval.CustomApprovalVO;
import com.ivucenter.cloud.portal.cmm.user.CustomCmmUserVO;
import com.ivucenter.cloud.portal.oss.project.CustomOssProjectVO;
import com.ivucenter.cloud.portal.req.customer.CustomReqCustomerVO;
import com.ivucenter.cloud.portal.req.user.CustomReqUserVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service("reqProjectService")
public class ReqProjectServiceImpl implements ReqProjectService{

    private static final Logger logger = LoggerFactory.getLogger(ReqProjectServiceImpl.class);

	@Autowired
	ReqProjectService reqProjectService;

	@Resource(name="reqProjectDAO")
	private ReqProjectDAO reqProjectDAO;

	@Autowired
	private AlarmsTemplateService alarmsTemplateService;

	@Autowired
	private ApprovalService approvalService;

	//project ��û �̸� �ߺ�üũ
	@Override
	public int setProjectNamechk(CustomReqProjectVO projectvo) {
		return reqProjectDAO.setProjectNamechk(projectvo);
	}
	@Override
	public int setProjectApprove1chk(CustomReqProjectVO projectvo) {
		return reqProjectDAO.setProjectApprove1chk(projectvo);
	}
	@Override
	public int setProjectApprove2chk(CustomReqProjectVO projectvo) {
		return reqProjectDAO.setProjectApprove2chk(projectvo);
	}

	@Override
	public int setManagerTypechk(CustomReqProjectVO projectvo) {
		return reqProjectDAO.setManagerTypechk(projectvo);
	}

	@Override
	public int setProjectManagerChk(CustomReqProjectVO projectvo) {
		return reqProjectDAO.setProjectManagerChk(projectvo);
	}

	//project ��û �Է�
	@Override
	public void setProjectForminsert(CustomReqProjectVO projectvo) {
		log.debug("=== setMbrForminsert Service ===");
		reqProjectDAO.setProjectForminsert(projectvo);
	}

	@Override
	public void setProjectCloudForminsert(CustomReqProjectVO projectvo) {
		reqProjectDAO.setProjectCloudForminsert(projectvo);
	}

	@Override
	public int reqProjectCloudChk(CustomReqProjectVO projectvo) {
		return reqProjectDAO.reqProjectCloudChk(projectvo);
	}


	@Override
	public void setProjectManagerUpdate(CustomReqProjectVO projectvo) {
		reqProjectDAO.setProjectManagerUpdate(projectvo);
	}

	@Override
	public void setProjectAdminiStratorInsert(CustomReqProjectVO projectvo) {
		reqProjectDAO.setProjectAdminiStratorInsert(projectvo);
	}


	//��Ʈ��ũ ����Ʈ
//	@Override
//	public List<CustomReqProjectVO> getProjectNetList(String codeKeyId){
//		log.debug("=== getProjectNetList Service ===");
//		return reqProjectDAO.getProjectNetList(codeKeyId);
//	}
//	@Override
//	public List<CustomReqProjectVO> getProjectNetList2(CustomReqProjectVO vo){
//		log.debug("=== getProjectNetList Service ===");
//		return reqProjectDAO.getProjectNetList2(vo);
//	}

	//��Ʈ��ũ ��û �Է�
	@Override
	public void setProjectNetinsert(CustomReqProjectVO projectvo) {
		log.debug("=== setProjectNetinsert Service ===");
		reqProjectDAO.setProjectNetinsert(projectvo);
	}

	@Override
	public void updateReqProjectCloudLimit(CustomReqProjectVO projectvo) {
		reqProjectDAO.updateReqProjectCloudLimit(projectvo);
	}

	@Override
	public void updateReqProjectCompeteFlag(CustomReqProjectVO projectvo) {
		reqProjectDAO.updateReqProjectCompeteFlag(projectvo);
	}

	//project 리스트
	@Override
	public String getProjectList(CustomReqProjectVO req){

		log.debug("=== getProjectList Service ===");
		int recordsTotal;
	    int recordsFiltered;
	    List<CustomReqProjectVO> lists = new ArrayList<>();

	    lists = reqProjectDAO.getProjectList(req);
    	recordsTotal = reqProjectDAO.getProjectListTot(req);
	    recordsFiltered = recordsTotal;

	    try {
	        JsonObject jsonResponse = new JsonObject();
	        Gson gson = new Gson();

	        jsonResponse.addProperty("draw", req.getDraw());
	        jsonResponse.addProperty("recordsTotal", recordsTotal);
	        jsonResponse.addProperty("recordsFiltered", recordsFiltered);
	        jsonResponse.add("data", gson.toJsonTree(lists));

	        return jsonResponse.toString();
	    } catch (JsonIOException e) {
	    	log.error(e.getMessage());
	    }
		return "";
		//log.debug("=== getProjectList Service ===");
		//return reqProjectDAO.getProjectList(req);
	}


	/**
	 * project 리스트
	 */
	@Override
	public String getProjectApproveList(CustomReqProjectVO req){

		log.debug("=== getProjectList Service ===");
		int recordsTotal;
	    int recordsFiltered;
	    List<CustomReqProjectVO> lists = new ArrayList<>();

	    lists = reqProjectDAO.getProjectApproveList(req);
    	recordsTotal = reqProjectDAO.getProjectApproveListTot(req);
	    recordsFiltered = recordsTotal;

	    try {
	        JsonObject jsonResponse = new JsonObject();
	        Gson gson = new Gson();

	        jsonResponse.addProperty("draw", req.getDraw());
	        jsonResponse.addProperty("recordsTotal", recordsTotal);
	        jsonResponse.addProperty("recordsFiltered", recordsFiltered);
	        jsonResponse.add("data", gson.toJsonTree(lists));

	        return jsonResponse.toString();
	    } catch (JsonIOException e) {
	    	log.error(e.getMessage());
	    }
		return "";
	}

	//project admin 리스트
	@Override
	public String getProjectAdminList(CustomReqProjectVO req){

		log.debug("=== getProjectList Service ===");
		int recordsTotal;
	    int recordsFiltered;
	    List<CustomReqProjectVO> lists = new ArrayList<>();

	    lists = reqProjectDAO.getProjectAdminList(req);
    	recordsTotal = reqProjectDAO.getProjectAdminListTot(req);
	    recordsFiltered = recordsTotal;

	    try {
	        JsonObject jsonResponse = new JsonObject();
	        Gson gson = new Gson();

	        jsonResponse.addProperty("draw", req.getDraw());
	        jsonResponse.addProperty("recordsTotal", recordsTotal);
	        jsonResponse.addProperty("recordsFiltered", recordsFiltered);
	        jsonResponse.add("data", gson.toJsonTree(lists));

	        return jsonResponse.toString();
	    } catch (JsonIOException e) {
	    	log.error(e.getMessage());
	    }
		return "";
		//log.debug("=== getProjectList Service ===");
		//return reqProjectDAO.getProjectList(req);
	}


	// projectCard 리스트
	@Override
	public List<CustomReqProjectVO> getProjectCardList(CustomReqProjectVO req){
		return reqProjectDAO.getProjectList(req);
	}

	public CustomCmmUserVO getUserInfo(String reqProjectSeq){
		log.debug("=== getUserInfo Service ===");
		return VoToDec(reqProjectDAO.getUserInfo(reqProjectSeq));
	}
	public CustomCmmUserVO VoToDec(CustomCmmUserVO vo){
		if(vo != null){
			vo.setUserPhone(vo.getUserPhoneDec());
			vo.setUserTel(vo.getUserTelDec());
			vo.setUserTelEx(vo.getUserTelExDec());
			vo.setUserMail(vo.getUserMailDec());
		}
		return vo;
	}

	public CustomCmmUserVO VoToEnc(CustomCmmUserVO vo){
		if(vo != null){
			vo.setUserPhone(vo.getUserPhoneEnc());
			vo.setUserTel(vo.getUserTelEnc());
			vo.setUserTelEx(vo.getUserTelExEnc());
			vo.setUserMail(vo.getUserMailEnc());
		}
		return vo;
	}

	@Override
	public CustomReqProjectVO getProjectView(String reqProjectSeq){
		log.debug("=== getProjectView Service ===");
		return reqProjectDAO.getProjectView(reqProjectSeq);
	}

	@Override
	public CustomReqProjectVO getReqProjectCloudQuota(CustomReqProjectVO req){
		log.debug("=== getProjectView Service ===");
		return reqProjectDAO.getReqProjectCloudQuota(req);
	}


	@Override
	public List<CustomReqProjectVO> getProjectCloudView(String reqProjectSeq){
		return reqProjectDAO.getProjectCloudView(reqProjectSeq);
	}

	@Override
	public List<CustomReqProjectVO> getProjectSubnetList(CustomReqProjectVO req){
		return reqProjectDAO.getProjectSubnetList(req);
	}
	@Override
	public CustomReqProjectVO getProjectDefaultSubnet(CustomReqProjectVO req){
		log.debug("=== getProjectView Service ===");
		return reqProjectDAO.getProjectDefaultSubnet(req);
	}

	@Override
	public void setProjectFormEdit(CustomReqProjectVO projectvo) {
		log.debug("=== setProjectFormEdit Service ===");
		reqProjectDAO.setProjectFormEdit(projectvo);
	}

	@Override
	public void setProjectNetdel(CustomReqProjectVO projectvo) {
		log.debug("=== setProjectNetdel Service ===");
		reqProjectDAO.setProjectNetdel(projectvo);
	}

	@Override
	public List<CustomReqCustomerVO> getApprovalModelSteplist() {
		log.debug("=== getApprovalModelSteplist Service ===");
		return reqProjectDAO.getApprovalModelSteplist();
	}

	@Override
	public void setSrApprovalStepinsert(CustomReqCustomerVO appmodelstep) {
		log.debug("=== setSrApprovalStepinsert Service ===");
		reqProjectDAO.setSrApprovalStepinsert(appmodelstep);
	}

	@Override
	public List<CustomReqCustomerVO> getApprovalModelMemberlist() {
		log.debug("=== getApprovalModelMemberlist Service ===");
		return reqProjectDAO.getApprovalModelMemberlist();
	}

	@Override
	public void setSrApprovalMemberinsert(CustomReqCustomerVO appmember) {
		log.debug("=== setSrApprovalMemberinsert Service ===");
		reqProjectDAO.setSrApprovalMemberinsert(appmember);
	}

	@Override
	public List<CustomReqCustomerVO> getProjectAppSteplist(String reqProjectSeq) {
		log.debug("=== getProjectAppSteplist Service ===");
		return reqProjectDAO.getProjectAppSteplist(reqProjectSeq);
	}

	@Override
	public List<CustomReqCustomerVO> managerList(CustomReqCustomerVO req) {
		log.debug("=== managerList Service ===");
		return reqProjectDAO.managerList(req);
	}


	@Override
	public String managerListGrid(CustomReqCustomerVO req){

		int recordsTotal;
	    int recordsFiltered;
	    List<CustomReqCustomerVO> lists = new ArrayList<>();

	    lists = reqProjectDAO.managerList(req);
    	recordsTotal = reqProjectDAO.managerListTotal(req);
	    recordsFiltered = recordsTotal;


    	List<CustomReqCustomerVO> decList = new LinkedList<CustomReqCustomerVO>();
    	for(CustomReqCustomerVO vo : lists){
    		vo.setUserPhone(vo.getUserPhoneDec());
			vo.setUserTel(vo.getUserTelDec());
			vo.setUserTelEx(vo.getUserTelExDec());
			vo.setUserMail(vo.getUserMailDec());
			decList.add(vo);
		}

	    try {
	        JsonObject jsonResponse = new JsonObject();
	        Gson gson = new Gson();

	        jsonResponse.addProperty("draw", req.getDraw());
	        jsonResponse.addProperty("recordsTotal", recordsTotal);
	        jsonResponse.addProperty("recordsFiltered", recordsFiltered);
	        jsonResponse.add("data", gson.toJsonTree(lists));

	        return jsonResponse.toString();
	    } catch (JsonIOException e) {
	    	log.error(e.getMessage());
	    }
		return "";
	}

	@Override
	public List<CustomReqCustomerVO> reqManagerList(String reqProjectSeq) {
		return reqProjectDAO.reqManagerList(reqProjectSeq);
	}

	@Override
	public List<CustomReqCustomerVO> reqWiteManagerList(String reqProjectSeq) {
		return reqProjectDAO.reqWiteManagerList(reqProjectSeq);
	}

	@Override
	public List<CustomReqProjectVO> getOkProjectList(){
		return reqProjectDAO.getOkProjectList();
	}

	@Override
	public CustomReqProjectVO getOkProjectView(String projectBoxId){
		log.debug("=== getOkProjectView Service ===");
		return reqProjectDAO.getOkProjectView(projectBoxId);
	}

	@Override
	public CustomReqProjectVO getProjectBoxId(String projectId){
		log.debug("=== getOkProjectView Service ===");
		return reqProjectDAO.getProjectBoxId(projectId);
	}


	@Override
	public CustomReqProjectVO getProjectWrite(String reqProjectSeq){
		return reqProjectDAO.getProjectWrite(reqProjectSeq);
	}

	//������Ʈ ȸ���� ��� ����Ʈ
	@Override
	public List<CustomReqUserVO> getCustomerMemberList(CustomReqProjectVO getOkProjectView){
		log.debug("=== getCustomerMemberList Service ===");
		return reqProjectDAO.getCustomerMemberList(getOkProjectView);
	}

	//������Ʈ ȸ���� ��� ����Ʈ 2
	@Override
	public List<CustomReqUserVO> getCustomerMemberchkList(CustomReqProjectVO getOkProjectView){
		log.debug("=== getCustomerMemberchkList Service ===");
		return reqProjectDAO.getCustomerMemberchkList(getOkProjectView);
	}

	//������Ʈ ��� ����Ʈ
	@Override
	public List<CustomReqProjectVO> getProjectMemberList(String projectId){
		log.debug("=== getProjectMemberList Service ===");
		return reqProjectDAO.getProjectMemberList(projectId);
	}

	@Override
	public String projectMemberlist(CustomReqProjectVO req) {
    	List<CustomReqProjectVO> lists = reqProjectDAO.projectMemberlist(req);

	    try {
	        JsonObject jsonResponse = new JsonObject();
	        Gson gson = new Gson();
	        jsonResponse.add("data", gson.toJsonTree(lists));
	        return jsonResponse.toString();
	    } catch (JsonIOException e) {
	    	log.error(e.getMessage());
	    }
		return "";
	}

	@Override
	public void setProjectMemberInsert(CustomReqProjectVO projectMembervo) {
		reqProjectDAO.setProjectMemberInsert(projectMembervo);
	}

	//������Ʈ PM ������Ʈ
	@Override
	public String setProjectPmupdate(CustomReqProjectVO req){
		return reqProjectDAO.setProjectPmupdate(req)+"";
	}

	@Override
	public String reqProjectStatusUpdate04(String reqProjectSeq){
		return reqProjectDAO.reqProjectStatusUpdate04(reqProjectSeq)+"";
	}

	//������Ʈ ��� ī����
	@Override
	public int getProjectMemberCnt(String projectId){
		return reqProjectDAO.getProjectMemberCnt(projectId);
	}

	@Override
	public void setProjectMemberDel(String projectId) {
		reqProjectDAO.setProjectMemberDel(projectId);
	}

	@Override
	public void setProjectMemberDel(CustomReqProjectVO req) {
		reqProjectDAO.setProjectMemberDel(req);
	}

	@Override
	public int deleteProjectApproveUserDelete(CustomReqProjectVO req) {
		return reqProjectDAO.deleteProjectApproveUserDelete(req);
	}

	@Override
	public int projectManagerUserDelete(CustomReqProjectVO req) {
		return reqProjectDAO.projectManagerUserDelete(req);
	}
	@Override
	public int ossProjectManagerUserDelete(CustomReqProjectVO req) {
		return reqProjectDAO.ossProjectManagerUserDelete(req);
	}

	@Override
	public int projectManagerUserUpdate(CustomReqProjectVO req) {
		return reqProjectDAO.projectManagerUserUpdate(req);
	}

	@Override
	public int projectManagerTypeUdate(CustomReqProjectVO req) {
		return reqProjectDAO.projectManagerTypeUdate(req);
	}

	@Override
	public int ossProjectManagerTypeUdate(CustomReqProjectVO req) {
		return reqProjectDAO.ossProjectManagerTypeUdate(req);
	}

	//관리자 - 프로젝트승인 - getProjectList
	@Override
	public String list(CustomReqProjectVO req) {
	    int recordsTotal; // �� ��
	    int recordsFiltered;	// �˻� �� ��

    	List<CustomReqProjectVO> lists = reqProjectDAO.list(req);
    	for(CustomReqProjectVO vo : lists) {
			vo.setUserTel(vo.getUserTelDec());
    	}

	    recordsTotal = reqProjectDAO.listTot(req).size();
	    recordsFiltered = recordsTotal;
	    try {
	        JsonObject jsonResponse = new JsonObject();
	        Gson gson = new Gson();

	        jsonResponse.addProperty("draw", req.getDraw());
	        jsonResponse.addProperty("recordsTotal", recordsTotal);
	        jsonResponse.addProperty("recordsFiltered", recordsFiltered);
	        jsonResponse.add("data", gson.toJsonTree(lists));

	        return jsonResponse.toString();
	    } catch (JsonIOException e) {
	    	log.error(e.getMessage());
	    }
		return "";
	}

	@Override
	public  CustomReqProjectVO detail(String reqProjectSeq){
		return reqProjectDAO.detail(reqProjectSeq);
	}

	@Override
	public String setprojectMemberRolchg(CustomReqProjectVO req){

		return reqProjectDAO.setprojectMemberRolchg(req)+"";
	}

	@Override
	public List<CustomReqUserVO> getCustomerMemberSerachList(CustomReqProjectVO req){
		return reqProjectDAO.getCustomerMemberSerachList(req);
	}
	@Override
	public String rejectedUpdate(CustomReqProjectVO req) {
		return reqProjectDAO.rejectedUpdate(req)+"";
	}
	@Override
	public String newUpdate(CustomReqProjectVO req) {
		return reqProjectDAO.newUpdate(req)+"";
	}

	@Override
	public String ossUpdate(CustomReqProjectVO req) {
		return reqProjectDAO.ossUpdate(req)+"";
	}

	@Override
	public String delete(CustomReqProjectVO req) {
		return reqProjectDAO.delete(req)+"";
	}

	//ȸ���� ��� �˻� ����Ʈ 2
	@Override
	public List<CustomReqUserVO> getCustomerMemberSerachchkList(CustomReqProjectVO req){
		return reqProjectDAO.getCustomerMemberSerachchkList(req);
	}

	//project ��� �˻� ����Ʈ
	@Override
	public List<CustomReqProjectVO> getProjectMemberSerachList(CustomReqProjectVO req){
		return reqProjectDAO.getProjectMemberSerachList(req);
	}

	//pm popup
	@Override
	public List<CustomReqUserVO> pmPopList(CustomReqProjectVO req){
		log.debug("=== pmPopList Service ===");
		return reqProjectDAO.pmPopList(req);
	}

	//승인프로젝트 정보 수정
	public String okProjectUpdate(CustomReqProjectVO req){
		return reqProjectDAO.okProjectUpdate(req)+"";
	}

	//승인프로젝트 정보 수정
	public String okProjectBoxUpdate(CustomReqProjectVO req){
		return reqProjectDAO.okProjectBoxUpdate(req)+"";
	}

	//승인프로젝트 정보 수정 history
	public String okProjectHistoryInsert(CustomReqProjectVO req){
		return reqProjectDAO.okProjectHistoryInsert(req)+"";
	}

	public String okOssProjectAdminiStratorInsert(CustomReqProjectVO req){
		return reqProjectDAO.okOssProjectAdminiStratorInsert(req)+"";
	}
	public String okOssProjectAdminiStratorUpdate(CustomReqProjectVO req){
		return reqProjectDAO.okOssProjectAdminiStratorUpdate(req)+"";
	}



	//승인프로젝트 정보 수정
	public String projectUpdate(CustomReqProjectVO req){
		return reqProjectDAO.projectUpdate(req)+"";
	}
	//프로젝트 관리자 insert
	public String projectAdminiStratorInsert(CustomReqProjectVO req){
		return reqProjectDAO.projectAdminiStratorInsert(req)+"";
	}
	public String projectAdminiStratorUpdate(CustomReqProjectVO req){
		return reqProjectDAO.projectAdminiStratorUpdate(req)+"";
	}


	//승인프로젝트 정보 수정
	public String srApprovalStepInsert(CustomReqCustomerVO req){
		return reqProjectDAO.srApprovalStepInsert(req)+"";
	}
	public String srApprovalStepUpdate(CustomReqProjectVO req){
		return reqProjectDAO.srApprovalStepUpdate(req)+"";
	}
	public String srApprovalStepApprv1StateUpdate(CustomReqProjectVO req){
		return reqProjectDAO.srApprovalStepApprv1StateUpdate(req)+"";
	}
	public String srApprovalStepApprv2StateUpdate(CustomReqProjectVO req){
		return reqProjectDAO.srApprovalStepApprv2StateUpdate(req)+"";
	}


	public String reqProjectStatusUpdate(CustomReqProjectVO req){
		return reqProjectDAO.reqProjectStatusUpdate(req)+"";
	}
	public String reqProjectDelete(CustomReqProjectVO req){
		return reqProjectDAO.reqProjectDelete(req)+"";
	}
	public String reqProjectManagerDelete(CustomReqProjectVO req){
		return reqProjectDAO.reqProjectManagerDelete(req)+"";
	}
	public String srApprovalStepDelete(CustomReqProjectVO req){
		return reqProjectDAO.srApprovalStepDelete(req)+"";
	}
	public String cmmFileDelete(CustomReqProjectVO req){
		return reqProjectDAO.cmmFileDelete(req)+"";
	}

	@Override
	public String insert(CustomReqProjectVO req, String projectId) {
		return reqProjectDAO.insert(req,projectId)+"";
	}

	@Override
	public String update(CustomReqProjectVO req) {
		return reqProjectDAO.update(req)+"";
	}

	@Override
	public String stepUpdate(CustomReqProjectVO req, String apprvState) {
		return reqProjectDAO.stepUpdate(req,apprvState)+"";
	}
	@Override
	public List<CustomReqProjectVO> approvalList(String requestSeq, String codeKeyId) {
		return reqProjectDAO.approvalList(requestSeq,codeKeyId);
	}

	@Override
	public List<CustomReqProjectVO> approvalUserId(String requestSeq) {
		return reqProjectDAO.approvalUserId(requestSeq);
	}

	// 프로젝트 신청현황 리스트
	@Override
	public String projectStatusList(CustomReqProjectVO req) {
	    int recordsTotal;
	    int recordsFiltered;

    	List<CustomReqProjectVO> lists = reqProjectDAO.projectStatusList(req);
//	    recordsTotal = reqProjectDAO.listTot(req);
	    recordsTotal = lists.size();
	    recordsFiltered = recordsTotal;

	    try {
	        JsonObject jsonResponse = new JsonObject();
	        Gson gson = new Gson();

	        jsonResponse.addProperty("draw", req.getDraw());
	        jsonResponse.addProperty("recordsTotal", recordsTotal);
	        jsonResponse.addProperty("recordsFiltered", recordsFiltered);
	        jsonResponse.add("data", gson.toJsonTree(lists));

	        return jsonResponse.toString();
	    } catch (JsonIOException e) {
	    	log.error(e.getMessage());
	    }
		return "";
	}

	//사용자 소속된(PM,멤버) 승인된프로젝트 리스트
	@Override
	public List<CustomReqProjectVO> getOkProjectUserList(String userId){
		log.debug("=== getOkProjectUserList Service ===");
		return reqProjectDAO.getOkProjectUserList(userId);
	}
	//회원사 아이디  승인된프로젝트 리스트
	@Override
	public List<CustomReqProjectVO> getOkProjectCustomerList(String userId){
		log.debug("=== getOkProjectCustomerList Service ===");
		return reqProjectDAO.getOkProjectCustomerList(userId);
	}

	//승인프로젝트 리스트 조회 Datatable
	public String projectOkList(CustomReqProjectVO req){
		log.debug("=== projectOkList Service ===");
		int recordsTotal;
	    int recordsFiltered;
	    List<CustomReqProjectVO> lists = new ArrayList<>();

	    lists = reqProjectDAO.projectOkList(req);
    	recordsTotal = reqProjectDAO.projectOkListTot(req);
	    recordsFiltered = recordsTotal;

	    try {
	        JsonObject jsonResponse = new JsonObject();
	        Gson gson = new Gson();

	        jsonResponse.addProperty("draw", req.getDraw());
	        jsonResponse.addProperty("recordsTotal", recordsTotal);
	        jsonResponse.addProperty("recordsFiltered", recordsFiltered);
	        jsonResponse.add("data", gson.toJsonTree(lists));

	        return jsonResponse.toString();
	    } catch (JsonIOException e) {
	    	log.error(e.getMessage());
	    }
		return "";
	}

	//project 해지 신청(회원사 계정)
	@Override
	public String setprojectReqExpr(CustomReqProjectVO req){
		return reqProjectDAO.setprojectReqExpr(req)+"";
	}

	// 프로젝트에 등록된 상품 확인
	@Override
	public int getProjectCatalogueCnt(CustomReqProjectVO req){
		return reqProjectDAO.getProjectCatalogueCnt(req);
	}
	// 사용자 승인 모델 승인처리중인	프로젝트  PM아이디 조회 카운터
	@Override
	public int getAppPmmemberCnt(CustomReqProjectVO req) {
		return reqProjectDAO.getAppPmmemberCnt(req);
	}

	@Override
	public String setProjectWorkComplete(CustomReqProjectVO req){
		CustomReqProjectVO projectVo = reqProjectDAO.getProjectView(req.getReqProjectSeq());
		Map<String,String> keywordMap = new HashMap<>();
		keywordMap.put("[[프로젝트명]]", projectVo.getProjectAlias());
		keywordMap.put("[[관리자명]]",  projectVo.getProjectAdminiStratorName());
		keywordMap.put("[[URL]]", "http://k-cloud.kepco.co.kr/mng/req/project/workApprovalProjectView?reqProjectSeq="+req.getReqProjectSeq());
		alarmsTemplateService.alarms(21, req.getReceiverId(), keywordMap);
		// 한전 연계 시스템 전송
		CustomApprovalVO stepUser = new CustomApprovalVO();
		stepUser.setStepLevel(req.getStepLevel());
		stepUser.setRequestSeq(req.getRequestSeq() );
		CustomApprovalVO ApprovalVo = approvalService.getNextScheduleUser(stepUser);
		Map<String, String> alarmkepcoMap = new HashMap<>();
		alarmkepcoMap.put("gbn", "21");
		alarmkepcoMap.put("requestSeq", req.getReqProjectSeq());
		alarmkepcoMap.put("regUserId", projectVo.getRegUserId());	// 프로젝트 신청자
		alarmkepcoMap.put("apprvNowUserId", ApprovalVo.getApprvUserId());	// 현재 결재자
		alarmkepcoMap.put("url", "http://k-cloud.kepco.co.kr/mng/req/project/workApprovalProjectView?reqProjectSeq="+req.getReqProjectSeq());
		alarmsTemplateService.alarmsKepco(alarmkepcoMap);

		return reqProjectDAO.setProjectWorkComplete(req);
	}

	@Override
	public String updateProject(CustomReqProjectVO req) {
		String paresIntProjectUpdate = null;
		try {
			paresIntProjectUpdate = reqProjectDAO.updateProject(req);
			CustomReqProjectVO getProjectView = reqProjectService.getProjectView( req.getReqProjectSeq());

			if( "1".equals( paresIntProjectUpdate) && "Y".equals( getProjectView.getPaas())) {
				req.setQuotaYn( getProjectView.getQuotaYn());
				this.updateReqProjectCloudLimit( req);
			}
		}catch (Exception e) {
			logger.error("updateProject Exception");
		}
		return paresIntProjectUpdate;
	}

	@Override
	public String cancelledProject(CustomReqProjectVO req) {
		String paresIntProjectUpdate = null;
		try {
			paresIntProjectUpdate = reqProjectDAO.cancelledProject(req);
			CustomReqProjectVO getProjectView = reqProjectService.getProjectView( req.getReqProjectSeq());

			if( "1".equals( paresIntProjectUpdate) && "Y".equals( getProjectView.getPaas())) {
				req.setQuotaYn( getProjectView.getQuotaYn());
				this.updateReqProjectCloudLimit( req);
			}
		}catch (Exception e) {
			logger.error("cancelledProject Exception");
		}
		return paresIntProjectUpdate;
	}

	@Override
	public List<CustomReqProjectVO> excel(CustomReqProjectVO req) {
		return reqProjectDAO.list(req);
	}

	@Override
	public int reqProjectManagerTypeCheck(CustomReqProjectVO req){
		return reqProjectDAO.reqProjectManagerTypeCheck(req);
	}
	@Override
	public int reqProjectManagerTypeCheckOne(CustomReqProjectVO req){
		return reqProjectDAO.reqProjectManagerTypeCheckOne(req);
	}

	@Override
	public int ossProjectManagerTypeCheck(CustomReqProjectVO req){
		return reqProjectDAO.ossProjectManagerTypeCheck(req);
	}
	@Override
	public int ossProjectManagerTypeCheckOne(CustomReqProjectVO req){
		return reqProjectDAO.ossProjectManagerTypeCheckOne(req);
	}

	@Override
	public List<CustomOssProjectVO> cloudProjectInfo(CustomOssProjectVO req){
		return reqProjectDAO.cloudProjectInfo(req);
	}

	@Override
	public List<CustomOssProjectVO> cloudProjectInfoLass(CustomOssProjectVO req) {
		return reqProjectDAO.cloudProjectInfoLass(req);
	}

	@Override
	public int ossProjectChkListCount(CustomReqProjectVO req){
		return reqProjectDAO.ossProjectChkListCount(req);
	}

	@Override
	public int reqProjectCloudChkList(Map<String, Object> param){
		return reqProjectDAO.reqProjectCloudChkList(param);
	}

	@Override
	public int deleteReqProjectCloud(Map<String, Object> param){
		return reqProjectDAO.deleteReqProjectCloud(param);
	}

	@Override
	public  CustomReqProjectVO getReqProjectQuota(CustomReqProjectVO req){
		return reqProjectDAO.getReqProjectQuota(req);
	}



}
