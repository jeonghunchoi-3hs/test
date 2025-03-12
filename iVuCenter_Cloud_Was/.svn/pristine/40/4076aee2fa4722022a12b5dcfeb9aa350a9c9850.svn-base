package com.ivucenter.cloud.portal.bbs.qna;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository
public class BbsQnaDAO {
	
	private final String GBN = "com.ivucenter.cloud.portal.bbs.qna.BbsQnaDAO.";
	
    @Autowired
    private SqlSession sqlSession;
    
	public int listTot(CustomBbsQnaVO req) {
		req.setLength(0);
		return sqlSession.selectList(GBN+"list", req).size();
	}
    
    public List<CustomBbsQnaVO> list(CustomBbsQnaVO req) {
        return sqlSession.selectList(GBN+"list", req);
    } 
    public List<CustomBbsQnaVO> mngListTot(CustomBbsQnaVO req) {
    	req.setLength(0);
    	return sqlSession.selectList(GBN+"mngList", req);
    }
    
    public List<CustomBbsQnaVO> mngList(CustomBbsQnaVO req) {
    	return sqlSession.selectList(GBN+"mngList", req);
    } 

	public CustomBbsQnaVO detail(CustomBbsQnaVO req) {
		return (CustomBbsQnaVO) sqlSession.selectOne(GBN+"detail", req);
	}
	
	public CustomBbsQnaVO detailReply(CustomBbsQnaVO req) {
		return (CustomBbsQnaVO) sqlSession.selectOne(GBN+"detailReply", req);
	}
    
    public int insert(CustomBbsQnaVO req) {
    	return (int)sqlSession.insert(GBN+"insert", req);
    }

    public int update(CustomBbsQnaVO req) {
    	return (int)sqlSession.update(GBN+"update", req);
    }

	public int delete(CustomBbsQnaVO req) {
		return (int)sqlSession.delete(GBN+"delete", req);
	}

	public void updateHitCount(CustomBbsQnaVO req) {
		sqlSession.update(GBN+"updateHitCount", req);
	}

	public List<CustomBbsQnaVO> getNoticeBbscodeList(String codeKeyId) {
		return sqlSession.selectList(GBN + "getNoticeBbscodeList",codeKeyId);
	}
	
	public CustomBbsQnaVO getNoReplyCount(CustomBbsQnaVO req) {
		return sqlSession.selectOne(GBN+"getNoReplyCount", req);
	}
	
}
