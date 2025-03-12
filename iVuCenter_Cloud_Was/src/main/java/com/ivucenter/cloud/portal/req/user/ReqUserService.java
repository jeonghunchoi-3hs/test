package com.ivucenter.cloud.portal.req.user;

import java.util.List;

import com.ivucenter.cloud.portal.cmm.customer.CustomCmmCustomerVO;

public interface ReqUserService {

	public String list(CustomReqUserVO req);
	
	public List<CustomReqUserVO> excel(CustomReqUserVO req);
	
	public List<CustomReqUserVO> getUserList();

	public CustomReqUserVO getUserView(CustomReqUserVO req);	
	
	public CustomReqUserVO getReqUserById(CustomReqUserVO req);
	
	public String setUserInsert(CustomReqUserVO getUserView);
	
	public boolean chkUniqueId(CustomReqUserVO getUserVo);

	public List<CustomCmmCustomerVO> selectCustomerList(CustomCmmCustomerVO customerVo);

	public List<CustomReqUserVO> selectDepartmentList(CustomReqUserVO reqUserVo);	
	
	public String UserConfirm(CustomReqUserVO getUserVO);
	
	
	
}
