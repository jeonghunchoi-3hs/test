package com.ivucenter.cloud.portal.bss.adjustment;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang.time.DateFormatUtils;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service("BssAdjustmentService")
public class BssAdjustmentServiceImpl implements BssAdjustmentService{

	@Resource(name="bssAdjustmentDAO")
	private BssAdjustmentDAO bssAdjustmentDAO;
	
	@Override
	public String list(CustomBssAdjustmentVO req){
		req.setSearchBillYyyyMm(req.getBillYyyy()+req.getBillMm());
		if(!req.getKeyword().equals("")){	
			if(req.getSearchKind().equals("projectName")){
				CustomBssAdjustmentVO getProjectName = bssAdjustmentDAO.getProjectName(req);
				req.setProjectId(getProjectName.getProjectId());
			}
		}
		List<CustomBssAdjustmentVO> getBssAdjustmentList = bssAdjustmentDAO.list(req);
		int recordsTotal = bssAdjustmentDAO.listTot(req).size();
		int recordsFiltered = recordsTotal;
		
		try {
	        JsonObject jsonResponse = new JsonObject();
	        Gson gson = new Gson();
	        
	        jsonResponse.addProperty("draw", req.getDraw());
	        jsonResponse.addProperty("recordsTotal", recordsTotal);
	        jsonResponse.addProperty("recordsFiltered", recordsFiltered);
	        jsonResponse.add("data", gson.toJsonTree(getBssAdjustmentList));
	        
	        return jsonResponse.toString();
	    } catch (JsonIOException e) {
	        log.error(e.getMessage());
	    }
		return "";
	}
	
	@Override
	public List<CustomBssAdjustmentVO> excel(CustomBssAdjustmentVO req) {
		req.setSearchBillYyyyMm(req.getBillYyyy()+req.getBillMm());
		if(!req.getKeyword().equals("")){	
			if(req.getSearchKind().equals("projectName")){
				CustomBssAdjustmentVO getProjectName = bssAdjustmentDAO.getProjectName(req);
				req.setProjectId(getProjectName.getProjectId());
			}
		}
		return bssAdjustmentDAO.listTot(req);
	}
	
	@Override
	public String insert(CustomBssAdjustmentVO req){
		req.setAdjustSeq(DateFormatUtils.format(new Date(), "yyyyMMddHHmmss"));
		
		String adjustAmount = "";
		if(req.getSigntxt().equals("1")){ adjustAmount = "+"+req.getAdjustAmount(); }
		else if(req.getSigntxt().equals("2")){ adjustAmount = "-"+req.getAdjustAmount(); }
		else if(req.getSigntxt().equals("3")){ adjustAmount = "+"+req.getAdjustAmount()+"%"; }
		else if(req.getSigntxt().equals("4")){ adjustAmount = "-"+req.getAdjustAmount()+"%"; }
		
		req.setAdjustAmount(adjustAmount);
		req.setBillYyyymm(req.getBillYyyymm().replace("-",""));
		return bssAdjustmentDAO.insert(req)+"";
	}
	@Override
	public String update(CustomBssAdjustmentVO req){
		String adjustAmount = "";
		if(req.getSigntxt().equals("1")){ adjustAmount = "+"+req.getAdjustAmount().replace(",", ""); }
		else if(req.getSigntxt().equals("2")){ adjustAmount = "-"+req.getAdjustAmount().replace(",", ""); }
		else if(req.getSigntxt().equals("3")){ adjustAmount = "+"+req.getAdjustAmount().replace(",", "")+"%"; }
		else if(req.getSigntxt().equals("4")){ adjustAmount = "-"+req.getAdjustAmount().replace(",", "")+"%"; }
		
		// 수정 시 재정산 할 수 있도록 flag값 초기화
		req.setBillFlag("N");
		
		req.setAdjustAmount(adjustAmount);
		return bssAdjustmentDAO.update(req)+"";
	}
	@Override
	public String delete(CustomBssAdjustmentVO req){
		return bssAdjustmentDAO.delete(req)+"";
	}
	
	@Override
	public CustomBssAdjustmentVO detail(CustomBssAdjustmentVO req){
		return bssAdjustmentDAO.detail(req);
	}
	@Override
	public List<CustomBssAdjustmentVO> getBillYyyy(){
		return bssAdjustmentDAO.getBillYyyy();
	}
	
	@Override
	public List<CustomBssAdjustmentVO> getBillMasterYyyymmList(){
		List<CustomBssAdjustmentVO> billYyyyMmList = bssAdjustmentDAO.getBillMasterYyyymmList();
		
		for(int i=0; i < billYyyyMmList.size() ; i++){
			String billYy = billYyyyMmList.get(i).getBillYyyymm().substring(0, 4);
			String billMm = billYyyyMmList.get(i).getBillYyyymm().substring(4, 6);
			
			billYyyyMmList.get(i).setBillYyyy(billYy);
			billYyyyMmList.get(i).setBillMm(billMm);
		}
		
		return billYyyyMmList;
	}
	
	
	
/*	
	
	@Override
	public List<CustomBssAdjustmentVO> getProjectList(CustomBssAdjustmentVO projectvo){
		return bssAdjustmentDAO.getProjectList(projectvo);
	}

	
	@Override
	public CustomBssAdjustmentVO getApprovalCheck(CustomBssAdjustmentVO req){
		return bssAdjustmentDAO.getApprovalCheck(req);
	}
	
	@Override
	public CustomBssAdjustmentVO getProjectName(CustomBssAdjustmentVO req){
		return bssAdjustmentDAO.getProjectName(req);
	}
	

*/


}
