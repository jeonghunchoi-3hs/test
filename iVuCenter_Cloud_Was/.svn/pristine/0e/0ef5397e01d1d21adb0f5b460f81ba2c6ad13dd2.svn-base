package com.ivucenter.cloud.batch.sendsms;

import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.InetSocketAddress;
import java.net.Socket;
import java.net.UnknownHostException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ivucenter.cloud.portal.alarms.sms.history.CustomSmsQueueHistoryVO;
import com.ivucenter.cloud.portal.alarms.sms.queue.CustomSmsQueueVO;
import com.ivucenter.cloud.portal.util.CodeUtil;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service("commonSendSmsService")
public class CommonSendSmsService {	

	private final String insertSendSms 		= "com.ivucenter.cloud.portal.sms.queue.SmsQueueDAO.insertSendSms";
	private final String insertSmsHistory 	= "com.ivucenter.cloud.portal.sms.queue.history.SmsQueueHistoryDAO.insert";
	private final String deleteSmsQueue 	= "com.ivucenter.cloud.portal.sms.queue.SmsQueueDAO.delete";
	private final String updateSmsQueue		= "com.ivucenter.cloud.portal.sms.queue.SmsQueueDAO.updateRetryCount";	

	
	@Autowired
    private SqlSession sqlSession;	

	@Setter
	private SqlSessionFactory sqlSessionFactory;    

    @Setter	
	private Map<String, Object> parameterValues;
	

	public void sendSmsDB(CustomSmsQueueVO smsQueue) {
		new Thread(new Runnable() {
			@Override
			public void run() {			
				synchronized (CommonSendSmsService.class) {
					
				CustomSmsQueueVO item = new CustomSmsQueueVO();
				item.setMessage(smsQueue.getMessage());
				item.setSenderNumber(smsQueue.getSenderNumberDec().replace("-", ""));
				item.setReceiverNumber(smsQueue.getReceiverNumberDec().replace("-", ""));			
				
				String msg =item.getMessage();
				final int unitSize = 40;
				int unitMsgSize = unitSize;
				if(msg.length() > unitSize){						
					final int cnt = (int) Math.ceil(msg.length()/(double)unitSize) ;					
					for(int i = 0 ; i < cnt ; i++ ){						
						if(msg.length() < unitMsgSize){ unitMsgSize = msg.length(); }
						String subMsg = msg.substring(i * unitSize, unitMsgSize);
						unitMsgSize += unitSize;
						
						item.setMessage(subMsg);
						sqlSession.insert(insertSendSms, item);
					}				
				}else{
					sqlSession.insert(insertSendSms, item);
				}				
				// 발송된 문자 삭제
				deleteSmsQueue(smsQueue);

				// 발송된 문자 이력 저장
				storeSmsQueueHistory(smsQueue, true);
			}
			}
		}).start();
	}
	public void sendSmsSocket(List<CustomSmsQueueVO> smsQueueList ) {
//		new Thread(new Runnable() {
//			@Override
//			public void run() {

				for(CustomSmsQueueVO smsQueueVo : smsQueueList) {
					
//					log.debug(smsQueueVo.toString());
					
					CustomSmsQueueVO item = new CustomSmsQueueVO();
					item.setSmsShortSeq(smsQueueVo.getSmsShortSeq());
					item.setMessage(smsQueueVo.getMessage().replace("\r", "").replace("\n", ""));
					item.setSenderNumber(smsQueueVo.getSenderNumberDec().replace("-", ""));
					item.setReceiverNumber(smsQueueVo.getReceiverNumberDec().replace("-", ""));
					item.setReceiverId(smsQueueVo.getReceiverIdDec());

					boolean sendOk = false;
					String msg =item.getMessage();
					final int unitSize = 40;
					int unitMsgSize = unitSize;
					if(msg.length() > unitSize){						
						final int cnt = (int) Math.ceil(msg.length()/(double)unitSize) ;					
						for(int i = 0 ; i < cnt ; i++ ){						
							if(msg.length() < unitMsgSize){ unitMsgSize = msg.length(); }
							String subMsg = msg.substring(i * unitSize, unitMsgSize);
							unitMsgSize += unitSize;
							
							item.setMessage(subMsg);
							sendOk = sendMsg(item);
						}				
					}else{
						sendOk = sendMsg(item);
					}
					
					if(sendOk || (smsQueueVo.getRetryCount()>=3) ) { 
						// 정상 전송 또는 3회 이상 실패
						deleteSmsQueue(smsQueueVo); 				// 발송된 문자 삭제
						storeSmsQueueHistory(smsQueueVo, sendOk); 	// 발송된 문자 이력 저장					
					} else {
						// 3회 이하 실패
						//smsQueueVo.setRetryCount(smsQueueVo.getRetryCount() + 1);
						updateSmsQueue(smsQueueVo);
					}
				} // end of for
//			}
//		}).start();
	}
	
	private boolean sendMsg(CustomSmsQueueVO item) {
		InetSocketAddress isa = new InetSocketAddress(CodeUtil.SMS_HOST, CodeUtil.SMS_PORT);					

		try(Socket socket = new Socket()) {
			socket.setReuseAddress(true);
			socket.setSoTimeout(3000);
			socket.setSoLinger(true, 0);			
			socket.connect(isa);
			
			try(BufferedOutputStream bout = new BufferedOutputStream(socket.getOutputStream());
			BufferedReader reader = new BufferedReader(new InputStreamReader(socket.getInputStream()))) {
			
			SMS_INFO info = new SMS_INFO(item);
						
			bout.write(info.getInfo());
			bout.flush();

			String line;
			while((line = reader.readLine()) != null) {
				log.info("SMS Result (9999) :" + line);				
			}

			}	catch (IOException ex) {
				log.error("ERROR: IOException() "+ex.getMessage());
				return false;				
			}
		}	catch (UnknownHostException ex) {
			log.error("ERROR: UnknownHostException() " + ex.getMessage() );
			return false;
		} catch (IOException ex) {
			log.error("ERROR: IOException() "+ex.getMessage());
			return false;
		} 
		return true;
	}

	private void storeSmsQueueHistory(CustomSmsQueueVO smsQueue, boolean sendOk) {
		/**************************************/
		// 문자 이력에 발송 내역 저장
		/**************************************/
		CustomSmsQueueHistoryVO smsHistory = new CustomSmsQueueHistoryVO();
		smsHistory.setSmsSeq(smsQueue.getSmsSeq());
		smsHistory.setSmsShortSeq(smsQueue.getSmsShortSeq());
		smsHistory.setTemplateId(smsQueue.getTemplateId());
		smsHistory.setSenderName(smsQueue.getSenderName());
		smsHistory.setSenderNumber(smsQueue.getSenderNumber());		
		smsHistory.setReceiverId(smsQueue.getReceiverId());
		smsHistory.setReceiverName(smsQueue.getReceiverName());
		smsHistory.setReceiverNumber(smsQueue.getReceiverNumber());
		smsHistory.setReceiverFlg(smsQueue.getReceiverFlg());
		smsHistory.setMessage(smsQueue.getMessage());
		smsHistory.setRetryCount(smsQueue.getRetryCount());
		smsHistory.setResultFlg(sendOk ? "Y":"N");
		sqlSession.insert(insertSmsHistory, smsHistory);
	}	
	
	private void deleteSmsQueue(CustomSmsQueueVO smsQueue) {
		sqlSession.delete(deleteSmsQueue, smsQueue);
	}
	
	private void updateSmsQueue(CustomSmsQueueVO smsQueue) {
		sqlSession.update(updateSmsQueue, smsQueue);
	}
}
