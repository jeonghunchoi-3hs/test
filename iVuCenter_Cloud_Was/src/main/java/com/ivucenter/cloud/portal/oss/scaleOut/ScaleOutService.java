package com.ivucenter.cloud.portal.oss.scaleOut;

import java.util.List;

public interface ScaleOutService {

	String list(CustomScaleOutVO req);

	List<CustomScaleOutVO> excel(CustomScaleOutVO req);

	CustomScaleOutVO detail(CustomScaleOutVO req);

	String update(CustomScaleOutVO req);

	String delete(CustomScaleOutVO req);

}
