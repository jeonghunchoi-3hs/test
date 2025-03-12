package com.ivucenter.cloud.portal.productUsageStatus.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ProductUsageStatusServiceService {

    private static final Logger logger = LoggerFactory.getLogger(ProductUsageStatusServiceService.class);

	@Autowired
	private ProductUsageStatusServiceDAO dao;

	/**
	 * 형상관리서비스 목록조회
	 * @param req
	 * @return
	 */
	public String list(CustomProductUsageStatusServiceVO req){
		List<CustomProductUsageStatusServiceVO> lists = dao.list(req);
		int recordsTotal = dao.listTotal(req);
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
	    	logger.error("JSON 처리 중 오류 발생");
	    }
		return "";
	}

	public void excel(CustomProductUsageStatusServiceVO req, ModelMap map) {
		try{
			map.addAttribute("excel_gbn", "service");
			map.addAttribute("excel_title", "상품사용현황_서비스상품");
			map.addAttribute("excel_list", dao.list(req));
		}catch(Exception e){
			logger.error("excel download 상품사용현황_서비스상품 Exception");
		}
	}

}
