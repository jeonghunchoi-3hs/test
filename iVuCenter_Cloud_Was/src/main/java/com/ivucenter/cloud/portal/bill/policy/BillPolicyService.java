package com.ivucenter.cloud.portal.bill.policy;

import java.util.List;

public interface BillPolicyService {

	String getBillPolicyList(CustomBillPolicyVO req);

	int cumlistTot(CustomBillPolicyVO req);

	CustomBillPolicyVO getBillPolicyView(CustomBillPolicyVO req);
	
	List<CustomBillPolicyVO> getBillItemList(CustomBillPolicyVO req);
	
	List<CustomBillPolicyVO> getBillTypeList(CustomBillPolicyVO req);

	String setBillPolicy(CustomBillPolicyVO req);

	List<CustomBillPolicyVO> getBillItemSearchList(CustomBillPolicyVO req);

	String setBillPolicyItem(CustomBillPolicyVO req);

	String setBillPolicyItemPrice(CustomBillPolicyVO req);

	List<CustomBillPolicyVO> getOldBillPolicyInfo(CustomBillPolicyVO billPolicyvo);

	int getBillPolicyCnt(CustomBillPolicyVO req);
	
	int billProductCheck(CustomBillPolicyVO req);

	CustomBillPolicyVO getBillPolicyInfo(CustomBillPolicyVO req);

	String setBillPolicyEdit(CustomBillPolicyVO req);

	CustomBillPolicyVO getBillItemEditVo(CustomBillPolicyVO req);

	String setBillPolicyItemEdit(CustomBillPolicyVO req);	

	List<CustomBillPolicyVO> getCopyBillPolicyInfo(CustomBillPolicyVO billPolicyvo);

	List<CustomBillPolicyVO> excel(CustomBillPolicyVO req);
	List<CustomBillPolicyVO> detailExcel(CustomBillPolicyVO req);
	
	String billProductInsert(CustomBillPolicyVO req);
	
	String billPolicyItemInsert(CustomBillPolicyVO req);
	
	String billProductCatalogItemInsert(CustomBillPolicyVO req);

}
