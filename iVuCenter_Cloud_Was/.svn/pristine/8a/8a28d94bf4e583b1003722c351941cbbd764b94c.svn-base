package com.ivucenter.cloud.portal.operation.adminuser;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;
import com.ivucenter.cloud.portal.cmm.cloud.OssCloudDAO;

@Service
public class AdminUserService {

    private static final Logger logger = LoggerFactory.getLogger(AdminUserService.class);

	@Autowired
	private AdminUserDAO dao;

	@Autowired
	private OssCloudDAO cloudDao;

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
	public String list(CustomAdminUserVO req){
    	List<CustomAdminUserVO> lists = dao.list(req);
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

	public List<CustomAdminUserVO> excel(CustomAdminUserVO req) {
		return dao.list(req);
	}

	public String addList(CustomAdminUserVO req) {
		 try {
		        JsonObject jsonResponse = new JsonObject();
		        Gson gson = new Gson();
		        jsonResponse.add("data", gson.toJsonTree(dao.addList(req)));

		        return jsonResponse.toString();
		    } catch (JsonIOException e) {
	            logger.error("JSON 처리 중 오류 발생");
		    }
			return "";
	}

	public String insertAdmin(CustomAdminUserVO req){
		try {
			req.setStepId("*");
			dao.insertAdmin(req);
			dao.updateAdmin(req);
			return "1";
		} catch (Exception e) {
            logger.error("insertAdmin Exception");
		}
		return "0";
	}

	public CustomAdminUserVO auth(CustomAdminUserVO req) {
		return dao.auth(req);
	}

	public String LoginAuth() {
		return dao.LoginAuth();
	}

	public String updateAdmin(CustomAdminUserVO req){
		try {
			//approval_model_member DB 데이터 초기화
			dao.deleteApproval(req);
			if(req.getLength() > 0){
				if(req.getWF1000A0().equals("Y")){
					req.setStepId("WF1000A0");
					dao.insertAdmin(req);
				}
				if(req.getWF1000B0().equals("Y")){
					req.setStepId("WF1000B0");
					dao.insertAdmin(req);
				}
				if(req.getWF1000C0().equals("Y")){
					req.setStepId("WF1000C0");
					dao.insertAdmin(req);
				}
				if(req.getWF1000D0().equals("Y")){
					req.setStepId("WF1000D0");
					dao.insertAdmin(req);
				}
				if(req.getWF1000E0().equals("Y")){
					req.setStepId("WF1000E0");
					dao.insertAdmin(req);
				}
				if(req.getWF2000A0().equals("Y")){
					req.setStepId("WF2000A0");
					dao.insertAdmin(req);
				}
				if(req.getWF2000B0().equals("Y")){
					req.setStepId("WF2000B0");
					dao.insertAdmin(req);
				}
				if(req.getWF2000C0().equals("Y")){
					req.setStepId("WF2000C0");
					dao.insertAdmin(req);
				}
				if(req.getWF2000D0().equals("Y")){
					req.setStepId("WF2000D0");
					dao.insertAdmin(req);
				}
				if(req.getWF2000E0().equals("Y")){
					req.setStepId("WF2000E0");
					dao.insertAdmin(req);
				}
				if(req.getWF4000A0().equals("Y")) {
					req.setStepId("WF4000A0");
					dao.insertAdmin(req);
				}

			}

			// 클라우드 어드민 (인프라승인권한자)
			if( req.getWF1000C0().equals("Y") || req.getWF1000D0().equals("Y") || req.getWF1000E0().equals("Y") || req.getWF4000A0().equals("Y") ) {
				req.setCloudeAdmin("1");
			}else{
				req.setCloudeAdmin("0");
			}
			req.setPortaladmin(req.getPortaladmin().equals("Y")?"1":"0");
			req.setOperation(req.getOperation().equals("Y")?"1":"0");
			req.setConfirmAction(req.getConfirmAction().equals("Y")?"1":"0");

			// 정산 관리자
			if( req.getWF2000A0().equals("Y") || req.getWF2000B0().equals("Y") || req.getWF2000C0().equals("Y") || req.getWF2000D0().equals("Y") || req.getWF2000E0().equals("Y")) {
				req.setCloudeAcct("1");
			}else{
				req.setCloudeAcct("0");
			}

			// 사용자 어드민(요청자승인권한자)
			if( req.getWF1000A0().equals("Y") || req.getWF1000B0().equals("Y") ) {
				req.setCustomAdmin("1");
			}else {
				req.setCustomAdmin("0");
			}



			//회원가입승인
			req.setLogin(req.getLogin().equals("Y")?"1":"0");
			dao.updateAuth(req);

			return "1";
		} catch (Exception e) {
            logger.error("updateAdmin Exception");
		}
		return "0";
	}

	/*
	// 관리자 상세 조회
	public CustomAdminUserVO view(CustomAdminUserVO req){
		CustomAdminUserVO res= dao.view(req);
		res.setUserTel(res.getUserTelDec());
		res.setUserPhone(res.getUserPhoneDec());

		//클라우드 관리자
		if(res.getUserAuthority().charAt(0) == '1'){
			res.setAuthority1("1");
		}
		//회계담당
		if(res.getUserAuthority().charAt(3) == '1'){
			res.setAuthority2("1");
		}
		//관리자 일반 사용자
		if(res.getUserAuthority().charAt(7) == '1'){
			res.setAuthority3("1");
		}
		return res;
	}

	// 일반 목록 조회
	public String userList(CustomAdminUserVO req){
    	List<CustomAdminUserVO> lists = dao.userList(req);
	    int recordsTotal = dao.userListTot(req);
	    int recordsFiltered = recordsTotal;

		List<CustomAdminUserVO> list = new LinkedList<CustomAdminUserVO>();
		for(CustomAdminUserVO vo : lists){
			list.add(VoToDec(vo));
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
            logger.error("JSON 처리 중 오류 발생");
	    }
		return "";
	}

	// 권한변경
	public String updateRole(CustomAdminUserVO req){
		StringBuffer userAuthority = new StringBuffer(req.getUserAuthority());
		//프로젝트 관리자
		if(req.getAuthority1().equals("1")){
			userAuthority.setCharAt(0, '1');
		}else{
			userAuthority.setCharAt(0, '0');
		}
		//회계담당
		if(req.getAuthority2().equals("1")){
			userAuthority.setCharAt(3, '1');
		}else{
			userAuthority.setCharAt(3, '0');
		}
		//관리자 일반
		if(req.getAuthority3().equals("1")){
			userAuthority.setCharAt(7, '1');
		}else{
			userAuthority.setCharAt(7, '0');
		}

		req.setUserAuthority(userAuthority.toString());

		return dao.updateRole(VoToDec(req));
	}

	// 관리자 등록
	public String adminInsert(CustomAdminUserVO req){

		StringBuffer userAuthority = new StringBuffer(req.getUserAuthority());
		//프로젝트 관리자

		userAuthority.setCharAt(7, '1');

		req.setUserAuthority(userAuthority.toString());

		return dao.updateRole(VoToDec(req));
	}
	*/



}
