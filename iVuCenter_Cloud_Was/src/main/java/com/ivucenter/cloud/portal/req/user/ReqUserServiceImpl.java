package com.ivucenter.cloud.portal.req.user;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;
import com.ivucenter.cloud.portal.alarms.template.AlarmsTemplateService;
import com.ivucenter.cloud.portal.cmm.customer.CustomCmmCustomerVO;
import com.ivucenter.cloud.portal.cmm.user.CmmUserDAO;
import com.ivucenter.cloud.portal.cmm.user.CustomCmmUserVO;
import com.ivucenter.cloud.portal.operation.adminuser.AdminUserService;
import com.ivucenter.cloud.portal.operation.adminuser.CustomAdminUserVO;
import com.ivucenter.cloud.portal.util.TokenGenerator;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service("reqUserService")
public class ReqUserServiceImpl implements ReqUserService{
	
	@Autowired
	private ReqUserDAO reqUserDao;
	
	@Autowired
	private CmmUserDAO cmmUserDao;
	
	@Autowired
	private AdminUserService adminUserService;
	
	@Autowired
	private AlarmsTemplateService alarmsTemplateService;
	
	// 사용안함 (예비)
	@Override
	public String list(CustomReqUserVO req) {
    	if(req.getSearchKind().equals("userPhone") && req.getKeyword() != ""){ req.setKeyword(req.getUserPhoneEnc()); }
    	if(req.getSearchKind().equals("userTel") && req.getKeyword() != ""){ req.setKeyword(req.getUserTelEnc()); }
    	if(req.getSearchKind().equals("userMail") && req.getKeyword() != ""){ req.setKeyword(req.getUserMailEnc()); }
    	
    	List<CustomReqUserVO> lists = reqUserDao.list(req);
    	int recordsTotal = reqUserDao.listTotal(req).size();
    	int recordsFiltered = recordsTotal;    	
		
    	List<CustomReqUserVO> decList = new LinkedList<CustomReqUserVO>();
    	for(CustomReqUserVO vo : lists){    		
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
	        jsonResponse.add("data", gson.toJsonTree(decList));
	        
	        log.debug(jsonResponse.toString());
	        return jsonResponse.toString();
	    } catch (JsonIOException e) {	        
	        log.error(e.getMessage());
	    }
		return "";
	}

	// 사용안함 (예비)
	@Override
	public List<CustomReqUserVO> excel(CustomReqUserVO req) {
    	if(req.getSearchKind().equals("userPhone") && req.getKeyword() != ""){ req.setKeyword(req.getUserPhoneEnc()); }
    	if(req.getSearchKind().equals("userTel") && req.getKeyword() != ""){ req.setKeyword(req.getUserTelEnc()); }
    	if(req.getSearchKind().equals("userMail") && req.getKeyword() != ""){ req.setKeyword(req.getUserMailEnc()); }
    	
		return reqUserDao.listTotal(req);
	}
	
	@Override
	public List<CustomReqUserVO> getUserList() {
		
		return reqUserDao.getUserList();
	}
	
	@Override
	public CustomReqUserVO getUserView(CustomReqUserVO req) {
		CustomReqUserVO res = reqUserDao.getUserView(req);

		if(res != null) {
			res.setUserPhone(res.getUserPhoneDec());
			res.setUserTel(res.getUserTelDec());
			res.setUserTelEx(res.getUserTelExDec());
			res.setUserMail(res.getUserMailDec());			
		}			
		
	    return res;
	}
	
	@Override
	public CustomReqUserVO getReqUserById(CustomReqUserVO req) {
		CustomReqUserVO res = reqUserDao.getReqUserById(req);
		if( res != null ) {
			res.setUserPhone(res.getUserPhoneDec());
			res.setUserTel(res.getUserTelDec());
			res.setUserTelEx(res.getUserTelExDec());
			res.setUserMail(res.getUserMailDec());			
		}
		
		return res;
	}
	// 사용자 가입 신청 - DB저정
	@Override
	public String setUserInsert(CustomReqUserVO getUserVo) {

		// 시퀀스 생성 
		Date reqUserSeqdate = new Date();
		SimpleDateFormat reqUserFormat = new SimpleDateFormat("yyyyMMddHHmmss");
		String reqUserSeq = reqUserFormat.format(reqUserSeqdate);
		getUserVo.setReqUserSeq(reqUserSeq);
		
		// 패스워드 생성
		getUserVo.setUserPassword(TokenGenerator.generate(getUserVo.getUserId(), getUserVo.getUserPassword()));
		
		//데이터 암호화
		getUserVo.setUserPhone(getUserVo.getUserPhoneEnc());
		getUserVo.setUserTel(getUserVo.getUserTelEnc());
		getUserVo.setUserTelEx(getUserVo.getUserTelExEnc());
		getUserVo.setUserMail(getUserVo.getUserMailEnc());
		reqUserDao.setUserInsert(getUserVo);
		return reqUserSeq;
	}
	
	// 사용자 ID 중복 체크 (req_user, cmm_user 둘 다 체크)
	@Override
	public boolean chkUniqueId(CustomReqUserVO getUserVo) {
		
		CustomCmmUserVO cmmUserVo = new CustomCmmUserVO();
		cmmUserVo.setUserId(getUserVo.getUserId());
		int chkval = 0;
		chkval += (int) reqUserDao.setMbrFormchk(getUserVo);
		chkval += (int) cmmUserDao.setMbrFormchk(cmmUserVo);		
		
		return (chkval == 0);
	}

	// 회원사 목록 조회
	@Override
	public List<CustomCmmCustomerVO> selectCustomerList(CustomCmmCustomerVO customerVo){
		return reqUserDao.selectCustomerList(customerVo);
	}	
	
	// 부서 목록 조회
	@Override
	public List<CustomReqUserVO> selectDepartmentList(CustomReqUserVO reqUserVo) {
		return reqUserDao.selectDepartmentList(reqUserVo);
	}
	
	// 가입요청 승인/거절
	@Override	
	public String UserConfirm(CustomReqUserVO managerVo) {
		
		if(managerVo.getApprvFlag().equals("Y")) {
			// 회원가입 승인
			reqUserDao.setUserConfirm(managerVo);	    // update req_user (apprv_user_id, apprv_flag, spprv_datetime, description)			
			reqUserDao.copyUserInfoToCmm(managerVo);	// copy from req_user to cmm_user
			
			if( StringUtils.isNotBlank(managerVo.getApprvOperation()) ) {
				// 관리자 권한 추가
				CustomAdminUserVO vo = new CustomAdminUserVO(); 
				vo.setUserId(managerVo.getUserId());
				adminUserService.insertAdmin(vo);
				
				if(managerVo.getApprvOperation().equals("WF1000A0")) {
					vo.setWF1000A0("Y"); 
				} else if(managerVo.getApprvOperation().equals("WF1000B0")) {
					vo.setWF1000B0("Y");
				}
				vo.setOperation("N");
				vo.setConfirmAction("N");
				vo.setLogin("N");
				vo.setLength(1);				
				adminUserService.updateAdmin(vo);
			}
			alarmsTemplateService.alarms("52", managerVo.getUserId(), managerVo.getUserId(), "");
		} else if(managerVo.getApprvFlag().equals("J")) { 
			// 회원가입 반려			
			Map<String,String> keywordMap = new HashMap<>();
			keywordMap.put("[[사번]]", managerVo.getUserId());
			keywordMap.put("[[반려사유]]",  managerVo.getDescription());
			alarmsTemplateService.alarms(53, managerVo.getUserId(),keywordMap);
			
			reqUserDao.delete(managerVo.getUserId());
		}
		
		return "1";
	}
}
