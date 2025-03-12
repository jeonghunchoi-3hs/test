package com.ivucenter.cloud.portal.alarms.mail.queue;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository
public class MailQueueDAO {
	
	private final String GBN = "com.ivucenter.cloud.portal.mail.queue.MailQueueDAO.";
	
    @Autowired
    private SqlSession sqlSession;
    
    public List<CustomMailQueueVO> list(CustomMailQueueVO req) {
        return sqlSession.selectList(GBN+"list", req);
    } 

	public CustomMailQueueVO detail(String mailSeq) {
		return (CustomMailQueueVO) sqlSession.selectOne(GBN+"detail", mailSeq);
	}
    
	public CustomMailQueueVO templateviewDetail(CustomMailQueueVO req) {
		return (CustomMailQueueVO) sqlSession.selectOne(GBN+"templateviewDetail", req);
	}
	
    public int insert(CustomMailQueueVO req) {
    	return (int)sqlSession.insert(GBN+"insert", req);
    }

    public int updateRetryCount(CustomMailQueueVO req) {
    	return (int)sqlSession.update(GBN+"updateRetryCount", req);
    }

    public int updateResultFlag(CustomMailQueueVO req) {
    	return (int)sqlSession.update(GBN+"updateResultFlag", req);
    }

	public int delete(CustomMailQueueVO req) {
		return (int)sqlSession.update(GBN+"delete", req);
	}

}
