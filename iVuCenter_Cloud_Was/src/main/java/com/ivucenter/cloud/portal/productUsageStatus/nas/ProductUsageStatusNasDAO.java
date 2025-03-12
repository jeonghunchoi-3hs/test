package com.ivucenter.cloud.portal.productUsageStatus.nas;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ProductUsageStatusNasDAO {
	
	private final String GBN = "com.ivucenter.cloud.portal.productUsageStatus.nas.ProductUsageStatusNasDAO.";
	
    @Autowired
    private SqlSession sqlSession;
    
    public List<CustomProductUsageStatusNasVO> list(CustomProductUsageStatusNasVO req) {
        return sqlSession.selectList(GBN+"list", req);
    }
    
	public CustomProductUsageStatusNasVO total(CustomProductUsageStatusNasVO req) {
		return sqlSession.selectOne(GBN+"total", req);
	}
}
