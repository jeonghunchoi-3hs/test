package com.ivucenter.cloud.portal.cmm.file;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CmmFileDAO {

	private final String GBN = "com.ivucenter.cloud.portal.cmm.file.CmmFileDAO.";
	
    @Autowired
    private SqlSession sqlSession;
    
    public List<CustomCmmFileVO> list(CustomCmmFileVO req) {
        return sqlSession.selectList(GBN+"list", req);
    } 
    
	public CustomCmmFileVO detail(String fileId) {
		return (CustomCmmFileVO) sqlSession.selectOne(GBN+"detail", fileId);
	}
    
    public int insert(CustomCmmFileVO req) {
    	return (int)sqlSession.insert(GBN+"insert", req);
    }

	public int delete(CustomCmmFileVO req) {
		return (int)sqlSession.delete(GBN+"delete", req);
	}

	public CustomCmmFileVO findById(CustomCmmFileVO req) {
		return (CustomCmmFileVO) sqlSession.selectOne(GBN+"findById", req);
	}
}
