package com.ivucenter.cloud.portal.cmm.aop;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ivucenter.cloud.portal.login.CustomLoginHistoryVO;

@Repository
public class UserHistoryDAO {
	
	private final String GBN = "com.ivucenter.cloud.portal.cmm.aop.UserHistoryDAO.";
	
	@Autowired
	private SqlSession sqlSession;
	
	public int insertUserHistory(UserHistoryVO req) {
		return sqlSession.insert(GBN+"insertUserHistory", req);
	}
	
	public List<UserHistoryVO> listTot(UserHistoryVO req) {
		req.setLength(0);
		return sqlSession.selectList(GBN+"list", req);
	}
	
    public List<UserHistoryVO> list(UserHistoryVO req) {
        return sqlSession.selectList(GBN+"list", req);
    } 


	
    public List<CustomLoginHistoryVO> loginHistoryListTot(CustomLoginHistoryVO req) {
		req.setLength(0);
		return sqlSession.selectList(GBN+"loginHistoryList", req);
	}
	
    public List<CustomLoginHistoryVO> loginHistoryList(CustomLoginHistoryVO req) {
        return sqlSession.selectList(GBN+"loginHistoryList", req);
    } 
    
    
    
    
    

}
