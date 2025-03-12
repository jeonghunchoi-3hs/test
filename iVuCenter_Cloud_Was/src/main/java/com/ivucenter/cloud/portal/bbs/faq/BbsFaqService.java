package com.ivucenter.cloud.portal.bbs.faq;

import java.util.List;

public interface BbsFaqService {
	
	String list(CustomBbsFaqVO req);

	CustomBbsFaqVO detail(CustomBbsFaqVO req);

	String insert(CustomBbsFaqVO req);

	String update(CustomBbsFaqVO req);

	String delete(CustomBbsFaqVO req);

	void updateHitCount(CustomBbsFaqVO req);
	
	List<CustomBbsFaqVO> faqList(String delflag);

	List<CustomBbsFaqVO> getNoticeBbscodeList(String codeKeyId);

}
