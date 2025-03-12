package com.ivucenter.cloud.portal.oss.nas;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class OssNasService {

	@Autowired
	private OssNasDAO nasDAO;

	public List<CustomOssNasVO> getNasList(CustomOssNasVO req) {
		return nasDAO.getNasList(req);
	}

	public List<CustomOssNasVO> getNasAllList(CustomOssNasVO req) {
		return nasDAO.getNasAllList(req);
	}

//	public int getNasListTot(CustomOssNasVO req) {
//		return nasDAO.getNasListTot(req);
//	}
//	public int setNasEditOk(CustomOssNasVO req) {
//		return nasDAO.setNasEditOk(req);
//	}

//	public CustomOssNasVO nasDetail(CustomOssNasVO req) {
//		return nasDAO.nasDetail(req);
//	}

//	public CustomOssNasVO nasEditDetail(CustomOssNasVO req) {
//		return nasDAO.nasEditDetail(req);
//	}
}
