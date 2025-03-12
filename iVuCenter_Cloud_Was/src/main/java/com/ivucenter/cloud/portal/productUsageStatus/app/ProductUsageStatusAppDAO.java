package com.ivucenter.cloud.portal.productUsageStatus.app;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ProductUsageStatusAppDAO {
	
	private final String GBN = "com.ivucenter.cloud.portal.productUsageStatus.app.ProductUsageStatusAppDAO.";
	
    @Autowired
    private SqlSession sqlSession;
    
    public List<CustomProductUsageStatusAppVO> list(CustomProductUsageStatusAppVO req) {
        return sqlSession.selectList(GBN+"list", req);
    }
    
    public List<CustomProductUsageStatusAppVO> listTot(CustomProductUsageStatusAppVO req) {
    	req.setLength(0);
        return sqlSession.selectList(GBN+"list", req);
    }

	public CustomProductUsageStatusAppVO total(CustomProductUsageStatusAppVO req) {
		return sqlSession.selectOne(GBN+"total", req);
	}
}
