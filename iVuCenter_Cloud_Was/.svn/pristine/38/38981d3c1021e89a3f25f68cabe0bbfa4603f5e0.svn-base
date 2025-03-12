package com.ivucenter.cloud.portal.bss.batch;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

@Service("bssBatchService")
public class BssBatchServiceImpl implements BssBatchService {

    private static final Logger logger = LoggerFactory.getLogger(BssBatchServiceImpl.class);

	@Autowired
	private BssBatchDAO dao;

	@Override
	public String bssBatchList(CustomBssBatchVO req) {

		int recordsTotal;
	    int recordsFiltered;

		List<CustomBssBatchVO> lists = dao.bssBatchList(req);
		recordsTotal = dao.bssBatchListTot(req);
		recordsFiltered = recordsTotal;

		try{
			JsonObject jsonResponse = new JsonObject();
			Gson gson = new Gson();

			jsonResponse.addProperty("draw", req.getDraw());
	        jsonResponse.addProperty("recordsTotal", recordsTotal);
	        jsonResponse.addProperty("recordsFiltered", recordsFiltered);
	        jsonResponse.add("data", gson.toJsonTree(lists));

	        return jsonResponse.toString();
		}catch(Exception e){
            logger.error("JSON 처리 중 오류 발생");
		}
		return "";
	}


	@Override
	public CustomBssBatchVO bssBatchDetail(CustomBssBatchVO batchVo){
		return dao.bssBatchDetail(batchVo);
	}

	@Override
	public String bssBatchInsert(CustomBssBatchVO batchVo) {
		return dao.bssBatchInsert(batchVo);
	}

	@Override
	public String bssBatchUpdate(CustomBssBatchVO batchVo) {
		return dao.bssBatchUpdate(batchVo);
	}

	@Override
	public String bssBatchDelete(CustomBssBatchVO batchVo) {
		return dao.bssBatchDelete(batchVo);
	}

}
