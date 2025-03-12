package com.ivucenter.cloud.portal.alarms.sms.history;

import java.util.LinkedList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class SmsQueueHistoryService{

    private static final Logger logger = LoggerFactory.getLogger(SmsQueueHistoryService.class);

	@Autowired
	private SmsQueueHistoryDAO dao;

	public String list(CustomSmsQueueHistoryVO req) {
//		if(req.getSearchKind().equals("senderName") && req.getKeyword() != ""){ req.setKeyword(req.getSenderNameEnc()); }
//		if(req.getSearchKind().equals("senderNumber") && req.getKeyword() != ""){ req.setKeyword(req.getSenderNumberEnc()); }
//		if(req.getSearchKind().equals("receiverId") && req.getKeyword() != ""){ req.setKeyword(req.getReceiverIdEnc()); }
//		if(req.getSearchKind().equals("receiverName") && req.getKeyword() != ""){ req.setKeyword(req.getReceiverNameEnc()); }
//		if(req.getSearchKind().equals("r1eceiverNumber") && req.getKeyword() != ""){ req.setKeyword(req.getReceiverNumberEnc()); }

		log.debug("req.getKeyword() : " + req.getKeyword());

    	List<CustomSmsQueueHistoryVO> lists = dao.list(req);
	    int recordsTotal = dao.listTot(req).size();
	    int recordsFiltered = recordsTotal;

		List<CustomSmsQueueHistoryVO> list = new LinkedList<CustomSmsQueueHistoryVO>();
		for(CustomSmsQueueHistoryVO vo : lists){
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

	public CustomSmsQueueHistoryVO VoToDec(CustomSmsQueueHistoryVO vo){
		vo.setSenderName(vo.getSenderNameDec());
		vo.setSenderNumber(vo.getSenderNumberDec());
		vo.setReceiverId(vo.getReceiverIdDec());
		vo.setReceiverName(vo.getReceiverNameDec());
		vo.setReceiverNumber(vo.getReceiverNumberDec());
		return vo;
	}

	public CustomSmsQueueHistoryVO VoToEnc(CustomSmsQueueHistoryVO vo){
		vo.setSenderName(vo.getSenderNameEnc());
		vo.setSenderNumber(vo.getSenderNumberEnc());
		vo.setReceiverId(vo.getReceiverIdEnc());
		vo.setReceiverName(vo.getReceiverNameEnc());
		vo.setReceiverNumber(vo.getReceiverNumberEnc());
		return vo;
	}

	public CustomSmsQueueHistoryVO detail(CustomSmsQueueHistoryVO req) {
		return VoToDec(dao.detail(req));
	}

	public String insert(CustomSmsQueueHistoryVO req) {

		if( StringUtils.isNotEmpty(req.getSmsSeq()) ){
			return dao.update(VoToEnc(req))+"";
		}else{
			return dao.insert(VoToEnc(req))+"";
		}
	}

	public String delete(CustomSmsQueueHistoryVO req) {
		return dao.delete(req)+"";
	}

	public List<CustomSmsQueueHistoryVO> excel(CustomSmsQueueHistoryVO req) {
		if(req.getSearchKind().equals("senderName") && req.getKeyword() != ""){ req.setKeyword(req.getSenderNameEnc()); }
		if(req.getSearchKind().equals("senderNumber") && req.getKeyword() != ""){ req.setKeyword(req.getSenderNumberEnc()); }
		if(req.getSearchKind().equals("receiverId") && req.getKeyword() != ""){ req.setKeyword(req.getReceiverIdEnc()); }
		if(req.getSearchKind().equals("receiverName") && req.getKeyword() != ""){ req.setKeyword(req.getReceiverNameEnc()); }
		if(req.getSearchKind().equals("r1eceiverNumber") && req.getKeyword() != ""){ req.setKeyword(req.getReceiverNumberEnc()); }
		return dao.listTot(req);
	}

}
