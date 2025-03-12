package com.ivucenter.cloud.portal.bss.batch;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.JsonObject;


@Service("SchedulerService")
public class SchedulerServiceImpl implements SchedulerService{

    private static final Logger logger = LoggerFactory.getLogger(SchedulerServiceImpl.class);

	@Autowired
	private SchedulerDAO schedulerDAO;

	@Override
	public String list(CustomSchedulerVO req) {

		int recordsTotal;
	    int recordsFiltered;

		List<CustomSchedulerVO> lists =  schedulerDAO.list(req);
		recordsTotal =  schedulerDAO.listTot(req);
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
	public CustomSchedulerVO detail(CustomSchedulerVO req) {
		return schedulerDAO.detail(req);
	}

	@Override
	public String insert(CustomSchedulerVO req) {
		return schedulerDAO.insert(req)+"";
	}

	@Override
	public String update(CustomSchedulerVO req) {
		return schedulerDAO.update(req)+"";
	}

	@Override
	public String delete(CustomSchedulerVO req) {
		return schedulerDAO.delete(req)+"";
	}
}
