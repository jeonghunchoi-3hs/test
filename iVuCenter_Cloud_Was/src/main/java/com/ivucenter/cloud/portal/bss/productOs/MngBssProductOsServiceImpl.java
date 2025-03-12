package com.ivucenter.cloud.portal.bss.productOs;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service("mngBssProductOsService")
public class MngBssProductOsServiceImpl implements MngBssProductOsService{

	@Resource(name="mngBssProductOsDAO")
	private MngBssProductOsDAO mngBssProductOsDAO;
	
	//pho getProjectList
	@Override
	public String list(CustomBssProductOsVO req) {
	    int recordsTotal; // �� ��
	    int recordsFiltered;	// �˻� �� ��
	    
    	List<CustomBssProductOsVO> lists = mngBssProductOsDAO.list(req);
	    recordsTotal = mngBssProductOsDAO.listTot(req);
	    recordsFiltered = recordsTotal;
	    
	    log.debug("=== recordsTotal ==="+recordsTotal);
	    

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
	
	@Override
	public CustomBssProductOsVO detail(String productSeq){
		log.debug("=== detail ServiceImpl ===");
		return mngBssProductOsDAO.detail(productSeq);
	}
	
	@Override
	public String delete(String productSeq) {
		return mngBssProductOsDAO.delete(productSeq) + "";
	}

	@Override
	public String productDelete(String productSeq) {
		return mngBssProductOsDAO.productDelete(productSeq) + "";
	}

	@Override
	public CustomBssProductOsVO productView(String productSeq){
		log.debug("=== getCatalogueProductList Service ===");
		return mngBssProductOsDAO.productView(productSeq);	
	}
	
	@Override
	public CustomBssProductOsVO osView(String productSeq){
		log.debug("=== getCatalogueProductList Service ===");
		return mngBssProductOsDAO.osView(productSeq);	
	}	
	
	@Override
	public CustomBssProductOsVO view(String productSeq){
		log.debug("=== getCatalogueProductList Service ===");
	return mngBssProductOsDAO.view(productSeq);	
	}	
	
	@Override
	public List<CustomBssProductOsVO> osPopList(CustomBssProductOsVO req){
		log.debug("=== osPopList Service ===");
		return mngBssProductOsDAO.osPopList(req);
	}
	
	@Override
	public String productUpdate(CustomBssProductOsVO req) {
		return mngBssProductOsDAO.productUpdate(req)+"";
	}
	
	@Override
	public String vmUpdate(CustomBssProductOsVO req) {
		return mngBssProductOsDAO.vmUpdate(req)+"";
	}
	
	@Override
	public String osUpdate(CustomBssProductOsVO req) {
		return mngBssProductOsDAO.osUpdate(req)+"";
	}
	
//	@Override
//	public List<CustomBssProductOsVO> pcList(String parentCodeId){
//		log.debug("=== String parentCodeId ServiceImpl ===");
//		return mngBssProductOsDAO.pcList(parentCodeId);
//	}	
	
	@Override
	public String productInsert(CustomBssProductOsVO req) {
		return mngBssProductOsDAO.productInsert(req)+"";
	}
	
	@Override
	public String vmInsert(CustomBssProductOsVO req) {
		return mngBssProductOsDAO.vmInsert(req)+"";
	}
	
	@Override
	public String osInsert(CustomBssProductOsVO req) {
		return mngBssProductOsDAO.osInsert(req)+"";
	}

	@Override
	public CustomBssProductOsVO productSeqReturn(CustomBssProductOsVO req) {
		return mngBssProductOsDAO.productSeqReturn( req);
	}
}	
