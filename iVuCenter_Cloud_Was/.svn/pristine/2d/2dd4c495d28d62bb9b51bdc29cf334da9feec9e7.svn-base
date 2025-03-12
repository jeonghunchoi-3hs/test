package com.ivucenter.cloud.portal.home;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ivucenter.cloud.portal.oss.disk.CustomStorageVO;

@Repository
public class PotalHomeDAO {

	private final String GBN = "com.ivucenter.cloud.portal.home.PotalHomeDAO.";
	
    @Autowired
    private SqlSession sqlSession;

	public CustomMbrHomeVO userReVO(CustomMbrHomeVO loginUserId) {
		return sqlSession.selectOne(GBN+"userReVO", loginUserId);		
	}

	public List<CustomMbrHomeVO> userReVOList(CustomMbrHomeVO loginUserId) {
		return sqlSession.selectList(GBN+"userReVOList", loginUserId);
	}

	public CustomMbrHomeVO userProcessVO(CustomMbrHomeVO loginUserId) {
		return sqlSession.selectOne(GBN+"userProcessVO", loginUserId);	
	}

	public CustomMbrHomeVO userWorkProcessVO(CustomMbrHomeVO loginUserId) {
		return sqlSession.selectOne(GBN+"userWorkProcessVO", loginUserId);
	}

	public CustomMbrHomeVO userCompletedVO(CustomMbrHomeVO loginUserId) {
		return sqlSession.selectOne(GBN+"userCompletedVO", loginUserId);
	}

	public CustomMbrHomeVO userRejectedVO(CustomMbrHomeVO loginUserId) {
		return sqlSession.selectOne(GBN+"userRejectedVO", loginUserId);
	}

	public List<CustomMbrHomeVO> userApprvstateList(CustomMbrHomeVO loginUserId) {
		return sqlSession.selectList(GBN+"userApprvstateList", loginUserId);
	}
	
	public List<CustomMbrHomeVO> billInvoiceByProject(CustomMbrHomeVO req){
		return sqlSession.selectList(GBN+"billInvoiceByProject", req);
	}
	
	public List<CustomMbrHomeVO> billInvoiceByCustomer(CustomMbrHomeVO req){
		return sqlSession.selectList(GBN+"billInvoiceByCustomer", req);
	}

	public CustomMbrHomeVO customerCnt(CustomMbrHomeVO req){
		return sqlSession.selectOne(GBN+"customerCnt", req);
	}

	public CustomMbrHomeVO workCnt(CustomMbrHomeVO req) {
		return sqlSession.selectOne(GBN+"workCnt", req);
	}
	
	public List<CustomMbrHomeVO> userDashboardInfo(CustomMbrHomeVO req) {
		return sqlSession.selectList(GBN+"userDashboardInfo", req);
	}
	
	public List<CustomMbrHomeVO> userNoticeList() {
		return sqlSession.selectList(GBN+"userNoticeList");
	}
	public List<CustomMbrHomeVO> userQnaLast(CustomMbrHomeVO req) {
		return sqlSession.selectList(GBN+"userQnaLast", req);
	}
	public List<CustomMbrHomeVO> userBillTwoMonth(CustomMbrHomeVO req) {
		return sqlSession.selectList(GBN+"userBillTwoMonth", req);
	}

	public String timer() {
		return sqlSession.selectOne(GBN+"timer");
	}
	
	public CustomMbrHomeVO cloudUsage(CustomMbrHomeVO req) {
		return sqlSession.selectOne(GBN+"cloudUsage", req);		
	}
	
	public List<CustomMbrHomeVO> mngQnaList(CustomMbrHomeVO req) {
		return sqlSession.selectList(GBN+"mngQnaList", req);		
	}
	
	public CustomMbrHomeVO mngCloudService(CustomMbrHomeVO req) {
		return sqlSession.selectOne(GBN+"mngCloudService", req);		
	}
	
	public CustomMbrHomeVO mngCustomerCount(CustomMbrHomeVO req) {
		return sqlSession.selectOne(GBN+"mngCustomerCount", req);		
	}
	
	public CustomMbrHomeVO mngCustomerAmount(CustomMbrHomeVO req) {
		return sqlSession.selectOne(GBN+"mngCustomerAmount", req);		
	}
	
	public List<CustomMbrHomeVO> mngCustomerAmount6month(CustomMbrHomeVO req) {
		return sqlSession.selectList(GBN+"mngCustomerAmount6month", req);		
	}
	
	public CustomMbrHomeVO myJobCount(CustomMbrHomeVO req) {
		return sqlSession.selectOne(GBN+"myJobCount", req);		
	}
	
	public CustomMbrHomeVO totGoodCount(CustomMbrHomeVO req) {
		return sqlSession.selectOne(GBN+"totGoodCount", req);		
	}
	
	public CustomMbrHomeVO totBillCount(CustomMbrHomeVO req) {
		return sqlSession.selectOne(GBN+"totBillCount", req);		
	}
	
	
	public CustomMbrHomeVO mbrProjectReq(CustomMbrHomeVO req) {
		return sqlSession.selectOne(GBN+"mbrProjectReq", req);		
	}
	
	public CustomMbrHomeVO mbrProjectApprove(CustomMbrHomeVO req) {
		return sqlSession.selectOne(GBN+"mbrProjectApprove", req);		
	}
	
	public CustomMbrHomeVO mbrProductReq(CustomMbrHomeVO req) {
		return sqlSession.selectOne(GBN+"mbrProductReq", req);		
	}
	public CustomMbrHomeVO mbrProductApprove(CustomMbrHomeVO req) {
		return sqlSession.selectOne(GBN+"mbrProductApprove", req);		
	}
	public List<CustomMbrHomeVO> mbrProjectResources(CustomMbrHomeVO req) {
		return sqlSession.selectList(GBN+"mbrProjectResources", req);		
	}
	public List<CustomMbrHomeVO> mbrServiceResources(CustomMbrHomeVO req) {
		return sqlSession.selectList(GBN+"mbrServiceResources", req);		
	}
	public List<CustomMbrHomeVO> mbrProjectResourcesList(CustomMbrHomeVO req) {
		return sqlSession.selectList(GBN+"mbrProjectResourcesList", req);		
	}
	public List<CustomMbrHomeVO> mbrProjectResourcesListTotal(CustomMbrHomeVO req) {
		return sqlSession.selectList(GBN+"mbrProjectResourcesListTotal", req);		
	}
	
	///////////////////////////////////////////////
	
	public CustomMbrHomeVO mngProjectApprove() {
		return sqlSession.selectOne(GBN+"mngProjectApprove");		
	}
	public CustomMbrHomeVO mngProductApprove() {
		return sqlSession.selectOne(GBN+"mngProductApprove");		
	}
	public CustomMbrHomeVO mngMyWork() {
		return sqlSession.selectOne(GBN+"mngMyWork");		
	}
	public CustomMbrHomeVO mngUserApprove() {
		return sqlSession.selectOne(GBN+"mngUserApprove");		
	}
	public List<CustomMbrHomeVO> myAllWork(CustomMbrHomeVO req) {
		return sqlSession.selectList(GBN+"myAllWork", req);		
	}
	public List<CustomMbrHomeVO> mngCloudProduct() {
		return sqlSession.selectList(GBN+"mngCloudProduct");		
	}
	public List<CustomMbrHomeVO> mngProductAvr() {
		return sqlSession.selectList(GBN+"mngProductAvr");		
	}
	public CustomMbrHomeVO mngCloudAmount() {
		return sqlSession.selectOne(GBN+"mngCloudAmount");		
	}
	public List<CustomMbrHomeVO> availHistoryAvr() {
		return sqlSession.selectList(GBN+"availHistoryAvr");		
	}
	
	public List<CustomMbrHomeVO> vmUsedHistory() {
		return sqlSession.selectList(GBN+"vmUsedHistory");		
	}
	
	public List<CustomMbrHomeVO> monthVm() {
		return sqlSession.selectList(GBN+"monthVm");		
	}
	
	public List<CustomStorageVO> getStorageList(String cloudId) {
		return sqlSession.selectList(GBN+"getStorageList",cloudId);		
	}
	
}
