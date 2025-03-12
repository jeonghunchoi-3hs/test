package com.ivucenter.cloud.portal.alarms.withnh;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.apache.commons.lang.time.DateFormatUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ivucenter.cloud.portal.alarms.template.AlarmsTemplateService;
import com.ivucenter.cloud.portal.cmm.user.CustomCmmUserVO;
import com.ivucenter.cloud.portal.util.CodeUtil;
//import com.nonghyupit.with.sender.NhWithApi;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class NhwithSendService {

	@Autowired
	private NhwithService nhwithService;

	@Autowired
	private AlarmsTemplateService alarmsTemplateService;
	
	public void alarms(String gbn, CustomCmmUserVO req, String keyword1, String keyword2) {
		final String templateId = "WITH00" + gbn;
		
		CustomNhwithVO nhwithVO = getTemplate(templateId);		
		nhwithVO.setContent(this.getContent(nhwithVO.getContent(), gbn, keyword1, keyword2));
		
//		sendNew(req, nhwithVO);
	}
	
	private CustomNhwithVO getTemplate(String templateId){
		CustomNhwithVO nhwithVO = new CustomNhwithVO();
		nhwithVO.setTemplateId(templateId);
		return nhwithService.templateviewDetail(nhwithVO);
	}
	
	private String getContent(String content, String gbn, String keyword1, String keyword2) {
		int iGbn = Integer.parseInt(gbn);
		switch(iGbn) {
			case 20: case 21:
				return alarmsTemplateService.project(content, keyword1);
			case 30: case 32: case 33:
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

//	private void sendNew(CustomCmmUserVO req, CustomNhwithVO nhwithVO) {
//		new Thread(new Runnable() {
//
//			@Override
//			public void run() {
//				List<String> receivers = new ArrayList<String>();
//				receivers.add(req.getUserId()); //수신자 사번(ID)
//				NhWithApi nhwith = new NhWithApi("nhwith.properties");
//				nhwith.setSenderId(CodeUtil.NHWITHSENDERID); // CLOUDADMIN
//				nhwith.setSenderName(CodeUtil.NHWITHSENDERNAME); //발신자 아이뷰센터 클라우드관리자
//				nhwith.setReceivers(receivers);
//				String sTitle = DateFormatUtils.format(new Date(), "yyyyMMddHHmmss ") + nhwithVO.getTitle();
//				nhwith.setTitle(sTitle); // 제목
//				nhwith.setContent(nhwithVO.getContent());
//
//				boolean result = nhwith.send(); // 방화벽오픈후 주석 제거
//				
//				nhwithVO.setNhwithSeq(DateFormatUtils.format(new Date(), "yyyyMMddHHmm_")+UUID.randomUUID().toString());
//				nhwithVO.setTitle(sTitle);
//				nhwithVO.setSenderName(CodeUtil.NHWITHSENDERNAME);
//				nhwithVO.setSenderId(CodeUtil.NHWITHSENDERID);
//				nhwithVO.setResultFlg(result?"Y":"N");
//				nhwithVO.setReceiverFlg("U");
//				nhwithVO.setReceiverId(req.getUserId());
//				nhwithVO.setReceiverName(req.getUserName());
//				
//				nhwithService.nhwithTemplateHistoryInsert(nhwithVO);
//			}
//		}).start();
//	}	
	
/* 20191107 주석처리
	public void setNhwithsend(CustomNhwithVO setnhwithVO) {
		new Thread(new Runnable() {
			@Override
			public void run() {
				// 상품신청 nhwith 발송 및 history 테이블 입력 2017.08.28 이윤준
				List<String> receivers = new ArrayList<String>();
				receivers.add(setnhwithVO.getReceiverId()); //수신자 사번(ID)
//				receivers.add("P1210052"); // 수신자 사번(ID)

				SimpleDateFormat nhwithdateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
				Date nhwithdate = new Date();
				NhWithApi nhwith = new NhWithApi("nhwith.properties");								
				nhwith.setSenderId(CodeUtil.NHWITHSENDERID); // 발신자 CLOUDADMIN
				nhwith.setSenderName(CodeUtil.NHWITHSENDERNAME); //발신자 아이뷰센터 클라우드관리자
//				nhwith.setSourceInfo("CLOUD"); // 발송지:PMS "NHINFO.PMS.NOTICE"
//				nhwith.setSourcePassword("aaaabbbb");
				nhwith.setReceivers(receivers);

				CustomNhwithVO nhwithVO = new CustomNhwithVO();
				nhwithVO.setTemplateId(setnhwithVO.getTemplateId());

				CustomNhwithVO templateviewDetail = nhwithService.templateviewDetail(nhwithVO);
				UUID nhwithSeq = UUID.randomUUID();

				nhwithVO.setNhwithSeq(nhwithSeq.toString());
				nhwithVO.setTitle(nhwithdateFormat.format(nhwithdate) + templateviewDetail.getTitle());
				nhwithVO.setContent(templateviewDetail.getContent());

				String nhwithContent = nhwithService.orderContent(nhwithVO, setnhwithVO.getOrderNo());

				nhwith.setTitle(nhwithdateFormat.format(nhwithdate) + templateviewDetail.getTitle()); // 제목

				nhwith.setContent(nhwithContent);

//				nhwith.setNhwithUrl("http://10.220.210.65:6122/api/message");
				log.debug("nhwith.getNhwithUrl() : " + nhwith.getNhwithUrl());
				boolean result = nhwith.send(); // 방화벽오픈후 주석 제거

				log.debug("result : " + result);

				nhwithVO.setContent(nhwithContent);
				nhwithVO.setSenderName(CodeUtil.NHWITHSENDERNAME);
				nhwithVO.setSenderId(CodeUtil.NHWITHSENDERID);
				nhwithVO.setReceiverId(setnhwithVO.getReceiverId());
				nhwithVO.setReceiverName(setnhwithVO.getReceiverName());
				if (result) {
					nhwithVO.setResultFlg("Y");
				} else {
					nhwithVO.setResultFlg("N");
				}
				nhwithVO.setReceiverFlg("U");
				nhwithService.nhwithTemplateHistoryInsert(nhwithVO);
			}
		}).start();

	}

	public void setNhwithsend2(CustomNhwithVO setnhwithVO) {
		new Thread(new Runnable() {

			@Override
			public void run() {
				// 프로젝트신청 nhwith 발송 및 history 테이블 입력 2017.08.28 이윤준
				List<String> receivers = new ArrayList<String>();
				receivers.add(setnhwithVO.getReceiverId()); //수신자 사번(ID)
//				receivers.add("P1210052"); // 수신자 사번(ID)

				SimpleDateFormat nhwithdateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
				Date nhwithdate = new Date();
				NhWithApi nhwith = new NhWithApi("nhwith.properties");
				// nhwith.setSenderId(CodeUtil.NHWITHSENDERID); //발신자
				// NHWITHSENDERID
				nhwith.setSenderId(CodeUtil.NHWITHSENDERID); // CLOUDADMIN
				nhwith.setSenderName(CodeUtil.NHWITHSENDERNAME); //발신자 아이뷰센터 클라우드관리자
//				nhwith.setSourceInfo("CLOUD"); // 발송지:PMS "NHINFO.PMS.NOTICE"
//				nhwith.setSourcePassword("aaaabbbb");

				nhwith.setReceivers(receivers);

				CustomNhwithVO nhwithVO = new CustomNhwithVO();
				nhwithVO.setTemplateId(setnhwithVO.getTemplateId());

				CustomNhwithVO templateviewDetail = nhwithService.templateviewDetail(nhwithVO);
				UUID nhwithSeq = UUID.randomUUID();

				nhwithVO.setNhwithSeq(nhwithSeq.toString());
				nhwithVO.setTitle(nhwithdateFormat.format(nhwithdate) + templateviewDetail.getTitle());
				nhwithVO.setContent(templateviewDetail.getContent());

				String nhwithContent = nhwithService.projectContent(nhwithVO, setnhwithVO.getOrderNo());

				nhwith.setTitle(nhwithdateFormat.format(nhwithdate) + templateviewDetail.getTitle()); // 제목

				nhwith.setContent(nhwithContent);

//				nhwith.setNhwithUrl("http://10.220.210.65:6122/api/message");
				log.debug("nhwith.getNhwithUrl() : " + nhwith.getNhwithUrl());
				// boolean result = nhwith.send(); // 방화벽오픈후 주석 제거
				boolean result = false;
				log.debug("result : " + result);

				nhwithVO.setContent(nhwithContent);
				nhwithVO.setSenderName(CodeUtil.SENDERNAME);
				nhwithVO.setSenderId(CodeUtil.NHWITHSENDERID);
				nhwithVO.setReceiverId(setnhwithVO.getReceiverId());
				nhwithVO.setReceiverName(setnhwithVO.getReceiverName());
				if (result) {
					nhwithVO.setResultFlg("Y");
				} else {
					nhwithVO.setResultFlg("N");
				}
				// nhwithVO.setResultDatetime("");
				nhwithVO.setReceiverFlg("U");

				nhwithService.nhwithTemplateHistoryInsert(nhwithVO);
			}
		}).start();

	}

	// 정산승인 push
	public void setNhwithsend3(CustomNhwithVO setnhwithVO) {
		new Thread(new Runnable() {
			
			@Override
			public void run() {
				log.debug("======setNhwithsend3=======");
				
				List<String> receivers = new ArrayList<String>();
				receivers.add(setnhwithVO.getReceiverId()); //수신자 사번(ID)

				SimpleDateFormat nhwithdateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
				Date nhwithdate = new Date();
				NhWithApi nhwith = new NhWithApi("nhwith.properties");
				nhwith.setSenderId(CodeUtil.NHWITHSENDERID); // CLOUDADMIN
				nhwith.setSenderName(CodeUtil.NHWITHSENDERNAME); //발신자 아이뷰센터 클라우드관리자
				nhwith.setReceivers(receivers);

				CustomNhwithVO nhwithVO = new CustomNhwithVO();
				nhwithVO.setTemplateId(setnhwithVO.getTemplateId());

				CustomNhwithVO templateviewDetail = nhwithService.templateviewDetail(nhwithVO);
				UUID nhwithSeq = UUID.randomUUID();

				nhwithVO.setNhwithSeq(nhwithSeq.toString());
				nhwithVO.setTitle(nhwithdateFormat.format(nhwithdate) + templateviewDetail.getTitle());
				nhwithVO.setContent(templateviewDetail.getContent());

				String nhwithContent = nhwithService.approvalContent(nhwithVO, setnhwithVO.getBillYyyymm());

				nhwith.setTitle(nhwithdateFormat.format(nhwithdate) + templateviewDetail.getTitle()); // 제목

				nhwith.setContent(nhwithContent);

//				nhwith.setNhwithUrl("http://10.220.210.65:6122/api/message");
				log.debug("nhwith.getNhwithUrl() : " + nhwith.getNhwithUrl());
				boolean result = nhwith.send(); // 방화벽오픈후 주석 제거
				// boolean result = false; // 방화벽오픈후 주석 제거

				log.debug("result : " + result);

				nhwithVO.setContent(nhwithContent);
				nhwithVO.setSenderName(CodeUtil.SENDERNAME);
				nhwithVO.setSenderId(CodeUtil.NHWITHSENDERID);
				nhwithVO.setReceiverId(setnhwithVO.getReceiverId());
				nhwithVO.setReceiverName(setnhwithVO.getReceiverName());
				if (result) {
					nhwithVO.setResultFlg("Y");
				} else {
					nhwithVO.setResultFlg("N");
				}
				// nhwithVO.setResultDatetime("");
				nhwithVO.setReceiverFlg("U");

				nhwithService.nhwithTemplateHistoryInsert(nhwithVO);

			}
		}).start();
	}

	// 사번 비밀번호 발송용
	public void setNhwithsend4(CustomNhwithVO setnhwithVO) {
		new Thread(new Runnable() {

			@Override
			public void run() {
				List<String> receivers = new ArrayList<String>();
				receivers.add(setnhwithVO.getReceiverId()); //수신자 사번(ID)
				
				NhWithApi nhwith = new NhWithApi("nhwith.properties");
				
				nhwith.setSenderId(CodeUtil.NHWITHSENDERID); // 발신자 
				nhwith.setSenderName(CodeUtil.NHWITHSENDERNAME);	 // 발신자 
//				nhwith.setSourceInfo("CLOUD"); // 발송지:PMS "NHINFO.PMS.NOTICE"
//				nhwith.setSourcePassword("a6ac4907e520edac0374cad52f5873cbdf5aa3ca458223f5797fa4fe4ade721a");

				nhwith.setReceivers(receivers);
				
				CustomNhwithVO nhwithVO = new CustomNhwithVO();
				nhwithVO.setTemplateId(setnhwithVO.getTemplateId());
				nhwithVO.setTempPw(setnhwithVO.getTempPw());
				nhwithVO.setSearchKind(setnhwithVO.getSearchKind());
				nhwithVO.setReceiverId(setnhwithVO.getReceiverId());

				CustomNhwithVO templateviewDetail = nhwithService.templateviewDetail(nhwithVO);
				UUID nhwithSeq = UUID.randomUUID();

				nhwithVO.setNhwithSeq(nhwithSeq.toString());
//				nhwithVO.setTitle(nhwithdateFormat.format(nhwithdate) + templateviewDetail.getTitle());
				nhwithVO.setTitle(templateviewDetail.getTitle());
				nhwithVO.setContent(templateviewDetail.getContent());

				String nhwithContent = nhwithService.searchContent(nhwithVO);

				nhwith.setTitle(templateviewDetail.getTitle()); // 제목

				nhwith.setContent(nhwithContent);

//				nhwith.setNhwithUrl("http://10.220.141.75:8090/api/message");
				log.debug("nhwith.getNhwithUrl() : " + nhwith.getNhwithUrl());
				boolean result = nhwith.send(); // 방화벽오픈후 주석 제거
				
				log.debug("result : " + result);

				nhwithVO.setContent(nhwithContent);
				nhwithVO.setSenderName(CodeUtil.NHWITHSENDERNAME);
				nhwithVO.setSenderId(CodeUtil.NHWITHSENDERID);
				nhwithVO.setReceiverId(setnhwithVO.getReceiverId());
				nhwithVO.setReceiverName(setnhwithVO.getReceiverName());
				if (result) {
					nhwithVO.setResultFlg("Y");
				} else {
					nhwithVO.setResultFlg("N");
				}
				// nhwithVO.setResultDatetime("");
				nhwithVO.setReceiverFlg("U");

				nhwithService.nhwithTemplateHistoryInsert(nhwithVO);

			}
		}).start();
	}
	
	// 1차 승인 후 작업자 통지
	public void setNhwithsend5(CustomNhwithVO setnhwithVO) {
		new Thread(new Runnable() {
			
			@Override
			public void run() {
				log.debug("======setNhwithsend5=======");
				
				List<String> receivers = new ArrayList<String>();
				receivers.add(setnhwithVO.getReceiverId()); //수신자 사번(ID)

				SimpleDateFormat nhwithdateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
				Date nhwithdate = new Date();
				NhWithApi nhwith = new NhWithApi("nhwith.properties");
				nhwith.setSenderId(CodeUtil.NHWITHSENDERID); // CLOUDADMIN
				nhwith.setSenderName(CodeUtil.NHWITHSENDERNAME); //발신자 아이뷰센터 클라우드관리자
				nhwith.setReceivers(receivers);

				CustomNhwithVO nhwithVO = new CustomNhwithVO();
				nhwithVO.setTemplateId(setnhwithVO.getTemplateId());

				CustomNhwithVO templateviewDetail = nhwithService.templateviewDetail(nhwithVO);
				UUID nhwithSeq = UUID.randomUUID();

				nhwithVO.setNhwithSeq(nhwithSeq.toString());
				nhwithVO.setTitle(nhwithdateFormat.format(nhwithdate) + templateviewDetail.getTitle());
				nhwithVO.setContent(templateviewDetail.getContent());

				String nhwithContent = nhwithService.workerContent(nhwithVO, setnhwithVO.getTempStr());

				nhwith.setTitle(nhwithdateFormat.format(nhwithdate) + templateviewDetail.getTitle()); // 제목

				nhwith.setContent(nhwithContent);

//					nhwith.setNhwithUrl("http://10.220.210.65:6122/api/message");
				log.debug("nhwith.getNhwithUrl() : " + nhwith.getNhwithUrl());
				boolean result = nhwith.send(); // 방화벽오픈후 주석 제거
				// boolean result = false; // 방화벽오픈후 주석 제거

				log.debug("result : " + result);

				nhwithVO.setContent(nhwithContent);
				nhwithVO.setSenderName(CodeUtil.SENDERNAME);
				nhwithVO.setSenderId(CodeUtil.NHWITHSENDERID);
				nhwithVO.setReceiverId(setnhwithVO.getReceiverId());
				nhwithVO.setReceiverName(setnhwithVO.getReceiverName());
				if (result) {
					nhwithVO.setResultFlg("Y");
				} else {
					nhwithVO.setResultFlg("N");
				}
				// nhwithVO.setResultDatetime("");
				nhwithVO.setReceiverFlg("U");

				nhwithService.nhwithTemplateHistoryInsert(nhwithVO);

			}
		}).start();
	}
*/  // 20191107 주석처리 (한전)	
}
