package com.ivucenter.cloud.portal.req.customer;

import java.util.List;

public interface ReqCustomerService {
	
	public List<CustomReqCustomerVO> getCompanyList();

	public void setCustomerForminsert(CustomReqCustomerVO customervo);

	public List<CustomReqCustomerVO> getApprovalModelSteplist();

	public void setSrApprovalStepinsert(CustomReqCustomerVO appmodelstep);

	public List<CustomReqCustomerVO> getApprovalModelMemberlist();

	public void setSrApprovalMemberinsert(CustomReqCustomerVO appmember);

	public String getCustomefIdcheck(String customerId);

	public String getCustomerNamecheck(String customerName);

	public boolean getCustomerNameajaxcheck(String customerName);

	public int setCustomerFormchk(CustomReqCustomerVO customervo);

	public CustomReqCustomerVO getCompanySelectList(CustomReqCustomerVO customervo);

	//Mng ȸ���� ��û��Ȳ ����Ʈ
	
	String list(CustomReqCustomerVO req);
	
	CustomReqCustomerVO detail(String requestSeq);

	String insert(CustomReqCustomerVO req);

	String newUpdate(CustomReqCustomerVO req);
	
	String update(CustomReqCustomerVO req);
	
	String rejectedUpdate(CustomReqCustomerVO req);
	
	String exprUpdate(CustomReqCustomerVO req);
	
	String stepUpdate(CustomReqCustomerVO req);
	
	List<CustomReqCustomerVO> approvalList(String requestSeq);
	
	List<CustomReqCustomerVO> approvalUserId(String requestSeq);
	
	//public CustomerVO getCompanyList();
}
