package com.ivucenter.cloud.portal.oss.loadbalancer;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ivucenter.cloud.portal.oss.vm.CustomOssVmVO;

@Service
public class OssLbService {

	@Autowired
	private OssLbDAO ossLbDAO;

	public List<CustomOssLbVO> getLbList(CustomOssLbVO req) {
		return ossLbDAO.getLbList(req);
	}
	
	public int getLbListTot(CustomOssLbVO req) {
		return ossLbDAO.getLbListTot(req);
	}
	
	public List<CustomOssLbVO> getLb(CustomOssLbVO req) {
		
		return ossLbDAO.getLb(req);
	}
	
	public List<CustomOssVmVO> getVmList(CustomOssLbVO req) {
		
		return ossLbDAO.getVmList(req);
	}
	
	public String deleteVm(CustomOssLbVO req) {
		return ossLbDAO.deleteVm(req)+"";
	}
	
//	public int getLbListTot(CustomOssLbVO req) {
//		return ossLbDAO.getLbListTot(req);
//	}
	
//	public int setLbEditOk(CustomOssLbVO req) {
//		return ossLbDAO.setLbEditOk(req);
//	}

//	public CustomOssLbVO lbDetail(CustomOssLbVO req) {
//		return ossLbDAO.lbDetail(req);
//	}
}
