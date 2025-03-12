package com.ivucenter.cloud.portal.alarms.sms.queue;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.security.NoSuchAlgorithmException;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.lang.RandomStringUtils;
import org.apache.commons.lang.time.DateFormatUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;
import com.ivucenter.cloud.portal.cmm.user.CmmUserDAO;
import com.ivucenter.cloud.portal.cmm.user.CustomCmmUserVO;
import com.ivucenter.cloud.portal.util.AES256Util;
import com.ivucenter.cloud.portal.util.CodeUtil;

@Service
public class SmsQueueService{

    private static final Logger logger = LoggerFactory.getLogger(SmsQueueService.class);

	@Autowired
	private SmsQueueDAO dao;

	@Autowired
	private CmmUserDAO cmmUserDAO;

	public String list(CustomSmsQueueVO req) {

    	List<CustomSmsQueueVO> lists = dao.list(req);
	    int recordsTotal = lists.size();
	    int recordsFiltered = recordsTotal;

		List<CustomSmsQueueVO> list = new LinkedList<CustomSmsQueueVO>();
		for(CustomSmsQueueVO vo : lists){
			list.add(VoToDec(vo));
		}

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

	public CustomSmsQueueVO VoToDec(CustomSmsQueueVO vo){
		if(vo != null){
			vo.setSenderName(vo.getSenderNameDec());
			vo.setSenderNumber(vo.getSenderNumberDec());
			vo.setReceiverId(vo.getReceiverIdDec());
			vo.setReceiverName(vo.getReceiverNameDec());
			vo.setReceiverNumber(vo.getReceiverNumberDec());
		}
		return vo;
	}

	public CustomSmsQueueVO VoToEnc(CustomSmsQueueVO vo){
		if(vo != null){
			vo.setSenderName(vo.getSenderNameEnc());
			vo.setSenderNumber(vo.getSenderNumberEnc());
			vo.setReceiverId(vo.getReceiverIdEnc());
			vo.setReceiverName(vo.getReceiverNameEnc());
			vo.setReceiverNumber(vo.getReceiverNumberEnc());
		}
		return vo;
	}

	public CustomSmsQueueVO detail(CustomSmsQueueVO req) {
		return VoToDec(dao.detail(req));
	}

	public String insert(Map<String, String> params) throws UnsupportedEncodingException, NoSuchAlgorithmException, GeneralSecurityException {
		int iRet = 0;
		AES256Util aes = new AES256Util(CodeUtil.KEY_SPEC);

		CustomSmsQueueVO req = new CustomSmsQueueVO();
		req.setSenderName(aes.encrypt(params.get("senderName")));
		req.setSenderNumber(aes.encrypt(params.get("senderNumber")));
		req.setMessage(params.get("message"));
		req.setRegUserId(params.get("regUserId"));

		for(int i=0;i< Integer.parseInt(params.get("receiverNumberListSize"));i++){
			// 화면에서 gbn과 관련없이 userId or managerId를 전달 받음 //
			//사용자
//			if(params.get("receiverNumberList["+i+"][gbn]").equals("1")){
				String gbn = params.get("receiverNumberList["+i+"][gbn]");
				CustomCmmUserVO vo = new CustomCmmUserVO();
				vo.setUserId(params.get("receiverNumberList["+i+"][id]"));
				vo = cmmUserDAO.detail(vo);
				req.setSmsSeq(DateFormatUtils.format(new Date(), "yyyyMMddHHmm_")+UUID.randomUUID().toString());
				req.setSmsShortSeq(RandomStringUtils.randomNumeric(15));
				req.setReceiverId(aes.encrypt(vo.getUserId()));
				req.setReceiverName(aes.encrypt(vo.getUserName()));
				req.setReceiverNumber(vo.getUserPhone());

				if(gbn.equals("1")) {
					req.setReceiverFlg("U");
				} else if(gbn.equals("2")) {
					req.setReceiverFlg("C");
				} else if(gbn.equals("3")) {
					req.setReceiverFlg("P");
				}

				iRet += dao.insert(req);
//			}
//			//고객사
//			else if(params.get("receiverNumberList["+i+"][gbn]").equals("2")){
//				CustomCmmUserVO param = new CustomCmmUserVO();
//				param.setCustomerId(params.get("receiverNumberList["+i+"][id]"));
//				List<CustomCmmUserVO> list = cmmUserDAO.listByCustomer(param);
//				req.setReceiverFlg("C");
//				for(CustomCmmUserVO vo : list){
//					req.setSmsSeq(DateFormatUtils.format(new Date(), "yyyyMMddHHmm_")+UUID.randomUUID().toString());
//					req.setReceiverId(aes.encrypt(vo.getUserId()));
//					req.setReceiverName(aes.encrypt(vo.getUserName()));
//					req.setReceiverNumber(vo.getUserPhone());
//					iRet += dao.insert(req);
//				}
//			}
//			//프로젝트
//			else if(params.get("receiverNumberList["+i+"][gbn]").equals("3")){
//				CustomCmmUserVO vo = new CustomCmmUserVO();
//				vo.setUserId(params.get("receiverNumberList["+i+"][id]"));
//				vo = cmmUserDAO.detail(vo);
//				req.setSmsSeq(DateFormatUtils.format(new Date(), "yyyyMMddHHmm_")+UUID.randomUUID().toString());
//				req.setReceiverId(aes.encrypt(vo.getUserId()));
//				req.setReceiverName(aes.encrypt(vo.getUserName()));
//				req.setReceiverNumber(vo.getUserPhone());
//				req.setReceiverFlg("P");
//				iRet += dao.insert(req);
//			}
		}
		return iRet+"";
	}

	//사번 비밀번호 발송용
	public String insertSmsQueue(CustomSmsQueueVO req) {
		return dao.insert(VoToEnc(req))+"";
	}

	public String delete(CustomSmsQueueVO req) {
		return dao.delete(req)+"";
	}

	public int insertQueue(CustomSmsQueueVO req) {
		return dao.insert(VoToEnc(req));
	}

}
