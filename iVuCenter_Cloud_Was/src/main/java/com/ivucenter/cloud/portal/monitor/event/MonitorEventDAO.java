package com.ivucenter.cloud.portal.monitor.event;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MonitorEventDAO {
	
	private final String GBN = "com.ivucenter.cloud.portal.monitor.event.MonitorEventDAO.";
	
    @Autowired
    private SqlSession sqlSession;
    
    public List<CustomMonitorEventVO> list(CustomMonitorEventVO req) {
        return sqlSession.selectList(GBN+"list", req);
    } 

	public int listTot(CustomMonitorEventVO req) {
		req.setLength(0);
		return sqlSession.selectList(GBN+"list", req).size();
	}
	
}
