package com.ivucenter.cloud.portal.productUsageStatus.nas;

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
public class ProductUsageStatusNasService{

	@Autowired
	private ProductUsageStatusNasDAO dao;

	
	public String list(CustomProductUsageStatusNasVO req) {
    	List<CustomProductUsageStatusNasVO> lists = dao.list(req);
    	CustomProductUsageStatusNasVO res = dao.total(req);
    	int recordsTotal = res.getLength();
    	int recordsFiltered = recordsTotal;
	    
	    try {
	        JsonObject jsonResponse = new JsonObject();
	        Gson gson = new Gson();
	        
	        jsonResponse.addProperty("draw", req.getDraw());
	        jsonResponse.addProperty("recordsTotal", recordsTotal);
	        jsonResponse.addProperty("recordsFiltered", recordsFiltered);
	        jsonResponse.addProperty("totalSize", res.getNasGb());
	        jsonResponse.add("data", gson.toJsonTree(lists));
	         
	        return jsonResponse.toString();
	    } catch (JsonIOException e) {
	    	log.error(e.getMessage());
	    }
		return "";
	}
	
	public void excel(CustomProductUsageStatusNasVO req, ModelMap map) {
		try{
			map.addAttribute("excel_gbn", "nas");
			map.addAttribute("excel_title", "상품사용현황_NAS");
			map.addAttribute("excel_list", dao.list(req));
		}catch(Exception e){
			log.error(e.getMessage());
		}
	}
}
