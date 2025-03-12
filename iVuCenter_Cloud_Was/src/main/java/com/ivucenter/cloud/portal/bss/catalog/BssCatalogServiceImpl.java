package com.ivucenter.cloud.portal.bss.catalog;

import java.util.Date;
import java.util.LinkedList;
import java.util.List;

import org.apache.commons.lang.time.DateFormatUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;
import com.ivucenter.cloud.portal.bill.policy.BillPolicyDAO;
import com.ivucenter.cloud.portal.bill.policy.CustomBillPolicyVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class BssCatalogServiceImpl implements BssCatalogService{

    private static final Logger logger = LoggerFactory.getLogger(BssCatalogServiceImpl.class);

	@Autowired
	private BssCatalogDAO mngCatalogDAO;

	@Autowired
	private BillPolicyDAO billPolicyDAO;


	//pho getProjectList
	@Override
	public String list(CustomBssCatalogVO req) {
	    int recordsTotal; // �� ��
	    int recordsFiltered;	// �˻� �� ��

    	List<CustomBssCatalogVO> lists = mngCatalogDAO.list(req);
	    recordsTotal = mngCatalogDAO.listTot(req).size();
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
	        log.error(e.getMessage());
	    }
		return "";
	}

	@Override
	public List<CustomBssCatalogVO> getCatalogueProductList(CustomBssCatalogVO catal){
	return mngCatalogDAO.getCatalogueProductList(catal);
	}

	@Override
	public List<CustomBssCatalogVO> getCatalogueProductOsList(CustomBssCatalogVO catal){
	return mngCatalogDAO.getCatalogueProductOsList(catal);
	}

	@Override
	public List<CustomBssCatalogVO> getCatalogueProductDiskList(CustomBssCatalogVO catal){
	return mngCatalogDAO.getCatalogueProductDiskList(catal);
	}

	@Override
	public List<CustomBssCatalogVO> getCatalogueProductNasList(CustomBssCatalogVO catal){
	return mngCatalogDAO.getCatalogueProductNasList(catal);
	}

	@Override
	public List<CustomBssCatalogVO> getCatalogueProductPublicIpList(CustomBssCatalogVO catal){
	return mngCatalogDAO.getCatalogueProductPublicIpList(catal);
	}

	@Override
	public List<CustomBssCatalogVO> getCatalogueProductLbList(CustomBssCatalogVO catal){
	return mngCatalogDAO.getCatalogueProductLbList(catal);
	}

//	@Override
//	public List<CustomBssCatalogVO> getCatalogueProductScmList(CustomBssCatalogVO catal){
//	log.debug("=== getCatalogueProductScmList Service ===");
//	return mngCatalogDAO.getCatalogueProductScmList(catal);
//	}

//	@Override
//	public List<CustomBssCatalogVO> getCatalogueProductBackupList(CustomBssCatalogVO catal){
//	log.debug("=== getCatalogueProductBackupList Service ===");
//	return mngCatalogDAO.getCatalogueProductBackupList(catal);
//	}

	@Override
	public List<CustomBssCatalogVO> getCatalogueProductServiceList(CustomBssCatalogVO catal){
		log.debug("=== getCatalogueProductServiceList Service ===");
		return mngCatalogDAO.getCatalogueProductServiceList(catal);
	}

//	@Override
//	public List<CustomBssCatalogVO> getCatalogueProductSercurityList(CustomBssCatalogVO catal){
//	log.debug("=== getCatalogueProductSercurityList Service ===");
//	return mngCatalogDAO.getCatalogueProductSercurityList(catal);
//	}

//	@Override
//	public List<CustomBssCatalogVO> getCatalogueProductMcaList(CustomBssCatalogVO catal){
//	log.debug("=== getCatalogueProductMcaList Service ===");
//	return mngCatalogDAO.getCatalogueProductMcaList(catal);
//	}

	@Override
	public CustomBssCatalogVO productView(CustomBssCatalogVO req){
		log.debug("=== getCatalogueProductList Service ===");
	return mngCatalogDAO.productView(req);
	}
	@Override
	public CustomBssCatalogVO osView(CustomBssCatalogVO req){
		log.debug("=== osView Service ===");
	return mngCatalogDAO.osView(req);
	}

	@Override
	public CustomBssCatalogVO detail(String catalogSeq){
		log.debug("=== getCatalogueProductList Service ===");
	return mngCatalogDAO.detail(catalogSeq);
	}
	@Override
	public CustomBssCatalogVO catalogDetail(String catalogSeq){
		log.debug("=== catalogDetail Service ===");
	return mngCatalogDAO.catalogDetail(catalogSeq);
	}
	@Override
	public String update(CustomBssCatalogVO req) {
		return mngCatalogDAO.update(req)+"";
	}


	@Override
	public String osUpdate(CustomBssCatalogVO req) {
		return mngCatalogDAO.osUpdate(req)+"";
	}

	@Override
	public String productInsert(CustomBssCatalogVO req) {
		return mngCatalogDAO.productInsert(req)+"";
	}
	@Override
	public String osInsert(CustomBssCatalogVO req) {
		return mngCatalogDAO.osInsert(req)+"";
	}
	@Override
	public String appInsert(CustomBssCatalogVO req) {
		return mngCatalogDAO.appInsert(req)+"";
	}
	@Override
	public String diskInsert(CustomBssCatalogVO req) {
		return mngCatalogDAO.diskInsert(req)+"";
	}
	@Override
	public String nasInsert(CustomBssCatalogVO req) {
		return mngCatalogDAO.nasInsert(req)+"";
	}
	@Override
	public String ipInsert(CustomBssCatalogVO req) {
		return mngCatalogDAO.ipInsert(req)+"";
	}
	@Override
	public String lbInsert(CustomBssCatalogVO req) {
		return mngCatalogDAO.lbInsert(req)+"";
	}
//	@Override
//	public String scmInsert(CustomBssCatalogVO req) {
//		return mngCatalogDAO.scmInsert(req)+"";
//	}
//	@Override
//	public String bkInsert(CustomBssCatalogVO req) {
//		return mngCatalogDAO.bkInsert(req)+"";
//	}
	@Override
	public String serviceInsert(CustomBssCatalogVO req) {
		return mngCatalogDAO.serviceInsert(req)+"";
	}
//	@Override
//	public String serInsert(CustomBssCatalogVO req) {
//		return mngCatalogDAO.serInsert(req)+"";
//	}
//	@Override
//	public String mcaInsert(CustomBssCatalogVO req) {
//		return mngCatalogDAO.mcaInsert(req)+"";
//	}

	//가상머신 popup
	@Override
	public List<CustomBssCatalogVO> productPopList(CustomBssCatalogVO req){
		log.debug("=== productPopList Service ===");
		return mngCatalogDAO.productPopList(req);
	}
	//os popup
	@Override
	public List<CustomBssCatalogVO> osPopList(CustomBssCatalogVO req){
		log.debug("=== osPopList Service ===");
		return mngCatalogDAO.osPopList(req);
	}
	//template pop
	@Override
	public List<CustomBssCatalogVO> templatePopList(CustomBssCatalogVO req){
		log.debug("=== osPopList Service ===");
		return mngCatalogDAO.templatePopList(req);
	}

	//서비스 popup
	@Override
	public List<CustomBssCatalogVO> servicePopList(CustomBssCatalogVO req){
		log.debug("=== osPopList Service ===");
		return mngCatalogDAO.servicePopList(req);
	}

	//os popup
	@Override
	public List<CustomBssCatalogVO> diskPopList(CustomBssCatalogVO req){
		log.debug("=== diskPopList Service ===");
		return mngCatalogDAO.diskPopList(req);
	}
	//os popup
	@Override
	public List<CustomBssCatalogVO> nasPopList(CustomBssCatalogVO req){
		log.debug("=== nasPopList Service ===");
		return mngCatalogDAO.nasPopList(req);
	}
	//os popup
	@Override
	public List<CustomBssCatalogVO> ipPopList(CustomBssCatalogVO req){
		log.debug("=== ipPopList Service ===");
		return mngCatalogDAO.ipPopList(req);
	}
	//os popup
	@Override
	public List<CustomBssCatalogVO> lbPopList(CustomBssCatalogVO req){
		log.debug("=== lbPopList Service ===");
		return mngCatalogDAO.lbPopList(req);
	}

//	@Override
//	public List<CustomBssCatalogVO> scmPopList(CustomBssCatalogVO req){
//		log.debug("=== scmPopList Service ===");
//		return mngCatalogDAO.scmPopList(req);
//	}

//	@Override
//	public List<CustomBssCatalogVO> bkPopList(CustomBssCatalogVO req){
//		log.debug("=== bkPopList Service ===");
//		return mngCatalogDAO.bkPopList(req);
//	}

//	@Override
//	public List<CustomBssCatalogVO> serPopList(CustomBssCatalogVO req){
//		log.debug("=== serPopList Service ===");
//		return mngCatalogDAO.serPopList(req);
//	}

//	@Override
//	public List<CustomBssCatalogVO> mcaPopList(CustomBssCatalogVO req){
//		log.debug("=== mcaPopList Service ===");
//		return mngCatalogDAO.mcaPopList(req);
//	}

	//카탈로그 복사 관련 전 카탈로그 정보 체크
	public List<CustomBssCatalogVO> getOldCataloginfo(String applyDate){
		return mngCatalogDAO.getOldCataloginfo(applyDate);
	}
	//카탈로그 복사 관련 전 카탈로그 정보 체크
	public List<CustomBssCatalogVO> getCopyCataloginfo(String catalogSeq){
		return mngCatalogDAO.getCopyCataloginfo(catalogSeq);
	}

	@Override
	public String productDisplayUpdate(CustomBssCatalogVO req) {
		return mngCatalogDAO.productDisplayUpdate(req)+"";
	}

	@Override
	public String productDelchk(CustomBssCatalogVO req) {
		return mngCatalogDAO.productDelchk(req)+"";
	}

	//DataTable 용
	//카테고리상세 상품 리스트
	public String catalogueProductList(CustomBssCatalogVO req){
		int recordsTotal;
	    int recordsFiltered;

    	List<CustomBssCatalogVO> lists = mngCatalogDAO.catalogueProductList(req);
	    recordsTotal = mngCatalogDAO.catalogueProductListTot(req).size();
	    recordsFiltered = recordsTotal;

	    List<CustomBssCatalogVO> list = new LinkedList<CustomBssCatalogVO>();

	    for(CustomBssCatalogVO vo : lists){
	    	String html = "";
	    	String k = vo.getDisplayOrder();
	    	int j = Integer.parseInt(k);

	    	html += "<div class='selectBox' style='width:75px;'>";
	    	html += "<label class='selectText' for='"+vo.getProductSeq()+"'>"+j+"</label>";
			html += "<select class='search-sel' id='"+vo.getProductSeq()+"' onchange='updateDisplayOrder(this);'>";
	    	for(int i=0; i < recordsTotal; i++){

	    		if(j==i){
	    			html += "<option value='"+i+"' selected='selected'>"+i+"</option>";
	    		}else{
	    			html += "<option value='"+i+"'>"+i+"</option>";
	    		}
	    	}
	    	html += "</select>";
	    	html += "</div>";
	    	vo.setSelectHtml(html);
	    	list.add(vo);
	    }

	    try {
	        JsonObject jsonResponse = new JsonObject();
	        Gson gson = new Gson();

	        jsonResponse.addProperty("draw", req.getDraw());
	        jsonResponse.addProperty("recordsTotal", recordsTotal);
	        jsonResponse.addProperty("recordsFiltered", recordsFiltered);
	        jsonResponse.add("data", gson.toJsonTree(list));

	        return jsonResponse.toString();
	    } catch (JsonIOException e) {
            logger.error("JSON 처리 중 오류 발생");
	    }
		return "";
	}

	public List<CustomBssCatalogVO> catalogueProductExcel(CustomBssCatalogVO req){
		return mngCatalogDAO.catalogueProductListTot(req);
	}

	@Override
	public String updateDisplayOrder(CustomBssCatalogVO req){
		log.debug("=== updateDisplayOrder Service ===");
		return mngCatalogDAO.updateDisplayOrder(req)+"";
	}

	@Override
	public String insert(CustomBssCatalogVO req) {
		req.setCatalogSeq(DateFormatUtils.format(new Date(), "yyyyMMddHHmmss"));
		if(mngCatalogDAO.getCatalogCnt(req) == 0){
			mngCatalogDAO.setCatalog(req);
			mngCatalogDAO.setCatalogProduct(req);

			CustomBillPolicyVO vo = new CustomBillPolicyVO();
			vo.setPolicySeq(req.getCatalogSeq());
			vo.setCloudId(req.getCloudId());
			vo.setPolicyName(req.getPolicyName());
			vo.setApplyDate(req.getApplyDate());
			vo.setRegUserId(req.getRegUserId());
			vo.setModUserId(req.getModUserId());
			vo.setBeforeCatalogSeq(req.getBeforeCatalogSeq());

			billPolicyDAO.setBillPolicy(vo);
			billPolicyDAO.setBillPolicyItem(vo);
			billPolicyDAO.setBillPolicyItemPrice(vo);

			return "1";
		}else{
			return "0";
		}
	}


	@Override
	public String catalogNewInsert(CustomBssCatalogVO req) {
		try {
    	    if(mngCatalogDAO.getCatalogCnt(req) == 0){
    		  req.setCatalogSeq(DateFormatUtils.format(new Date(), "yyyyMMddHHmmss"));
    		  mngCatalogDAO.setCatalogNewInsert(req);

	    	    return "1";
	  		}else{
	  			return "2";
	  		}
		} catch (Exception e) {
            logger.error("catalogNewInsert Exception");
		return "0";
		}
	}


	@Override
	public int getDisplayOrderCount(CustomBssCatalogVO req){
		return mngCatalogDAO.getDisplayOrderCount(req);
	}


	@Override
	public String delete(CustomBssCatalogVO req){
		try {
			mngCatalogDAO.catalogDelOk(req);
			mngCatalogDAO.catalogPproductDelete(req);

			CustomBillPolicyVO vo = new CustomBillPolicyVO();
			vo.setPolicySeq(req.getCatalogSeq());
			billPolicyDAO.delete(vo);
			billPolicyDAO.deleteItem(vo);
			billPolicyDAO.deleteItemPrice(vo);

			return "1";
		} catch (Exception e) {
            logger.error("delete Exception");
			return "0";
		}
	}


	@Override
	public String catalogProductDelete(CustomBssCatalogVO req){
		try {
			mngCatalogDAO.catalogProductDelete(req);

			return "1";
		} catch (Exception e) {
            logger.error("catalogProductDelete Exception");
			return "0";
		}
	}



	@Override
	public String catalogUpdate(CustomBssCatalogVO req) {
		try {
			mngCatalogDAO.catalogUpdate(req);


			CustomBillPolicyVO vo = new CustomBillPolicyVO();
			vo.setPolicySeq(req.getCatalogSeq());
			vo.setPolicyName(req.getPolicyName());
			vo.setApplyDate(req.getApplyDate());
			vo.setRegUserId(req.getRegUserId());
			vo.setModUserId(req.getModUserId());
			billPolicyDAO.setBillPolicyEdit(vo);

			return "1";
		} catch (Exception e) {
            logger.error("catalogUpdate Exception");
			return "0";
		}
	}

	@Override
	public List<CustomBssCatalogVO> excel(CustomBssCatalogVO req) {
		return mngCatalogDAO.listTot(req);
	}

	@Override
	public List<CustomBssCatalogVO> envPopList(CustomBssCatalogVO req) {
		log.debug("=== envPopList Service ===");
		return mngCatalogDAO.envPopList(req);
	}

	@Override
	public String envInsert(CustomBssCatalogVO req) {
		return mngCatalogDAO.envInsert(req)+"";
	}
}
