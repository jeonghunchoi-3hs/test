package com.ivucenter.cloud.portal.req.catalogue;

import java.util.List;
import java.util.Map;

import com.ivucenter.cloud.entity.OssFlavorVO;
import com.ivucenter.cloud.portal.mng.req.work.CustomMngOssVo;
import com.ivucenter.cloud.portal.req.customer.CustomReqCustomerVO;
import com.ivucenter.cloud.portal.req.project.CustomReqProjectVO;

public interface ReqCatalogueService {

	// 프로젝트 리스트
	List<CustomReqCatalogueVO> getProjectList(CustomReqCatalogueVO projectvo);

	List<CustomReqCatalogueVO> getDevEnvList(CustomReqCatalogueVO projectvo);

	List<CustomMngOssVo> getSnapshots(CustomMngOssVo SnValue);

	// 네트워크 vm 리스트
//	List<CustomReqCatalogueVO> networkVmPopList(CustomReqCatalogueVO projectvo);
	String networkVmPopList(CustomReqCatalogueVO projectvo);

	//카테고리 상품 리스트
	List<CustomReqCatalogueVO> getCatalogueList(CustomReqCatalogueVO projectvo);

	List<CustomReqCatalogueVO> getCatalogueAppList(CustomReqCatalogueVO projectvo);

	List<CustomReqCatalogueVO> getContainerList(CustomReqCatalogueVO projectvo);

	//카테고리 부가상품 리스트
	List<CustomReqCatalogueVO> getCatalogueSubList(CustomReqCatalogueVO projectvo);

	//카테고리 상품 선택
	CustomReqCatalogueVO getCatalogueSelectView(CustomReqCatalogueVO projectvo);
	CustomReqCatalogueVO getCatalogueSelectApp(CustomReqCatalogueVO projectvo);
	CustomReqCatalogueVO getSelectContainer(CustomReqCatalogueVO projectvo);
	//카테고리 상품 별 아이템 가격정보
	CustomReqCatalogueVO getCatalogueItempric(CustomReqCatalogueVO projectvo);

	//카테고리 os 정보 리스트
	List<CustomReqCatalogueVO> getCatalogueOslist(CustomReqCatalogueVO projectvo);

	//카테고리 Flavor 정보 리스트
	List<OssFlavorVO> getCatalogueFlavorList(CustomReqCatalogueVO projectvo);

	//주문서 입력 bss_order_product_vm
	String setOrderProductVm(CustomReqOrderVO ordervo);

	//주문서 입력 bss_order_product
	String setOrderProduct(CustomReqOrderVO ordervo);

	CustomReqOrderVO getSnapshotInfo(CustomReqOrderVO ordervo);

	//주문서 입력 bss_order_product
	String setOrderDirectProductVm(CustomReqOrderVO ordervo);

	String detailProjectId(CustomReqOrderVO ordervo);
	String detailProjectId2(CustomReqOrderVO ordervo);
	//주문서 입력 bss_order
	String setOrder(CustomReqOrderVO ordervo);

	//주문서 입력 bss_order
	String setOrderDirect(CustomReqOrderVO ordervo);


	////카테고리 os 정보 가격 포함 리스트
	CustomReqCatalogueVO getCatalogueOs(CustomReqCatalogueVO osselectvo);

	//Flavor 타입 정보 리스트
	List<OssFlavorVO> getFlavorTypeList(CustomReqCatalogueVO projectvo);

	//사용자 승인 스텝 정보
	List<CustomReqCustomerVO> getApprovalModelSteplist();

	//사용자 승인 스텝 모델 입력
	void setSrApprovalStepinsert(CustomReqCustomerVO appmodelstep);

	// 개발자 라인
	void setDevUserInsert(CustomReqOrderVO appmodelstep);

	//사용자 승인 스텝 멤버 입력
	void setSrApprovalMemberinsert(CustomReqCustomerVO appmember);

	//사용자 승인 스텝 모델 정보
	List<CustomReqCustomerVO> getApprovalModelMemberlist();

	//프로젝트 정보
	CustomReqCatalogueVO getProjectId(String projectId);

	//장바구니 입력 bss_basket
	String setBasket(CustomReqBasketVO basketvo);

	//장바구니 입력 bss_basket_vm
	String setBasketVm(CustomReqBasketVO basketvo);

	//장바구니 리스트
	List<CustomReqBasketVO> getBasketlist(CustomReqBasketVO basketvo);

	//장바구니 자료 삭제 bss_basket
	String setBasketDel(CustomReqBasketVO basketvo);

	//장바구니 자료 삭제  bss_basket_vm
	String setBasketVmDel(CustomReqBasketVO basketvo);

	//장바구니 상품 선택 리스트
	List<CustomReqBasketVO> getBasketOrderList(Map<String, Object> map);

	//PM 상품 신청현황 목록 조회
	List<CustomReqOrderVO> getPmOrderList(CustomReqOrderVO req);
	CustomReqOrderVO getPmOrderStatusCnt(CustomReqOrderVO req);

	// 상품구매 요청 승인 목록
	List<CustomReqOrderVO> getOrderApproveList(CustomReqOrderVO req);
	// 상품구매 요청 승인 목록 상품 신청 현황 데이터
	CustomReqOrderVO getOrderApproveStatusCnt(CustomReqOrderVO req);

	//

	List<CustomReqCustomerVO> approvalList(CustomReqCatalogueVO catalolovo);

	List<CustomReqCustomerVO> approvalUserId(CustomReqCatalogueVO catalolovo);

	CustomReqOrderVO orderview(CustomReqOrderVO req);

	List<CustomReqOrderVO> orderviewList(CustomReqOrderVO req);

	List<CustomReqOrderVO> getCustomerOrderList(CustomReqOrderVO req);

	List<CustomReqCustomerVO> getApprovalModelSteplist2();

	// 프로젝트 스텝리스트
	List<CustomReqCustomerVO> getApprovalModelSteplistProject();

	// 3차 4차 5차 프로젝트 승인자리스트
	List<CustomReqCustomerVO> getApprovalUserList();

	List<CustomReqCustomerVO> getApprovalModelMemberlist2();

	List<CustomReqCustomerVO> getApprovalModelMemberlistProject();

	List<CustomReqCustomerVO> getApproveModelMemberlistProject(String userId);

	List<CustomReqDataStoreVO> getDataStoreList(String cloudId);

	CustomReqBasketCountVO checkProject(CustomReqCatalogueVO ordervo);

	void deleteApprovalStep(CustomReqProjectVO appmodelstep);

	void setSrApprovalStepinsert2(CustomReqCustomerVO appmodelstep);

	void updateSrApprovalStepinsert(CustomReqCustomerVO appmodelstep);

	void insertSrApprovalStepHis(CustomReqCustomerVO appmodelstep);

	void deleteSrApprovalStep(CustomReqCustomerVO appmodelstep);

	//프로젝트 스텝 insert
	void setSrApprovalStepinsertProject(CustomReqCustomerVO appmodelstep);

	//프로젝트 1차 결재자 2차 결재자 선택되어진 사용자로 새팅
	void updateProjectApprovalMemberInsert(CustomReqCustomerVO appmodelstep);

	//프로젝트 스텝 체크
	int projectStepCheck(CustomReqCustomerVO appmodelstep);

	void setSrApprovalMemberinsert2(CustomReqCustomerVO appmember);

	int projectMemberCheck(CustomReqCustomerVO appmember);

	int cumlistTot(CustomReqOrderVO req);

	int pmlistTot(CustomReqOrderVO req);

	int productApproveListTot(CustomReqOrderVO req);

	int userIdchk(String userId);

	int hostnameChk(CustomReqOrderVO ordervo);

	List<CustomReqOrderVO> getMemberOrderList(CustomReqOrderVO req);

	int memberlistTot(CustomReqOrderVO req);

	int reviewChk(CustomReqOrderVO req);
	int approveChk(CustomReqOrderVO req);

	String setOrderProductVmNetwork(CustomReqOrderVO ordervo);

	String setBasketVmNetwork(CustomReqBasketVO setBasketNetworkVm);

	List<CustomReqBasketVO> getBasketVmList(String basketSeq);

	String setBasketVmNetworkDel(CustomReqBasketVO basketvo);

	String setOrderProductDisk(CustomReqOrderVO ordervo);

	String setBasketDisk(CustomReqBasketVO basketvo);

	String setOrderProductNas(CustomReqOrderVO ordervo);

	String setOrderProductNasVm(CustomReqOrderVO ordervo);

	String setOrderProductIp(CustomReqOrderVO ordervo);

	List<CustomReqBasketVO> getBasketDisklistvo(CustomReqBasketVO basketvo);

	List<CustomReqBasketVO> getBasketNaslistvo(CustomReqBasketVO basketvo);

	List<CustomReqBasketVO> getBasketIplistvo(CustomReqBasketVO basketvo);

	List<CustomReqBasketVO> getBasketLblistvo(CustomReqBasketVO basketvo);

//	List<CustomReqBasketVO> getBasketSvlistvo(CustomReqBasketVO basketvo);

	List<CustomReqBasketVO> getBasketDiskOrderList(Map<String, Object> map);

	String setBasketDiskDel(CustomReqBasketVO basketvo);

	List<CustomReqBasketVO> getBasketNasOrderList(Map<String, Object> map);

	String setBasketNasDel(CustomReqBasketVO basketvo);

	List<CustomReqBasketVO> getBasketIpOrderList(Map<String, Object> map);

	String setBasketIpDel(CustomReqBasketVO basketvo);

	List<CustomReqBasketVO> getBasketLbOrderList(Map<String, Object> map);

	String setOrderProductLb(CustomReqOrderVO ordervo);

	String setOrderProductSn(CustomReqOrderVO ordervo);

	String setOrderProductApp(CustomReqOrderVO ordervo);

	// 개발환경 신청
	String setOrderProductEnv(CustomReqOrderVO ordervo);

	String setBasketLbDel(CustomReqBasketVO basketvo);

	String setBasketNas(CustomReqBasketVO basketvo);

	String setBasketNasVm(CustomReqBasketVO basketvo);

	String setBasketIp(CustomReqBasketVO basketvo);

	// vm_network 리스트
	List<CustomReqCatalogueVO> getVmNetworkList(CustomReqCatalogueVO projectvo);

	// network 리스트
	List<CustomReqCatalogueVO> getNetworkList(CustomReqCatalogueVO projectvo);

	//카테고리 기본상품 선택
	CustomReqCatalogueVO getCatalogueSelectBasicView(CustomReqCatalogueVO projectvo);

	CustomReqCatalogueVO getChangOrderViewPriceInfo(CustomReqCatalogueVO projectvo);

	List<CustomReqCatalogueVO> getCatalogueServiceList(CustomReqCatalogueVO projectvo);

	CustomReqCatalogueVO getCatalogueServiceView(CustomReqCatalogueVO projectvo);

//	String setOrderProductServiceMca(CustomReqOrderVO ordervo);

//	String setOrderProductServiceScm(CustomReqOrderVO ordervo);

//	String setOrderProductServiceScr(CustomReqOrderVO ordervo);

//	List<CustomReqBasketVO> getBasketMcalistvo(CustomReqBasketVO basketvo);

//	String setBasketMca(CustomReqBasketVO basketvo);

//	List<CustomReqBasketVO> getBasketMcaOrderList(Map<String, Object> map);

//	List<CustomReqBasketVO> getBasketScmOrderList(Map<String, Object> map);

//	List<CustomReqBasketVO> getBasketScrOrderList(Map<String, Object> map);

//	String setBasketScm(CustomReqBasketVO basketvo);

//	String setBasketScr(CustomReqBasketVO basketvo);

//	List<CustomReqBasketVO> getBasketScmlistvo(CustomReqBasketVO basketvo);

//	List<CustomReqBasketVO> getBasketSerlistvo(CustomReqBasketVO basketvo);

//	String setOrderProductMca(CustomReqOrderVO basketordervo);

//	String setBasketMcaDel(CustomReqBasketVO basketvo);

//	String setBasketScmDel(CustomReqBasketVO basketvo);

//	String setBasketSerDel(CustomReqBasketVO basketvo);

//	String setOrderProductServiceBak(CustomReqOrderVO ordervo);

	String setOrderProductServiceService(CustomReqOrderVO ordervo);

//	String setBasketBak(CustomReqBasketVO basketvo);
	// 서비스 입력
	String setBasketService(CustomReqBasketVO basketvo);

//	List<CustomReqBasketVO> getBasketBaklistvo(CustomReqBasketVO basketvo);
	// 서비스 리스트
	List<CustomReqBasketVO> getBasketServicelistvo(CustomReqBasketVO basketvo);

//	List<CustomReqBasketVO> getBasketBakOrderList(Map<String, Object> map);

	//서비스 오더 리스트
	List<CustomReqBasketVO> getBasketServiceOrderList(Map<String, Object> map);

//	String setBasketbakDel(CustomReqBasketVO basketvo);

//	String setBasketServiceDel(CustomReqBasketVO basketvo);

	//2017.07.26 박현오
	//장바구니 입력 bss_basket_loadbalancer
	String setBasketLoad(CustomReqBasketVO basketvo);

	//장바구니 입력bss_basket_loadbalancer_vm
	String setBasketLoadVm(CustomReqBasketVO basketvo);

	String setChkBasketDel(Map<String, Object> map);

	String setChkBasketVmDel(Map<String, Object> map);

	String setChkBasketVmNetworkDel(Map<String, Object> map);

	String setChkBasketDiskDel(Map<String, Object> map);

	String setChkBasketNasDel(Map<String, Object> map);

	String setChkBasketLbDel(Map<String, Object> map);

	String setChkBasketIpDel(Map<String, Object> map);

//	String setChkBasketbakDel(Map<String, Object> map);

	String setChkBasketserviceDel(Map<String, Object> map);

//	String setChkBasketScmDel(Map<String, Object> map);

//	String setChkBasketMcaDel(Map<String, Object> map);

//	String setChkBasketSerDel(Map<String, Object> map);

	String setChkBasketLbNetDel(Map<String, Object> map);

	List<CustomReqBasketVO> getBasketLbNetList(String basketSeq);

	String setOrderProductLbVm(CustomReqOrderVO setLbNetworkVm);

	String setBasketLbVmDel(CustomReqBasketVO basketvo);

	List<CustomReqOrderVO> orderDiskviewList(CustomReqOrderVO req);

	List<CustomReqOrderVO> orderNasviewList(CustomReqOrderVO req);

	List<CustomReqOrderVO> orderLbviewList(CustomReqOrderVO req);

	List<CustomReqOrderVO> orderSnviewList(CustomReqOrderVO req);

	List<CustomReqOrderVO> orderAppviewList(CustomReqOrderVO req);


	List<CustomReqOrderVO> orderAppviewList_sub(CustomReqOrderVO req);

	List<CustomReqOrderVO> orderEnvviewList_sub(CustomReqOrderVO req);

	List<CustomReqOrderVO> orderIpviewList(CustomReqOrderVO req);

//	List<CustomReqOrderVO> orderBakviewList(CustomReqOrderVO req);

	List<CustomReqOrderVO> orderServiceviewList(CustomReqOrderVO req);

//	List<CustomReqOrderVO> getReqScmOrderList(CustomReqOrderVO req);

//	List<CustomReqOrderVO> getReqMcaOrderList(CustomReqOrderVO req);

//	List<CustomReqOrderVO> getReqSerOrderList(CustomReqOrderVO req);

//	String setOrderBackVm(CustomReqOrderVO setVmUuid);

//	String setBasketBackVm(CustomReqBasketVO setVmUuid);

//	List<CustomReqBasketVO> getBasketBackVmList(String basketSeq);
	//service vm 리스트
//	List<CustomReqBasketVO> getBasketServiceVmList(String basketSeq);

//	String setBasketBackupVmDel(CustomReqBasketVO basketvo);

	List<CustomReqCustomerVO> getApprovalModelMemberlist3(String stepLevel);

	int getBasketCnt(String userId);

	public List<CustomReqCatalogueVO> getCatalogueAppVersionList(CustomReqCatalogueVO projectvo);

	String getProjectPopList(CustomReqCatalogueVO req);

	public int getAutoScaleOutCnt(String appUid);

	public int getAppCnt(String projectBoxId);

	public int pathChk(String nasFileSystemPath);

	public String getOpsNasProjectId(CustomReqCatalogueVO projectvo);

	public int checkContainerTerminal(String vmUuId);

}
