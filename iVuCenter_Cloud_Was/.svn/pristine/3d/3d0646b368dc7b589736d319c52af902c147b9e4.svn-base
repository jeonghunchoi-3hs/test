package com.ivucenter.cloud.batch.provisioning;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.apache.commons.lang.time.DateFormatUtils;
import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ivucenter.cloud.api.openstack.connector.OpenStackRestConnector;
import com.ivucenter.cloud.entity.MailQueueVO;
import com.ivucenter.cloud.entity.MngNhwithVO;
import com.ivucenter.cloud.entity.SmsQueueVO;
import com.ivucenter.cloud.portal.alarms.mail.template.CustomMailTemplateVO;
import com.ivucenter.cloud.portal.alarms.sms.template.CustomSmsTemplateVO;
import com.ivucenter.cloud.portal.alarms.withnh.CustomNhwithVO;
import com.ivucenter.cloud.portal.cmm.user.CustomCmmUserVO;
import com.ivucenter.cloud.portal.req.product.CustomReqProductVO;
import com.ivucenter.cloud.portal.req.product.ReqProductService;
import com.ivucenter.cloud.portal.util.AES256Util;
import com.ivucenter.cloud.portal.util.CodeUtil;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class BatchAlarmService {

	private final String insertMailQueue = "com.ivucenter.cloud.portal.mail.queue.MailQueueDAO.insert";
	private final String insertSmsQueue = "com.ivucenter.cloud.portal.sms.queue.SmsQueueDAO.insert";
	private final String insertNhwithTemplateHistory = "com.ivucenter.cloud.portal.mng.nhwith.NhwithDAO.nhwithTemplateHistoryInsert";

	private final String detailMailTemplate = "com.ivucenter.cloud.portal.mail.template.MailTemplateDAO.detail";
	private final String detailSmsTemplate = "com.ivucenter.cloud.portal.sms.template.SmsTemplateDAO.detail";
	private final String detailNhwithTemplate = "com.ivucenter.cloud.portal.mng.nhwith.NhwithDAO.templateviewDetail";

	private final String detailCmmUser = "com.ivucenter.cloud.portal.cmm.user.CmmUserDAO.detail";

	@Autowired
	private ReqProductService reqProductService;

	@Autowired
	SqlSessionFactory sqlSessionFactory4;

    private static final Logger logger = LoggerFactory.getLogger(BatchAlarmService.class);


	public void sendAlarmMessage(String templateId, String receiverId, String productName,String orderProductSeq) {
		SqlSessionTemplate sqlSessionTemplate = new SqlSessionTemplate(this.sqlSessionFactory4, ExecutorType.BATCH);

		CustomCmmUserVO paramCmmUserVO = new CustomCmmUserVO();
		paramCmmUserVO.setUserId(receiverId);
		CustomCmmUserVO cmmUser = sqlSessionTemplate.selectOne(detailCmmUser, paramCmmUserVO);

		sendMail("MAL"+templateId, receiverId, productName,orderProductSeq);

		/* NHWith 부분 제거
		if ("Y".equals(cmmUser.getNhwithRecvFlag())) {
			sendNHwith("WITH"+templateId, cmmUser, productName);
		}
		*/
		log.warn("cmmUser.getSmsRecvFlag()=" + cmmUser.getSmsRecvFlag());

		if ("Y".equals(cmmUser.getSmsRecvFlag())) {
			sendSMS("SMS"+templateId, cmmUser, productName);
		}
	}


	/**********************************************************
	 * sendMail :
	 * 		암호화된 값으로 MailQueue에 넣으면 된다.
	 *		History는 Mail 발송 배치가 MailQueue 데이터를 전송하고 MailQueueHistory에 저장한다.
	 **********************************************************/
	private void sendMail(String templateId, String receiverId, String productName,String orderProductSeq) {
		SqlSessionTemplate sqlSessionTemplate = new SqlSessionTemplate(this.sqlSessionFactory4, ExecutorType.BATCH);

		try {
			String uuid = DateFormatUtils.format(new Date(), "yyyyMMddHHmm_")+UUID.randomUUID().toString();

			// 템플릿 정의
			CustomMailTemplateVO paramMailTemplateVO = new CustomMailTemplateVO();
			paramMailTemplateVO.setTemplateId(templateId);;
			CustomMailTemplateVO mailTemplate = sqlSessionTemplate.selectOne(detailMailTemplate, paramMailTemplateVO);

			String content = mailTemplate.getContent();
			content = content.replace("[[상품명]]", productName);
			String currentDate = DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:00");
			content = content.replace("[[적용일자]]", currentDate);
			StringBuffer buf = new StringBuffer();
			String orderUserName = "";
			String serverInfo = "";
			List<CustomReqProductVO> getReqOrderlistVo = reqProductService.getReqOrderList(orderProductSeq);
			for(CustomReqProductVO reqProductVo : getReqOrderlistVo) {

				buf.append(reqProductVo.getOrderSummary());
				orderUserName = reqProductVo.getUserName();
			}
			serverInfo += "<hr /><p>생성된 자원의 서버 정보 및 계정 정보는 아래와 같습니다.</p>";
			serverInfo += (buf.length() > 0) ? buf.toString() : "";
			for(CustomReqProductVO reqProductVo : getReqOrderlistVo) {
				if(reqProductVo.getRequestType().equals("REQTYPE_NEW") && reqProductVo.getProductCategory().equals("PRODCATE_VM")){
					CustomReqProductVO vmInfo = reqProductService.getOrderVm(orderProductSeq);
					serverInfo += "<br />호스트명 : "+vmInfo.getHostnameAlias();
					serverInfo += "<br />IP : "+vmInfo.getDefaultNetworkIp();
					if(vmInfo.getBackupNetworkFlag().equals("Y")) {
						serverInfo += "<br />BACKUP IP : "+vmInfo.getBackupNetworkIp();
					}
					serverInfo += "<br />PORT : 윈도우 RDP : 29338, 리눅스 SSH : 22002";
					serverInfo += "<br />ID : appuser";
					serverInfo += "<br />PW : kepco123/456";
				}
			}
			content = content.replace("[[서버명]]", serverInfo);

			// 사용자 정보 정의
			CustomCmmUserVO paramCmmUserVO = new CustomCmmUserVO();
			paramCmmUserVO.setUserId(receiverId);
			CustomCmmUserVO cmmUser = sqlSessionTemplate.selectOne(detailCmmUser, paramCmmUserVO);


			AES256Util aes = new AES256Util(CodeUtil.KEY_SPEC);

			MailQueueVO mailQueueVo = new MailQueueVO();
			mailQueueVo.setMailSeq(uuid);
			mailQueueVo.setTemplateId(templateId);
			mailQueueVo.setTitle(mailTemplate.getTitle());
			mailQueueVo.setContent(content);
			mailQueueVo.setSenderName(aes.encrypt(CodeUtil.SENDERNAME));
			mailQueueVo.setSenderMail(aes.encrypt(CodeUtil.SENDERMAIL));
			mailQueueVo.setReceiverFlg(CodeUtil.USERRECEIVERFLG);
			mailQueueVo.setReceiverId(aes.encrypt(receiverId));
			mailQueueVo.setReceiverName(aes.encrypt(cmmUser.getUserName()));
			mailQueueVo.setReceiverMail(cmmUser.getUserMail());
			mailQueueVo.setRegUserId(receiverId);

			sqlSessionTemplate.insert(insertMailQueue, mailQueueVo);
		} catch (Exception e) {
			logger.error("sendMail Exception ");
		}
	}


//	private void sendNHwith(String templateId, CustomCmmUserVO cmmUser, String productName) {
//		SqlSessionTemplate sqlSessionTemplate = new SqlSessionTemplate(this.sqlSessionFactory4, ExecutorType.BATCH);
//
//		new Thread(new Runnable() {
//
//			@Override
//			public void run() {
//				try {
//				// 템플릿 정의
//					CustomNhwithVO paramNhwithTemplateVO = new CustomNhwithVO();
//					paramNhwithTemplateVO.setTemplateId(templateId);;
//					CustomNhwithVO nhwithTemplate = sqlSessionTemplate.selectOne(detailNhwithTemplate, paramNhwithTemplateVO);
//
//					String content = nhwithTemplate.getContent();
//					content = content.replace("[[상품명]]", productName);
//					String currentDate = DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:00");
//					content = content.replace("[[적용일자]]", currentDate);
//
////					// 사용자 정보 정의
////					CustomCmmUserVO paramCmmUserVO = new CustomCmmUserVO();
////					paramCmmUserVO.setUserId(receiverId);
////					CustomCmmUserVO cmmUser = sqlSessionTemplate.selectOne(detailCmmUser, paramCmmUserVO);
//
//					// NHwith 정의
//					String nhwithSeq = DateFormatUtils.format(new Date(), "yyyyMMddHHmm_")+UUID.randomUUID().toString();
//					String sTitle = DateFormatUtils.format(new Date(), "yyyyMMddHHmmss ") + nhwithTemplate.getTitle();
//
//					List<String> receivers = new ArrayList<String>();
//					receivers.add(cmmUser.getUserId()); //수신자 사번(ID);
//					String senderId = CodeUtil.NHWITHSENDERID;
//					String senderName = CodeUtil.NHWITHSENDERNAME;
//
//					NhWithApi nhwith = new NhWithApi("nhwith.properties");
//					nhwith.setSenderId(CodeUtil.NHWITHSENDERID); // CLOUDADMIN
//					nhwith.setSenderName(CodeUtil.NHWITHSENDERNAME); //발신자 아이뷰센터 클라우드관리자
//					nhwith.setReceivers(receivers);
//					nhwith.setTitle(sTitle); // 제목
//					nhwith.setContent(content);
//
//					boolean result = nhwith.send();
//
//					AES256Util aes = new AES256Util(CodeUtil.KEY_SPEC);
//
//				// NHwith DB 정의
//					MngNhwithVO nhwithVO = new MngNhwithVO();
//					nhwithVO.setNhwithSeq(nhwithSeq);
//					nhwithVO.setTemplateId(templateId);
//					nhwithVO.setTitle(sTitle);
//					nhwithVO.setContent(content);
//					nhwithVO.setSenderName(aes.encrypt(senderName));
//					nhwithVO.setSenderId(aes.encrypt(senderId));
//					nhwithVO.setReceiverId(aes.encrypt(cmmUser.getUserId()));
//					nhwithVO.setReceiverName(aes.encrypt(cmmUser.getUserName()));
//					nhwithVO.setResultFlg(result?"Y":"N");
//					nhwithVO.setReceiverFlg("U");
//
//					sqlSessionTemplate.insert(insertNhwithTemplateHistory, nhwithVO);
//				} catch (Exception e) {
//				}
//			}
//		}).start();
//	}



	/**********************************************************
	 * sendSMS :
	 **********************************************************/
	private void sendSMS(String templateId, CustomCmmUserVO cmmUser, String productName) {
		SqlSessionTemplate sqlSessionTemplate = new SqlSessionTemplate(this.sqlSessionFactory4, ExecutorType.BATCH);


		try {
			String uuid = DateFormatUtils.format(new Date(), "yyyyMMddHHmm_")+UUID.randomUUID().toString();

			// 템플릿 정의
			CustomSmsTemplateVO paramSmsTemplateVO = new CustomSmsTemplateVO();
			paramSmsTemplateVO.setTemplateId(templateId);;
			CustomSmsTemplateVO smsTemplate = sqlSessionTemplate.selectOne(detailSmsTemplate, paramSmsTemplateVO);

			String message = smsTemplate.getMessage();
			message = message.replace("[[상품명]]", productName);
			String currentDate = DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:00");
			message = message.replace("[[적용일자]]", currentDate);

			AES256Util aes = new AES256Util(CodeUtil.KEY_SPEC);

			SmsQueueVO SmsQueueVO = new SmsQueueVO();
			SmsQueueVO.setSmsSeq(uuid);
			SmsQueueVO.setTemplateId(templateId);
			SmsQueueVO.setSenderName(aes.encrypt(CodeUtil.SMSSENDERID));
			SmsQueueVO.setSenderNumber(aes.encrypt(CodeUtil.SMSSENDERNUMBER));
			SmsQueueVO.setReceiverFlg("U");
			SmsQueueVO.setReceiverId(aes.encrypt(cmmUser.getUserId()));
			SmsQueueVO.setReceiverName(aes.encrypt(cmmUser.getUserName()));
			SmsQueueVO.setReceiverNumber(cmmUser.getUserPhone());
			SmsQueueVO.setMessage(message);
			SmsQueueVO.setRegUserId(CodeUtil.SMSSENDERID);

			sqlSessionTemplate.insert(insertSmsQueue, SmsQueueVO);
		} catch (Exception e) {
			logger.error("sendSMS Exception ");
		}
	}
}
