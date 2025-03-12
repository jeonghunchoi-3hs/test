package com.ivucenter.cloud.portal.charge.bill;

import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service("ChargeBillService")
public class ChargeBillServieceImpl implements ChargeBillService{

    private static final Logger logger = LoggerFactory.getLogger(ChargeBillServieceImpl.class);

	@Autowired
	private ChargeBillDAO dao;

	@Override
	public String list(CustomChargeBillVO req) {
		int recordsTotal;
	    int recordsFiltered;

		List<CustomChargeBillVO> lists = dao.list(req);
		recordsTotal = dao.listTot(req);
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
			log.error(e.getMessage());
		}
		return "";
	}


	@Override
	public String listMng(CustomChargeBillVO req) {
		int recordsTotal;
	    int recordsFiltered;

		List<CustomChargeBillVO> lists = dao.listMng(req);
		recordsTotal = dao.listMngTot(req).size();
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
			log.error(e.getMessage());
		}
		return "";
	}

	@Override
	public String listMngProject(CustomChargeBillVO req) {
		int recordsTotal;
	    int recordsFiltered;

		List<CustomChargeBillVO> lists = dao.listMngProject(req);

		recordsTotal = dao.listMngProjectTot(req).size();
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
			log.error(e.getMessage());
		}
		return "";
	}

	@Override
	public String getProjectBillList(CustomChargeBillVO req) {
		int recordsTotal;
	    int recordsFiltered;

		List<CustomChargeBillVO> lists = dao.getProjectBillList(req);
		recordsTotal = dao.getProjectBillListTot(req);
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
			log.error(e.getMessage());
		}
		return "";
	}



	@Override
	public CustomChargeBillVO getBillDate(CustomChargeBillVO req){
		return dao.getBillDate(req);
	}
	@Override
	public CustomChargeBillVO getUserCustomerId(CustomChargeBillVO req){
		return dao.getUserCustomerId(req);
	}

	@Override
	public List<CustomChargeBillVO> view(CustomChargeBillVO req){
		return dao.view(req);
	}

	@Override
	public HashMap<String, String> view2(CustomChargeBillVO req, Model model){
		List<CustomChargeBillVO> list = dao.view(req);
		HashMap<String, String> map = new HashMap<>();
		StringBuffer sb = new StringBuffer();
		StringBuffer sb2 = new StringBuffer();
		String strSb = "";
		String strSb2 = "";

		if(list != null){
			sb.append("[");
			sb2.append("[");
			int index = 0;
			for(int i=0; i<list.size(); i++){
				index++;
				if(list.get(i).getInvoiceItem().equals("AA00")){
//					sb.append("{'name': '기본상품', 'y': "+list.get(i).getAmount()+", 'color': '#ac5fbd'}");
					sb.append("{'name': '기본상품', 'y': "+list.get(i).getAmount()+", 'color': '#6396e5'}");
					sb2.append("'기본상품'");
					if(index < list.size()){
						sb.append(",");
						sb2.append(",");
					}
				}else if(list.get(i).getInvoiceItem().equals("AE00")){
					sb.append("{'name': '부가상품', 'y': "+list.get(i).getAmount()+", 'color': '#30f6e7'}");
					sb2.append("'부가상품'");
					if(index < list.size()){
						sb.append(",");
						sb2.append(",");
					}
				}else if(list.get(i).getInvoiceItem().equals("AI00")){
					sb.append("{'name': '서비스', 'y': "+list.get(i).getAmount()+", 'color': '#e84971'}");
					sb2.append("'서비스'");
					if(index < list.size()){
						sb.append(",");
						sb2.append(",");
					}
				}

			}
			strSb = sb.toString().substring(0, sb.toString().length()-1);
			strSb2 = sb2.toString().substring(0, sb2.toString().length()-1);

		}
		log.debug(strSb);
		log.debug(strSb2+"]");

		map.put("getProduct", strSb+"]");
		map.put("getCategory", strSb2+"]");

		return map;
	}

	@Override
	public List<CustomChargeBillVO> projectBillView(CustomChargeBillVO req){
		return dao.projectBillView(req);
	}

	@Override
	public CustomChargeBillVO getCustomerId(CustomChargeBillVO req){
		return dao.getCustomerId(req);
	}

	@Override
	public List<CustomChargeBillVO> projectList(CustomChargeBillVO req){
		return dao.projectList(req);
	}
	@Override
	public List<CustomChargeBillVO> invoiceProjectList(CustomChargeBillVO req){
		return dao.invoiceProjectList(req);
	}
	@Override
	public List<CustomChargeBillVO> invoiceProjectBillDetailList(CustomChargeBillVO req){
		return dao.invoiceProjectBillDetailList(req);
	}

	@Override
	public List<CustomChargeBillVO> billCustomerDetailList(CustomChargeBillVO req){
		return dao.billCustomerDetailList(req);
	}
	@Override
	public List<CustomChargeBillVO> vmCustomerResource(CustomChargeBillVO req) {
		return dao.vmCustomerResource(req);
	}



	//-->청구서 자원 상세 start
	@Override
	public List<CustomChargeBillVO> billDetailList(CustomChargeBillVO req){
		return dao.billDetailList(req);
	}
	@Override
	public List<CustomChargeBillVO> vmResource(CustomChargeBillVO req) {
		return dao.resourceDetail(req);
	}
	@Override
	public List<CustomChargeBillVO> diskResource(CustomChargeBillVO req) {
		return dao.resourceDetail(req);
	}
	@Override
	public List<CustomChargeBillVO> nasResource(CustomChargeBillVO req) {
		return dao.resourceDetail(req);
	}
	@Override
	public List<CustomChargeBillVO> ipResource(CustomChargeBillVO req) {
		return dao.resourceDetail(req);
	}
	@Override
	public List<CustomChargeBillVO> loadbalancerResource(CustomChargeBillVO req) {
		return dao.resourceDetail(req);
	}
	@Override
	public List<CustomChargeBillVO> backupResource(CustomChargeBillVO req) {
		return dao.resourceDetail(req);
	}
	@Override
	public List<CustomChargeBillVO> mcaResource(CustomChargeBillVO req) {
		return dao.resourceDetail(req);
	}
	@Override
	public List<CustomChargeBillVO> scmResource(CustomChargeBillVO req) {
		return dao.resourceDetail(req);
	}
	@Override
	public List<CustomChargeBillVO> securityResource(CustomChargeBillVO req) {
		return dao.resourceDetail(req);
	}
	@Override
	public List<CustomChargeBillVO> resourceDetail(CustomChargeBillVO req) {
		return dao.resourceDetail(req);
	}
	@Override
	public List<CustomChargeBillVO> resourceDetail2(CustomChargeBillVO req) {
		return dao.resourceDetail2(req);
	}
	@Override
	public List<CustomChargeBillVO> resourceCustomerDetail(CustomChargeBillVO req) {
		return dao.resourceCustomerDetail(req);
	}
	@Override
	public List<CustomChargeBillVO> dcAdDetail(CustomChargeBillVO req) {
		return dao.dcAdDetail(req);
	}

	//<--청구서 자원 상세 end

	@Override
	public String salesList(CustomChargeBillVO req){
		int recordsTotal;
	    int recordsFiltered;

    	List<CustomChargeBillVO> lists = dao.salesList(req);
	    recordsTotal = dao.salesListTot(req).size();
	    recordsFiltered = recordsTotal;

	    CustomChargeBillVO billVo = dao.salesTotalAmount(req);
	    log.debug("billVo : " + billVo);
	    try {
	        JsonObject jsonResponse = new JsonObject();
	        Gson gson = new Gson();

	        jsonResponse.addProperty("draw", req.getDraw());
	        jsonResponse.addProperty("recordsTotal", recordsTotal);
	        jsonResponse.addProperty("recordsFiltered", recordsFiltered);
	        if(billVo !=null){
	        	jsonResponse.addProperty("totalAmount", billVo.getAmount());
	        }else{
	        	jsonResponse.addProperty("totalAmount", "0");
	        }
	        jsonResponse.add("data", gson.toJsonTree(lists));

	        return jsonResponse.toString();
	    } catch (JsonIOException e) {
	    	log.error(e.getMessage());
	    }
		return "";
	}

	@Override
	public CustomChargeBillVO salesView(CustomChargeBillVO req){

		return dao.salesView(req);
	}
	@Override
	public List<CustomChargeBillVO> salesViewExcel(CustomChargeBillVO req){

		return dao.salesViewExcel(req);
	}



	@Override
	public String calculateList(CustomChargeBillVO req){
		int recordsTotal;
		int recordsFiltered;

		List<CustomChargeBillVO> lists = dao.calculateList(req);
		log.debug("lists : " + lists.size());
		recordsTotal = dao.calculateListTot(req);
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
	public List<CustomChargeBillVO> calculateDetailList(CustomChargeBillVO req){
			return dao.calculateDetailList(req);
	}

	@Override
	public String updateConfirmFlag(CustomChargeBillVO req){
		return dao.updateConfirmFlag(req);
	}


	@Override
	public List<CustomChargeBillVO> excel(CustomChargeBillVO req) {
		return dao.listMngProjectTot(req);
	}

	@Override
	public int getStepAuth(CustomChargeBillVO req){
		return dao.getStepAuth(req);
	}
}
