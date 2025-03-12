package com.ivucenter.cloud.portal.req.project;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ivucenter.cloud.api.openstack.object.OpenStackComplexQuota;
import com.ivucenter.cloud.portal.cmm.user.CustomCmmUserVO;
import com.ivucenter.cloud.portal.oss.project.CustomOssProjectVO;
import com.ivucenter.cloud.portal.req.customer.CustomReqCustomerVO;
import com.ivucenter.cloud.portal.req.user.CustomReqUserVO;



@Repository
public class ReqProjectDAO {

	private final String GBN = "com.ivucenter.cloud.portal.req.project.ReqProjectDAO.";
	
    @Autowired
    private SqlSession sqlSession;

	public int setProjectNamechk(CustomReqProjectVO projectvo) {
		return sqlSession.selectOne(GBN + "setProjectManagerChk", projectvo);
	}
	
	public int setProjectApprove1chk(CustomReqProjectVO projectvo) {
		return sqlSession.selectOne(GBN + "setProjectApprove1chk", projectvo);
	}
	public int setProjectApprove2chk(CustomReqProjectVO projectvo) {
		return sqlSession.selectOne(GBN + "setProjectApprove2chk", projectvo);
	}
	
	public int setManagerTypechk(CustomReqProjectVO projectvo) {
		return sqlSession.selectOne(GBN + "setManagerTypechk", projectvo);
	}
	
	public int setProjectManagerChk(CustomReqProjectVO projectvo) {
		return sqlSession.selectOne(GBN + "setProjectManagerChk", projectvo);
	}

	public void setProjectForminsert(CustomReqProjectVO projectvo) {
		sqlSession.update(GBN + "setProjectForminsert", projectvo);
	}
	
	public void setProjectCloudForminsert(CustomReqProjectVO projectvo) {
		sqlSession.update(GBN + "setProjectCloudForminsert", projectvo);
	}
	
	public int reqProjectCloudChk(CustomReqProjectVO projectvo) {
		return sqlSession.selectOne(GBN + "reqProjectCloudChk", projectvo);
	}
	
	public void setProjectManagerUpdate(CustomReqProjectVO projectvo) {
		sqlSession.update(GBN + "setProjectManagerUpdate", projectvo);
	}
	
	public void setProjectAdminiStratorInsert(CustomReqProjectVO projectvo) {
		sqlSession.update(GBN + "setProjectAdminiStratorInsert", projectvo);
	}
	
	public void setProjectNetinsert(CustomReqProjectVO projectvo) {
		sqlSession.insert(GBN + "setProjectNetinsert", projectvo);
	}
	
	public void updateReqProjectCloudLimit(CustomReqProjectVO projectvo) {
		sqlSession.update(GBN + "updateReqProjectCloudLimit", projectvo);
	}
	
	public void updateReqProjectCompeteFlag(CustomReqProjectVO projectvo) {
		sqlSession.update(GBN + "updateReqProjectCompeteFlag", projectvo);
	}

	public List<CustomReqProjectVO> getProjectList(CustomReqProjectVO req) {
		return sqlSession.selectList(GBN + "getProjectList",req);
	}
	
	public List<CustomReqProjectVO> getProjectAdminList(CustomReqProjectVO req) {
		return sqlSession.selectList(GBN + "getProjectAdminList",req);
	}
	
	public List<CustomReqProjectVO> getProjectApproveList(CustomReqProjectVO req) {
		return sqlSession.selectList(GBN + "getProjectApproveList",req);
	}

	public CustomReqProjectVO getProjectView(String reqProjectSeq) {
		return sqlSession.selectOne(GBN + "getProjectView", reqProjectSeq);
	}
	
	public CustomReqProjectVO getReqProjectCloudQuota(CustomReqProjectVO req) {
		return sqlSession.selectOne(GBN + "getReqProjectCloudQuota", req);
	}
	
	public List<CustomReqProjectVO> getProjectCloudView(String reqProjectSeq) {
		return sqlSession.selectList(GBN + "getProjectCloudView",reqProjectSeq);
	}
	
	public List<CustomReqProjectVO> getProjectSubnetList(CustomReqProjectVO req) {
		return sqlSession.selectList(GBN + "getProjectSubnetList",req);
	}
	
	public CustomReqProjectVO getProjectDefaultSubnet(CustomReqProjectVO req) {
		return sqlSession.selectOne(GBN + "getProjectDefaultSubnet", req);
	}
	
	public CustomCmmUserVO getUserInfo(String reqProjectSeq){
		return sqlSession.selectOne(GBN + "getUserInfo", reqProjectSeq);
	}

	public void setProjectFormEdit(CustomReqProjectVO projectvo) {
		sqlSession.update(GBN + "setProjectFormEdit", projectvo);
	}

	public void setProjectNetdel(CustomReqProjectVO projectvo) {
		sqlSession.update(GBN + "setProjectNetdel", projectvo);
	}

	public List<CustomReqCustomerVO> getApprovalModelSteplist() {
		return sqlSession.selectList(GBN + "getApprovalModelSteplist");
	}

	public void setSrApprovalStepinsert(CustomReqCustomerVO appmodelstep) {
		sqlSession.update(GBN + "setSrApprovalStepinsert", appmodelstep);
	}

	public void setSrApprovalMemberinsert(CustomReqCustomerVO appmember) {
		sqlSession.update(GBN + "setSrApprovalMemberinsert", appmember);
		
	}

	public List<CustomReqCustomerVO> getApprovalModelMemberlist() {
		return sqlSession.selectList(GBN + "getApprovalModelMemberlist");
	}

	public List<CustomReqCustomerVO> getProjectAppSteplist(String reqProjectSeq) {
		return sqlSession.selectList(GBN + "getProjectAppSteplist",reqProjectSeq);
	}
	public List<CustomReqCustomerVO> managerList(CustomReqCustomerVO req) {
		return sqlSession.selectList(GBN + "managerList",req);
	}
	public int managerListTotal(CustomReqCustomerVO req) {
		return sqlSession.selectList(GBN + "managerList",req).size();
	}
	public List<CustomReqCustomerVO> reqManagerList(String reqProjectSeq) {
		return sqlSession.selectList(GBN + "reqManagerList",reqProjectSeq);
	}

	public List<CustomReqCustomerVO> reqWiteManagerList(String reqProjectSeq) {
		return sqlSession.selectList(GBN + "reqWiteManagerList",reqProjectSeq);
	}

	public List<CustomReqProjectVO> getOkProjectList() {
		return sqlSession.selectList(GBN + "getOkProjectList");
	}

	public CustomReqProjectVO getOkProjectView(String projectId) {
		return sqlSession.selectOne(GBN + "getOkProjectView", projectId);
	}
	
	public CustomReqProjectVO getProjectBoxId(String projectId) {
		return sqlSession.selectOne(GBN + "getProjectBoxId", projectId);
	}
	
	public CustomReqProjectVO getProjectWrite(String reqProjectSeq) {
		return sqlSession.selectOne(GBN + "getProjectWrite", reqProjectSeq);
	}

	public List<CustomReqUserVO> getCustomerMemberList(CustomReqProjectVO getOkProjectView) {
		return sqlSession.selectList(GBN + "getCustomerMemberList",getOkProjectView);
	}

	public List<CustomReqProjectVO> getProjectMemberList(String projectId) {
		return sqlSession.selectList(GBN + "getProjectMemberList",projectId);
	}

	public List<CustomReqProjectVO> projectMemberlist(CustomReqProjectVO req) {
		return sqlSession.selectList(GBN + "projectMemberlist",req);
	}

	public void setProjectMemberInsert(CustomReqProjectVO projectMembervo) {
		sqlSession.update(GBN + "setProjectMemberInsert", projectMembervo);
	}

	public int setProjectPmupdate(CustomReqProjectVO req) {		
		return (int)sqlSession.update(GBN + "setProjectPmupdate", req);
	}
	
	public int reqProjectStatusUpdate04(String reqProjectSeq) {		
		return (int)sqlSession.update(GBN + "reqProjectStatusUpdate04", reqProjectSeq);
	}

	public int getProjectMemberCnt(String projectId) {
		return sqlSession.selectOne(GBN + "getProjectMemberCnt", projectId);
	}

	public List<CustomReqUserVO> getCustomerMemberchkList(CustomReqProjectVO getOkProjectView) {
		return sqlSession.selectList(GBN + "getCustomerMemberchkList",getOkProjectView);
	}

	public void setProjectMemberDel(String projectId) {
		sqlSession.update(GBN + "setProjectMemberDel", projectId);
	}
    
    //pho
	public List<CustomReqProjectVO> list(CustomReqProjectVO req ){
		return sqlSession.selectList(GBN + "list",req);
	}
	public List<CustomReqProjectVO> listTot(CustomReqProjectVO req) {
		req.setLength(0);
		return sqlSession.selectList(GBN + "list",req);
	}
	
	public int insert(CustomReqProjectVO req,String projectId) {
		return (int)sqlSession.insert(GBN+"insert", req);
	}
	public CustomReqProjectVO detail(String reqProjectSeq) {
		return (CustomReqProjectVO) sqlSession.selectOne(GBN+"detail", reqProjectSeq);
	}
	public void setProjectMemberDel(CustomReqProjectVO req) {
		sqlSession.update(GBN + "setProjectMemberDel", req);
	}
	
	public int deleteProjectApproveUserDelete(CustomReqProjectVO req) {
		return (int)sqlSession.update(GBN + "deleteProjectApproveUserDelete", req);
	}
		
	// 프로젝트 관리자 delete
	public int projectManagerUserDelete(CustomReqProjectVO req) {
		return (int)sqlSession.update(GBN + "projectManagerUserDelete", req);
	}
	
	// 프로젝트 관리자 delete
	public int ossProjectManagerUserDelete(CustomReqProjectVO req) {
		return (int)sqlSession.update(GBN + "ossProjectManagerUserDelete", req);
	}
	
	public int projectManagerUserUpdate(CustomReqProjectVO req) {
		return (int)sqlSession.update(GBN + "projectManagerUserUpdate", req);
	}
	public int projectManagerTypeUdate(CustomReqProjectVO req) {
		return (int)sqlSession.update(GBN + "projectManagerTypeUdate", req);
	}	
	
	public int ossProjectManagerTypeUdate(CustomReqProjectVO req) {
		return (int)sqlSession.update(GBN + "ossProjectManagerTypeUdate", req);
	}
	
	public int update(CustomReqProjectVO req) {
	   return (int)sqlSession.update(GBN+"update", req);
   	}
	public int rejectedUpdate(CustomReqProjectVO req) {
		   return (int)sqlSession.update(GBN+"rejectedUpdate", req);
	   	}	
	public int newUpdate(CustomReqProjectVO req) {
		   return (int)sqlSession.update(GBN+"newUpdate", req);
	   	}
	
	public int delete(CustomReqProjectVO req) {
		   return (int)sqlSession.delete(GBN+"delete", req);
	   	}
	
	public int ossUpdate(CustomReqProjectVO req) {
		   return (int)sqlSession.update(GBN+"ossUpdate", req);
	   	}
	
	public int stepUpdate(CustomReqProjectVO req,String apprvState) {
		   return (int)sqlSession.update(GBN+"stepUpdate", req);
   	}

	public int setprojectMemberRolchg(CustomReqProjectVO req) {
		return (int)sqlSession.update(GBN+"setprojectMemberRolchg", req);
	}
	public List<CustomReqProjectVO> approvalList(String reqProjectSeq,String codeKeyId) {
		return sqlSession.selectList(GBN + "approvalList",reqProjectSeq);
}
	public List<CustomReqUserVO> getCustomerMemberSerachList(CustomReqProjectVO req) {
		return sqlSession.selectList(GBN + "getCustomerMemberSerachList",req);
	}
	
	public List<CustomReqProjectVO> approvalUserId(String reqProjectSeq) {
		return sqlSession.selectList(GBN + "approvalUserId",reqProjectSeq);
}
	public List<CustomReqUserVO> getCustomerMemberSerachchkList(CustomReqProjectVO req) {
		return sqlSession.selectList(GBN + "getCustomerMemberSerachchkList",req);
	}

	public List<CustomReqProjectVO> getProjectMemberSerachList(CustomReqProjectVO req) {
		return sqlSession.selectList(GBN + "getProjectMemberSerachList",req);
	}

	
	// PM popup 
	public List<CustomReqUserVO> pmPopList(CustomReqProjectVO req) {
		return sqlSession.selectList(GBN + "getPmPopList", req);
	}

	// 승인프로젝트 정보 수정 
	public int okProjectUpdate(CustomReqProjectVO req) {
		return (int)sqlSession.update(GBN + "okProjectUpdate", req);
	}
	
	// 승인프로젝트 정보 수정 
	public int okProjectBoxUpdate(CustomReqProjectVO req) {
		return (int)sqlSession.update(GBN + "okProjectBoxUpdate", req);
	}
	
	// 승인프로젝트 정보 수정 history
	public int okProjectHistoryInsert(CustomReqProjectVO req) {
		return (int)sqlSession.update(GBN + "okProjectHistoryInsert", req);
	}
	
	// 승인프로젝트 정보 수정 history
	public int okOssProjectAdminiStratorInsert(CustomReqProjectVO req) {
		return (int)sqlSession.update(GBN + "okOssProjectAdminiStratorInsert", req);
	}
	
	// 승인프로젝트 정보 수정 history
	public int okOssProjectAdminiStratorUpdate(CustomReqProjectVO req) {
		return (int)sqlSession.update(GBN + "okOssProjectAdminiStratorUpdate", req);
	}
	
	
	// 승인프로젝트 정보 수정 
	public int projectUpdate(CustomReqProjectVO req) {
		return (int)sqlSession.update(GBN + "projectUpdate", req);
	}
	
	// 승인프로젝트 정보 수정 
	public int projectAdminiStratorInsert(CustomReqProjectVO req) {
		return (int)sqlSession.update(GBN + "projectAdminiStratorInsert", req);
	}
	public int projectAdminiStratorUpdate(CustomReqProjectVO req) {
		return (int)sqlSession.update(GBN + "projectAdminiStratorUpdate", req);
	}
	// 프로젝트 승인정보 등록 및 업데이트
	public int srApprovalStepInsert(CustomReqCustomerVO req) {
		return (int)sqlSession.insert(GBN + "srApprovalStepInsert", req);
	}
	// 승인프로젝트 정보 수정 
	public int srApprovalStepUpdate(CustomReqProjectVO req) {
		return (int)sqlSession.update(GBN + "srApprovalStepUpdate", req);
	}
	public int srApprovalStepApprv1StateUpdate(CustomReqProjectVO req) {
		return (int)sqlSession.update(GBN + "srApprovalStepApprv1StateUpdate", req);
	}
	public int srApprovalStepApprv2StateUpdate(CustomReqProjectVO req) {
		return (int)sqlSession.update(GBN + "srApprovalStepApprv2StateUpdate", req);
	}
	
	
	public int reqProjectStatusUpdate(CustomReqProjectVO req) {
		return (int)sqlSession.update(GBN + "reqProjectStatusUpdate", req);
	}
	public int reqProjectDelete(CustomReqProjectVO req) {
		return (int)sqlSession.update(GBN + "reqProjectDelete", req);
	}
	public int reqProjectManagerDelete(CustomReqProjectVO req) {
		return (int)sqlSession.update(GBN + "reqProjectManagerDelete", req);
	}
	public int srApprovalStepDelete(CustomReqProjectVO req) {
		return (int)sqlSession.update(GBN + "srApprovalStepDelete", req);
	}
	public int cmmFileDelete(CustomReqProjectVO req) {
		return (int)sqlSession.update(GBN + "cmmFileDelete", req);
	}
	
	// 프로젝트 신청 현황 리스트
	public List<CustomReqProjectVO> projectStatusList(CustomReqProjectVO req ){
		return sqlSession.selectList(GBN + "projectStatusList",req);
	}

	//사용자 소속된(PM,멤버) 승인된 프로젝트 리스트
	public List<CustomReqProjectVO> getOkProjectUserList(String userId) {
		return sqlSession.selectList(GBN + "getOkProjectUserList",userId);
	}

	//회원사 아이디  승인된프로젝트 리스트
	public List<CustomReqProjectVO> getOkProjectCustomerList(String userId) {
		return sqlSession.selectList(GBN + "getOkProjectCustomerList",userId);
	}
	
	//승인프로젝트 리스트 Datatable 
	public List<CustomReqProjectVO> projectOkList(CustomReqProjectVO req) {
		return sqlSession.selectList(GBN + "projectOkList",req);
	}
	public int projectOkListTot(CustomReqProjectVO req) {
		req.setLength(0);
		return sqlSession.selectList(GBN + "projectOkList",req).size();
	}
	//승인프로젝트 리스트 소속 Datatable 
	public List<CustomReqProjectVO> projectOkListUser(CustomReqProjectVO req) {
		return sqlSession.selectList(GBN + "projectOkListUser",req);
	}
	//승인프로젝트 리스트 회원사 Datatable
	public List<CustomReqProjectVO> projectOkListCustomer(CustomReqProjectVO req) {
		return sqlSession.selectList(GBN + "projectOkListCustomer",req);
	}
	//승인프로젝트 목록 카운트 소속 Datatable
	public int okListUserTot(CustomReqProjectVO req) {
		return (int)sqlSession.selectOne(GBN+"okListUserTot", req);
	}
	//승인프로젝트 목록 카운트 회원사 Datatable
	public int okListCustomerTot(CustomReqProjectVO req) {
		return (int)sqlSession.selectOne(GBN+"okListCustomerTot", req);
	}

	//project 해지 신청(회원사 계정)
	public int setprojectReqExpr(CustomReqProjectVO req) {
		return (int)sqlSession.insert(GBN+"setprojectReqExpr", req);
	}

	// 프로젝트에 등록된 상품 확인	
	public int getProjectCatalogueCnt(CustomReqProjectVO req) {
		return sqlSession.selectOne(GBN+"getProjectCatalogueCnt", req);
	}
	
	// 사용자 승인 모델 승인처리중인	프로젝트  PM아이디 조회 카운터
	public int getAppPmmemberCnt(CustomReqProjectVO req) {
		return sqlSession.selectOne(GBN+"getAppPmmemberCnt", req);
	}
	
	// 프로젝트 신청 작업 완료
	public String setProjectWorkComplete(CustomReqProjectVO req){
		return sqlSession.update(GBN+"setProjectWorkComplete", req)+"";
	}

	public String updateProject(CustomReqProjectVO req) {
		return sqlSession.update(GBN+"updateProject", req)+"";
	}
	
	public String cancelledProject(CustomReqProjectVO req) {
		return sqlSession.update(GBN+"cancelledProject", req)+"";
	}

	public int getProjectListTot(CustomReqProjectVO req) {
		req.setLength(0);
		return sqlSession.selectList(GBN + "getProjectList",req).size();
	}
	
	public int getProjectApproveListTot(CustomReqProjectVO req) {
		req.setLength(0);
		return sqlSession.selectList(GBN + "getProjectApproveList",req).size();
	}
	
	public int getProjectAdminListTot(CustomReqProjectVO req) {
		req.setLength(0);
		return sqlSession.selectList(GBN + "getProjectAdminList",req).size();
	}
	
	public int reqProjectManagerTypeCheck(CustomReqProjectVO req) {
		return sqlSession.selectOne(GBN+"reqProjectManagerTypeCheck", req);
	}
	public int reqProjectManagerTypeCheckOne(CustomReqProjectVO req) {
		return sqlSession.selectOne(GBN+"reqProjectManagerTypeCheckOne", req);
	}
	
	
	public int ossProjectManagerTypeCheck(CustomReqProjectVO req) {
		return sqlSession.selectOne(GBN+"ossProjectManagerTypeCheck", req);
	}
	public int ossProjectManagerTypeCheckOne(CustomReqProjectVO req) {
		return sqlSession.selectOne(GBN+"ossProjectManagerTypeCheckOne", req);
	}
	
	public List<CustomOssProjectVO> cloudProjectInfo(CustomOssProjectVO req) {
		return sqlSession.selectList(GBN+"cloudProjectInfo", req);
	}
	
	public List<CustomOssProjectVO> cloudProjectInfoLass(CustomOssProjectVO req) {
		return sqlSession.selectList(GBN+"cloudProjectInfoLass", req);
	}
	
	public int ossProjectChkListCount(CustomReqProjectVO req) {
		return sqlSession.selectOne(GBN+"ossProjectChkListCount", req);
	}
	
	public int reqProjectCloudChkList(Map<String, Object> param) {
		return sqlSession.selectOne(GBN+"reqProjectCloudChkList", param);
	}
	
	public int deleteReqProjectCloud(Map<String, Object> param) {
		return sqlSession.delete(GBN+"deleteReqProjectCloud", param);
	}

	public CustomReqProjectVO getReqProjectQuota(CustomReqProjectVO req) {
		return (CustomReqProjectVO) sqlSession.selectOne(GBN+"getReqProjectQuota", req);
	}
	
	
	
}
