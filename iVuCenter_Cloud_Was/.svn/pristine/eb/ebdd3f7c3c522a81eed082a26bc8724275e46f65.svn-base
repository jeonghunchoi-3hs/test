package com.ivucenter.cloud.portal.bill.policy;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;
import com.ivucenter.cloud.api.openstack.connector.OpenStackRestConnector;

@Service("billPolicyService")
public class BillPolicyServiceImpl implements BillPolicyService{

    private static final Logger logger = LoggerFactory.getLogger(BillPolicyServiceImpl.class);

	@Resource(name="billPolicyDAO")
	private BillPolicyDAO dao;

	@Override
	public String getBillPolicyList(CustomBillPolicyVO req){
		List<CustomBillPolicyVO> getBillPolicyList = dao.getBillPolicyList(req);

		int recordsTotal = dao.getBillPolicyListTot(req).size();
		int recordsFiltered = recordsTotal;
		 try {
		        JsonObject jsonResponse = new JsonObject();
		        Gson gson = new Gson();

		        jsonResponse.addProperty("draw", req.getDraw());
		        jsonResponse.addProperty("recordsTotal", recordsTotal);
		        jsonResponse.addProperty("recordsFiltered", recordsFiltered);
		        jsonResponse.add("data", gson.toJsonTree(getBillPolicyList));

		        return jsonResponse.toString();
		    } catch (JsonIOException e) {
	            logger.error("JSON 처리 중 오류 발생");
		    }

		return "";
	}

	@Override
	public int cumlistTot(CustomBillPolicyVO req){
		return dao.cumlistTot(req);
	}

	@Override
	public CustomBillPolicyVO getBillPolicyView(CustomBillPolicyVO req){
		return dao.getBillPolicyView(req);
	}

	@Override
	public List<CustomBillPolicyVO> getBillItemList(CustomBillPolicyVO req){
		return dao.getBillItemList(req);
	}

	@Override
	public List<CustomBillPolicyVO> getBillTypeList(CustomBillPolicyVO req){
		return dao.getBillTypeList(req);
	}

	@Override
	public String setBillPolicy(CustomBillPolicyVO req){
		return dao.setBillPolicy(req)+"";
	}

	@Override
	public List<CustomBillPolicyVO> getBillItemSearchList(CustomBillPolicyVO req){
		return dao.getBillItemSearchList(req);
	}

	@Override
	public String setBillPolicyItem(CustomBillPolicyVO req){
		return dao.setBillPolicyItem(req)+"";
	}

	@Override
	public String setBillPolicyItemPrice(CustomBillPolicyVO req){
		return dao.setBillPolicyItemPrice(req)+"";
	}

	@Override
	public List<CustomBillPolicyVO> getOldBillPolicyInfo(CustomBillPolicyVO billPolicyvo){
		return dao.getOldBillPolicyInfo(billPolicyvo);
	}

	@Override
	public int getBillPolicyCnt(CustomBillPolicyVO req){
		return dao.getBillPolicyCnt(req);
	}
	@Override
	public int billProductCheck(CustomBillPolicyVO req){
		return dao.billProductCheck(req);
	}

	@Override
	public CustomBillPolicyVO getBillPolicyInfo(CustomBillPolicyVO req){
		return dao.getBillPolicyInfo(req);
	}

	@Override
	public String setBillPolicyEdit(CustomBillPolicyVO req){
		return dao.setBillPolicyEdit(req)+"";
	}

	@Override
	public CustomBillPolicyVO getBillItemEditVo(CustomBillPolicyVO req){
		return dao.getBillItemEditVo(req);
	}

	@Override
	public String setBillPolicyItemEdit(CustomBillPolicyVO req){
		return dao.setBillPolicyItemEdit(req)+"";
	}

	@Override
	public List<CustomBillPolicyVO> getCopyBillPolicyInfo(CustomBillPolicyVO billPolicyvo){
		return dao.getCopyBillPolicyInfo(billPolicyvo);
	}

	@Override
	public List<CustomBillPolicyVO> excel(CustomBillPolicyVO req) {
		return dao.getBillPolicyListTot(req);
	}
	@Override
	public List<CustomBillPolicyVO> detailExcel(CustomBillPolicyVO req) {
		return dao.getBillItemList(req);
	}

	@Override
	public String billProductInsert(CustomBillPolicyVO req){
		return dao.billProductInsert(req)+"";
	}
	@Override
	public String billPolicyItemInsert(CustomBillPolicyVO req){
		return dao.billPolicyItemInsert(req)+"";
	}
	@Override
	public String billProductCatalogItemInsert(CustomBillPolicyVO req){
		return dao.billProductCatalogItemInsert(req)+"";
	}

}
