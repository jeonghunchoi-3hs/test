package com.ivucenter.cloud.portal.productUsageStatus.vm;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ProductUsageStatusVmDAO {
	
	private final String GBN = "com.ivucenter.cloud.portal.productUsageStatus.vm.ProductUsageStatusVmDAO.";
	
    @Autowired
    private SqlSession sqlSession;
    
    public List<CustomProductUsageStatusVmVO> list(CustomProductUsageStatusVmVO req) {
        return sqlSession.selectList(GBN+"list", req);
    }
    
    public List<CustomProductUsageStatusVmVO> listTot(CustomProductUsageStatusVmVO req) {
    	req.setLength(0);
        return sqlSession.selectList(GBN+"list", req);
    }

	public CustomProductUsageStatusVmVO total(CustomProductUsageStatusVmVO req) {
		return sqlSession.selectOne(GBN+"total", req);
	}
}
