package com.ivucenter.cloud.portal.operation.approveUser;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ApproveUserDAO {
	
	private final String GBN = "com.ivucenter.cloud.portal.operation.approveUser.ApproveUserDAO.";
	
	@Autowired
	private SqlSession sqlSession;
	
	public List<CustomApproveUserVO> list(CustomApproveUserVO req){
		return sqlSession.selectList(GBN+"list", req);
	}
	public List<CustomApproveUserVO> listTot(CustomApproveUserVO req){
		req.setLength(0);
		return sqlSession.selectList(GBN+"list", req);
	}
	
	public List<CustomApproveUserVO> projectManagerCheck(CustomApproveUserVO req){
		req.setLength(0);
		return sqlSession.selectList(GBN+"projectManagerCheck", req);
	}
	
	public List<CustomApproveUserVO> ossProjectManagerCheck(CustomApproveUserVO req){
		req.setLength(0);
		return sqlSession.selectList(GBN+"ossProjectManagerCheck", req);
	}
	
	public List<CustomApproveUserVO> projectManagerCount(CustomApproveUserVO req){
		req.setLength(0);
		return sqlSession.selectList(GBN+"projectManagerCount", req);
	}
	
	public List<CustomApproveUserVO> ossProjectManagerCount(CustomApproveUserVO req){
		req.setLength(0);
		return sqlSession.selectList(GBN+"ossProjectManagerCount", req);
	}
	
	
	public List<CustomApproveUserVO> projectList(CustomApproveUserVO req){
		return sqlSession.selectList(GBN+"projectList", req);
	}
	
	public List<CustomApproveUserVO> projectManagerList(CustomApproveUserVO req){
		return sqlSession.selectList(GBN+"projectManagerList", req);
	}
	public List<CustomApproveUserVO> projectManagerWriteList(CustomApproveUserVO req){
		return sqlSession.selectList(GBN+"projectManagerWriteList", req);
	}
	
	public List<CustomApproveUserVO> ossProjectManagerList(CustomApproveUserVO req){
		return sqlSession.selectList(GBN+"ossProjectManagerList", req);
	}
	
	public List<CustomApproveUserVO> projectListTot(CustomApproveUserVO req){
		req.setLength(0);
		return sqlSession.selectList(GBN+"projectList", req);
	}
	
	public List<CustomApproveUserVO> addList(CustomApproveUserVO req){
		return sqlSession.selectList(GBN+"addList", req);
	}
	public List<CustomApproveUserVO> addProjectApproveList(CustomApproveUserVO req){
		return sqlSession.selectList(GBN+"addProjectApproveList", req);
	}
	public List<CustomApproveUserVO> addProjectApprove2List(CustomApproveUserVO req){
		return sqlSession.selectList(GBN+"addProjectApprove2List", req);
	}
	public List<CustomApproveUserVO> addProjectManageList(CustomApproveUserVO req){
		return sqlSession.selectList(GBN+"addProjectManageList", req);
	}
	public List<CustomApproveUserVO> addOssProjectManageList(CustomApproveUserVO req){
		return sqlSession.selectList(GBN+"addOssProjectManageList", req);
	}
	public String insertAdmin(CustomApproveUserVO req) {
		return (int)sqlSession.insert(GBN+"insertAdmin", req)+"";
	}
	public String insertManager(CustomApproveUserVO req) {
		return (int)sqlSession.insert(GBN+"insertManager", req)+"";
	}
	public String updateManager(CustomApproveUserVO req) {
		return (int)sqlSession.insert(GBN+"updateManager", req)+"";
	}
	
	public String ossInsertManager(CustomApproveUserVO req) {
		return (int)sqlSession.insert(GBN+"ossInsertManager", req)+"";
	}
	
	public String updateAdmin(CustomApproveUserVO req) {
		return (int)sqlSession.update(GBN+"updateAdmin", req)+"";
	}
	public String updatePm(CustomApproveUserVO req) {
		return (int)sqlSession.update(GBN+"updatePm", req)+"";
	}
	public CustomApproveUserVO auth(CustomApproveUserVO req) {
		return sqlSession.selectOne(GBN+"auth", req);
	}
	public String updateAuth(CustomApproveUserVO req) {
		return (int)sqlSession.update(GBN+"updateAuth", req)+"";
	}
	public void deleteApproval(CustomApproveUserVO req) {
		sqlSession.delete(GBN+"deleteApproval", req);		
	}
	
}
