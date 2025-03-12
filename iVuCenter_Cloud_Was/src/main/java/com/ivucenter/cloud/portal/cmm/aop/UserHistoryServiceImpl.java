package com.ivucenter.cloud.portal.cmm.aop;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;
import com.ivucenter.cloud.portal.login.CustomLoginHistoryVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service("UserHistoryService")
public class UserHistoryServiceImpl implements UserHistoryService {
	
	@Autowired
	private UserHistoryDAO dao;
	
	public String insertUserHistory(UserHistoryVO req) {
		return dao.insertUserHistory(req)+"";
	}
	
	@Override
	public String list(UserHistoryVO req) {
    	List<UserHistoryVO> lists = dao.list(req);
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
	public List<UserHistoryVO> excel(UserHistoryVO req) {
		return dao.listTot(req);
	}
	@Override
	public List<CustomLoginHistoryVO> loginHistoryListTot(CustomLoginHistoryVO req) {
		return dao.loginHistoryListTot(req);
	}
	
	
	@Override
	public String loginHistoryList(CustomLoginHistoryVO req) {
    	List<CustomLoginHistoryVO> lists = dao.loginHistoryList(req);
	    int recordsTotal = dao.loginHistoryListTot(req).size();
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
	

}
