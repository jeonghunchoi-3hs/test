package com.ivucenter.cloud.portal.cmm.network;

import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.apache.commons.lang.time.DateFormatUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;
import com.ivucenter.cloud.portal.util.CodeUtil;


/**
 * @author 박진우
 */
@Service
public class CmmNetworkService{

    private static final Logger logger = LoggerFactory.getLogger(CmmNetworkService.class);

	@Autowired
	CmmNetworkDAO dao;

	public String list(CustomCmmNetworkVO req) {

		List<CustomCmmNetworkVO> lists = dao.list(req);
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
            logger.error("JSON 처리 중 오류 발생");
	    }
		return "";
	}

	public CustomCmmNetworkVO detail(CustomCmmNetworkVO req) {
		return dao.detail(req);
	}

	public String insert(CustomCmmNetworkVO req) {
		if(req.getNetworkId().equals("")){
			String [][] aNetworks = CodeUtil.NETWORKS;
			int num = 0;
			for(String [] aArray : aNetworks){
				req.setNetworkId(DateFormatUtils.format(new Date(), "yyyyMMdd-")+UUID.randomUUID());
				req.setWorkKind(aArray[0]);
				req.setWorkNetKind(aArray[1]);
				req.setCClass(aArray[2]);
				req.setCidr(aArray[3]);
				dao.insert(req);
				num++;
			}
			return num+"";
		}else{
			return dao.update(req)+"";
		}
	}

	public String delete(CustomCmmNetworkVO req) {
		return dao.delete(req)+"";
	}

	public String customerlist(CustomCmmNetworkVO req) {
		List<CustomCmmNetworkVO> lists = dao.customerlist(req);
		int recordsTotal = dao.customerlistTot(req);
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

	public String customerPopList(CustomCmmNetworkVO req) {
		List<CustomCmmNetworkVO> lists = dao.customerPopList(req);
		int recordsTotal = dao.customerPopListTot(req);
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

	public String customerInsert(CustomCmmNetworkVO req) {

		if(dao.customerChk(req) > 0){
			return "0";
		}else{
			return dao.customerInsert(req);
		}


	}

	public String customerDelete(CustomCmmNetworkVO req) {
		return dao.customerDelete(req);
	}

	public List<CustomCmmNetworkVO> listAffiliateName(CustomCmmNetworkVO req) {
		return dao.listAffiliateName(req);
	}

	public Object excel(CustomCmmNetworkVO req) {
		return dao.listTot(req);
	}
}
