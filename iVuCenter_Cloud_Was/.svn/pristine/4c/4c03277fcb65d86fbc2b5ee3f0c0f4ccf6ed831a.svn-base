package com.ivucenter.cloud.portal.bbs.notice;

import java.util.List;

public interface BbsNoticeService {
	
	String list(CustomBbsNoticeVO req);

	CustomBbsNoticeVO detail(CustomBbsNoticeVO req);

	CustomBbsNoticeVO getCurrentNotice(CustomBbsNoticeVO req);

	String insert(CustomBbsNoticeVO req);

	String update(CustomBbsNoticeVO req);

	String delete(CustomBbsNoticeVO req);

	void updateHitCount(CustomBbsNoticeVO req);
	
	List<CustomBbsNoticeVO> getBbsCodeList(String codeKeyId);
	
	List<CustomBbsNoticeVO> getApprovalModelStepList(String modeLid);
	
	List<CustomBbsNoticeVO> getNoticeBbscodeList(String codeKeyId);

	List<CustomBbsNoticeVO> excel(CustomBbsNoticeVO req);

}
