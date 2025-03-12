package com.ivucenter.cloud.portal.req.customer;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class ReqCustomerDAO {

	private final String GBN = "com.ivucenter.cloud.portal.req.customer.CustomerDAO.";
	

	@Autowired
	private SqlSession sqlSession;
	
	public List<CustomReqCustomerVO> getCompanyList(){
		
		return sqlSession.selectList(GBN + "getCompanyList");
	}


	public void setCustomerForminsert(CustomReqCustomerVO customervo) {
		sqlSession.update(GBN + "setCustomerForminsert", customervo);
	}
	
	public List<CustomReqCustomerVO> getApprovalModelSteplist(){
		
		return sqlSession.selectList(GBN + "getApprovalModelSteplist");
	}


	public void setSrApprovalStepinsert(CustomReqCustomerVO appmodelstep) {
		sqlSession.update(GBN + "setSrApprovalStepinsert", appmodelstep);
	}


	public List<CustomReqCustomerVO> getApprovalModelMemberlist() {
		return sqlSession.selectList(GBN + "getApprovalModelMemberlist");
	}


	public void setSrApprovalMemberinsert(CustomReqCustomerVO appmember) {
		sqlSession.update(GBN + "setSrApprovalMemberinsert", appmember);
	}


	public String getCustomefIdcheck(String customerId) {
		return sqlSession.selectOne(GBN + "getCustomefIdcheck", customerId);
	}


	public String getCustomerNamecheck(String customerName) {
		return sqlSession.selectOne(GBN + "getCustomerNamecheck", customerName);
	}


	public boolean getCustomerNameajaxcheck(String customerName) {
		
		return sqlSession.selectOne(GBN + "getCustomerNameajaxcheck", customerName);
	}


	public int setCustomerFormchk(CustomReqCustomerVO customervo) {		
		return sqlSession.selectOne(GBN + "setCustomerFormchk", customervo);
	}

	/**
	 * 濡쒓렇�씤�뿉�꽌 �궗�슜
	 * @param customervo
	 * @return
	 */
	public CustomReqCustomerVO getCompanySelectList(CustomReqCustomerVO customervo) {
		return (CustomReqCustomerVO) sqlSession.selectOne(GBN+"getCompanySelectList", customervo);
	}
	//pho
		public List<CustomReqCustomerVO> list(CustomReqCustomerVO req) {
			log.debug("회원사 가입신청 리스트");
			return sqlSession.selectList(GBN + "list",req);
		}
		
		public int listTot(CustomReqCustomerVO req) {
			return (int)sqlSession.selectOne(GBN+"listTot", req);
		}
		
		public CustomReqCustomerVO detail(String requestSeq) {
			return (CustomReqCustomerVO) sqlSession.selectOne(GBN+"detail", requestSeq);
		}
		public int rejectedUpdate(CustomReqCustomerVO req) {
			   return (int)sqlSession.update(GBN+"rejectedUpdate", req);
		}		
		public int newUpdate(CustomReqCustomerVO req) {
		   return (int)sqlSession.update(GBN+"newUpdate", req);
	   	}
		
		public int update(CustomReqCustomerVO req) {
			   return (int)sqlSession.update(GBN+"update", req);
	   	}
		
		public int exprUpdate(CustomReqCustomerVO req) {
			   return (int)sqlSession.update(GBN+"exprUpdate", req);
	   	}
		
		public int stepUpdate(CustomReqCustomerVO req) {
			   return (int)sqlSession.update(GBN+"stepUpdate", req);
	   	}

		public int insert(CustomReqCustomerVO req) {
			return (int)sqlSession.insert(GBN+"insert", req);
		}
		public List<CustomReqCustomerVO> approvalList(String requestSeq) {
			
			log.debug("승인 멤버 조회");
			return sqlSession.selectList(GBN + "approvalList",requestSeq);
		}
		public List<CustomReqCustomerVO> approvalUserId(String requestSeq) {
			
			log.debug("승인 멤버아이디 조회");
			return sqlSession.selectList(GBN + "approvalUserId",requestSeq);
		}
}
