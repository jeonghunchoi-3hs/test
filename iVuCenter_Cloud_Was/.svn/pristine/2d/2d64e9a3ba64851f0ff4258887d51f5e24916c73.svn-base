package com.ivucenter.cloud.portal.alarms.mail.history;

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

@Service
public class MailQueueHistoryService{

    private static final Logger logger = LoggerFactory.getLogger(MailQueueHistoryService.class);

	@Autowired
	private MailQueueHistoryDAO dao;

	public String list(CustomMailQueueHistoryVO req) {
    	if(req.getSearchKind().equals("senderName") && req.getKeyword() != ""){ req.setKeyword(req.getSenderNameEnc()); }
    	if(req.getSearchKind().equals("senderMail") && req.getKeyword() != ""){ req.setKeyword(req.getSenderMailEnc()); }
    	if(req.getSearchKind().equals("receiverId") && req.getKeyword() != ""){ req.setKeyword(req.getReceiverIdEnc()); }
    	if(req.getSearchKind().equals("receiverName") && req.getKeyword() != ""){ req.setKeyword(req.getReceiverNameEnc()); }
    	if(req.getSearchKind().equals("receiverMail") && req.getKeyword() != ""){ req.setKeyword(req.getReceiverMailEnc()); }

    	List<CustomMailQueueHistoryVO> lists = dao.list(req);
    	int recordsTotal = dao.listTot(req).size();
    	int recordsFiltered = recordsTotal;

    	List<CustomMailQueueHistoryVO> list = new LinkedList<CustomMailQueueHistoryVO>();
		for(CustomMailQueueHistoryVO vo : lists){
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

	public CustomMailQueueHistoryVO detail(CustomMailQueueHistoryVO req) {
		return VoToDec(dao.detail(req));
	}

	public String insert(CustomMailQueueHistoryVO req) {

		if( StringUtils.isNotEmpty(req.getMailSeq()) ){
			return dao.update(VoToEnc(req))+"";
		}else{
			return dao.insert(VoToEnc(req))+"";
		}
	}

	public String delete(CustomMailQueueHistoryVO req) {
		return dao.delete(req)+"";
	}

	public CustomMailQueueHistoryVO VoToDec(CustomMailQueueHistoryVO vo){
		if(vo != null){
			vo.setSenderName(vo.getSenderNameDec());
			vo.setSenderMail(vo.getSenderMailDec());
			vo.setReceiverId(vo.getReceiverIdDec());
			vo.setReceiverName(vo.getReceiverNameDec());
			vo.setReceiverMail(vo.getReceiverMailDec());
		}
		return vo;
	}
	public CustomMailQueueHistoryVO VoToEnc(CustomMailQueueHistoryVO vo){
		if(vo != null){
			vo.setSenderName(vo.getSenderNameEnc());
			vo.setSenderMail(vo.getSenderMailEnc());
			vo.setReceiverId(vo.getReceiverIdEnc());
			vo.setReceiverName(vo.getReceiverNameEnc());
			vo.setReceiverMail(vo.getReceiverMailEnc());
		}
		return vo;
	}

	public List<CustomMailQueueHistoryVO> excel(CustomMailQueueHistoryVO req) {
		return dao.listTot(req);
	}

}
