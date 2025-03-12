package com.ivucenter.cloud.portal.cmm.license;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class OssLicenseService {

	@Autowired
	OssLicenseDAO dao;
	
	public String list(CustomOssLicenseVO req) {

    	List<CustomOssLicenseVO> lists = dao.list(req);
    	int recordsTotal = dao.listTot(req);
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
	
	public String detailList(CustomOssLicenseVO req) {

    	List<CustomOssLicenseVO> lists = dao.detailList(req);
    	int recordsTotal = dao.detailListTot(req);
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
	
	public CustomOssLicenseVO view(CustomOssLicenseVO req) {
		return dao.view(req);
	}
	public CustomOssLicenseVO detailView(CustomOssLicenseVO req) {
		return dao.detailView(req);
	}
	
	public String insert(CustomOssLicenseVO req) {
		return dao.insert(req)+"";
	}
	public String detailInsert(CustomOssLicenseVO req) {
		return dao.detailInsert(req)+"";
	}
	
	public String update(CustomOssLicenseVO req) {
		return dao.update(req)+"";
	}
	
	public String detailUpdate(CustomOssLicenseVO req) {
		return dao.detailUpdate(req)+"";
	}
	
	public String delete(CustomOssLicenseVO req) {
		return dao.delete(req)+"";
	}
	
	public String detailDelete(CustomOssLicenseVO req) {
		return dao.detailDelete(req)+"";
	}
}
