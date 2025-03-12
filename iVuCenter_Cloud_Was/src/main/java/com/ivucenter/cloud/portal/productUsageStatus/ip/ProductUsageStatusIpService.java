package com.ivucenter.cloud.portal.productUsageStatus.ip;

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
public class ProductUsageStatusIpService {

    private static final Logger logger = LoggerFactory.getLogger(ProductUsageStatusIpService.class);

	@Autowired
	ProductUsageStatusIpDAO dao;

	/**
	 * 공인IP 목록조회
	 * @param req
	 * @return
	 */
	public String list(CustomProductUsageStatusIpVO req){
		List<CustomProductUsageStatusIpVO> lists = dao.list(req);

		int recordsTotal = lists.size();
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

	public void excel(CustomProductUsageStatusIpVO req, ModelMap map) {
		try{
			map.addAttribute("excel_gbn", "ip");
			map.addAttribute("excel_title", "상품사용현황_공인IP");
			map.addAttribute("excel_list", dao.list(req));
		}catch(Exception e){
			logger.error("상품사용현황_공인IP Exception");
		}
	}
}
