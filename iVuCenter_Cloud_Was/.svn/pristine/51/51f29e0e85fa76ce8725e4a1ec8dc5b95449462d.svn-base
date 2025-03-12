package com.ivucenter.cloud.portal.alarms.withkepco;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class WithKepcoDAO {
	
	private final String GBN = "com.ivucenter.cloud.portal.alarms.withkepco.WithKepcoDAO.";
	
	@Autowired
	private SqlSession sqlSession;
	
	public int alarmWithKepcoQueueInsert(CustomWithKepcoVO req) {
		return (int) sqlSession.insert(GBN+"alarmWithKepcoQueueInsert", req);
	}
	public List<CustomWithKepcoVO> list(CustomWithKepcoVO req) {
        return sqlSession.selectList(GBN+"list", req);
    } 

    public List<CustomWithKepcoVO> listTot(CustomWithKepcoVO req) {
    	req.setLength(0);
    	return sqlSession.selectList(GBN+"list", req);
    } 
    
    public CustomWithKepcoVO detail(String alarmSeq) {
		return (CustomWithKepcoVO) sqlSession.selectOne(GBN+"detail", alarmSeq);
	}
    
}
