package com.ivucenter.cloud.portal.bbs.qna;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service("BbsQnaService")
public class BbsQnaServiceImpl implements BbsQnaService{

    private static final Logger logger = LoggerFactory.getLogger(BbsQnaServiceImpl.class);

	@Autowired
	private BbsQnaDAO dao;

	@Override
	public String list(CustomBbsQnaVO req) {
	    int recordsTotal;
	    int recordsFiltered;
	    int noReplyCntTotal = 0;
	    int replyCnt = 0;

    	List<CustomBbsQnaVO> lists = dao.list(req);
	    recordsTotal = dao.listTot(req);
	    recordsFiltered = recordsTotal;

	    for(CustomBbsQnaVO vo : lists) {
	    	replyCnt = vo.getReplyCnt();
	    	if(replyCnt == 0) {
	    		noReplyCntTotal ++;
	    	}
	    }

	    try {
	        JsonObject jsonResponse = new JsonObject();
	        Gson gson = new Gson();

	        jsonResponse.addProperty("draw", req.getDraw());
	        jsonResponse.addProperty("recordsTotal", recordsTotal);
	        jsonResponse.addProperty("recordsFiltered", recordsFiltered);
	        jsonResponse.addProperty("noReplyCntTotal", noReplyCntTotal);
	        jsonResponse.add("data", gson.toJsonTree(lists));

	        return jsonResponse.toString();
	    } catch (JsonIOException e) {

            logger.error("JSON 처리 중 오류 발생");
	    }
		return "";
	}

	@Override
	public String mngList(CustomBbsQnaVO req) {
    	List<CustomBbsQnaVO> lists = dao.mngList(req);
	    int recordsTotal = dao.mngListTot(req).size();
	    int recordsFiltered = recordsTotal;

	    try {
	        JsonObject jsonResponse = new JsonObject();
	        Gson gson = new Gson();

	        jsonResponse.addProperty("draw", req.getDraw());
	        jsonResponse.addProperty("recordsTotal", recordsTotal);
	        jsonResponse.addProperty("recordsFiltered", recordsFiltered);
	        jsonResponse.add("data", gson.toJsonTree(lists));

	        return jsonResponse.toString();
	    } catch (JsonIOException e) {

	    	logger.error("mngList Exception");

	    }
		return "";
	}

	@Override
	public CustomBbsQnaVO detail(CustomBbsQnaVO req) {
		return dao.detail(req);
	}

	@Override
	public CustomBbsQnaVO detailReply(CustomBbsQnaVO req) {
		return dao.detailReply(req);
	}

	@Override
	public String insert(CustomBbsQnaVO req) {
		return dao.insert(req)+"";
	}

	@Override
	public String update(CustomBbsQnaVO req) {
		return dao.update(req)+"";
	}

	@Override
	public String delete(CustomBbsQnaVO req) {
		return dao.delete(req)+"";
	}

	@Override
	public void updateHitCount(CustomBbsQnaVO req) {
		 dao.updateHitCount(req);
	}

	@Override
	public List<CustomBbsQnaVO> getNoticeBbscodeList(String codeKeyId){
		log.debug("=== getNoticeBbscodeList Service ===");
		return dao.getNoticeBbscodeList(codeKeyId);
	}

	@Override
	public CustomBbsQnaVO getNoReplyCount(CustomBbsQnaVO req) {
		 return dao.getNoReplyCount(req);
	}

	@Override
	public List<CustomBbsQnaVO> excel(CustomBbsQnaVO req) {
		return dao.mngListTot(req);
	}
}
