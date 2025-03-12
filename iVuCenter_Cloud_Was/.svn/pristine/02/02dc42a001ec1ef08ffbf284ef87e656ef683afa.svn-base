package com.ivucenter.cloud.portal.mygoods.vm;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;

@Service("MygoodsVmService")
public class MygoodsVmServiceImpl implements MygoodsVmService {

    private static final Logger logger = LoggerFactory.getLogger(MygoodsVmServiceImpl.class);

	@Autowired
	MygoodsVmDAO dao;

	//나의상품 VM 목록조회
	@Override
	public String list(CustomMygoodsVmVO req) {
		int recordsTotal;
		int recordsFiltered;

		List<CustomMygoodsVmVO> lists = dao.list(req);
	    recordsTotal = dao.listTot(req);
	    recordsFiltered = recordsTotal;
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

	@Override
	public CustomMygoodsVmVO detail(CustomMygoodsVmVO req) {
		return null;
	}

	@Override
	public CustomMygoodsVmVO insert(CustomMygoodsVmVO req) {
		return null;
	}

	@Override
	public CustomMygoodsVmVO update(CustomMygoodsVmVO req) {
		return null;
	}

	@Override
	public CustomMygoodsVmVO delete(CustomMygoodsVmVO req) {
		return null;
	}

}
