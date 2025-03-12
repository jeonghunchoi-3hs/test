package com.ivucenter.cloud.portal.alarms.mail.history;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository
public class MailQueueHistoryDAO {
	
	private final String GBN = "com.ivucenter.cloud.portal.mail.queue.history.MailQueueHistoryDAO.";
	
    @Autowired
    private SqlSession sqlSession;
    
    public List<CustomMailQueueHistoryVO> list(CustomMailQueueHistoryVO req) {
        return sqlSession.selectList(GBN+"list", req);
    } 

    public List<CustomMailQueueHistoryVO> listTot(CustomMailQueueHistoryVO req) {
    	req.setLength(0);
    	return sqlSession.selectList(GBN+"list", req);
    } 

	public CustomMailQueueHistoryVO detail(CustomMailQueueHistoryVO req) {
		return (CustomMailQueueHistoryVO) sqlSession.selectOne(GBN+"detail", req);
	}
    
    public int insert(CustomMailQueueHistoryVO req) {
    	return (int)sqlSession.insert(GBN+"insert", req);
    }

    public int update(CustomMailQueueHistoryVO req) {
    	return (int)sqlSession.update(GBN+"update", req);
    }

	public int delete(CustomMailQueueHistoryVO req) {
		return (int)sqlSession.update(GBN+"delete", req);
	}

}
