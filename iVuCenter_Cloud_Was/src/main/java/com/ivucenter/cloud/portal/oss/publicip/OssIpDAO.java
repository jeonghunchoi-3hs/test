package com.ivucenter.cloud.portal.oss.publicip;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class OssIpDAO {

	private final String GBN = "com.ivucenter.cloud.portal.oss.publicip.OssIpDAO.";
	
    @Autowired
    private SqlSession sqlSession;

	public List<CustomOssIpVO> getIpList(CustomOssIpVO req) {
		return sqlSession.selectList(GBN+"getIpList", req);
	}
	
//	public int getIpListTot(CustomOssIpVO req) {
//		req.setLength(0);
//		return sqlSession.selectList(GBN+"getIpList", req).size();
//	}

//	public int setIpEditOk(CustomOssIpVO req) {
//		return sqlSession.update(GBN+"setIpEditOk", req);
//	}

//	public CustomOssIpVO ipDetail(CustomOssIpVO req) {
//		return sqlSession.selectOne(GBN+"ipDetail", req);
//	}
}
