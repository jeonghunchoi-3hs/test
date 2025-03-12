package com.ivucenter.cloud.batch.sendsms;

import java.io.UnsupportedEncodingException;
import java.nio.ByteBuffer;

import org.apache.commons.collections.BufferOverflowException;
import org.apache.commons.lang.RandomStringUtils;

import com.ivucenter.cloud.entity.SmsQueueVO;

import lombok.NoArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@NoArgsConstructor
public class SMS_INFO {
	
	// output buffer
	private ByteBuffer sendBuf; 
	
	// packet structure
	private String padding = "\0";
	private Integer[] padSize = { 5, 4, 15, 15, 15, 80, 8, 5};
	private String[] packet = {
			"E741D",		// 0 연계 코드 kepco
			"E741",			// 1 비밀번호 kepco
			"",				// 2 고유키
			"",				// 3 수신자 번호 ('-' 제외)
			"0613455366",	// 4 발신자 번호 ('-' 제외)
			"",				// 5 메시지 (80byte 이내)
			"",				// 6 사번 (xor11111)
			"0"				// 7 참조자수 (00000~99999)
	};
	
	// constructors
	public SMS_INFO(SmsQueueVO item) {		
		this.sendBuf = ByteBuffer.allocate(155);
		//this.sendBuf.order(ByteOrder.LITTLE_ENDIAN);
		if(item.getSmsShortSeq() == null) {
			item.setSmsShortSeq(RandomStringUtils.randomNumeric(15));
		}
		packet[2] = item.getSmsShortSeq().substring(0, 15).trim();
		packet[3] = item.getReceiverNumber().replace("-", "").trim();
		if( (item.getSenderNumber() != null) && 
		    (! item.getSenderNumber().isEmpty()) ) {
			packet[4] = item.getSenderNumber().replace("-", "").trim();
		}		
		packet[5] = item.getMessage().trim();
		
		if(item.getReceiverId().length() < 9) {
			packet[6] = item.getReceiverId().trim();
		}else {
			packet[6] = item.getReceiverId().substring(0, 8).trim();
		}
		
	}
	
	// output function
	public byte [] getInfo() {
		generate();
		return sendBuf.array();
	}

	// internal functions
	private void generate() {
		try {
			for(int i =0; i < packet.length; i++) {
			
				byte[] msg = packet[i].getBytes("euc-kr");
				int size = msg.length;				
				sendBuf.put(msg);
				
				log.debug(packet[i]+" : "+padSize[i]+" : "+size);
				String debugMsg = packet[i];
				for(int j=0; j < padSize[i] - size + 1; j++) {
					debugMsg += "0";
					sendBuf.put(padding.getBytes());
				}
				log.debug("packet msg : " + debugMsg);
			}
		} catch (UnsupportedEncodingException e) {
			log.error(e.getMessage());
		} catch (BufferOverflowException e) {
			log.error(e.getMessage());
		}
	}
}
