package com.ivucenter.cloud.portal.bill.policy;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BillPolicyDAO {

	private final String GBN = "com.ivucenter.cloud.portal.bill.policy.BillPolicyDAO.";
	
    @Autowired
    private SqlSession sqlSession;

	public List<CustomBillPolicyVO> getBillPolicyList(CustomBillPolicyVO req) {
		return sqlSession.selectList(GBN + "getBillPolicyList",req);
	}
	
	public List<CustomBillPolicyVO> getBillPolicyListTot(CustomBillPolicyVO req) {
		req.setLength(0);
		return sqlSession.selectList(GBN + "getBillPolicyList",req);
	}

	public int cumlistTot(CustomBillPolicyVO req) {
		return sqlSession.selectOne(GBN + "cumlistTot",req);
	}

	public CustomBillPolicyVO getBillPolicyView(CustomBillPolicyVO req) {
		return sqlSession.selectOne(GBN + "getBillPolicyView",req);
	}
	
	public List<CustomBillPolicyVO> getBillItemList(CustomBillPolicyVO req) {
		return sqlSession.selectList(GBN + "getBillItemList",req);
	}
	
	public List<CustomBillPolicyVO> getBillTypeList(CustomBillPolicyVO req) {
		return sqlSession.selectList(GBN + "getBillTypeList",req);
	}

	public int setBillPolicy(CustomBillPolicyVO req) {
		return (int)sqlSession.insert(GBN+"setBillPolicy", req);
	}

	public List<CustomBillPolicyVO> getBillItemSearchList(CustomBillPolicyVO req) {
		return sqlSession.selectList(GBN + "getBillItemSearchList",req);
	}

	public int setBillPolicyItem(CustomBillPolicyVO req) {
		return (int)sqlSession.insert(GBN+"setBillPolicyItem", req);
	}

	public int setBillPolicyItemPrice(CustomBillPolicyVO req) {
		return (int)sqlSession.insert(GBN+"setBillPolicyItemPrice", req);
	}

	public List<CustomBillPolicyVO> getOldBillPolicyInfo(CustomBillPolicyVO billPolicyvo) {
		return sqlSession.selectList(GBN + "getOldBillPolicyInfo",billPolicyvo);
	}

	public int getBillPolicyCnt(CustomBillPolicyVO req) {
		return sqlSession.selectOne(GBN+"getBillPolicyCnt", req);
	}
	public int billProductCheck(CustomBillPolicyVO req) {
		return sqlSession.selectOne(GBN+"billProductCheck", req);
	}

	public CustomBillPolicyVO getBillPolicyInfo(CustomBillPolicyVO req) {
		return sqlSession.selectOne(GBN + "getBillPolicyInfo",req);
	}

	public int setBillPolicyEdit(CustomBillPolicyVO req) {
		return (int)sqlSession.update(GBN+"setBillPolicyEdit", req);
	}

	public CustomBillPolicyVO getBillItemEditVo(CustomBillPolicyVO req) {
		return sqlSession.selectOne(GBN+"getBillItemEditVo", req);
	}

	public int setBillPolicyItemEdit(CustomBillPolicyVO req) {
		return (int)sqlSession.update(GBN+"setBillPolicyItemEdit", req);
	}

	public List<CustomBillPolicyVO> getCopyBillPolicyInfo(CustomBillPolicyVO billPolicyvo) {
		return sqlSession.selectList(GBN + "getCopyBillPolicyInfo",billPolicyvo);
	}

	public int delete(CustomBillPolicyVO req) {
		return (int)sqlSession.delete(GBN+"delete", req);
	}
	public int deleteItem(CustomBillPolicyVO req) {
		return (int)sqlSession.delete(GBN+"deleteItem", req);
	}
	public int deleteItemPrice(CustomBillPolicyVO req) {
		return (int)sqlSession.delete(GBN+"deleteItemPrice", req);
	}
	
	
	public int billProductInsert(CustomBillPolicyVO req) {
		return (int)sqlSession.update(GBN+"billProductInsert", req);
	}
	public int billPolicyItemInsert(CustomBillPolicyVO req) {
		return (int)sqlSession.update(GBN+"billPolicyItemInsert", req);
	}
	public int billProductCatalogItemInsert(CustomBillPolicyVO req) {
		return (int)sqlSession.update(GBN+"billProductCatalogItemInsert", req);
	}
	
	
}
