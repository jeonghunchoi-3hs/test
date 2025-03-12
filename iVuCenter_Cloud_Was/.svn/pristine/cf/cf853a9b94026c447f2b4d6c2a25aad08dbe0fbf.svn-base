package com.ivucenter.cloud.portal.productUsageStatus.lb;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;

@Service
public class ProductUsageStatusLbService{

    private static final Logger logger = LoggerFactory.getLogger(ProductUsageStatusLbService.class);

	@Autowired
	ProductUsageStatusLbDAO dao;


	public String list(CustomProductUsageStatusLbVO req) {
    	List<CustomProductUsageStatusLbVO> lists = dao.list(req);
    	CustomProductUsageStatusLbVO res = dao.total(req);
    	int recordsTotal = res.getLength();
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
	    	logger.error("JSON 처리 중 오류 발생");
	    }
		return "";
	}

	public void excel(CustomProductUsageStatusLbVO req, ModelMap map) {
		try{
			map.addAttribute("excel_gbn", "lb");
			map.addAttribute("excel_title", "상품사용현황_로드분산");
			map.addAttribute("excel_list", dao.list(req));
		}catch(Exception e){
			logger.error("상품사용현황_로드분산 Exception");
		}
	}
}
