package com.ivucenter.cloud.portal.approval;

import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;
import com.ivucenter.cloud.portal.charge.bill.CustomChargeBillVO;
import com.ivucenter.cloud.portal.util.CodeUtil;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ApprovalService {

	@Autowired
	private ApprovalDAO dao;


	// 정산 목록 조회(로그인 계정 기준)
	public String calculateList(CustomChargeBillVO req){
		int recordsTotal;
	    int recordsFiltered;

		List<CustomChargeBillVO> lists = dao.calculateList(req);
		recordsTotal = dao.calculateListTot(req).size();
		recordsFiltered = recordsTotal;

		try{
			JsonObject jsonResponse = new JsonObject();
			Gson gson = new Gson();

			jsonResponse.addProperty("draw", req.getDraw());
	        jsonResponse.addProperty("recordsTotal", recordsTotal);
	        jsonResponse.addProperty("recordsFiltered", recordsFiltered);
	        jsonResponse.add("data", gson.toJsonTree(lists));

	        return jsonResponse.toString();
		}catch(Exception e){
			log.error(e.getMessage());
		}

		return "";
	}

	// 정산 상세 조회
	public String calculateDetailList(CustomChargeBillVO req){
		int recordsTotal;
		int recordsFiltered;

		List<CustomChargeBillVO> lists = dao.calculateDetailList(req);
		recordsTotal = dao.calculateDetailListTot(req);
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

	// 정산 확정
	public String updateConfirmFlag(CustomChargeBillVO req){
		return dao.updateConfirmFlag(req);
	}
	// 정산 승인 요청(bill_master 상태값 업데이트)
	public String reqCalculateApproval(CustomChargeBillVO req){
		log.debug("========reqCalculateApproval : " +req.getBillProcStat() + " / "+ req.getBillYyyymm());
		return dao.reqCalculateApproval(req);
	}

	// 보정재정산유무확인
	public int adjustYn(CustomChargeBillVO req){
		log.debug("========adjustYn");
		return dao.adjustYn(req);
	}


	// 승인스텝조회
	public List<CustomApprovalVO> getApprovalModelSteplist(){
		return dao.getApprovalModelSteplist();
	}


	// 정산 승인스텝 조회


	public List<CustomApprovalVO> getCalculatetApprovalModelSteplist(){
            return dao.getCalculatetApprovalModelSteplist();

	}


	// 승인스텝멤버조회
//	public List<CustomApprovalVO> getApprovalModelMemberlist(){
//		return dao.getApprovalModelMemberlist();
//	}
	//승인스텝등록
	public void setSrApprovalStepinsert(CustomApprovalVO appmodelstep){
		dao.setSrApprovalStepinsert(appmodelstep);
	}
	//승인스텝멤버등록
	public void setSrApprovalMemberinsert(CustomApprovalVO appmodelstep){
		dao.setSrApprovalMemberinsert(appmodelstep);
	}

	// 승인플로우 조회->
	public String getStepId(Map<String, String> map) {
		return dao.getStepId(map);
	}
	public String getUserApprvState(Map<String, String> map) {
		return dao.getUserApprvState(map);
	}
	public List<CustomApprovalVO> approvalList(CustomApprovalVO req) {
		return dao.approvalList(req);
	}
	public List<Object> billYearList(CustomChargeBillVO req) {
		return dao.billYearList(req);
	}

	public List<CustomApprovalVO> approvalUserId(CustomApprovalVO req) {
		return dao.approvalUserId(req);
	}

	// 승인플로우 업데이트
	public String stepUpdate(CustomApprovalVO req) {
		if ("*".equals(req.getRightStepId())) {
			return dao.stepUpdate(req)+"";
		}else {
			dao.stepUpdate(req);
			int level= Integer.parseInt(req.getStepLevel())+1;
			req.setStepLevel(String.valueOf(level));
			String apprvState = CodeUtil.CMM_CODE_APPRV_PROCESSING;
			req.setApprvState(apprvState);
			String apprvDescription = "(NULL)";
			req.setApprvDescription(apprvDescription);
			return dao.stepUpdate(req)+"";
		}

	}
	public String stepRejectUpdate(CustomApprovalVO req) {
					dao.hisApprvUpdate(req);
			return dao.stepUpdate(req)+"";

	}
	public String reReqDelete(CustomApprovalVO req) {
				dao.reReqDeleteMember(req);
		return dao.reReqDelete(req)+"";

	}


	public List<CustomApprovalVO> getApprovalModelMemberlist(CustomApprovalVO req){
		List<CustomApprovalVO> lists = dao.getApprovalModelMemberlist(req);
		List<CustomApprovalVO> list = new LinkedList<CustomApprovalVO>();

		for(CustomApprovalVO vo : lists){
			list.add(VoToDec(vo));
		}

		return list;
	}

	public CustomApprovalVO VoToDec(CustomApprovalVO vo){
		if(vo != null){
			vo.setUserMail(vo.getUserMailDec());
		}
		return vo;
	}

	public List<CustomApprovalVO> getNextScheduleUserList(CustomApprovalVO vo) {
		// 요청 부서의 최종 승인자인 경우
		if(vo.getStepLevel().equals("4")) {
			// 지정한 승인부서 담당자 리스트를 넘김
			return dao.getApprovalModelMemberStepList("WF4000A0");
		}
		return dao.getNextScheduleUserList(vo);
	}
	
	public List<CustomApprovalVO> getApprovalQueueMemberList(CustomApprovalVO vo) {
		return dao.getApprovalQueueMemberList(vo);
	}
	
	public CustomApprovalVO getNextScheduleUser(CustomApprovalVO vo) {
		return dao.getNextScheduleUser(vo);
	}

	public List<CustomChargeBillVO> excel(CustomChargeBillVO req) {
		return dao.calculateListTot(req);
	}

	public List<CustomApprovalVO> getComplatedMemberList(CustomApprovalVO req){
		List<CustomApprovalVO> lists = dao.getComplatedMemberList(req);
		List<CustomApprovalVO> list = new LinkedList<CustomApprovalVO>();

		for(CustomApprovalVO vo : lists){
			list.add(VoToDec(vo));
		}
		return list;
	}

	public int checkApprovalAuth(CustomApprovalVO req) {
		return dao.checkApprovalAuth(req);
	}

	public CustomApprovalVO getSetpMember(CustomApprovalVO req){
		return dao.getSetpMember(req);
	}

}
