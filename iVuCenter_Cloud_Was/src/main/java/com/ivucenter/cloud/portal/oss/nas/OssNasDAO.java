package com.ivucenter.cloud.portal.oss.nas;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class OssNasDAO {

	private final String GBN = "com.ivucenter.cloud.portal.oss.nas.OssNasDAO.";

    @Autowired
    private SqlSession sqlSession;

	public List<CustomOssNasVO> getNasList(CustomOssNasVO req) {
		 return sqlSession.selectList(GBN+"getNasList", req);
	}

	public List<CustomOssNasVO> getNasAllList(CustomOssNasVO req) {
		return sqlSession.selectList(GBN+"getNasAllList", req);
	}

//	public int getNasListTot(CustomOssNasVO req) {
//		req.setLength(0);
//		return sqlSession.selectList(GBN+"getNasList", req).size();
//	}
//	public int setNasEditOk(CustomOssNasVO req) {
//		return sqlSession.update(GBN+"setNasEditOk", req);
//	}

//	public CustomOssNasVO nasDetail(CustomOssNasVO req) {
//		return sqlSession.selectOne(GBN+"nasDetail", req);
//	}

//	public CustomOssNasVO nasEditDetail(CustomOssNasVO req) {
//		return sqlSession.selectOne(GBN+"nasEditDetail", req);
//	}
}
