package com.ivucenter.cloud.portal.productUsageStatus.total;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;
import com.ivucenter.cloud.portal.oss.application.CustomOssAppVO;
import com.ivucenter.cloud.portal.oss.application.OssAppService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ProductUsageStatusTotalService{

    private static final Logger logger = LoggerFactory.getLogger(ProductUsageStatusTotalService.class);

	@Autowired
	ProductUsageStatusTotalDAO dao;

	@Autowired
	OssAppService ossAppService;

	public String list(CustomProductUsageStatusTotalVO req) {
    	List<CustomProductUsageStatusTotalVO> lists = dao.list(req);

    	List appUidList = new ArrayList();

    	for( int i =0; i<lists.size(); ++i) {
    		CustomProductUsageStatusTotalVO customProductUsageStatusTotalVO = new CustomProductUsageStatusTotalVO();
    		customProductUsageStatusTotalVO = (CustomProductUsageStatusTotalVO) lists.get( i);
    		int podCount = 0;
    		if( customProductUsageStatusTotalVO.getAppUid() != null) {
    			//CustomOssAppVO customOssAppVO = new CustomOssAppVO();
        		//customOssAppVO.setAppUid( customProductUsageStatusTotalVO.getAppUid());
        		String[] aresApp = customProductUsageStatusTotalVO.getAppUid().split(",");
        		if( aresApp != null) {
        			for( int j = 0; j<aresApp.length; ++j) {
        				CustomOssAppVO customOssAppVO = new CustomOssAppVO();
        				customOssAppVO.setAppUid( aresApp[j]);
        				customOssAppVO = ossAppService.returnVoInfo( customOssAppVO);

        				log.debug("customOssAppVO######f");
        				log.debug(customOssAppVO.toString());

        			}

        		}
    		}

    	}




    	int recordsTotal = lists.size();
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

	public List<CustomProductUsageStatusTotalVO> lists(CustomProductUsageStatusTotalVO req) {
		return dao.list(req);
	}

	public String searchBox(CustomProductUsageStatusTotalVO req) {
		if(req.getSearchKind().equals("0") || req.getSearchKind().equals("1") || req.getSearchKind().equals("2")){
			try {
		        JsonObject jsonResponse = new JsonObject();
		        Gson gson = new Gson();
		        String [] aGroup = {"customer_name", "customer_name", "project_alias"};
		        req.setSearchKind(aGroup[Integer.parseInt(req.getSearchKind())]);
		        jsonResponse.add("searchBox", gson.toJsonTree(dao.searchBox(req)));
		        return jsonResponse.toString();
		    } catch (JsonIOException e) {
		    	logger.error("JSON 처리 중 오류 발생");
		    }
		}
		return "";
	}


	public void excel(CustomProductUsageStatusTotalVO req, ModelMap map) {
		try{
			map.addAttribute("excel_gbn", "total");
			map.addAttribute("excel_title", "상품사용현황_"+ req.getCloudName() );
			map.addAttribute("excel_list", dao.list(req));
			map.addAttribute("excel_list_total", dao.total(req));
		}catch(Exception e){
			logger.error("excel download 상품사용현황 Exception");
		}
	}
}
