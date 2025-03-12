package com.ivucenter.cloud.portal.productUsageStatus.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ProductUsageStatusServiceDAO {
	
	private final String GBN = "com.ivucenter.cloud.portal.productUsageStatus.service.ProductUsageStatusServiceDAO.";
	
	@Autowired
    private SqlSession sqlSession;
	
	/**
     * 기타서비스 목록조회
     * @param req
     * @return
     */
    public List<CustomProductUsageStatusServiceVO> list(CustomProductUsageStatusServiceVO req) {
        return sqlSession.selectList(GBN+"list", req);
    }
    
    public int listTotal(CustomProductUsageStatusServiceVO req){
    	req.setLength(0);
    	return sqlSession.selectList(GBN+"list", req).size();
    }
    
    public CustomProductUsageStatusServiceVO total(CustomProductUsageStatusServiceVO req){
    	return sqlSession.selectOne(GBN+"total", req);
    }

}
