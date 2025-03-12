package com.ivucenter.cloud.portal.cmm.department;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CmmDepartmentDAO {
	
	private final String GBN="com.ivucenter.cloud.portal.cmm.department.CmmDepartmentDAO.";
	
	@Autowired
	private SqlSession sqlSession;
	
	public List<CustomCmmDepartmentVO> listAll() {
		return sqlSession.selectList(GBN+"listAll");
	}
	
	public List<CustomCmmDepartmentVO> list(CustomCmmDepartmentVO vo) {
		return sqlSession.selectList(GBN+"list");
	}
	
	public List<CustomCmmDepartmentVO> listTot(CustomCmmDepartmentVO req) {
    	req.setLength(0);
        return sqlSession.selectList(GBN+"list", req);
    }
	
	public List<CustomCmmDepartmentVO> TreeAll(CustomCmmDepartmentVO req) {    	
        return sqlSession.selectList(GBN+"TreeAll", req);
    }
	
	public CustomCmmDepartmentVO detail(CustomCmmDepartmentVO req) {
		return (CustomCmmDepartmentVO) sqlSession.selectOne(GBN+"detail", req);
	}
	
	public String insert(CustomCmmDepartmentVO req) {
		return (int) sqlSession.insert(GBN+"insert", req)+"";
	}
	
	public String update(CustomCmmDepartmentVO req) {
		return (int)sqlSession.update(GBN+"update", req)+"";
	}

}
