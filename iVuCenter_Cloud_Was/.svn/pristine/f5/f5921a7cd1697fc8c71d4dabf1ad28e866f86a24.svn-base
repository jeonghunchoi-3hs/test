package com.ivucenter.cloud.portal.alarms.event;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class EventAlarmDAO {
	
	private final String GBN = "com.ivucenter.cloud.portal.alarms.event.EventAlarmDAO.";
	
    @Autowired
    private SqlSession sqlSession;
    
	public void insertHistory(CustomEventAlarmVO req) {
		sqlSession.insert(GBN+"insertHistory", req);
	}
    
    public void insert(CustomEventAlarmVO req) {
		sqlSession.insert(GBN+"insert", req);
	}

	public void update(CustomEventAlarmVO req) {
		sqlSession.update(GBN+"update", req);
	}

	public int cnt(CustomEventAlarmVO req) {
		return (int) sqlSession.selectOne(GBN+"cnt", req);
	}

	
}
