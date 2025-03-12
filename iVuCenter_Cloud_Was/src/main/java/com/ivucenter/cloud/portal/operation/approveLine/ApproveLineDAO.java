package com.ivucenter.cloud.portal.operation.approveLine;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ApproveLineDAO {
	
	private final String GBN = "com.ivucenter.cloud.portal.operation.adminuser.ApproveLineDAO.";
	
	@Autowired
	private SqlSession sqlSession;
	
	
	public List<CustomApproveLineVO> list(CustomApproveLineVO req){
		return sqlSession.selectList(GBN+"list", req);
	}
	public List<CustomApproveLineVO> listTot(CustomApproveLineVO req){
		req.setLength(0);
		return sqlSession.selectList(GBN+"list", req);
	}
	
	 public int insert(CustomApproveLineVO req) {
	    	return (int)sqlSession.update(GBN+"insert", req);
	 }
	 public int delete(CustomApproveLineVO req) {
		 return (int)sqlSession.update(GBN+"delete", req);
	 }
	 
	 public List<CustomApproveLineVO> getApproveLineList(CustomApproveLineVO req) {
			return sqlSession.selectList(GBN + "getApproveLineList",req);
		}
	 
	 public int approveLineUpdate(CustomApproveLineVO req) {
		 return (int)sqlSession.update(GBN+"approveLineUpdate", req);
	 }
	 
	 public CustomApproveLineVO stepMaxValue(CustomApproveLineVO req) {
			return sqlSession.selectOne(GBN + "stepMaxValue",req);
		}
	
}
