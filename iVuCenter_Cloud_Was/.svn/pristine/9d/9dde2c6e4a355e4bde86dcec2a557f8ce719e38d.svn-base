package com.ivucenter.cloud.portal.bss.order;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ivucenter.cloud.portal.req.catalogue.CustomReqOrderVO;


@Repository
public class BssOrderDAO {

	private final String GBN = "com.ivucenter.cloud.portal.bss.order.BssOrderDAO.";

    @Autowired
    private SqlSession sqlSession;

	public int insertBssOrder(CustomReqOrderVO req) {
		return (int)sqlSession.insert(GBN+"insertBssOrder", req);
	}

	public int insertBssOrderProduct(CustomReqOrderVO req) {
		return (int)sqlSession.insert(GBN+"insertBssOrderProduct", req);
	}

	public int insertBssOrderProductVm(CustomReqOrderVO req) {
		return (int)sqlSession.insert(GBN+"insertBssOrderProductVm", req);
	}

	public String insertBssOrderProductDisk(CustomReqOrderVO req) {
		return (int)sqlSession.insert(GBN+"insertBssOrderProductDisk", req)+"";
	}

	public String insertBssOrderProductNas(CustomReqOrderVO req) {
		return (int)sqlSession.insert(GBN+"insertBssOrderProductNas", req)+"";
	}

	public String insertBssOrderProductNasVm(CustomReqOrderVO req) {
		return (int)sqlSession.insert(GBN+"insertBssOrderProductNasVm", req)+"";
	}

	public String insertBssOrderProductIp(CustomReqOrderVO req) {
		return (int)sqlSession.insert(GBN+"insertBssOrderProductIp", req)+"";
	}

	public String insertBssOrderProductService(CustomReqOrderVO req) {
		return (int)sqlSession.insert(GBN+"insertBssOrderProductService", req)+"";
	}

	public String insertBssOrderProductApp(CustomReqOrderVO req) {
		return (int)sqlSession.insert(GBN+"insertBssOrderProductApp", req)+"";
	}

//	public String insertBssOrderProductBack(CustomReqOrderVO req) {
//		return (int)sqlSession.insert(GBN+"insertBssOrderProductBack", req)+"";
//	}
//	public String insertBssOrderProductMca(CustomReqOrderVO req) {
//		return (int)sqlSession.insert(GBN+"insertBssOrderProductMca", req)+"";
//	}
//	public String insertBssOrderProductScm(CustomReqOrderVO req) {
//		return (int)sqlSession.insert(GBN+"insertBssOrderProductScm", req)+"";
//	}
//	public String insertBssOrderProductSec(CustomReqOrderVO req) {
//		return (int)sqlSession.insert(GBN+"insertBssOrderProductSec", req)+"";
//	}

	public CustomReqOrderVO selectByOrderProductSeq(String orderProductSeq){
		return sqlSession.selectOne(GBN + "selectByOrderProductSeq",orderProductSeq);
	}

	public CustomReqOrderVO serviceSeq(String vmUuid){
		return sqlSession.selectOne(GBN + "selectServiceSeq",vmUuid);
	}

	public String getCloudId(CustomReqOrderVO req) {
		return sqlSession.selectOne(GBN + "selectCloudId",req);
	}
}
