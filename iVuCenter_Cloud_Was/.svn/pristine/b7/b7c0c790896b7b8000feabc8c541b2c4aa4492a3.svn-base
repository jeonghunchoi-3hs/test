package com.ivucenter.cloud.portal.cmm.customer;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;
import com.ivucenter.cloud.portal.req.customer.CustomReqCustomerVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class CmmCustomerService{

	@Autowired
	private CmmCustomerDAO dao;
	
	public String list(CustomCmmCustomerVO req){
    	if(req.getSearchKind().equals("companyRep") && req.getKeyword() != ""){ req.setKeyword(req.getCompanyRepEnc()); }
		List<CustomCmmCustomerVO> lists = dao.list(req);
		int recordsTotal = dao.listTot(req).size();
		int recordsFiltered = recordsTotal;
		
		List<CustomCmmCustomerVO> list = new LinkedList<CustomCmmCustomerVO>();
		for(CustomCmmCustomerVO vo : lists){
			vo.setCompanyRep(vo.getCompanyRepDec());
			vo.setManagerPhone(vo.getManagerPhoneDec());
			vo.setManagerTel(vo.getManagerTelDec());
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
			log.error(e.getMessage());
		}

		return "";
	}
	
	public List<CustomCmmCustomerVO> listAll(){
		List<CustomCmmCustomerVO> lists = dao.listAll();
	    List<CustomCmmCustomerVO> list = new LinkedList<CustomCmmCustomerVO>();
		for(CustomCmmCustomerVO vo : lists){
			vo.setCompanyRep(vo.getCompanyRepDec());
			vo.setManagerPhone(vo.getManagerPhoneDec());
			vo.setManagerTel(vo.getManagerTelDec());
			list.add(vo);
    	}
		return list;
	}
	
	public CustomCmmCustomerVO detail(CustomCmmCustomerVO req) {
		CustomCmmCustomerVO vo = dao.detail(req);  
   		vo.setCompanyRep  (vo.getCompanyRepDec());
   		vo.setManagerMail (vo.getManagerMailDec());
   		vo.setManagerTel  (vo.getManagerTelDec());
   		vo.setManagerTelEx(vo.getManagerTelExDec());
   		vo.setManagerPhone(vo.getManagerPhoneDec());
		return vo;
	}

	public String insert(CustomCmmCustomerVO req) {
   		req.setCompanyRep(req.getCompanyRepEnc());
		return dao.insert(req)+"";
	}

	public String update(CustomCmmCustomerVO req) {
   		req.setCompanyRep(req.getCompanyRepEnc());
		return dao.update(req)+"";
	}

	public String customerInfoUpdate(CustomCmmCustomerVO req) {
		return dao.customerInfoUpdate(req)+"";
	}

	public String delete(CustomCmmCustomerVO req) {
		return dao.delete(req)+"";
	}
	//회원사에 등록된 프로젝트 확인
	public int customerProjectcnt(CustomReqCustomerVO req) {		
		return dao.customerProjectcnt(req);
	}

	
	public CustomCmmCustomerVO getCustomerInfo(CustomCmmCustomerVO req) {
		return dao.getCustomerInfo(req);
	}
	
	public String setSearchResult(CustomCmmCustomerVO req) {
		return dao.setSearchResult(req)+"";
	}


	public CustomCmmCustomerVO getCustomerInfopw(CustomCmmCustomerVO req) {
		return dao.getCustomerInfopw(req);
	}


	public String setUserInfo(CustomCmmCustomerVO getUserInfo) {
		return dao.setUserInfo(getUserInfo)+"";
	}


	public int getCustomerexprcnt(CustomCmmCustomerVO req) {
		return dao.getCustomerexprcnt(req);
	}


	public String customerInfoUpdatepw(CustomCmmCustomerVO req) {
		return dao.customerInfoUpdatepw(req)+"";
	}


	public List<CustomCmmCustomerVO> vatRateList() {
		return dao.vatRateList();
	}


	public List<CustomCmmCustomerVO> getCustomerMemberList(CustomCmmCustomerVO req) {
		return dao.getCustomerMemberList(req);
	}


	public String customerInsert(CustomCmmCustomerVO req) {
   		req.setCompanyRep(req.getCompanyRepEnc());
		return dao.customerInsert(req)+"";
	}

	public String setCustomadminInsert(CustomCmmCustomerVO req) {
		dao.setUserCustomadminInsert(req);
		return dao.setCustomadminInsert(req)+"";
	}

	public String customerEdit(CustomCmmCustomerVO req) {
   		req.setCompanyRep(req.getCompanyRepEnc());
		return dao.customerEdit(req)+"";
	}


	public CustomCmmCustomerVO detailManagerId(CustomCmmCustomerVO req) {
		CustomCmmCustomerVO res = dao.detailManagerId(req);  
   		res.setCompanyRep(res.getCompanyRepDec());
		return VoToDec(res);
	}
	
	
	public CustomCmmCustomerVO VoToDec(CustomCmmCustomerVO vo){
		if(vo != null){
			vo.setUserPhone(vo.getUserPhoneDec());
			vo.setUserTel(vo.getUserTelDec());
			vo.setUserMail(vo.getUserMailDec());
			vo.setManagerPhone(vo.getManagerPhoneDec());			
			vo.setManagerTel(vo.getManagerTelDec());
		}
		return vo;
	}
	
	public CustomCmmCustomerVO VoToEnc(CustomCmmCustomerVO vo){
		if(vo != null){
			vo.setUserPhone(vo.getUserPhoneEnc());
			vo.setUserTel(vo.getUserTelEnc());
			vo.setUserMail(vo.getUserMailEnc());
			vo.setManagerPhone(vo.getManagerPhoneEnc());
			vo.setManagerTel(vo.getManagerTelDec());
		}
		return vo;
	}

	public String userList(CustomCmmCustomerVO req) {
    	List<CustomCmmCustomerVO> lists = dao.userList(req);
	    int recordsTotal = dao.userListTot(req);
	    int recordsFiltered = recordsTotal;
	    
		List<CustomCmmCustomerVO> list = new LinkedList<CustomCmmCustomerVO>();
		for(CustomCmmCustomerVO vo : lists){
			list.add(VoToDec(vo));
		}
		
	    for(int i=0;i<lists.size();i++){
	    	//프로젝트 관리자
			if(lists.get(i).getUserAuthority().charAt(12) == '1'){
				lists.get(i).setAuthority1("O");
			}
			//회계담당
			if(lists.get(i).getUserAuthority().charAt(11) == '1'){
				lists.get(i).setAuthority2("O");
			}
			//일반 사용자
			if(lists.get(i).getUserAuthority().charAt(15) == '1'){
				lists.get(i).setAuthority3("O");
			}
			//회원사 담당자
			if(lists.get(i).getUserAuthority().charAt(8) == '1'){
				lists.get(i).setAuthority0("O");
			}
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
	    	log.error(e.getMessage());
	    }
		return "";
	}


	public CustomCmmCustomerVO detailUser(CustomCmmCustomerVO req) {
		return VoToDec(dao.detailUser(req));
	}


	public String editUser(CustomCmmCustomerVO req) {
		return dao.editUser(VoToEnc(req))+"";
	}


	public CustomCmmCustomerVO setManageridChk(CustomCmmCustomerVO req) {
		return dao.setManageridChk(req);
	}


	public CustomCmmCustomerVO getuserAuthView(CustomCmmCustomerVO manageridChk) {
		return dao.getuserAuthView(manageridChk);
	}


	public String setuserAuthChg(CustomCmmCustomerVO userAuthView) {
		return dao.setuserAuthChg(userAuthView)+"";
	}
	
	
	// Chart 최근3개월 청구금액
	public List<CustomCmmCustomerVO> get3MonthAmount2(CustomCmmCustomerVO req, Model model){
		return dao.get3MonthAmount(req);
	}
	public void get3MonthAmount(CustomCmmCustomerVO req, Model model){
		log.debug("==========get3MonthAmount");
		StringBuffer sb = new StringBuffer();
		StringBuffer sb2 = new StringBuffer();
		sb.append("[{");
		sb.append("data:[");
		
		sb2.append("[");
		
		List<CustomCmmCustomerVO> list = dao.get3MonthAmount(req);
		
		if(list != null){
			int index = 0;
			for(int i=0; i<list.size(); i++){
				sb.append("{y:"+list.get(i).getAmount()+",color:colors["+i+"]}");
				index++;
				if(index < list.size()){
					sb.append(",");
				}
				
				sb2.append("'"+list.get(i).getBillYyyymm()+"'");
				if(index < list.size()){
					sb2.append(",");
				}
			}
		}
		sb2.append("]");
		sb.append("],");
		sb.append("dataLabels : {formatter : function(){return addcomma(this.y)+'원';},style:{fontSize : '13px'}}");
		sb.append("}]");
		
		model.addAttribute("get3MonthAmount", sb.toString());
		model.addAttribute("get3Yyyymm", sb2.toString());
		
	}
	
	public HashMap<String, String> get3MonthAmount3(CustomCmmCustomerVO req, Model model){
		log.debug("==========get3MonthAmount3");
		
		HashMap<String, String> map = new HashMap<>();
		StringBuffer sb = new StringBuffer();
		StringBuffer sb2 = new StringBuffer();
		
//		sb.append("[{");
//		sb.append("data:[");

		sb.append("[");

		
		sb2.append("[");
		log.debug("BillYyyymm : " + req.getBillYyyymm());
		List<CustomCmmCustomerVO> list = dao.get3MonthAmount(req);
		
		String [] colors = new String[]{"#ecdb69", "#a591d9", "#7ece55"};
		
		if(list != null){
			int index = 0;
			
//			for(int i=list.size(); i<3; i++){
//				CustomCmmCustomerVO tmp = new CustomCmmCustomerVO();
//				tmp.setAmount("0");
//				list.add(tmp);
//			}	
			
			for(int i=0; i<list.size(); i++){
				
				sb.append("{y:"+list.get(i).getAmount()+",'color':'"+colors[i]+"'}");
				index++;
				if(index < list.size()){
					sb.append(",");
				}
				
				sb2.append("'"+list.get(i).getBillYyyymm()+"'");
				if(index < list.size()){
					sb2.append(",");
				}
			}
		}
		sb2.append("]");
		sb.append("]");
//		sb.append("],");
//		sb.append("dataLabels : {formatter : function(){return addcomma(this.y)+'원';},style:{fontSize : '13px'}}");
//		sb.append("}]");
		
		map.put("get3MonthAmount", sb.toString());
		map.put("get3Yyyymm", sb2.toString());
		
		return map;
	}
	
	
	// 청구예상금액 당월 사용금액
	public CustomCmmCustomerVO getCurrentAmount(CustomCmmCustomerVO req){
		return dao.getCurrentAmount(req);
	}
	// Chart 리소스별 총사용량
	public CustomCmmCustomerVO getResourceTotalAmount2(CustomCmmCustomerVO req, Model model){
		return dao.getResourceTotalAmount(req);
	}
	public void getResourceTotalAmount(CustomCmmCustomerVO req, Model model){
		CustomCmmCustomerVO res = new CustomCmmCustomerVO();
		res = dao.getResourceTotalAmount(req);
		
		StringBuffer sb1 = new StringBuffer();
		StringBuffer sb2 = new StringBuffer();
		StringBuffer sb3 = new StringBuffer();
		StringBuffer sb4 = new StringBuffer();
		
		if(res != null){
			//sb.append("[");
			sb1.append("{drilldown: {name: 'SERVER', categories: ['SERVER'], data: ["+res.getServerCnt()+"], color: colors[0]}}"); 
			sb2.append("{drilldown: {name: 'vCPU', categories: ['vCPU'], data: ["+res.getVcpus()+"], color: colors[1]}}"); 
			sb3.append("{drilldown: {name: 'MEM', categories: ['MEM'], data: ["+res.getMemGb()+"], color: colors[2]}}"); 
			sb4.append("{drilldown: {name: 'DISK', categories: ['DISK'], data: ["+res.getDiskGb()+"], color: colors[3]}}");
			//sb.append("]");
		}else{
			sb1.append("{drilldown: {name: 'SERVER', categories: ['SERVER'], data: [0], color: colors[0]}}"); 
			sb2.append("{drilldown: {name: 'vCPU', categories: ['vCPU'], data: [0], color: colors[1]}}"); 
			sb3.append("{drilldown: {name: 'MEM', categories: ['MEM'], data: [0], color: colors[2]}}"); 
			sb4.append("{drilldown: {name: 'DISK', categories: ['DISK'], data: [0], color: colors[3]}}");
		}
		model.addAttribute("getResourceTotalAmount1", sb1.toString());
		model.addAttribute("getResourceTotalAmount2", sb2.toString());
		model.addAttribute("getResourceTotalAmount3", sb3.toString());
		model.addAttribute("getResourceTotalAmount4", sb4.toString());
	}

	public int companyNoChk(CustomCmmCustomerVO req) {
		return dao.companyNoChk(req);
	}
	
	public List<CustomCmmCustomerVO> upCompanyList(){
		return dao.upCompanyList();
	}
	
	public List<CustomCmmCustomerVO> companySelectList(CustomCmmCustomerVO req){
		return dao.companySelectList(req);	
	}
	
	public List<CustomCmmCustomerVO> getCompanyList(CustomCmmCustomerVO req){
		return dao.companyList(req);	
	}
	
	public List<CustomCmmCustomerVO> getCompanyFullList(CustomCmmCustomerVO req){
		return dao.getCompanyFullList(req);	
	}

	public List<CustomCmmCustomerVO> vatRateExcel(CustomCmmCustomerVO req) {
		return dao.listTot(req);
	}

	public String vatRateEdit(CustomCmmCustomerVO req) {
		return dao.vatRateEdit(req)+"";
	}

	public List<CustomCmmCustomerVO> excel(CustomCmmCustomerVO req) {
		return dao.listTot(req);
	}
}
