package com.ivucenter.cloud.portal.req.catalogue;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ivucenter.cloud.entity.OssFlavorVO;
import com.ivucenter.cloud.portal.mng.req.work.CustomMngOssVo;
import com.ivucenter.cloud.portal.oss.project.CustomOssProjectVO;
import com.ivucenter.cloud.portal.req.customer.CustomReqCustomerVO;
import com.ivucenter.cloud.portal.req.project.CustomReqProjectVO;

@Repository
public class ReqCatalogueDAO {

	private final String GBN = "com.ivucenter.cloud.portal.req.catalogue.ReqCatalogueDAO.";

    @Autowired
    private SqlSession sqlSession;
	public List<CustomReqCatalogueVO> getProjectList(CustomReqCatalogueVO projectvo) {
		return sqlSession.selectList(GBN + "getProjectList",projectvo);
	}

	public int getProjectListTot(CustomReqCatalogueVO projectvo) {
		projectvo.setLength(0);
		return sqlSession.selectList(GBN + "getProjectList",projectvo).size();
	}

	public List<CustomReqCatalogueVO> getDevEnvList(CustomReqCatalogueVO projectvo) {
		return sqlSession.selectList(GBN + "getDevEnvList",projectvo);
	}

	public int getDevEnvListTot(CustomReqCatalogueVO projectvo) {
		projectvo.setLength(0);
		return sqlSession.selectList(GBN + "getDevEnvList",projectvo).size();
	}

	public List<CustomMngOssVo> getSnapshots(CustomMngOssVo SnValue) {
		return sqlSession.selectList(GBN + "getSnapshots",SnValue);
	}

	public List<CustomReqCatalogueVO> networkVmPopList(CustomReqCatalogueVO projectvo) {
		return sqlSession.selectList(GBN + "networkVmPopList",projectvo);
	}

	public int networkVmPopListTot(CustomReqCatalogueVO projectvo) {
		projectvo.setLength(0);
		return sqlSession.selectList(GBN + "networkVmPopList",projectvo).size();
	}

	public List<CustomReqCatalogueVO> getCatalogueList(CustomReqCatalogueVO projectvo) {
		return sqlSession.selectList(GBN + "getCatalogueList",projectvo);
	}

	public List<CustomReqCatalogueVO> getCatalogueAppList(CustomReqCatalogueVO projectvo) {
		return sqlSession.selectList(GBN + "getCatalogueAppList",projectvo);
	}

	public List<CustomReqCatalogueVO> getContainerList(CustomReqCatalogueVO projectvo) {
		return sqlSession.selectList(GBN + "getContainerList",projectvo);
	}

	public List<CustomReqCatalogueVO> getCatalogueSubList(CustomReqCatalogueVO projectvo) {
		return sqlSession.selectList(GBN + "getCatalogueSubList",projectvo);
	}

	public CustomReqCatalogueVO getCatalogueSelectView(CustomReqCatalogueVO projectvo) {
		return sqlSession.selectOne(GBN + "getCatalogueSelectView",projectvo);
	}

	public CustomReqCatalogueVO getCatalogueSelectApp(CustomReqCatalogueVO projectvo) {
		return sqlSession.selectOne(GBN + "getCatalogueSelectApp",projectvo);
	}

	public CustomReqCatalogueVO getSelectContainer(CustomReqCatalogueVO projectvo) {
		return sqlSession.selectOne(GBN + "getSelectContainer",projectvo);
	}

	public CustomReqCatalogueVO getCatalogueItempric(CustomReqCatalogueVO projectvo) {
		return sqlSession.selectOne(GBN + "getCatalogueItempric",projectvo);
	}

	public List<CustomReqCatalogueVO> getCatalogueOslist(CustomReqCatalogueVO projectvo) {
		return sqlSession.selectList(GBN + "getCatalogueOslist",projectvo);
	}

	public List<OssFlavorVO> getCatalogueFlavorList(CustomReqCatalogueVO projectvo) {
		return sqlSession.selectList(GBN + "getCatalogueFlavorList", projectvo);
	}

	public List<OssFlavorVO> getFlavorTypeList(CustomReqCatalogueVO projectvo) {
		return sqlSession.selectList(GBN + "getFlavorTypeList", projectvo);
	}

	public int setOrderProductVm(CustomReqOrderVO ordervo) {
		return (int)sqlSession.insert(GBN+"setOrderProductVm", ordervo);
	}

	public CustomReqOrderVO getSnapshotInfo(CustomReqOrderVO ordervo) {
		return sqlSession.selectOne(GBN + "getSnapshotInfo", ordervo);
	}

	public int setOrderDirectProductVm(CustomReqOrderVO ordervo) {
		return (int)sqlSession.insert(GBN+"setOrderDirectProductVm", ordervo);
	}


	public int setOrderProduct(CustomReqOrderVO ordervo) {
		return (int)sqlSession.update(GBN+"setOrderProduct", ordervo);
	}

	public String detailProjectId(CustomReqOrderVO ordervo) {
		return sqlSession.selectOne(GBN+"detailProjectId",ordervo);
	}

	public String detailProjectId2(CustomReqOrderVO ordervo) {
		return sqlSession.selectOne(GBN+"detailProjectId2",ordervo);
	}

	public int setOrder(CustomReqOrderVO ordervo) {
		return (int)sqlSession.update(GBN+"setOrder", ordervo);
	}

	public int setOrderDirect(CustomReqOrderVO ordervo) {
		return (int)sqlSession.update(GBN+"setOrderDirect", ordervo);
	}

	public CustomReqCatalogueVO getCatalogueOs(CustomReqCatalogueVO osselectvo) {
		return sqlSession.selectOne(GBN + "getCatalogueOs",osselectvo);
	}

	public List<CustomReqCustomerVO> getApprovalModelSteplist() {
		return sqlSession.selectList(GBN + "getApprovalModelSteplist");
	}

	public void deleteApprovalStep(CustomReqProjectVO appmodelstep) {
		sqlSession.delete(GBN+"deleteApprovalStep", appmodelstep);
	}

	public void setSrApprovalStepinsert(CustomReqCustomerVO appmodelstep) {
		sqlSession.update(GBN+"setSrApprovalStepinsert", appmodelstep);
	}

	public void setSrApprovalMemberinsert(CustomReqCustomerVO appmember) {
		sqlSession.update(GBN+"setSrApprovalMemberinsert", appmember);
	}

	public List<CustomReqCustomerVO> getApprovalModelMemberlist() {
		return sqlSession.selectList(GBN + "getApprovalModelMemberlist");
	}

	public CustomReqCatalogueVO getProjectId(String projectId) {
		return sqlSession.selectOne(GBN + "getProjectId",projectId);
	}

	public int setBasket(CustomReqBasketVO basketvo) {
		return (int)sqlSession.update(GBN+"setBasket", basketvo);
	}

	public int setBasketVm(CustomReqBasketVO basketvo) {
		return (int)sqlSession.update(GBN+"setBasketVm", basketvo);
	}

	public List<CustomReqBasketVO> getBasketlist(CustomReqBasketVO basketvo) {
		return sqlSession.selectList(GBN + "getBasketlist", basketvo);
	}

	public int setBasketDel(CustomReqBasketVO basketvo) {
		return (int)sqlSession.update(GBN+"setBasketDel", basketvo);
	}

	public int setBasketVmDel(CustomReqBasketVO basketvo) {
		return (int)sqlSession.update(GBN+"setBasketVmDel", basketvo);
	}

	public List<CustomReqBasketVO> getBasketOrderList(Map<String, Object> map) {
		return sqlSession.selectList(GBN + "getBasketOrderList", map);
	}

	public List<CustomReqOrderVO> getPmOrderList(CustomReqOrderVO req) {
		return sqlSession.selectList(GBN + "getPmOrderList", req);
	}
	public CustomReqOrderVO getPmOrderStatusCnt(CustomReqOrderVO req) {
		return sqlSession.selectOne(GBN + "getPmOrderStatusCnt", req);
	}

	public List<CustomReqOrderVO> getOrderApproveList(CustomReqOrderVO req) {
		return sqlSession.selectList(GBN + "getOrderApproveList", req);
	}
	public CustomReqOrderVO getOrderApproveStatusCnt(CustomReqOrderVO req) {
		return sqlSession.selectOne(GBN + "getOrderApproveStatusCnt", req);
	}

	public int productApprovelistTot(CustomReqOrderVO req) {
		req.setLength(0);
		return sqlSession.selectList(GBN + "getOrderApproveList",req).size();
	}

	public List<CustomReqCustomerVO> approvalList(CustomReqCatalogueVO catalolovo) {
		return sqlSession.selectList(GBN + "approvalList", catalolovo);
	}

	public List<CustomReqCustomerVO> approvalUserId(CustomReqCatalogueVO catalolovo) {
		return sqlSession.selectList(GBN + "approvalUserId", catalolovo);
	}

	public CustomReqOrderVO orderview(CustomReqOrderVO req) {
		return sqlSession.selectOne(GBN + "orderview",req);
	}

	public List<CustomReqOrderVO> orderviewList(CustomReqOrderVO req) {
		return sqlSession.selectList(GBN + "orderviewList", req);
	}

	public List<CustomReqOrderVO> getCustomerOrderList(CustomReqOrderVO req) {
		return sqlSession.selectList(GBN + "getCustomerOrderList", req);
	}

	public List<CustomReqCustomerVO> getApprovalModelSteplist2() {
		return sqlSession.selectList(GBN + "getApprovalModelSteplist2");
	}

	public List<CustomReqCustomerVO> getApprovalModelSteplistProject() {
		return sqlSession.selectList(GBN + "getApprovalModelSteplistProject");
	}

	public List<CustomReqCustomerVO> getApprovalUserList() {
		return sqlSession.selectList(GBN + "getApprovalUserList");
	}

	public List<CustomReqCustomerVO> getApprovalModelMemberlist2() {
		return sqlSession.selectList(GBN + "getApprovalModelMemberlist2");
	}

	public List<CustomReqCustomerVO> getApprovalModelMemberlistProject() {
		return sqlSession.selectList(GBN + "getApprovalModelMemberlistProject");
	}
	public List<CustomReqCustomerVO> getApproveModelMemberlistProject(String userId) {
		return sqlSession.selectList(GBN + "getApproveModelMemberlistProject", userId);
	}

	public List<CustomReqDataStoreVO> getDataStoreList(String cloudId) {
		return sqlSession.selectList(GBN + "getDataStoreList", cloudId);
	}


	public void setSrApprovalStepinsert2(CustomReqCustomerVO appmodelstep) {
		sqlSession.update(GBN+"setSrApprovalStepinsert2", appmodelstep);
	}

	public void updateSrApprovalStepinsert(CustomReqCustomerVO appmodelstep) {
		sqlSession.update(GBN+"updateSrApprovalStepinsert", appmodelstep);
	}
	public void insertSrApprovalStepHis(CustomReqCustomerVO appmodelstep) {
		sqlSession.update(GBN+"insertSrApprovalStepHis", appmodelstep);
	}

	public void deleteSrApprovalStep(CustomReqCustomerVO appmodelstep) {
		sqlSession.update(GBN+"deleteSrApprovalStep", appmodelstep);
	}

	public void setSrApprovalStepinsertProject(CustomReqCustomerVO appmodelstep) {
		sqlSession.update(GBN+"setSrApprovalStepinsertProject", appmodelstep);
	}
	//프로젝트 1차 결재자 2차 결재자 선택되어진 사용자로 새팅
	public void updateProjectApprovalMemberInsert(CustomReqCustomerVO appmodelstep) {
		sqlSession.update(GBN+"updateProjectApprovalMemberInsert", appmodelstep);
	}

	//개발자 라인
	public void setDevUserInsert(CustomReqOrderVO devUserStepList) {
		sqlSession.update(GBN+"setDevUserInsert", devUserStepList);
	}

	public int projectStepCheck(CustomReqCustomerVO appmodelstep) {
		return sqlSession.selectOne(GBN+"projectStepCheck", appmodelstep);
	}

	public void setSrApprovalMemberinsert2(CustomReqCustomerVO appmodelstep) {
		sqlSession.update(GBN+"setSrApprovalMemberinsert2", appmodelstep);
	}

	public int projectMemberCheck(CustomReqCustomerVO appmodelstep) {
		return sqlSession.selectOne(GBN+"projectMemberCheck", appmodelstep);
	}

	public int cumlistTot(CustomReqOrderVO req) {
		return sqlSession.selectOne(GBN + "cumlistTot",req);
	}

	public int pmlistTot(CustomReqOrderVO req) {
		req.setLength(0);
		return sqlSession.selectList(GBN + "getPmOrderList",req).size();
	}

	public int userIdchk(String userId) {
		return sqlSession.selectOne(GBN + "userIdchk",userId);
	}

	public int hostnameChk(CustomReqOrderVO ordervo) {
		return sqlSession.selectOne(GBN + "hostnameChk", ordervo);
	}

	public List<CustomReqOrderVO> getMemberOrderList(CustomReqOrderVO req) {
		return sqlSession.selectList(GBN + "getMemberOrderList", req);
	}

	public int memberlistTot(CustomReqOrderVO req) {
		return sqlSession.selectOne(GBN + "memberlistTot",req);
	}
	public int reviewChk(CustomReqOrderVO req) {
		return sqlSession.selectOne(GBN + "reviewChk",req);
	}
	public int approveChk(CustomReqOrderVO req) {
		return sqlSession.selectOne(GBN + "approveChk",req);
	}

	public int setOrderProductVmNetwork(CustomReqOrderVO ordervo) {
		return (int)sqlSession.update(GBN+"setOrderProductVmNetwork", ordervo);
	}

	public int setBasketVmNetwork(CustomReqBasketVO setBasketNetworkVm) {
		return (int)sqlSession.update(GBN+"setBasketVmNetwork", setBasketNetworkVm);
	}

	public List<CustomReqBasketVO> getBasketVmList(String basketSeq) {
		return sqlSession.selectList(GBN + "getBasketVmList",basketSeq);
	}

	public int setBasketVmNetworkDel(CustomReqBasketVO basketvo) {
		return (int)sqlSession.update(GBN+"setBasketVmNetworkDel", basketvo);
	}

	public int setOrderProductDisk(CustomReqOrderVO ordervo) {
		return (int)sqlSession.insert(GBN+"setOrderProductDisk", ordervo);
	}

	public int setBasketDisk(CustomReqBasketVO basketvo) {
		return (int)sqlSession.update(GBN+"setBasketDisk", basketvo);
	}

	public int setOrderProductNas(CustomReqOrderVO ordervo) {
		return (int)sqlSession.insert(GBN+"setOrderProductNas", ordervo);
	}

	public int setOrderProductNasVm(CustomReqOrderVO ordervo) {
		return (int)sqlSession.insert(GBN+"setOrderProductNasVm", ordervo);
	}

	public int setOrderProductIp(CustomReqOrderVO ordervo) {
		return (int)sqlSession.insert(GBN+"setOrderProductIp", ordervo);
	}

	public List<CustomReqBasketVO> getBasketDisklistvo(CustomReqBasketVO basketvo) {
		return sqlSession.selectList(GBN + "getBasketDisklistvo", basketvo);
	}

	public List<CustomReqBasketVO> getBasketNaslistvo(CustomReqBasketVO basketvo) {
		return sqlSession.selectList(GBN + "getBasketNaslistvo", basketvo);
	}

	public List<CustomReqBasketVO> getBasketIplistvo(CustomReqBasketVO basketvo) {
		return sqlSession.selectList(GBN + "getBasketIplistvo", basketvo);
	}

	public List<CustomReqBasketVO> getBasketLblistvo(CustomReqBasketVO basketvo) {
		return sqlSession.selectList(GBN + "getBasketLblistvo", basketvo);
	}

//	public List<CustomReqBasketVO> getBasketSvlistvo(CustomReqBasketVO basketvo) {
//		return sqlSession.selectList(GBN + "getBasketSvlistvo", basketvo);
//	}

	public List<CustomReqBasketVO> getBasketDiskOrderList(Map<String, Object> map) {
		return sqlSession.selectList(GBN + "getBasketDiskOrderList", map);
	}

	public int setBasketDiskDel(CustomReqBasketVO basketvo) {
		return (int)sqlSession.update(GBN+"setBasketDiskDel", basketvo);
	}

	public List<CustomReqBasketVO> getBasketNasOrderList(Map<String, Object> map) {
		return sqlSession.selectList(GBN + "getBasketNasOrderList", map);
	}

	public int setBasketNasDel(CustomReqBasketVO basketvo) {
		return (int)sqlSession.update(GBN+"setBasketNasDel", basketvo);
	}

	public List<CustomReqBasketVO> getBasketIpOrderList(Map<String, Object> map) {
		return sqlSession.selectList(GBN + "getBasketIpOrderList", map);
	}

	public int setBasketIpDel(CustomReqBasketVO basketvo) {
		return (int)sqlSession.update(GBN+"setBasketIpDel", basketvo);
	}

	public int setOrderProductLb(CustomReqOrderVO ordervo) {
		return (int)sqlSession.insert(GBN+"setOrderProductLb", ordervo);
	}

	public int setOrderProductSn(CustomReqOrderVO ordervo) {
		return (int)sqlSession.insert(GBN+"setOrderProductSn", ordervo);
	}

	public int setOrderProductApp(CustomReqOrderVO ordervo) {
		return (int)sqlSession.insert(GBN+"setOrderProductApp", ordervo);
	}

	public int setOrderProductEnv(CustomReqOrderVO ordervo) {
		return (int)sqlSession.insert(GBN+"setOrderProductEnv", ordervo);
	}

	public List<CustomReqBasketVO> getBasketLbOrderList(Map<String, Object> map) {
		return sqlSession.selectList(GBN + "getBasketLbOrderList", map);
	}

	public int setBasketLbDel(CustomReqBasketVO basketvo) {
		return (int)sqlSession.update(GBN+"setBasketLbDel", basketvo);
	}

	public int setBasketNas(CustomReqBasketVO basketvo) {
		return (int)sqlSession.update(GBN+"setBasketNas", basketvo);
	}

	public int setBasketNasVm(CustomReqBasketVO basketvo) {
		return (int)sqlSession.update(GBN+"setBasketNasVm", basketvo);
	}

	public int setBasketIp(CustomReqBasketVO basketvo) {
		return (int)sqlSession.update(GBN+"setBasketIp", basketvo);
	}

	public List<CustomReqCatalogueVO> getVmNetworkList(CustomReqCatalogueVO projectvo) {
		return sqlSession.selectList(GBN + "getVmNetworkList",projectvo);
	}

	public List<CustomReqCatalogueVO> getNetworkList(CustomReqCatalogueVO projectvo) {
		return sqlSession.selectList(GBN + "getNetworkList",projectvo);
	}

	public CustomReqCatalogueVO getCatalogueSelectBasicView(CustomReqCatalogueVO projectvo) {
		return sqlSession.selectOne(GBN + "getCatalogueSelectBasicView",projectvo);
	}

	public CustomReqCatalogueVO getChangOrderViewPriceInfo(CustomReqCatalogueVO projectvo) {
		return sqlSession.selectOne(GBN + "getChangOrderViewPriceInfo",projectvo);
	}

	public List<CustomReqCatalogueVO> getCatalogueServiceList(CustomReqCatalogueVO projectvo) {
		return sqlSession.selectList(GBN + "getCatalogueServiceList", projectvo);
	}

	public CustomReqCatalogueVO getCatalogueServiceView(CustomReqCatalogueVO projectvo) {
		return sqlSession.selectOne(GBN + "getCatalogueServiceView",projectvo);
	}

//	public int setOrderProductServiceMca(CustomReqOrderVO ordervo) {
//		return (int)sqlSession.update(GBN+"setOrderProductServiceMca", ordervo);
//	}

//	public int setOrderProductServiceScm(CustomReqOrderVO ordervo) {
//		return (int)sqlSession.update(GBN+"setOrderProductServiceScm", ordervo);
//	}

//	public int setOrderProductServiceScr(CustomReqOrderVO ordervo) {
//		return (int)sqlSession.update(GBN+"setOrderProductServiceScr", ordervo);
//	}

//	public List<CustomReqBasketVO> getBasketMcalistvo(CustomReqBasketVO basketvo) {
//		return sqlSession.selectList(GBN + "getBasketMcalistvo", basketvo);
//	}

//	public int setBasketMca(CustomReqBasketVO basketvo) {
//		return (int)sqlSession.update(GBN+"setBasketMca", basketvo);
//	}

//	public List<CustomReqBasketVO> getBasketMcaOrderList(Map<String, Object> map) {
//		return sqlSession.selectList(GBN + "getBasketMcaOrderList", map);
//	}

//	public List<CustomReqBasketVO> getBasketScmOrderList(Map<String, Object> map) {
//		return sqlSession.selectList(GBN + "getBasketScmOrderList", map);
//	}

//	public List<CustomReqBasketVO> getBasketScrOrderList(Map<String, Object> map) {
//		return sqlSession.selectList(GBN + "getBasketScrOrderList", map);
//	}

//	public int setBasketScm(CustomReqBasketVO basketvo) {
//		return (int)sqlSession.update(GBN+"setBasketScm", basketvo);
//	}

//	public int setBasketScr(CustomReqBasketVO basketvo) {
//		return (int)sqlSession.update(GBN+"setBasketScr", basketvo);
//	}

//	public List<CustomReqBasketVO> getBasketScmlistvo(CustomReqBasketVO basketvo) {
//		return sqlSession.selectList(GBN + "getBasketScmlistvo", basketvo);
//	}

//	public List<CustomReqBasketVO> getBasketSerlistvo(CustomReqBasketVO basketvo) {
//		return sqlSession.selectList(GBN + "getBasketSerlistvo", basketvo);
//	}

//	public int setOrderProductMca(CustomReqOrderVO ordervo) {
//		return (int)sqlSession.insert(GBN+"setOrderProductServiceMca", ordervo);
//	}

//	public int setBasketMcaDel(CustomReqBasketVO basketvo) {
//		return (int)sqlSession.update(GBN+"setBasketMcaDel", basketvo);
//	}

//	public int setBasketScmDel(CustomReqBasketVO basketvo) {
//		return (int)sqlSession.update(GBN+"setBasketScmDel", basketvo);
//	}

//	public int setBasketSerDel(CustomReqBasketVO basketvo) {
//		return (int)sqlSession.update(GBN+"setBasketSerDel", basketvo);
//	}

//	public int setOrderProductServiceBak(CustomReqOrderVO ordervo) {
//		return (int)sqlSession.update(GBN+"setOrderProductServiceBak", ordervo);
//	}

	public int setOrderProductServiceService(CustomReqOrderVO ordervo) {
		return (int)sqlSession.update(GBN+"setOrderProductServiceService", ordervo);
	}

//	public int setBasketBak(CustomReqBasketVO basketvo) {
//		return (int)sqlSession.update(GBN+"setBasketBak", basketvo);
//	}

	//서비스 입력
	public int setBasketService(CustomReqBasketVO basketvo) {
		return (int)sqlSession.update(GBN+"setBasketService", basketvo);
	}

//	public List<CustomReqBasketVO> getBasketBaklistvo(CustomReqBasketVO basketvo) {
//		return sqlSession.selectList(GBN + "getBasketBaklistvo", basketvo);
//	}

	public List<CustomReqBasketVO> getBasketServicelistvo(CustomReqBasketVO basketvo) {
		return sqlSession.selectList(GBN + "getBasketServicelistvo", basketvo);
	}

//	public List<CustomReqBasketVO> getBasketBakOrderList(Map<String, Object> map) {
//		return sqlSession.selectList(GBN + "getBasketBakOrderList", map);
//	}
	public List<CustomReqBasketVO> getBasketServiceOrderList(Map<String, Object> map) {
		return sqlSession.selectList(GBN + "getBasketServiceOrderList", map);
	}

//	public int setBasketbakDel(CustomReqBasketVO basketvo) {
//		return (int)sqlSession.update(GBN+"setBasketbakDel", basketvo);
//	}

//	public int setBasketServiceDel(CustomReqBasketVO basketvo) {
//		return (int)sqlSession.update(GBN+"setBasketServiceDel", basketvo);
//	}

	public int setBasketLoad(CustomReqBasketVO basketvo) {
		return (int)sqlSession.update(GBN+"setBasketLoad", basketvo);
	}

	public int setBasketLoadVm(CustomReqBasketVO basketvo) {
		return (int)sqlSession.update(GBN+"setBasketLoadVm", basketvo);
	}

	public int setChkBasketDel(Map<String, Object> map) {
		return (int)sqlSession.update(GBN+"setChkBasketDel", map);
	}

	public int setChkBasketVmDel(Map<String, Object> map) {
		return (int)sqlSession.update(GBN+"setChkBasketVmDel", map);
	}

	public int setChkBasketVmNetworkDel(Map<String, Object> map) {
		return (int)sqlSession.update(GBN+"setChkBasketVmNetworkDel", map);
	}

	public int setChkBasketDiskDel(Map<String, Object> map) {
		return (int)sqlSession.update(GBN+"setChkBasketDiskDel", map);
	}

	public int setChkBasketNasDel(Map<String, Object> map) {
		return (int)sqlSession.update(GBN+"setChkBasketNasDel", map);
	}

	public int setChkBasketLbDel(Map<String, Object> map) {
		return (int)sqlSession.update(GBN+"setChkBasketLbDel", map);
	}

	public int setChkBasketIpDel(Map<String, Object> map) {
		return (int)sqlSession.update(GBN+"setChkBasketIpDel", map);
	}

//	public int setChkBasketbakDel(Map<String, Object> map) {
//		return (int)sqlSession.update(GBN+"setChkBasketbakDel", map);
//	}

	public int setChkBasketserviceDel(Map<String, Object> map) {
		return (int)sqlSession.update(GBN+"setChkBasketserviceDel", map);
	}

//	public int setChkBasketScmDel(Map<String, Object> map) {
//		return (int)sqlSession.update(GBN+"setChkBasketScmDel", map);
//	}

//	public int setChkBasketMcaDel(Map<String, Object> map) {
//		return (int)sqlSession.update(GBN+"setChkBasketMcaDel", map);
//	}

//	public int setChkBasketSerDel(Map<String, Object> map) {
//		return (int)sqlSession.update(GBN+"setChkBasketSerDel", map);
//	}

	public int setChkBasketLbNetDel(Map<String, Object> map) {
		return (int)sqlSession.update(GBN+"setChkBasketLbNetDel", map);
	}

	public List<CustomReqBasketVO> getBasketLbNetList(String basketSeq) {
		return sqlSession.selectList(GBN + "getBasketLbNetList", basketSeq);
	}

	public int setOrderProductLbVm(CustomReqOrderVO ordervo) {
		return (int)sqlSession.update(GBN+"setOrderProductLbVm", ordervo);
	}

	public int setBasketLbVmDel(CustomReqBasketVO basketvo) {
		return (int)sqlSession.update(GBN+"setBasketLbVmDel", basketvo);
	}

	public List<CustomReqOrderVO> orderDiskviewList(CustomReqOrderVO req) {
		return sqlSession.selectList(GBN + "orderDiskviewList", req);
	}

	public List<CustomReqOrderVO> orderNasviewList(CustomReqOrderVO req) {
		return sqlSession.selectList(GBN + "orderNasviewList", req);
	}

	public List<CustomReqOrderVO> orderLbviewList(CustomReqOrderVO req) {
		return sqlSession.selectList(GBN + "orderLbviewList", req);
	}

	public List<CustomReqOrderVO> orderSnviewList(CustomReqOrderVO req) {
		return sqlSession.selectList(GBN + "orderSnviewList", req);
	}

	public List<CustomReqOrderVO> orderAppviewList(CustomReqOrderVO req) {
		return sqlSession.selectList(GBN + "orderAppviewList", req);
	}

	public List<CustomReqOrderVO> orderAppviewList_sub(CustomReqOrderVO req) {
		return sqlSession.selectList(GBN + "orderAppviewList_sub", req);
	}

	public List<CustomReqOrderVO> orderEnvviewList_sub(CustomReqOrderVO req) {
		return sqlSession.selectList(GBN + "orderEnvviewList_sub", req);
	}

	public List<CustomReqOrderVO> orderIpviewList(CustomReqOrderVO req) {
		return sqlSession.selectList(GBN + "orderIpviewList", req);
	}

//	public List<CustomReqOrderVO> orderBakviewList(CustomReqOrderVO req) {
//		return sqlSession.selectList(GBN + "orderBakviewList", req);
//	}

	public List<CustomReqOrderVO> orderServiceviewList(CustomReqOrderVO req) {
		return sqlSession.selectList(GBN + "orderServiceviewList", req);
	}

//	public List<CustomReqOrderVO> getReqScmOrderList(CustomReqOrderVO req) {
//		return sqlSession.selectList(GBN + "getReqScmOrderList", req);
//	}

//	public List<CustomReqOrderVO> getReqMcaOrderList(CustomReqOrderVO req) {
//		return sqlSession.selectList(GBN + "getReqMcaOrderList", req);
//	}

//	public List<CustomReqOrderVO> getReqSerOrderList(CustomReqOrderVO req) {
//		return sqlSession.selectList(GBN + "getReqSerOrderList", req);
//	}

//	public int setOrderBackVm(CustomReqOrderVO setVmUuid) {
//		return (int)sqlSession.update(GBN+"setOrderBackVm", setVmUuid);
//	}

//	public int setBasketBackVm(CustomReqBasketVO setVmUuid) {
//		return (int)sqlSession.update(GBN+"setBasketBackVm", setVmUuid);
//	}

//	public List<CustomReqBasketVO> getBasketBackVmList(String basketSeq) {
//		return sqlSession.selectList(GBN + "getBasketBackVmList", basketSeq);
//	}
//	public List<CustomReqBasketVO> getBasketServiceVmList(String basketSeq) {
//		return sqlSession.selectList(GBN + "getBasketServiceVmList", basketSeq);
//	}

//	public int setBasketBackupVmDel(CustomReqBasketVO basketvo) {
//		return (int)sqlSession.update(GBN+"setBasketBackupVmDel", basketvo);
//	}

	public List<CustomReqCustomerVO> getApprovalModelMemberlist3(String stepLevel) {
		return sqlSession.selectList(GBN + "getApprovalModelMemberlist3",stepLevel);
	}

	public int getBasketCnt(String userId) {
		return sqlSession.selectOne(GBN + "getBasketCnt", userId);
	}

	public int getBasketCnt(CustomOssProjectVO req) {
		return sqlSession.selectOne(GBN + "getBasketCnt", req);
	}

	public CustomReqBasketCountVO checkProject(CustomReqCatalogueVO ordervo) {
		return sqlSession.selectOne(GBN + "checkProject", ordervo);
	}

	public List<CustomReqCatalogueVO> getCatalogueAppVersionList(CustomReqCatalogueVO projectvo) {
		return sqlSession.selectList(GBN + "getCatalogueAppVersionList",projectvo);
	}

	public int getAutoScaleOutCnt(String appUid) {
		return sqlSession.selectOne(GBN + "getAutoScaleOutCnt", appUid);
	}

	public int getAppCnt(String projectBoxId) {
		return sqlSession.selectOne(GBN + "getAppCnt", projectBoxId);
	}

	public int pathChk(String nasFileSystemPath) {
		return sqlSession.selectOne(GBN + "pathChk", nasFileSystemPath);
	}

	public String getOpsNasProjectId(CustomReqCatalogueVO projectvo) {
		return sqlSession.selectOne(GBN + "getOpsNasProjectId", projectvo);
	}

	public int checkContainerTerminal(String vmUuId) {
		return sqlSession.selectOne(GBN + "checkContainerTerminal", vmUuId);
	}
}
