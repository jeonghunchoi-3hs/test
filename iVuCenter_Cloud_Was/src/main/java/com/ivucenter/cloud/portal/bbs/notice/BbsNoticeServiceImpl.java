package com.ivucenter.cloud.portal.bbs.notice;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service("BbsNoticeService")
public class BbsNoticeServiceImpl implements BbsNoticeService{
	
	@Autowired
	private BbsNoticeDAO dao;
	
	@Override
	public String list(CustomBbsNoticeVO req) {
    	List<CustomBbsNoticeVO> lists = dao.list(req);
	    int recordsTotal = dao.listTot(req).size();
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
	        log.error(e.getMessage());
	    }
		return "";
	}
	
	@Override
	public CustomBbsNoticeVO detail(CustomBbsNoticeVO req) {
		return dao.detail(req);
	}

	@Override
	public CustomBbsNoticeVO getCurrentNotice(CustomBbsNoticeVO req) {
		return dao.getCurrentNotice(req);
	}

	@Override
	public String insert(CustomBbsNoticeVO req) {
		return dao.insert(req)+"";
	}

	@Override
	public String update(CustomBbsNoticeVO req) {
		return dao.update(req)+"";
	}

	@Override
	public String delete(CustomBbsNoticeVO req) {
		return dao.delete(req)+"";
	}

	@Override
	public void updateHitCount(CustomBbsNoticeVO req) {
		log.debug("updateHitCount service");
		log.debug("noticeNo : " + req.getNoticeNo());
		 dao.updateHitCount(req);
	}

	@Override
	public List<CustomBbsNoticeVO> getBbsCodeList(String codeKeyId) {
		
		return dao.bbsCodeList(codeKeyId);
	}
	
	@Override
	public List<CustomBbsNoticeVO> getNoticeBbscodeList(String codeKeyId){
		log.debug("=== getNoticeBbscodeList Service ===");
		return dao.getNoticeBbscodeList(codeKeyId);
	}
	
	@Override
	public List<CustomBbsNoticeVO> getApprovalModelStepList(String modeLid){
		log.debug("=== getNoticeBbscodeList Service ===");
		return dao.getApprovalModelStepList(modeLid);
	}

	@Override
	public List<CustomBbsNoticeVO> excel(CustomBbsNoticeVO req) {
		return dao.listTot(req);
	}
	
}
