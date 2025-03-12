package com.ivucenter.cloud.portal.monitoring.event;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MonitoringRealtimeEventDAO {

	private final String GBN = "hq.itrm.kepco.monitoring.event.MonitoringEventDAO.";

	// Mybatis ITRM Session
    @Autowired
    @Resource(name="sqlSession2")
    private SqlSession sqlSession;

    public List<CustomMonitoringEventVO> list(Map req) {
        return sqlSession.selectList(GBN+"list", req);
    }


	public int listTot(Map req) {
		//req.setLength(0);
		return sqlSession.selectList(GBN+"list", req).size();
	}

	public CustomMonitoringEventVO getEventSummaryCnt(Map req) {
		return sqlSession.selectOne(GBN+"getEventSummaryCnt", req);
	}
}
