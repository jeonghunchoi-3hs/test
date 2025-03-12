package com.ivucenter.cloud.portal.monitoring.status;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;
import com.ivucenter.cloud.portal.oss.vm.CustomOssVmVO;

@Service
public class MonitoringRealtimeStatusService{

    private static final Logger logger = LoggerFactory.getLogger(MonitoringRealtimeStatusService.class);

	@Autowired
	MonitoringRealtimeStatusDAO dao;

	public String list(Map req) {
	    int recordsTotal;
	    int recordsFiltered;

    	List<CustomMonitoringStatusVO> lists = dao.list(req);
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

	public List<CustomMonitoringStatusVO> getCpuUsaged(CustomOssVmVO req) {
		return dao.getCpuUsaged(req);
	}

	public List<CustomMonitoringStatusVO> getMemUsaged(CustomOssVmVO req) {
		return dao.getMemUsaged(req);
	}

	public List<CustomMonitoringStatusVO> getDiskUsaged(CustomOssVmVO req) {
		return dao.getDiskUsaged(req);
	}

	public List<CustomMonitoringStatusVO> getNetworkUsaged(CustomOssVmVO req) {
		return dao.getNetworkUsaged(req);
	}

	public List<CustomMonitoringStatusVO> getCpuTopX(Map req) {
		return dao.getCpuTopX(req);
	}

	public List<CustomMonitoringStatusVO> getMemTopX(Map req) {
		return dao.getMemTopX(req);
	}

}
