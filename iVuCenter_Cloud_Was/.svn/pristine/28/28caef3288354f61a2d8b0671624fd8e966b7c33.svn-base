package com.ivucenter.cloud.portal.alarms.sms.template;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.lang.RandomStringUtils;
import org.apache.commons.lang.time.DateFormatUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;
import com.ivucenter.cloud.portal.alarms.sms.queue.CustomSmsQueueVO;
import com.ivucenter.cloud.portal.alarms.sms.queue.SmsQueueService;
import com.ivucenter.cloud.portal.alarms.template.AlarmsTemplateService;
import com.ivucenter.cloud.portal.cmm.user.CustomCmmUserVO;
import com.ivucenter.cloud.portal.util.CodeUtil;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class SmsTemplateService{
	
	@Autowired
	private SmsTemplateDAO dao;
	
	@Autowired
	private SmsQueueService smsQueueService;
	
	@Autowired
	private AlarmsTemplateService alarmsTemplateService;
	
	public String list(CustomSmsTemplateVO req) {
	    int recordsTotal; 
	    int recordsFiltered;
	    
    	List<CustomSmsTemplateVO> lists = dao.list(req);
	    recordsTotal = dao.listTot(req).size();
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
	
	public CustomSmsTemplateVO detail(CustomSmsTemplateVO req) {
		return dao.detail(req);
	}

	public String update(CustomSmsTemplateVO req) {
		return dao.update(req)+"";
	}

	public List<CustomSmsTemplateVO> excel(CustomSmsTemplateVO req) {
		return dao.listTot(req);
	}
	
	public void alarms(String gbn, CustomCmmUserVO req, String keyword1, String keyword2) {
		String templateId =  "SMS00"+gbn;
		CustomSmsTemplateVO customSmsTemplateVO = getTemplate(templateId);
		CustomSmsQueueVO customSmsQueueVO = setSmsQueue(customSmsTemplateVO, req);
		customSmsQueueVO.setTemplateId(templateId);		
		customSmsQueueVO.setMessage(getContent(gbn, customSmsTemplateVO.getMessage(), keyword1, keyword2));
		
		smsQueueService.insertQueue(customSmsQueueVO);				
	}
	
	private CustomSmsQueueVO setSmsQueue(CustomSmsTemplateVO customSmsTemplateVO, CustomCmmUserVO req){
		CustomSmsQueueVO customSmsQueueVO = new CustomSmsQueueVO();
		customSmsQueueVO.setSenderName(CodeUtil.SMSSENDERID);
		customSmsQueueVO.setSenderNumber(CodeUtil.SMSSENDERNUMBER);
		customSmsQueueVO.setRegUserId(CodeUtil.SMSSENDERID);
		customSmsQueueVO.setSmsSeq(DateFormatUtils.format(new Date(), "yyyyMMddHHmm_")+UUID.randomUUID().toString());
		customSmsQueueVO.setSmsShortSeq(RandomStringUtils.randomNumeric(15));
		customSmsQueueVO.setReceiverFlg(CodeUtil.USERRECEIVERFLG);
		customSmsQueueVO.setReceiverNumber(req.getUserPhone());
		customSmsQueueVO.setReceiverName(req.getUserName());
		customSmsQueueVO.setReceiverId(req.getUserId());
		return customSmsQueueVO;
	}
	
	public CustomSmsTemplateVO getTemplate(String templateId){
		CustomSmsTemplateVO smsTemplateVo = new CustomSmsTemplateVO();
		smsTemplateVo.setTemplateId(templateId);		
		return detail(smsTemplateVo);
	}	
	
	private String getContent(String gbn, String content, String keyword1, String keyword2) {
		
		switch(Integer.parseInt(gbn)) {
			case 20: case 21:
				return alarmsTemplateService.project(content, keyword1);
			case 30: case 32: case 33: case 23:
				return alarmsTemplateService.order(content, keyword1);
			case 31: case 34: case 35: case 36: case 38:
				return alarmsTemplateService.product(content, keyword1);
			case 37:
				return alarmsTemplateService.apply(content, keyword1, keyword2);
			case 40: case 41: case 42:
				return alarmsTemplateService.bill(content, keyword1);
			case 50: case 52:
				return alarmsTemplateService.userId(content, keyword1);
			case 51: 
				return alarmsTemplateService.pwd(content, keyword1);
			case 53:
				return alarmsTemplateService.reject(content, keyword1);				
		}		
		return "";
	}

	public void alarms(int gbn, CustomCmmUserVO req, Map<String, String> keywordMap) {
		String templateId =  "SMS00"+gbn;
		CustomSmsTemplateVO smsTemplateVO = getTemplate(templateId);
		String msg = getContent(gbn, smsTemplateVO.getMessage(), keywordMap);
		if(msg != null && !"".equals(msg)) {
			CustomSmsQueueVO insertVO = setSmsQueue(smsTemplateVO, req);
			insertVO.setTemplateId(templateId);		
			insertVO.setMessage(msg);
			smsQueueService.insertQueue(insertVO);			
		}				
	}
	
	private String getContent(int gbn, String content, Map<String, String> keywordMap) {

		String ret = "";
		List<String> key = new ArrayList<>();
		
		switch(gbn) {  // 이곳에 정의된 gbn 만 insert
			case 23: case 33:  	// 문자 발송 안함 
				break;
			case 60: // 변환 키워드는 없지만 ret에 내용이 있어야 발송됨
				ret = content; //"K-Cloud Q&A 서비스 답변 완료";
				break;
			case 20: case 21: case 22: // 프로젝트 신청, 승인완료, 승인 반려
				key.add("[[프로젝트명]]");				
				break;
			case 30: case 31: case 32: // 자원 신청, 승인완료, 승인반려
				key.add("[[신청자명]]");				
				break;
			case 35: case 36: case 37:case 38: // 작업요청등록, 작업요청, 작업 완료, 작업반려
				key.add("[[상품명]]");
				break;
			case 40: case 41: case 42: // 정산
				key.add("[[정산년월]]");				
				break;
			case 50: case 52: case 54: case 55: // 사번찾기,회원가입 승인완료, 신청, 승인요청
				key.add("[[사번]]");
				break;
			case 51: // 비밀번호찾기
				key.add("[[패스워드]]");				
				break;
			case 53: // 회원가입 반려
				key.add("[[반려사유]]");				
				break;				
		}
		if( ! key.isEmpty()) {
			ret = content.replace(key.get(0), keywordMap.get(key.get(0)));
		}
		
		return ret;
	}
}
