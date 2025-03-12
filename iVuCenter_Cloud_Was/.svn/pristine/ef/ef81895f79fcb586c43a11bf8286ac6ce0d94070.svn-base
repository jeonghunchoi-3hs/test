package com.ivucenter.cloud.batch.sendKepco;

import java.io.UnsupportedEncodingException;
import java.nio.ByteBuffer;

import org.apache.commons.collections.BufferOverflowException;

import com.ivucenter.cloud.entity.WithKepcoVO;

import lombok.NoArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@NoArgsConstructor
public class SENDKEPCO_INFO {
	
	// output buffer
	private ByteBuffer sendBuf;
	
	// packet structure
	private String padding = "\0";
	private Integer[] padSize = { 1, 8, 5, 15, 20, 14, 20, 8, 255, 255, 1};
	private String[] packet = {
			"",		    // 0 결재구분 (대기/결재)
			"",			// 1 결재자 사번 테스트 : 0000
			"",			// 2 연계시스템 아이디
			"",			// 3 결재문서 고유키
			"",			// 4 결재타입(시스템이름)
			"",			// 5 결재문서도착/결재 일시
			"",			// 6 문서 최초 작성자 이름
			"",			// 7 문서 최초 작성자 사번
			"",			// 8 문서 제목
			"",			// 9 결재시행 할 url
			""			// 10 결재진행상태
	};

	// constructors
	public SENDKEPCO_INFO(WithKepcoVO item) {
		
		this.sendBuf = ByteBuffer.allocate(1024);
		//this.sendBuf.order(ByteOrder.LITTLE_ENDIAN);
		packet[0] = item.getSignType(); 	// not null
		packet[1] = item.getPayerId(); 		// not null
		packet[2] = "10135"; 				// not null 
		packet[3] = item.getApprovalNo(); 	// not null
		packet[4] = item.getSystemName(); 	// not null
		packet[5] = item.getRegDatetime(); 	// not null
		packet[6] = item.getWriterName(); 	// not null
		packet[7] = item.getWriterId(); 	// not null
		
		if(item.getTitle() != null){
			packet[8] = item.getTitle(); 
		}
		if(item.getContentUrl() != null) {
			packet[9] = item.getContentUrl();
		}
		if(item.getStatus() != null) {
			packet[10] = item.getStatus();
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
//				log.debug(packet[i]+" : "+padSize[i]+" : "+size);
				String debugMsg = packet[i];
				for(int j=0; j < padSize[i] - size + 1; j++) {
					debugMsg += "0";
					sendBuf.put(padding.getBytes());
				}
//				log.debug("packet msg : " + debugMsg);
			}
		} catch (UnsupportedEncodingException e) {
			log.error(e.getMessage());
		} catch (BufferOverflowException e) {
			log.error(e.getMessage());
		}
	}
}
