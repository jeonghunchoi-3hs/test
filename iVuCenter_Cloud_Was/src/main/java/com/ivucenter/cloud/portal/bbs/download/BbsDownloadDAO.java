package com.ivucenter.cloud.portal.bbs.download;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository
public class BbsDownloadDAO {
	
	private final String GBN = "com.ivucenter.cloud.portal.bbs.download.BbsDownloadDAO.";
	
    @Autowired
    private SqlSession sqlSession;
    
	public List<CustomBbsDownloadVO> listTot(CustomBbsDownloadVO req) {
		req.setLength(0);
		return sqlSession.selectList(GBN+"list", req);
	}
    
    public List<CustomBbsDownloadVO> list(CustomBbsDownloadVO req) {
        return sqlSession.selectList(GBN+"list", req);
    } 

	public CustomBbsDownloadVO detail(CustomBbsDownloadVO req) {
		return (CustomBbsDownloadVO) sqlSession.selectOne(GBN+"detail", req);
	}
    
    public int insert(CustomBbsDownloadVO req) {
    	return (int)sqlSession.insert(GBN+"insert", req);
    }

    public int update(CustomBbsDownloadVO req) {
    	return (int)sqlSession.update(GBN+"update", req);
    }

    public int updateFilesCnt(CustomBbsDownloadVO req) {
    	return (int)sqlSession.update(GBN+"updateFilesCnt", req);
    }
    
	public int delete(CustomBbsDownloadVO req) {
		return (int)sqlSession.update(GBN+"delete", req);
	}

	public String findLastIndex() {
		return (String)sqlSession.selectOne(GBN+"findLastIndex");
	}

}
