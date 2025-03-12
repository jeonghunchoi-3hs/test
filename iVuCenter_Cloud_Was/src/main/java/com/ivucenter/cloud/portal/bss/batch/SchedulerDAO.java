package com.ivucenter.cloud.portal.bss.batch;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository
public class SchedulerDAO {
	
	private final String GBN = "com.ivucenter.cloud.batch.scheduler.SchedulerDAO.";
	
    @Autowired
    private SqlSession sqlSession;
    
	public int listTot(CustomSchedulerVO req) {
		req.setLength(0);
		return sqlSession.selectList(GBN+"list", req).size();
	}
    
    public List<CustomSchedulerVO> list(CustomSchedulerVO req) {
        return sqlSession.selectList(GBN+"list", req);
    } 
	
	public CustomSchedulerVO detail(CustomSchedulerVO req) {
		return (CustomSchedulerVO) sqlSession.selectOne(GBN+"detail", req);
	}
    
    public int insert(CustomSchedulerVO req) {
    	return (int)sqlSession.insert(GBN+"insert", req);
    }

    public int update(CustomSchedulerVO req) {
    	return (int)sqlSession.update(GBN+"update", req);
    }

	public int delete(CustomSchedulerVO req) {
		return (int)sqlSession.update(GBN+"delete", req);
	}

}
