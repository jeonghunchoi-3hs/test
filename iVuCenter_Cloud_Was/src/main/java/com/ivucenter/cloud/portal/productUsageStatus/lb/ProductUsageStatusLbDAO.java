package com.ivucenter.cloud.portal.productUsageStatus.lb;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ProductUsageStatusLbDAO {
	
	private final String GBN = "com.ivucenter.cloud.portal.productUsageStatus.lb.ProductUsageStatusLbDAO.";
	
    @Autowired
    private SqlSession sqlSession;
    
    public List<CustomProductUsageStatusLbVO> list(CustomProductUsageStatusLbVO req) {
        return sqlSession.selectList(GBN+"list", req);
    }
    
	public CustomProductUsageStatusLbVO total(CustomProductUsageStatusLbVO req) {
		return sqlSession.selectOne(GBN+"total", req);
	}
}
