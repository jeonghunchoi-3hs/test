package com.ivucenter.cloud.portal.cmm.user;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ivucenter.cloud.portal.cmm.customer.CustomCmmCustomerVO;
import com.ivucenter.cloud.portal.operation.approveUser.CustomApproveUserVO;

@Repository
public class CmmUserDAO {
	
	private final String GBN = "com.ivucenter.cloud.portal.cmm.user.CmmUserDAO.";
	
    @Autowired
    private SqlSession sqlSession;
    
    @Autowired
    @Resource(name="sqlSession3")
    private SqlSession sqlSession3;
    
    public List<CustomCmmUserVO> list(CustomCmmUserVO req) {
        return sqlSession.selectList(GBN+"list", req);
    } 
    public List<CustomCmmUserVO> listTotal(CustomCmmUserVO req) {
    	req.setLength(0);
    	return sqlSession.selectList(GBN+"list", req);
    } 
    public List<CustomCmmUserVO> listByCustomer(CustomCmmUserVO req) {
    	return sqlSession.selectList(GBN+"listByCustomer", req);
    }
    
	public CustomCmmUserVO detail(CustomCmmUserVO req) {
		return (CustomCmmUserVO) sqlSession.selectOne(GBN+"detail", req);
	}
	
	public CustomCmmUserVO loginChk(CustomCmmUserVO req) {
		return (CustomCmmUserVO) sqlSession.selectOne(GBN+"loginChk", req);
	}

	public CustomCmmUserVO userRoleCheck(CustomCmmUserVO req) {
		return (CustomCmmUserVO) sqlSession.selectOne(GBN+"userRoleCheck", req);
	}
	
	public int userPmCheck(CustomCmmUserVO req) {
		return (int) sqlSession.selectOne(GBN+"userPmCheck", req);
	}
	
	public int userPasswordCheck(CustomCmmUserVO req) {
		return (int) sqlSession.selectOne(GBN+"userPasswordCheck", req);
	}
	
	public CustomCmmUserVO userInfoDetail(CustomCmmUserVO req) {
		return (CustomCmmUserVO) sqlSession.selectOne(GBN+"userInfoDetail", req.getUserId());
	}
	
	public CustomCmmUserVO userInfoDetail(String userId) {
		return (CustomCmmUserVO) sqlSession.selectOne(GBN+"userInfoDetail", userId);
	}	
	
    public int insert(CustomCmmUserVO req) {
    	return (int)sqlSession.insert(GBN+"insert", req);
    }
	
    public int insertUserdescription(CustomCmmUserVO req) {
	    return (int)sqlSession.insert(GBN+"insertUserdescription", req);
	}

    public int update(CustomCmmUserVO req) {
    	return (int)sqlSession.update(GBN+"update", req);
    }

    public int userInfoUpdate(CustomCmmUserVO req) {
    	return (int)sqlSession.update(GBN+"userInfoUpdate", req);
    }

	public int delete(CustomCmmUserVO req) {
		return (int)sqlSession.update(GBN+"delete", req);
	}
	
	public CustomCmmUserVO getUserInfoByName(CustomCmmUserVO req) {
		return (CustomCmmUserVO) sqlSession.selectOne(GBN+"getUserInfoByName", req);
	}

	public int setUserPasswordReset(CustomCmmUserVO req) {
		return (int) sqlSession.update(GBN+"setUserPasswordReset", req);
	}
	
	public CustomCmmUserVO getUserInfoById(CustomCmmUserVO req) {
		return (CustomCmmUserVO) sqlSession.selectOne(GBN+"getUserInfoById", req);
	}

	public int userInfoUpdatepw(CustomCmmUserVO req) {
		return (int)sqlSession.update(GBN+"userInfoUpdatepw", req);
	}

	public int blockUpdate(CustomCmmUserVO req) {
		return (int)sqlSession.update(GBN+"blockUpdate", req);
	}
	
	// 회원사 아이디 중복체크 팝업
	public int setMbrFormchk(CustomCmmUserVO req) {
		return sqlSession.selectOne(GBN + "setMbrFormchk", req);
	}

	// 회원가입 신청
	public void setMbrForminsert(CustomCmmUserVO req) {
		sqlSession.insert(GBN + "setMbrForminsert", req);
	}
	
	// 회원사 조회 팝업
	public List<CustomCmmCustomerVO> selectCustomerList(CustomCmmCustomerVO req){
		return sqlSession.selectList(GBN + "selectCustomerList", req);
	}
	// 회원사 조회 팝업 Count
	public int selectCustomerListTot(CustomCmmCustomerVO req){
		return sqlSession.selectList(GBN + "selectCustomerList", req).size();
	}
	
	public String getTempPw(String userId){
		return sqlSession.selectOne(GBN + "getTempPw", userId);
	}
	
	//사용자관리 회원사정보 수정
	public int updateUserCustomer(CustomCmmUserVO req) {
		return (int)sqlSession.update(GBN+"updateUserCustomer", req);
	}
	public void loginOk(CustomCmmUserVO req) {
		sqlSession.update(GBN+"loginOk", req);		
	}
	public void failPassword(CustomCmmUserVO req) {
		sqlSession.update(GBN+"failPassword", req);		
	}
	
	public List<CustomCmmUserVO> worklist() {
		return sqlSession.selectList(GBN + "worklist");
	}
	
	// 회원가입 승인자 정보
	public List<CustomCmmUserVO> loginAdminDetail() {
		return sqlSession.selectList(GBN + "loginAdminDetail");
	}
	
	
	public CustomCmmUserVO loginUserApproveYn(String userId) {
		return (CustomCmmUserVO) sqlSession.selectOne(GBN+"loginUserApproveYn", userId);
	}
	
	public List<CustomApproveUserVO> searchUserInfo(CustomApproveUserVO req){
		return sqlSession3.selectList(GBN+"searchUserInfo", req);
	}
	
	public CustomCmmCustomerVO selectUserCloudCuthority(CustomCmmCustomerVO req){
		return sqlSession.selectOne(GBN + "selectUserCloudCuthority", req);
	}
	
	public int userCloudAuthupdate(CustomCmmUserVO req) {
		return sqlSession.update(GBN+"userCloudAuthupdate", req);
	}
	
//	ip check 추가 	
	public CustomCmmUserVO getUserInfo(String userId){
		return (CustomCmmUserVO) sqlSession.selectOne(GBN+"getUserInfo", userId);
	}
	
	public int userIpCheck(CustomCmmUserVO req) {
		return (int)sqlSession.selectOne(GBN+"userIpCheck", req);
	}	
}
