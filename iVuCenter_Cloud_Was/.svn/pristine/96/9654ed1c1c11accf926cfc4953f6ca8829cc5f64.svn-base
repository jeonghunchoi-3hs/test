package com.ivucenter.cloud.portal.login;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class LoginDAO {

	private final String GBN = "com.ivucenter.cloud.portal.login.LoginDAO.";
	
    @Autowired
    private SqlSession sqlSession;

	public int insertLoginHitory(CustomLoginHistoryVO req) {
		return sqlSession.insert(GBN+"insertLoginHitory", req);
	}
	
	
}
