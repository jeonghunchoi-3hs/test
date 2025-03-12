package com.ivucenter.cloud.portal.cmm.code;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;
import com.ivucenter.cloud.portal.bss.product.CustomBssProductVO;
import com.ivucenter.cloud.portal.req.catalogue.CustomReqCatalogueVO;

@Service
public class CmmCodeService{

    private static final Logger logger = LoggerFactory.getLogger(CmmCodeService.class);

	@Autowired
	public CmmCodeDAO dao;

	public String list(CustomCmmCodeVO req) {

    	List<CustomCmmCodeVO> lists = dao.list(req);
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

	public List<CustomCmmCodeVO> listDetail(CustomCmmCodeVO req) {
		return dao.list(req);
	}

	public List<CustomCmmCodeVO> getBlockDisk(CustomReqCatalogueVO req) {
		return dao.getBlockDisk(req);
	}

	public CustomCmmCodeVO detail(CustomCmmCodeVO req) {
		return dao.detail(req);
	}

	public String insert(CustomCmmCodeVO req) {
		return dao.insert(req)+"";
	}

	public String update(CustomCmmCodeVO req) {
		return dao.update(req)+"";
	}

	public String delete(CustomCmmCodeVO req) {
		return dao.delete(req)+"";
	}

	public List<CustomCmmCodeVO> getSharedNetwork() {
		return dao.getSharedNetwork();
	}

	public List<CustomCmmCodeVO> getLoadProtocol() {
		return dao.getLoadProtocol();
	}

	public List<CustomCmmCodeVO> getLoadMethod() {
		return dao.getLoadMethod();
	}

	public List<CustomCmmCodeVO> getLoadMonitorType() {
		return dao.getLoadMonitorType();
	}

	public List<CustomCmmCodeVO> getCmmCode(String codeKeyId) {
		return dao.getCmmCode(codeKeyId);
	}

	public List<CustomCmmCodeVO> getCmmCodeByList(List<String> codeKeyList) {
		return dao.getCmmCodeByList(codeKeyList);
	}

	public List<CustomCmmCodeVO> getBlockDisk(CustomBssProductVO req) {
		return dao.getBlockDisk(req);
	}

}
