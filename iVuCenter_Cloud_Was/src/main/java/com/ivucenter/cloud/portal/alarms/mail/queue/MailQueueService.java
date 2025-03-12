package com.ivucenter.cloud.portal.alarms.mail.queue;

import java.util.LinkedList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;
import com.ivucenter.cloud.api.openstack.connector.OpenStackRestConnector;

@Service
public class MailQueueService{

    private static final Logger logger = LoggerFactory.getLogger(MailQueueService.class);

	@Autowired
	private MailQueueDAO dao;

	public String list(CustomMailQueueVO req) {
    	List<CustomMailQueueVO> lists = dao.list(req);
    	int recordsTotal = lists.size();
    	int recordsFiltered = recordsTotal;

		List<CustomMailQueueVO> list = new LinkedList<CustomMailQueueVO>();
		for(CustomMailQueueVO vo : lists){
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

	public CustomMailQueueVO detail(String mailSeq) {
		return VoToDec(dao.detail(mailSeq));
	}

	public CustomMailQueueVO templateviewDetail(CustomMailQueueVO req) {
		return dao.templateviewDetail(req);
	}

	public String insert(CustomMailQueueVO req) {
		return dao.insert(VoToEnc(req))+"";
	}

	public String delete(CustomMailQueueVO req) {
		return dao.delete(req)+"";
	}

	public CustomMailQueueVO VoToDec(CustomMailQueueVO vo){
		if(vo != null){
			vo.setSenderName(vo.getSenderNameDec());
			vo.setSenderMail(vo.getSenderMailDec());
			vo.setReceiverId(vo.getReceiverIdDec());
			vo.setReceiverName(vo.getReceiverNameDec());
			vo.setReceiverMail(vo.getReceiverMailDec());
		}
		return vo;
	}
	public CustomMailQueueVO VoToEnc(CustomMailQueueVO vo){
		if(vo != null){
			vo.setSenderName(vo.getSenderNameEnc());
			vo.setSenderMail(vo.getSenderMailEnc());
			vo.setReceiverId(vo.getReceiverIdEnc());
			vo.setReceiverName(vo.getReceiverNameEnc());
			vo.setReceiverMail(vo.getReceiverMailEnc());
		}
		return vo;
	}
}
