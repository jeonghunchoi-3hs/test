package com.ivucenter.cloud.portal.home;

import java.util.Date;
import java.util.LinkedList;
import java.util.List;

import org.apache.commons.lang.time.DateFormatUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.ivucenter.cloud.portal.oss.disk.CustomStorageVO;
import com.ivucenter.cloud.portal.util.DateUtils;

@Service
public class PotalHomeService {

	@Autowired
	PotalHomeDAO potalHomeDAO;

	public CustomMbrHomeVO userReVO(CustomMbrHomeVO loginUserId) {
		return potalHomeDAO.userReVO(loginUserId);
	}

	public List<CustomMbrHomeVO> userReVOList(CustomMbrHomeVO loginUserId) {
		return potalHomeDAO.userReVOList(loginUserId);
	}

	public CustomMbrHomeVO userProcessVO(CustomMbrHomeVO loginUserId) {
		return potalHomeDAO.userProcessVO(loginUserId);
	}

	public CustomMbrHomeVO userWorkProcessVO(CustomMbrHomeVO loginUserId) {
		return potalHomeDAO.userWorkProcessVO(loginUserId);
	}

	public CustomMbrHomeVO userCompletedVO(CustomMbrHomeVO loginUserId) {
		return potalHomeDAO.userCompletedVO(loginUserId);
	}

	public CustomMbrHomeVO userRejectedVO(CustomMbrHomeVO loginUserId) {
		return potalHomeDAO.userRejectedVO(loginUserId);
	}

	public List<CustomMbrHomeVO> userApprvstateList(CustomMbrHomeVO loginUserId) {
		return potalHomeDAO.userApprvstateList(loginUserId);
	}

	public void billInvoiceByProject(Model model, CustomMbrHomeVO req) {
		StringBuffer sb = new StringBuffer();
		sb.append("[");
		
		List<CustomMbrHomeVO> list = new LinkedList<>();
		if(req.getRolechk().equals("custom") && req.getGroup().equals("all")){
			list = potalHomeDAO.billInvoiceByCustomer(req);
		}
		else if(req.getRolechk().equals("mng")){
			list = potalHomeDAO.billInvoiceByCustomer(req);
		}
		else{
			list = potalHomeDAO.billInvoiceByProject(req);	
		}
		
		if(list != null){
			int index = 0;
			for(CustomMbrHomeVO obj : list){
				sb.append("{name: '"+obj.getProjectName()+"',");
				sb.append("data: [");
				sb.append(obj.getM01()+",");
				sb.append(obj.getM02()+",");
				sb.append(obj.getM03()+",");
				sb.append(obj.getM04()+",");
				sb.append(obj.getM05()+",");
				sb.append(obj.getM06()+",");
				sb.append(obj.getM07()+",");
				sb.append(obj.getM08()+",");
				sb.append(obj.getM09()+",");
				sb.append(obj.getM10()+",");
				sb.append(obj.getM11()+",");
				sb.append(obj.getM12());
				sb.append("]}");
				index++;
				if(index < list.size()){
					sb.append(",");
				}
			}
		}
		sb.append("]");
		
		model.addAttribute("billInvoiceBy"+req.getGroup(), sb.toString());
		model.addAttribute("billInvoiceByList"+req.getGroup(), list);
		
	}

	public void billInvoiceByCategory(Model model, CustomMbrHomeVO req) {
		
		StringBuffer sb = new StringBuffer();
		sb.append("[");
		sb.append(new StringBuffer(req.getSearchMonth01()).insert(0, "'").insert(5, "/").insert(8, "',"));
		sb.append(new StringBuffer(req.getSearchMonth02()).insert(0, "'").insert(5, "/").insert(8, "',"));
		sb.append(new StringBuffer(req.getSearchMonth03()).insert(0, "'").insert(5, "/").insert(8, "',"));
		sb.append(new StringBuffer(req.getSearchMonth04()).insert(0, "'").insert(5, "/").insert(8, "',"));
		sb.append(new StringBuffer(req.getSearchMonth05()).insert(0, "'").insert(5, "/").insert(8, "',"));
		sb.append(new StringBuffer(req.getSearchMonth06()).insert(0, "'").insert(5, "/").insert(8, "',"));
		sb.append(new StringBuffer(req.getSearchMonth07()).insert(0, "'").insert(5, "/").insert(8, "',"));
		sb.append(new StringBuffer(req.getSearchMonth08()).insert(0, "'").insert(5, "/").insert(8, "',"));
		sb.append(new StringBuffer(req.getSearchMonth09()).insert(0, "'").insert(5, "/").insert(8, "',"));
		sb.append(new StringBuffer(req.getSearchMonth10()).insert(0, "'").insert(5, "/").insert(8, "',"));
		sb.append(new StringBuffer(req.getSearchMonth11()).insert(0, "'").insert(5, "/").insert(8, "',"));
		sb.append(new StringBuffer(req.getSearchMonth12()).insert(0, "'").insert(5, "/").insert(8, "'"));
		sb.append("]");
		model.addAttribute("billInvoiceByCategory", sb.toString());
		model.addAttribute("billInvoiceByCategory2", req);
	}

	public void higtChart(Model model, CustomMbrHomeVO loginUserId) {
		Date now = new Date();
		int i = -1;
		loginUserId.setSearchMonth12(DateFormatUtils.format(now, "yyyyMM"));
		loginUserId.setSearchMonth11(DateFormatUtils.format(DateUtils.addMonths(now, i--), "yyyyMM"));
		loginUserId.setSearchMonth10(DateFormatUtils.format(DateUtils.addMonths(now, i--), "yyyyMM"));
		loginUserId.setSearchMonth09(DateFormatUtils.format(DateUtils.addMonths(now, i--), "yyyyMM"));
		loginUserId.setSearchMonth08(DateFormatUtils.format(DateUtils.addMonths(now, i--), "yyyyMM"));
		loginUserId.setSearchMonth07(DateFormatUtils.format(DateUtils.addMonths(now, i--), "yyyyMM"));
		loginUserId.setSearchMonth06(DateFormatUtils.format(DateUtils.addMonths(now, i--), "yyyyMM"));
		loginUserId.setSearchMonth05(DateFormatUtils.format(DateUtils.addMonths(now, i--), "yyyyMM"));
		loginUserId.setSearchMonth04(DateFormatUtils.format(DateUtils.addMonths(now, i--), "yyyyMM"));
		loginUserId.setSearchMonth03(DateFormatUtils.format(DateUtils.addMonths(now, i--), "yyyyMM"));
		loginUserId.setSearchMonth02(DateFormatUtils.format(DateUtils.addMonths(now, i--), "yyyyMM"));
		loginUserId.setSearchMonth01(DateFormatUtils.format(DateUtils.addMonths(now, i--), "yyyyMM"));
		
		billInvoiceByCategory(model, loginUserId);
		
		loginUserId.setInvoiceItem("0000");
		loginUserId.setGroup("all");
		billInvoiceByProject(model, loginUserId);
		
		loginUserId.setGroup("project");
		billInvoiceByProject(model, loginUserId);
		
		loginUserId.setGroup("customer");
		billInvoiceByProject(model, loginUserId);
		
	}

	public CustomMbrHomeVO customerCnt(CustomMbrHomeVO loginUserId) {
		return potalHomeDAO.customerCnt(loginUserId);
	}

	public CustomMbrHomeVO workCnt(CustomMbrHomeVO loginUserId) {
		return potalHomeDAO.workCnt(loginUserId);
	}
	
	public List<CustomMbrHomeVO> userDashboardInfo(CustomMbrHomeVO loginUserId) {
		return potalHomeDAO.userDashboardInfo(loginUserId);
	}
	
	public List<CustomMbrHomeVO> userNoticeList() {
		return potalHomeDAO.userNoticeList();
	}
	public List<CustomMbrHomeVO> userQnaLast(CustomMbrHomeVO loginUserId) {
		return potalHomeDAO.userQnaLast(loginUserId);
	}
	public List<CustomMbrHomeVO> userBillTwoMonth(CustomMbrHomeVO loginUserId) {
		return potalHomeDAO.userBillTwoMonth(loginUserId);
	}

	public String timer() { 
		return potalHomeDAO.timer();
	}

	public CustomMbrHomeVO cloudUsage(CustomMbrHomeVO req) {
		return potalHomeDAO.cloudUsage(req);
	}
	
	public List<CustomMbrHomeVO> mngQnaList(CustomMbrHomeVO req) {
		return potalHomeDAO.mngQnaList(req);
	}
	
	public CustomMbrHomeVO mngCloudService(CustomMbrHomeVO req) {
		return potalHomeDAO.mngCloudService(req);
	}
	
	public CustomMbrHomeVO mngCustomerCount(CustomMbrHomeVO req) {
		return potalHomeDAO.mngCustomerCount(req);
	}
	
	public CustomMbrHomeVO mngCustomerAmount(CustomMbrHomeVO req) {
		return potalHomeDAO.mngCustomerAmount(req);
	}
	
	public List<CustomMbrHomeVO> mngCustomerAmount6month(CustomMbrHomeVO req) {
		return potalHomeDAO.mngCustomerAmount6month(req);
	}
	
	public CustomMbrHomeVO myJobCount(CustomMbrHomeVO req) {
		return potalHomeDAO.myJobCount(req);
	}
	
	public CustomMbrHomeVO totGoodCount(CustomMbrHomeVO req) {
		return potalHomeDAO.totGoodCount(req);
	}
	
	public CustomMbrHomeVO totBillCount(CustomMbrHomeVO req) {
		return potalHomeDAO.totBillCount(req);
	}
	
	
	
	////////////////////////////////////////////////////////////////////////////////
	
	public CustomMbrHomeVO mbrProjectReq(CustomMbrHomeVO req) {
		return potalHomeDAO.mbrProjectReq(req);
	}
	public CustomMbrHomeVO mbrProjectApprove(CustomMbrHomeVO req) {
		return potalHomeDAO.mbrProjectApprove(req);
	}
	public CustomMbrHomeVO mbrProductReq(CustomMbrHomeVO req) {
		return potalHomeDAO.mbrProductReq(req);
	}
	public CustomMbrHomeVO mbrProductApprove(CustomMbrHomeVO req) {
		return potalHomeDAO.mbrProductApprove(req);
	}
	public List<CustomMbrHomeVO> mbrProjectResources(CustomMbrHomeVO req) {
		return potalHomeDAO.mbrProjectResources(req);
	}
	public List<CustomMbrHomeVO> mbrServiceResources(CustomMbrHomeVO req) {
		return potalHomeDAO.mbrServiceResources(req);
	}
	
	
	
	public List<CustomMbrHomeVO> mbrProjectResourcesList(CustomMbrHomeVO req) {
		return potalHomeDAO.mbrProjectResourcesList(req);
	}
	public List<CustomMbrHomeVO> mbrProjectResourcesListTotal(CustomMbrHomeVO req) {
		return potalHomeDAO.mbrProjectResourcesListTotal(req);
	}
	
	/////////////////////////////////////////////////////////////////////////////
	
	public CustomMbrHomeVO mngProjectApprove() {
		return potalHomeDAO.mngProjectApprove();
	}
	public CustomMbrHomeVO mngProductApprove() {
		return potalHomeDAO.mngProductApprove();
	}
	public CustomMbrHomeVO mngMyWork() {
		return potalHomeDAO.mngMyWork();
	}
	public CustomMbrHomeVO mngUserApprove() {
		return potalHomeDAO.mngUserApprove();
	}
	public List<CustomMbrHomeVO> myAllWork(CustomMbrHomeVO req) {
		return potalHomeDAO.myAllWork(req);
	}
	public List<CustomMbrHomeVO> mngCloudProduct() {
		return potalHomeDAO.mngCloudProduct();
	}
	public List<CustomMbrHomeVO> mngProductAvr() {
		return potalHomeDAO.mngProductAvr();
	}
	public CustomMbrHomeVO mngCloudAmount() {
		return potalHomeDAO.mngCloudAmount();
	}
	public List<CustomMbrHomeVO> availHistoryAvr() {
		return potalHomeDAO.availHistoryAvr();
	}
	
	public List<CustomMbrHomeVO> vmUsedHistory() {
		return potalHomeDAO.vmUsedHistory();
	}
	
	public List<CustomMbrHomeVO> monthVm() {
		return potalHomeDAO.monthVm();
	}
	
	public List<CustomStorageVO> getStorageList(String cloudId) {
		return potalHomeDAO.getStorageList(cloudId);
	}
	
}

