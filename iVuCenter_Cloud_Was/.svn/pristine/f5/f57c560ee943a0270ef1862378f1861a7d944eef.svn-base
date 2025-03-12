package com.ivucenter.cloud.portal.productUsageStatus.pv;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ProductUsageStatusPvDAO {

	private final String GBN = "com.ivucenter.cloud.portal.productUsageStatus.pv.ProductUsageStatusPvDAO.";

    @Autowired
    private SqlSession sqlSession;

    public List<CustomProductUsageStatusPvVO> list(CustomProductUsageStatusPvVO req) {
        return sqlSession.selectList(GBN+"list", req);
    }

	public CustomProductUsageStatusPvVO total(CustomProductUsageStatusPvVO req) {
		return sqlSession.selectOne(GBN+"total", req);
	}
}
