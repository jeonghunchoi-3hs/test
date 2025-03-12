package com.ivucenter.cloud.portal.req.product;

import java.util.Date;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateFormatUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;
import com.ivucenter.cloud.api.common.batch.BatchProcessor;
import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.api.openstack.interfaces.AbstractFactory;
import com.ivucenter.cloud.api.openstack.interfaces.FlavorIF;
import com.ivucenter.cloud.api.openstack.object.Flavor;
import com.ivucenter.cloud.api.openstack.object.Network;
import com.ivucenter.cloud.api.openstack.object.Server;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;
import com.ivucenter.cloud.portal.cmm.cloud.OssCloudService;
import com.ivucenter.cloud.portal.oss.project.CustomOssProjectVO;
import com.ivucenter.cloud.portal.req.customer.CustomReqCustomerVO;
import com.ivucenter.cloud.portal.req.project.CustomReqProjectVO;
import com.ivucenter.cloud.portal.util.CodeUtil;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service("reqProductService")
public class ReqProductServiceImpl implements ReqProductService{

	@Resource(name="reqProductDAO")
	private ReqProductDAO reqProductDAO;

	@Autowired
	private OssCloudService ossCloudService;

//	@Autowired	private OssDiskService service;
	//pho
	@Override
	public String list(CustomReqProductVO req) {

    	List<CustomReqProductVO> lists = reqProductDAO.list(req);
    	int recordsTotal = reqProductDAO.listTot(req).size();
    	int recordsFiltered = recordsTotal;

	    try {
	        JsonObject jsonResponse = new JsonObject();
	        Gson gson = new Gson();

	        jsonResponse.addProperty("draw", req.getDraw());
	        jsonResponse.addProperty("recordsTotal", recordsTotal);
	        jsonResponse.addProperty("recordsFiltered", recordsFiltered);
	        jsonResponse.add("data", gson.toJsonTree(lists));

	        return jsonResponse.toString();
	    } catch (JsonIOException e) {
	    	log.error(e.getMessage());
	    }
		return "";
	}

	@Override
	public  List<CustomReqProductVO> detail(String orderNo){
		return reqProductDAO.detail(orderNo);
	}
	@Override
	public  CustomReqProductVO detail1(String orderNo){
		return reqProductDAO.detail1(orderNo);
	}
	@Override
	public List<CustomReqProductVO> approvalList(Map<String, String> map) {
		return reqProductDAO.approvalList(map);
	}
	@Override
	public List<CustomReqProductVO> approvalList2(Map<String, String> map) {
		return reqProductDAO.approvalList2(map);
	}

	@Override
	public List<CustomReqProductVO> approvalUserId(String orderNo) {
		return reqProductDAO.approvalUserId(orderNo);
	}

	@Override
	public List<CustomReqProductVO> orderView(String orderNo) {
		return reqProductDAO.orderView(orderNo);
	}

	@Override
	public CustomReqProductVO orderUserInfo(String orderNo) {
		return reqProductDAO.orderUserInfo(orderNo);
	}

	@Override
	public  String rejectedUpdate(CustomReqCustomerVO req){
		return reqProductDAO.rejectedUpdate(req)+"";
	}
	@Override
	public  String reqProjectRejectedUpdate(CustomReqCustomerVO req){
		return reqProductDAO.reqProjectRejectedUpdate(req)+"";
	}
	@Override
	public String insertOssVm(CustomReqProductVO vm) {
		return reqProductDAO.insertOssVm(vm)+"";
	}

	@Override
	public String newUpdate(CustomReqProductVO req) {
		return reqProductDAO.newUpdate(req)+"";
	}

	@Override
	public List<String> getNetworkList(String orderProductSeq) {
		return reqProductDAO.getNetworkList(orderProductSeq);
	}

	@Override
	public CustomReqProductVO createVM(CustomReqProductVO req) {

		try {
			String sFlaverId = setFlaver(req);
			CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo(req.getCloudId());
			// server create IF
			Server server = new Server();
			server.setName(req.getHostname());
			server.setFlavorRef(sFlaverId);
			server.setImageRef(req.getVmImageId());
			server.setOS_DCF_diskConfig("AUTO");

			List<Network> networks = new LinkedList<Network>();
			Network network = new Network();
			network.setUuid(req.getDefaultNetworkId());
			networks.add(network);

			// network 백업, 대외망, 공용 화면에서 삭제되어 주석처리
/*			List<String> networkList = getNetworkList(req.getOrderProductSeq());
			for(String networkId : networkList){
				network = new Network();
				network.setUuid(networkId);
				networks.add(network);
			}
			*/
			server.setNetworks(networks);
			Server obj12 = BatchProcessor.createServer(req.getProjectName(), server,cloudVo);

			CustomReqProductVO vm = new CustomReqProductVO();
			vm.setVmUuid(obj12.getId());
			vm.setProjectId(req.getProjectId());
			vm.setHostname(req.getHostname());
			vm.setHostnameAlias(req.getHostnameAlias());
			vm.setVcpus(req.getVcpus());
			vm.setMemGb(req.getMemGb());
			vm.setDiskGb(req.getDiskGb());
			vm.setVmProductSeq(req.getVmProductSeq());
			vm.setOsProductSeq(req.getOsProductSeq());
			vm.setVmCatalogSeq(req.getVmCatalogSeq());
			vm.setOrderUserId(req.getOrderUserId());
			vm.setCreateDatetime(req.getOnDemandFlag().equals("N")?req.getApplyDatetime():DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss"));
			vm.setRegUserId(CodeUtil.SYNC_ADMIN);
			insertOssVm(vm);

			vm.setNetworkId(req.getDefaultNetworkId());
			insertOssVmNetwork(vm);

		} catch (NotConnectGatewayException|NotSupportGatewayException|InvaildOpenStackException e) {
			log.error(e.getMessage());
			req.setErrorMsg(e.getMessage());
		}

		return req;
	}

	/**
	 * 오픈스택에 동일한 Flaver가 있는지 검색 하고, 없으면 새로 생성을 한다.
	 */
	public String setFlaver(CustomReqProductVO req) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException{
		int iMemory = Integer.parseInt(req.getMemGb())*1024;

		req.setDiskGb("1");
		CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo(req.getCloudId());
		String sFlaverId = "";
		FlavorIF flavorIF = AbstractFactory.getFlavorIF(cloudVo);
		List<Flavor> flavors = flavorIF.getFlavors();
		for (Flavor flavor : flavors) {
//				log.debug("flavor-----------------------------------");
//				log.debug("Name=>"+flavor.getName());
//				log.debug("Id=>"+flavor.getId());
//				log.debug("vcpus=>"+flavor.getVcpus());
//				log.debug("ram=>"+flavor.getRam());
//				log.debug("disk=>"+flavor.getDisk());
//
//				log.debug("/////////////////////////");
//				log.debug(req.getVcpus());
//				log.debug(req.getMemGb());
//				log.debug(req.getDiskGb());
			if(req.getVcpus().equals(flavor.getVcpus().toString())
					&& (iMemory+"").equals(flavor.getRam().toString())
					&& req.getDiskGb().equals(flavor.getDisk().toString())){
//					log.debug("find flavor id=>"+flavor.getId());
				sFlaverId = flavor.getId();
				break;
			}
		}

		// 기존 Flaover가 없는 경우 새로 생성한다.
		if(sFlaverId.equals("")){
			Flavor flavor = new Flavor();
			flavor.setName("c"+StringUtils.leftPad(req.getVcpus(), 2, "0")+"m"+StringUtils.leftPad(req.getMemGb(), 3, "0")+"d"+StringUtils.leftPad(req.getDiskGb(), 4, "0"));
			flavor.setVcpus(Integer.parseInt(req.getVcpus()));
			flavor.setRam(iMemory);
			flavor.setDisk(Integer.parseInt(req.getDiskGb()));
			Flavor obj1 = flavorIF.createFlavor(flavor);
//				log.debug("great flavor id=>"+obj1.getId());
			sFlaverId = obj1.getId();
		}
//			log.debug("req.getProjectName()=>"+req.getProjectName());
//			log.debug("req.getHostname()=>"+req.getHostname());
//			log.debug("sFlaverId=>"+sFlaverId);
//			log.debug("req.getVmImageId()=>"+req.getVmImageId());

		return sFlaverId;
	}

	/**
	 * orderProductSeq 기준으로
	 * ProductCategory 와  RequestType 을 DB에서 조회 후
	 * 작업을 분배한다.
	 */
	@Override
	public void actProduct(CustomReqProductVO req) {
		String orderProductSeq = req.getOrderProductSeq();
		String orderUserId = req.getOrderUserId();
		String sProduct = req.getProductCategory();
		String sRequestType = req.getRequestType();

		productByOpenSteak(orderProductSeq, sProduct, sRequestType, orderUserId);
	}

	private void productByOpenSteak(String orderProductSeq, String sProduct, String sRequestType, String orderUserId){

		CustomReqProductVO res = new CustomReqProductVO();

		// VM
		if(sProduct.equals(CodeUtil.CMM_CODE_PRODCATE_VM)){
			res = reqProductDAO.detailBssOrderProductVm(orderProductSeq);
			res.setOrderUserId(orderUserId);
			res.setProvisioningSeq(DateFormatUtils.format(new Date(), "yyyyMMdd")+UUID.randomUUID());
			res.setProvisioningStatus(CodeUtil.CMM_CODE_PROVISIONING_READY);
			res.setRequestType(sRequestType);
			res.setOrderProductSeq(orderProductSeq);
			res.setProductCategory(sProduct);
			CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo(res.getCloudId());
			res.setCloudType(cloudVo.getCloudType());
			reqProductDAO.insertProvisioningQueue(res);
		} else if(sProduct.equals(CodeUtil.CMM_CODE_PRODCATE_DISK)){
			res = reqProductDAO.detailBssOrderProductDisk(orderProductSeq);

			res.setOrderUserId(orderUserId);
			res.setProvisioningSeq(DateFormatUtils.format(new Date(), "yyyyMMdd")+UUID.randomUUID());
			res.setProvisioningStatus(CodeUtil.CMM_CODE_PROVISIONING_READY);
			res.setRequestType(sRequestType);
			res.setOrderProductSeq(orderProductSeq);
			res.setProductCategory(sProduct);
			CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo(res.getCloudId());
			res.setCloudType(cloudVo.getCloudType());
			reqProductDAO.insertProvisioningQueue(res);
		} else if(sProduct.equals(CodeUtil.CMM_CODE_PRODCATE_APP)) {
			res = reqProductDAO.detailBssOrderProductApp(orderProductSeq);
			res.setOrderUserId(orderUserId);
			res.setProvisioningSeq(DateFormatUtils.format(new Date(), "yyyyMMdd") + UUID.randomUUID());
			res.setProvisioningStatus(CodeUtil.CMM_CODE_PROVISIONING_READY);
			if(res.getExportType().equals("PROD")) {
				res.setRequestType(CodeUtil.CMM_CODE_REQTYPE_PROD);
				res.setProductCategory(CodeUtil.CMM_CODE_PRODCATE_ENV);
			} else {
				res.setRequestType(sRequestType);
				res.setProductCategory(sProduct);
			}
			res.setOrderProductSeq(orderProductSeq);
//			res.setProductCategory(sProduct);
			CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo(res.getCloudId());
			res.setCloudType(cloudVo.getCloudType());
			reqProductDAO.insertProvisioningQueue(res);

//			res = reqProductDAO.detailBssOrderProductApp(orderProductSeq);
//			if (res != null && res.getOrderProductSeq() != null) {
//			    res.setOrderUserId(orderUserId);
//			    res.setProvisioningSeq(DateFormatUtils.format(new Date(), "yyyyMMdd") + UUID.randomUUID());
//			    res.setProvisioningStatus(CodeUtil.CMM_CODE_PROVISIONING_READY);
//			    res.setRequestType(sRequestType);
//			    res.setOrderProductSeq(orderProductSeq);
//			    res.setProductCategory(sProduct);
//			    CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo(res.getCloudId());
//			    res.setCloudType(cloudVo.getCloudType());
//			    reqProductDAO.insertProvisioningQueue(res);
//			} else {
//				CustomReqProductVO resEnv = new CustomReqProductVO();
//				resEnv = reqProductDAO.detailBssOrderProductEnv(orderProductSeq);
//
//			    resEnv.setOrderUserId(orderUserId);
//			    resEnv.setProvisioningSeq(DateFormatUtils.format(new Date(), "yyyyMMdd") + UUID.randomUUID());
////			    resEnv.setProvisioningStatus(CodeUtil.CMM_CODE_PROVISIONING_READY);
//			    resEnv.setProvisioningStatus("PROVISIONING_DEV");
//			    resEnv.setRequestType(sRequestType);
//			    resEnv.setOrderProductSeq(orderProductSeq);
//			    resEnv.setProductCategory(sProduct);
//			    CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo(resEnv.getCloudId());
//			    resEnv.setCloudType(cloudVo.getCloudType());
//			    reqProductDAO.insertProvisioningQueue(resEnv);
//			}



//		} else if(sProduct.equals(CodeUtil.CMM_CODE_UPDATE_APP)) {
//			res = reqProductDAO.detailBssOrderProductApp(orderProductSeq);
//			res.setOrderUserId(orderUserId);
//			res.setProvisioningSeq(DateFormatUtils.format(new Date(), "yyyyMMdd")+UUID.randomUUID());
//			res.setProvisioningStatus(CodeUtil.CMM_CODE_PROVISIONING_READY);
//			res.setRequestType(sRequestType);
//			res.setOrderProductSeq(orderProductSeq);
//			res.setProductCategory(sProduct);
//			CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo(res.getCloudId());
//			res.setCloudType(cloudVo.getCloudType());
//			reqProductDAO.insertProvisioningQueue(res);

		} else if(sProduct.equals(CodeUtil.CMM_CODE_PRODCATE_ENV)){
			res = reqProductDAO.detailBssOrderProductEnv(orderProductSeq);
			res.setOrderUserId(orderUserId);
			res.setProvisioningSeq(DateFormatUtils.format(new Date(), "yyyyMMdd") + UUID.randomUUID());
			res.setProvisioningStatus("PROVISIONING_READY");
			res.setRequestType(sRequestType);
			res.setOrderProductSeq(orderProductSeq);
			res.setProductCategory(sProduct);
		    CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo(res.getCloudId());
		    res.setCloudType(cloudVo.getCloudType());
		    reqProductDAO.insertProvisioningQueue(res);
		} else if(sProduct.equals(CodeUtil.CMM_CODE_PRODCATE_NAS)){
			res = reqProductDAO.detailBssOrderProductNas(orderProductSeq);

			res.setOrderUserId(orderUserId);
			res.setProvisioningSeq(DateFormatUtils.format(new Date(), "yyyyMMdd")+UUID.randomUUID());
			res.setProvisioningStatus(CodeUtil.CMM_CODE_PROVISIONING_READY);
			res.setRequestType(sRequestType);
			res.setOrderProductSeq(orderProductSeq);
			res.setProductCategory(sProduct);
			CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo(res.getCloudId());
			res.setCloudType(cloudVo.getCloudType());
			reqProductDAO.insertProvisioningQueue(res);
		} else if(sProduct.equals(CodeUtil.CMM_CODE_PRODCATE_SERVICE)){
			res = reqProductDAO.detailBssOrderProductService(orderProductSeq);
			if(res.getServiceType().equals("SERVICE99")) {
				res.setOrderUserId(orderUserId);
				res.setRequestType(sRequestType);
				res.setProvisioningSeq(DateFormatUtils.format(new Date(), "yyyyMMdd")+UUID.randomUUID());
				res.setProvisioningStatus(CodeUtil.CMM_CODE_PROVISIONING_READY);
				res.setOrderProductSeq(orderProductSeq);
				res.setProductCategory(sProduct);
				res.setServiceType(res.getServiceType());
				CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo(res.getCloudId());
				res.setCloudType(cloudVo.getCloudType());
				reqProductDAO.insertProvisioningQueue(res);
			}
		}
	}

//	private void changeVM(CustomReqProductVO req) {
//		try {
//			CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo(req.getCloudId());
//			ServerIF serverIF = AbstractFactory.getServerIF(req.getProjectName(),cloudVo);
//			Resize resize = new Resize();
//			resize.setServer_id(req.getVmUuid());
//			resize.setFlavorRef(setFlaver(req));
//			serverIF.resizeServer(resize,cloudVo);
//
//			reqProductDAO.updateOssVm(req);
//		} catch (NotConnectGatewayException | NotSupportGatewayException | InvaildOpenStackException e) {
//			log.error(e.getMessage());
//		}
//	}
//
//	private void deleteVM(CustomReqProductVO req) {
//		try {
//			CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo(req.getCloudId());
//			BatchProcessor.deleteServer(req.getProjectName(), req.getVmUuid(),cloudVo);
//
//			reqProductDAO.deleteOssVm(req);
//		} catch (NotConnectGatewayException | NotSupportGatewayException | InvaildOpenStackException e) {
//			log.error(e.getMessage());
//		}
//	}
//
//	private void createDisk(CustomReqProductVO req) {
//		try {
//			CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo(req.getCloudId());
//			VolumeIF volumeIF = AbstractFactory.getVolumeIF(req.getProjectName(),cloudVo);
//			Volume volume = new Volume();
//			//volume.setSize(Integer.parseInt(req.getDiskGb()));
//			volume.setSize(1);
//			Volume obj = volumeIF.createVolume(volume,cloudVo);
//
//			req.setDiskId(obj.getId());
//			req.setCreateDatetime(req.getOnDemandFlag().equals("N")?req.getApplyDatetime():DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss"));
//			reqProductDAO.insertOssDisk(req);
//
//			CustomOssDiskVO vo = new CustomOssDiskVO();
//			vo.setProjectName(req.getProjectName());
//			vo.setVmUuid(req.getVmUuid());
//			vo.setDiskId(req.getDiskId());
//
//			service.attach(vo);
//
//		} catch (NotConnectGatewayException | NotSupportGatewayException | InvaildOpenStackException e) {
//			log.error(e.getMessage());
//		}
//	}
//
//	private void changeDisk(CustomReqProductVO req) {
//		try {
//			CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo(req.getCloudId());
//			VolumeIF volumeIF = AbstractFactory.getVolumeIF(req.getProjectName(),cloudVo);
//			//volumeIF.extendVolume(req.getDiskId(), Integer.parseInt(req.getDiskGb()));
//			volumeIF.extendVolume(req.getDiskId(), 1,cloudVo);
//
//			reqProductDAO.updateOssDisk(req);
//		} catch (NotConnectGatewayException | NotSupportGatewayException | InvaildOpenStackException e) {
//			log.error(e.getMessage());
//		}
//	}
//
//	private void deleteDisk(CustomReqProductVO req) {
//		try {
//			CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo(req.getCloudId());
//			VolumeIF volumeIF = AbstractFactory.getVolumeIF(req.getProjectName(),cloudVo);
//			volumeIF.deleteVolume(req.getDiskId(),cloudVo);
//
//			reqProductDAO.deleteOssDisk(req);
//		} catch (NotConnectGatewayException | NotSupportGatewayException | InvaildOpenStackException e) {
//			log.error(e.getMessage());
//		}
//	}

	@Override
	public List<CustomReqProductVO> getReqDiskOrderList(String orderNo){
		return reqProductDAO.getReqDiskOrderList(orderNo);
	}

	@Override
	public List<CustomReqProductVO> getReqNasOrderList(String orderNo){
		return reqProductDAO.getReqNasOrderList(orderNo);
	}

	@Override
	public List<CustomReqProductVO> getReqIpOrderList(String orderNo){
		return reqProductDAO.getReqIpOrderList(orderNo);
	}

	@Override
	public List<CustomReqProductVO> getReqLbOrderList(String orderNo){
		return reqProductDAO.getReqLbOrderList(orderNo);
	}

	@Override
	public List<CustomReqProductVO> getReqSnOrderList(String orderNo){
		return reqProductDAO.getReqSnOrderList(orderNo);
	}

	@Override
	public List<CustomReqProductVO> getReqAppOrderList(String orderNo){
		return reqProductDAO.getReqAppOrderList(orderNo);
	}

	@Override
	public List<CustomReqProductVO> getReqEnvOrderList(String orderNo){
		return reqProductDAO.getReqEnvOrderList(orderNo);
	}

	@Override
	public List<CustomReqProductVO> getReqPrdOrderList(String orderNo){
		return reqProductDAO.getReqPrdOrderList(orderNo);
	}

	@Override
	public List<CustomReqProductVO> bssEnvUserList(String orderProductSeq) {
		return reqProductDAO.bssEnvUserList(orderProductSeq);
	}

//	@Override
//	public List<CustomReqProductVO> getReqBakOrderList(String orderNo){
//		return reqProductDAO.getReqBakOrderList(orderNo);
//	}

	@Override
	public List<CustomReqProductVO> getReqServiceOrderList(String orderNo){
		return reqProductDAO.getReqServiceOrderList(orderNo);
	}

//	@Override
//	public List<CustomReqProductVO> getReqMcaOrderList(String orderNo){
//		return reqProductDAO.getReqMcaOrderList(orderNo);
//	}

//	@Override
//	public List<CustomReqProductVO> getReqScmOrderList(String orderNo){
//		return reqProductDAO.getReqScmOrderList(orderNo);
//	}

//	@Override
//	public List<CustomReqProductVO> getReqSerOrderList(String orderNo){
//		return reqProductDAO.getReqSerOrderList(orderNo);
//	}

	@Override
	public List<CustomReqProductVO> getReqVMOrderList(String orderNo){
		return reqProductDAO.getReqVMOrderList(orderNo);
	}

	@Override
	public List<CustomReqProductVO> getReqOrderList(String orderNo){
		return reqProductDAO.getReqOrderList(orderNo);
	}

	@Override
	public CustomReqProductVO getOrderVm(String orderNo){
		return reqProductDAO.getOrderVm(orderNo);
	}

	@Override
	public List<CustomReqProductVO> pmList(CustomReqProductVO req){
		return reqProductDAO.pmList(req);
	}

	@Override
	public int setReqWork(CustomReqProductVO reqWork){
		return reqProductDAO.setReqWork(reqWork);
	}

	@Override
	public int getProductNameChk(CustomReqProductVO reqWork){
		return reqProductDAO.getProductNameChk(reqWork);
	}

	@Override
	public String stepUpdate(CustomReqProductVO req) {
		return reqProductDAO.stepUpdate(req)+"";
	}

	@Override
	public String reqProjectUpdate(CustomReqProductVO req) {
		return reqProductDAO.reqProjectUpdate(req)+"";
	}



	@Override
	public String stepUpdateUser(CustomReqProductVO req) {
		return reqProductDAO.stepUpdateUser(req)+"";
	}

	@Override
	public String getStepId(Map<String, String> map) {
		return reqProductDAO.getStepId(map);
	}

	@Override
	public String getUserApprvState(Map<String, String> map) {
		return reqProductDAO.getUserApprvState(map);
	}

	public int setUpdateWorkUser(CustomReqProductVO req) {
		return reqProductDAO.setUpdateWorkUser(req);
	}

	public List<CustomReqProductVO> checkWorkUser(CustomReqProductVO req) {
		return reqProductDAO.checkWorkUser(req);
	}
	@Override
	public String insertOssVmNetwork(CustomReqProductVO vm) {
		return reqProductDAO.insertOssVmNetwork(vm)+"";
	}
	public List<CustomReqProductVO> setHostNameCheck(CustomReqProductVO req) {
		return reqProductDAO.setHostNameCheck(req);
	}
	public List<CustomReqProductVO> setUserIdCheck(CustomReqProductVO req) {
		return reqProductDAO.setUserIdCheck(req);
	}
	public List<CustomReqProductVO> setUserPwCheck(CustomReqProductVO req) {
		return reqProductDAO.setUserPwCheck(req);
	}

	@Override
	public List<CustomReqProductVO> detailBbsOrder(String orderNo) {
		return reqProductDAO.detailBbsOrder(orderNo);
	}

	@Override
	public  CustomReqProductVO getOrderVo(String orderNo){
		return reqProductDAO.getOrderVo(orderNo);
	}

	@Override
	public List<CustomReqProductVO> getCloudAvailList(String orderNo) {
		return reqProductDAO.getCloudAvailList(orderNo);
	}

	@Override
	public List<CustomReqProductVO> getCloudAvail(String projectBoxId) {
		return reqProductDAO.getCloudAvail(projectBoxId);
	}


	@Override
	public CustomReqProductVO getReqDiskOrder(String orderProductSeq){
		return reqProductDAO.getReqDiskOrder(orderProductSeq);
	}

	@Override
	public CustomReqProductVO getReqNasOrder(String orderProductSeq){
		return reqProductDAO.getReqNasOrder(orderProductSeq);
	}

	@Override
	public CustomReqProductVO getReqIpOrder(String orderProductSeq){
		return reqProductDAO.getReqIpOrder(orderProductSeq);
	}

	@Override
	public CustomReqProductVO getReqLbOrder(String orderProductSeq){
		return reqProductDAO.getReqLbOrder(orderProductSeq);
	}

//	@Override
//	public CustomReqProductVO getReqBakOrder(String orderProductSeq){
//		return reqProductDAO.getReqBakOrder(orderProductSeq);
//	}

	@Override
	public CustomReqProductVO getReqServiceOrder(String orderProductSeq){
		return reqProductDAO.getReqServiceOrder(orderProductSeq);
	}

	@Override
	public CustomReqProductVO getReqAppOrder(String orderProductSeq){
		return reqProductDAO.getReqAppOrder(orderProductSeq);
	}

	@Override
	public CustomReqProductVO getReqEnvOrder(String orderProductSeq){
		return reqProductDAO.getReqEnvOrder(orderProductSeq);
	}

//	@Override
//	public CustomReqProductVO getReqMcaOrder(String orderProductSeq){
//		return reqProductDAO.getReqMcaOrder(orderProductSeq);
//	}

//	@Override
//	public CustomReqProductVO getReqScmOrder(String orderProductSeq){
//		return reqProductDAO.getReqScmOrder(orderProductSeq);
//	}

//	@Override
//	public CustomReqProductVO getReqScrOrder(String orderProductSeq){
//		return reqProductDAO.getReqScrOrder(orderProductSeq);
//	}

	@Override
	public CustomReqProductVO getReqVmOrder(String orderProductSeq){
		return reqProductDAO.getReqVmOrder(orderProductSeq);
	}


	@Override
	public List<CustomReqProductVO> excel(CustomReqProductVO req) {
		return reqProductDAO.list(req);
	}


	@Override
	public List<CustomReqProductVO> stepIdList(String stepId) {
		return reqProductDAO.stepIdList(stepId);
	}

	@Override
	public String updateHostName(CustomReqProductVO req) {
		return reqProductDAO.setUpdateHostName(req)+"";
	}
	@Override
	public String setUpdateUserId(CustomReqProductVO req) {
		return reqProductDAO.setUpdateUserId(req)+"";
	}
	@Override
	public String setUpdateUserPw(CustomReqProductVO req) {
		return reqProductDAO.setUpdateUserPw(req)+"";
	}

	@Override
	public List<CustomReqProductVO> setIpCheck(CustomReqProductVO req) {
		return reqProductDAO.setIpCheck(req);
	}

	@Override
	public List<CustomReqProductVO> setNasIpCheck(CustomReqProductVO req) {
		return reqProductDAO.setNasIpCheck(req);
	}

	@Override
	public List<CustomReqProductVO> setBackupIpCheck(CustomReqProductVO req) {
		return reqProductDAO.setBackupIpCheck(req);
	}


	@Override
	public String updateIp(CustomReqProductVO req) {
		return reqProductDAO.setUpdateIp(req)+"";
	}


	@Override
	public String updateBackupIp(CustomReqProductVO req) {
		return reqProductDAO.setUpdateBackupIp(req)+"";
	}

	@Override
	public String updateNasIp(CustomReqProductVO req) {
		return reqProductDAO.setUpdateNasIp(req)+"";
	}

	@Override
	public String changeProvisioning(CustomReqProductVO req) {
		return reqProductDAO.changeProvisioning(req)+"";
	}

	@Override
	public String endProvisioning(CustomReqProductVO req) {
		return reqProductDAO.endProvisioning(req)+"";
	}

	@Override
	public CustomReqProductVO getProvisioningStatus(String orderProductSeq){
		return reqProductDAO.getProvisioningStatus(orderProductSeq);
	}

	@Override
	public List<CustomReqProductVO> getOrderList(CustomReqProductVO req){
		return reqProductDAO.getOrderList(req);
	}

	@Override
	public List<CustomReqProductVO> getSumVm(CustomReqProductVO req){
		return reqProductDAO.getSumVm(req);
	}

	@Override
	public List<CustomReqProductVO> getSumDisk(CustomReqProductVO req){
		return reqProductDAO.getSumDisk(req);
	}
	@Override
	public List<CustomReqProductVO> getSumService(CustomReqProductVO req){
		return reqProductDAO.getSumService(req);
	}
	@Override
	public List<CustomReqProductVO> getSumLB(CustomReqProductVO req){
		return reqProductDAO.getSumLB(req);
	}

	@Override
	public List<CustomReqProductVO> getSumSN(CustomReqProductVO req){
		return reqProductDAO.getSumSN(req);
	}

	@Override
	public List<CustomReqProductVO> getSumAPP(CustomReqProductVO req){
		return reqProductDAO.getSumAPP(req);
	}


	@Override
	public CustomReqProductVO getFlaverDetail(CustomReqProductVO req){
		return reqProductDAO.getFlaverDetail(req);
	}



	@Override
	public CustomReqProductVO processSumVm(CustomReqProductVO req){
		return reqProductDAO.processSumVm(req);
	}

	@Override
	public CustomReqProductVO processSumDisk(CustomReqProductVO req){
		return reqProductDAO.processSumDisk(req);
	}

	@Override
	public CustomReqProjectVO getAdminProject() {
		return reqProductDAO.getAdminProject();
	}

	@Override
	public  String bssOrderProductUpdate(CustomReqProductVO req){
		return reqProductDAO.bssOrderProductUpdate(req)+"";
	}
	@Override
	public  String bssOrderProductVmUpdate(CustomReqProductVO req){
		return reqProductDAO.bssOrderProductVmUpdate(req)+"";
	}

	@Override
	public  String bssOrderProductNasUpdate(CustomReqProductVO req){
		return reqProductDAO.bssOrderProductNasUpdate(req)+"";
	}

	@Override
	public int bssOrderProductAppNameChk(CustomReqProductVO req) {
		return reqProductDAO.bssOrderProductAppNameChk(req);
	}

	@Override
	public List<CustomReqProductVO> detailBssOrder(String orderNo) {
		return reqProductDAO.detailBssOrder(orderNo);
	}

	@Override
	public String bssOrderProductAppUpdate(CustomReqProductVO req) {
		return reqProductDAO.bssOrderProductAppUpdate(req)+"";
	}

	// 개발환경 중복체크
	public int envGrpUrlChk(CustomReqProductVO req){
		return reqProductDAO.envGrpUrlChk(req);
	}

	// 개발환경명 중복체크
	public int envNameChk(CustomReqProductVO req){
		return reqProductDAO.envNameChk(req);
	}

	public int envGroupNameChk(CustomReqProductVO req){
		return reqProductDAO.envGroupNameChk(req);
	}

	@Override
	public String envNameInsert(CustomReqProductVO env) {
		return reqProductDAO.envNameInsert(env)+"";
	}

	@Override
	public String envGroupNameInsert(CustomReqProductVO env) {
		return reqProductDAO.envGroupNameInsert(env)+"";
	}


}