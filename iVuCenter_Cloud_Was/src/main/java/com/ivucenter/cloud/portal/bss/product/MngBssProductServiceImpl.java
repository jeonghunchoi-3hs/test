package com.ivucenter.cloud.portal.bss.product;

import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service("mngBssProductService")
public class MngBssProductServiceImpl implements MngBssProductService{

	@Resource(name="mngBssProductDAO")
	private MngBssProductDAO mngBssProductDAO;

	//pho getProjectList
	@Override
	public String list(CustomBssProductVO req) {
	    int recordsTotal; // �� ��
	    int recordsFiltered;	// �˻� �� ��

    	List<CustomBssProductVO> lists = mngBssProductDAO.list(req);
	    recordsTotal = mngBssProductDAO.listTot(req).size();
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
	public List<CustomBssProductVO> bssProductList(CustomBssProductVO req){
		log.debug("=== bssProductList Service ===");
		return mngBssProductDAO.bssProductList(req);
	}
	@Override
	public CustomBssProductVO detail(String productSeq){
		log.debug("=== detail ServiceImpl ===");
		return mngBssProductDAO.detail(productSeq);
	}

	@Override
	public CustomBssProductVO productView(String productSeq){
		log.debug("=== getCatalogueProductList Service ===");
		return mngBssProductDAO.productView(productSeq);
	}
	@Override
	public CustomBssProductVO osView(String productSeq){
		log.debug("=== getCatalogueProductList Service ===");
		return mngBssProductDAO.osView(productSeq);
	}
	@Override
	public CustomBssProductVO diskView(String productSeq){
		log.debug("=== getCatalogueProductList Service ===");
		return mngBssProductDAO.diskView(productSeq);
	}
	@Override
	public CustomBssProductVO nasView(String productSeq){
		log.debug("=== getCatalogueProductList Service ===");
		return mngBssProductDAO.nasView(productSeq);
	}
	@Override
	public CustomBssProductVO ipView(String productSeq){
		log.debug("=== getCatalogueProductList Service ===");
		return mngBssProductDAO.ipView(productSeq);
	}
	@Override
	public CustomBssProductVO lbView(String productSeq){
		log.debug("=== getCatalogueProductList Service ===");
		return mngBssProductDAO.lbView(productSeq);
	}
//	@Override
//	public CustomBssProductVO scmView(String productSeq){
//		log.debug("=== getCatalogueProductList Service ===");
//		return mngBssProductDAO.scmView(productSeq);
//	}
//	@Override
//	public CustomBssProductVO mcaView(String productSeq){
//		log.debug("=== getCatalogueProductList Service ===");
//		return mngBssProductDAO.mcaView(productSeq);
//	}
//	@Override
//	public CustomBssProductVO bkView(String productSeq){
//		log.debug("=== getCatalogueProductList Service ===");
//		return mngBssProductDAO.bkView(productSeq);
//	}
	@Override
	public CustomBssProductVO serviceView(String productSeq){
		log.debug("=== getCatalogueProductList Service ===");
		return mngBssProductDAO.serviceView(productSeq);
	}

	@Override
	public CustomBssProductVO appView(String productSeq){
		log.debug("=== getCatalogueProductList app ===");
		return mngBssProductDAO.appView(productSeq);
	}
//	@Override
//	public CustomBssProductVO serView(String productSeq){
//		log.debug("=== getCatalogueProductList Service ===");
//		return mngBssProductDAO.serView(productSeq);
//	}
	@Override
	public CustomBssProductVO view(String productSeq){
		log.debug("=== getCatalogueProductList Service ===");
		return mngBssProductDAO.view(productSeq);
	}
	@Override
	public CustomBssProductVO getProductImageType(CustomBssProductVO req){
		return mngBssProductDAO.getProductImageType(req);
	}
	@Override
	public CustomBssProductVO getProductDiskType(CustomBssProductVO req){
		return mngBssProductDAO.getProductDiskType(req);
	}
	@Override
	public CustomBssProductVO getItemPriceInfo(CustomBssProductVO req){
		log.debug("=== getItemPriceInfo Service ===");
		return mngBssProductDAO.getItemPriceInfo(req);
	}


	@Override
	public List<CustomBssProductVO> getItemsPriceInfo(CustomBssProductVO req){
		log.debug("=== getItemPriceInfo Service ===");
		return mngBssProductDAO.getItemsPriceInfo(req);
	}


	@Override
	public List<CustomBssProductVO> osPopList(CustomBssProductVO req){
		log.debug("=== osPopList Service ===");
		return mngBssProductDAO.osPopList(req);
	}
	@Override
	public String productUpdate(CustomBssProductVO req) {
		return mngBssProductDAO.productUpdate(req)+"";
	}
	@Override
	public String vmUpdate(CustomBssProductVO req) {
		return mngBssProductDAO.vmUpdate(req)+"";
	}
	@Override
	public String osUpdate(CustomBssProductVO req) {
		return mngBssProductDAO.osUpdate(req)+"";
	}

	@Override
	public String diskUpdate(CustomBssProductVO req) {
		return mngBssProductDAO.diskUpdate(req)+"";
	}
	@Override
	public String nasUpdate(CustomBssProductVO req) {
		return mngBssProductDAO.nasUpdate(req)+"";
	}
	@Override
	public String ipUpdate(CustomBssProductVO req) {
		return mngBssProductDAO.ipUpdate(req)+"";
	}
	@Override
	public String lbUpdate(CustomBssProductVO req) {
		return mngBssProductDAO.lbUpdate(req)+"";
	}
//	@Override
//	public String scmUpdate(CustomBssProductVO req) {
//		return mngBssProductDAO.scmUpdate(req)+"";
//	}
//	@Override
//	public String bkUpdate(CustomBssProductVO req) {
//		return mngBssProductDAO.bkUpdate(req)+"";
//	}
//	@Override
//	public String serUpdate(CustomBssProductVO req) {
//		return mngBssProductDAO.serUpdate(req)+"";
//	}
//	@Override
//	public String mcaUpdate(CustomBssProductVO req) {
//		return mngBssProductDAO.mcaUpdate(req)+"";
//	}
	@Override
	public String serviceUpdate(CustomBssProductVO req) {
		return mngBssProductDAO.serviceUpdate(req)+"";
	}
	@Override
	public String productDelete(CustomBssProductVO req) {
		return mngBssProductDAO.productDelete(req)+"";
	}
	@Override
	public String vmDelete(CustomBssProductVO req) {
		return mngBssProductDAO.vmDelete(req)+"";
	}
	@Override
	public String diskDelete(CustomBssProductVO req) {
		return mngBssProductDAO.diskDelete(req)+"";
	}
	@Override
	public String seviceDelete(CustomBssProductVO req) {
		return mngBssProductDAO.seviceDelete(req)+"";
	}
	@Override
	public String osDelete(CustomBssProductVO req) {
		return mngBssProductDAO.osDelete(req)+"";
	}


//	@Override
//	public List<CustomBssProductVO> pcList(String parentCodeId){
//		log.debug("=== String parentCodeId ServiceImpl ===");
//		return mngBssProductDAO.pcList(parentCodeId);
//	}

//	@Override
//	public List<CustomBssProductVO> getItemImageType(String parentCodeId){
//		return mngBssProductDAO.getItemImageType(parentCodeId);
//	}

//	@Override
//	public List<CustomBssProductVO> getCmmCode(CustomBssProductVO req){
//		return mngBssProductDAO.getCmmCode(req);
//	}

	@Override
	public String productInsert(CustomBssProductVO req) {
		return mngBssProductDAO.productInsert(req)+"";
	}
	//서비스 상품 등록
	@Override
	public String serviceInsert(CustomBssProductVO req) {
		return mngBssProductDAO.serviceInsert(req)+"";
	}

	@Override
	public String vmInsert(CustomBssProductVO req) {
		return mngBssProductDAO.vmInsert(req)+"";
	}

	@Override
	public String osInsert(CustomBssProductVO req) {
		return mngBssProductDAO.osInsert(req)+"";
	}

	@Override
	public String diskInsert(CustomBssProductVO req) {
		return mngBssProductDAO.diskInsert(req)+"";
	}

	@Override
	public String nasInsert(CustomBssProductVO req) {
		return mngBssProductDAO.nasInsert(req)+"";
	}

	@Override
	public String ipInsert(CustomBssProductVO req) {
		return mngBssProductDAO.ipInsert(req)+"";
	}

	@Override
	public String lbInsert(CustomBssProductVO req) {
		return mngBssProductDAO.lbInsert(req)+"";
	}

	@Override
	public String templateInsert(CustomBssProductVO req) {
		return mngBssProductDAO.templateInsert(req)+"";
	}

	@Override
	public String containerInsert(CustomBssProductVO req) {
		return mngBssProductDAO.containerInsert(req)+"";
	}

//	@Override
//	public String scmInsert(CustomBssProductVO req) {
//		return mngBssProductDAO.scmInsert(req)+"";
//	}
//
//	@Override
//	public String bkInsert(CustomBssProductVO req) {
//		return mngBssProductDAO.bkInsert(req)+"";
//	}
//
//	@Override
//	public String serInsert(CustomBssProductVO req) {
//		return mngBssProductDAO.serInsert(req)+"";
//	}
//
//	@Override
//	public String mcaInsert(CustomBssProductVO req) {
//		return mngBssProductDAO.mcaInsert(req)+"";
//	}

	@Override
	public int pageNum(CustomBssProductVO req) {
	    try {
	    	if(StringUtils.isNotEmpty(req.getProductSeq())){
	    		int seq = mngBssProductDAO.pageCount(req);
	    		int page = 10;
		    	return (seq/page)*page;
		    }
		} catch (Exception e) {
			log.error(e.getMessage());
		}
	    return 0;
	}

	@Override
	public List<CustomBssProductVO> excel(CustomBssProductVO req) {
		return mngBssProductDAO.listTot(req);
	}

	@Override
	public String envInsert(CustomBssProductVO req) {
		return mngBssProductDAO.envInsert(req)+"";
	}
}
