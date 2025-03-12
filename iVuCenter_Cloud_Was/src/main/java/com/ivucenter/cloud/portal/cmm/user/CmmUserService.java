package com.ivucenter.cloud.portal.cmm.user;

import java.util.LinkedList;
import java.util.List;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;
import com.ivucenter.cloud.portal.alarms.template.AlarmsTemplateService;
import com.ivucenter.cloud.portal.cmm.customer.CustomCmmCustomerVO;
import com.ivucenter.cloud.portal.operation.approveUser.CustomApproveUserVO;
import com.ivucenter.cloud.portal.req.user.ReqUserDAO;
import com.ivucenter.cloud.portal.util.TokenGenerator;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class CmmUserService {

    private static final Logger logger = LoggerFactory.getLogger(CmmUserService.class);

	@Autowired
	private CmmUserDAO dao;

	@Autowired
	private ReqUserDAO reqDao;

//	@Autowired	private MailTemplateService mailTemplateService;

    @Autowired
    private AlarmsTemplateService alarmsTemplateService;

    private CustomCmmUserVO VoToDec(CustomCmmUserVO vo){
		if(vo != null){
			vo.setUserPhone(vo.getUserPhoneDec());
			vo.setUserTel(vo.getUserTelDec());
			vo.setUserTelEx(vo.getUserTelExDec());
			vo.setUserMail(vo.getUserMailDec());
		}
		return vo;
	}

	private CustomCmmUserVO VoToEnc(CustomCmmUserVO vo){
		if(vo != null){
			vo.setUserPhone(vo.getUserPhoneEnc());
			vo.setUserTel(vo.getUserTelEnc());
			vo.setUserTelEx(vo.getUserTelExEnc());
			vo.setUserMail(vo.getUserMailEnc());
		}
		return vo;
	}

	public String list(CustomCmmUserVO req) {
    	if(req.getSearchKind().equals("userPhone") && req.getKeyword() != ""){ req.setKeyword(req.getUserPhoneEnc()); }
    	if(req.getSearchKind().equals("userTel") && req.getKeyword() != ""){ req.setKeyword(req.getUserTelEnc()); }
    	if(req.getSearchKind().equals("userMail") && req.getKeyword() != ""){ req.setKeyword(req.getUserMailEnc()); }

    	List<CustomCmmUserVO> lists = dao.list(req);
    	int recordsTotal = dao.listTotal(req).size();
    	int recordsFiltered = recordsTotal;

		List<CustomCmmUserVO> list = new LinkedList<CustomCmmUserVO>();
		for(CustomCmmUserVO vo : lists){
			list.add(VoToDec(vo));
		}

	    try {
	        JsonObject jsonResponse = new JsonObject();
	        Gson gson = new Gson();

	        jsonResponse.addProperty("draw", req.getDraw());
	        jsonResponse.addProperty("recordsTotal", recordsTotal);
	        jsonResponse.addProperty("recordsFiltered", recordsFiltered);
	        jsonResponse.add("data", gson.toJsonTree(list));

	        return jsonResponse.toString();
	    } catch (JsonIOException e) {
	        log.error(e.toString());
	    }
		return "";
	}

	public CustomCmmUserVO detail(CustomCmmUserVO req) {
		return VoToDec(dao.detail(VoToEnc(req)));
	}

	public CustomCmmUserVO loginChk(CustomCmmUserVO req) {
		return VoToDec(dao.loginChk(req));
	}

	public CustomCmmUserVO userRoleCheck(CustomCmmUserVO req) {
		return dao.userRoleCheck(req);
	}

	public int userPmCheck(CustomCmmUserVO req) {
		return dao.userPmCheck(req);
	}

	public String userPasswordCheck(CustomCmmUserVO req) {
		return dao.userPasswordCheck(req)+"";
	}

	public CustomCmmUserVO userInfoDetail(CustomCmmUserVO req) {
		return VoToDec(dao.userInfoDetail(req));
	}
	public CustomCmmUserVO userInfoDetail(String userId) {
		return VoToDec(dao.userInfoDetail(userId));
	}

	public String insert(CustomCmmUserVO req) {
		return dao.insert(VoToEnc(req))+"";
	}

	public String insertUserdescription(CustomCmmUserVO req) {
		return dao.insert(VoToEnc(req))+"";
	}

	public String update(CustomCmmUserVO req) {
		req.setUserPassword(TokenGenerator.generate(req.getUserId(), req.getUserPassword()));
		return dao.update(VoToEnc(req))+"";
	}

	public String userInfoUpdate(CustomCmmUserVO req) {
		return dao.userInfoUpdate(VoToEnc(req))+"";
	}

	public String delete(CustomCmmUserVO req) {
		reqDao.delete(req.getUserId());
		return dao.delete(req)+"";
	}

	// 사용자 비밀번호 찾기 결과
	public CustomCmmUserVO getUserInfoByName(CustomCmmUserVO req) {
		return VoToDec(dao.getUserInfoByName(VoToEnc(req)));
	}

	//사용자 비밀번호 초기화 값 입력
	public String setUserPasswordReset(CustomCmmUserVO req) {
		return dao.setUserPasswordReset(req)+"";
	}

	public CustomCmmUserVO getUserInfoById(CustomCmmUserVO req) {
		return VoToDec(dao.getUserInfoById(VoToEnc(req)));
	}

	public String userInfoUpdatepw(CustomCmmUserVO req) {
		return dao.userInfoUpdatepw(VoToEnc(req))+"";
	}

	public String blockUpdate(CustomCmmUserVO req) {
		return dao.blockUpdate(req) + "";
	}

	//사용자 아이디 중복 체크
	public int setMbrFormchk(CustomCmmUserVO req) {
		return dao.setMbrFormchk(req);
	}

	//회원가입신청
	public void setMbrForminsert(CustomCmmUserVO req) {
		String tempPw = makeTempPassword(req);
		req.setUserPassword(tempPw);
		dao.setMbrForminsert(VoToEnc(req));
	}

	//회원사 목록 조회
	public List<CustomCmmCustomerVO> selectCustomerList(CustomCmmCustomerVO req){
		return dao.selectCustomerList(req);
	}
	//회원사 목록 Count
	public int selectCustomerListTot(CustomCmmCustomerVO req){
		return dao.selectCustomerListTot(req);
	}

	//임시비밀번호 return 및 mail_queue 에 정보저장
	public String makeTempPassword(CustomCmmUserVO req){
		UUID uid= UUID.randomUUID();
		String tempPw = TokenGenerator.generate(uid.toString());
		tempPw = tempPw.substring(0, 10);
		alarmsTemplateService.alarms("52", req.getUserId(), tempPw, "");
		return TokenGenerator.generate(req.getUserId(), tempPw);
	}

	public String getTempPw(String userId){

		return dao.getTempPw(userId);
	}

	public String updateUserCustomer(CustomCmmUserVO req) {
		return dao.updateUserCustomer(VoToEnc(req))+"";
	}

	public void loginOk(CustomCmmUserVO req) {
		dao.loginOk(req);
	}

	public void failPassword(CustomCmmUserVO req) {
		dao.failPassword(req);
	}

	public List<CustomCmmUserVO> excel(CustomCmmUserVO req) {
    	if(req.getSearchKind().equals("userPhone") && req.getKeyword() != ""){ req.setKeyword(req.getUserPhoneEnc()); }
    	if(req.getSearchKind().equals("userTel") && req.getKeyword() != ""){ req.setKeyword(req.getUserTelEnc()); }
    	if(req.getSearchKind().equals("userMail") && req.getKeyword() != ""){ req.setKeyword(req.getUserMailEnc()); }

		return dao.list(req);
	}

	public List<CustomCmmUserVO> worklist() {
		return dao.worklist();
	}

	public List<CustomCmmUserVO> loginAdminDetail() {
		return dao.loginAdminDetail();
	}


	public CustomCmmUserVO loginUserApproveYn(String userId) {
		return dao.loginUserApproveYn(userId);

	}


	public String searchUserInfo(CustomApproveUserVO req) {
		try {
			JsonObject jsonResponse = new JsonObject();
			Gson gson = new Gson();
			jsonResponse.add("data", gson.toJsonTree(dao.searchUserInfo(req)));

			return jsonResponse.toString();
		} catch (JsonIOException e) {
            logger.error("JSON 처리 중 오류 발생");
		}
		return "";
	}

	public CustomCmmCustomerVO selectUserCloudCuthority(CustomCmmCustomerVO req){
		return dao.selectUserCloudCuthority(req);
	}


	public int userCloudAuthupdate(CustomCmmUserVO req) {
		return dao.userCloudAuthupdate(req);
	}

	//ip check 추가
	public CustomCmmUserVO getUserInfo(String userId) {
		return dao.getUserInfo(userId);
	}

	public int userIpCheck(CustomCmmUserVO req) {
		return dao.userIpCheck(req);
	}

}
