package com.ivucenter.cloud.portal.monitoring.kvm;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MonitoringKvmStatusDAO {
	
	private final String GBN = "hq.itrm.kepco.monitoring.status.MonitoringEventDAO.";
	
	// Mybatis ITRM Session
    @Autowired
    @Resource(name="sqlSession2")
    private SqlSession sqlSession;
    
    public List<CustomMonitoringKvmStatusVO> list(Map req) {
        return sqlSession.selectList(GBN+"listKvm", req);
    } 

	public int listTot(Map req) {
		//req.setLength(0);
		req.put("size", 0);
		return sqlSession.selectList(GBN+"listKvm", req).size();
	}
	
}
