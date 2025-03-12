package com.ivucenter.cloud.portal.req.product;

import java.util.List;
import java.util.Map;

import com.ivucenter.cloud.portal.req.customer.CustomReqCustomerVO;
import com.ivucenter.cloud.portal.req.project.CustomReqProjectVO;

public interface ReqProductService {

	String getStepId(Map<String, String> map);
	String getUserApprvState(Map<String, String> map);
	String list(CustomReqProductVO req);

	List<CustomReqProductVO> orderView(String orderNo);
	CustomReqProductVO	orderUserInfo(String orderNo);

	List<CustomReqProductVO> approvalList(Map<String, String> map);
	List<CustomReqProductVO> approvalList2(Map<String, String> map);
	List<CustomReqProductVO> approvalUserId(String orderNo);
	List<CustomReqProductVO> detail(String orderNo);
	CustomReqProductVO detail1(String orderNo);
	String rejectedUpdate(CustomReqCustomerVO req);
	String reqProjectRejectedUpdate(CustomReqCustomerVO req);
	String insertOssVm(CustomReqProductVO vm);
	String insertOssVmNetwork(CustomReqProductVO vm);
	String newUpdate(CustomReqProductVO req);

	List<String> getNetworkList(String orderProductSeq);
	List<CustomReqProductVO> getReqDiskOrderList(String orderNo);
	List<CustomReqProductVO> getReqNasOrderList(String orderNo);
	List<CustomReqProductVO> getReqIpOrderList(String orderNo);
	List<CustomReqProductVO> getReqLbOrderList(String orderNo);
	List<CustomReqProductVO> getReqSnOrderList(String orderNo);
	List<CustomReqProductVO> getReqAppOrderList(String orderNo);
	List<CustomReqProductVO> getReqEnvOrderList(String orderNo);
	List<CustomReqProductVO> getReqPrdOrderList(String orderNo);
	List<CustomReqProductVO> bssEnvUserList(String orderNo);

	List<CustomReqProductVO> getReqServiceOrderList(String orderNo);
	List<CustomReqProductVO> getReqVMOrderList(String orderNo);
	List<CustomReqProductVO> getReqOrderList(String orderNo);
	CustomReqProductVO getOrderVm(String orderNo);
	List<CustomReqProductVO> pmList(CustomReqProductVO req);
	int setReqWork(CustomReqProductVO reqWork);
	int getProductNameChk(CustomReqProductVO req);
	String stepUpdate(CustomReqProductVO req);
	String reqProjectUpdate(CustomReqProductVO req);
	String stepUpdateUser(CustomReqProductVO req);
	int setUpdateWorkUser(CustomReqProductVO req);
	List<CustomReqProductVO> checkWorkUser(CustomReqProductVO req);
	String updateHostName(CustomReqProductVO req);
	String updateIp(CustomReqProductVO req);
	String updateBackupIp(CustomReqProductVO req);
	String updateNasIp(CustomReqProductVO req);
	String setUpdateUserId(CustomReqProductVO req);
	String setUpdateUserPw(CustomReqProductVO req);
	String changeProvisioning(CustomReqProductVO req);
	String endProvisioning(CustomReqProductVO req);
	List<CustomReqProductVO> setHostNameCheck(CustomReqProductVO req);
	List<CustomReqProductVO> setIpCheck(CustomReqProductVO req);
	List<CustomReqProductVO> setNasIpCheck(CustomReqProductVO req);
	List<CustomReqProductVO> setBackupIpCheck(CustomReqProductVO req);

	List<CustomReqProductVO> setUserIdCheck(CustomReqProductVO req);
	List<CustomReqProductVO> setUserPwCheck(CustomReqProductVO req);

	List<CustomReqProductVO> getOrderList(CustomReqProductVO req);
	List<CustomReqProductVO> getSumVm(CustomReqProductVO req);
	List<CustomReqProductVO> getSumDisk(CustomReqProductVO req);
	List<CustomReqProductVO> getSumService(CustomReqProductVO req);
	List<CustomReqProductVO> getSumLB(CustomReqProductVO req);
	List<CustomReqProductVO> getSumSN(CustomReqProductVO req);
	List<CustomReqProductVO> getSumAPP(CustomReqProductVO req);

	CustomReqProductVO getFlaverDetail(CustomReqProductVO req);



	CustomReqProductVO processSumVm(CustomReqProductVO req);
	CustomReqProductVO processSumDisk(CustomReqProductVO req);
	CustomReqProjectVO getAdminProject();

	CustomReqProductVO createVM(CustomReqProductVO req);
	void actProduct(CustomReqProductVO req);

	List<CustomReqProductVO> detailBbsOrder(String orderNo);

	CustomReqProductVO getOrderVo(String orderNo);

	List<CustomReqProductVO> getCloudAvailList(String orderNo);

	List<CustomReqProductVO> getCloudAvail(String projectBoxId);

//	CustomReqProductVO getCompany(String orderNo);

	CustomReqProductVO getReqDiskOrder(String orderProductSeq);

	CustomReqProductVO getReqNasOrder(String orderProductSeq);

	CustomReqProductVO getReqIpOrder(String orderProductSeq);

	CustomReqProductVO getReqLbOrder(String orderProductSeq);

	CustomReqProductVO getReqServiceOrder(String orderProductSeq);

	CustomReqProductVO getReqAppOrder(String orderProductSeq);

	CustomReqProductVO getReqEnvOrder(String orderProductSeq);

	CustomReqProductVO getReqVmOrder(String orderProductSeq);

	CustomReqProductVO getProvisioningStatus(String orderProductSeq);

	List<CustomReqProductVO> excel(CustomReqProductVO req);

	List<CustomReqProductVO> stepIdList(String stepId);

	String bssOrderProductUpdate(CustomReqProductVO req);
	String bssOrderProductVmUpdate(CustomReqProductVO req);
	String bssOrderProductNasUpdate(CustomReqProductVO req);

	public int bssOrderProductAppNameChk(CustomReqProductVO req);
	public List<CustomReqProductVO> detailBssOrder(String orderNo);
	public String bssOrderProductAppUpdate(CustomReqProductVO req);

	// 개발환경
	public int envGrpUrlChk(CustomReqProductVO req);

	public int envNameChk(CustomReqProductVO req);
	public int envGroupNameChk(CustomReqProductVO req);
//	String envGrpUrlInsert(CustomReqProductVO vm);
	String envNameInsert(CustomReqProductVO vm);
	String envGroupNameInsert(CustomReqProductVO vm);

}
