package com.ivucenter.cloud.portal.bss.product;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;



@Repository
public class MngBssProductDAO {

	private final String GBN = "com.ivucenter.cloud.portal.bss.product.MngBssProductDAO.";

    @Autowired
    private SqlSession sqlSession;
  //pho
	public List<CustomBssProductVO> list(CustomBssProductVO req ){
		return sqlSession.selectList(GBN + "list",req);
	}

	public List<CustomBssProductVO> listTot(CustomBssProductVO req) {
		req.setLength(0);
		return sqlSession.selectList(GBN + "list",req);
	}
	public List<CustomBssProductVO> bssProductList(CustomBssProductVO req) {
		return sqlSession.selectList(GBN + "bssProductList", req);
	}
	public CustomBssProductVO detail(String productSeq) {
	return sqlSession.selectOne(GBN + "detail",productSeq);
	}

	public Integer pageCount(CustomBssProductVO req) {
		return sqlSession.selectOne(GBN + "pageCount",req);
	}

	public CustomBssProductVO productView(String productSeq) {
	return sqlSession.selectOne(GBN + "productView",productSeq);
	}
	public CustomBssProductVO osView(String productSeq) {
	return sqlSession.selectOne(GBN + "osView",productSeq);
	}
	public CustomBssProductVO diskView(String productSeq) {
	return sqlSession.selectOne(GBN + "diskView",productSeq);
	}
	public CustomBssProductVO nasView(String productSeq) {
	return sqlSession.selectOne(GBN + "nasView",productSeq);
	}
	public CustomBssProductVO ipView(String productSeq) {
	return sqlSession.selectOne(GBN + "ipView",productSeq);
	}
	public CustomBssProductVO lbView(String productSeq) {
	return sqlSession.selectOne(GBN + "lbView",productSeq);
	}
//	public CustomBssProductVO scmView(String productSeq) {
//	return sqlSession.selectOne(GBN + "scmView",productSeq);
//	}
//	public CustomBssProductVO bkView(String productSeq) {
//	return sqlSession.selectOne(GBN + "bkView",productSeq);
//	}
	public CustomBssProductVO serviceView(String productSeq) {
		return sqlSession.selectOne(GBN + "serviceView",productSeq);
	}
	public CustomBssProductVO appView(String productSeq) {
		return sqlSession.selectOne(GBN + "appView",productSeq);
	}
//	public CustomBssProductVO serView(String productSeq) {
//	return sqlSession.selectOne(GBN + "serView",productSeq);
//	}
//	public CustomBssProductVO mcaView(String productSeq) {
//	return sqlSession.selectOne(GBN + "mcaView",productSeq);
//	}
	public CustomBssProductVO view(String productSeq) {
	return sqlSession.selectOne(GBN + "view",productSeq);
	}
	// 상품가격정보조회
	public CustomBssProductVO getItemPriceInfo(CustomBssProductVO req) {
		return sqlSession.selectOne(GBN + "getItemPriceInfo",req);
	}
	// 상품가격정보조회
	public List<CustomBssProductVO> getItemsPriceInfo(CustomBssProductVO req) {
		return sqlSession.selectList(GBN + "getItemsPriceInfo",req);
	}
	public CustomBssProductVO getProductImageType(CustomBssProductVO req) {
		return sqlSession.selectOne(GBN + "getProductImageType",req);
	}
	public CustomBssProductVO getProductDiskType(CustomBssProductVO req) {
		return sqlSession.selectOne(GBN + "getProductDiskType",req);
	}
	// 상품 os popup
	public List<CustomBssProductVO> osPopList(CustomBssProductVO req) {
		return sqlSession.selectList(GBN + "osPopList", req);
	}
	public int productUpdate(CustomBssProductVO req) {
	return (int)sqlSession.update(GBN+"productUpdate", req);
	}
	public int vmUpdate(CustomBssProductVO req) {
	return (int)sqlSession.update(GBN+"vmUpdate", req);
	}
	public int osUpdate(CustomBssProductVO req) {
	return (int)sqlSession.update(GBN+"osUpdate", req);
	}

	public int diskUpdate(CustomBssProductVO req) {
	return (int)sqlSession.update(GBN+"diskUpdate", req);
	}
	public int nasUpdate(CustomBssProductVO req) {
	return (int)sqlSession.update(GBN+"nasUpdate", req);
	}
	public int ipUpdate(CustomBssProductVO req) {
	return (int)sqlSession.update(GBN+"ipUpdate", req);
	}
	public int lbUpdate(CustomBssProductVO req) {
	return (int)sqlSession.update(GBN+"lbUpdate", req);
	}
//	public int scmUpdate(CustomBssProductVO req) {
//	return (int)sqlSession.update(GBN+"scmUpdate", req);
//	}
//	public int bkUpdate(CustomBssProductVO req) {
//	return (int)sqlSession.update(GBN+"bkUpdate", req);
//	}
//	public int serUpdate(CustomBssProductVO req) {
//	return (int)sqlSession.update(GBN+"serUpdate", req);
//	}
//	public int mcaUpdate(CustomBssProductVO req) {
//	return (int)sqlSession.update(GBN+"mcaUpdate", req);
//	}
	public int serviceUpdate(CustomBssProductVO req) {
		return (int)sqlSession.update(GBN+"serviceUpdate", req);
	}
	public int productDelete(CustomBssProductVO req) {
		return (int)sqlSession.update(GBN+"productDelete", req);
	}
	public int vmDelete(CustomBssProductVO req) {
		return (int)sqlSession.update(GBN+"vmDelete", req);
	}
	public int diskDelete(CustomBssProductVO req) {
		return (int)sqlSession.update(GBN+"diskDelete", req);
	}
	public int seviceDelete(CustomBssProductVO req) {
		return (int)sqlSession.update(GBN+"seviceDelete", req);
	}
	public int osDelete(CustomBssProductVO req) {
		return (int)sqlSession.update(GBN+"osDelete", req);
	}


//	public List<CustomBssProductVO> pcList(String parentCodeId) {
//	return sqlSession.selectList(GBN + "pcList",parentCodeId);
//	}

//	public List<CustomBssProductVO> getItemImageType(String parentCodeId) {
//		return sqlSession.selectList(GBN + "getItemImageType",parentCodeId);
//	}
//	public List<CustomBssProductVO> getCmmCode(CustomBssProductVO req) {
//		return sqlSession.selectList(GBN + "getCmmCode",req);
//	}
	public int productInsert(CustomBssProductVO req) {
	return (int)sqlSession.insert(GBN+"productInsert", req);
	}
	public int vmInsert(CustomBssProductVO req) {
	return (int)sqlSession.insert(GBN+"vmInsert", req);
	}
	// 서비스 상품등록
	public int serviceInsert(CustomBssProductVO req) {
		return (int)sqlSession.insert(GBN+"serviceInsert", req);
	}
	public int osInsert(CustomBssProductVO req) {
	return (int)sqlSession.insert(GBN+"osInsert", req);
	}
	public int diskInsert(CustomBssProductVO req) {
	return (int)sqlSession.insert(GBN+"diskInsert", req);
	}
	public int nasInsert(CustomBssProductVO req) {
	return (int)sqlSession.insert(GBN+"nasInsert", req);
	}
	public int ipInsert(CustomBssProductVO req) {
	return (int)sqlSession.insert(GBN+"ipInsert", req);
	}
	public int lbInsert(CustomBssProductVO req) {
	return (int)sqlSession.insert(GBN+"lbInsert", req);
	}
	public int templateInsert(CustomBssProductVO req) {
	return (int)sqlSession.insert(GBN+"templateInsert", req);
	}
	public int containerInsert(CustomBssProductVO req) {
		return (int)sqlSession.insert(GBN+"containerInsert", req);
	}
	public int envInsert(CustomBssProductVO req) {
		return (int)sqlSession.insert(GBN+"envInsert", req);
	}

//	public int scmInsert(CustomBssProductVO req) {
//	return (int)sqlSession.insert(GBN+"scmInsert", req);
//	}
//	public int bkInsert(CustomBssProductVO req) {
//	return (int)sqlSession.insert(GBN+"bkInsert", req);
//	}
//	public int serInsert(CustomBssProductVO req) {
//	return (int)sqlSession.insert(GBN+"serInsert", req);
//	}
//	public int mcaInsert(CustomBssProductVO req) {
//	return (int)sqlSession.insert(GBN+"mcaInsert", req);
//	}
}
