package com.ivucenter.cloud.portal.operation.adminuser;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AdminUserDAO {
	
	private final String GBN = "com.ivucenter.cloud.portal.operation.adminuser.AdminUserDAO.";
	
	@Autowired
	private SqlSession sqlSession;
	
	
	public List<CustomAdminUserVO> list(CustomAdminUserVO req){
		return sqlSession.selectList(GBN+"list", req);
	}
	public List<CustomAdminUserVO> listTot(CustomAdminUserVO req){
		req.setLength(0);
		return sqlSession.selectList(GBN+"list", req);
	}
	public List<CustomAdminUserVO> addList(CustomAdminUserVO req){
		return sqlSession.selectList(GBN+"addList", req);
	}
	public String insertAdmin(CustomAdminUserVO req) {
		return (int)sqlSession.insert(GBN+"insertAdmin", req)+"";
	}
	public String updateAdmin(CustomAdminUserVO req) {
		return (int)sqlSession.update(GBN+"updateAdmin", req)+"";
	}
	public CustomAdminUserVO auth(CustomAdminUserVO req) {
		return sqlSession.selectOne(GBN+"auth", req);
	}
	public String LoginAuth() {
		return (int) sqlSession.selectOne(GBN+"LoginAuth") + "";
	}
	public String updateAuth(CustomAdminUserVO req) {
		return (int)sqlSession.update(GBN+"updateAuth", req)+"";
	}
	public void deleteApproval(CustomAdminUserVO req) {
		sqlSession.delete(GBN+"deleteApproval", req);		
	}
	public String updateCloudAuth(CustomAdminUserVO req) {
		return (int)sqlSession.update(GBN+"updateCloudAuth", req)+"";
	}
	
//	
//	
//	public CustomAdminUserVO view(CustomAdminUserVO req){
//		return sqlSession.selectOne(GBN+"view", req);
//	}
//
//	public List<CustomAdminUserVO> userList(CustomAdminUserVO req){
//		
//		return sqlSession.selectList(GBN+"userList", req);
//	}
//	public int userListTot(CustomAdminUserVO req){
//		req.setLength(0);
//		return sqlSession.selectList(GBN+"userList", req).size();
//	}
//
//	public String updateRole(CustomAdminUserVO req){
//		return sqlSession.update(GBN+"updateRole", req)+"";
//	}

	
}
