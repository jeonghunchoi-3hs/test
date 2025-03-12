package com.ivucenter.cloud.portal.bss.discount;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BssDiscountDAO {
	
	private final String GBN = "com.ivucenter.cloud.portal.bss.discount.BssDiscountDAO.";
	
    @Autowired
    private SqlSession sqlSession;
    
    public List<CustomBssDiscountVO> list(CustomBssDiscountVO req) {
        return sqlSession.selectList(GBN+"list", req);
    } 
	public List<CustomBssDiscountVO> listTot(CustomBssDiscountVO req) {
		req.setLength(0);
		return sqlSession.selectList(GBN+"list", req);
	}
	public List<CustomBssDiscountVO> detail(CustomBssDiscountVO req) {
		return sqlSession.selectList(GBN+"detail", req);
	}	
    public int insert(CustomBssDiscountVO req) {
    	return (int)sqlSession.insert(GBN+"insert", req);
    }
	public int delete(CustomBssDiscountVO req) {
		return (int)sqlSession.delete(GBN+"delete", req);
	}
	public int update(CustomBssDiscountVO req) {
		return (int)sqlSession.update(GBN+"update", req);
	}
}
