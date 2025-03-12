package com.ivucenter.cloud.portal.productUsageStatus.total;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ProductUsageStatusTotalDAO {
	
	private final String GBN = "com.ivucenter.cloud.portal.productUsageStatus.total.ProductUsageStatusTotalDAO.";
	
    @Autowired
    private SqlSession sqlSession;
    
    public List<CustomProductUsageStatusTotalVO> list(CustomProductUsageStatusTotalVO req) {
        return sqlSession.selectList(GBN+"list", req);
    }

	public CustomProductUsageStatusTotalVO total(CustomProductUsageStatusTotalVO req) {
		return sqlSession.selectOne(GBN+"total", req);
	}

	public List<CustomProductUsageStatusTotalVO> searchBox(CustomProductUsageStatusTotalVO req) {
		return sqlSession.selectList(GBN+"searchBox", req);
	} 
}
