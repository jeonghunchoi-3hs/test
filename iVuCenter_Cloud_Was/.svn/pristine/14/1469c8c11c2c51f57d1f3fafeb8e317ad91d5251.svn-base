package com.ivucenter.cloud.portal.bss.discount;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang.time.DateFormatUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;
import com.ivucenter.cloud.portal.oss.project.CustomOssProjectVO;
import com.ivucenter.cloud.portal.oss.project.OssProjectDAO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class BssDiscountService{

	@Autowired
	private BssDiscountDAO dao;
	
	@Autowired
	private OssProjectDAO ossProjectDAO;
	
	public String list(CustomBssDiscountVO req){
		List<CustomBssDiscountVO> lists = dao.list(req);
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
			log.error(e.getMessage());
		}
		return "";
	}
	public List<CustomBssDiscountVO> excel(CustomBssDiscountVO req) {
		return dao.listTot(req);
	}
	
	public String detail(CustomBssDiscountVO req) {
		List<CustomBssDiscountVO> lists = dao.detail(req);
		int recordsTotal = lists.size();
		int recordsFiltered = recordsTotal;
		CustomOssProjectVO vo = new CustomOssProjectVO();
		vo.setProjectId(req.getProjectId());
		vo = ossProjectDAO.detail(vo);
		
		try {
			JsonObject jsonResponse = new JsonObject();
			Gson gson = new Gson();
			
			jsonResponse.addProperty("draw", req.getDraw());
			jsonResponse.addProperty("recordsTotal", recordsTotal);
			jsonResponse.addProperty("recordsFiltered", recordsFiltered);
			jsonResponse.add("data", gson.toJsonTree(lists));
			jsonResponse.add("prjectData", gson.toJsonTree(vo));
			
			return jsonResponse.toString();
		} catch (JsonIOException e) {
			log.error(e.getMessage());
		}
		return "";
	}
	public String insert(CustomBssDiscountVO req) {
		JsonObject jsonResponse = new JsonObject();
		
		int iApplyDate = Integer.parseInt(req.getApplyDate().replace("-", ""));
		int iNow = Integer.parseInt(DateFormatUtils.format(new Date(), "yyyyMM"));
		if(iApplyDate <= iNow){
			jsonResponse.addProperty("errorMsg", "해당 적용년월은 등록할수 없습니다.");
			return jsonResponse.toString();
		}
		
		req.setApplyDate(req.getApplyDate()+"-01");
		if(dao.detail(req).size() > 0){
			jsonResponse.addProperty("errorMsg", "이미 등록된 할인율이 있습니다.");
			return jsonResponse.toString();
		}
		
		req.setDiscountSeq(DateFormatUtils.format(new Date(), "yyyyMMddHHmmss"));
		jsonResponse.addProperty("errorMsg", dao.insert(req));
		return jsonResponse.toString();
	}
	
	public String delete(CustomBssDiscountVO req) {
		return dao.delete(req)+"";
	}
	
	public String update(CustomBssDiscountVO req) {
		JsonObject jsonResponse = new JsonObject();
		
		int iApplyDate = Integer.parseInt(req.getApplyDate().replace("-", ""));
		int iNow = Integer.parseInt(DateFormatUtils.format(new Date(), "yyyyMM"));
		if(iApplyDate <= iNow){
			jsonResponse.addProperty("errorMsg", "해당 적용년월은 등록할수 없습니다.");
			return jsonResponse.toString();
		}
		
		req.setApplyDate(req.getApplyDate()+"-01");
		if(dao.detail(req).size() > 0){
			jsonResponse.addProperty("errorMsg", "이미 등록된 할인율이 있습니다.");
			return jsonResponse.toString();
		}
		jsonResponse.addProperty("errorMsg", dao.update(req));
		return jsonResponse.toString();
	}
	
}
