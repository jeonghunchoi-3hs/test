package com.ivucenter.cloud.portal.productUsageStatus.disk;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ProductUsageStatusDiskDAO {
	
	private final String GBN = "com.ivucenter.cloud.portal.productUsageStatus.disk.ProductUsageStatusDiskDAO.";
	
    @Autowired
    private SqlSession sqlSession;
    
    public List<CustomProductUsageStatusDiskVO> list(CustomProductUsageStatusDiskVO req) {
        return sqlSession.selectList(GBN+"list", req);
    }
    
	public CustomProductUsageStatusDiskVO total(CustomProductUsageStatusDiskVO req) {
		return sqlSession.selectOne(GBN+"total", req);
	}
}
