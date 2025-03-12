package com.ivucenter.cloud.portal.productUsageStatus.vm;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ProductUsageStatusVmService{

	@Autowired
	private ProductUsageStatusVmDAO dao;

	
	public String list(CustomProductUsageStatusVmVO req) {
    	List<CustomProductUsageStatusVmVO> lists = dao.list(req);
    	int recordsTotal = dao.listTot(req).size();
    	int recordsFiltered = recordsTotal;
	    
	    try {
	        JsonObject jsonResponse = new JsonObject();
	        Gson gson = new Gson();
	        
	        jsonResponse.addProperty("draw", req.getDraw());
	        jsonResponse.addProperty("recordsTotal", recordsTotal);
	        jsonResponse.addProperty("recordsFiltered", recordsFiltered);
	        jsonResponse.add("data", gson.toJsonTree(lists));
	        jsonResponse.add("totalData", gson.toJsonTree(dao.total(req)));
	         
	        return jsonResponse.toString();
	    } catch (JsonIOException e) {
	    	log.error(e.getMessage());
	    }
		return "";
	}
	
	public void excel(CustomProductUsageStatusVmVO req, ModelMap map) {
		try{
			map.addAttribute("excel_gbn", "vm");
			map.addAttribute("excel_title", "상품사용현황_가상서버");
			map.addAttribute("excel_list", dao.list(req));
		}catch(Exception e){
			log.error(e.getMessage());
		}
	}
}
