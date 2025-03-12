package com.ivucenter.cloud.portal.charge.bill;

import java.util.HashMap;
import java.util.List;

import org.springframework.ui.Model;

public interface ChargeBillService {
	
	public String list(CustomChargeBillVO req);

	public String listMng(CustomChargeBillVO req);
	public String listMngProject(CustomChargeBillVO req);
	public String getProjectBillList(CustomChargeBillVO req);
		
	public CustomChargeBillVO getBillDate(CustomChargeBillVO req);
	public CustomChargeBillVO getUserCustomerId(CustomChargeBillVO req);

	public List<CustomChargeBillVO> view(CustomChargeBillVO req);
	public HashMap<String, String> view2(CustomChargeBillVO req, Model model);

	public List<CustomChargeBillVO> projectBillView(CustomChargeBillVO req);
	
	public CustomChargeBillVO getCustomerId(CustomChargeBillVO req);

	public List<CustomChargeBillVO> projectList(CustomChargeBillVO req);
	public List<CustomChargeBillVO> invoiceProjectList(CustomChargeBillVO req);
	
	public List<CustomChargeBillVO> invoiceProjectBillDetailList(CustomChargeBillVO req);
	
	public List<CustomChargeBillVO> billDetailList(CustomChargeBillVO req);
	public List<CustomChargeBillVO> vmResource(CustomChargeBillVO req);
	public List<CustomChargeBillVO> diskResource(CustomChargeBillVO req);
	public List<CustomChargeBillVO> nasResource(CustomChargeBillVO req);
	public List<CustomChargeBillVO> ipResource(CustomChargeBillVO req);
	public List<CustomChargeBillVO> loadbalancerResource(CustomChargeBillVO req);
	public List<CustomChargeBillVO> backupResource(CustomChargeBillVO req);
	public List<CustomChargeBillVO> mcaResource(CustomChargeBillVO req);
	public List<CustomChargeBillVO> scmResource(CustomChargeBillVO req);
	public List<CustomChargeBillVO> securityResource(CustomChargeBillVO req);
	public List<CustomChargeBillVO> resourceDetail(CustomChargeBillVO req);
	public List<CustomChargeBillVO> resourceDetail2(CustomChargeBillVO req);
	public List<CustomChargeBillVO> dcAdDetail(CustomChargeBillVO req);
	public List<CustomChargeBillVO> billCustomerDetailList(CustomChargeBillVO req);
	public List<CustomChargeBillVO> vmCustomerResource(CustomChargeBillVO req);
	public List<CustomChargeBillVO> resourceCustomerDetail(CustomChargeBillVO req);

	
	public String salesList(CustomChargeBillVO req);

	public CustomChargeBillVO salesView(CustomChargeBillVO req);
	
	
	public List<CustomChargeBillVO> salesViewExcel(CustomChargeBillVO req);

	
	
	public String calculateList(CustomChargeBillVO req);

	public List<CustomChargeBillVO> calculateDetailList(CustomChargeBillVO req);
	
	public String updateConfirmFlag(CustomChargeBillVO req);

	public List<CustomChargeBillVO> excel(CustomChargeBillVO req);
	
	public int getStepAuth(CustomChargeBillVO req);
}
