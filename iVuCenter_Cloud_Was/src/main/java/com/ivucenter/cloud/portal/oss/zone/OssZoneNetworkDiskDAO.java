package com.ivucenter.cloud.portal.oss.zone;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ivucenter.cloud.portal.oss.vm.CustomOssVmVO;

@Repository
public class OssZoneNetworkDiskDAO {

	private final String GBN = "com.ivucenter.cloud.portal.oss.vm.OssZoneNetwrokDiskDAO.";
	
    @Autowired
    private SqlSession sqlSession;
    
    public List<OssZoneNetworkDiskVO> list(OssZoneNetworkDiskVO req) {
    	
    	return sqlSession.selectList(GBN+"list", req);
    }
    
    public List<CustomOssVmVO> listTot(OssZoneNetworkDiskVO req) {
    	//req.setLength(0);
		return sqlSession.selectList(GBN+"list", req);
	}
    
}
