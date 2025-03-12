package com.ivucenter.cloud.portal.productUsageStatus.ip;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ProductUsageStatusIpDAO {
	
	private final String GBN = "com.ivucenter.cloud.portal.productUsageStatus.ip.ProductUsageStatusIpDAO.";
	
    @Autowired
    private SqlSession sqlSession;
    
    /**
     * 공인IP 목록조회
     * @param req
     * @return
     */
    public List<CustomProductUsageStatusIpVO> list(CustomProductUsageStatusIpVO req) {
        return sqlSession.selectList(GBN+"list", req);
    }
    
    public int total(CustomProductUsageStatusIpVO req){
    	req.setLength(0);
    	return sqlSession.selectList(GBN+"list", req).size();
    }

}
