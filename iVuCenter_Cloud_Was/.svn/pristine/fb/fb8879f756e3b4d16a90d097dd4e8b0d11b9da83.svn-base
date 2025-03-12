package com.ivucenter.cloud.portal.alarms.sms.queue;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository
public class SmsQueueDAO {
	
	private final String GBN = "com.ivucenter.cloud.portal.sms.queue.SmsQueueDAO.";
	
    @Autowired
    private SqlSession sqlSession;
    
    public List<CustomSmsQueueVO> list(CustomSmsQueueVO req) {
        return sqlSession.selectList(GBN+"list", req);
    } 

	public CustomSmsQueueVO detail(CustomSmsQueueVO req) {
		return (CustomSmsQueueVO) sqlSession.selectOne(GBN+"detail", req);
	}
    
    public int insert(CustomSmsQueueVO req) {
    	return (int)sqlSession.insert(GBN+"insert", req);
    }

    public int updateRetryCount(CustomSmsQueueVO req) {
    	return (int)sqlSession.update(GBN+"updateRetryCount", req);
    }

	public int delete(CustomSmsQueueVO req) {
		return (int)sqlSession.update(GBN+"delete", req);
	}

}
