package com.ivucenter.cloud.portal.alarms.withnh;

import java.util.LinkedList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;
import com.ivucenter.cloud.portal.util.AES256Util;
import com.ivucenter.cloud.portal.util.CodeUtil;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class NhwithService {

    private static final Logger logger = LoggerFactory.getLogger(NhwithService.class);

	@Autowired
	private NhwithDAO nhwithDAO;

	public String nhwithTemplatelist(CustomNhwithVO req) {
	    List<CustomNhwithVO> lists = nhwithDAO.nhwithTemplatelist(req);
	    int recordsTotal = nhwithDAO.nhwithTemplatelistTot(req).size();
	    int recordsFiltered = recordsTotal;

		List<CustomNhwithVO> list = new LinkedList<CustomNhwithVO>();
		for(CustomNhwithVO vo : lists){
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

	public CustomNhwithVO templateviewDetail(CustomNhwithVO req) {
		return VoToDec(nhwithDAO.templateviewDetail(VoToEnc(req)));
	}

	public String templateUpdate(CustomNhwithVO req) {
		return nhwithDAO.templateUpdate(VoToEnc(req))+"";
	}

	public String nhwithTemplateHistoryList(CustomNhwithVO req) {
    	if(req.getSearchKind().equals("receiver_name") && req.getKeyword() != ""){ req.setKeyword(req.getReceiverNameEnc()); }

    	List<CustomNhwithVO> lists = nhwithDAO.nhwithTemplateHistoryList(req);

	    int recordsTotal = nhwithDAO.nhwithTemplateHistoryListTot(req).size();
	    int recordsFiltered = recordsTotal;

		List<CustomNhwithVO> list = new LinkedList<CustomNhwithVO>();
		for(CustomNhwithVO vo : lists){
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

	public String nhwithTemplateHistoryInsert(CustomNhwithVO req) {
		return nhwithDAO.nhwithTemplateHistoryInsert(VoToEnc(req))+"";
	}

	public String orderContent(CustomNhwithVO nhwithVO, String orderNo) {
		String nhwithContent = nhwithVO.getContent();
		nhwithContent = nhwithContent.replace("[[주문번호]]", orderNo);

		return nhwithContent;
	}

	public String projectContent(CustomNhwithVO nhwithVO, String projectAlias) {
		String nhwithContent = nhwithVO.getContent();
		nhwithContent = nhwithContent.replace("[[프로젝트명]]", projectAlias);

		return nhwithContent;
	}

	public String approvalContent(CustomNhwithVO nhwithVO, String billYyyymm) {
		String nhwithContent = nhwithVO.getContent();

		String billY = (String) billYyyymm.subSequence(0, 4);
		String billM = (String) billYyyymm.subSequence(4, 6);

		nhwithContent = nhwithContent.replace("[[정산년월]]", billY+"년 "+billM+"월");

		return nhwithContent;
	}

	public String workerContent(CustomNhwithVO nhwithVO, String str) {
		String nhwithContent = nhwithVO.getContent();
		nhwithContent = nhwithContent.replace("[[상품명]]", str);

		return nhwithContent;
	}

	public String searchContent(CustomNhwithVO nhwithVO) {
		String nhwithContent = nhwithVO.getContent();
		log.debug("nhwithVO.getSearchKind() : " + nhwithVO.getSearchKind());
		if(nhwithVO.getSearchKind()=="searchId"){
			nhwithContent = nhwithContent.replace("[[사번]]", decrypt(nhwithVO.getReceiverId()));
			log.debug("사번 템플릿 : " + nhwithContent);
		}else if(nhwithVO.getSearchKind()=="searchPw"){
			nhwithContent = nhwithContent.replace("[[패스워드]]", nhwithVO.getTempPw());
			log.debug("패스워드 템플릿 : " + nhwithContent);
		}

		return nhwithContent;
	}

	public CustomNhwithVO nhwithTemplateHistoryDetail(CustomNhwithVO req) {
		return VoToDec(nhwithDAO.nhwithTemplateHistoryDetail(VoToEnc(req)));
	}

	public CustomNhwithVO VoToDec(CustomNhwithVO vo){
		if(vo != null){
			vo.setSenderName(vo.getSenderNameDec());
			vo.setSenderId(vo.getSenderIdDec());
			vo.setReceiverId(vo.getReceiverIdDec());
			vo.setReceiverName(vo.getReceiverNameDec());
		}
		return vo;
	}
	public CustomNhwithVO VoToEnc(CustomNhwithVO vo){
		if(vo != null){
			vo.setSenderName(vo.getSenderNameEnc());
			vo.setSenderId(vo.getSenderIdEnc());
			vo.setReceiverId(vo.getReceiverIdEnc());
			vo.setReceiverName(vo.getReceiverNameEnc());
		}
		return vo;
	}

	private String decrypt(String str){
		AES256Util aes;
		String strOut=null;
		try {
			aes = new AES256Util(CodeUtil.KEY_SPEC);
			strOut = aes.decrypt(str);
		} catch (Exception e) {
            logger.error("decrypt Exception");
		}
    	return strOut;
	}

	public List<CustomNhwithVO> excel(CustomNhwithVO req) {
		return nhwithDAO.nhwithTemplatelistTot(req);
	}

	public List<CustomNhwithVO> historyExcel(CustomNhwithVO req) {
    	if(req.getSearchKind().equals("receiver_name") && req.getKeyword() != ""){ req.setReceiverName(req.getReceiverNameEnc()); }
		return nhwithDAO.nhwithTemplateHistoryListTot(req);
	}

}
