package com.ivucenter.cloud.portal.alarms.sms.history;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository
public class SmsQueueHistoryDAO {
	
	private final String GBN = "com.ivucenter.cloud.portal.sms.queue.history.SmsQueueHistoryDAO.";
	
    @Autowired
    private SqlSession sqlSession;
    
    public List<CustomSmsQueueHistoryVO> list(CustomSmsQueueHistoryVO req) {
        return sqlSession.selectList(GBN+"list", req);
    } 

    public List<CustomSmsQueueHistoryVO> listTot(CustomSmsQueueHistoryVO req) {
    	req.setLength(0);
    	return sqlSession.selectList(GBN+"list", req);
    } 

	public CustomSmsQueueHistoryVO detail(CustomSmsQueueHistoryVO req) {
		return (CustomSmsQueueHistoryVO) sqlSession.selectOne(GBN+"detail", req);
	}
    
    public int insert(CustomSmsQueueHistoryVO req) {
    	return (int)sqlSession.insert(GBN+"insert", req);
    }

    public int update(CustomSmsQueueHistoryVO req) {
    	return (int)sqlSession.update(GBN+"update", req);
    }

	public int delete(CustomSmsQueueHistoryVO req) {
		return (int)sqlSession.update(GBN+"delete", req);
	}

}
