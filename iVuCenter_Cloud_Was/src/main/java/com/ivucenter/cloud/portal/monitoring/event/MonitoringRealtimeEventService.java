package com.ivucenter.cloud.portal.monitoring.event;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;

@Service
public class MonitoringRealtimeEventService{

    private static final Logger logger = LoggerFactory.getLogger(MonitoringRealtimeEventService.class);

	@Autowired
	MonitoringRealtimeEventDAO dao;

	public String list(Map req) {
	    int recordsTotal;
	    int recordsFiltered;

    	List<CustomMonitoringEventVO> lists = dao.list(req);
	    recordsTotal = dao.listTot(req);
	    recordsFiltered = recordsTotal;

	    try {
	        JsonObject jsonResponse = new JsonObject();
	        Gson gson = new Gson();

	        //jsonResponse.addProperty("draw", req.getDraw());
	        jsonResponse.addProperty("recordsTotal", recordsTotal);
	        jsonResponse.addProperty("recordsFiltered", recordsFiltered);
	        jsonResponse.add("data", gson.toJsonTree(lists));

	        return jsonResponse.toString();
	    } catch (JsonIOException e) {
            logger.error("JSON 처리 중 오류 발생");
	    }
		return "";
	}

	public CustomMonitoringEventVO getEventSummaryCnt(Map req) {
		return dao.getEventSummaryCnt(req);
	}


}
