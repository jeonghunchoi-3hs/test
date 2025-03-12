package com.ivucenter.cloud.portal.bbs.faq;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@Repository
public class BbsFaqDAO {
	
	private final String GBN = "com.ivucenter.cloud.portal.bbs.faq.BbsFaqDAO.";
	
    @Autowired
    private SqlSession sqlSession;
    
	public int listTot(CustomBbsFaqVO req) {
		req.setLength(0);
		return sqlSession.selectList(GBN+"list", req).size();
	}
    
    public List<CustomBbsFaqVO> list(CustomBbsFaqVO req) {
        return sqlSession.selectList(GBN+"list", req);
    } 

	public CustomBbsFaqVO findByIdx(CustomBbsFaqVO req) {
		return (CustomBbsFaqVO) sqlSession.selectOne(GBN+"detail", req);
	}
    
    public int insert(CustomBbsFaqVO req) {
    	log.debug("=== req ===" + req.getRegUserId());
    	return (int)sqlSession.insert(GBN+"insert", req);
    }

    public int update(CustomBbsFaqVO req) {
    	return (int)sqlSession.update(GBN+"update", req);
    }

	public int delete(CustomBbsFaqVO req) {
		return (int)sqlSession.update(GBN+"delete", req);
	}

	public void updateHitCount(CustomBbsFaqVO req) {
		sqlSession.update(GBN+"updateHitCount", req);
	}
	
	 public List<CustomBbsFaqVO> faqList(String delflag) {
			return  sqlSession.selectList(GBN+"faqList", delflag);
		}

	public List<CustomBbsFaqVO> getNoticeBbscodeList(String codeKeyId) {
		return sqlSession.selectList(GBN + "getNoticeBbscodeList",codeKeyId);
	}
	
}
