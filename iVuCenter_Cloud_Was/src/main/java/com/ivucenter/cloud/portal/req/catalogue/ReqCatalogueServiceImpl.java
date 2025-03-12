package com.ivucenter.cloud.portal.req.catalogue;

import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;
import com.ivucenter.cloud.entity.OssFlavorVO;
import com.ivucenter.cloud.portal.mng.req.work.CustomMngOssVo;
import com.ivucenter.cloud.portal.req.customer.CustomReqCustomerVO;
import com.ivucenter.cloud.portal.req.project.CustomReqProjectVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service("reqCatalogueService")
public class ReqCatalogueServiceImpl implements ReqCatalogueService {

    private static final Logger logger = LoggerFactory.getLogger(ReqCatalogueServiceImpl.class);

	@Resource(name="reqCatalogueDAO")
	private ReqCatalogueDAO reqCatalogueDAO;

	@Override
	public List<CustomReqCatalogueVO> getProjectList(CustomReqCatalogueVO projectvo) {
		log.debug("=== getProjectList Service ===");
		return reqCatalogueDAO.getProjectList(projectvo);
	}

	@Override
	public List<CustomReqCatalogueVO> getDevEnvList(CustomReqCatalogueVO projectvo) {

		return reqCatalogueDAO.getDevEnvList(projectvo);
	}

	@Override
	public List<CustomMngOssVo> getSnapshots(CustomMngOssVo SnValue) {
		log.debug("=== getProjectList Service ===");
		return reqCatalogueDAO.getSnapshots(SnValue);
	}
//	@Override
//	public List<CustomReqCatalogueVO> networkVmPopList(CustomReqCatalogueVO projectvo) {
//		log.debug("=== networkVmPopList Service ===");
//		return reqCatalogueDAO.networkVmPopList(projectvo);
//	}


	@Override
	public String getProjectPopList(CustomReqCatalogueVO req) {
		List<CustomReqCatalogueVO> lists = reqCatalogueDAO.getProjectList(req);
		int recordsTotal = reqCatalogueDAO.getProjectListTot(req);

		int recordsFiltered = recordsTotal;
		String sError = "";
	    try {
	        JsonObject jsonResponse = new JsonObject();
	        Gson gson = new Gson();

	        jsonResponse.addProperty("draw", req.getDraw());
	        jsonResponse.addProperty("error", sError);
	        jsonResponse.addProperty("recordsTotal", recordsTotal);
	        jsonResponse.addProperty("recordsFiltered", recordsFiltered);
	        jsonResponse.add("data", gson.toJsonTree(lists));

	        return jsonResponse.toString();
	    } catch (JsonIOException e) {
	    	logger.error("JSON 처리 중 오류 발생");
	    }
		return "";
	}





	@Override
	public String networkVmPopList(CustomReqCatalogueVO req) {
		log.debug("=== networkVmPopList Service ===");
		List<CustomReqCatalogueVO> lists = reqCatalogueDAO.networkVmPopList(req);
		int recordsTotal = reqCatalogueDAO.networkVmPopListTot(req);

//		int recordsTotal = lists.size();
		int recordsFiltered = recordsTotal;
		String sError = "";
	    try {
	        JsonObject jsonResponse = new JsonObject();
	        Gson gson = new Gson();

	        jsonResponse.addProperty("draw", req.getDraw());
	        jsonResponse.addProperty("error", sError);
	        jsonResponse.addProperty("recordsTotal", recordsTotal);
	        jsonResponse.addProperty("recordsFiltered", recordsFiltered);
	        jsonResponse.add("data", gson.toJsonTree(lists));

	        return jsonResponse.toString();
	    } catch (JsonIOException e) {
	    	logger.error("JSON 처리 중 오류 발생");
	    }
		return "";
	}

	@Override
	public List<CustomReqCatalogueVO> getCatalogueList(CustomReqCatalogueVO projectvo) {
		log.debug("=== getCatalogueList Service ===");
		return reqCatalogueDAO.getCatalogueList(projectvo);
	}

	@Override
	public List<CustomReqCatalogueVO> getCatalogueAppList(CustomReqCatalogueVO projectvo) {
		log.debug("=== getCatalogueList Service ===");
		return reqCatalogueDAO.getCatalogueAppList(projectvo);
	}

	@Override
	public List<CustomReqCatalogueVO> getContainerList(CustomReqCatalogueVO projectvo) {
		log.debug("=== getContainerList Service ===");
		return reqCatalogueDAO.getContainerList(projectvo);
	}

	@Override
	public List<CustomReqCatalogueVO> getCatalogueSubList(CustomReqCatalogueVO projectvo) {
		log.debug("=== getCatalogueSubList Service ===");
		return reqCatalogueDAO.getCatalogueSubList(projectvo);
	}

	@Override
	public CustomReqCatalogueVO getCatalogueSelectView(CustomReqCatalogueVO projectvo) {
		log.debug("=== getCatalogueSelectView Service ===");
		return reqCatalogueDAO.getCatalogueSelectView(projectvo);
	}

	@Override
	public CustomReqCatalogueVO getCatalogueSelectApp(CustomReqCatalogueVO projectvo) {
		log.debug("=== getCatalogueSelectApp Service ===");
		return reqCatalogueDAO.getCatalogueSelectApp(projectvo);
	}

	@Override
	public CustomReqCatalogueVO getSelectContainer(CustomReqCatalogueVO projectvo) {
		log.debug("=== getSelectContainer Service ===");
		return reqCatalogueDAO.getSelectContainer(projectvo);
	}

	@Override
	public CustomReqCatalogueVO getCatalogueItempric(CustomReqCatalogueVO projectvo) {
		log.debug("=== getCatalogueItempric Service ===");
		return reqCatalogueDAO.getCatalogueItempric(projectvo);
	}

	@Override
	public List<CustomReqCatalogueVO> getCatalogueOslist(CustomReqCatalogueVO projectvo) {
		log.debug("=== getCatalogueOslist Service ===");
		return reqCatalogueDAO.getCatalogueOslist(projectvo);
	}

	@Override
	public List<OssFlavorVO> getCatalogueFlavorList(CustomReqCatalogueVO projectvo) {
		return reqCatalogueDAO.getCatalogueFlavorList(projectvo);
	}

	@Override
	public List<OssFlavorVO> getFlavorTypeList(CustomReqCatalogueVO projectvo) {
		return reqCatalogueDAO.getFlavorTypeList(projectvo);
	}

	@Override
	public String detailProjectId(CustomReqOrderVO ordervo) {
		return reqCatalogueDAO.detailProjectId(ordervo)+"";
	}

	@Override
	public String detailProjectId2(CustomReqOrderVO ordervo) {
		return reqCatalogueDAO.detailProjectId2(ordervo)+"";
	}

	@Override
	public String setOrderProductVm(CustomReqOrderVO ordervo){
		return reqCatalogueDAO.setOrderProductVm(ordervo)+"";
	}

	@Override
	public CustomReqOrderVO getSnapshotInfo(CustomReqOrderVO ordervo) {
		return reqCatalogueDAO.getSnapshotInfo(ordervo);
	}

	@Override
	public String setOrderDirectProductVm(CustomReqOrderVO ordervo){
		return reqCatalogueDAO.setOrderDirectProductVm(ordervo)+"";
	}

	@Override
	public String setOrderProduct(CustomReqOrderVO ordervo){
		return reqCatalogueDAO.setOrderProduct(ordervo)+"";
	}

	@Override
	public String setOrder(CustomReqOrderVO ordervo){
		return reqCatalogueDAO.setOrder(ordervo)+"";
	}

	@Override
	public String setOrderDirect(CustomReqOrderVO ordervo){
		return reqCatalogueDAO.setOrderDirect(ordervo)+"";
	}

	@Override
	public CustomReqCatalogueVO getCatalogueOs(CustomReqCatalogueVO osselectvo){
		return reqCatalogueDAO.getCatalogueOs(osselectvo);
	}

	@Override
	public List<CustomReqCustomerVO> getApprovalModelSteplist(){
		return reqCatalogueDAO.getApprovalModelSteplist();
	}

	@Override
	public void deleteApprovalStep(CustomReqProjectVO appmodelstep) {
		reqCatalogueDAO.deleteApprovalStep(appmodelstep);
	}

	@Override
	public void setSrApprovalStepinsert(CustomReqCustomerVO appmodelstep){
		reqCatalogueDAO.setSrApprovalStepinsert(appmodelstep);
	}

	@Override
	public void setSrApprovalMemberinsert(CustomReqCustomerVO appmember){
		reqCatalogueDAO.setSrApprovalMemberinsert(appmember);
	}

	@Override
	public List<CustomReqCustomerVO> getApprovalModelMemberlist(){
		return reqCatalogueDAO.getApprovalModelMemberlist();
	}

	@Override
	public CustomReqCatalogueVO getProjectId(String projectId){
		return reqCatalogueDAO.getProjectId(projectId);
	}

	@Override
	public String setBasket(CustomReqBasketVO basketvo){
		return reqCatalogueDAO.setBasket(basketvo)+"";
	}

	@Override
	public String setBasketVm(CustomReqBasketVO basketvo){
		return reqCatalogueDAO.setBasketVm(basketvo)+"";
	}

	@Override
	public List<CustomReqBasketVO> getBasketlist(CustomReqBasketVO basketvo){
		return reqCatalogueDAO.getBasketlist(basketvo);
	}

	@Override
	public String setBasketDel(CustomReqBasketVO basketvo){
		return reqCatalogueDAO.setBasketDel(basketvo)+"";
	}

	@Override
	public String setBasketVmDel(CustomReqBasketVO basketvo){
		return reqCatalogueDAO.setBasketVmDel(basketvo)+"";
	}

	@Override
	public List<CustomReqBasketVO> getBasketOrderList(Map<String, Object> map){
		return reqCatalogueDAO.getBasketOrderList(map);
	}

	@Override
	public List<CustomReqOrderVO> getPmOrderList(CustomReqOrderVO req){
		return reqCatalogueDAO.getPmOrderList(req);
	}
	@Override
	public CustomReqOrderVO getPmOrderStatusCnt(CustomReqOrderVO req){
		return reqCatalogueDAO.getPmOrderStatusCnt(req);
	}

	@Override
	public List<CustomReqOrderVO> getOrderApproveList(CustomReqOrderVO req){
		return reqCatalogueDAO.getOrderApproveList(req);
	}
	@Override
	public CustomReqOrderVO getOrderApproveStatusCnt(CustomReqOrderVO req){
		return reqCatalogueDAO.getOrderApproveStatusCnt(req);
	}

	@Override
	public int productApproveListTot(CustomReqOrderVO req){
		return reqCatalogueDAO.productApprovelistTot(req);
	}

	@Override
	public List<CustomReqCustomerVO> approvalList(CustomReqCatalogueVO catalolovo){
		return reqCatalogueDAO.approvalList(catalolovo);
	}

	@Override
	public List<CustomReqCustomerVO> approvalUserId(CustomReqCatalogueVO catalolovo){
		return reqCatalogueDAO.approvalUserId(catalolovo);
	}

	@Override
	public CustomReqOrderVO orderview(CustomReqOrderVO req) {
		return reqCatalogueDAO.orderview(req);
	}

	@Override
	public List<CustomReqOrderVO> orderviewList(CustomReqOrderVO req) {
		return reqCatalogueDAO.orderviewList(req);
	}

	@Override
	public List<CustomReqOrderVO> getCustomerOrderList(CustomReqOrderVO req){
		return reqCatalogueDAO.getCustomerOrderList(req);
	}

	@Override
	public List<CustomReqCustomerVO> getApprovalModelSteplist2(){
		return reqCatalogueDAO.getApprovalModelSteplist2();
	}

	@Override
	public List<CustomReqCustomerVO> getApprovalModelSteplistProject(){
		return reqCatalogueDAO.getApprovalModelSteplistProject();
	}

	@Override
	public List<CustomReqCustomerVO> getApprovalUserList(){
		return reqCatalogueDAO.getApprovalUserList();
	}

	@Override
	public List<CustomReqCustomerVO> getApprovalModelMemberlist2(){
		return reqCatalogueDAO.getApprovalModelMemberlist2();
	}

	// 프로젝트 결재자 리스트
	@Override
	public List<CustomReqCustomerVO> getApprovalModelMemberlistProject(){
		return reqCatalogueDAO.getApprovalModelMemberlistProject();
	}
	// 프로젝트 결재자 리스트
	@Override
	public List<CustomReqCustomerVO> getApproveModelMemberlistProject(String userId){
		return reqCatalogueDAO.getApproveModelMemberlistProject(userId);
	}

	@Override
	public List<CustomReqDataStoreVO> getDataStoreList(String cloudId){
		return reqCatalogueDAO.getDataStoreList(cloudId);
	}


	@Override
	public void setSrApprovalStepinsert2(CustomReqCustomerVO appmodelstep){
		reqCatalogueDAO.setSrApprovalStepinsert2(appmodelstep);
	}

	@Override
	public void setDevUserInsert(CustomReqOrderVO appmodelstep) {
        reqCatalogueDAO.setDevUserInsert(appmodelstep);
    }

	@Override
	public void updateSrApprovalStepinsert(CustomReqCustomerVO appmodelstep) {
		reqCatalogueDAO.updateSrApprovalStepinsert(appmodelstep);
	}
	@Override
	public void insertSrApprovalStepHis(CustomReqCustomerVO appmodelstep) {
		reqCatalogueDAO.insertSrApprovalStepHis(appmodelstep);
	}
	@Override
	public void deleteSrApprovalStep(CustomReqCustomerVO appmodelstep) {
		reqCatalogueDAO.deleteSrApprovalStep(appmodelstep);
	}

	//프로젝트 스탭 insert
	@Override
	public void setSrApprovalStepinsertProject(CustomReqCustomerVO appmodelstep){
		reqCatalogueDAO.setSrApprovalStepinsertProject(appmodelstep);
	}
	//프로젝트 1차 결재자 2차 결재자 선택되어진 사용자로 새팅
	@Override
	public void updateProjectApprovalMemberInsert(CustomReqCustomerVO appmodelstep){
		reqCatalogueDAO.updateProjectApprovalMemberInsert(appmodelstep);
	}
	//프로젝트 스탭 체크
	@Override
	public int projectStepCheck(CustomReqCustomerVO appmodelstep){
		return reqCatalogueDAO.projectStepCheck(appmodelstep);
	}

	@Override
	public void setSrApprovalMemberinsert2(CustomReqCustomerVO appmodelstep){
		reqCatalogueDAO.setSrApprovalMemberinsert2(appmodelstep);
	}

	@Override
	public int projectMemberCheck(CustomReqCustomerVO appmodelstep){
		return reqCatalogueDAO.projectMemberCheck(appmodelstep);
	}

	@Override
	public int cumlistTot(CustomReqOrderVO req){
		return reqCatalogueDAO.cumlistTot(req);
	}

	@Override
	public int pmlistTot(CustomReqOrderVO req){
		return reqCatalogueDAO.pmlistTot(req);
	}

	@Override
	public int userIdchk(String userId){
		return reqCatalogueDAO.userIdchk(userId);
	}

	@Override
	public int hostnameChk(CustomReqOrderVO ordervo){
		return reqCatalogueDAO.hostnameChk(ordervo);
	}

	@Override
	public List<CustomReqOrderVO> getMemberOrderList(CustomReqOrderVO req){
		return reqCatalogueDAO.getMemberOrderList(req);
	}

	@Override
	public int memberlistTot(CustomReqOrderVO req){
		return reqCatalogueDAO.memberlistTot(req);
	}
	@Override
	public int reviewChk(CustomReqOrderVO req){
		return reqCatalogueDAO.reviewChk(req);
	}

	@Override
	public int approveChk(CustomReqOrderVO req){
		return reqCatalogueDAO.approveChk(req);
	}

	@Override
	public String setOrderProductVmNetwork(CustomReqOrderVO ordervo){
		return reqCatalogueDAO.setOrderProductVmNetwork(ordervo)+"";
	}

	@Override
	public String setBasketVmNetwork(CustomReqBasketVO setBasketNetworkVm){
		return reqCatalogueDAO.setBasketVmNetwork(setBasketNetworkVm)+"";
	}

	@Override
	public List<CustomReqBasketVO> getBasketVmList(String basketSeq){
		return reqCatalogueDAO.getBasketVmList(basketSeq);
	}

	@Override
	public String setBasketVmNetworkDel(CustomReqBasketVO basketvo){
		return reqCatalogueDAO.setBasketVmNetworkDel(basketvo)+"";
	}

	@Override
	public String setOrderProductDisk(CustomReqOrderVO ordervo){
		return reqCatalogueDAO.setOrderProductDisk(ordervo)+"";
	}

	@Override
	public String setBasketDisk(CustomReqBasketVO basketvo){
		return reqCatalogueDAO.setBasketDisk(basketvo)+"";
	}

	@Override
	public String setOrderProductNas(CustomReqOrderVO ordervo){
		return reqCatalogueDAO.setOrderProductNas(ordervo)+"";
	}

	@Override
	public String setOrderProductNasVm(CustomReqOrderVO ordervo){
		return reqCatalogueDAO.setOrderProductNasVm(ordervo)+"";
	}

	@Override
	public String setOrderProductIp(CustomReqOrderVO ordervo){
		return reqCatalogueDAO.setOrderProductIp(ordervo)+"";
	}

	@Override
	public List<CustomReqBasketVO> getBasketDisklistvo(CustomReqBasketVO basketvo){
		return reqCatalogueDAO.getBasketDisklistvo(basketvo);
	}

	@Override
	public List<CustomReqBasketVO> getBasketNaslistvo(CustomReqBasketVO basketvo){
		return reqCatalogueDAO.getBasketNaslistvo(basketvo);
	}

	@Override
	public List<CustomReqBasketVO> getBasketIplistvo(CustomReqBasketVO basketvo){
		return reqCatalogueDAO.getBasketIplistvo(basketvo);
	}

	@Override
	public List<CustomReqBasketVO> getBasketLblistvo(CustomReqBasketVO basketvo){
		return reqCatalogueDAO.getBasketLblistvo(basketvo);
	}

//	@Override
//	public List<CustomReqBasketVO> getBasketSvlistvo(CustomReqBasketVO basketvo){
//		return reqCatalogueDAO.getBasketSvlistvo(basketvo);
//	}

	@Override
	public List<CustomReqBasketVO> getBasketDiskOrderList(Map<String, Object> map){
		return reqCatalogueDAO.getBasketDiskOrderList(map);
	}

	@Override
	public String setBasketDiskDel(CustomReqBasketVO basketvo){
		return reqCatalogueDAO.setBasketDiskDel(basketvo)+"";
	}

	@Override
	public List<CustomReqBasketVO> getBasketNasOrderList(Map<String, Object> map){
		return reqCatalogueDAO.getBasketNasOrderList(map);
	}

	@Override
	public String setBasketNasDel(CustomReqBasketVO basketvo){
		return reqCatalogueDAO.setBasketNasDel(basketvo)+"";
	}

	@Override
	public List<CustomReqBasketVO> getBasketIpOrderList(Map<String, Object> map){
		return reqCatalogueDAO.getBasketIpOrderList(map);
	}

	@Override
	public String setBasketIpDel(CustomReqBasketVO basketvo){
		return reqCatalogueDAO.setBasketIpDel(basketvo)+"";
	}

	@Override
	public String setOrderProductLb(CustomReqOrderVO ordervo){
		return reqCatalogueDAO.setOrderProductLb(ordervo)+"";
	}

	@Override
	public String setOrderProductSn(CustomReqOrderVO ordervo){
		return reqCatalogueDAO.setOrderProductSn(ordervo)+"";
	}

	@Override
	public String setOrderProductApp(CustomReqOrderVO ordervo) {
		return reqCatalogueDAO.setOrderProductApp(ordervo)+"";
	}

	@Override
	public String setOrderProductEnv(CustomReqOrderVO ordervo) {
		return reqCatalogueDAO.setOrderProductEnv(ordervo)+"";
	}

	@Override
	public List<CustomReqBasketVO> getBasketLbOrderList(Map<String, Object> map){
		return reqCatalogueDAO.getBasketLbOrderList(map);
	}

	@Override
	public String setBasketLbDel(CustomReqBasketVO basketvo){
		return reqCatalogueDAO.setBasketLbDel(basketvo)+"";
	}

	@Override
	public String setBasketNas(CustomReqBasketVO basketvo){
		return reqCatalogueDAO.setBasketNas(basketvo)+"";
	}

	@Override
	public String setBasketNasVm(CustomReqBasketVO basketvo){
		return reqCatalogueDAO.setBasketNasVm(basketvo)+"";
	}

	@Override
	public String setBasketIp(CustomReqBasketVO basketvo){
		return reqCatalogueDAO.setBasketIp(basketvo)+"";
	}

	@Override
	public List<CustomReqCatalogueVO> getVmNetworkList(CustomReqCatalogueVO projectvo) {
		log.debug("=== getVmNetworkList Service ===");
	return reqCatalogueDAO.getVmNetworkList(projectvo);
	}

	@Override
	public List<CustomReqCatalogueVO> getNetworkList(CustomReqCatalogueVO projectvo) {
		log.debug("=== getNetworkList Service ===");
	return reqCatalogueDAO.getNetworkList(projectvo);
	}

	//카테고리 기본상품 상세
	@Override
	public CustomReqCatalogueVO getCatalogueSelectBasicView(CustomReqCatalogueVO projectvo) {
		log.debug("=== getCatalogueSelectBasicView Service ===");
		return reqCatalogueDAO.getCatalogueSelectBasicView(projectvo);
	}

	@Override
	public CustomReqCatalogueVO getChangOrderViewPriceInfo(CustomReqCatalogueVO projectvo) {
		log.debug("=== getChangOrderViewPriceInfo Service ===");
		return reqCatalogueDAO.getChangOrderViewPriceInfo(projectvo);
	}

	@Override
	public List<CustomReqCatalogueVO> getCatalogueServiceList(CustomReqCatalogueVO projectvo) {
		log.debug("=== getCatalogueServiceList Service ===");
		return reqCatalogueDAO.getCatalogueServiceList(projectvo);
	}

	@Override
	public CustomReqCatalogueVO getCatalogueServiceView(CustomReqCatalogueVO projectvo) {
		log.debug("=== getCatalogueServiceView Service ===");
		return reqCatalogueDAO.getCatalogueServiceView(projectvo);
	}

//	@Override
//	public String setOrderProductServiceMca(CustomReqOrderVO ordervo){
//		return reqCatalogueDAO.setOrderProductServiceMca(ordervo)+"";
//	}
//
//	@Override
//	public String setOrderProductServiceScm(CustomReqOrderVO ordervo){
//		return reqCatalogueDAO.setOrderProductServiceScm(ordervo)+"";
//	}

//	@Override
//	public String setOrderProductServiceScr(CustomReqOrderVO ordervo){
//		return reqCatalogueDAO.setOrderProductServiceScr(ordervo)+"";
//	}
//
//	@Override
//	public List<CustomReqBasketVO> getBasketMcalistvo(CustomReqBasketVO basketvo) {
//		log.debug("=== getBasketMcalistvo Service ===");
//		return reqCatalogueDAO.getBasketMcalistvo(basketvo);
//	}

//	@Override
//	public String setBasketMca(CustomReqBasketVO basketvo){
//		return reqCatalogueDAO.setBasketMca(basketvo)+"";
//	}

//	@Override
//	public List<CustomReqBasketVO> getBasketMcaOrderList(Map<String, Object> map){
//		return reqCatalogueDAO.getBasketMcaOrderList(map);
//	}

//	@Override
//	public List<CustomReqBasketVO> getBasketScmOrderList(Map<String, Object> map){
//		return reqCatalogueDAO.getBasketScmOrderList(map);
//	}

//	@Override
//	public List<CustomReqBasketVO> getBasketScrOrderList(Map<String, Object> map){
//		return reqCatalogueDAO.getBasketScrOrderList(map);
//	}

//	@Override
//	public String setBasketScm(CustomReqBasketVO basketvo){
//		return reqCatalogueDAO.setBasketScm(basketvo)+"";
//	}

//	@Override
//	public String setBasketScr(CustomReqBasketVO basketvo){
//		return reqCatalogueDAO.setBasketScr(basketvo)+"";
//	}

//	@Override
//	public List<CustomReqBasketVO> getBasketScmlistvo(CustomReqBasketVO basketvo) {
//		log.debug("=== getBasketScmlistvo Service ===");
//		return reqCatalogueDAO.getBasketScmlistvo(basketvo);
//	}

//	@Override
//	public List<CustomReqBasketVO> getBasketSerlistvo(CustomReqBasketVO basketvo) {
//		log.debug("=== getBasketSerlistvo Service ===");
//		return reqCatalogueDAO.getBasketSerlistvo(basketvo);
//	}

//	@Override
//	public String setOrderProductMca(CustomReqOrderVO ordervo){
//		return reqCatalogueDAO.setOrderProductMca(ordervo)+"";
//	}

//	@Override
//	public String setBasketMcaDel(CustomReqBasketVO basketvo){
//		return reqCatalogueDAO.setBasketMcaDel(basketvo)+"";
//	}

//	@Override
//	public String setBasketScmDel(CustomReqBasketVO basketvo){
//		return reqCatalogueDAO.setBasketScmDel(basketvo)+"";
//	}

//	@Override
//	public String setBasketSerDel(CustomReqBasketVO basketvo){
//		return reqCatalogueDAO.setBasketSerDel(basketvo)+"";
//	}

//	@Override
//	public String setOrderProductServiceBak(CustomReqOrderVO ordervo){
//		return reqCatalogueDAO.setOrderProductServiceBak(ordervo)+"";
//	}

	@Override
	public String setOrderProductServiceService(CustomReqOrderVO ordervo){
		return reqCatalogueDAO.setOrderProductServiceService(ordervo)+"";
	}

//	@Override
//	public String setBasketBak(CustomReqBasketVO basketvo){
//		return reqCatalogueDAO.setBasketBak(basketvo)+"";
//	}

	// 서비스 입력
	@Override
	public String setBasketService(CustomReqBasketVO basketvo){
		return reqCatalogueDAO.setBasketService(basketvo)+"";
	}

//	@Override
//	public List<CustomReqBasketVO> getBasketBaklistvo(CustomReqBasketVO basketvo) {
//		log.debug("=== getBasketBaklistvo Service ===");
//		return reqCatalogueDAO.getBasketBaklistvo(basketvo);
//	}

	@Override
	public List<CustomReqBasketVO> getBasketServicelistvo(CustomReqBasketVO basketvo) {
		log.debug("=== getbasketServicelistvo Service ===");
		return reqCatalogueDAO.getBasketServicelistvo(basketvo);
	}

//	@Override
//	public List<CustomReqBasketVO> getBasketBakOrderList(Map<String, Object> map){
//		return reqCatalogueDAO.getBasketBakOrderList(map);
//	}
//	@Override
	public List<CustomReqBasketVO> getBasketServiceOrderList(Map<String, Object> map){
		return reqCatalogueDAO.getBasketServiceOrderList(map);
	}

//	@Override
//	public String setBasketbakDel(CustomReqBasketVO basketvo){
//		return reqCatalogueDAO.setBasketbakDel(basketvo)+"";
//	}

//	@Override
//	public String setBasketServiceDel(CustomReqBasketVO basketvo){
//		return reqCatalogueDAO.setBasketServiceDel(basketvo)+"";
//	}

	//2017.07.26 박현오
	//장바구니 입력 bss_basket_loadbalancer
	@Override
	public String setBasketLoad(CustomReqBasketVO basketvo){
		return reqCatalogueDAO.setBasketLoad(basketvo)+"";
	}

	//장바구니 입력bss_basket_loadbalancer_vm
	@Override
	public String setBasketLoadVm(CustomReqBasketVO basketvo){
		return reqCatalogueDAO.setBasketLoadVm(basketvo)+"";
	}

	@Override
	public String setChkBasketDel(Map<String, Object> map){
		return reqCatalogueDAO.setChkBasketDel(map)+"";
	}

	@Override
	public String setChkBasketVmDel(Map<String, Object> map){
		return reqCatalogueDAO.setChkBasketVmDel(map)+"";
	}

	@Override
	public String setChkBasketVmNetworkDel(Map<String, Object> map){
		return reqCatalogueDAO.setChkBasketVmNetworkDel(map)+"";
	}

	@Override
	public String setChkBasketDiskDel(Map<String, Object> map){
		return reqCatalogueDAO.setChkBasketDiskDel(map)+"";
	}

	@Override
	public String setChkBasketNasDel(Map<String, Object> map){
		return reqCatalogueDAO.setChkBasketNasDel(map)+"";
	}

	@Override
	public String setChkBasketLbDel(Map<String, Object> map){
		return reqCatalogueDAO.setChkBasketLbDel(map)+"";
	}

	@Override
	public String setChkBasketIpDel(Map<String, Object> map){
		return reqCatalogueDAO.setChkBasketIpDel(map)+"";
	}

//	@Override
//	public String setChkBasketbakDel(Map<String, Object> map){
//		return reqCatalogueDAO.setChkBasketbakDel(map)+"";
//	}

	@Override
	public String setChkBasketserviceDel(Map<String, Object> map){
		return reqCatalogueDAO.setChkBasketserviceDel(map)+"";
	}

//	@Override
//	public String setChkBasketScmDel(Map<String, Object> map){
//		return reqCatalogueDAO.setChkBasketScmDel(map)+"";
//	}

//	@Override
//	public String setChkBasketMcaDel(Map<String, Object> map){
//		return reqCatalogueDAO.setChkBasketMcaDel(map)+"";
//	}

//	@Override
//	public String setChkBasketSerDel(Map<String, Object> map){
//		return reqCatalogueDAO.setChkBasketSerDel(map)+"";
//	}

	@Override
	public String setChkBasketLbNetDel(Map<String, Object> map){
		return reqCatalogueDAO.setChkBasketLbNetDel(map)+"";
	}

	@Override
	public List<CustomReqBasketVO> getBasketLbNetList(String basketSeq) {
		log.debug("=== getBasketLbNetList Service ===");
		return reqCatalogueDAO.getBasketLbNetList(basketSeq);
	}

	@Override
	public String setOrderProductLbVm(CustomReqOrderVO ordervo){
		return reqCatalogueDAO.setOrderProductLbVm(ordervo)+"";
	}

	@Override
	public String setBasketLbVmDel(CustomReqBasketVO basketvo){
		return reqCatalogueDAO.setBasketLbVmDel(basketvo)+"";
	}

	@Override
	public List<CustomReqOrderVO> orderDiskviewList(CustomReqOrderVO req) {
		log.debug("=== orderDiskviewList Service ===");
		return reqCatalogueDAO.orderDiskviewList(req);
	}

	@Override
	public List<CustomReqOrderVO> orderNasviewList(CustomReqOrderVO req) {
		log.debug("=== orderNasviewList Service ===");
		return reqCatalogueDAO.orderNasviewList(req);
	}

	@Override
	public List<CustomReqOrderVO> orderLbviewList(CustomReqOrderVO req) {
		log.debug("=== orderLbviewList Service ===");
		return reqCatalogueDAO.orderLbviewList(req);
	}

	@Override
	public List<CustomReqOrderVO> orderSnviewList(CustomReqOrderVO req) {
		log.debug("=== orderSnviewList Service ===");
		return reqCatalogueDAO.orderSnviewList(req);
	}

	@Override
	public List<CustomReqOrderVO> orderAppviewList(CustomReqOrderVO req) {
		log.debug("=== orderSnviewList Service ===");
		return reqCatalogueDAO.orderAppviewList(req);
	}

	@Override
	public List<CustomReqOrderVO> orderAppviewList_sub(CustomReqOrderVO req) {
		log.debug("=== orderSnviewList Service ===");
		return reqCatalogueDAO.orderAppviewList_sub(req);
	}

	@Override
	public List<CustomReqOrderVO> orderEnvviewList_sub(CustomReqOrderVO req) {
		log.debug("=== orderSnviewList Service ===");
		return reqCatalogueDAO.orderEnvviewList_sub(req);
	}

	@Override
	public List<CustomReqOrderVO> orderIpviewList(CustomReqOrderVO req) {
		log.debug("=== orderIpviewList Service ===");
		return reqCatalogueDAO.orderIpviewList(req);
	}

//	@Override
//	public List<CustomReqOrderVO> orderBakviewList(CustomReqOrderVO req) {
//		log.debug("=== orderBakviewList Service ===");
//		return reqCatalogueDAO.orderBakviewList(req);
//	}

	@Override
	public List<CustomReqOrderVO> orderServiceviewList(CustomReqOrderVO req) {
		log.debug("=== orderServiceviewList Service ===");
		return reqCatalogueDAO.orderServiceviewList(req);
	}

//	@Override
//	public List<CustomReqOrderVO> getReqScmOrderList(CustomReqOrderVO req) {
//		log.debug("=== getReqScmOrderList Service ===");
//		return reqCatalogueDAO.getReqScmOrderList(req);
//	}

//	@Override
//	public List<CustomReqOrderVO> getReqMcaOrderList(CustomReqOrderVO req) {
//		log.debug("=== getReqMcaOrderList Service ===");
//		return reqCatalogueDAO.getReqMcaOrderList(req);
//	}

//	@Override
//	public List<CustomReqOrderVO> getReqSerOrderList(CustomReqOrderVO req) {
//		log.debug("=== getReqSerOrderList Service ===");
//		return reqCatalogueDAO.getReqSerOrderList(req);
//	}

//	@Override
//	public String setOrderBackVm(CustomReqOrderVO setVmUuid){
//		return reqCatalogueDAO.setOrderBackVm(setVmUuid)+"";
//	}

//	@Override
//	public String setBasketBackVm(CustomReqBasketVO setVmUuid){
//		return reqCatalogueDAO.setBasketBackVm(setVmUuid)+"";
//	}

//	@Override
//	public List<CustomReqBasketVO> getBasketBackVmList(String basketSeq) {
//		log.debug("=== getBasketBackVmList Service ===");
//		return reqCatalogueDAO.getBasketBackVmList(basketSeq);
//	}
//	@Override
//	public List<CustomReqBasketVO> getBasketServiceVmList(String basketSeq) {
//		log.debug("=== getBasketServiceVmList Service ===");
//		return reqCatalogueDAO.getBasketServiceVmList(basketSeq);
//	}

	@Override
	public CustomReqBasketCountVO checkProject(CustomReqCatalogueVO ordervo) {
		return reqCatalogueDAO.checkProject(ordervo);
	}

//	@Override
//	public String setBasketBackupVmDel(CustomReqBasketVO basketvo){
//		return reqCatalogueDAO.setBasketBackupVmDel(basketvo)+"";
//	}

	@Override
	public List<CustomReqCustomerVO> getApprovalModelMemberlist3(String stepLevel){
    	List<CustomReqCustomerVO> lists = reqCatalogueDAO.getApprovalModelMemberlist3(stepLevel);

		List<CustomReqCustomerVO> list = new LinkedList<CustomReqCustomerVO>();
		for(CustomReqCustomerVO vo : lists){
			list.add(VoToDec(vo));
		}
		return list;
	}

	public CustomReqCustomerVO VoToDec(CustomReqCustomerVO vo){
		if(vo != null){
			vo.setUserPhone(vo.getUserPhoneDec());
			vo.setUserMail(vo.getUserMailDec());
		}
		return vo;
	}

	public CustomReqCustomerVO VoToEnc(CustomReqCustomerVO vo){
		if(vo != null){
			vo.setUserPhone(vo.getUserPhoneEnc());
			vo.setUserMail(vo.getUserMailEnc());
		}
		return vo;
	}

	public int getBasketCnt(String userId){
		return reqCatalogueDAO.getBasketCnt(userId);
	}

	@Override
	public List<CustomReqCatalogueVO> getCatalogueAppVersionList(CustomReqCatalogueVO projectvo) {
		log.debug("=== getCatalogueAppVersionList Service ===");
		return reqCatalogueDAO.getCatalogueAppVersionList(projectvo);
	}

	@Override
	public int getAutoScaleOutCnt(String appUid) {
		return reqCatalogueDAO.getAutoScaleOutCnt(appUid);
	}

	@Override
	public int getAppCnt(String projectBoxId) {
		return reqCatalogueDAO.getAppCnt(projectBoxId);
	}

	@Override
	public int pathChk(String nasFileSystemPath) {
		return reqCatalogueDAO.pathChk(nasFileSystemPath);
	}

	@Override
	public String getOpsNasProjectId(CustomReqCatalogueVO projectvo) {
		return reqCatalogueDAO.getOpsNasProjectId(projectvo);
	}

	@Override
	public int checkContainerTerminal(String vmUuId) {
		return reqCatalogueDAO.checkContainerTerminal(vmUuId);
	}

}
