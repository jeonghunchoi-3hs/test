package com.ivucenter.cloud.entity;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class WithKepcoVO extends DataTableVO {
	private String alarmSeq;	// 
	private String approvalNo;  // req_project_seq, order_no 정보
	private String signType;	// S: 결재 시작/중간 , E: 결재 종료/반송  
	private String status;		// 0; 진행 , 1: 완료, 9: 회수 
	private String payerId;		// 결재자  사번
	private String writerId;	// 기안자 사번
	private String writerName;	// 기안자 이름
	private String systemName;	// 시스템 이름 (E-CLOUD)
	private String title;		// 문서제목 (sms template 제목 사용)
	private String contentUrl;	// 클라우드 시스템 URL (사용자/관리자 구분 필요)	
	private String regDatetime;	// 등록 시간
	private String rtnCode;		// 수신결과   0000: 성공,  
								// 1001 : 데이터 형식 오류, 1002 : 서버간 전송시간 초과
								// 1100 : DB 접속 오류,   1101 : DB Query 오류
								// 1200 : 시스템 서비스 오류
								// 404 : 접속장애, 405 : 데이터오류 	
	private String rtnDatetime; // 수신시간 
	private int retryCount;
	private String step;
	
	private String redirectUrl;
}
