package com.ivucenter.cloud.portal.cmm.license;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class OssLicenseDAO {

	private final String GBN = "com.ivucenter.cloud.portal.cmm.cloud.OssLicenseDao.";

	@Autowired
	private SqlSession sqlSession;

	public CustomOssLicenseVO view(CustomOssLicenseVO req) {

		return sqlSession.selectOne(GBN + "view", req);
	}
	
	public CustomOssLicenseVO detailView(CustomOssLicenseVO req) {

		return sqlSession.selectOne(GBN + "detailView", req);
	}
	
	public int listTot(CustomOssLicenseVO req) {
		req.setLength(0);
		return sqlSession.selectList(GBN+"list", req).size();
	}
	
	public List<CustomOssLicenseVO> list(CustomOssLicenseVO req) {

		return sqlSession.selectList(GBN + "list", req);
	}
	
	public List<CustomOssLicenseVO> detailList(CustomOssLicenseVO req) {

		return sqlSession.selectList(GBN + "detailList", req);
	}
	
	public int detailListTot(CustomOssLicenseVO req) {
		req.setLength(0);
		return sqlSession.selectList(GBN+"detailList", req).size();
	}
	
	public int insert(CustomOssLicenseVO req) {
     	return (int)sqlSession.insert(GBN+"insert", req);
     }
	
	public int detailInsert(CustomOssLicenseVO req) {
     	return (int)sqlSession.insert(GBN+"detailInsert", req);
     }
	
	public int update(CustomOssLicenseVO req) {
 		 return (int)sqlSession.update(GBN+"update", req);
 	 }
	
	public int detailUpdate(CustomOssLicenseVO req) {
		 return (int)sqlSession.update(GBN+"detailUpdate", req);
	 }
	
	public int delete(CustomOssLicenseVO req) {
  	  	 return (int)sqlSession.update(GBN+"delete", req);
	}
	
	public int detailDelete(CustomOssLicenseVO req) {
 	  	 return (int)sqlSession.update(GBN+"detailDelete", req);
	}
}
