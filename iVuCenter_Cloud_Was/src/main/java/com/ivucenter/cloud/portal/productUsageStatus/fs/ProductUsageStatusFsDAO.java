package com.ivucenter.cloud.portal.productUsageStatus.fs;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ProductUsageStatusFsDAO {

	private final String GBN = "com.ivucenter.cloud.portal.productUsageStatus.fs.ProductUsageStatusFsDAO.";

    @Autowired
    private SqlSession sqlSession;

    public List<CustomProductUsageStatusFsVO> list(CustomProductUsageStatusFsVO req) {
        return sqlSession.selectList(GBN+"list", req);
    }

	public CustomProductUsageStatusFsVO total(CustomProductUsageStatusFsVO req) {
		return sqlSession.selectOne(GBN+"total", req);
	}
}
