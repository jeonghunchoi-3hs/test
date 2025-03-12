package com.ivucenter.cloud.portal.bss.productOs;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MngBssProductOsDAO {

	private final String GBN = "com.ivucenter.cloud.portal.bss.product.MngBssProductOsDAO.";

	@Autowired
	private SqlSession sqlSession;
	
	public CustomBssProductOsVO productSeqReturn(CustomBssProductOsVO req) {
		return sqlSession.selectOne(GBN + "productSeqReturn", req);
	}

	public List<CustomBssProductOsVO> list(CustomBssProductOsVO req) {
		return sqlSession.selectList(GBN + "list", req);
	}

	public int listTot(CustomBssProductOsVO req) {
		req.setLength(0);
		return sqlSession.selectList(GBN + "list", req).size();
	}

	public CustomBssProductOsVO detail(String productSeq) {
		return sqlSession.selectOne(GBN + "detail", productSeq);
	}

	public CustomBssProductOsVO productView(String productSeq) {
		return sqlSession.selectOne(GBN + "productView", productSeq);
	}

	public CustomBssProductOsVO osView(String productSeq) {
		return sqlSession.selectOne(GBN + "osView", productSeq);
	}

	public CustomBssProductOsVO view(String productSeq) {
		return sqlSession.selectOne(GBN + "view", productSeq);
	}
	
	public int delete(String seq) {
		return (int) sqlSession.update(GBN + "delete", seq);
	}
	
	public int productDelete(String seq) {
		return (int) sqlSession.update(GBN + "productDelete", seq);
	}

	// 상품 os popup
	public List<CustomBssProductOsVO> osPopList(CustomBssProductOsVO req) {
		return sqlSession.selectList(GBN + "osPopList", req);
	}

	public int productUpdate(CustomBssProductOsVO req) {
		return (int) sqlSession.update(GBN + "productUpdate", req);
	}

	public int vmUpdate(CustomBssProductOsVO req) {
		return (int) sqlSession.update(GBN + "vmUpdate", req);
	}

	public int osUpdate(CustomBssProductOsVO req) {
		return (int) sqlSession.update(GBN + "osUpdate", req);
	}

//	public List<CustomBssProductOsVO> pcList(String parentCodeId) {
//		return sqlSession.selectList(GBN + "pcList", parentCodeId);
//	}

	public int productInsert(CustomBssProductOsVO req) {
		return (int) sqlSession.insert(GBN + "productInsert", req);
	}

	public int vmInsert(CustomBssProductOsVO req) {
		return (int) sqlSession.insert(GBN + "vmInsert", req);
	}

	public int osInsert(CustomBssProductOsVO req) {
		return (int) sqlSession.insert(GBN + "osInsert", req);
	}
}
