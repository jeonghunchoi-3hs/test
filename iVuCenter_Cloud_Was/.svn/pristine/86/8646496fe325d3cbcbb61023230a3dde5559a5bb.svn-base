package com.ivucenter.cloud.portal.alarms.template;

import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

import com.ivucenter.cloud.portal.alarms.mail.template.MailTemplateService;
import com.ivucenter.cloud.portal.alarms.sms.template.SmsTemplateService;
import com.ivucenter.cloud.portal.alarms.withkepco.WithKepcoService;
import com.ivucenter.cloud.portal.cmm.user.CmmUserService;
import com.ivucenter.cloud.portal.cmm.user.CustomCmmUserVO;
import com.ivucenter.cloud.portal.req.user.CustomReqUserVO;
import com.ivucenter.cloud.portal.req.user.ReqUserService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class AlarmsTemplateService{
	
	@Autowired 	
	private CmmUserService cmmUserService;
	
	@Autowired	
	private ReqUserService reqUserService;

	@Autowired	
	private MailTemplateService mailTemplateService;
	
	@Autowired	
	private SmsTemplateService smsTemplateService;
	
	@Autowired	
	private WithKepcoService withKepcoService;
	
//	@Autowired 	private NhwithSendService nhwithSendService;	
	
	public String project(String context, String word){
		return context.replace("[[프로젝트명]]", word);
	}
	public String order(String context, String word){
		return context.replace("[[주문번호]]", word);
	}
	public String product(String context, String word){
		return context.replace("[[상품명]]", word);
	}
	public String apply(String context, String word1, String word2){
		context = context.replace("[[상품명]]", word1);
		context = context.replace("[[적용일자]]", word2); 
		return context;
	}
	public String bill(String context, String word){
		try {
			if(word.indexOf("-") == -1){
				word = (String) word.subSequence(0, 4)+"년 "+(String) word.subSequence(4, 6)+"월";
			}else{
				word = word.split("-")[0]+"년 "+word.split("-")[0]+"월";
			}
		} catch (IndexOutOfBoundsException e) {
			log.error(word, e);
		}
		return context.replace("[[정산년월]]", word);
	}
	public String userId(String context, String word){
		return context.replace("[[사번]]", word);
	}
	public String pwd(String context, String word){
		return context.replace("[[패스워드]]", word);
	}
	public String reject(String context, String word){
		return context.replace("[[반려사유]]", word);
	}
		
	public CustomCmmUserVO userInfoDetail(String userId){
		CustomCmmUserVO req = new CustomCmmUserVO();			
		req.setUserId(userId);
		CustomCmmUserVO userVO = cmmUserService.userInfoDetail(req); 
		if(userVO == null) { // 회원가입 반려 시 사용자 정보가 req_user 테이블에 있음.			
			CustomReqUserVO reqUserVo = new CustomReqUserVO ();
			reqUserVo.setUserId(userId);
			CustomReqUserVO res = reqUserService.getReqUserById(reqUserVo);
			
			if(res == null) { return null; }
			
			userVO = new CustomCmmUserVO (); 
			userVO.setUserId(res.getUserId());
			userVO.setUserName(res.getUserName());
			userVO.setUserPhone(res.getUserPhone());
			userVO.setUserMail(res.getUserMail());
			userVO.setMailRecvFlag(res.getMailRecvFlag());
			userVO.setSmsRecvFlag(res.getSmsRecvFlag());
			//userVO.setNhwithRecvFlag("N"); // nh 농협 코드 비활성화
		}
		return userVO;
	}

	/**
	 * @param gbn  : tmplate 구분자 뒤에 2자리
	 * @param userId : 수신자
	 * @param keyword1 : 키워드1
	 * @param keyword2 : 키워드2
	 */
	public void alarms(String gbn, String userId, String keyword1, String keyword2){
		//String sMailTemp = "MAL00"+gbn;
		//String sSmsTemp = "SMS00"+gbn;
		//String sNhwithTemp = "WITH00"+gbn;
		
		//수신여부 조회
		CustomCmmUserVO userVO = userInfoDetail(userId);
		if(userVO == null) {
			log.info(userId+" : cmm_user, req_user 정보 없음");
			return ; 
		}
		
		if(userVO.getMailRecvFlag().equals("Y") && StringUtils.isNotBlank(userVO.getUserMail())) {
			mailTemplateService.alarms(gbn, userVO, keyword1, keyword2);
		}

		if(userVO.getSmsRecvFlag().equals("Y") && StringUtils.isNotBlank(userVO.getUserPhone())){
			smsTemplateService.alarms(gbn, userVO, keyword1, keyword2);
		}
		
		/*
		if(userVO.getNhwithRecvFlag().equals("Y") && StringUtils.isNotBlank(userVO.getUserPhone())){
			nhwithSendService.alarms(gbn, userVO, keyword1, keyword2);
		}
 		*/
	}
	
	public void alarms(int gbn, String userId, Map<String,String> keywordMap) {		
		//수신여부 조회
		CustomCmmUserVO userVO = userInfoDetail(userId);
		if(userVO == null) {
			log.info(userId+" : cmm_user, req_user 정보 없음");
			return ; 
		}
		
		if(userVO.getMailRecvFlag().equals("Y") && StringUtils.isNotBlank(userVO.getUserMail())) {
			mailTemplateService.alarms(gbn, userVO, keywordMap);
		}

		if(userVO.getSmsRecvFlag().equals("Y") && StringUtils.isNotBlank(userVO.getUserPhone())){
			smsTemplateService.alarms(gbn, userVO, keywordMap);
		}
	}
	
	public String mail(int gbn, String userId, Map<String,String> keywordMap) {		
		//수신여부 조회
		CustomCmmUserVO userVO = userInfoDetail(userId);
		if(userVO == null) {
			log.info(userId+" : cmm_user, req_user 정보 없음");
			return "2"; 
		}
		
		if(StringUtils.isNotBlank(userVO.getUserMail())) {
			mailTemplateService.alarms(gbn, userVO, keywordMap);
		}
		return "1";
	}
	
	// 한전 결재 전용 함수 
	// 프로젝트 승인, 자원 요청 승인
//	public void alarmsKepco(int gbn, String requestSeq, String regUserId, String apprvNowUserId, String apprvNextUserId) {
	public void alarmsKepco(Map<String, String> paramMap) {
		Assert.notNull(paramMap.get("gbn"), "gbn이 없습니다.");
		Assert.notNull(paramMap.get("requestSeq"), "requestSeq가 없습니다.");
		Assert.notNull(paramMap.get("regUserId"), "regUserId가 없습니다.");		
		Assert.notNull(paramMap.get("url"), "url이 없습니다.");
		boolean isApprvUser = paramMap.containsKey("apprvNowUserId") || paramMap.containsKey("apprvNextUserId"); 
		Assert.isTrue(isApprvUser, "apprvNowUserId 또는 apprvNextUserId 이 없습니다.");
		
		// 신청자 정보 조회  (register user id)
		CustomCmmUserVO regUserVO = userInfoDetail(paramMap.get("regUserId"));
		if(regUserVO != null) {
			paramMap.put("regUserName", regUserVO.getUserName());
		}
		
		// 한전 결재 연계 시스템 전송
		withKepcoService.alarmsKepco(paramMap);
	}
}