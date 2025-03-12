package com.ivucenter.cloud.portal.oss.zone;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class OssZoneNetworkDiskService {
	
	@Autowired
	OssZoneNetworkDiskDAO dao;
	
	public List<OssZoneNetworkDiskVO> list(OssZoneNetworkDiskVO req) {
    	return dao.list(req);
	}
	

}
