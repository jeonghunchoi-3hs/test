package com.ivucenter.cloud.portal.operation.approveLine;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;
import com.ivucenter.cloud.portal.operation.adminuser.CustomAdminUserVO;

@Service
public class ApproveLineService {

    private static final Logger logger = LoggerFactory.getLogger(ApproveLineService.class);

	@Autowired
	private ApproveLineDAO dao;

	public CustomAdminUserVO VoToDec(CustomAdminUserVO vo){
		if(vo != null){
			vo.setUserPhone(vo.getUserPhoneDec());
			vo.setUserTel(vo.getUserTelDec());
			vo.setUserMail(vo.getUserMailDec());
		}
		return vo;
	}

	public CustomAdminUserVO VoToEnc(CustomAdminUserVO vo){
		if(vo != null){
			vo.setUserPhone(vo.getUserPhoneEnc());
			vo.setUserTel(vo.getUserTelEnc());
			vo.setUserMail(vo.getUserMailEnc());
		}
		return vo;
	}

	// 관리자 목록 조회
	public String list(CustomApproveLineVO req){
    	List<CustomApproveLineVO> lists = dao.list(req);
	    int recordsTotal = dao.listTot(req).size();
	    int recordsFiltered = recordsTotal;

	    try {
	        JsonObject jsonResponse = new JsonObject();
	        Gson gson = new Gson();

	        jsonResponse.addProperty("draw", req.getDraw());
	        jsonResponse.addProperty("recordsTotal", recordsTotal);
	        jsonResponse.addProperty("recordsFiltered", recordsFiltered);
	        jsonResponse.add("data", gson.toJsonTree(lists));

	        return jsonResponse.toString();
	    } catch (JsonIOException e) {

            logger.error("JSON 처리 중 오류 발생");
	    }
		return "";
	}

		public String insert(CustomApproveLineVO req) {
			return dao.insert(req)+"";
		}
		public String delete(CustomApproveLineVO req) {
			return dao.delete(req)+"";
        }
		public List<CustomApproveLineVO> getApproveLineList(CustomApproveLineVO req){
			return dao.getApproveLineList(req);
		}
		public String approveLineUpdate(CustomApproveLineVO req) {
			return dao.approveLineUpdate(req)+"";
		}
		public CustomApproveLineVO stepMaxValue(CustomApproveLineVO req) {
			return dao.stepMaxValue(req);
		}

}
