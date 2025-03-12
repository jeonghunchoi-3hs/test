package com.ivucenter.cloud.portal.req.user;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ivucenter.cloud.portal.cmm.customer.CustomCmmCustomerVO;


@Repository
public class ReqUserDAO {
	
	private final String GBN = "com.ivucenter.cloud.portal.req.user.ReqUserDAO.";
	
    @Autowired
    private SqlSession sqlSession;
    
    public List<CustomReqUserVO> list(CustomReqUserVO req) {
        return sqlSession.selectList(GBN+"list", req);
    } 
    public List<CustomReqUserVO> listTotal(CustomReqUserVO req) {
    	req.setLength(0);
    	return sqlSession.selectList(GBN+"list", req);
    } 
    public List<CustomReqUserVO> listByCustomer(CustomReqUserVO req) {
    	return sqlSession.selectList(GBN+"listByCustomer", req);
    }    
    public CustomReqUserVO detail(CustomReqUserVO req) {
		return (CustomReqUserVO) sqlSession.selectOne(GBN+"detail", req);
	}
    
	public List<CustomReqUserVO> getUserList() {
		return sqlSession.selectList(GBN + "getUserList");
	}

	public CustomReqUserVO getUserView(CustomReqUserVO req) {
		return sqlSession.selectOne(GBN + "getUserView", req);
	}
	public CustomReqUserVO getReqUserById(CustomReqUserVO req) {
		return sqlSession.selectOne(GBN + "getReqUserById", req);
	}
	

	// 사용자 가입 저장
	public int setUserInsert(CustomReqUserVO reqUserVo) {
		return (int)sqlSession.insert(GBN+"setUserInsert", reqUserVo);
	}    
	//사용자 아이디 중복 체크
	public int setMbrFormchk(CustomReqUserVO reqUserVo) {
		return sqlSession.selectOne(GBN+"setMbrFormchk", reqUserVo);
	}		
	// 고객사 리스트
	public List<CustomCmmCustomerVO> selectCustomerList(CustomCmmCustomerVO customerVo){
		return sqlSession.selectList(GBN + "selectCustomerList", customerVo);
	}
	// 부서 리스트
	public List<CustomReqUserVO> selectDepartmentList(CustomReqUserVO reqUserVo){
		return sqlSession.selectList(GBN + "selectDepartmentList", reqUserVo);
	}
	// 사용자 복사 (req_user to cmm_user)
	public int copyUserInfoToCmm(CustomReqUserVO managerVo) {
		return (int) sqlSession.insert(GBN+"copyUserInfoToCmm", managerVo);
	}
	// 사용자 승인 
	public int  setUserConfirm(CustomReqUserVO managerVo) {
		return (int) sqlSession.update(GBN+"setUserConfirm", managerVo);
	}	
	// 사용자 삭제
	public int delete(String userId) {
		return (int) sqlSession.delete(GBN+"delete", userId);
	}
	
}
