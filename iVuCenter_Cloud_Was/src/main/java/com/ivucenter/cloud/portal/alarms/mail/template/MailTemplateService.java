package com.ivucenter.cloud.portal.alarms.mail.template;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateFormatUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;
import com.ivucenter.cloud.api.openstack.connector.OpenStackRestConnector;
import com.ivucenter.cloud.portal.alarms.mail.queue.CustomMailQueueVO;
import com.ivucenter.cloud.portal.alarms.mail.queue.MailQueueService;
import com.ivucenter.cloud.portal.alarms.template.AlarmsTemplateService;
import com.ivucenter.cloud.portal.cmm.user.CustomCmmUserVO;
import com.ivucenter.cloud.portal.util.CodeUtil;


@Service
public class MailTemplateService{

    private static final Logger logger = LoggerFactory.getLogger(MailTemplateService.class);

	@Autowired
	private MailTemplateDAO dao;

	@Autowired
	private MailQueueService mailQueueService;

	@Autowired
	private AlarmsTemplateService alarmsTemplateService;

	public String list(CustomMailTemplateVO req) {
	    int recordsTotal;
	    int recordsFiltered;

    	List<CustomMailTemplateVO> lists = dao.list(req);
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
            logger.error("JSON 처리 중 오류 발생");
	    }
		return "";
	}

	public CustomMailTemplateVO detail(CustomMailTemplateVO req) {
		return dao.detail(req);
	}

	public String update(CustomMailTemplateVO req) {
		return dao.update(req)+"";
	}

	public List<CustomMailTemplateVO> excel(CustomMailTemplateVO req) {
		return dao.listTot(req);
	}

	public void alarms(String gbn, CustomCmmUserVO req, String keyword1, String keyword2) {
		String templateId = "MAL00"+gbn;
		CustomMailTemplateVO setmailTemplateVo = getTemplate(templateId);
		CustomMailQueueVO mailQueueVo = setMailQueue(setmailTemplateVo, req);
		mailQueueVo.setTemplateId(templateId);
		mailQueueVo.setContent(getContent(gbn, setmailTemplateVo.getContent(), keyword1, keyword2));

		mailQueueService.insert(mailQueueVo);
	}

	private CustomMailTemplateVO getTemplate(String templateId){
		CustomMailTemplateVO mailTemplateVo = new CustomMailTemplateVO();
		mailTemplateVo.setTemplateId(templateId);
		return detail(mailTemplateVo);
	}

	private CustomMailQueueVO setMailQueue(CustomMailTemplateVO setmailTemplateVo, CustomCmmUserVO req){
		CustomMailQueueVO mailQueueVo = new CustomMailQueueVO();
		mailQueueVo.setMailSeq(DateFormatUtils.format(new Date(), "yyyyMMddHHmm_")+UUID.randomUUID().toString());
		mailQueueVo.setTemplateId(setmailTemplateVo.getTemplateId());
		mailQueueVo.setTitle(setmailTemplateVo.getTitle());
		mailQueueVo.setSenderName(CodeUtil.SENDERNAME);
		mailQueueVo.setSenderMail(CodeUtil.SENDERMAIL);
		mailQueueVo.setReceiverFlg(CodeUtil.USERRECEIVERFLG);
		mailQueueVo.setReceiverId(req.getUserId());
		mailQueueVo.setReceiverName(req.getUserName());
		mailQueueVo.setReceiverMail(req.getUserMail());
		mailQueueVo.setRegUserId(req.getUserId());
		return mailQueueVo;
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

	public void alarms(int gbn, CustomCmmUserVO req, Map<String,String> keywordMap) {

		String templateId = "MAL00"+gbn;

		CustomMailTemplateVO mailTemplateVo = getTemplate(templateId);
		CustomMailQueueVO mailQueueVo = setMailQueue(mailTemplateVo, req);
		mailQueueVo.setTemplateId(templateId);

		String redirectUrl = "";
		boolean isRedirect = keywordMap.containsKey("[[URL]]");
		if(isRedirect) {
			redirectUrl = keywordMap.get("[[URL]]");
			boolean isMng = StringUtils.contains(redirectUrl, "/mng/");
			if(isMng) {
				keywordMap.put("[[URL]]", "http://k-cloud.kepco.co.kr/mng/alarms/mail/redirect/" + mailQueueVo.getMailSeq());
			} else {
				keywordMap.put("[[URL]]", "http://k-cloud.kepco.co.kr/mbr/alarms/mail/redirect/" + mailQueueVo.getMailSeq());
			}
		}

		String msg = getContent(gbn, mailTemplateVo.getContent(), keywordMap);
		mailQueueVo.setContent(msg);
		mailQueueVo.setRedirectUrl(redirectUrl);

		if(msg != null && !"".equals(msg)) { mailQueueService.insert(mailQueueVo); }
	}

	private String getContent(int gbn, String content, Map<String,String>keywordMap) {
		String ret = "";
		List<String> keyArr = new ArrayList<>();
		// 이곳에 정의된 gbn 만 insert
		switch(gbn) {
			case 70:
				keyArr.add("[[date]]");
				keyArr.add("[[content1]]");
				keyArr.add("[[content2]]");
				keyArr.add("[[content3]]");
				keyArr.add("[[content4]]");
				break;
			case 60: // 변환 키워드는 없지만 ret에 데이터가 있어야 발송됨.
				ret = content; // "K-Cloud Q&A 서비스 답변 완료";
				break;
			case 20: case 21: // 프로젝트 신청, 프로젝트 신청완료
				keyArr.add("[[프로젝트명]]");
				keyArr.add("[[관리자명]]");
				keyArr.add("[[URL]]");
				break;
			case 22: // 프로젝트 반려
				keyArr.add("[[프로젝트명]]");
				keyArr.add("[[관리자명]]");
				keyArr.add("[[반려사유]]");
				keyArr.add("[[URL]]");
				break;
			case 23: // 프로젝트 승인 요청
				keyArr.add("[[프로젝트명]]");
				keyArr.add("[[URL]]");
				break;
			case 33: // 자원 승인 요청
				keyArr.add("[[신청자명]]");
				keyArr.add("[[URL]]");
				keyArr.add("[[LURL]]");
				break;
			case 30: case 31:  // 자원 신청, 자원 신청 완료
				keyArr.add("[[신청자명]]");
				keyArr.add("[[URL]]");
				break;
			case 32: // 자원 빈려
				keyArr.add("[[신청자명]]");
				keyArr.add("[[반려사유]]");
				keyArr.add("[[URL]]");
				break;
			case 35: case 38: // 작업 요청 등록, 작업 반려
				keyArr.add("[[상품명]]");
				keyArr.add("[[URL]]");
				break;
			case 36: // 작업 요청, 작업 완료
				keyArr.add("[[상품명]]");
				keyArr.add("[[적용일자]]");
				break;
			case 37:
				keyArr.add("[[상품명]]");
				keyArr.add("[[서버명]]");
				keyArr.add("[[적용일자]]");
				break;
			case 40: case 41: case 42: // 정산
				keyArr.add("[[정산년월]]");
				break;
			case 50: case 52: case 54: case 55: //사번찾기, 회원가입 완료, 회원가입 신청, 회원가입 승인요청
				keyArr.add("[[사번]]");
				break;
			case 51: // 패스워드 찾기
				keyArr.add("[[패스워드]]");
				break;
			case 53: // 회원가입 반려
				keyArr.add("[[사번]]");
				keyArr.add("[[반려사유]]");
				break;
		}

		for(String key : keyArr) { content = content.replace(key, keywordMap.get(key)); }
		if( ! keyArr.isEmpty()) { ret = content; }

		return ret;
	}
}
