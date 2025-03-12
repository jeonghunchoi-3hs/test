package com.ivucenter.cloud.portal.alarms.withnh;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class NhwithDAO {

	private final String GBN = "com.ivucenter.cloud.portal.mng.nhwith.NhwithDAO.";
	
	@Autowired
	private SqlSession sqlSession;

	public List<CustomNhwithVO> nhwithTemplatelist(CustomNhwithVO req) {
		 return sqlSession.selectList(GBN+"nhwithTemplatelist", req);
	}

	public CustomNhwithVO templateviewDetail(CustomNhwithVO req) {
		 return sqlSession.selectOne(GBN+"templateviewDetail", req);
		 
	}

	public int templateUpdate(CustomNhwithVO req) {
		return (int)sqlSession.update(GBN+"templateUpdate", req);
	}

	public List<CustomNhwithVO> nhwithTemplateHistoryList(CustomNhwithVO req) {
		 return sqlSession.selectList(GBN+"nhwithTemplateHistoryList", req);
	}

	public int nhwithTemplateHistoryInsert(CustomNhwithVO req) {
		return (int)sqlSession.insert(GBN+"nhwithTemplateHistoryInsert", req);
	}

	public List<CustomNhwithVO> nhwithTemplateHistoryListTot(CustomNhwithVO req) {
		req.setLength(0);
		return sqlSession.selectList(GBN + "nhwithTemplateHistoryList",req);
	}

	public List<CustomNhwithVO> nhwithTemplatelistTot(CustomNhwithVO req) {
		req.setLength(0);
		return sqlSession.selectList(GBN + "nhwithTemplatelist",req);
	}

	public CustomNhwithVO nhwithTemplateHistoryDetail(CustomNhwithVO req) {
		return sqlSession.selectOne(GBN + "nhwithTemplateHistoryDetail",req);
	}
}
