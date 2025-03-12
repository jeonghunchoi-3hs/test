package com.ivucenter.cloud.portal.bss.basket;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ivucenter.cloud.portal.req.catalogue.CustomReqBasketVO;


@Repository
public class BssBasketDAO {
	
	private final String GBN = "com.ivucenter.cloud.portal.bss.basket.BssBasketDAO.";
	
    @Autowired
    private SqlSession sqlSession;

	public int insertBssBasket(CustomReqBasketVO req) {
		return (int)sqlSession.insert(GBN+"insertBssBasket", req);
	}

	public int insertBssBasketVm(CustomReqBasketVO req) {
		return (int)sqlSession.insert(GBN+"insertBssBasketVm", req);		
	}

	public int insertBssBasketDisk(CustomReqBasketVO req) {
		return (int)sqlSession.insert(GBN+"insertBssBasketDisk", req);
	}

	public int insertBssBasketNas(CustomReqBasketVO req) {
		return (int)sqlSession.insert(GBN+"insertBssBasketNas", req);
	}

	public int insertBssBasketIp(CustomReqBasketVO req) {
		return (int)sqlSession.insert(GBN+"insertBssBasketIp", req);		
	}
	
	public int insertBssBasketService(CustomReqBasketVO req) {
		return (int)sqlSession.insert(GBN+"insertBssBasketService", req);		
	}

//	public int insertBssBasketBack(CustomReqBasketVO req) {
//		return (int)sqlSession.insert(GBN+"insertBssBasketBack", req);		
//	}
//	public int insertBssBasketMca(CustomReqBasketVO req) {
//		return (int)sqlSession.insert(GBN+"insertBssBasketMca", req);		
//	}
//	public int insertBssBasketScm(CustomReqBasketVO req) {
//		return (int)sqlSession.insert(GBN+"insertBssBasketScm", req);		
//	}
//	public int insertBssBasketSec(CustomReqBasketVO req) {
//		return (int)sqlSession.insert(GBN+"insertBssBasketSec", req);		
//	}

}
