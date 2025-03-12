package com.ivucenter.cloud.portal.approval;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ivucenter.cloud.portal.charge.bill.CustomChargeBillVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class ApprovalDAO {

	private final String GBN = "com.ivucenter.cloud.portal.mng.approval.ApprovalDAO.";

	@Autowired
	private SqlSession sqlSession;

	public List<CustomChargeBillVO> calculateList(CustomChargeBillVO req){
		return sqlSession.selectList(GBN+"calculateList", req);
	}

	public List<CustomChargeBillVO> calculateListTot(CustomChargeBillVO req){
		req.setLength(0);
		return sqlSession.selectList(GBN+"calculateList", req);
	}

	public List<CustomChargeBillVO> calculateDetailList(CustomChargeBillVO req){
		return sqlSession.selectList(GBN+"calculateDetailList", req);
	}

	public int calculateDetailListTot(CustomChargeBillVO req){
		req.setLength(0);
		return sqlSession.selectList(GBN+"calculateDetailList", req).size();
	}

	//정산확정
	public String updateConfirmFlag(CustomChargeBillVO req){
		return sqlSession.update(GBN+"updateConfirmFlag", req)+"";
	}

	//정산승인요청
	public String reqCalculateApproval(CustomChargeBillVO req){
		return sqlSession.update(GBN+"reqCalculateApproval", req)+"";
	}

	//보정 재정산 유무확인
	public int adjustYn(CustomChargeBillVO req){
		return sqlSession.selectOne(GBN+"adjustYn", req);
	}


	/**
	 * 승인프로세스등록
	 */
	public List<CustomApprovalVO> getApprovalModelSteplist() {
		return sqlSession.selectList(GBN + "getApprovalModelSteplist");
	}
	/**
	 * 승인프로세스등록
	 */
     public List	<CustomApprovalVO> getCalculatetApprovalModelSteplist(){
 		return sqlSession.selectList(GBN + "getCalculatetApprovalModelSteplist");
     }

	public List<CustomApprovalVO> getApprovalModelMemberlist() {
		return sqlSession.selectList(GBN + "getApprovalModelMemberlist");
	}

	public List<CustomApprovalVO> getApprovalModelMemberStepList(String stepId) {
		return sqlSession.selectList(GBN + "getApprovalModelMemberStepList", stepId);
	}

	public List<CustomApprovalVO> getNextScheduleUserList(CustomApprovalVO vo)	{
		return sqlSession.selectList(GBN + "getNextScheduleUserList", vo);
	}
	
	public List<CustomApprovalVO> getApprovalQueueMemberList(CustomApprovalVO vo) {
		return sqlSession.selectList(GBN + "getApprovalQueueMemberList", vo);
	}
	
	public CustomApprovalVO getNextScheduleUser(CustomApprovalVO vo)	{
		return sqlSession.selectOne(GBN + "getNextScheduleUser", vo);
	}

	public void setSrApprovalStepinsert(CustomApprovalVO appmodelstep) {
		sqlSession.insert(GBN+"setSrApprovalStepinsert", appmodelstep);
	}

	public void setSrApprovalMemberinsert(CustomApprovalVO appmodelstep) {
		sqlSession.insert(GBN+"setSrApprovalMemberinsert", appmodelstep);
	}

	public String getStepId(Map<String, String> map) {
		return sqlSession.selectOne(GBN + "getStepId",map);
	}
	public String getUserApprvState(Map<String, String> map) {
		return sqlSession.selectOne(GBN + "getUserApprvState", map);
	}
	public List<CustomApprovalVO> approvalList(CustomApprovalVO req) {
		log.debug("스텝멤버 조회");
		return sqlSession.selectList(GBN + "approvalList",req);
	}
	public List<CustomApprovalVO> approvalUserId(CustomApprovalVO req) {
		log.debug("스텝멤버 아이디 조회");
		return sqlSession.selectList(GBN + "approvalUserId",req);
	}

	public int stepUpdate(CustomApprovalVO req) {
		log.debug("승인 업데이트");
		return (int)sqlSession.update(GBN+"stepUpdate", req);
	}
	public int reReqDelete(CustomApprovalVO req) {
		log.debug("재요청 : 기존 승인스텝 삭제");
		return (int)sqlSession.delete(GBN+"reReqDelete", req);
	}
	public int reReqDeleteMember(CustomApprovalVO req) {
		log.debug("재요청 : 기존 승인스텝멤버 삭제");
		return (int)sqlSession.delete(GBN+"reReqDeleteMember", req);
	}

	public int hisApprvUpdate(CustomApprovalVO req) {
		log.debug("승인 업데이트");
		return (int)sqlSession.update(GBN+"hisApprvUpdate", req);
	}

	public List<CustomApprovalVO> getApprovalModelMemberlist(CustomApprovalVO req) {
		return sqlSession.selectList(GBN + "getApprovalModelMemberlist",req);
	}

	public List<Object> billYearList(CustomChargeBillVO req) {
		return sqlSession.selectList(GBN + "billYearList",req);
	}


	public int checkApprovalAuth(CustomApprovalVO req) {
		return sqlSession.selectOne(GBN + "checkApprovalAuth", req);
	}

	public CustomApprovalVO getSetpMember(CustomApprovalVO req) {
		return sqlSession.selectOne(GBN + "getSetpMember",req);
	}

	public List<CustomApprovalVO> getComplatedMemberList(CustomApprovalVO req) {
		return sqlSession.selectList(GBN + "getComplatedMemberList",req);
	}
}
