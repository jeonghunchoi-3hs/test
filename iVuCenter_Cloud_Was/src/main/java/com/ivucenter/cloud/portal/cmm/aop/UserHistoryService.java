package com.ivucenter.cloud.portal.cmm.aop;

import java.util.List;

import com.ivucenter.cloud.portal.login.CustomLoginHistoryVO;

public interface UserHistoryService {
	
	
	String list(UserHistoryVO req);
	
	List<UserHistoryVO> excel(UserHistoryVO req);
	
	List<CustomLoginHistoryVO> loginHistoryListTot(CustomLoginHistoryVO req);
	
	String loginHistoryList(CustomLoginHistoryVO req);
	
}
