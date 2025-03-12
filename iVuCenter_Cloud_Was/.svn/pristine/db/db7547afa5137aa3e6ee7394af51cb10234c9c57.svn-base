package com.ivucenter.cloud.portal.bss.catalog;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BssCatalogDAO {

	private final String GBN = "com.ivucenter.cloud.portal.bss.catalog.BssCatalogDAO.";

    @Autowired
    private SqlSession sqlSession;
  //pho
	public List<CustomBssCatalogVO> list(CustomBssCatalogVO req ){
		return sqlSession.selectList(GBN + "list",req);
	}

	public List<CustomBssCatalogVO> listTot(CustomBssCatalogVO req) {
		req.setLength(0);
		return sqlSession.selectList(GBN+"list", req);
	}

	public List<CustomBssCatalogVO> getCatalogueProductList(CustomBssCatalogVO catal) {
	return sqlSession.selectList(GBN + "getCatalogueProductList",catal);
	}

	public List<CustomBssCatalogVO> getCatalogueProductOsList(CustomBssCatalogVO catal) {
	return sqlSession.selectList(GBN + "getCatalogueProductOsList",catal);
	}

	public List<CustomBssCatalogVO> getCatalogueProductDiskList(CustomBssCatalogVO catal) {
	return sqlSession.selectList(GBN + "getCatalogueProductDiskList",catal);
	}

	public List<CustomBssCatalogVO> getCatalogueProductNasList(CustomBssCatalogVO catal) {
	return sqlSession.selectList(GBN + "getCatalogueProductNasList",catal);
	}

	public List<CustomBssCatalogVO> getCatalogueProductPublicIpList(CustomBssCatalogVO catal) {
	return sqlSession.selectList(GBN + "getCatalogueProductPublicIpList",catal);
	}

	public List<CustomBssCatalogVO> getCatalogueProductLbList(CustomBssCatalogVO catal) {
	return sqlSession.selectList(GBN + "getCatalogueProductLbList",catal);
	}

//	public List<CustomBssCatalogVO> getCatalogueProductScmList(CustomBssCatalogVO catal) {
//	return sqlSession.selectList(GBN + "getCatalogueProductScmList",catal);
//	}

//	public List<CustomBssCatalogVO> getCatalogueProductBackupList(CustomBssCatalogVO catal) {
//	return sqlSession.selectList(GBN + "getCatalogueProductBackupList",catal);
//	}

	public List<CustomBssCatalogVO> getCatalogueProductServiceList(CustomBssCatalogVO catal) {
		return sqlSession.selectList(GBN + "getCatalogueProductServiceList",catal);
	}

//	public List<CustomBssCatalogVO> getCatalogueProductSercurityList(CustomBssCatalogVO catal) {
//	return sqlSession.selectList(GBN + "getCatalogueProductSercurityList",catal);
//	}

//	public List<CustomBssCatalogVO> getCatalogueProductMcaList(CustomBssCatalogVO catal) {
//	return sqlSession.selectList(GBN + "getCatalogueProductMcaList",catal);
//	}

	public CustomBssCatalogVO productView(CustomBssCatalogVO req) {
	return sqlSession.selectOne(GBN + "productView",req);
	}
	public CustomBssCatalogVO osView(CustomBssCatalogVO req) {
	return sqlSession.selectOne(GBN + "osView",req);
	}
	public CustomBssCatalogVO detail(String catalogSeq) {
	return sqlSession.selectOne(GBN + "detail",catalogSeq);
	}
	public CustomBssCatalogVO catalogDetail(String catalogSeq) {
	return sqlSession.selectOne(GBN + "catalogDetail",catalogSeq);
	}
	public int catalogUpdate(CustomBssCatalogVO req) {
		return (int)sqlSession.update(GBN+"catalogUpdate", req);
	}
	public int update(CustomBssCatalogVO req) {
		return (int)sqlSession.update(GBN+"update", req);
	}
	public int osUpdate(CustomBssCatalogVO req) {
		return (int)sqlSession.update(GBN+"osUpdate", req);
	}
	public int productInsert(CustomBssCatalogVO req) {
		return (int)sqlSession.insert(GBN+"productInsert", req);
	}
	public int osInsert(CustomBssCatalogVO req) {
		return (int)sqlSession.insert(GBN+"osInsert", req);
	}
	public int appInsert(CustomBssCatalogVO req) {
		return (int)sqlSession.insert(GBN+"appInsert", req);
	}
	public int diskInsert(CustomBssCatalogVO req) {
		return (int)sqlSession.insert(GBN+"diskInsert", req);
	}
	public int nasInsert(CustomBssCatalogVO req) {
		return (int)sqlSession.insert(GBN+"nasInsert", req);
	}
	public int ipInsert(CustomBssCatalogVO req) {
		return (int)sqlSession.insert(GBN+"ipInsert", req);
	}
	public int lbInsert(CustomBssCatalogVO req) {
		return (int)sqlSession.insert(GBN+"lbInsert", req);
	}

	public int envInsert(CustomBssCatalogVO req) {
		return (int)sqlSession.insert(GBN+"envInsert", req);
	}
//	public int scmInsert(CustomBssCatalogVO req) {
//		return (int)sqlSession.insert(GBN+"scmInsert", req);
//	}
//	public int bkInsert(CustomBssCatalogVO req) {
//		return (int)sqlSession.insert(GBN+"bkInsert", req);
//	}
	public int serviceInsert(CustomBssCatalogVO req) {
		return (int)sqlSession.insert(GBN+"serviceInsert", req);
	}
//	public int serInsert(CustomBssCatalogVO req) {
//		return (int)sqlSession.insert(GBN+"serInsert", req);
//	}
//	public int mcaInsert(CustomBssCatalogVO req) {
//		return (int)sqlSession.insert(GBN+"mcaInsert", req);
//	}
	// 가상머신 popup
	public List<CustomBssCatalogVO> productPopList(CustomBssCatalogVO req) {
		return sqlSession.selectList(GBN + "productPopList", req);
	}
	// os popup
	public List<CustomBssCatalogVO> osPopList(CustomBssCatalogVO req) {
		return sqlSession.selectList(GBN + "osPopList", req);
	}
	// template popup
	public List<CustomBssCatalogVO> templatePopList(CustomBssCatalogVO req) {
		return sqlSession.selectList(GBN + "templatePopList", req);
	}
	// 서비스 popup
	public List<CustomBssCatalogVO> servicePopList(CustomBssCatalogVO req) {
		return sqlSession.selectList(GBN + "servicePopList", req);
	}

	public List<CustomBssCatalogVO> diskPopList(CustomBssCatalogVO req) {
		return sqlSession.selectList(GBN + "diskPopList", req);
	}

	public List<CustomBssCatalogVO> nasPopList(CustomBssCatalogVO req) {
		return sqlSession.selectList(GBN + "nasPopList", req);
	}

	public List<CustomBssCatalogVO> ipPopList(CustomBssCatalogVO req) {
		return sqlSession.selectList(GBN + "ipPopList", req);
	}

	public List<CustomBssCatalogVO> lbPopList(CustomBssCatalogVO req) {
		return sqlSession.selectList(GBN + "lbPopList", req);
	}

	public List<CustomBssCatalogVO> envPopList(CustomBssCatalogVO req) {
		return sqlSession.selectList(GBN + "envPopList", req);
	}
//	public List<CustomBssCatalogVO> scmPopList(CustomBssCatalogVO req) {
//		return sqlSession.selectList(GBN + "scmPopList", req);
//	}
//	public List<CustomBssCatalogVO> bkPopList(CustomBssCatalogVO req) {
//		return sqlSession.selectList(GBN + "bkPopList", req);
//	}
//	public List<CustomBssCatalogVO> serPopList(CustomBssCatalogVO req) {
//		return sqlSession.selectList(GBN + "serPopList", req);
//	}
//	public List<CustomBssCatalogVO> mcaPopList(CustomBssCatalogVO req) {
//		return sqlSession.selectList(GBN + "mcaPopList", req);
//	}
	public int setCatalog(CustomBssCatalogVO req) {
		return (int)sqlSession.insert(GBN+"setCatalog", req);
	}
	public int setCatalogNewInsert(CustomBssCatalogVO req) {
		return (int)sqlSession.insert(GBN+"setCatalogNewInsert", req);
	}
	public int setCatalogProduct(CustomBssCatalogVO req) {
		return (int)sqlSession.insert(GBN+"setCatalogProduct", req);
	}
	public List<CustomBssCatalogVO> getOldCataloginfo(String applyDate) {
		return sqlSession.selectList(GBN + "getOldCataloginfo", applyDate);
	}
	public List<CustomBssCatalogVO> getCopyCataloginfo(String catalogSeq) {
		return sqlSession.selectList(GBN + "getCopyCataloginfo", catalogSeq);
	}
	public int getCatalogCnt(CustomBssCatalogVO req) {
		return sqlSession.selectOne(GBN + "getCatalogCnt", req);
	}

	public int productDisplayUpdate(CustomBssCatalogVO req) {
		return (int)sqlSession.update(GBN+"productDisplayUpdate", req);
	}

	public int productDelchk(CustomBssCatalogVO req) {
		return (int)sqlSession.update(GBN+"productDelchk", req);
	}

	public int catalogDelOk(CustomBssCatalogVO req) {
		return (int)sqlSession.delete(GBN+"catalogDelOk", req);
	}
	public int catalogPproductDelete(CustomBssCatalogVO req) {
		return (int)sqlSession.delete(GBN+"catalogPproductDelete", req);
	}

	public int catalogProductDelete(CustomBssCatalogVO req) {
		return (int)sqlSession.delete(GBN+"catalogProductDelete", req);
	}

	//카탈로그상세 상품리스트
	public List<CustomBssCatalogVO> catalogueProductList(CustomBssCatalogVO req) {
		return sqlSession.selectList(GBN+"catalogueProductList", req);
	}
	//카탈로그 상품별 Count
	public int getDisplayOrderCount(CustomBssCatalogVO req) {
		return sqlSession.selectOne(GBN+"getDisplayOrderCount", req);
	}
	public List<CustomBssCatalogVO> catalogueProductListTot(CustomBssCatalogVO req) {
		req.setLength(0);
		return sqlSession.selectList(GBN+"catalogueProductList", req);
	}
	//카탈로그상세 상품 display order 수정
	public int updateDisplayOrder(CustomBssCatalogVO req) {
		return (int)sqlSession.update(GBN+"updateDisplayOrder", req);
	}


}
