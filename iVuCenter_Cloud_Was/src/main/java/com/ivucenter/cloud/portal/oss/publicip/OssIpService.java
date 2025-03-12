package com.ivucenter.cloud.portal.oss.publicip;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class OssIpService {

	@Autowired
	private OssIpDAO ossIpDAO;

	public List<CustomOssIpVO> getIpList(CustomOssIpVO req) {
		return ossIpDAO.getIpList(req);
	}

//	public int getIpListTot(CustomOssIpVO req) {
//		return ossIpDAO.getIpListTot(req);
//	}

//	public int setIpEditOk(CustomOssIpVO req) {
//		return ossIpDAO.setIpEditOk(req);
//	}

//	public CustomOssIpVO ipDetail(CustomOssIpVO req) {
//		return ossIpDAO.ipDetail(req);
//	}
}
