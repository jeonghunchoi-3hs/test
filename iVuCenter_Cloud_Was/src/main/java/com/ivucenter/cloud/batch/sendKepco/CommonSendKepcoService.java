package com.ivucenter.cloud.batch.sendKepco;

import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.InetSocketAddress;
import java.net.Socket;
import java.net.UnknownHostException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ivucenter.cloud.portal.alarms.withkepco.CustomWithKepcoVO;
import com.ivucenter.cloud.portal.util.CodeUtil;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service("commonSendKepcoService")
public class CommonSendKepcoService {

	private final String deleteSendKepcoQueue = "com.ivucenter.cloud.portal.alarms.withkepco.WithKepcoDAO.WithKepcoQueueDelete";
	private final String insertMailHistory = "com.ivucenter.cloud.portal.alarms.withkepco.WithKepcoDAO.WithKepcoQueueHistoryInsert";
	private final String updateSendKepcoRetry = "com.ivucenter.cloud.portal.alarms.withkepco.WithKepcoDAO.WithkepcoRetryUpdate";
	private final String updateSendKepcoNext = "com.ivucenter.cloud.portal.alarms.withkepco.WithKepcoDAO.WithkepcoNextStepUpdate";
	@Autowired
    private SqlSession sqlSession;
	
	public void sendKepco(List<CustomWithKepcoVO> sendKepcoList) {
		for(CustomWithKepcoVO CustomWithKepcoVO : sendKepcoList) {
			String sendOk;
			boolean checkData = checkData(CustomWithKepcoVO); // NOT NULL 필드에 대한 NULL체크
			
			// 수신결과 0000 : 성공, 1001 : 데이터 형식 오류, 1002 : 서버간 전송시간 초과, 1100 : DB 접속 오류, 1101 : DB Query 오류, 1200 : 시스셈 서비스 오류, 405 : 데이터오류, 404 : 접속장애
			if(checkData == true) {
				sendOk = sendKepco(CustomWithKepcoVO);
				if(sendOk.equals("0000")) {
					deleteSendKepcoQueue(CustomWithKepcoVO); 				// 발송된 알람 삭제
					storeSendKepcoQueueHistory(CustomWithKepcoVO,sendOk); 	// 발송된 알람 이력 저장
				} else {
					if(CustomWithKepcoVO.getRetryCount() < 3 ) {
						updateSendKepcoQueue(CustomWithKepcoVO);
					} else {
						sendOk = "400";                        
						deleteSendKepcoQueue(CustomWithKepcoVO); 				
						storeSendKepcoQueueHistory(CustomWithKepcoVO,sendOk); 
					}
				}
			} else {
				sendOk = "406";
				deleteSendKepcoQueue(CustomWithKepcoVO); 				
				storeSendKepcoQueueHistory(CustomWithKepcoVO,sendOk); 
			}
		}
	}
	
	private String sendKepco(CustomWithKepcoVO item) {
		String line = "404";
		InetSocketAddress isa = new InetSocketAddress(CodeUtil.KEPCO_HOST, CodeUtil.KEPCO_PORT);					
			
		try(Socket socket = new Socket()) {
			socket.setReuseAddress(true);;
			socket.setSoTimeout(10000);
			socket.setSoLinger(true, 0);			
			socket.connect(isa);
	

			try(BufferedOutputStream bout = new BufferedOutputStream(socket.getOutputStream());
			BufferedReader reader = new BufferedReader(new InputStreamReader(socket.getInputStream(),"UTF-8"))) {
			
			SENDKEPCO_INFO info = new SENDKEPCO_INFO(item);
			
			bout.write(info.getInfo());
			bout.flush();
			
			String readerLine;
			while((readerLine = reader.readLine()) != null) {
				line = readerLine;
			}
			}catch (IOException ex) {
				log.error("ERROR: IOException() "+ex.getMessage());
			}
		} catch (UnknownHostException ex) {
			log.error("ERROR: UnknownHostException() " + ex.getMessage() );
		} catch (IOException ex) {
			log.error("ERROR: IOException() "+ex.getMessage());
		}
		return line;
	}
	
	private void storeSendKepcoQueueHistory(CustomWithKepcoVO withKepcoQueue, String sendOk) {
		/**************************************/
		// 문자 이력에 발송 내역 저장
		/**************************************/
		CustomWithKepcoVO withKepcoHistory = new CustomWithKepcoVO();
		withKepcoHistory.setAlarmSeq(withKepcoQueue.getAlarmSeq());
		withKepcoHistory.setStatus(withKepcoQueue.getStatus());
		withKepcoHistory.setSignType(withKepcoQueue.getSignType());
		withKepcoHistory.setPayerId(withKepcoQueue.getPayerId());
		withKepcoHistory.setWriterId(withKepcoQueue.getWriterId());
		withKepcoHistory.setWriterName(withKepcoQueue.getWriterName());		
		withKepcoHistory.setSystemName(withKepcoQueue.getSystemName());
		withKepcoHistory.setTitle(withKepcoQueue.getTitle());
		withKepcoHistory.setContentUrl(withKepcoQueue.getContentUrl());
		withKepcoHistory.setRegDatetime(withKepcoQueue.getRegDatetime());
		withKepcoHistory.setRtnCode(sendOk);
		withKepcoHistory.setStep(withKepcoQueue.getStep());
		withKepcoHistory.setRedirectUrl(withKepcoQueue.getRedirectUrl());
		sqlSession.insert(insertMailHistory, withKepcoHistory);
	}	
	
	private void deleteSendKepcoQueue(CustomWithKepcoVO withKepcoQueue) {
		sqlSession.delete(deleteSendKepcoQueue, withKepcoQueue);
	}
	
	private void updateSendKepcoQueue(CustomWithKepcoVO withKepcoQueue) {
		sqlSession.update(updateSendKepcoRetry, withKepcoQueue);
	}
	private void updateSendKepcoNextStep(CustomWithKepcoVO withKepcoQueue) {
		sqlSession.update(updateSendKepcoNext, withKepcoQueue);
	}
	private boolean checkData(CustomWithKepcoVO withKepcoQueue) {
		System.out.print("check ==> " + checkNull(withKepcoQueue.getWriterName()));
		if(checkNull(withKepcoQueue.getSignType()) == true || checkNull(withKepcoQueue.getPayerId()) == true || checkNull(withKepcoQueue.getAlarmSeq()) == true 
				|| checkNull(withKepcoQueue.getSystemName()) == true || checkNull(withKepcoQueue.getRegDatetime()) == true 
				|| checkNull(withKepcoQueue.getWriterName()) == true || checkNull(withKepcoQueue.getWriterId()) == true) {
			return false;
		} else {
			return true;
		}
	}
	private boolean checkNull(String data) {
		if(data == null || data.trim().isEmpty() || data.equals("(NULL)")) {
			return true;
		} else {
			return false;
		}
		
	}
	
}
