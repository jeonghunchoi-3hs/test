package com.ivucenter.cloud.portal.bss.adjustment;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BssAdjustmentDAO {

	private final String GBN = "com.ivucenter.cloud.portal.bss.adjustment.BssAdjustmentDAO.";
	
    @Autowired
    private SqlSession sqlSession;

	public List<CustomBssAdjustmentVO> list(CustomBssAdjustmentVO req) {
		return sqlSession.selectList(GBN + "list",req);
	}
	public List<CustomBssAdjustmentVO> listTot(CustomBssAdjustmentVO req) {
		req.setLength(0);
		return sqlSession.selectList(GBN + "list",req);
	}
	public int insert(CustomBssAdjustmentVO req) {
		return (int)sqlSession.insert(GBN+"insert", req);
	}
	public int delete(CustomBssAdjustmentVO req) {
		return (int)sqlSession.update(GBN+"delete", req);
	}
	public CustomBssAdjustmentVO detail(CustomBssAdjustmentVO req) {
		return sqlSession.selectOne(GBN + "detail",req);
	}
	public int update(CustomBssAdjustmentVO req) {
		return (int)sqlSession.update(GBN+"update", req);
	}
	public CustomBssAdjustmentVO getProjectName(CustomBssAdjustmentVO req) {
		return sqlSession.selectOne(GBN + "getProjectName",req);
	}
	public List<CustomBssAdjustmentVO> getBillYyyy() {
		return sqlSession.selectList(GBN + "getBillYyyy");
	}	
	public List<CustomBssAdjustmentVO> getBillMasterYyyymmList() {
		return sqlSession.selectList(GBN + "getBillMasterYyyymmList");
	}

	
	/*
	public List<CustomBssAdjustmentVO> getProjectList(CustomBssAdjustmentVO projectvo) {
		return sqlSession.selectList(GBN + "getProjectList",projectvo);
	}
	public CustomBssAdjustmentVO getApprovalCheck(CustomBssAdjustmentVO req){
		return sqlSession.selectOne(GBN + "getApprovalCheck",req);
	}
*/
}
