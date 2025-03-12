package com.ivucenter.cloud.portal.oss.scaleOut;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;


@Service("ScaleOutService")
public class ScaleOutServiceImpl implements ScaleOutService{

	@Autowired
	private ScaleOutDAO dao;

	@Override
	public String list(CustomScaleOutVO req) {
	    int recordsTotal;
	    int recordsFiltered;

    	List<CustomScaleOutVO> lists = dao.list(req);
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
	        e.printStackTrace();
	    }
		return "";
	}

	@Override
	public List<CustomScaleOutVO> excel(CustomScaleOutVO req) {
		return dao.excel(req);
	}

	@Override
	public CustomScaleOutVO detail(CustomScaleOutVO req) {
		return dao.detail(req);
	}

	@Override
	public String update(CustomScaleOutVO req) {
		return dao.update(req)+"";
	}

	@Override
	public String delete(CustomScaleOutVO req) {
		return dao.delete(req)+"";
	}
}
