package com.ivucenter.cloud.portal.cmm.company;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class CmmCompanyService{

	@Autowired
	private CmmCompanyDAO dao;
	
	public String list(CustomCmmCompanyVO req) {
    	List<CustomCmmCompanyVO> lists = dao.list(req);
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

	
	public String affilateList(CustomCmmCompanyVO req) {
    	List<CustomCmmCompanyVO> lists = dao.affilateList(req);
    	int recordsTotal = dao.affilateListTot(req).size();
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

	public String companylist(CustomCmmCompanyVO req) {
	    try {
	        JsonObject jsonResponse = new JsonObject();
	        Gson gson = new Gson();
	        jsonResponse.add("companylist", gson.toJsonTree(dao.companylist(req)));
	        return jsonResponse.toString();
	    } catch (JsonIOException e) {
	    	log.error(e.getMessage());
	    }
		return "";
	}
	
	
	public List<CustomCmmCompanyVO> excel(CustomCmmCompanyVO req) {
		return dao.listTot(req);
	}

	public String insert(CustomCmmCompanyVO req) {
		
		try {
			if(req.getUpCompanyId().equals("*")){
				req.setCompanyId("CUSTOMER_"+UUID.randomUUID().toString());
			}else{
				req.setCompanyId(UUID.randomUUID().toString());
			}
			
	        JsonObject jsonResponse = new JsonObject();
	        jsonResponse.addProperty("companyId", req.getCompanyId());
	        jsonResponse.addProperty("errorCode", dao.insert(req));
	         
	        return jsonResponse.toString();
	    } catch (JsonIOException e) {
	    	log.error(e.getMessage());
	    }
		return "";
	}

	public String update(CustomCmmCompanyVO req) {
		return dao.update(req);
	}

	public CustomCmmCompanyVO detail(CustomCmmCompanyVO req) {
		return dao.detail(req);
	}
}
