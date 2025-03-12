package com.ivucenter.cloud.portal.cmm.customer;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ivucenter.cloud.portal.req.customer.CustomReqCustomerVO;

@Repository
public class CmmCustomerDAO {
	
	private final String GBN = "com.ivucenter.cloud.portal.cmm.customer.CmmCustomerDAO.";
	
    @Autowired
    private SqlSession sqlSession;
    
    public List<CustomCmmCustomerVO> list(CustomCmmCustomerVO req) {
        return sqlSession.selectList(GBN+"list", req);
    } 
	public List<CustomCmmCustomerVO> listTot(CustomCmmCustomerVO req) {
		req.setLength(0);
		return sqlSession.selectList(GBN+"list", req);
	}
	public List<CustomCmmCustomerVO> listAll() {
		return sqlSession.selectList(GBN+"listAll");
	}
	public CustomCmmCustomerVO detail(CustomCmmCustomerVO req) {
		return (CustomCmmCustomerVO) sqlSession.selectOne(GBN+"detail", req);
	}
    public int insert(CustomCmmCustomerVO req) {
    	return (int)sqlSession.insert(GBN+"insert", req);
    }

    public int update(CustomCmmCustomerVO req) {
    	return (int)sqlSession.update(GBN+"update", req);
    }
    
    public int customerInfoUpdate(CustomCmmCustomerVO req) {
    	return (int)sqlSession.update(GBN+"customerInfoUpdate", req);
    }

	public int delete(CustomCmmCustomerVO req) {
		return (int)sqlSession.update(GBN+"delete", req);
	}
	//회원사에 등록된 프로젝트 확인
	public int customerProjectcnt(CustomReqCustomerVO req) {		
		return sqlSession.selectOne(GBN+"customerProjectcnt", req);
	}

	public CustomCmmCustomerVO getCustomerInfo(CustomCmmCustomerVO req) {
		return (CustomCmmCustomerVO) sqlSession.selectOne(GBN+"getCustomerInfo", req);
	}

	public int setSearchResult(CustomCmmCustomerVO req) {
		return (int) sqlSession.update(GBN+"setSearchResult", req);
	}

	public CustomCmmCustomerVO getCustomerInfopw(CustomCmmCustomerVO req) {
		return (CustomCmmCustomerVO) sqlSession.selectOne(GBN+"getCustomerInfopw", req);
	}

	public int setUserInfo(CustomCmmCustomerVO getUserInfo) {
		return (int) sqlSession.update(GBN+"setUserInfo", getUserInfo);
	}

	public int getCustomerexprcnt(CustomCmmCustomerVO req) {
		return  sqlSession.selectOne(GBN+"getCustomerexprcnt", req);
	}

	public int customerInfoUpdatepw(CustomCmmCustomerVO req) {
		return (int)sqlSession.update(GBN+"customerInfoUpdatepw", req);
	}

	public List<CustomCmmCustomerVO> vatRateList() {
		 return sqlSession.selectList(GBN+"vatRateList");
	}

	public List<CustomCmmCustomerVO> getCustomerMemberList(CustomCmmCustomerVO req) {
		return sqlSession.selectList(GBN+"getCustomerMemberList", req);
	}

	public int customerInsert(CustomCmmCustomerVO req) {
		return (int)sqlSession.insert(GBN+"customerInsert", req);
	}

public int setUserCustomadminInsert(CustomCmmCustomerVO req) {
		return (int)sqlSession.update(GBN+"setUserCustomadminInsert", req);
	}

	public int setCustomadminInsert(CustomCmmCustomerVO req) {
		return (int)sqlSession.update(GBN+"setCustomadminInsert", req);
	}

	public int customerEdit(CustomCmmCustomerVO req) {
		return (int)sqlSession.update(GBN+"customerEdit", req);
	}

	public CustomCmmCustomerVO detailManagerId(CustomCmmCustomerVO req) {
		return (CustomCmmCustomerVO) sqlSession.selectOne(GBN+"detailManagerId", req);
	}

	public List<CustomCmmCustomerVO> userList(CustomCmmCustomerVO req) {
		return sqlSession.selectList(GBN+"userList", req);
	}
	public Integer userListTot(CustomCmmCustomerVO req) {
		req.setLength(0);
		return sqlSession.selectList(GBN+"userList", req).size();
	}

	public CustomCmmCustomerVO detailUser(CustomCmmCustomerVO req) {
		return sqlSession.selectOne(GBN+"detailUser", req);
	}

	public int editUser(CustomCmmCustomerVO req) {
		return (int)sqlSession.update(GBN+"editUser", req);
	}

	public CustomCmmCustomerVO setManageridChk(CustomCmmCustomerVO req) {
		return sqlSession.selectOne(GBN+"setManageridChk", req);
	}

	public CustomCmmCustomerVO getuserAuthView(CustomCmmCustomerVO manageridChk) {
		return sqlSession.selectOne(GBN+"getuserAuthView", manageridChk);
	}

	public int setuserAuthChg(CustomCmmCustomerVO userAuthView) {
		return (int)sqlSession.update(GBN+"setuserAuthChg", userAuthView);
	}
	
	
	// Chart 최근3개월 청구금액
	public List<CustomCmmCustomerVO> get3MonthAmount(CustomCmmCustomerVO req){
		return sqlSession.selectList(GBN+"get3MonthAmount", req);
	}
	// Chart 최근3개월 청구금액
//	public List<CustomCmmCustomerVO> get3MonthAmount2(CustomCmmCustomerVO req){
//		return sqlSession.selectList(GBN+"get3MonthAmount2", req);
//	}
	// 청구예상금액 당월 사용금액
	public CustomCmmCustomerVO getCurrentAmount(CustomCmmCustomerVO req){
		return sqlSession.selectOne(GBN+"getCurrentAmount", req);
	}
	
	// Chart 리소스별 총사용량
	public CustomCmmCustomerVO getResourceTotalAmount(CustomCmmCustomerVO req){
		return sqlSession.selectOne(GBN+"getResourceTotalAmount", req);
	}
	public int companyNoChk(CustomCmmCustomerVO req) {
		return sqlSession.selectOne(GBN+"companyNoChk", req);
	}
	
	public List<CustomCmmCustomerVO> upCompanyList () {
		return sqlSession.selectList(GBN+"upCompanyList", null);
	}

	public List<CustomCmmCustomerVO> companySelectList (CustomCmmCustomerVO req) {
		return sqlSession.selectList(GBN+"companySelectList", req);
	}
	
	public List<CustomCmmCustomerVO> companyList (CustomCmmCustomerVO req) {
		return sqlSession.selectList(GBN+"companyList", req);
	}
	
	public List<CustomCmmCustomerVO> getCompanyFullList (CustomCmmCustomerVO req) {
		return sqlSession.selectList(GBN+"companyFullList", req);
	}
	public int vatRateEdit(CustomCmmCustomerVO req) {
		return (int)sqlSession.update(GBN+"vatRateEdit", req);
	}
	
	
}
