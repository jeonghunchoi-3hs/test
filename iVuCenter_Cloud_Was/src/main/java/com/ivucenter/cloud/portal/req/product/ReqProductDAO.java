package com.ivucenter.cloud.portal.req.product;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.util.Assert;

import com.ivucenter.cloud.portal.oss.project.CustomOssProjectVO;
import com.ivucenter.cloud.portal.req.customer.CustomReqCustomerVO;
import com.ivucenter.cloud.portal.req.project.CustomReqProjectVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class ReqProductDAO {

	private final String GBN = "com.ivucenter.cloud.portal.req.product.ReqProductDAO.";

    @Autowired
    private SqlSession sqlSession;

	public List<CustomReqProductVO> list(CustomReqProductVO req ){
		return sqlSession.selectList(GBN + "list",req);
	}

	public List<CustomReqProductVO> listTot(CustomReqProductVO req) {
		req.setLength(0);
		return sqlSession.selectList(GBN + "list",req);
	}

	public List<CustomReqProductVO> orderView(String orderNo) {
		return sqlSession.selectList(GBN + "orderView", orderNo);
	}

	public CustomReqProductVO orderUserInfo(String orderNo) {
		return sqlSession.selectOne(GBN + "orderUserInfo", orderNo);
	}

	public List<CustomReqProductVO> approvalUserId(String orderNo) {

		log.debug("스텝멤버 아이디 조회");
		return sqlSession.selectList(GBN + "approvalUserId",orderNo);
	}

	public List<CustomReqProductVO> approvalList(Map<String, String> map) {
		log.debug("사용자포털 스텝멤버 조회");
		return sqlSession.selectList(GBN + "approvalList",map);
	}

	public List<CustomReqProductVO> approvalList2(Map<String, String> map) {
		log.debug("관리자포털 스텝멤버 조회");
		return sqlSession.selectList(GBN + "approvalList2",map);
	}


	public CustomReqProductVO detailBssOrderProductVm(String orderProductSeq) {
		return sqlSession.selectOne(GBN+"detailBssOrderProductVm", orderProductSeq);
	}

	public CustomReqProductVO detailBssOrderProductDisk(String orderProductSeq) {
		return sqlSession.selectOne(GBN+"detailBssOrderProductDisk", orderProductSeq);
	}

	public CustomReqProductVO detailBssOrderProductNas(String orderProductSeq) {
		return sqlSession.selectOne(GBN+"detailBssOrderProductNas", orderProductSeq);
	}

	public CustomReqProductVO detailBssOrderProductApp(String orderProductSeq) {
		return sqlSession.selectOne(GBN+"detailBssOrderProductApp", orderProductSeq);
	}

	public CustomReqProductVO detailBssOrderProductEnv(String orderProductSeq) {
		return sqlSession.selectOne(GBN+"detailBssOrderProductEnv", orderProductSeq);
	}

	public CustomReqProductVO detailBssOrderProductService(String orderProductSeq) {
		return sqlSession.selectOne(GBN+"detailBssOrderProductService", orderProductSeq);
	}

	public List<CustomReqProductVO> detail(String orderNo) {
		return sqlSession.selectList(GBN+"detail", orderNo);
	}

	public CustomReqProductVO detail1(String orderNo) {
		log.debug("상품 상제 조회 한개");
		return sqlSession.selectOne(GBN+"detail1", orderNo);
	}

	public int rejectedUpdate(CustomReqCustomerVO req ) {
		return sqlSession.update(GBN+"rejectedUpdate", req);
	}

	public int reqProjectRejectedUpdate(CustomReqCustomerVO req ) {
		return sqlSession.update(GBN+"reqProjectRejectedUpdate", req);
	}

	public int newUpdate(CustomReqProductVO req ) {
		return sqlSession.update(GBN+"newUpdate", req);
	}

	public List<String> getNetworkList(String orderProductSeq) {
		return sqlSession.selectList(GBN + "getNetworkList",orderProductSeq);
	}


	public List<CustomReqProductVO> getReqDiskOrderList(String orderNo) {
		return sqlSession.selectList(GBN + "getReqDiskOrderList", orderNo);
	}

	public List<CustomReqProductVO> getReqNasOrderList(String orderNo) {
		return sqlSession.selectList(GBN + "getReqNasOrderList", orderNo);
	}

	public List<CustomReqProductVO> getReqIpOrderList(String orderNo) {
		return sqlSession.selectList(GBN + "getReqIpOrderList", orderNo);
	}

	public List<CustomReqProductVO> getReqLbOrderList(String orderNo) {
		return sqlSession.selectList(GBN + "getReqLbOrderList", orderNo);
	}

	public List<CustomReqProductVO> getReqSnOrderList(String orderNo) {
		return sqlSession.selectList(GBN + "getReqSnOrderList", orderNo);
	}

	public List<CustomReqProductVO> getReqAppOrderList(String orderNo) {
		return sqlSession.selectList(GBN + "getReqAppOrderList", orderNo);
	}

	public List<CustomReqProductVO> getReqEnvOrderList(String orderNo) {
		return sqlSession.selectList(GBN + "getReqEnvOrderList", orderNo);
	}

	public List<CustomReqProductVO> getReqPrdOrderList(String orderNo) {
		return sqlSession.selectList(GBN + "getReqPrdOrderList", orderNo);
	}

	public List<CustomReqProductVO> bssEnvUserList(String cicdProjectId) {
		return sqlSession.selectList(GBN+"bssEnvUserList", cicdProjectId);
	}


//	public List<CustomReqProductVO> getReqBakOrderList(String orderNo) {
//		return sqlSession.selectList(GBN + "getReqBakOrderList", orderNo);
//	}

	public List<CustomReqProductVO> getReqServiceOrderList(String orderNo) {
		return sqlSession.selectList(GBN + "getReqServiceOrderList", orderNo);
	}

//	public List<CustomReqProductVO> getReqMcaOrderList(String orderNo) {
//		return sqlSession.selectList(GBN + "getReqMcaOrderList", orderNo);
//	}

//	public List<CustomReqProductVO> getReqScmOrderList(String orderNo) {
//		return sqlSession.selectList(GBN + "getReqScmOrderList", orderNo);
//	}

//	public List<CustomReqProductVO> getReqScrOrderList(String orderNo) {
//		return sqlSession.selectList(GBN + "getReqScrOrderList", orderNo);
//	}

//	public List<CustomReqProductVO> getReqSerOrderList(String orderNo) {
//		return sqlSession.selectList(GBN + "getReqSerOrderList", orderNo);
//	}

	public List<CustomReqProductVO> getReqVMOrderList(String orderNo) {
		return sqlSession.selectList(GBN + "getReqVMOrderList", orderNo);
	}

	public List<CustomReqProductVO> getReqOrderList(String orderNo) {
		return sqlSession.selectList(GBN + "getReqOrderList", orderNo);
	}

	public CustomReqProductVO getOrderVm(String orderNo) {
		return sqlSession.selectOne(GBN + "getOrderVm", orderNo);
	}

	public List<CustomReqProductVO> pmList(CustomReqProductVO req) {
		return sqlSession.selectList(GBN + "pmList", req);
	}

	public int setReqWork(CustomReqProductVO reqWork) {
		return sqlSession.insert(GBN + "setReqWork",reqWork);
	}

	public int getProductNameChk(CustomReqProductVO reqWork) {
		return sqlSession.selectOne(GBN + "getProductNameChk",reqWork);
	}


	public int stepUpdate(CustomReqProductVO req) {
		return sqlSession.update(GBN + "stepUpdate",req);
	}

	public int reqProjectUpdate(CustomReqProductVO req) {
		return sqlSession.update(GBN + "reqProjectUpdate",req);
	}

	public int stepUpdateUser(CustomReqProductVO req) {
		return sqlSession.update(GBN + "stepUpdateUser",req);
	}

	public String getStepId(Map<String, String> map) {
		return sqlSession.selectOne(GBN + "getStepId",map);
	}

	public String getUserApprvState(Map<String, String> map) {
		return sqlSession.selectOne(GBN + "getUserApprvState",map);
	}

	public int setUpdateWorkUser(CustomReqProductVO req) {
		return sqlSession.update(GBN + "setUpdateWorkUser",req);
	}

	public List<CustomReqProductVO> checkWorkUser(CustomReqProductVO req) {
		return sqlSession.selectList(GBN + "checkWorkUser",req);
	}
	public List<CustomReqProductVO> setHostNameCheck(CustomReqProductVO req) {
		return sqlSession.selectList(GBN + "setHostNameCheck",req);
	}
	public List<CustomReqProductVO> setUserIdCheck(CustomReqProductVO req) {
		return sqlSession.selectList(GBN + "setUserIdCheck",req);
	}
	public List<CustomReqProductVO> setUserPwCheck(CustomReqProductVO req) {
		return sqlSession.selectList(GBN + "setUserPwCheck",req);
	}




	public int insertOssVmNetwork(CustomReqProductVO vm) {
		return (int)sqlSession.insert(GBN+"insertOssVmNetwork", vm);
	}


	public int insertOssVm(CustomReqProductVO req) {
		return (int)sqlSession.insert(GBN+"insertOssVm", req);
	}

//	public int updateOssVm(CustomReqProductVO req) {
//		return sqlSession.update(GBN + "updateOssVm",req);
//	}
//	public int deleteOssVm(CustomReqProductVO req) {
//		return sqlSession.update(GBN + "deleteOssVm",req);
//	}
//	public int insertOssDisk(CustomReqProductVO req) {
//		return (int)sqlSession.insert(GBN+"insertOssDisk", req);
//	}
//	public int CustomReqProductVO req) {
//		return sqlSession.update(GBN + "updateOssDisk",req);
//	}
//	public int deleteOssDisk(CustomReqProductVO req) {
//		return sqlSession.update(GBN + "deleteOssDisk",req);
//	}

	public List<CustomReqProductVO> detailBbsOrder(String orderNo) {
		return sqlSession.selectList(GBN+"detailBbsOrder", orderNo);
	}

	public CustomReqProductVO getOrderVo(String orderNo) {
		return sqlSession.selectOne(GBN+"getOrderVo", orderNo);
	}

	public int insertProvisioningQueue(CustomReqProductVO req) {
		return (int)sqlSession.insert(GBN+"insertProvisioningQueue", req);
	}

	public List<CustomReqProductVO> getCloudAvailList(String orderNo) {
		return sqlSession.selectList(GBN+"getCloudAvailList", orderNo);
	}

	public List<CustomReqProductVO> getCloudAvail(String projectBoxId) {
		return sqlSession.selectList(GBN+"getCloudAvail", projectBoxId);
	}

//	public CustomReqProductVO getCompany(String orderNo) {
//		return sqlSession.selectOne(GBN+"getCompany", orderNo);
//	}


	public CustomReqProductVO getReqDiskOrder(String orderProductSeq) {
		return sqlSession.selectOne(GBN + "getReqDiskOrder", orderProductSeq);
	}

	public CustomReqProductVO getReqNasOrder(String orderProductSeq) {
		return sqlSession.selectOne(GBN + "getReqNasOrder", orderProductSeq);
	}

	public CustomReqProductVO getReqIpOrder(String orderProductSeq) {
		return sqlSession.selectOne(GBN + "getReqIpOrder", orderProductSeq);
	}

	public CustomReqProductVO getReqLbOrder(String orderProductSeq) {
		return sqlSession.selectOne(GBN + "getReqLbOrder", orderProductSeq);
	}

//	public CustomReqProductVO getReqBakOrder(String orderProductSeq) {
//		return sqlSession.selectOne(GBN + "getReqBakOrder", orderProductSeq);
//	}

	public CustomReqProductVO getReqServiceOrder(String orderProductSeq) {
		return sqlSession.selectOne(GBN + "getReqServiceOrder", orderProductSeq);
	}

	public CustomReqProductVO getReqAppOrder(String orderProductSeq) {
		return sqlSession.selectOne(GBN + "getReqAppOrder", orderProductSeq);
	}

	public CustomReqProductVO getReqEnvOrder(String orderProductSeq) {
		return sqlSession.selectOne(GBN + "getReqEnvOrder", orderProductSeq);
	}

//	public CustomReqProductVO getReqMcaOrder(String orderProductSeq) {
//		return sqlSession.selectOne(GBN + "getReqMcaOrder", orderProductSeq);
//	}

//	public CustomReqProductVO getReqScmOrder(String orderProductSeq) {
//		return sqlSession.selectOne(GBN + "getReqScmOrder", orderProductSeq);
//	}

//	public CustomReqProductVO getReqScrOrder(String orderProductSeq) {
//		return sqlSession.selectOne(GBN + "getReqScrOrder", orderProductSeq);
//	}

	public CustomReqProductVO getReqVmOrder(String orderProductSeq) {
		return sqlSession.selectOne(GBN + "getReqVmOrder", orderProductSeq);
	}

	public List<CustomReqProductVO> stepIdList(String stepId) {
		return sqlSession.selectList(GBN+"stepIdList", stepId);
	}

	public int setUpdateHostName(CustomReqProductVO req) {
		return sqlSession.update(GBN + "setUpdateHostName", req);
	}

	public int setUpdateIp(CustomReqProductVO req) {
		return sqlSession.update(GBN + "setUpdateIp", req);
	}

	public int setUpdateBackupIp(CustomReqProductVO req) {
		return sqlSession.update(GBN + "setUpdateBackupIp", req);
	}

	public int setUpdateNasIp(CustomReqProductVO req) {
		return sqlSession.update(GBN + "setUpdateNasIp", req);
	}

	public int setUpdateUserId(CustomReqProductVO req) {
		return sqlSession.update(GBN + "setUpdateUserId", req);
	}

	public int setUpdateUserPw(CustomReqProductVO req) {
		return sqlSession.update(GBN + "setUpdateUserPw", req);
	}

	public List<CustomReqProductVO> setIpCheck(CustomReqProductVO req) {
		return sqlSession.selectList(GBN + "setIpCheck", req);
	}

	public List<CustomReqProductVO> setNasIpCheck(CustomReqProductVO req) {
		return sqlSession.selectList(GBN + "setNasIpCheck", req);
	}

	public List<CustomReqProductVO> setBackupIpCheck(CustomReqProductVO req) {
		return sqlSession.selectList(GBN + "setBackupIpCheck", req);
	}

	public CustomReqProductVO getProvisioningStatus(String orderProductSeq) {
		return sqlSession.selectOne(GBN + "getProvisioningStatus", orderProductSeq);
	}

	public int changeProvisioning(CustomReqProductVO req) {
		return sqlSession.update(GBN + "changeProvisioning", req);
	}
	public int endProvisioning(CustomReqProductVO req) {
		return sqlSession.update(GBN + "endProvisioning", req);
	}

	public List<CustomReqProductVO> getOrderList(CustomReqProductVO req){
		return sqlSession.selectList(GBN + "getOrderList", req);
	}

	public List<CustomReqProductVO> getSumVm(CustomReqProductVO req){
		return sqlSession.selectList(GBN + "getSumVm", req);
	}

	public List<CustomReqProductVO> getSumDisk(CustomReqProductVO req){
		return sqlSession.selectList(GBN + "getSumDisk", req);
	}
	public List<CustomReqProductVO> getSumService(CustomReqProductVO req){
		return sqlSession.selectList(GBN + "getSumService", req);
	}
	public List<CustomReqProductVO> getSumLB(CustomReqProductVO req){
		return sqlSession.selectList(GBN + "getSumLB", req);
	}
	public List<CustomReqProductVO> getSumSN(CustomReqProductVO req){
		return sqlSession.selectList(GBN + "getSumSN", req);
	}
	public List<CustomReqProductVO> getSumAPP(CustomReqProductVO req){
		return sqlSession.selectList(GBN + "getSumAPP", req);
	}

	public CustomReqProductVO getFlaverDetail(CustomReqProductVO req){
		return sqlSession.selectOne(GBN + "getFlaverDetail", req);
	}

	public CustomReqProductVO processSumVm(CustomReqProductVO req){
		return sqlSession.selectOne(GBN + "processSumVm", req);
	}
	public CustomReqProductVO processSumDisk(CustomReqProductVO req){
		return sqlSession.selectOne(GBN + "processSumDisk", req);
	}
	public CustomReqProjectVO getAdminProject() {
		return sqlSession.selectOne(GBN + "getAdminProject","");
	}

	public int bssOrderProductUpdate(CustomReqProductVO req) {
		return sqlSession.update(GBN + "bssOrderProductUpdate",req);
	}
	public int bssOrderProductVmUpdate(CustomReqProductVO req) {
		return sqlSession.update(GBN + "bssOrderProductVmUpdate",req);
	}

	public int bssOrderProductNasUpdate(CustomReqProductVO req) {
		return sqlSession.update(GBN + "bssOrderProductNasUpdate",req);
	}

	public int bssOrderProductAppNameChk(CustomReqProductVO req) {
		log.info("getAppName {}", req.getAppName());
		log.info("getProjectId {}", req.getProjectId());
		Assert.notNull(req.getAppName(), "");
		Assert.notNull(req.getProjectId(), "");
		return sqlSession.selectOne(GBN + "bssOrderProductAppNameChk", req);
	}

	public List<CustomReqProductVO> detailBssOrder(String orderNo) {
		return sqlSession.selectList(GBN+"detailBssOrder", orderNo);
	}

	public int bssOrderProductAppUpdate(CustomReqProductVO req) {
		return sqlSession.update(GBN + "bssOrderProductAppUpdate",req);
	}

	public int envGrpUrlChk(CustomReqProductVO req){
		return sqlSession.selectOne(GBN+"envGrpUrlChk", req);
	}

	public int envNameChk(CustomReqProductVO req){
		return sqlSession.selectOne(GBN+"envNameChk", req);
	}

	public int envGroupNameChk(CustomReqProductVO req){
		return sqlSession.selectOne(GBN+"envGroupNameChk", req);
	}

	public int envNameInsert(CustomReqProductVO req) {
		return sqlSession.update(GBN+"envNameInsert", req);
	}

	public int envGroupNameInsert(CustomReqProductVO req) {
		return sqlSession.update(GBN+"envGroupNameInsert", req);
	}

}