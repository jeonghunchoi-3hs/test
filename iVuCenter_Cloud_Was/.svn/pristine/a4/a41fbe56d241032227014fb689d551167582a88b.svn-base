package com.ivucenter.cloud.portal.req.project;

import java.util.List;
import java.util.Map;

import com.ivucenter.cloud.api.openstack.object.OpenStackComplexQuota;
import com.ivucenter.cloud.portal.cmm.user.CustomCmmUserVO;
import com.ivucenter.cloud.portal.oss.project.CustomOssProjectVO;
import com.ivucenter.cloud.portal.req.customer.CustomReqCustomerVO;
import com.ivucenter.cloud.portal.req.user.CustomReqUserVO;

public interface ReqProjectService {

	int setProjectNamechk(CustomReqProjectVO projectvo);
	
	int setProjectApprove1chk(CustomReqProjectVO projectvo);
	
	int setProjectApprove2chk(CustomReqProjectVO projectvo);
	
	int setManagerTypechk(CustomReqProjectVO projectvo);
	
	int setProjectManagerChk(CustomReqProjectVO projectvo);

	void setProjectForminsert(CustomReqProjectVO projectvo);
	
	void setProjectCloudForminsert(CustomReqProjectVO projectvo);
	
	int reqProjectCloudChk(CustomReqProjectVO projectvo);
	
	void setProjectManagerUpdate(CustomReqProjectVO projectvo);
	
	void setProjectAdminiStratorInsert(CustomReqProjectVO projectvo);

//	List<CustomReqProjectVO> getProjectNetList(String codeKeyId);
	
//	List<CustomReqProjectVO> getProjectNetList2(CustomReqProjectVO vo);
	
	CustomCmmUserVO getUserInfo(String reqProjectSeq);

	void setProjectNetinsert(CustomReqProjectVO projectvo);

	String getProjectList(CustomReqProjectVO req);
	
	String getProjectApproveList(CustomReqProjectVO req);
	
	String getProjectAdminList(CustomReqProjectVO req);
	
	List<CustomReqProjectVO> getProjectCardList(CustomReqProjectVO req);

	CustomReqProjectVO getProjectView(String reqProjectSeq);
	
	CustomReqProjectVO getReqProjectCloudQuota(CustomReqProjectVO req);
	
	List<CustomReqProjectVO> getProjectCloudView(String reqProjectSeq);
	
	List<CustomReqProjectVO> getProjectSubnetList(CustomReqProjectVO req);
	
	CustomReqProjectVO getProjectDefaultSubnet(CustomReqProjectVO req);

	void updateReqProjectCloudLimit(CustomReqProjectVO req);
	
	void updateReqProjectCompeteFlag(CustomReqProjectVO req);

	void setProjectFormEdit(CustomReqProjectVO projectvo);

	void setProjectNetdel(CustomReqProjectVO projectvo);
	
	int deleteProjectApproveUserDelete(CustomReqProjectVO req);
		
	int projectManagerUserDelete(CustomReqProjectVO req);
	int projectManagerUserUpdate(CustomReqProjectVO req);

	int projectManagerTypeUdate(CustomReqProjectVO req);	
	
	int ossProjectManagerUserDelete(CustomReqProjectVO req);
	int ossProjectManagerTypeUdate(CustomReqProjectVO req);	

	String list(CustomReqProjectVO req);
	
	CustomReqProjectVO detail(String reqProjectSeq);

	String insert(CustomReqProjectVO req, String projectId);

	String update(CustomReqProjectVO req);
	
	String newUpdate(CustomReqProjectVO req);
	
	String rejectedUpdate(CustomReqProjectVO req);
	
	String ossUpdate(CustomReqProjectVO req);
	
	String delete(CustomReqProjectVO req);
	
	String stepUpdate(CustomReqProjectVO req,String apprvState);
	
	List<CustomReqProjectVO> approvalList(String reqProjectSeq,String codeKeyId);
	
	List<CustomReqProjectVO> approvalUserId(String reqProjectSeq);
	
	List<CustomReqCustomerVO> getApprovalModelSteplist();

	void setSrApprovalStepinsert(CustomReqCustomerVO appmodelstep);

	List<CustomReqCustomerVO> getApprovalModelMemberlist();

	void setSrApprovalMemberinsert(CustomReqCustomerVO appmember);

	List<CustomReqCustomerVO> getProjectAppSteplist(String reqProjectSeq);
	
	List<CustomOssProjectVO> cloudProjectInfo(CustomOssProjectVO req);
	
	List<CustomOssProjectVO> cloudProjectInfoLass(CustomOssProjectVO req);
	
	List<CustomReqCustomerVO> managerList(CustomReqCustomerVO req);
	
	List<CustomReqCustomerVO> reqManagerList(String reqProjectSeq);
	
	List<CustomReqCustomerVO> reqWiteManagerList(String reqProjectSeq);

	List<CustomReqProjectVO> getOkProjectList();

	CustomReqProjectVO getOkProjectView(String projectId);
	
	CustomReqProjectVO getProjectBoxId(String projectId);
	
	CustomReqProjectVO getProjectWrite(String reqProjectSeq);

	List<CustomReqUserVO> getCustomerMemberList(CustomReqProjectVO getOkProjectView);

	List<CustomReqProjectVO> getProjectMemberList(String projectId);

	String projectMemberlist(CustomReqProjectVO req);
	
	String reqProjectStatusUpdate04(String reqProjectSeq);

	void setProjectMemberInsert(CustomReqProjectVO projectMembervo);

	String setProjectPmupdate(CustomReqProjectVO req);

	int getProjectMemberCnt(String projectId);

	List<CustomReqUserVO> getCustomerMemberchkList(CustomReqProjectVO getOkProjectView);

	void setProjectMemberDel(String projectId);

	void setProjectMemberDel(CustomReqProjectVO req);

	String setprojectMemberRolchg(CustomReqProjectVO req);

	List<CustomReqUserVO> getCustomerMemberSerachList(CustomReqProjectVO req);

	List<CustomReqUserVO> getCustomerMemberSerachchkList(CustomReqProjectVO req);

	List<CustomReqProjectVO> getProjectMemberSerachList(CustomReqProjectVO req);
	
	//PM pupup
	List<CustomReqUserVO> pmPopList(CustomReqProjectVO req);
	
	//프로젝트 정보 수정
	String okProjectUpdate(CustomReqProjectVO req);
	
	//프로젝트 정보 수정
	String okProjectBoxUpdate(CustomReqProjectVO req);
	
	//프로젝트 정보 수정 히스토리
	String okProjectHistoryInsert(CustomReqProjectVO req);
	
	//프로젝트 관리자 insert
	String okOssProjectAdminiStratorInsert(CustomReqProjectVO req);
	
	//프로젝트 관리자 update
	String okOssProjectAdminiStratorUpdate(CustomReqProjectVO req);
	
	
	//프로젝트 정보 수정 
	String projectUpdate(CustomReqProjectVO req);
	
	//프로젝트 관리자 insert 
	String projectAdminiStratorInsert(CustomReqProjectVO req);
	
	//프로젝트 관리자 insert 
	String projectAdminiStratorUpdate(CustomReqProjectVO req);
	
	String srApprovalStepUpdate(CustomReqProjectVO req);
	
	String srApprovalStepInsert(CustomReqCustomerVO req);
	
	//1차 결재선 수정
	String srApprovalStepApprv1StateUpdate(CustomReqProjectVO req);
	//2차 결재선 수정
	String srApprovalStepApprv2StateUpdate(CustomReqProjectVO req);
	
	String reqProjectStatusUpdate(CustomReqProjectVO req);
	
	String reqProjectDelete(CustomReqProjectVO req);
	String reqProjectManagerDelete(CustomReqProjectVO req);
	String srApprovalStepDelete(CustomReqProjectVO req);
	String cmmFileDelete(CustomReqProjectVO req);
	
	//프로젝트 신현 현황 리스트
	String projectStatusList(CustomReqProjectVO req);
	//사용자 소속된(PM,멤버) 승인된프로젝트 리스트
	List<CustomReqProjectVO> getOkProjectUserList(String userId);
	//회원사 아이디  승인된프로젝트 리스트
	List<CustomReqProjectVO> getOkProjectCustomerList(String userId);
	//승인프로세스 리스트 조회 Datatalble
	String projectOkList(CustomReqProjectVO req);
	
	//project 해지 신청(회원사 계정)
	String setprojectReqExpr(CustomReqProjectVO req);

	// 프로젝트에 등록된 상품 확인
	int getProjectCatalogueCnt(CustomReqProjectVO req);

	int getAppPmmemberCnt(CustomReqProjectVO req);
	
	String setProjectWorkComplete(CustomReqProjectVO req);


	List<CustomReqProjectVO> excel(CustomReqProjectVO req);
	
	// 프로젝트에 등록된 관리자 확인
	int reqProjectManagerTypeCheck(CustomReqProjectVO req);
	int reqProjectManagerTypeCheckOne(CustomReqProjectVO req);

	
	int ossProjectManagerTypeCheck(CustomReqProjectVO req);
	int ossProjectManagerTypeCheckOne(CustomReqProjectVO req);

	String managerListGrid(CustomReqCustomerVO req);
	
	int ossProjectChkListCount(CustomReqProjectVO req);
	
	int reqProjectCloudChkList(Map<String, Object> param);

	int deleteReqProjectCloud(Map<String, Object> param) throws Exception;

	String updateProject(CustomReqProjectVO req) throws Exception;
	
	String cancelledProject(CustomReqProjectVO req) throws Exception;
	
	CustomReqProjectVO getReqProjectQuota(CustomReqProjectVO projectVo);


}
