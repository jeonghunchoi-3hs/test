package com.ivucenter.cloud.batch.sendmail;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeUtility;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ivucenter.cloud.api.openstack.connector.OpenStackRestConnector;
import com.ivucenter.cloud.entity.MailQueueHistoryVO;
import com.ivucenter.cloud.entity.MailQueueVO;
import com.ivucenter.cloud.portal.util.CodeUtil;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service("commonSendMailService")
public class CommonSendMailService {

    private static final Logger logger = LoggerFactory.getLogger(CommonSendMailService.class);

	private final String deleteMailQueue = "com.ivucenter.cloud.portal.mail.queue.MailQueueDAO.batchDelete";
	private final String insertMailHistory = "com.ivucenter.cloud.portal.mail.queue.history.MailQueueHistoryDAO.insert";

	@Autowired
    private SqlSession sqlSession;

//	@Autowired	private MailQueueDAO mailQueueDAO;

	public void sendEmail(MailQueueVO mailQueue) {

		new Thread(new Runnable() {

			@Override
			public void run() {
				synchronized (CommonSendMailService.class) {
					
				String from = mailQueue.getSenderMailDec();
				String to = mailQueue.getReceiverMailDec();

				String host = CodeUtil.MAIL_SMTP_HOST;
				String subject = mailQueue.getTitle();
				String content = mailQueue.getContent();

				String result_flg = "Y";	// 정상전송여부
				try {
					log.debug("from   : " + from);
					log.debug("to     : " + to);
					log.debug("host   : " + host);
					log.debug("subject: " + subject);
					log.debug("content: " + content);

					emailSender(from, to, host, subject, content);
				} catch (Exception e) {
					result_flg = "N";

					logger.error("emailSender Exception");

					log.warn("[WARNING] Could not connect to SMTP host: " + host + ", port: 25");
				}

				// 발송된 메일 삭제
				deleteMailQueue(mailQueue);

				// 발송된 메일 이력 저장
				storeMailQueueHistory(mailQueue, result_flg);
			}
			}
		}).start();

	}

	private void emailSender(String from, String to, String host, String subject, String content) throws Exception {
		Properties properties = System.getProperties();
		properties.setProperty("mail.smtp.host", host);

		Session session = Session.getDefaultInstance(properties);

		MimeMessage message = new MimeMessage(session);

		message.setFrom(new InternetAddress(from));
		message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));

		message.setSubject(MimeUtility.encodeText(subject, "UTF-8", "B"));
		message.setContent(content, "text/html;charset=UTF-8");

		log.debug(message.toString());
		try {
			Transport.send(message);
		} catch(Exception e) {
			log.error(e.getMessage());
		}
	}

	private void storeMailQueueHistory(MailQueueVO mailQueue, String result_flg) {
		/**************************************/
		// 메일 이력에 발송 내역 저장
		/**************************************/
		MailQueueHistoryVO mailHistory = new MailQueueHistoryVO();
		mailHistory.setMailSeq(mailQueue.getMailSeq());
		mailHistory.setTemplateId(mailQueue.getTemplateId());
		mailHistory.setTitle(mailQueue.getTitle());
		mailHistory.setContent(mailQueue.getContent());
		mailHistory.setSenderName(mailQueue.getSenderName());
		mailHistory.setSenderMail(mailQueue.getSenderMail());
		mailHistory.setReceiverId(mailQueue.getReceiverId());
		mailHistory.setReceiverName(mailQueue.getReceiverName());
		mailHistory.setReceiverMail(mailQueue.getReceiverMail());
		mailHistory.setRetryCount(mailQueue.getRetryCount());
		mailHistory.setResultFlg(result_flg);
		mailHistory.setRedirectUrl(mailQueue.getRedirectUrl());
		sqlSession.insert(insertMailHistory, mailHistory);
		//sqlSessionTemplate.insert(insertMailHistory, mailHistory);
	}

	private void deleteMailQueue(MailQueueVO mailQueue) {
		sqlSession.delete(deleteMailQueue, mailQueue);
	}
}
