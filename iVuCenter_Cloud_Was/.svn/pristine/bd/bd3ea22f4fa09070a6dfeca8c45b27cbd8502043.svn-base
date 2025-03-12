package com.ivucenter.cloud.portal.pss.server;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class PssServerDAO {
	
	private final String GBN = "com.ivucenter.cloud.portal.pss.server.PssServerDAO.";
	
    @Autowired
    private SqlSession sqlSession;
    
    public List<CustomPssServerVO> pssServerList() {
        return sqlSession.selectList(GBN+"pssServerList");
    } 

}
