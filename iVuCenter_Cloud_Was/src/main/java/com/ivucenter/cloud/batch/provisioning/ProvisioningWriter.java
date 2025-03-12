package com.ivucenter.cloud.batch.provisioning;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.stream.Collectors;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateFormatUtils;
import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.batch.item.ItemWriter;
import org.springframework.beans.factory.annotation.Autowired;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.reflect.TypeToken;
import com.ivucenter.cloud.api.ansible.AnsibleObject;
import com.ivucenter.cloud.api.ansible.AnsibleUtils;
import com.ivucenter.cloud.api.common.batch.BatchProcessor;
import com.ivucenter.cloud.api.common.utils.SystemCalculatorInfo;
import com.ivucenter.cloud.api.gitlab.GitlabObject;
import com.ivucenter.cloud.api.gitlab.GitlabUtils;
import com.ivucenter.cloud.api.nas.NasObject;
import com.ivucenter.cloud.api.nas.NasType;
import com.ivucenter.cloud.api.nas.NasUtils;
import com.ivucenter.cloud.api.nas.object.NasObjectVO;
import com.ivucenter.cloud.api.nutanix.NutanixObject;
import com.ivucenter.cloud.api.nutanix.NutanixPowerState;
import com.ivucenter.cloud.api.nutanix.NutanixUtils;
import com.ivucenter.cloud.api.openshift.object.OpsApiOptionService;
import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.api.openstack.interfaces.AbstractFactory;
import com.ivucenter.cloud.api.openstack.interfaces.FlavorIF;
import com.ivucenter.cloud.api.openstack.interfaces.PortIF;
import com.ivucenter.cloud.api.openstack.interfaces.ServerIF;
import com.ivucenter.cloud.api.openstack.interfaces.VolumeIF;
import com.ivucenter.cloud.api.openstack.object.FixedIPS;
import com.ivucenter.cloud.api.openstack.object.Flavor;
import com.ivucenter.cloud.api.openstack.object.Network;
import com.ivucenter.cloud.api.openstack.object.Port;
import com.ivucenter.cloud.api.openstack.object.Project;
import com.ivucenter.cloud.api.openstack.object.Resize;
import com.ivucenter.cloud.api.openstack.object.Server;
import com.ivucenter.cloud.api.openstack.object.Volume;
import com.ivucenter.cloud.api.openstack.object.VolumeAttachment;
import com.ivucenter.cloud.api.vRealize.connector.vraRestResponse;
import com.ivucenter.cloud.api.vRealize.interfaces.vraAbstractFactory;
import com.ivucenter.cloud.api.vRealize.interfaces.vraDiskIF;
import com.ivucenter.cloud.api.vRealize.interfaces.vraNetworkIF;
import com.ivucenter.cloud.api.vRealize.interfaces.vraServerIF;
import com.ivucenter.cloud.api.vRealize.object.vraAttachDisk;
import com.ivucenter.cloud.api.vRealize.object.vraBlockDevice;
import com.ivucenter.cloud.api.vRealize.object.vraContent;
import com.ivucenter.cloud.api.vRealize.object.vraDataStoreContent;
import com.ivucenter.cloud.api.vRealize.object.vraDiskContent;
import com.ivucenter.cloud.api.vRealize.object.vraInputs;
import com.ivucenter.cloud.api.vRealize.object.vraJsonObject;
import com.ivucenter.cloud.api.vRealize.object.vraMachineDisks;
import com.ivucenter.cloud.api.vRealize.object.vraNetworkInterfaces;
import com.ivucenter.cloud.api.vRealize.object.vraNetworks;
import com.ivucenter.cloud.api.vRealize.object.vraProjectObject;
import com.ivucenter.cloud.api.vRealize.object.vraServer;
import com.ivucenter.cloud.api.vRealize.object.vraServerDeploy;
import com.ivucenter.cloud.api.vRealize.object.vraServerObject;
import com.ivucenter.cloud.api.vRealize.object.vraServerRequest;
import com.ivucenter.cloud.api.vmware.interfaces.VmAbstractFactory;
import com.ivucenter.cloud.api.vmware.interfaces.VmDiskIF;
import com.ivucenter.cloud.api.vmware.interfaces.VmHardwareCpuIF;
import com.ivucenter.cloud.api.vmware.interfaces.VmHardwareMemIF;
import com.ivucenter.cloud.api.vmware.interfaces.VmServerIF;
import com.ivucenter.cloud.api.vmware.object.DiskBacking;
import com.ivucenter.cloud.api.vmware.object.DiskInfo;
import com.ivucenter.cloud.api.vmware.object.DiskSpec;
import com.ivucenter.cloud.api.vmware.object.VmCapacity;
import com.ivucenter.cloud.api.vmware.object.VmCpuUpdate;
import com.ivucenter.cloud.api.vmware.object.VmDiskStorage;
import com.ivucenter.cloud.api.vmware.object.VmDiskToUpdate;
import com.ivucenter.cloud.api.vmware.object.VmDisks;
import com.ivucenter.cloud.api.vmware.object.VmHardwareCpuSpecVO;
import com.ivucenter.cloud.api.vmware.object.VmHardwareCpuVO;
import com.ivucenter.cloud.api.vmware.object.VmHardwareCustomization;
import com.ivucenter.cloud.api.vmware.object.VmHardwareMemSpecVO;
import com.ivucenter.cloud.api.vmware.object.VmHardwareMemVO;
import com.ivucenter.cloud.api.vmware.object.VmMemoryUpdate;
import com.ivucenter.cloud.api.vmware.object.VmNics;
import com.ivucenter.cloud.api.vmware.object.VmPlacement;
import com.ivucenter.cloud.api.vmware.object.VmServer;
import com.ivucenter.cloud.api.vmware.object.VmSpec;
import com.ivucenter.cloud.api.vmware.object.VmWareJsonObject;
import com.ivucenter.cloud.batch.entity.BatchOssPortVO;
import com.ivucenter.cloud.batch.entity.BatchProvisioningVO;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;
import com.ivucenter.cloud.portal.cmm.cloud.OssCloudService;
import com.ivucenter.cloud.portal.oss.project.CustomOssProjectVO;
import com.ivucenter.cloud.portal.oss.project.OssProjectDAO;
import com.ivucenter.cloud.portal.oss.project.OssProjectService;
import com.ivucenter.cloud.portal.req.customer.CustomReqCustomerVO;
import com.ivucenter.cloud.portal.req.product.CustomReqProductVO;
import com.ivucenter.cloud.portal.req.project.CustomReqProjectVO;
import com.ivucenter.cloud.portal.req.project.ReqProjectService;
import com.ivucenter.cloud.portal.util.CodeUtil;

import io.fabric8.kubernetes.api.model.ObjectMeta;
import io.fabric8.kubernetes.api.model.PersistentVolume;
import io.fabric8.kubernetes.api.model.PersistentVolumeClaim;
import io.fabric8.kubernetes.api.model.ServiceList;
import io.fabric8.openshift.api.model.BuildList;
import io.fabric8.openshift.api.model.DeploymentConfig;
import io.fabric8.openshift.api.model.DeploymentConfigList;
import io.fabric8.openshift.api.model.RouteList;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class ProvisioningWriter implements ItemWriter<BatchProvisioningVO> {

    private static final Logger logger = LoggerFactory.getLogger(ProvisioningWriter.class);

	private final String batchProvisioningDAO = "com.ivucenter.cloud.batch.provisioning.BatchProvisioningDAO.";
//	private final String reqProductDAO				= "com.ivucenter.cloud.portal.req.product.ReqProductDAO.";

	private final String updateProvisioning = batchProvisioningDAO + "updateProvisioning";
	private final String detailBssOrderProductVm = batchProvisioningDAO + "detailBssOrderProductVm";
	private final String detailBssOrderProductDisk = batchProvisioningDAO + "detailBssOrderProductDisk";
	private final String detailBssOrderProductAPP = batchProvisioningDAO + "detailBssOrderProductAPP";
	private final String detailBssOrderProductNas = batchProvisioningDAO + "detailBssOrderProductNas";
	private final String detailBssOrderProductNasVm = batchProvisioningDAO + "detailBssOrderProductNasVm";
	private final String detailBssOrderProductService = batchProvisioningDAO + "detailBssOrderProductService";
	private final String insertOssVm = batchProvisioningDAO + "insertOssVm";
	private final String updateOssVm = batchProvisioningDAO + "updateOssVm";
	private final String deleteOssVm = batchProvisioningDAO + "deleteOssVm";

	private final String insertOssService = batchProvisioningDAO + "insertOssService";
//	private final String updateOssService = batchProvisioningDAO + "updateOssService";
	private final String deleteOssService = batchProvisioningDAO + "deleteOssService";

	private final String insertOssNas = batchProvisioningDAO + "insertOssNas";
	private final String insertOssNasVm = batchProvisioningDAO + "insertOssNasVm";
	private final String deleteOssNas = batchProvisioningDAO + "deleteOssNas";
	private final String deleteOssNasVm = batchProvisioningDAO + "deleteOssNasVm";
	private final String deleteOssApp = batchProvisioningDAO + "deleteOssApp";
	private final String insertOssVmNetwork = batchProvisioningDAO + "insertOssVmNetwork";
	private final String insertOssPort = batchProvisioningDAO + "insertOssPort";
	private final String insertOssApp = batchProvisioningDAO + "insertOssApp";
	private final String deleteOssPort = batchProvisioningDAO + "deleteOssPort";
	private final String insertOssDisk = batchProvisioningDAO + "insertOssDisk";
	private final String updateOssDisk = batchProvisioningDAO + "updateOssDisk";
	private final String deleteOssDisk = batchProvisioningDAO + "deleteOssDisk";
	private final String deleteOssDiskVmUuid = batchProvisioningDAO + "deleteOssDiskVmUuid";
	private final String getOssDiskList = batchProvisioningDAO + "getDiskList";
	private final String getBackupNetwork = batchProvisioningDAO + "getBackupNetwork";
	private final String getDataStore = batchProvisioningDAO + "getDataStore";
	private final String getOssDiskAt = batchProvisioningDAO + "getOssDiskAt";
	private final String updateOssApp = batchProvisioningDAO + "updateOssApp";
	private final String getDataDiskIds				= batchProvisioningDAO + "getDataDiskIds";

	private final String detailBssOrderProductEnv = batchProvisioningDAO + "detailBssOrderProductEnv";
	private final String detailBssOrderProductEnvUserList = batchProvisioningDAO + "detailBssOrderProductEnvUserList";
	private final String detailConfigTemplate = batchProvisioningDAO + "detailConfigTemplate";
	private final String getConfigTemplateList = batchProvisioningDAO + "getConfigTemplateList";



	private final String deleteCicdBranchTag = batchProvisioningDAO + "deleteCicdBranchTag";
	private final String insertCicdBranch = batchProvisioningDAO + "insertCicdBranch";
	private final String insertCicdBranchTag = batchProvisioningDAO + "insertCicdBranchTag";
	private final String insertCicdGroup = batchProvisioningDAO + "insertCicdGroup";
	private final String insertCicdJob = batchProvisioningDAO + "insertCicdJob";
	private final String insertCicdMergeRequest = batchProvisioningDAO + "insertCicdMergeRequest";
	private final String insertCicdPipeline = batchProvisioningDAO + "insertCicdPipeline";
	private final String insertCicdProject = batchProvisioningDAO + "insertCicdProject";
	private final String updateCicdProjectEnvironmentStatus = batchProvisioningDAO + "updateCicdProjectEnvironmentStatus";

	private final String insertCicdProjectUser = batchProvisioningDAO + "insertCicdProjectUser";
	private final String insertCicdRepository = batchProvisioningDAO + "insertCicdRepository";
	private final String insertCicdUser = batchProvisioningDAO + "insertCicdUser";



	private final String detailBssOrderProductReqtypeDev = batchProvisioningDAO + "detailBssOrderProductReqtypeDev";
	private final String cicdGourpProjectInfo = batchProvisioningDAO + "cicdGourpProjectInfo";
	private final String cicdProjectUserInfo = batchProvisioningDAO + "cicdProjectUserInfo";
	private final String getBssOrderProductVmInfo = batchProvisioningDAO + "getBssOrderProductVmInfo";
	private final String updateOssServiceDelFlag = batchProvisioningDAO + "updateOssServiceDelFlag";

	@Autowired
	private OssProjectDAO dao;

	@Autowired
	private OssProjectService service;

	@Autowired
	private ReqProjectService reqProjectService;

	@Autowired
	private BatchAlarmService batchAlarmService;

	@Autowired
	private OssCloudService ossCloudService;

	@Autowired
	OpsApiOptionService opsApiOptionService;

	@Setter
	private SqlSessionFactory sqlSessionFactory;

	@Setter
	private Map<String, Object> parameterValues;

	private SqlSessionTemplate sqlSessionTemplate;
//    private OssDiskService service;
	private int count = 10;
//    private int limit = 1;
//    private int errorCount = 0;

	class InCloudList {
		private List<CustomOssCloudVO> list = null;

		public void setCloudList(List<CustomOssCloudVO> inList) {
			this.list = inList;
		}

		public CustomOssCloudVO getCloudVo(String cloudId) {
			for (CustomOssCloudVO vo : this.list) {
				if (vo.getCloudId().equals(cloudId)) {
					return vo;
				}
			}
			return null;
		}
	}

	private InCloudList inCloudList = null;

	@Override
	public void write(List<? extends BatchProvisioningVO> items) throws Exception {
		this.sqlSessionTemplate = new SqlSessionTemplate(this.sqlSessionFactory, ExecutorType.BATCH);
		SystemCalculatorInfo systemCalculatorInfo = new SystemCalculatorInfo();
		String orderProductSeq;
		String sProduct;
		String sRequestType;
		String orderUserId;
		CustomReqProductVO res = new CustomReqProductVO();
		int sleepTime = Integer.parseInt(systemCalculatorInfo.getSleepTime());
		this.inCloudList = new InCloudList();
		this.inCloudList.setCloudList(ossCloudService.getCloudList());

		for (BatchProvisioningVO item : items) {

			CustomOssCloudVO cloudVo = this.inCloudList.getCloudVo(item.getCloudId());

			item.setProvisioningStatus("PROVISIONING_ONGOING");
			item.setRegUserId("BATCH_SYSTEM");

			this.sqlSessionTemplate.update(updateProvisioning, item);

			orderProductSeq = item.getOrderProductSeq();
			sProduct = item.getProductCategory();
			sRequestType = item.getRequestType();
			orderUserId = item.getOrderUserId();

			log.debug("OrderProductSeq={},productCategory={},RequestType={},orderUserId={}", orderProductSeq, sProduct,
					sRequestType, orderUserId);
			if (item.getProductCategory().equals("PRODCATE_PROJECT")) {
				CustomOssProjectVO projectRes = new CustomOssProjectVO();
				projectRes = createProject(item);
				BatchProvisioningVO insertVO = new BatchProvisioningVO();
				insertVO.setProvisioningSeq(item.getProvisioningSeq());
				insertVO.setRegUserId("BATCH_SYSTEM");
				insertVO.setProvisioningStatus(projectRes.getErrorStatus());
				if ("PROVISIONING_FAIL".equals(projectRes.getErrorStatus())) {
					insertVO.setProvisioningStatusMessage(projectRes.getErrorMsg());
				} else if ("PROVISIONING_SUCCESS".equals(projectRes.getErrorStatus())) {
					// sendMessageToCustomer(item);
				}
				this.sqlSessionTemplate.update(updateProvisioning, insertVO);
				Thread.sleep(sleepTime);
			} else if(item.getProductCategory().equals("PRODCATE_APP")) {
				res = productByOpenShift(orderProductSeq, sProduct, sRequestType, orderUserId, cloudVo);
				BatchProvisioningVO insertVO = new BatchProvisioningVO();
				insertVO.setProvisioningSeq(item.getProvisioningSeq());
				insertVO.setRegUserId("BATCH_SYSTEM");
				insertVO.setProvisioningStatus(res.getErrorStatus());
				if ("PROVISIONING_FAIL".equals(res.getErrorStatus())) {
					insertVO.setProvisioningStatusMessage(res.getErrorMsg());
				} else if ("PROVISIONING_SUCCESS".equals(res.getErrorStatus())) {
					sendMessageToCustomer(item);
				}
				this.sqlSessionTemplate.update(updateProvisioning, insertVO);
				Thread.sleep(sleepTime);
			} else if(item.getProductCategory().equals("PRODCATE_ENV")) {
				res = productByEnv(orderProductSeq, sProduct, sRequestType, orderUserId, cloudVo);
				BatchProvisioningVO insertVO = new BatchProvisioningVO();
				insertVO.setProvisioningSeq(item.getProvisioningSeq());
				insertVO.setRegUserId("BATCH_SYSTEM");
				insertVO.setProvisioningStatus(res.getErrorStatus());
				if ("PROVISIONING_FAIL".equals(res.getErrorStatus())) {
					insertVO.setProvisioningStatusMessage(res.getErrorMsg());
				} else if ("PROVISIONING_SUCCESS".equals(res.getErrorStatus())) {
					sendMessageToCustomer(item);
				}
				this.sqlSessionTemplate.update(updateProvisioning, insertVO);
				Thread.sleep(sleepTime);
			} else if(item.getProductCategory().equals("PRODCATE_NAS")) {
				res = productByNas(orderProductSeq, sProduct, sRequestType, orderUserId, cloudVo);
				BatchProvisioningVO insertVO = new BatchProvisioningVO();
				insertVO.setProvisioningSeq(item.getProvisioningSeq());
				insertVO.setRegUserId("BATCH_SYSTEM");
				insertVO.setProvisioningStatus(res.getErrorStatus());
				if ("PROVISIONING_FAIL".equals(res.getErrorStatus())) {
					insertVO.setProvisioningStatusMessage(res.getErrorMsg());
				} else if ("PROVISIONING_SUCCESS".equals(res.getErrorStatus())) {
					sendMessageToCustomer(item);
				}
				this.sqlSessionTemplate.update(updateProvisioning, insertVO);

			} else {

				if (cloudVo.getCloudType().equals("openstack")) {
					res = productByOpenSteak(orderProductSeq, sProduct, sRequestType, orderUserId, cloudVo);
				} else if (cloudVo.getCloudType().equals("vmware")) {
					// res = productByVmWare(orderProductSeq , sProduct, sRequestType, orderUserId,
					// cloudVo);
					res = productByVra(orderProductSeq, sProduct, sRequestType, orderUserId, cloudVo);
				} else if (cloudVo.getCloudType().equals("nutanix")) {

					res = productByNutanix(orderProductSeq, sProduct, sRequestType, orderUserId, cloudVo);

				}


				BatchProvisioningVO insertVO = new BatchProvisioningVO();
				insertVO.setProvisioningSeq(item.getProvisioningSeq());
				insertVO.setRegUserId("BATCH_SYSTEM");
				insertVO.setProvisioningStatus(res.getErrorStatus());
				if ("PROVISIONING_FAIL".equals(res.getErrorStatus())) {
					insertVO.setProvisioningStatusMessage(res.getErrorMsg());
				} else if ("PROVISIONING_SUCCESS".equals(res.getErrorStatus())) {
					sendMessageToCustomer(item);
				}
				this.sqlSessionTemplate.update(updateProvisioning, insertVO);
				Thread.sleep(sleepTime);
			}
		}
	}

	private void sendMessageToCustomer(BatchProvisioningVO provisioningVO) {
		String orderProductSeq = provisioningVO.getOrderProductSeq();
		String receiverId = provisioningVO.getOrderUserId();
		String productCategory = provisioningVO.getProductCategory();
		String productName = "";

		CustomReqProductVO res = new CustomReqProductVO();
		if (productCategory.equals(CodeUtil.CMM_CODE_PRODCATE_VM)) {
			res = this.sqlSessionTemplate.selectOne(detailBssOrderProductVm, orderProductSeq);
			productName = res.getHostnameAlias();
		} else if (productCategory.equals(CodeUtil.CMM_CODE_PRODCATE_DISK)) {
			res = this.sqlSessionTemplate.selectOne(detailBssOrderProductDisk, orderProductSeq);
			productName = res.getDiskName();
		}

		batchAlarmService.sendAlarmMessage("0037", receiverId, productName, orderProductSeq);
	}

	private CustomReqProductVO productByOpenSteak(String orderProductSeq, String sProduct, String sRequestType,
			String orderUserId, CustomOssCloudVO cloudVo) {
		CustomReqProductVO res = new CustomReqProductVO();
//		errorCount = 0;
		res.setCloudId(cloudVo.getCloudId());

		log.debug("orderProductSeq=" + orderProductSeq);

		if (sProduct.equals(CodeUtil.CMM_CODE_PRODCATE_VM)) {

			res = this.sqlSessionTemplate.selectOne(detailBssOrderProductVm, orderProductSeq);
			res.setOrderUserId(orderUserId);
			res.setErrorStatus("PROVISIONING_SUCCESS");

			if (sRequestType.equals(CodeUtil.CMM_CODE_REQTYPE_NEW)) {
				res = createVM(res, cloudVo);
			} // 신규
			else if (sRequestType.equals(CodeUtil.CMM_CODE_REQTYPE_CHANGE)) {
				res = changeVM(res, cloudVo);
			} // 변경
			else if (sRequestType.equals(CodeUtil.CMM_CODE_REQTYPE_EXPR)) {
				res = deleteVM(res, cloudVo);
			} // 삭제

		} else if (sProduct.equals(CodeUtil.CMM_CODE_PRODCATE_DISK)) {

			res = this.sqlSessionTemplate.selectOne(detailBssOrderProductDisk, orderProductSeq);
			res.setOrderUserId(orderUserId);
			res.setErrorStatus("PROVISIONING_SUCCESS");

			if (sRequestType.equals(CodeUtil.CMM_CODE_REQTYPE_NEW)) {
				res = createDisk(res, cloudVo);
			} // 신규 생성
			else if (sRequestType.equals(CodeUtil.CMM_CODE_REQTYPE_CHANGE)) {
				res = changeDisk(res, cloudVo);
			} // 변경
			else if (sRequestType.equals(CodeUtil.CMM_CODE_REQTYPE_EXPR)) {
				res = deleteDisk(res, cloudVo);
			} // 삭제
		} else if (sProduct.equals(CodeUtil.CMM_CODE_PRODCATE_SERVICE)) {

			res = this.sqlSessionTemplate.selectOne(detailBssOrderProductService, orderProductSeq);
			res.setOrderUserId(orderUserId);
			res.setErrorStatus("PROVISIONING_SUCCESS");

			if (sRequestType.equals(CodeUtil.CMM_CODE_REQTYPE_NEW)) {
				res = createService(res, cloudVo);
			} // 신규 생성
//			else if (sRequestType.equals(CodeUtil.CMM_CODE_REQTYPE_CHANGE)) {
//				res = changeDisk(res, cloudVo);
//			} // 변경
			else if (sRequestType.equals(CodeUtil.CMM_CODE_REQTYPE_EXPR)) {
				res = deleteService(res, cloudVo);
			} // 삭제
		}

		return res;
	}

	private CustomReqProductVO productByOpenShift(String orderProductSeq, String sProduct, String sRequestType,
			String orderUserId, CustomOssCloudVO cloudVo) {
		CustomReqProductVO res = new CustomReqProductVO();
//		errorCount = 0;

		int size = 0;
        int servicesCnt = 0;
        int routesCnt = 0;
        int buildsCnt = 0;
        int configsCnt = 0;

		res.setCloudId(cloudVo.getCloudId());

		log.debug("orderProductSeq=" + orderProductSeq);
		log.debug("sProduct=" + sProduct);

		if (sProduct.equals(CodeUtil.CMM_CODE_PRODCATE_APP)) {

			res = this.sqlSessionTemplate.selectOne(detailBssOrderProductAPP, orderProductSeq);
			res.setOrderUserId(orderUserId);
			res.setErrorStatus("PROVISIONING_SUCCESS");

			if (sRequestType.equals(CodeUtil.CMM_CODE_REQTYPE_NEW)) {

				Map<String, Object> returnMap = opsApiOptionService.opsCreateApplicationMap(res, cloudVo);
				if( returnMap != null) {
					if( returnMap.get("deploymentConfig") != null) {
						DeploymentConfig dp = (DeploymentConfig) returnMap.get("deploymentConfig");
//						KubernetesList template = (KubernetesList) returnMap.get("template");
						ObjectMeta meta = dp.getMetadata();
						res.setAppUid(meta.getUid());
						res.setApiVersion(dp.getApiVersion());
						res.setKind(dp.getKind());
						res.setAppName(meta.getName());
						res.setAppNameSpace(meta.getNamespace());
						res.setCreateDatetime(meta.getCreationTimestamp());
						res.setOrderProductSeq(orderProductSeq);
						res.setPod(dp.getSpec().getReplicas().toString());
						res.setCpuReq(Integer.parseInt(dp.getSpec().getTemplate().getSpec().getContainers().get(0).getResources().getRequests().get("cpu").toString()));
						res.setCpuLimit(Integer.parseInt(dp.getSpec().getTemplate().getSpec().getContainers().get(0).getResources().getLimits().get("cpu").toString()));
						res.setMemReq(Integer.parseInt(dp.getSpec().getTemplate().getSpec().getContainers().get(0).getResources().getRequests().get("memory").toString().replaceAll("[^0-9]", "")));
						res.setMemLimit(Integer.parseInt(dp.getSpec().getTemplate().getSpec().getContainers().get(0).getResources().getLimits().get("memory").toString().replaceAll("[^0-9]", "")));
					    res.setVolume(dp.getSpec().getTemplate().getSpec().getVolumes().size());

					    // project_name / app name
				    	ServiceList getServiceList = opsApiOptionService.getService(cloudVo, meta.getNamespace(), meta.getName());
						RouteList getRouteList = opsApiOptionService.getRouteList(cloudVo, meta.getNamespace());
						BuildList getBuildList = opsApiOptionService.getBuild(cloudVo, meta.getNamespace(), meta.getName());
						DeploymentConfigList getConfigList = opsApiOptionService.getDeploymentConfigList(cloudVo, meta.getNamespace());

						servicesCnt = getServiceList.getItems().size();
				        buildsCnt = getBuildList.getItems().size();

				        String tempAppStr = "";
				        String tempApp = "";

				        for(int rCnt=0; rCnt < getRouteList.getItems().size(); rCnt++) {
				        	tempAppStr = getRouteList.getItems().get(rCnt).getMetadata().getLabels().get("application");
				        	tempApp = getRouteList.getItems().get(rCnt).getMetadata().getLabels().get("app");

				        	if(meta.getName().equals(tempAppStr) || meta.getName().equals(tempApp)){
				        		routesCnt ++;
				        	}
				        }
				        for(int dCnt=0; dCnt < getConfigList.getItems().size(); dCnt++) {
				        	tempAppStr = getConfigList.getItems().get(dCnt).getMetadata().getLabels().get("application");
				        	tempApp = getConfigList.getItems().get(dCnt).getMetadata().getLabels().get("app");

				        	if(meta.getName().equals(tempAppStr) || meta.getName().equals(tempApp)){
				        		configsCnt ++;
				        	}
				        }
				        res.setServiceCnt(servicesCnt);
				        res.setRoutesCnt(routesCnt);
				        res.setBuildsCnt(buildsCnt);
				        res.setDeploymentConfigCnt(configsCnt);

						this.sqlSessionTemplate.insert(insertOssApp, res);
					}
				}

			}else if( sRequestType.equals(CodeUtil.CMM_CODE_REQTYPE_CHANGE)) { //업데이트
				res = this.sqlSessionTemplate.selectOne(detailBssOrderProductAPP, orderProductSeq);
				res.setOrderUserId(orderUserId);
				res.setErrorStatus("PROVISIONING_SUCCESS");

				int podCount = res.getPodCnt();
//				int cpuLimit = res.getCpuLimit();
//				int memLimit = res.getMemLimit();
				int cpuReq = res.getCpuReq();
				int memReq = res.getMemReq();

				opsApiOptionService.podCountUpdate(cloudVo, res.getProjectName().toLowerCase(), res.getAppName(), podCount);
//				opsApiOptionService.applicationUpdate(cloudVo, res.getProjectName().toLowerCase(), res.getAppName(), podCount, cpuReq, memReq);
				DeploymentConfig deploymentConfig  = opsApiOptionService.getDeploymentConfig(cloudVo,  res.getProjectName().toLowerCase(), res.getAppName());

				res.setAppUid(res.getAppUid());
				res.setPodCnt(podCount);
				res.setVolume(deploymentConfig.getSpec().getTemplate().getSpec().getVolumes().size());

				this.sqlSessionTemplate.update(updateOssApp, res);

			}else if( sRequestType.equals(CodeUtil.CMM_CODE_REQTYPE_EXPR)) {
				res = this.sqlSessionTemplate.selectOne(detailBssOrderProductAPP, orderProductSeq);
				res.setOrderUserId(orderUserId);
				res.setErrorStatus("PROVISIONING_SUCCESS");

				opsApiOptionService.templateDelete(cloudVo, res.getProjectName(), res.getAppName());
				this.sqlSessionTemplate.delete(deleteOssApp, res);
			}

		}

		return res;
	}

	private CustomReqProductVO productByEnv(String orderProductSeq, String sProduct, String sRequestType,
			String orderUserId, CustomOssCloudVO cloudVo) {

		CustomReqProductVO res = new CustomReqProductVO();
		SystemCalculatorInfo systemCalculatorInfo = new SystemCalculatorInfo();

		res.setCloudId(cloudVo.getCloudId());

		// 신규 요청 처리
		if (sRequestType.equals(CodeUtil.CMM_CODE_REQTYPE_NEW)) {

			res = this.sqlSessionTemplate.selectOne(detailBssOrderProductEnv, orderProductSeq);
			List<CustomReqProductVO> envUserList = this.sqlSessionTemplate.selectList(detailBssOrderProductEnvUserList, orderProductSeq);

			try {
				// 1. 그룹 생성 및 ID 조회
				GitlabObject groupInfo = GitlabUtils.createGroup(systemCalculatorInfo, res.getEnvGroupName(), res.getEnvGroupUrl());
				String groupId = groupInfo.getValue("id").toString();
//				String groupId = "451";

				// 그룹 정보 저장
				CustomReqProductVO groupInfoVO = new CustomReqProductVO();

				groupInfoVO.setGroupId(groupId);
				groupInfoVO.setName(groupInfo.getValue("name").toString());
				groupInfoVO.setWebUrl(groupInfo.getValue("web_url").toString());
				groupInfoVO.setPath(groupInfo.getValue("path").toString());
				groupInfoVO.setVisibility(groupInfo.getValue("visibility").toString());

				groupInfoVO.setRegUserId(orderUserId);
				this.sqlSessionTemplate.insert(insertCicdGroup, groupInfoVO);

				// 2. 프로젝트 생성 및 ID 조회
				GitlabObject projectInfo = GitlabUtils.createProject(systemCalculatorInfo, res.getEnvName(), groupId);
				String projectId = projectInfo.getValue("id").toString();
//				String projectId = "137";

				// 프로젝트 정보 저장
				CustomReqProductVO projectInfoVO = new CustomReqProductVO();
				projectInfoVO.setCicdProjectId(projectId);
				projectInfoVO.setGroupId(groupId);
				projectInfoVO.setName(res.getEnvName());

//				projectInfoVO.setUrl("https://gitlabsvr.kepco.co.kr/" + groupId + "/" + res.getEnvName());
				projectInfoVO.setUrl("https://gitlabsvr.kepco.co.kr/" + groupInfo.getValue("path").toString() + "/" + res.getEnvName());
				projectInfoVO.setVisibility("private");
				projectInfoVO.setDescription("Project for " + res.getEnvName());
				projectInfoVO.setOrderProductSeq(orderProductSeq);
				projectInfoVO.setProjectBoxId(res.getProjectBoxId());
				projectInfoVO.setRegUserId(orderUserId);
				this.sqlSessionTemplate.insert(insertCicdProject, projectInfoVO);

				// 3. 브랜치 생성 및 YAML 파일 업로드
				String[] branches = { "develop","main","staging"};
				for (String branchName : branches) {

					if (!branchName.equals("main")) {
						GitlabUtils.createBranch(systemCalculatorInfo, projectId, branchName, "main");
					}

					// 브랜치 정보 저장
					CustomReqProductVO branchInfoVO = new CustomReqProductVO();
					branchInfoVO.setBranchId(branchName);
					branchInfoVO.setCicdProjectId(projectId);
					branchInfoVO.setName(branchName);
					branchInfoVO.setTemplateId(branchName.equals("main") ? "1" : null); // main 브랜치에만 템플릿 ID 설정
					branchInfoVO.setRegUserId(orderUserId);
					branchInfoVO.setModUserId(orderUserId);
					this.sqlSessionTemplate.insert(insertCicdBranch, branchInfoVO);

					// main 브랜치 생성 시, YAML 템플릿 파일을 GitLab에 업로드
					if (branchName.equals("main")) {

						List <CustomReqProductVO> configTemplateInfoList  = this.sqlSessionTemplate.selectList(getConfigTemplateList);

						for(CustomReqProductVO vo : configTemplateInfoList) {
							String yamlContent =  vo.getContent();
							GitlabUtils.insertGitlabCIPipelineFile(systemCalculatorInfo, projectId, "main", yamlContent, "Update " + vo.getTemplateName() + "file via API", vo.getTemplateName());
						}
					}
				}

				List<CustomReqProductVO> accessLevelMaintainerList = envUserList.stream()
						.filter(envUser -> envUser.getEnvAccessLevel().equals("40"))
						.collect(Collectors.toList());

				List<CustomReqProductVO> accessLevelDeveloperList = envUserList.stream()
						.filter(envUser -> envUser.getEnvAccessLevel().equals("30"))
						.collect(Collectors.toList());

				// 4. Maintainer 사용자 생성 및 PAT 발급
				for (CustomReqProductVO envUser : accessLevelMaintainerList) {

					String userEmail =	 envUser.getEnvUserEmailDec();
					String userPassword = envUser.getEnvUserPasswordDec();
					String userName = envUser.getEnvUserName();
					String userId = null;

					String checkUserId = null;
					String checkUserName = null;
					String checkUserEmail = null;

					GitlabObject userInfo =  GitlabUtils.getUsers(systemCalculatorInfo, userEmail, envUser.getEnvUserId());

                    if(userInfo.getJsonArray().size() == 0) {

                    	GitlabObject createUserInfo = GitlabUtils.createUser(systemCalculatorInfo, envUser.getEnvUserId(), envUser.getEnvUserName(), userEmail, userPassword);
                    	userId = createUserInfo.getValue("id").toString();
    					envUser.setUserId(userId);

    					// 사용자 정보 저장
    					CustomReqProductVO userInfoVO = new CustomReqProductVO();
    					userInfoVO.setUserId(userId);
    					userInfoVO.setUserEmail(envUser.getEnvUserEmail());
    					userInfoVO.setName(envUser.getEnvUserId());
    					userInfoVO.setAlias(envUser.getEnvUserName());
    					userInfoVO.setPassword(envUser.getEnvUserPassword());
    					userInfoVO.setRegUserId(orderUserId);
    					userInfoVO.setModUserId(orderUserId);
    					this.sqlSessionTemplate.insert("insertCicdUser", userInfoVO);
                    }else {

                    	for(JsonElement jsonElement : userInfo.getJsonArray()) {
                    		checkUserId = jsonElement.getAsJsonObject().get("id").toString();
                    		checkUserName = jsonElement.getAsJsonObject().get("name").toString().replaceAll("\"", "");
                    		checkUserEmail = jsonElement.getAsJsonObject().get("email").toString().replaceAll("\"", "");

	                    	if (checkUserName.equals(userName) && checkUserEmail.equals(userEmail)) {
		                    	userId = checkUserId;
	                    	}
                    	}
                    }

					// 사용자에 Personal Access Token 발급
					GitlabObject tokenInfo = GitlabUtils.createPersonalAccessToken(systemCalculatorInfo, userId, "MT_USER_TOKEN_NAME");
					String userToken = tokenInfo.getValue("token").toString();
					envUser.setToken(userToken);

					// 프로젝트에 Maintainer 역할로 사용자 추가
					GitlabUtils.addUserToProject(systemCalculatorInfo, projectId, userId, envUser.getEnvAccessLevel());

					// 사용자 토큰 정보 저장
					CustomReqProductVO projectUserInfoVO = new CustomReqProductVO();
					projectUserInfoVO.setCicdProjectId(projectId);

					projectUserInfoVO.setCicdUserId(userId);

					projectUserInfoVO.setUserEmail(envUser.getEnvUserEmail());
					projectUserInfoVO.setToken(userToken);
					projectUserInfoVO.setAccessLevel(envUser.getEnvAccessLevel());
					projectUserInfoVO.setRegUserId(orderUserId);
					this.sqlSessionTemplate.insert("insertCicdProjectUser", projectUserInfoVO);
				}

				// 5. Developer 역할로 일반 사용자 추가
				for (CustomReqProductVO envUser : accessLevelDeveloperList) {

					String userEmail =	 envUser.getEnvUserEmailDec();
					String userPassword = envUser.getEnvUserPasswordDec();
					String userName = envUser.getEnvUserName();
					String userId = null;
					String checkUserId = null;
					String checkUserName = null;
					String checkUserEmail = null;


					GitlabObject userInfo =  GitlabUtils.getUsers(systemCalculatorInfo, userEmail, envUser.getEnvUserId());

                    if(userInfo.getJsonArray().size() == 0) {
                    	GitlabObject createUserInfo = GitlabUtils.createUser(systemCalculatorInfo, envUser.getEnvUserId(), envUser.getEnvUserName(), userEmail, userPassword);
                    	userId = createUserInfo.getValue("id").toString();
    					envUser.setUserId(userId);
				     }else {
				    		for(JsonElement jsonElement : userInfo.getJsonArray()) {
	                    		checkUserId = jsonElement.getAsJsonObject().get("id").toString();
	                    		checkUserName = jsonElement.getAsJsonObject().get("name").toString().replaceAll("\"", "");
	                    		checkUserEmail = jsonElement.getAsJsonObject().get("email").toString().replaceAll("\"", "");

		                    	if (checkUserName.equals(userName) && checkUserEmail.equals(userEmail)) {
			                    	userId = checkUserId;
		                    	}
	                    	}
                    }

					// 사용자 정보 저장
					CustomReqProductVO userInfoVO = new CustomReqProductVO();
					userInfoVO.setUserId(userId);
					userInfoVO.setUserEmail(envUser.getEnvUserEmail());
					userInfoVO.setName(envUser.getEnvUserId());
					userInfoVO.setAlias(envUser.getEnvUserName());
					userInfoVO.setPassword(envUser.getEnvUserPassword());
					userInfoVO.setRegUserId(orderUserId);
					this.sqlSessionTemplate.insert("insertCicdUser", userInfoVO);

					GitlabUtils.addUserToProject(systemCalculatorInfo, projectId, envUser.getUserId(), envUser.getEnvAccessLevel());

					// 일반 사용자 정보 저장
					CustomReqProductVO projectUserInfoVO = new CustomReqProductVO();
					projectUserInfoVO.setCicdProjectId(projectId);
					projectUserInfoVO.setCicdUserId(userId);
					projectUserInfoVO.setUserEmail(envUser.getEnvUserEmail());
					projectUserInfoVO.setAccessLevel(envUser.getEnvAccessLevel());

					projectUserInfoVO.setRegUserId(orderUserId);
					this.sqlSessionTemplate.insert("insertCicdProjectUser", projectUserInfoVO);
				}
				res.setOrderUserId(orderUserId);

		        // environment 생성(prod)
				String environmentStatus = "";
				try {
					GitlabObject environmentInfo = GitlabUtils.createProdEnvironment(systemCalculatorInfo, projectId);
					log.info("state : {}", environmentInfo.getValue("state").toString());
					environmentStatus = environmentInfo.getValue("state").toString();

					projectInfoVO.setEnvironmentStatus(environmentStatus);
					this.sqlSessionTemplate.update("updateCicdProjectEnvironmentStatus", projectInfoVO);

				}catch (Exception e) {
					e.printStackTrace();
					res.setErrorStatus("PROVISIONING_FAIL");
				}

		        // Protected environment 설정
				try {
					// Protected environment CMP 에서는 따로 관리하거나 하지 않음.
					GitlabUtils.protectedEnvironmentConfig(systemCalculatorInfo, projectId);
				} catch (Exception e) {
					e.printStackTrace();
					res.setErrorStatus("PROVISIONING_FAIL");
				}
				res.setErrorStatus("PROVISIONING_SUCCESS");

			} catch (Exception e) {
				e.printStackTrace();
				res.setErrorStatus("PROVISIONING_FAIL");
			}
			// 개발 배포
		} else if (sRequestType.equals(CodeUtil.CMM_CODE_REQTYPE_DEV)) {

			res = this.sqlSessionTemplate.selectOne(detailBssOrderProductAPP, orderProductSeq);

			CustomReqProductVO gourpProjectInfo = this.sqlSessionTemplate.selectOne(cicdGourpProjectInfo, res.getCicdProjectId());
			CustomReqProductVO projectUserInfo = this.sqlSessionTemplate.selectOne(cicdProjectUserInfo, res.getCicdProjectId());

			String appVersion = res.getAppVersion();
			String tagName = "";
			int versionNum = 0;

			if(!appVersion.equals("") && appVersion != null) {
				versionNum = Integer.parseInt(appVersion.replaceAll("[^\\d]","")) ;
			}else {
				versionNum = CodeUtil.CICD_REQTYPE_NEW_VERSION;
			}

			if(versionNum != CodeUtil.CICD_REQTYPE_NEW_VERSION) {
				versionNum = versionNum - CodeUtil.CICD_REQTYPE_NEW_VERSION;
			}
			log.info("version Info {}", "stage." + res.getAppName() + ".v" + versionNum);
			tagName = "stage." + res.getAppName() + ".v" + versionNum;

			// 개발 배포 처리
			try {

				GitlabObject tag = null;
				try {
					tag = GitlabUtils.selectTag(systemCalculatorInfo, res.getCicdProjectId(), tagName);
				} catch (Exception e) {
					e.printStackTrace();
					res.setErrorStatus("PROVISIONING_FAIL");
				}

                if(tag !=null) {
                	GitlabUtils.deleteTag(systemCalculatorInfo, res.getCicdProjectId(), tagName);
                	// 삭제한 태그 정보 데이터베이스에서도 삭제
                	CustomReqProductVO deleteTagInfo = new CustomReqProductVO();
                	deleteTagInfo.setBranchTagId(tagName);
                	deleteTagInfo.setCicdProjectId(res.getCicdProjectId());
                	this.sqlSessionTemplate.delete(deleteCicdBranchTag, deleteTagInfo);
                }

				//새로운 스테이징 브랜치 태그 생성
				GitlabUtils.createTag(systemCalculatorInfo, res.getCicdProjectId(), "stage." + res.getAppName() + "." + res.getAppVersion(), "staging",	"Batch Release version");

				// 생성된 태그 정보 데이터베이스에 삽입
				CustomReqProductVO insertTagInfo = new CustomReqProductVO();
				insertTagInfo.setBranchTagId("stage." + res.getAppName() + "." + res.getAppVersion());
				insertTagInfo.setBranchName("staging");
				insertTagInfo.setCicdProjectId(res.getCicdProjectId());
				insertTagInfo.setProjectId(res.getProjectId());
				insertTagInfo.setAppName(res.getAppName());

				insertTagInfo.setName("stage." + res.getAppName()+ "." + res.getAppVersion());
				insertTagInfo.setRegUserId(orderUserId);
				insertTagInfo.setModUserId(orderUserId);
				this.sqlSessionTemplate.insert(insertCicdBranchTag, insertTagInfo);


				// 3. 스테이징 파이프라인 트리거
				Map<String, String> variables = new HashMap<>();
				variables.put("DEPLOY_TARGET_NAME", "staging");
				variables.put("GL_USER_NAME", projectUserInfo.getName());
				variables.put("GL_PASSWORD", projectUserInfo.getPasswordDec());
				variables.put("OPENSHIFT_SERVER", "https://api.oaocp4.kepco.co.kr:6443");
				variables.put("OPENSHIFT_USERNAME", cloudVo.getAdminUsername());
				variables.put("OPENSHIFT_PASSWORD", cloudVo.getAdminPassword());
				variables.put("OPENSHIFT_TEMPLATE", res.getImageId());

				variables.put("SOURCE_REPOSITORY_URL", "https://gitlabsvr.kepco.co.kr/"+gourpProjectInfo.getCicdGroupPath()+"/"+gourpProjectInfo.getCicdProjectName()+".git");
				variables.put("CONTEXT_DIR", res.getDeploysDirectory());

				variables.put("ENV_PROJECT", res.getProjectName()+"-dev"); // 오픈 쉬프트 프로젝트 ID
				variables.put("ENV_APPLICATION_NAME", res.getAppName());
				variables.put("ENV_APPLICATION_VERSION", res.getAppVersion());
				variables.put("ENV_NUMBER_OF_INSTANCES", res.getPodCnt() + "");
				variables.put("ENV_URL_OF_APPLICATION", res.getDomainUrl());
				variables.put("ENV_SOURCE_REPOSITORY_URL", "https://gitlabsvr.kepco.co.kr/"+gourpProjectInfo.getCicdGroupPath()+"/"+gourpProjectInfo.getCicdProjectName()+".git");
				variables.put("ENV_SOURCE_REPOSITORY_REF", "staging");
				variables.put("ENV_CONTEXT_DIR",res.getDeploysDirectory());
				variables.put("ENV_CPU_LIMIT", Integer.toString(res.getCpuLimit()));
				variables.put("ENV_MEMORY_LIMIT", res.getMemLimit()+"Gi");

				GitlabObject pipeline = GitlabUtils.triggerPipeline(systemCalculatorInfo, res.getCicdProjectId(), "stage." + res.getAppName() + "." + res.getAppVersion(), variables);
				String pipelineId = pipeline.getValue("id").toString();

				String status;

				int timeCnt = 0;
				while (true) {
					GitlabObject pipelineResult = GitlabUtils.getPipelineResult(systemCalculatorInfo, res.getCicdProjectId(), pipelineId);
					status = pipelineResult.getValue("status").toString();
					if ("success".equals(status) || "failed".equals(status)) {
						break;
					}

					if(timeCnt == 36) { // 3분 FAIL 처리
						res.setErrorStatus("PROVISIONING_FAIL");
						return res;
					}

					Thread.sleep(5000);
					timeCnt++;
				}

				// 파이프라인 정보 데이터베이스에 저장
				CustomReqProductVO pipelineInfoVO = new CustomReqProductVO();
				pipelineInfoVO.setPipelineId(pipelineId);
				pipelineInfoVO.setCicdProjectId(res.getCicdProjectId());
				pipelineInfoVO.setProjectId(res.getProjectId());
				pipelineInfoVO.setStatus(status);
				pipelineInfoVO.setRef("stage." + res.getAppName() + "." + res.getAppVersion());
				pipelineInfoVO.setAppName(res.getAppName());

				if(res.getCicdRequestType().equals("") || res.getCicdRequestType() == null) {
					pipelineInfoVO.setCicdRequestType("CICD_REQTYPE_NEW_DEPLOY");
				}else {
					pipelineInfoVO.setCicdRequestType(res.getCicdRequestType());
				}
				pipelineInfoVO.setSyncAppStatus("SYNC_APP_READY");
				pipelineInfoVO.setOrderProductSeq(orderProductSeq);

				pipelineInfoVO.setRegUserId(orderUserId);
				pipelineInfoVO.setEnvApplicationVersion(res.getAppVersion());

				this.sqlSessionTemplate.insert(insertCicdPipeline, pipelineInfoVO);

				GitlabObject jobResult = GitlabUtils.getJobs(systemCalculatorInfo, res.getCicdProjectId(), pipelineId);

		        for(JsonElement jsonElement : jobResult.getJsonArray()) {
		            String resProjectId = jsonElement.getAsJsonObject().getAsJsonObject("pipeline").get("project_id").toString();
		            String resPipelineId = jsonElement.getAsJsonObject().getAsJsonObject("pipeline").get("id").toString();
		            String jobName = jsonElement.getAsJsonObject().get("name").toString().replaceAll("\"", "");

		            if(resProjectId.equals(res.getCicdProjectId()) && resPipelineId.equals(pipelineId)) {

		            	if(jobName.equals(CodeUtil.CICD_PIPELINE_JOB_STATUS_STAGE)){

		            		CustomReqProductVO reqVO = new CustomReqProductVO();
		            		reqVO.setPipelineId(resPipelineId);
		            		reqVO.setJobId(jsonElement.getAsJsonObject().get("id").toString());
		            		reqVO.setStatus(jsonElement.getAsJsonObject().get("status").toString().replaceAll("\"", ""));
		            		reqVO.setJobName(jobName);
		            		reqVO.setRef(jsonElement.getAsJsonObject().get("ref").toString().replaceAll("\"", ""));
		            		sqlSessionTemplate.insert(insertCicdJob, reqVO);
		            	}
		            }
		        }

				res.setOrderUserId(orderUserId);
				res.setErrorStatus("PROVISIONING_SUCCESS");

			} catch (Exception e) {
				e.printStackTrace();
				res.setErrorStatus("PROVISIONING_FAIL");
			}

		} else if (sRequestType.equals(CodeUtil.CMM_CODE_REQTYPE_PROD)) {

			// 운영 배포 처리
			try {

				res = this.sqlSessionTemplate.selectOne(detailBssOrderProductAPP, orderProductSeq);

				CustomReqProductVO gourpProjectInfo = this.sqlSessionTemplate.selectOne(cicdGourpProjectInfo, res.getCicdProjectId());
				CustomReqProductVO projectUserInfo = this.sqlSessionTemplate.selectOne(cicdProjectUserInfo, res.getCicdProjectId());
				GitlabObject tag = null;

				String appVersion = res.getAppVersion();
				String tagName = "";
				int versionNum = 0;

				versionNum = Integer.parseInt(appVersion.replaceAll("[^\\d]","")) ;
				if(versionNum != CodeUtil.CICD_REQTYPE_NEW_VERSION) {
					versionNum = versionNum - CodeUtil.CICD_REQTYPE_NEW_VERSION;
				}

				log.info("version Info {}", "copy." + res.getAppName() + ".v" + versionNum);
				tagName = "copy." + res.getAppName() + ".v" + versionNum;

				try {
					 tag = GitlabUtils.selectTag(systemCalculatorInfo, res.getCicdProjectId(), tagName);
				} catch (Exception e) {

				}

                if(tag !=null) {
                	GitlabUtils.deleteTag(systemCalculatorInfo, res.getCicdProjectId(), tagName);
                	// 삭제한 태그 정보 데이터베이스에서도 삭제
                	CustomReqProductVO deleteTagInfo = new CustomReqProductVO();
                	deleteTagInfo.setBranchTagId(tagName);
                	deleteTagInfo.setCicdProjectId(res.getCicdProjectId());
                	this.sqlSessionTemplate.delete(deleteCicdBranchTag, deleteTagInfo);
                }

                // cicd project maintainer 계정으로 tag 생성
                String copyTagName = "copy." + res.getAppName()+ "." + res.getAppVersion();
                GitlabUtils.createTag(systemCalculatorInfo, res.getCicdProjectId(), copyTagName, "main",	"Batch Release version", projectUserInfo);

                // 스테이징 브랜치를 메인 브랜치로 복사 copy pipeline 수행
				Map<String, String> copyVariables = new HashMap<>();

				copyVariables.put("DEPLOY_TARGET_NAME", "copy");
				copyVariables.put("GL_USER_NAME", projectUserInfo.getName());
				copyVariables.put("GL_PASSWORD", projectUserInfo.getPasswordDec());
				copyVariables.put("GL_PAT", projectUserInfo.getToken());

				copyVariables.put("GL_GRPNAME", gourpProjectInfo.getCicdGroupPath());
				copyVariables.put("GL_REPONAME", gourpProjectInfo.getCicdProjectName());
				copyVariables.put("GL_SERVER", "gitlabsvr.kepco.co.kr");

                // cicd project maintainer 계정으로 pipeline trigger 실행
				GitlabObject copyPipeline = GitlabUtils.triggerPipeline(systemCalculatorInfo, res.getCicdProjectId(), copyTagName, copyVariables, projectUserInfo);
				String copyPipelineId = copyPipeline.getValue("id").toString();

				String status;
				int timeCnt = 0;
				while (true) {
					GitlabObject pipelineResult = GitlabUtils.getPipelineResult(systemCalculatorInfo, res.getCicdProjectId(), copyPipelineId);
					status = pipelineResult.getValue("status").toString();
					if("manual".equals(status)) {
						break;
					}

					if(timeCnt == 36) { // 3분 FAIL 처리
						res.setErrorStatus("PROVISIONING_FAIL");
						return res;
					}

					Thread.sleep(5000);
					timeCnt++;
				}

				// 파이프라인 정보 데이터베이스에 저장
				CustomReqProductVO copyPipelineInfoVO = new CustomReqProductVO();
				copyPipelineInfoVO.setPipelineId(copyPipelineId);
				copyPipelineInfoVO.setCicdProjectId(res.getCicdProjectId());
				copyPipelineInfoVO.setProjectId(res.getProjectId());
				copyPipelineInfoVO.setStatus(status);
				copyPipelineInfoVO.setRef(copyTagName);
				copyPipelineInfoVO.setAppName(res.getAppName());
				copyPipelineInfoVO.setCicdRequestType("CICD_REQTYPE_COPY");
				copyPipelineInfoVO.setSyncAppStatus("SYNC_APP_SKIP");
				copyPipelineInfoVO.setOrderProductSeq(orderProductSeq);

				copyPipelineInfoVO.setRegUserId(orderUserId);
				copyPipelineInfoVO.setEnvApplicationVersion(res.getAppVersion());

				this.sqlSessionTemplate.insert(insertCicdPipeline, copyPipelineInfoVO);

		        // 승인 대기중인 Deployment 확인
				GitlabObject deploymentChk = GitlabUtils.waitingDeploymentCheck(systemCalculatorInfo, res.getCicdProjectId());
				String deploymentId = "";
				status = "";
				timeCnt = 0;
				for(JsonElement jsonElement : deploymentChk.getJsonArray()) {
					String deploymentStatus = jsonElement.getAsJsonObject().get("status").toString().replaceAll("\"", "");
					String deploymentResPipelinId = jsonElement.getAsJsonObject().getAsJsonObject("deployable").getAsJsonObject("pipeline").get("id").toString();
					deploymentId = jsonElement.getAsJsonObject().get("id").toString();

			        // 승인 대기중인 Deployment 승인
					if(deploymentStatus.equals("blocked") && deploymentResPipelinId.equals(copyPipelineId)) {
						GitlabObject deploymentRes = GitlabUtils.waitingDeploymentStart(systemCalculatorInfo, res.getCicdProjectId(), deploymentId);
						String resStatus = deploymentRes.getValue("status").toString();
					}
				}

				String manualJobId = "";
				timeCnt = 0;
				while (true) {

					// 승인된 deployment 에서 manual 상태인 job id 조회
					GitlabObject manualStatusList = GitlabUtils.getManualStatusList(systemCalculatorInfo, res.getCicdProjectId(), deploymentId);

					manualJobId = manualStatusList.getObject("deployable").getValue("id").toString();
					String manualStatus = manualStatusList.getObject("deployable").getValue("status").toString();

					if ("manual".equals(manualStatus)) {
						break;
					}

					if(timeCnt == 36) { // 3분 FAIL 처리
						res.setErrorStatus("PROVISIONING_FAIL");
						return res;
					}
					Thread.sleep(5000);
					timeCnt++;
				}

				// manualRes
				GitlabObject manualRes = GitlabUtils.manualStatusJobStart(systemCalculatorInfo, res.getCicdProjectId(), manualJobId);

				status = "";
				timeCnt = 0;
				while (true) {
					GitlabObject pipelineResult = GitlabUtils.getPipelineResult(systemCalculatorInfo, res.getCicdProjectId(), copyPipelineId);
					status = pipelineResult.getValue("status").toString();

					if ("success".equals(status) || "failed".equals(status)) {
						break;
					}

					if(timeCnt == 36) { // 3분 FAIL 처리
						res.setErrorStatus("PROVISIONING_FAIL");
						return res;
					}

					Thread.sleep(5000);
					timeCnt++;
				}

				// copy pipeline, deployment 에서 manual 상태인 job id 조회 / 실행 결과 조회
				GitlabObject jobResult = GitlabUtils.getJobs(systemCalculatorInfo, res.getCicdProjectId(), copyPipelineId);

		        for(JsonElement jsonElement : jobResult.getJsonArray()) {
		            String resProjectId = jsonElement.getAsJsonObject().getAsJsonObject("pipeline").get("project_id").toString();
		            String resPipelineId = jsonElement.getAsJsonObject().getAsJsonObject("pipeline").get("id").toString();
		            String jobName = jsonElement.getAsJsonObject().get("name").toString().replaceAll("\"", "");

		            if(resProjectId.equals(res.getCicdProjectId()) && resPipelineId.equals(copyPipelineId)) {

		            	if(jobName.equals(CodeUtil.CICD_PIPELINE_JOB_STATUS_COPY)){

		            		CustomReqProductVO reqVO = new CustomReqProductVO();
		            		reqVO.setPipelineId(resPipelineId);
		            		reqVO.setJobId(jsonElement.getAsJsonObject().get("id").toString());
		            		reqVO.setStatus(jsonElement.getAsJsonObject().get("status").toString().replaceAll("\"", ""));
		            		reqVO.setJobName(jobName);
		            		reqVO.setRef(jsonElement.getAsJsonObject().get("ref").toString().replaceAll("\"", ""));
		            		sqlSessionTemplate.insert(insertCicdJob, reqVO);
		            	}
		            }
		        }

		        // getPipelineResult 결과가 file 이면 JOB 은 저장하고  FAIL 처리
		        if("failed".equals(status)) {
					res.setErrorMsg("manualStatusJobStart failed");
					res.setErrorStatus("PROVISIONING_FAIL");
					return res;
				}

		        // 운영 배포
				log.info("version Info {}", "prod." + res.getAppName() + ".v" + versionNum);
				tagName = "prod." + res.getAppName() + ".v" + versionNum;

				GitlabObject prodTag = null;
				try {
					prodTag = GitlabUtils.selectTag(systemCalculatorInfo, res.getCicdProjectId(), tagName);
				} catch (Exception e) {

				}

                if(prodTag !=null) {
                	GitlabUtils.deleteTag(systemCalculatorInfo, res.getCicdProjectId(), tagName);
                	// 삭제한 태그 정보 데이터베이스에서도 삭제
                	CustomReqProductVO deleteTagInfo = new CustomReqProductVO();
                	deleteTagInfo.setBranchTagId(tagName);
                	deleteTagInfo.setCicdProjectId(res.getCicdProjectId());
                	this.sqlSessionTemplate.delete(deleteCicdBranchTag, deleteTagInfo);
                }

                // cicd project maintainer 계정으로 tag 생성
                String prodTagName = "prod." + res.getAppName() + "." + res.getAppVersion();
                GitlabUtils.createTag(systemCalculatorInfo, res.getCicdProjectId(), prodTagName, "main",	"Batch Release version", projectUserInfo);

				// 생성된 태그 정보 데이터베이스에 삽입
				CustomReqProductVO insertTagInfo = new CustomReqProductVO();
				insertTagInfo.setBranchTagId("prod." + res.getAppName()+ "." + res.getAppVersion());
				insertTagInfo.setBranchName("main");
				insertTagInfo.setCicdProjectId(res.getCicdProjectId());
				insertTagInfo.setProjectId(res.getProjectId());
				insertTagInfo.setName("prod." + res.getAppName()+ "." + res.getAppVersion());
				insertTagInfo.setRegUserId(orderUserId);
				insertTagInfo.setModUserId(orderUserId);
				this.sqlSessionTemplate.insert("insertCicdBranchTag", insertTagInfo);

				// 3. 스테이징 파이프라인 트리거
				Map<String, String> variables = new HashMap<>();
				variables.put("DEPLOY_TARGET_NAME", "production");

				variables.put("GL_USER_NAME", projectUserInfo.getName());
				variables.put("GL_PASSWORD", projectUserInfo.getPasswordDec());

				variables.put("OPENSHIFT_SERVER", "https://api.oaocp4.kepco.co.kr:6443");
				variables.put("OPENSHIFT_USERNAME", cloudVo.getAdminUsername());
				variables.put("OPENSHIFT_PASSWORD", cloudVo.getAdminPassword());
				variables.put("OPENSHIFT_TEMPLATE", res.getImageId());
				variables.put("SOURCE_REPOSITORY_URL", "https://gitlabsvr.kepco.co.kr/"+gourpProjectInfo.getCicdGroupPath()+"/"+gourpProjectInfo.getCicdProjectName()+".git");
				variables.put("CONTEXT_DIR", res.getDeploysDirectory());

				variables.put("ENV_PROJECT", res.getProjectName()+"-prod"); // 오픈 쉬프트 프로젝트 ID
				variables.put("ENV_APPLICATION_NAME", res.getAppName());
				variables.put("ENV_APPLICATION_VERSION", res.getAppVersion());
				variables.put("ENV_NUMBER_OF_INSTANCES", res.getPodCnt() + "");
				variables.put("ENV_URL_OF_APPLICATION", res.getDomainUrl());
				variables.put("ENV_SOURCE_REPOSITORY_URL", "https://gitlabsvr.kepco.co.kr/"+gourpProjectInfo.getCicdGroupPath()+"/"+gourpProjectInfo.getCicdProjectName()+".git");
				variables.put("ENV_SOURCE_REPOSITORY_REF", "main");
				variables.put("ENV_CONTEXT_DIR", res.getDeploysDirectory());
				variables.put("ENV_CPU_LIMIT", Integer.toString(res.getCpuLimit()));
				variables.put("ENV_MEMORY_LIMIT", res.getMemLimit()+"Gi");

				GitlabObject pipeline = GitlabUtils.triggerPipeline(systemCalculatorInfo, res.getCicdProjectId(), prodTagName, variables, projectUserInfo);
				String pipelineId = pipeline.getValue("id").toString();

				status = "";
				timeCnt = 0;
				while (true) {
					GitlabObject pipelineResult = GitlabUtils.getPipelineResult(systemCalculatorInfo, res.getCicdProjectId(), pipelineId);
					status = pipelineResult.getValue("status").toString();
					if("manual".equals(status)) {
						break;
					}

					if(timeCnt == 36) { // 3분 FAIL 처리
						res.setErrorStatus("PROVISIONING_FAIL");
						return res;
					}

					Thread.sleep(5000);
					timeCnt++;
				}

				// 파이프라인 정보 데이터베이스에 저장
				CustomReqProductVO pipelineInfoVO = new CustomReqProductVO();
				pipelineInfoVO.setPipelineId(pipelineId);
				pipelineInfoVO.setCicdProjectId(res.getCicdProjectId());
				pipelineInfoVO.setProjectId(res.getProjectId());
				pipelineInfoVO.setStatus(status);
				pipelineInfoVO.setRef(prodTagName);
				pipelineInfoVO.setAppName(res.getAppName());

				if(res.getCicdRequestType().equals("") || res.getCicdRequestType() == null) {
					pipelineInfoVO.setCicdRequestType("CICD_REQTYPE_NEW_DEPLOY");
				}else {
					pipelineInfoVO.setCicdRequestType(res.getCicdRequestType());
				}

//				pipelineInfoVO.setCicdRequestType("CICD_REQTYPE_NEW_DEPLOY");
				pipelineInfoVO.setSyncAppStatus("SYNC_APP_READY");
				pipelineInfoVO.setRegUserId(orderUserId);
				pipelineInfoVO.setOrderProductSeq(orderProductSeq);
				pipelineInfoVO.setEnvApplicationVersion(res.getAppVersion());
				this.sqlSessionTemplate.insert("insertCicdPipeline", pipelineInfoVO);

		        // 승인 대기중인 Deployment 확인
				deploymentChk = GitlabUtils.waitingDeploymentCheck(systemCalculatorInfo, res.getCicdProjectId());
				deploymentId = "";
				status = "";
				timeCnt = 0;
				for(JsonElement jsonElement : deploymentChk.getJsonArray()) {
					String deploymentStatus = jsonElement.getAsJsonObject().get("status").toString().replaceAll("\"", "");
					String deploymentResPipelinId = jsonElement.getAsJsonObject().getAsJsonObject("deployable").getAsJsonObject("pipeline").get("id").toString();
					deploymentId = jsonElement.getAsJsonObject().get("id").toString();

			        // 승인 대기중인 Deployment 승인
					if(deploymentStatus.equals("blocked") && deploymentResPipelinId.equals(pipelineId)) {

						GitlabObject deploymentRes = GitlabUtils.waitingDeploymentStart(systemCalculatorInfo, res.getCicdProjectId(), deploymentId);
						String resStatus = deploymentRes.getValue("status").toString();
					}
				}

				manualJobId = "";
				timeCnt = 0;
				while (true) {

					// 승인된 deployment 에서 manual 상태인 job id 조회
					GitlabObject manualStatusList = GitlabUtils.getManualStatusList(systemCalculatorInfo, res.getCicdProjectId(), deploymentId);

					manualJobId = manualStatusList.getObject("deployable").getValue("id").toString();
					String manualStatus = manualStatusList.getObject("deployable").getValue("status").toString();

					if ("manual".equals(manualStatus)) {
						break;
					}

					if(timeCnt == 36) { // 3분 FAIL 처리
						res.setErrorStatus("PROVISIONING_FAIL");
						return res;
					}
					Thread.sleep(5000);
					timeCnt++;
				}

				manualRes = null;
				manualRes = GitlabUtils.manualStatusJobStart(systemCalculatorInfo, res.getCicdProjectId(), manualJobId);

				status = "";
				timeCnt = 0;
				while (true) {
					GitlabObject pipelineResult = GitlabUtils.getPipelineResult(systemCalculatorInfo, res.getCicdProjectId(), pipelineId);
					status = pipelineResult.getValue("status").toString();

					if ("success".equals(status) || "failed".equals(status)) {
						break;
					}

					if(timeCnt == 36) { // 3분 FAIL 처리
						res.setErrorStatus("PROVISIONING_FAIL");
						return res;
					}

					Thread.sleep(5000);
					timeCnt++;
				}

				// main branch pipeline, deployment 에서 manual 상태인 job id 조회 / 실행 결과 조회
				jobResult = GitlabUtils.getJobs(systemCalculatorInfo, res.getCicdProjectId(), pipelineId);

		        for(JsonElement jsonElement : jobResult.getJsonArray()) {
		            String resProjectId = jsonElement.getAsJsonObject().getAsJsonObject("pipeline").get("project_id").toString();
		            String resPipelineId = jsonElement.getAsJsonObject().getAsJsonObject("pipeline").get("id").toString();
		            String jobName = jsonElement.getAsJsonObject().get("name").toString().replaceAll("\"", "");

		            if(resProjectId.equals(res.getCicdProjectId()) && resPipelineId.equals(pipelineId)) {

		            	if(jobName.equals(CodeUtil.CICD_PIPELINE_JOB_STATUS_PORD)) {
		            		log.info("jobName {}", jobName);
		            		CustomReqProductVO reqVO = new CustomReqProductVO();
		            		reqVO.setPipelineId(resPipelineId);
		            		reqVO.setJobId(jsonElement.getAsJsonObject().get("id").toString());
		            		reqVO.setStatus(jsonElement.getAsJsonObject().get("status").toString().replaceAll("\"", ""));
		            		reqVO.setJobName(jobName);
		            		reqVO.setRef(jsonElement.getAsJsonObject().get("ref").toString().replaceAll("\"", ""));
		            		sqlSessionTemplate.insert(insertCicdJob, reqVO);
		            	}
		            }
		        }

				res.setOrderUserId(orderUserId);
				res.setErrorStatus("PROVISIONING_SUCCESS");

			} catch (Exception e) {
				e.printStackTrace();
				res.setErrorStatus("PROVISIONING_FAIL");
			}
		}

		return res;
	}

	private CustomReqProductVO productByNas(String orderProductSeq, String sProduct, String sRequestType,String orderUserId, CustomOssCloudVO cloudVo) throws Exception {

		CustomReqProductVO res = new CustomReqProductVO();

		res.setCloudId(cloudVo.getCloudId());

		log.debug("orderProductSeq=" + orderProductSeq);
		log.debug("sProduct=" + sProduct);

		if (sProduct.equals(CodeUtil.CMM_CODE_PRODCATE_NAS)) {

			res = this.sqlSessionTemplate.selectOne(detailBssOrderProductNas, orderProductSeq);
			res.setOrderUserId(orderUserId);
			res.setErrorStatus("PROVISIONING_SUCCESS");

			if (sRequestType.equals(CodeUtil.CMM_CODE_REQTYPE_NEW)) {

				try {
					SystemCalculatorInfo systemCalculatorInfo = new SystemCalculatorInfo();
					NasObjectVO nasObjectVO = new NasObjectVO();

					nasObjectVO.setVolumeName(res.getNasName());
					nasObjectVO.setMountPath(res.getNasFileSystemPath());
					nasObjectVO.setVolumeSize(res.getNasGb());

					List<CustomReqProductVO> nasOrderVmList = this.sqlSessionTemplate.selectList(detailBssOrderProductNasVm, orderProductSeq);
					String cloudZone = "";

					StringBuilder sb = new StringBuilder();
					int index = 1;
					if (cloudVo.getCloudType().equals("openshift")) {
						sb.append("90.1.1.18,");
						sb.append("90.1.1.19,");
						sb.append("90.1.1.20,");
						sb.append("90.1.1.22,");
						sb.append("90.1.1.23");
					} else {
						for (CustomReqProductVO nasOrderVm : nasOrderVmList) {
							cloudZone = nasOrderVm.getCloudZone();

							sb.append(nasOrderVm.getDefaultNetworkIp());
							nasOrderVm.getDefaultNetworkIp();
							if (index < nasOrderVmList.size()) {
								sb.append(",")	;
							}
							index++;
						}
					}
					String clientIp = sb.toString();
					nasObjectVO.setClientIp(clientIp);

					String policyName = nasObjectVO.getVolumeName() + "_export_policy";
					NasUtils.createExportPolicy(systemCalculatorInfo, policyName, cloudZone);

					NasObject exportPolicyObject = NasUtils.getExportPolicyID(systemCalculatorInfo, policyName, cloudZone);

					String exportPolicyId = "";
					List<NasObject> list = exportPolicyObject.getArray("records", NasType.RESULT);
					for (NasObject record : list) {
						exportPolicyId = record.getValue("id").toString();
					}

					NasUtils.setExportPolicyRule(systemCalculatorInfo, exportPolicyId, clientIp, cloudZone);

					Thread.sleep(2000);

					NasObject createVolume = NasUtils.createVolume(systemCalculatorInfo, nasObjectVO.getVolumeName(), nasObjectVO.getVolumeSize(), policyName, cloudZone);

					String jobUuid = createVolume.getObject("job").getValue("uuid").toString();

					while (true) {
						NasObject jobStatus = NasUtils.checkVolumeCreationJobStatus(systemCalculatorInfo, jobUuid, cloudZone);
						String state = jobStatus.getValue("state").toString();

						if ("success".equals(state)) break;
						if ("failure".equals(state)) break;

						Thread.sleep(2000);
					}

					NasObject getVolume = NasUtils.getVolumeUUID(systemCalculatorInfo, nasObjectVO.getVolumeName(), cloudZone);

					String nasId = "";
					List<NasObject> volume = getVolume.getArray("records", NasType.RESULT);
					for (NasObject record : volume) {
						nasId = record.getValue("uuid").toString();
					}

					nasObjectVO.setNasId(nasId);
					res.setNasId(nasId);
					res.setOrderProductSeq(orderProductSeq);
					res.setRegUserId(orderUserId);
					res.setNasNfsObjectId(exportPolicyId);

					NasUtils.applyMountPath(systemCalculatorInfo, nasObjectVO.getNasId() ,nasObjectVO.getMountPath(), cloudZone);

					if(cloudVo.getCloudType().equals("openshift")) {
						if (CodeUtil.DEV_ENV_TYPE_CODE_ID.equals(res.getEnvType())) {
							res.setProjectName(res.getProjectName() + CodeUtil.CREATE_PAAS_DEV_ENV);
						} else {
							res.setProjectName(res.getProjectName() + CodeUtil.CREATE_PAAS_PORD_ENV);
						}

						PersistentVolume pv = opsApiOptionService.opsCreatePersistentVolume(res, cloudVo);
						PersistentVolumeClaim pvc = opsApiOptionService.opsCreatePersistentVolumeClaim(res, cloudVo);

						res.setPvName(pv.getMetadata().getName());
						res.setPvcName(pvc.getMetadata().getName());
						res.setNasType(CodeUtil.CMM_CODE_PV_NAS_TYPE);
					}else {

						for(CustomReqProductVO nasOrderVm : nasOrderVmList) {
							Port ipObj = setIp(res, cloudVo);
							res.setPortNetworkId(ipObj.getId());

							BatchOssPortVO port = new BatchOssPortVO();
							port.setPortId(ipObj.getId());
							port.setPortName(ipObj.getName());
							port.setFixedIps(ipObj.getFixed_ips().get(0).getIp_address());
							port.setMacAddress(ipObj.getMac_address());
							port.setProjectId(res.getProjectId());
							port.setNetworkId(ipObj.getNetwork_id());
							port.setSubnetId(ipObj.getFixed_ips().get(0).getSubnet_id());
							port.setDeviceOwner(ipObj.getDevice_owner());
							port.setDeviceId(nasOrderVm.getVmUuid());

							insertOssPort(port);

							ServerIF serverIF = AbstractFactory.getServerIF(res.getProjectName(),cloudVo);
							serverIF.attachPortAttachment(port.getDeviceId(), port.getPortId());

							Thread.sleep(5000);

						    AnsibleObject ansibleAddHost = AnsibleUtils.addHost(systemCalculatorInfo, nasOrderVm.getFixedIps(), 3);
						    String hostId = ansibleAddHost.getValue("id").toString();

						    AnsibleObject getJob = AnsibleUtils.nasSetIp(systemCalculatorInfo, port.getMacAddress(), port.getFixedIps());
						    String jobId = getJob.getValue("id").toString();

						    while (true) {
						    	AnsibleObject jobStatus = AnsibleUtils.getStatus(systemCalculatorInfo, jobId);
								String status = jobStatus.getValue("status").toString();

								if ("successful".equals(status)) break;
								if ("failed".equals(status)) break;

								Thread.sleep(2000);
						    }

							AnsibleUtils.deleteHost(systemCalculatorInfo, hostId);
							res.setVmUuid(nasOrderVm.getVmUuid());
							res.setNasType(CodeUtil.CMM_CODE_FS_NAS_TYPE);
							this.sqlSessionTemplate.insert(insertOssNasVm, res);
						}
					}

					this.sqlSessionTemplate.insert(insertOssNas, res);

				} catch (InterruptedException e) {
					log.error(e.getMessage());
					res.setErrorStatus("PROVISIONING_FAIL");
					res.setErrorMsg(e.getMessage());
				} catch (NotConnectGatewayException e) {
					log.error(e.getMessage());
					res.setErrorStatus("PROVISIONING_FAIL");
					res.setErrorMsg(e.getMessage());
				} catch (NotSupportGatewayException e) {
					log.error(e.getMessage());
					res.setErrorStatus("PROVISIONING_FAIL");
					res.setErrorMsg(e.getMessage());
				} catch (InvaildOpenStackException e) {
					log.error(e.getMessage());
					res.setErrorStatus("PROVISIONING_FAIL");
					res.setErrorMsg(e.getMessage());
				} catch (Exception e) {
					log.error(e.getMessage());
					res.setErrorStatus("PROVISIONING_FAIL");
					res.setErrorMsg(e.getMessage());
				}

			}else if(sRequestType.equals(CodeUtil.CMM_CODE_REQTYPE_CHANGE)){

				res.setOrderUserId(orderUserId);
				res.setErrorStatus("PROVISIONING_SUCCESS");

				List<CustomReqProductVO> nasOrderVmList = this.sqlSessionTemplate.selectList(detailBssOrderProductNasVm, orderProductSeq);

				StringBuilder sb = new StringBuilder();
				int index = 1;
				int ansbileTemplate = 3;
				String cloudZone = "";

				for (CustomReqProductVO nasOrderVm : nasOrderVmList) {
					cloudZone = nasOrderVm.getCloudZone();

					sb.append(nasOrderVm.getDefaultNetworkIp());
					nasOrderVm.getDefaultNetworkIp();
					if (index < nasOrderVmList.size()) {
						sb.append(",")	;
					}
					index++;
				}

				SystemCalculatorInfo systemCalculatorInfo = new SystemCalculatorInfo();
				NasObjectVO nasObjectVO = new NasObjectVO();

				nasObjectVO.setNfsAccessConfig(sb.toString());
				nasObjectVO.setVirtualVolumeName(res.getNasName());
				nasObjectVO.setPath(res.getNasFileSystemPath());
				nasObjectVO.setNasGb(res.getNasGb());
				nasObjectVO.setObjectId(res.getNasId());
				nasObjectVO.setName(res.getNasName());
				nasObjectVO.setNfsObjectId(res.getNasNfsObjectId());


				CustomReqProductVO resInfo = new CustomReqProductVO();
				resInfo.setNasId(res.getNasId());
				resInfo.setNasGb(res.getNasGb());
				resInfo.setOrderProductSeq(orderProductSeq);
				resInfo.setModUserId(orderUserId);
				resInfo.setRegUserId(orderUserId);
				resInfo.setNasNfsObjectId(nasObjectVO.getNasNfsObjectId());
				
				NasObject getVolume = NasUtils.getVolumeUUID(systemCalculatorInfo, nasObjectVO.getVolumeName(), cloudZone);
				
				String nasId = "";
				
				List<NasObject> volume = getVolume.getArray("records", NasType.RESULT);
				for (NasObject record : volume) {
					nasId = record.getValue("uuid").toString();
				}
				
				NasObject resize = NasUtils.resizeVolume(systemCalculatorInfo, nasId, res.getNasGb(), cloudZone);

				for(CustomReqProductVO nasOrderVm : nasOrderVmList) {
					Port ipObj = setIp(res, cloudVo);
					res.setPortNetworkId(ipObj.getId());

					BatchOssPortVO port = new BatchOssPortVO();
					port.setPortId(ipObj.getId());
					port.setPortName(ipObj.getName());
					port.setFixedIps(ipObj.getFixed_ips().get(0).getIp_address());
					port.setMacAddress(ipObj.getMac_address());
					port.setProjectId(res.getProjectId());
					port.setNetworkId(ipObj.getNetwork_id());
					port.setSubnetId(ipObj.getFixed_ips().get(0).getSubnet_id());
					port.setDeviceOwner(ipObj.getDevice_owner());
					port.setDeviceId(nasOrderVm.getVmUuid());

					insertOssPort(port);

					ServerIF serverIF = AbstractFactory.getServerIF(res.getProjectName(),cloudVo);
					serverIF.attachPortAttachment(port.getDeviceId(), port.getPortId());

					Thread.sleep(2000);

				    AnsibleObject ansibleAddHost = AnsibleUtils.addHost(systemCalculatorInfo, nasOrderVm.getFixedIps(), ansbileTemplate);
				    String hostId = ansibleAddHost.getValue("id").toString();

				    AnsibleObject getJob = AnsibleUtils.nasSetIp(systemCalculatorInfo, port.getMacAddress(), port.getFixedIps());
				    String jobId = getJob.getValue("id").toString();

				    while (true) {
				    	AnsibleObject jobStatus = AnsibleUtils.getStatus(systemCalculatorInfo, jobId);
						String status = jobStatus.getValue("status").toString();

						if ("successful".equals(status)) break;
						if ("failed".equals(status)) break;

						Thread.sleep(2000);
				    }

					AnsibleUtils.deleteHost(systemCalculatorInfo, hostId);
					res.setVmUuid(nasOrderVm.getVmUuid());
					res.setNasType(CodeUtil.CMM_CODE_FS_NAS_TYPE);
					this.sqlSessionTemplate.insert(insertOssNasVm, res);
				}				

			}else if(sRequestType.equals(CodeUtil.CMM_CODE_REQTYPE_EXPR)){

				try {
					res.setOrderUserId(orderUserId);
					res.setErrorStatus("PROVISIONING_SUCCESS");

					List<CustomReqProductVO> nasOrderVmList = this.sqlSessionTemplate.selectList(detailBssOrderProductNasVm, orderProductSeq);
					String cloudZone = "";

					if (nasOrderVmList.size() != 0) {
						StringBuilder sb = new StringBuilder();
						int index = 1;
						for (CustomReqProductVO nasOrderVm : nasOrderVmList) {							cloudZone = nasOrderVm.getCloudZone();

							sb.append(nasOrderVm.getDefaultNetworkId());
							if (index < nasOrderVmList.size()) {
								sb.append(",")	;
							}
							index++;
						}
					}

					SystemCalculatorInfo systemCalculatorInfo = new SystemCalculatorInfo();
					NasObjectVO nasObjectVO = new NasObjectVO();
					nasObjectVO.setVolumeName(res.getNasName());
					nasObjectVO.setMountPath(res.getNasFileSystemPath());
					nasObjectVO.setVolumeSize(res.getNasGb());
					nasObjectVO.setNasId(res.getNasId());
					nasObjectVO.setNasNfsObjectId(res.getNasNfsObjectId());
					nasObjectVO.setName(res.getNasName());

//					NasObject deleteVolume = NasUtils.deleteVolume(systemCalculatorInfo, nasObjectVO.getNasId(), cloudZone);
//
//					String jobUuid = deleteVolume.getObject("job").getValue("uuid").toString();
//
//					while (true) {
//						NasObject jobStatus = NasUtils.checkVolumeCreationJobStatus(systemCalculatorInfo, jobUuid, cloudZone);
//						String state = jobStatus.getValue("state").toString();
//
//						if ("success".equals(state)) break;
//						if ("failure".equals(state)) break;
//
//						Thread.sleep(2000);
//					}
//
//					NasUtils.deleteExportPolicy(systemCalculatorInfo, nasObjectVO.getNasNfsObjectId(), cloudZone);

					CustomReqProductVO resInfo = new CustomReqProductVO();

					resInfo.setNasId(res.getNasId());
					resInfo.setModUserId(orderUserId);

					this.sqlSessionTemplate.update(deleteOssNas, resInfo);


					if(cloudVo.getCloudType().equals("openshift")) {
						if ("DEV".equals(res.getEnvType())) {
							res.setProjectName(res.getProjectName() + CodeUtil.CREATE_PAAS_DEV_ENV);
						} else {
							res.setProjectName(res.getProjectName() + CodeUtil.CREATE_PAAS_PORD_ENV);
						}

						String nasName = nasObjectVO.getName().toLowerCase();
						String pvcName = nasName + "-pvc";
						String pvName = nasName + "-pv";

						try {
							opsApiOptionService.opsDeletePersistentVolumeClaim(res, cloudVo, pvcName);
							opsApiOptionService.opsDeletePersistentVolume(res, cloudVo, pvName);
						} catch (Exception e) {
							e.printStackTrace();
							res.setErrorStatus("PROVISIONING_FAIL");
							res.setErrorMsg(e.getMessage());
						}
					}else {
						for(CustomReqProductVO nasOrderVm : nasOrderVmList) {
							res.setVmUuid(nasOrderVm.getVmUuid());
							res.setPortNetworkId(nasOrderVm.getDefaultNetworkId());

							if(deleteIp(res, cloudVo) == true) {
								this.sqlSessionTemplate.update(deleteOssPort, res);
							}

							this.sqlSessionTemplate.update(deleteOssNasVm, resInfo);
						}
					}
//				} catch (InterruptedException e) {
//					log.error(e.getMessage());
//					res.setErrorStatus("PROVISIONING_FAIL");
//					res.setErrorMsg(e.getMessage());
				} catch (Exception e) {
					log.error(e.getMessage());
					res.setErrorStatus("PROVISIONING_FAIL");
					res.setErrorMsg(e.getMessage());
				}
			}
		}

		return res;
	}

	private CustomReqProductVO createService(CustomReqProductVO req, CustomOssCloudVO cloudVo) {
		try {
			CustomReqProductVO res = this.sqlSessionTemplate.selectOne(getBssOrderProductVmInfo, req.getOrderProductSeq());

			if(res != null) {
				if ("SERVICE99".equals(req.getServiceType())) {
					SystemCalculatorInfo systemCalculatorInfo = new SystemCalculatorInfo();
					String namesapce = req.getProjectName().toLowerCase();
					AnsibleUtils.bastionUser(systemCalculatorInfo, req.getBastionVmUserId(), req.getBastionVmUserPasswordDec(), namesapce);
				}
				CustomReqProductVO service = new CustomReqProductVO();
				Date idDate = new Date();
				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
				String serviceId = dateFormat.format(idDate);

				service.setServiceId(serviceId);
				service.setProjectId(req.getProjectId());
				service.setServiceEa(req.getServiceEa());
				service.setServiceName(req.getServiceName());
				service.setReqServiceProductSeq(req.getOrderProductSeq());
				service.setDescription(req.getDescription());
				service.setRegUserId(req.getRegUserId());
				service.setServiceCatalogSeq(req.getServiceCatalogSeq());
				service.setServiceProductSeq(req.getServiceProductSeq());
				service.setServiceType(req.getServiceType());
				service.setBastionVmUserId(req.getBastionVmUserId());
				service.setBastionVmUserPassword(req.getBastionVmUserPassword());
				service.setReqServiceProductSeq(req.getOrderProductSeq());
				service.setVmUuid(res.getVmUuid());

				insertOssService(service);

			}else {
				req.setErrorStatus("PROVISIONING_READY");
				req.setErrorMsg(null);
			}

		} catch (Exception e) {
			log.error(e.getMessage());
			req.setErrorStatus("PROVISIONING_FAIL");
			req.setErrorMsg(e.getMessage());
		}
		return req;
	}

	private CustomReqProductVO deleteService(CustomReqProductVO req, CustomOssCloudVO cloudVo) {
		try {
			this.sqlSessionTemplate.update(updateOssServiceDelFlag, req.getVmUuid());
		} catch (Exception e) {
			log.error(e.getMessage());
			req.setErrorStatus("PROVISIONING_FAIL");
			req.setErrorMsg(e.getMessage());
		}
		return req;
	}

	private CustomReqProductVO createVM(CustomReqProductVO req, CustomOssCloudVO cloudVo) {

		try {
			// Create VM STEP 1 - Flaver id Check
			req.setStep("1");
			String sFlaverId;
			if (req.getFlavorId() == null) {
				sFlaverId = setFlaver(req, cloudVo);
			} else {
				sFlaverId = req.getFlavorId();
			}

			req.setStep("2");
			// Create VM STEP 2 - Create Port
			Port ipObj = setIp(req, cloudVo);
			req.setPortNetworkId(ipObj.getId());
			// Backup IP 있을경우
			Port backupIpObj = null;
			if (req.getBackupNetworkFlag().equals("Y")) {
				backupIpObj = setBackupIp(req, cloudVo);
				req.setPortBackupNetworkId(backupIpObj.getId());
			}

			req.setStep("3");
			// Create VM STEP 3 - Create Bootable Disk
			Volume diskObj = setBootableDisk(req, cloudVo);

			  if(!diskObj.getStatus().equals("available")) {
				  throw new Exception("disk status not available");
				  }

			req.setDiskId(diskObj.getId());

			// Create VM STEP 4 - Sessting Server Network
			req.setStep("4");
			List<Network> networks = new LinkedList<Network>();
			Network network = new Network();
			network.setPort(ipObj.getId());
			networks.add(network);

			if (req.getBackupNetworkFlag().equals("Y")) {
				Network network2 = new Network();
				network2.setPort(backupIpObj.getId());
				networks.add(network2);
			}

			req.setStep("5");
			// Create VM STEP 5 - Create VM
			Server server = new Server();
			server.setName(req.getHostname());
			server.setFlavorRef(sFlaverId);
			server.setImageRef(req.getVmImageId());
			server.setOS_DCF_diskConfig("AUTO");
			server.setNetworks(networks);
			server.setAvailability_zone(req.getAzName());
			server.setImageRef(diskObj.getId());
			Server obj12 = BatchProcessor.createServer(req.getProjectName(), server, cloudVo);
			req.setVmUuid(obj12.getId());

			// OSS_VM 저장
			CustomReqProductVO vm = new CustomReqProductVO();
			vm.setVmUuid(obj12.getId());
			vm.setProjectId(req.getProjectId());
			vm.setHostname(req.getHostname());
			vm.setHostnameAlias(req.getHostnameAlias());
			vm.setFlavorId(req.getFlavorId());
			vm.setVcpus(req.getVcpus());
			vm.setMemGb(req.getMemGb());
			vm.setDiskGb(req.getDiskGb());
			vm.setImageId(diskObj.getId());
			vm.setVolumeType(req.getVolumeType());
			vm.setAzName(req.getAzName());
			vm.setVmProductSeq(req.getVmProductSeq());
			vm.setOsProductSeq(req.getOsProductSeq());
			vm.setVmCatalogSeq(req.getVmCatalogSeq());
			vm.setOrderUserId(req.getOrderUserId());
			vm.setCreateDatetime(req.getOnDemandFlag().equals("N") ? req.getApplyDatetime()
					: DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss"));
			vm.setRegUserId(CodeUtil.SYNC_ADMIN);
			vm.setInstanceType(req.getInstanceType());

			insertOssVm(vm);

			// OSS_VM_NETWORK 저장
			vm.setNetworkId(req.getDefaultNetworkId());
			vm.setBackupNetworkId(req.getBackupNetworkId());
			vm.setPortNetworkId(ipObj.getId());
			if (req.getBackupNetworkFlag().equals("Y")) {
				vm.setPortBackupNetworkId(backupIpObj.getId());
			} else {
				vm.setPortBackupNetworkId("");
			}
			insertOssVmNetwork(vm);

			// OSS_PORT 정보저장
			BatchOssPortVO port = new BatchOssPortVO();
			port.setPortId(ipObj.getId());
			port.setPortName(ipObj.getName());
			port.setFixedIps(ipObj.getFixed_ips().get(0).getIp_address());
			port.setMacAddress(ipObj.getMac_address());
			port.setProjectId(req.getProjectId());
			port.setNetworkId(ipObj.getNetwork_id());
			port.setSubnetId(ipObj.getFixed_ips().get(0).getSubnet_id());
			port.setDeviceOwner(ipObj.getDevice_owner());
			port.setDeviceId(obj12.getId());
			insertOssPort(port);

			if (req.getBackupNetworkFlag().equals("Y")) {
				BatchOssPortVO backupPort = new BatchOssPortVO();
				backupPort.setPortId(backupIpObj.getId());
				backupPort.setPortName(backupIpObj.getName());
				backupPort.setFixedIps(backupIpObj.getFixed_ips().get(0).getIp_address());
				backupPort.setMacAddress(backupIpObj.getMac_address());
				backupPort.setProjectId(req.getProjectId());
				backupPort.setNetworkId(backupIpObj.getNetwork_id());
				backupPort.setSubnetId(backupIpObj.getFixed_ips().get(0).getSubnet_id());
				backupPort.setDeviceOwner(backupIpObj.getDevice_owner());
				backupPort.setDeviceId(obj12.getId());
				insertOssPort(backupPort);
			}

			// OSS_DISK 저장
			CustomReqProductVO disk = new CustomReqProductVO();
			disk.setDiskId(diskObj.getId());
			disk.setVmUuid(obj12.getId());
			disk.setProjectId(req.getProjectId());
			disk.setDiskName(req.getHostname() + "-OS");
			disk.setDiskGb(req.getDiskGb());
			disk.setCreateDatetime(req.getOnDemandFlag().equals("N") ? req.getApplyDatetime()
					: DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss"));
			disk.setOrderUserId(req.getOrderUserId());
			disk.setDescription(req.getDescription());
			disk.setDiskCatalogSeq(req.getDiskCatalogSeq());
			disk.setDiskProductSeq(req.getDiskProductSeq());
			disk.setVolumeType(req.getDiskType());

			this.sqlSessionTemplate.insert(insertOssDisk, disk);

		} catch (Exception e) {
			log.error(e.getMessage());
			req.setErrorStatus("PROVISIONING_FAIL");
			req.setErrorMsg(e.getMessage());
			if (req.getStep().equals("3")) {
				try {
					if (deleteIp(req, cloudVo) == true) {
						this.sqlSessionTemplate.delete(deleteOssPort, req);
						if (req.getBackupNetworkFlag() == "Y") {
							if (deleteBackupIp(req, cloudVo) == true) {
								this.sqlSessionTemplate.delete(deleteOssPort, req);
							}
						}
					}
				} catch (NotConnectGatewayException | NotSupportGatewayException | InvaildOpenStackException e1) {
					log.error(e1.getMessage());
					req.setErrorMsg(e1.getMessage());
				}
			}
			if (req.getStep().equals("4")) {
				deleteDisk(req, cloudVo);
				try {
					if (deleteIp(req, cloudVo) == true) {
						this.sqlSessionTemplate.delete(deleteOssPort, req);
						if (req.getBackupNetworkFlag() == "Y") {
							if (deleteBackupIp(req, cloudVo) == true) {
								this.sqlSessionTemplate.delete(deleteOssPort, req);
							}
						}
					}
				} catch (NotConnectGatewayException | NotSupportGatewayException | InvaildOpenStackException e1) {
					log.error(e1.getMessage());
					req.setErrorMsg(e1.getMessage());
				}
			}
			if (req.getStep().equals("5")) {
				if (req.getVmUuid() != null) {
					deleteVM(req, cloudVo);
				} else {
					deleteDisk(req, cloudVo);
					try {
						if (deleteIp(req, cloudVo) == true) {
							this.sqlSessionTemplate.delete(deleteOssPort, req);
							if (req.getBackupNetworkFlag() == "Y") {
								if (deleteBackupIp(req, cloudVo) == true) {
									this.sqlSessionTemplate.delete(deleteOssPort, req);
								}
							}
						}
					} catch (NotConnectGatewayException | NotSupportGatewayException | InvaildOpenStackException e1) {
						log.error(e1.getMessage());
						req.setErrorMsg(e1.getMessage());
					}
				}
			}
		}

		return req;
	}

	private CustomReqProductVO changeVM(CustomReqProductVO req, CustomOssCloudVO cloudVo) {
		try {

			ServerIF serverIF = AbstractFactory.getServerIF(req.getProjectName(), cloudVo);
			Resize resize = new Resize();
			resize.setServer_id(req.getVmUuid());
			String sFlaverId;
			if (req.getFlavorId().equals(null)) {
				sFlaverId = setFlaver(req, cloudVo);
			} else {
				sFlaverId = req.getFlavorId();
			}
			resize.setFlavorRef(sFlaverId);
			serverIF.resizeServer(resize);
			this.sqlSessionTemplate.update(updateOssVm, req);

			for (int i = 0; i < count; i++) {

				Server server = serverIF.getServer(req.getVmUuid());
				log.debug("VM Status ================>>>>" + " VM UUID={}, Status={}", req.getVmUuid(),
						server.getStatus());

				if (server.getStatus().equals("VERIFY_RESIZE")) {
					serverIF.actionServer(req.getVmUuid(), "confirmResize");
					break;
				}
				Thread.sleep(30000);
			}

		} catch (NotConnectGatewayException | NotSupportGatewayException | InvaildOpenStackException
				| InterruptedException e) {

            logger.error("changeVM Exception");

			req.setErrorStatus("PROVISIONING_FAIL");
			req.setErrorMsg(e.getMessage());
		}

		return req;
	}

	private CustomReqProductVO deleteVM(CustomReqProductVO req, CustomOssCloudVO cloudVo) {

     try {

			try {
				BatchProcessor.deleteServer(req.getProjectName(), req.getVmUuid(), cloudVo);
				Thread.sleep(30000);
			} catch (InterruptedException | NotConnectGatewayException | NotSupportGatewayException | InvaildOpenStackException e) {
				req.setErrorStatus("PROVISIONING_FAIL");
				req.setErrorMsg(e.getMessage());
			}


			List<CustomReqProductVO> getDataDisk = this.sqlSessionTemplate.selectList(getDataDiskIds,req);

			for(CustomReqProductVO getData : getDataDisk) {
				BatchProcessor.deleteVolume(req.getProjectName(), getData.getDiskId(), cloudVo);
			}

			req.setDiskId(req.getImageId());
			this.sqlSessionTemplate.delete(deleteOssVm, req);
			this.sqlSessionTemplate.delete(deleteOssDisk, req);

			// IP 삭제 부분
			if(deleteIp(req, cloudVo) == true) {
				this.sqlSessionTemplate.delete(deleteOssPort, req);
			}

			// Backup IP 삭제 부분
			if( req.getBackupNetworkFlag() == "Y" ) {
				if(deleteBackupIp(req, cloudVo) == true) {
					this.sqlSessionTemplate.delete(deleteOssPort, req);
				}
			}

		} catch (NotConnectGatewayException | NotSupportGatewayException | InvaildOpenStackException e) {

            logger.error("deleteVM Exception");

			req.setErrorStatus("PROVISIONING_FAIL");
			req.setErrorMsg(e.getMessage());
		}
		return req;
	}

	private CustomReqProductVO createDisk(CustomReqProductVO req, CustomOssCloudVO cloudVo) {

		try {
			VolumeIF volumeIF = AbstractFactory.getVolumeIF(req.getProjectName(), cloudVo);
			Volume volume = new Volume();
			volume.setSize(Integer.parseInt(req.getDiskGb()));
			volume.setName(req.getDiskName());
			volume.setVolume_type(req.getDiskType());
			Volume obj = volumeIF.createVolume(volume);
			req.setStep("1");
			req.setDiskId(obj.getId());
			req.setCreateDatetime(req.getOnDemandFlag().equals("N") ? req.getApplyDatetime()
					: DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss"));
			req.setVolumeType(req.getDiskType());
			this.sqlSessionTemplate.insert(insertOssDisk, req);

			if (req.getVmUuid() == null || req.getVmUuid() == "" || req.getVmUuid().length() <= 0) {
				return req;
			}

			for (int i = 0; i < count; i++) {
				obj = volumeIF.getVolume(req.getDiskId());
				log.debug("Disk ================>>>> Disk Status={}", obj.getStatus());
				if (obj.getStatus().equals("available")) {
					attachVolume(req, cloudVo);
					break;
				}
				Thread.sleep(30000);
			}

		} catch (NotConnectGatewayException | NotSupportGatewayException | InvaildOpenStackException
				| InterruptedException e) {
			log.error(e.getMessage());
			req.setErrorStatus("PROVISIONING_FAIL");
			req.setErrorMsg(e.getMessage());
			if (req.getStep().equals("1")) {
				deleteDisk(req, cloudVo);
			}
		}

		return req;
	}

	private CustomReqProductVO changeDisk(CustomReqProductVO req, CustomOssCloudVO cloudVo) {

		try {
			VolumeIF volumeIF = AbstractFactory.getVolumeIF(req.getProjectName(), cloudVo);
			Volume obj = volumeIF.getVolume(req.getDiskId());

			log.debug("Disk size ================>>>>" + obj.getAttachments().size());

			if (obj.getAttachments().size() > 0) {
				detachVolume(req, cloudVo);

				for (int i = 0; i < count; i++) {
					obj = volumeIF.getVolume(req.getDiskId());
					log.debug("Disk ================>>>>" + " Disk Aetach=" + obj.getAttachments().size());

					if (obj.getAttachments().size() <= 0) {
						break;
					}
					Thread.sleep(30000);
				}
			}

			// volumeIF.extendVolume(req.getDiskId(), 2); //2017.11.13 고정크기 2에서 입력값으로 변경
			volumeIF.extendVolume(req.getDiskId(), Integer.parseInt(req.getDiskGb()));

			this.sqlSessionTemplate.update(updateOssDisk, req);

			if (req.getVmUuid() == null || req.getVmUuid() == "" || req.getVmUuid().length() <= 0) {
				return req;
			}

			for (int i = 0; i < count; i++) {

				obj = volumeIF.getVolume(req.getDiskId());
				log.debug("Disk ================>>>> Disk Status=" + obj.getStatus());

				if (obj.getStatus().equals("available")) {
					attachVolume(req, cloudVo);
					break;
				}

				Thread.sleep(30000);
			}

		} catch (NotConnectGatewayException | NotSupportGatewayException | InvaildOpenStackException
				| InterruptedException e) {
			log.error(e.getMessage());
			req.setErrorStatus("PROVISIONING_FAIL");
			req.setErrorMsg(e.getMessage());
		}

		return req;
	}

	private CustomReqProductVO deleteDisk(CustomReqProductVO req, CustomOssCloudVO cloudVo) {

		try {
			VolumeIF volumeIF = AbstractFactory.getVolumeIF(req.getProjectName(), cloudVo);
			Volume obj = volumeIF.getVolume(req.getDiskId());

			log.debug("Disk size ================>>>>" + obj.getAttachments().size());

			if (obj.getAttachments().size() > 0) {
				detachVolume(req, cloudVo);

				for (int i = 0; i < count; i++) {
					obj = volumeIF.getVolume(req.getDiskId());
					log.debug("Disk ================>>>>" + " Disk Aetach=" + obj.getAttachments().size());

					if (obj.getAttachments().size() <= 0) {
						break;
					}
					Thread.sleep(30000);
				}
			}

			volumeIF.deleteVolume(req.getDiskId());
			this.sqlSessionTemplate.delete(deleteOssDisk, req);

		} catch (NotConnectGatewayException | NotSupportGatewayException | InvaildOpenStackException
				| InterruptedException e) {
			log.error(e.getMessage());
			req.setErrorStatus("PROVISIONING_FAIL");
			req.setErrorMsg(e.getMessage());
		}
		return req;
	}

	private CustomReqProductVO vcreateDisk(CustomReqProductVO req, CustomOssCloudVO cloudVo) {

		try {
			DiskBacking diskBacking = new DiskBacking();
			diskBacking.setType("VMDK_FILE");
			diskBacking.setVmdkFile(req.getVmdkFile());

			DiskInfo diskInfo = new DiskInfo();
			diskInfo.setType(req.getDiskType());
			diskInfo.setBacking(diskBacking);

			DiskSpec diskSpec = new DiskSpec();
			diskSpec.setSpec(diskInfo);

			VmDiskIF vmDiskIF = AbstractFactory.getDiskVmware(req, cloudVo);
			DiskSpec obj = vmDiskIF.createDisk(diskSpec, req.getDiskId());

			String reqDiskSeq = DateFormatUtils.format(new Date(), "yyyyMMddHHmmss");
			req.setDiskId(obj.getValue() + "-" + reqDiskSeq);
			req.setCreateDatetime(req.getOnDemandFlag().equals("N") ? req.getApplyDatetime()
					: DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss"));

			this.sqlSessionTemplate.insert(insertOssDisk, req);

		} catch (Exception e) {
			log.error(e.getMessage());
			req.setErrorStatus("PROVISIONING_FAIL");
			req.setErrorMsg(e.getMessage());
		}

		return req;
	}

	private CustomReqProductVO vdeleteDisk(CustomReqProductVO req, CustomOssCloudVO cloudVo) {

		try {
			DiskSpec diskSpec = new DiskSpec();
			String[] wmwareDiskId = req.getDiskId().split("-");
			String diskId = wmwareDiskId[0];
			String diskUuid = wmwareDiskId[1];
			req.setDiskId(diskId);
			VmDiskIF vmDiskIF = AbstractFactory.getDiskVmware(req, cloudVo);
			vmDiskIF.deleteDisk(diskSpec, req.getDiskId());
			req.setDiskId(diskId + "-" + diskUuid);

			this.sqlSessionTemplate.delete(deleteOssDisk, req);

		} catch (Exception e) {
			log.error(e.getMessage());
			req.setErrorStatus("PROVISIONING_FAIL");
			req.setErrorMsg(e.getMessage());
		}
		return req;
	}

	/**
	 * 오픈스택에 동일한 Flaver가 있는지 검색 하고, 없으면 새로 생성을 한다.
	 */
	public String setFlaver(CustomReqProductVO req, CustomOssCloudVO cloudVo)
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {

		int iMemory = Integer.parseInt(req.getMemGb()) * 1024;
		req.setDiskGb(req.getDiskGb());

		String sFlaverId = "";
		FlavorIF flavorIF = AbstractFactory.getFlavorIF(cloudVo);
		List<Flavor> flavors = flavorIF.getFlavors();
		for (Flavor flavor : flavors) {
			if (req.getVcpus().equals(flavor.getVcpus().toString()) && (iMemory + "").equals(flavor.getRam().toString())
					&& req.getDiskGb().equals(flavor.getDisk().toString())) {

				sFlaverId = flavor.getId();
				break;
			}
		}

		// 기존 Flaover가 없는 경우 새로 생성한다.
		if (sFlaverId.equals("")) {
			StringBuffer nameBuf = new StringBuffer();
			nameBuf.append("c" + StringUtils.leftPad(req.getVcpus(), 2, "0"));
			nameBuf.append("m" + StringUtils.leftPad(req.getMemGb(), 3, "0"));
			nameBuf.append("d" + StringUtils.leftPad(req.getDiskGb(), 4, "0"));

			Flavor flavor = new Flavor();
			flavor.setName(nameBuf.toString());
			flavor.setVcpus(Integer.parseInt(req.getVcpus()));
			flavor.setRam(iMemory);
			flavor.setDisk(Integer.parseInt(req.getDiskGb()));
			Flavor obj1 = flavorIF.createFlavor(flavor);
			sFlaverId = obj1.getId();
		}

		return sFlaverId;
	}

	/**
	 * Bootable OS 블록디스크 생성
	 */
	public Volume setBootableDisk(CustomReqProductVO req, CustomOssCloudVO cloudVo)
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		String sBootableDiskId = "";
		String sBootableDiskStatus = "";
		Volume obj = null;

		VolumeIF volumeIF = AbstractFactory.getVolumeIF(req.getProjectName(), cloudVo);
		Volume volume = new Volume();
		volume.setSize(Integer.parseInt(req.getDiskGb()));
		// volume.setAvailability_zone(req.getAzName());
		volume.setName(req.getDiskName());
		volume.setImageRef(req.getVmImageId());
		// volume.setVolume_type("hitachi-g900");
		volume.setVolume_type(req.getVolumeType());
		volume.setName(req.getHostname() + "-OS");
		obj = volumeIF.createVolume(volume);
		sBootableDiskId = obj.getId();
		obj = volumeIF.getVolume(sBootableDiskId);
		sBootableDiskStatus = obj.getStatus();

		while (!sBootableDiskStatus.equals("available")) {
			obj = volumeIF.getVolume(sBootableDiskId);
			sBootableDiskStatus = obj.getStatus();
			long start = System.currentTimeMillis();
			long end = start + 600*1000;
		if (sBootableDiskStatus.equals("available") || System.currentTimeMillis() <end) {
			log.debug("Created Volumes");
			continue;
		} else {
			log.debug("Creating Volumes");
		}
	}

		return obj;
	}

	/**
	 * Port IP 생성
	 */
	public Port setIp(CustomReqProductVO req, CustomOssCloudVO cloudVo)
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {

		PortIF portIF = AbstractFactory.getPortIF(cloudVo);

		Port port = new Port();
		port.setNetwork_id(req.getDefaultNetworkId());
		port.setName(req.getDefaultNetworkIp());
		// port.setDevice_owner("");
		port.setProject_id(req.getProjectId());

		List<FixedIPS> listFixedIps = new LinkedList<FixedIPS>();
		FixedIPS fixedIps = new FixedIPS();
		fixedIps.setSubnet_id(req.getSubnetId());
		fixedIps.setIp_address(req.getDefaultNetworkIp());
		listFixedIps.add(fixedIps);
		port.setFixed_ips(listFixedIps);

		Port obj = portIF.createPort(port);

		return obj;
	}

	/**
	 * Port Backup IP 생성
	 */
	public Port setBackupIp(CustomReqProductVO req, CustomOssCloudVO cloudVo)
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {

		Port obj = null;
		String cloudId = cloudVo.getCloudId();
		CustomReqProductVO res = this.sqlSessionTemplate.selectOne(getBackupNetwork, cloudId);
		try {
			PortIF portIF = AbstractFactory.getPortIF(cloudVo);
			Port port = new Port();
			port.setNetwork_id(res.getNetworkId());
			port.setName(req.getBackupNetworkIp());
			// port.setDevice_owner("");
			port.setProject_id(req.getProjectId());

			List<FixedIPS> listFixedIps = new LinkedList<FixedIPS>();
			FixedIPS fixedIps = new FixedIPS();
			fixedIps.setSubnet_id(res.getSubnetId());
			fixedIps.setIp_address(req.getBackupNetworkIp());
			listFixedIps.add(fixedIps);

			port.setFixed_ips(listFixedIps);

			obj = portIF.createPort(port);
		} catch (Exception e) {
			log.error(e.getMessage());
			req.setErrorStatus("PROVISIONING_FAIL");
			req.setErrorMsg(e.getMessage());
		}

		return obj;
	}

	/**
	 * Port IP 삭제
	 */
	public boolean deleteIp(CustomReqProductVO req, CustomOssCloudVO cloudVo)
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {

		try {
			PortIF portIF = AbstractFactory.getPortIF(cloudVo);
			Port port = new Port();
			port.setId(req.getPortNetworkId());
			port.setProject_id(req.getProjectId());

			portIF.deletePort(port);
		} catch (Exception e) {
			log.error(e.getMessage());
			req.setErrorStatus("PROVISIONING_FAIL");
			req.setErrorMsg(e.getMessage());
		}

		return true;
	}

	/**
	 * Port IP 삭제
	 */
	public boolean deleteBackupIp(CustomReqProductVO req, CustomOssCloudVO cloudVo)
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {

		try {
			PortIF portIF = AbstractFactory.getPortIF(cloudVo);
			Port port = new Port();
			port.setId(req.getPortBackupNetworkId());

			portIF.deletePort(port);
		} catch (Exception e) {
			log.error(e.getMessage());
			req.setErrorStatus("PROVISIONING_FAIL");
			req.setErrorMsg(e.getMessage());
		}

		return true;
	}

	private String insertOssService(CustomReqProductVO service) {

		return this.sqlSessionTemplate.insert(insertOssService, service) + "";
	}

	private String insertOssVm(CustomReqProductVO vm) {

		return this.sqlSessionTemplate.insert(insertOssVm, vm) + "";
	}

	private String insertOssVmNetwork(CustomReqProductVO vm) {

		return this.sqlSessionTemplate.insert(insertOssVmNetwork, vm) + "";
	}

	private String insertOssPort(BatchOssPortVO port) {

		return this.sqlSessionTemplate.insert(insertOssPort, port) + "";
	}

	private boolean detachVolume(CustomReqProductVO req, CustomOssCloudVO cloudVo) {

		ServerIF serverIF = AbstractFactory.getServerIF(req.getProjectName(), cloudVo);
		boolean result = false;
		try {
			log.debug("detachVolume ===>>>> vmuuid= {}, diskid= {}", req.getVmUuid(), req.getDiskId());

			result = serverIF.detachVolumeAttachments(req.getVmUuid(), req.getDiskId());
		} catch (NotConnectGatewayException | NotSupportGatewayException | InvaildOpenStackException e) {
			log.error(e.getMessage());
			result = false;
		}
		return result;
	}

	private boolean attachVolume(CustomReqProductVO req, CustomOssCloudVO cloudVo) {

		ServerIF serverIF = AbstractFactory.getServerIF(req.getProjectName(), cloudVo);
		boolean result = false;

		try {
			log.debug("attachVolume ===>>>> vmuuit= {}, diskid= {}", req.getVmUuid(), req.getDiskId());
			VolumeAttachment vol = serverIF.attachVolumeAttachments(req.getVmUuid(), req.getDiskId());
			if (vol != null) {
				result = true;
			}
		} catch (NotConnectGatewayException | NotSupportGatewayException | InvaildOpenStackException e) {
			log.error(e.getMessage());
			result = false;
		}

		return result;
	}

	private CustomReqProductVO productByVmWare(String orderProductSeq, String sProduct, String sRequestType,
			String orderUserId, CustomOssCloudVO cloudVo) {

		CustomReqProductVO res = new CustomReqProductVO();
		res.setCloudId(cloudVo.getCloudId());

		if (sProduct.equals(CodeUtil.CMM_CODE_PRODCATE_VM)) {
			res = this.sqlSessionTemplate.selectOne(detailBssOrderProductVm, orderProductSeq);
			res.setOrderUserId(orderUserId);
			res.setErrorStatus("PROVISIONING_SUCCESS");
			if (sRequestType.equals(CodeUtil.CMM_CODE_REQTYPE_NEW)) {
				res = vCreateVM(res, cloudVo);
			} // 신규
			else if (sRequestType.equals(CodeUtil.CMM_CODE_REQTYPE_CHANGE)) {
				res = changeVM_vmWare(res, cloudVo);
			} // 변경
			else if (sRequestType.equals(CodeUtil.CMM_CODE_REQTYPE_EXPR)) {
				res = deleteVM_vmWare(res, cloudVo);
			} // 삭제
		} else if (sProduct.equals(CodeUtil.CMM_CODE_PRODCATE_DISK)) {

			res = this.sqlSessionTemplate.selectOne(detailBssOrderProductDisk, orderProductSeq);
			res.setOrderUserId(orderUserId);
			res.setErrorStatus("PROVISIONING_SUCCESS");
			if (sRequestType.equals(CodeUtil.CMM_CODE_REQTYPE_NEW)) {
				res = vcreateDisk(res, cloudVo);
			} // 신규
			else if (sRequestType.equals(CodeUtil.CMM_CODE_REQTYPE_EXPR)) {
				res = vdeleteDisk(res, cloudVo);
			} // 삭제

		}

		return res;
	}

	private CustomReqProductVO productByVra(String orderProductSeq, String sProduct, String sRequestType,
			String orderUserId, CustomOssCloudVO cloudVo) {
		CustomReqProductVO res = new CustomReqProductVO();
		res.setCloudId(cloudVo.getCloudId());

		if (sProduct.equals(CodeUtil.CMM_CODE_PRODCATE_VM)) {
			res = this.sqlSessionTemplate.selectOne(detailBssOrderProductVm, orderProductSeq);
			res.setOrderUserId(orderUserId);
			res.setErrorStatus("PROVISIONING_SUCCESS");
			if (sRequestType.equals(CodeUtil.CMM_CODE_REQTYPE_NEW)) {
				res = vraCreateVM(res, cloudVo);
			} // 신규
			else if (sRequestType.equals(CodeUtil.CMM_CODE_REQTYPE_CHANGE)) {
				res = vraChangeVM(res, cloudVo);
			} // 변경
			else if (sRequestType.equals(CodeUtil.CMM_CODE_REQTYPE_EXPR)) {
				res = vraDeleteVM(res, cloudVo);
			} // 삭제
		} else if (sProduct.equals(CodeUtil.CMM_CODE_PRODCATE_DISK)) {

			res = this.sqlSessionTemplate.selectOne(detailBssOrderProductDisk, orderProductSeq);
			res.setOrderUserId(orderUserId);
			res.setErrorStatus("PROVISIONING_SUCCESS");
			if (sRequestType.equals(CodeUtil.CMM_CODE_REQTYPE_NEW)) {
				res = vraCreateDisk(res, cloudVo);
			} // 신규
			else if (sRequestType.equals(CodeUtil.CMM_CODE_REQTYPE_CHANGE)) {
				res = vraChangeDisk(res, cloudVo);
			} // 변경
			else if (sRequestType.equals(CodeUtil.CMM_CODE_REQTYPE_EXPR)) {
				res = vraDeleteDisk(res, cloudVo);
			} // 삭제

		}

		return res;
	}

	private CustomReqProductVO productByNutanix(String orderProductSeq, String sProduct, String sRequestType,
			String orderUserId, CustomOssCloudVO cloudVo) throws Exception {
		CustomReqProductVO res = new CustomReqProductVO();
		res.setCloudId(cloudVo.getCloudId());

		if (sProduct.equals(CodeUtil.CMM_CODE_PRODCATE_VM)) {
			res = this.sqlSessionTemplate.selectOne(detailBssOrderProductVm, orderProductSeq);
			res.setOrderUserId(orderUserId);
			res.setErrorStatus("PROVISIONING_SUCCESS");
			if (sRequestType.equals(CodeUtil.CMM_CODE_REQTYPE_NEW)) {
				res = nutanixCreateVM(res, cloudVo);
			} // 신규
			else if (sRequestType.equals(CodeUtil.CMM_CODE_REQTYPE_CHANGE)) {
				res = nutanixChangeVM(res, cloudVo);
			} // 변경
			else if (sRequestType.equals(CodeUtil.CMM_CODE_REQTYPE_EXPR)) {
				res = nutanixDeleteVM(res, cloudVo);
			} // 삭제
		} else if (sProduct.equals(CodeUtil.CMM_CODE_PRODCATE_DISK)) {

			res = this.sqlSessionTemplate.selectOne(detailBssOrderProductDisk, orderProductSeq);
			res.setOrderUserId(orderUserId);
			res.setErrorStatus("PROVISIONING_SUCCESS");
			if (sRequestType.equals(CodeUtil.CMM_CODE_REQTYPE_NEW)) {
				res = nutanixCreateDisk(res, cloudVo);
			} // 신규
			else if (sRequestType.equals(CodeUtil.CMM_CODE_REQTYPE_CHANGE)) {
				res = nutanixChangeDisk(res, cloudVo);
			} // 변경
			else if (sRequestType.equals(CodeUtil.CMM_CODE_REQTYPE_EXPR)) {
				res = nutanixDeleteDisk(res, cloudVo);
			} // 삭제

		}

		return res;
	}

	private CustomReqProductVO vCreateVM(CustomReqProductVO req, CustomOssCloudVO cloudVo) {
		try {
			VmServerIF serverIF = VmAbstractFactory.getServerIF(req.getProjectName(), cloudVo);

			VmCpuUpdate cpuUpdate = new VmCpuUpdate();
			cpuUpdate.setNumCpus(req.getVcpus()); // cpu 갯수를 넣어 적용

			VmMemoryUpdate memoryUpdate = new VmMemoryUpdate();
			int memoryMb = Integer.parseInt(req.getMemGb()) * 1024;
			memoryUpdate.setMemory(Integer.toString(memoryMb)); // memory mb단위를 넣어 적용

			VmCapacity capacity = new VmCapacity();
			long DiskByte = Integer.parseInt(req.getDiskGb()) * 1073741824L;
			capacity.setCapacity(Long.toString(DiskByte));

			List<VmDiskToUpdate> diskList = new ArrayList<VmDiskToUpdate>();

			VmDiskToUpdate diskToUpdate = new VmDiskToUpdate();
			diskToUpdate.setKey(req.getVolumeType()); // 기존 template에 속한 Disk의 Key값
			diskToUpdate.setValue(capacity); // Disk Byte단위를 넣어 적용 기존 Disk보다 용량이 적으면 실패
			diskList.add(diskToUpdate);

			VmHardwareCustomization hardwareCustomization = new VmHardwareCustomization();
			hardwareCustomization.setCpuUpdate(cpuUpdate);
			hardwareCustomization.setMemoryUpdate(memoryUpdate);
			hardwareCustomization.setDiskToUpdate(diskList);

			VmDiskStorage datastore = new VmDiskStorage();
			datastore.setDatastore(req.getDatastoreId());

			VmPlacement placement = new VmPlacement();
			placement.setFolder("group-v3"); // 생성 폴더 선택 (required)
			placement.setCluster(req.getDefaultNetworkId()); // 생성 Cluster 선택 (Cluster,Host,Resource_pool 중 택1)

			VmServer vmServer = new VmServer();
			vmServer.setName(req.getHostname());
			vmServer.setPoweredOn(true); // vm 생성시 전원 on/off
			vmServer.setPlacement(placement);
			vmServer.setHardwareCustomization(hardwareCustomization);
			vmServer.setDiskStorage(datastore);
			VmSpec vmSpec = new VmSpec();
			vmSpec.setSpec(vmServer);

			String libraryId = req.getVmImageId();

			// Create VM

			vmSpec = serverIF.createServer(vmSpec, libraryId);

			VmWareJsonObject JsonObject = new VmWareJsonObject();
			JsonObject = serverIF.getServer(vmSpec.getValue());

			VmDisks vmDisks = JsonObject.getValue().getDisks().get(0);
			VmNics vmNics = JsonObject.getValue().getNics().get(0);
			// OSS_VM 저장
			CustomReqProductVO vm = new CustomReqProductVO();
			vm.setVmUuid(vmSpec.getValue());
			vm.setProjectId(req.getProjectId());
			vm.setHostname(req.getHostname());
			vm.setHostnameAlias(req.getHostnameAlias());
			vm.setFlavorId(req.getFlavorId());
			vm.setVcpus(req.getVcpus());
			vm.setMemGb(req.getMemGb());
			vm.setDiskGb(req.getDiskGb());
			vm.setImageId(vmDisks.getKey());
			vm.setVolumeType(req.getVolumeType());
			vm.setAzName(req.getAzName());
			vm.setVmProductSeq(req.getVmProductSeq());
			vm.setOsProductSeq(req.getOsProductSeq());
			vm.setVmCatalogSeq(req.getVmCatalogSeq());
			vm.setOrderUserId(req.getOrderUserId());
			vm.setCreateDatetime(req.getOnDemandFlag().equals("N") ? req.getApplyDatetime()
					: DateFormatUtils.format(new Date(), "yyyyMMddHHmmss"));
			vm.setRegUserId(CodeUtil.SYNC_ADMIN);
			insertOssVm(vm);

			// OSS_VM_NETWORK 저장
			vm.setNetworkId(req.getDefaultNetworkId());
			vm.setBackupNetworkId(req.getBackupNetworkId());
			vm.setPortNetworkId(vmSpec.getValue() + "-" + vmNics.getKey());
			/*
			 * if(req.getBackupNetworkFlag().equals("Y") ) {
			 * vm.setPortBackupNetworkId(backupIpObj.getId()); } else {
			 * vm.setPortBackupNetworkId(""); }
			 */
			insertOssVmNetwork(vm);

			// OSS_PORT 정보저장
			BatchOssPortVO port = new BatchOssPortVO();
			port.setPortId(vmSpec.getValue() + "-" + vmNics.getKey());
			port.setPortName(vmNics.getValue().getBacking().getNetworkName());
			port.setFixedIps(req.getDefaultNetworkIp());
			port.setMacAddress(vmNics.getValue().getMacAddress());
			port.setProjectId(req.getProjectId());
			port.setNetworkId(vmSpec.getValue() + "-" + vmNics.getKey());
			// port.setSubnetId(ipObj.getFixed_ips().get(0).getSubnet_id());
			// port.setDeviceOwner(ipObj.getDevice_owner());
			// port.setDeviceId(obj12.getId());
			insertOssPort(port);
			// OSS_DISK 저장
			CustomReqProductVO disk = new CustomReqProductVO();
			disk.setDiskId(vmSpec.getValue() + "-" + vmDisks.getKey());
			disk.setVmUuid(vmSpec.getValue());
			disk.setProjectId(req.getProjectId());
			disk.setDiskName(req.getHostname() + "-OS");
			disk.setDiskGb(req.getDiskGb());
			disk.setCreateDatetime(req.getOnDemandFlag().equals("N") ? req.getApplyDatetime()
					: DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss"));
			disk.setOrderUserId(req.getOrderUserId());
			disk.setDescription(req.getDescription());
			disk.setDiskCatalogSeq(req.getDiskCatalogSeq());
			disk.setDiskProductSeq(req.getDiskProductSeq());
			disk.setVolumeType(req.getDiskType());

			this.sqlSessionTemplate.insert(insertOssDisk, disk);
		} catch (NotConnectGatewayException | NotSupportGatewayException | InvaildOpenStackException
				| NullPointerException e) {
			log.error(e.getMessage());
			req.setErrorStatus("PROVISIONING_FAIL");
			req.setErrorMsg(e.getMessage());
		}
		return req;
	}

	private CustomReqProductVO changeVM_vmWare(CustomReqProductVO req, CustomOssCloudVO cloudVo) {
		String vmId = req.getVmUuid();
		String projectName = req.getProjectName();

		try {
			VmHardwareCpuIF vmHardwareCpu = VmAbstractFactory.getVmHardwareCpuIF(cloudVo);
			VmHardwareMemIF vmHardwareMem = VmAbstractFactory.getVmHardwareMemIF(projectName, vmId, cloudVo);

			// STEP 1. CPU UPDATE
			// VO생성
			VmHardwareCpuVO vmCpu = new VmHardwareCpuVO();
			VmHardwareCpuSpecVO vmCpuSpec = new VmHardwareCpuSpecVO();

			// openstack에 socket부분 없음. default = 1
			vmCpuSpec.setCores_per_socket(1L);
			vmCpuSpec.setCount(Long.parseLong(req.getVcpus()));

			vmCpu.setSpec(vmCpuSpec);

			// API 호출
			vmHardwareCpu.updateCpu(vmCpu, vmId);

			// STEP 2. MEM UPDATE
			// VO생성
			VmHardwareMemVO vmMem = new VmHardwareMemVO();
			VmHardwareMemSpecVO vmMemSpec = new VmHardwareMemSpecVO();

			// openstack에 socket부분 없음. default = 1
			vmMemSpec.setSize_MiB((Integer.parseInt(req.getMemGb()) * 1024));

			vmMem.setSpec(vmMemSpec);

			// API 호출
			vmHardwareMem.updateMem(vmMem, vmId);

			// OSS 정보 Update
			this.sqlSessionTemplate.update(updateOssVm, req);

			/*
			 * for(int i = 0 ; i < count; i++) {
			 *
			 * Server server = serverIF.getServer(req.getVmUuid());
			 * log.debug("VM Status ================>>>>"+" VM UUID={}, Status={}",
			 * req.getVmUuid(), server.getStatus());
			 *
			 * if(server.getStatus().equals("VERIFY_RESIZE")){
			 * serverIF.actionServer(req.getVmUuid(), "confirmResize"); break; }
			 * Thread.sleep(30000); }
			 */

		} catch (NotConnectGatewayException | NotSupportGatewayException | InvaildOpenStackException
				| NullPointerException e) {

            logger.error("changeVM_vmWare Exception");

			req.setErrorStatus("PROVISIONING_FAIL");
			req.setErrorMsg(e.getMessage());
		}

		return req;
	}

	private CustomReqProductVO deleteVM_vmWare(CustomReqProductVO req, CustomOssCloudVO cloudVo) {
		String vmId = req.getVmUuid();
		String projectName = req.getProjectName();

		try {
			VmServerIF vmServerIF = VmAbstractFactory.getServerIF(cloudVo);

			// 1. API 호출
			vmServerIF.deleteServer(vmId);
			// 2. API 호출

			// OSS 정보 Update

			req.setDiskId(req.getImageId());
			this.sqlSessionTemplate.delete(deleteOssVm, req);
			this.sqlSessionTemplate.delete(deleteOssDisk, req);

		} catch (NotConnectGatewayException | NotSupportGatewayException | InvaildOpenStackException e) {

			logger.error("deleteVM_vmWare Exception");

			req.setErrorStatus("PROVISIONING_FAIL");
			req.setErrorMsg(e.getMessage());
		}
		return req;
	}

	private CustomReqProductVO vraCreateVM(CustomReqProductVO req, CustomOssCloudVO cloudVo) {
		vraServerIF vraServerIF = vraAbstractFactory.getServerIF(cloudVo);
		vraNetworkIF networkIF = vraAbstractFactory.getNetworkIF(cloudVo);
		vraDiskIF diskIF = vraAbstractFactory.getDiskIF(cloudVo);
		vraServerObject VraServerObject = new vraServerObject();
		String deploymentId = "";
		vraInputs vraServerInputs = new vraInputs();
		try {
			String catalogId = req.getVmImageId();
			if (req.getBackupNetworkFlag().equals("Y")) {
				vraServerInputs.setBackup("YES");
			} else {
				vraServerInputs.setBackup("NO");
			}
			VraServerObject.setDeploymentName(req.getHostname());
			// 추후 작업
			VraServerObject.setBulkRequestCount("1");
			VraServerObject.setReason("");
			VraServerObject.setProjectId(req.getProjectId());
			vraServerInputs.setDiskSize(req.getDiskGb());
			vraServerInputs.setFlavor(req.getFlavorId());
			// vraServerInputs.setImage(req.getVmImageName());
			vraServerInputs.setVmName(req.getHostname());

			List<CustomReqProductVO> getDataStores = this.sqlSessionTemplate.selectList(getDataStore, cloudVo);
			Collections.shuffle(getDataStores);
			for (CustomReqProductVO dataStore : getDataStores) {
				vraDataStoreContent ds = diskIF.getDataStore(dataStore.getDatastoreId());
				if (ds.getFreeSizeGB() > Integer.parseInt(req.getDiskGb())) {
					vraServerInputs.setDatastore(ds.getTags().get(0).getKey());
					break;
				}
			}
			vraServerInputs.setIp(req.getDefaultNetworkIp());
			vraServerInputs.setCluster(req.getAzName());
			vraServerInputs.setNetwork(req.getDefaultNetworkId());
			if (req.getBackupNetworkFlag().equals("Y")) {
				vraServerInputs.setBackupip(req.getBackupNetworkIp());
			} else {
				vraServerInputs.setBackupip("NULL");
			}
			VraServerObject.setInputs(vraServerInputs);

			vraRestResponse response = vraServerIF.createServer(VraServerObject, catalogId);
			Gson gson2 = new Gson();
			TypeToken<List<vraServerDeploy>> typeToken = new TypeToken<List<vraServerDeploy>>() {
			};
			List<vraServerDeploy> deploys = gson2.fromJson(response.getMessage(), typeToken.getType());
			for (vraServerDeploy deploy : deploys) {
				deploymentId = deploy.getDeploymentId();

				List<vraServerRequest> serverRequest = vraServerIF.getServerRequest(deploymentId, "").getContent();

				for (vraServerRequest server : serverRequest) {
					if (server.getName().equals("Create")) {
						while (!server.getStatus().equals("SUCCESSFUL")) {
							if (server.getStatus().equals("FAILED")) {
								req.setErrorStatus("PROVISIONING_FAIL");
								req.setErrorMsg(server.getDetails());
								if (!deploymentId.equals("")) {
									vraServerIF.deleteVm(deploymentId);
								}
								break;
							} else {
								server = vraServerIF.getServerRequest(deploymentId, server.getId());
								Thread.sleep(30000);
							}
						}
					}
				}
				// OSS_VM 저장

				vraServer depInfo = vraServerIF.getDepInfo(deploymentId);
				List<vraContent> contents = depInfo.getContent();
				for (vraContent content : contents) {
					if (content.getType().equals("Cloud.vSphere.Machine")) {
						CustomReqProductVO vm = new CustomReqProductVO();
						vm.setCloudId(cloudVo.getCloudId());
						vm.setVmUuid(deploymentId);
						vm.setProjectId(req.getProjectId());
						vm.setHostname(req.getHostname());
						vm.setHostnameAlias(req.getHostnameAlias());
						vm.setFlavorId(req.getFlavorId());
						vm.setVcpus(req.getVcpus());
						vm.setMemGb(req.getMemGb());
						vm.setDiskGb(req.getDiskGb());
						vm.setImageId(catalogId);
						vm.setVolumeType(req.getVolumeType());
						vm.setAzName(req.getAzName());
						vm.setVmProductSeq(req.getVmProductSeq());
						vm.setOsProductSeq(req.getOsProductSeq());
						vm.setVmCatalogSeq(req.getVmCatalogSeq());
						vm.setOrderUserId(req.getOrderUserId());
						vm.setCreateDatetime(req.getOnDemandFlag().equals("N") ? req.getApplyDatetime()
								: DateFormatUtils.format(new Date(), "yyyyMMddHHmmss"));
						vm.setRegUserId(CodeUtil.SYNC_ADMIN);
						insertOssVm(vm);

						// OSS_VM_NETWORK 저장
						BatchOssPortVO port = new BatchOssPortVO();
						List<vraNetworks> networkList = content.getProperties().getNetworks();
						for (vraNetworks network : networkList) {
							String portId = network.getName();
							String networkAry[] = network.getId().split("/");
							String networkId = networkAry[3];
							String subnetAry[] = networkIF.getComputeNetworks(network.getNetwork()).getSubnetLink()
									.split("/");
							String subnetId = subnetAry[3];
							vraNetworkInterfaces networkInterfaces = networkIF.getNetworks(content.getId(), networkId);
							if (!network.getName().equals("OA-Backup")) {
								vm.setNetworkId(portId);
								vm.setPortNetworkId(networkId);
								port.setPortId(networkId);
								port.setPortName(portId);
								port.setFixedIps(req.getDefaultNetworkIp());
								port.setMacAddress(network.getMac_address());
								port.setProjectId(req.getProjectId());
								port.setNetworkId(portId);
								port.setSubnetId(subnetId);
								port.setDeviceOwner(networkInterfaces.getOwner());
								port.setBindingHostId(networkInterfaces.getExternalRegionId());
								port.setDeviceId(deploymentId);
								port.setStatus("ACTIVE");
								insertOssPort(port);
							}
							if (req.getBackupNetworkFlag().equals("Y") && network.getName().equals("OA-Backup")) {
								vm.setBackupNetworkId(portId);
								vm.setPortBackupNetworkId(networkId);
								BatchOssPortVO backupPort = new BatchOssPortVO();
								backupPort.setPortId(networkId);
								backupPort.setPortName(portId);
								backupPort.setFixedIps(req.getBackupNetworkIp());
								backupPort.setMacAddress(network.getMac_address());
								backupPort.setProjectId(req.getProjectId());
								backupPort.setNetworkId(portId);
								backupPort.setDeviceId(deploymentId);
								backupPort.setSubnetId(subnetId);
								backupPort.setDeviceOwner(networkInterfaces.getOwner());
								backupPort.setBindingHostId(networkInterfaces.getExternalRegionId());
								backupPort.setStatus("ACTIVE");
								insertOssPort(backupPort);
							}
						}
						insertOssVmNetwork(vm);
						// port.setSubnetId(ipObj.getFixed_ips().get(0).getSubnet_id());
						// port.setDeviceOwner(ipObj.getDevice_owner());
						// port.setDeviceId(obj12.getId());

						vraDiskIF vraDiskIF = vraAbstractFactory.getDiskIF(cloudVo);
						vraMachineDisks machineDisks = vraDiskIF.getDiskInfo(content.getId());
						vraDiskContent diskContent = machineDisks.getContent().get(0);
						CustomReqProductVO disk = new CustomReqProductVO();
						disk.setDiskId(diskContent.getId());
						disk.setVmUuid(deploymentId);
						disk.setProjectId(req.getProjectId());
						disk.setDiskName(req.getHostname() + "-OS");
						disk.setDiskGb(req.getDiskGb());
						disk.setCreateDatetime(req.getOnDemandFlag().equals("N") ? req.getApplyDatetime()
								: DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss"));
						disk.setOrderUserId(req.getOrderUserId());
						disk.setDescription(req.getDescription());
						disk.setDiskCatalogSeq(req.getDiskCatalogSeq());
						disk.setDiskProductSeq(req.getDiskProductSeq());
						disk.setVolumeType(req.getVolumeType());

						this.sqlSessionTemplate.insert(insertOssDisk, disk);
					}
				}

			}

		} catch (Exception e) {

            logger.error("vraCreateVM Exception");

			if (!deploymentId.equals("")) {
				try {
					vraServerIF.deleteVm(deploymentId);
				} catch (NotConnectGatewayException | NotSupportGatewayException | InvaildOpenStackException e1) {
					req.setErrorStatus("PROVISIONING_FAIL");
					req.setErrorMsg(e.getMessage());
				}
			}
			req.setErrorStatus("PROVISIONING_FAIL");
			req.setErrorMsg(e.getMessage());
		}
		return req;
	}

	private CustomReqProductVO vraChangeVM(CustomReqProductVO req, CustomOssCloudVO cloudVo) {
		vraServerIF vraServerIF = vraAbstractFactory.getServerIF(cloudVo);
		vraServer depInfo;
		try {

			depInfo = vraServerIF.getDepInfo(req.getVmUuid());
			List<vraContent> contents = depInfo.getContent();
			for (vraContent content : contents) {
				if (content.getType().equals("Cloud.vSphere.Machine")) {
					String machineId = content.getId();
					String flavorId = req.getFlavorId();
					vraJsonObject res = vraServerIF.changeMachine(machineId, flavorId);
					vraJsonObject Tracker = vraServerIF.tracker(res.getId());
					while (!Tracker.getStatus().equals("FINISHED")) {
						Tracker = vraServerIF.tracker(res.getId());
						Thread.sleep(1500);
					}
					if (!Tracker.getMessage().equals("success")) {
						req.setErrorStatus("PROVISIONING_FAIL");
						req.setErrorMsg(Tracker.getMessage());
					} else {
						this.sqlSessionTemplate.update(updateOssVm, req);
					}
				}
			}
		} catch (Exception e) {
			log.error(e.getMessage());
			req.setErrorStatus("PROVISIONING_FAIL");
			req.setErrorMsg(e.getMessage());
		}
		return req;
	}

	private CustomReqProductVO vraDeleteVM(CustomReqProductVO req, CustomOssCloudVO cloudVo) {
		vraServerIF vraServerIF = vraAbstractFactory.getServerIF(cloudVo);
		vraDiskIF vraDiskIF = vraAbstractFactory.getDiskIF(cloudVo);
		try {
			String MachineId = "";
			vraServer depInfo = vraServerIF.getDepInfo(req.getVmUuid());
			List<vraContent> contents = depInfo.getContent();
			for (vraContent content : contents) {
				if (content.getType().equals("Cloud.vSphere.Machine")) {
					MachineId = content.getId();
				}
			}
			for (vraContent content : contents) {
				if (content.getType().equals("Cloud.Volume")) {
					vraJsonObject detach = vraServerIF.detachDisk(MachineId, content.getId());
					vraJsonObject blockTracker = vraDiskIF.blockTracker(detach.getId());
					while (!blockTracker.getStatus().equals("FINISHED")) {
						blockTracker = vraDiskIF.blockTracker(detach.getId());
						Thread.sleep(1500);
					}
					if (blockTracker.getMessage().equals("success")) {
						vraJsonObject deleteDisk = vraDiskIF.deleteDisk(content.getId());
						vraJsonObject blockTracker2 = vraDiskIF.blockTracker(deleteDisk.getId());
						while (!blockTracker2.getStatus().equals("FINISHED")) {
							blockTracker2 = vraDiskIF.blockTracker(deleteDisk.getId());
							Thread.sleep(1500);
						}
						if (!blockTracker2.getMessage().equals("Resource does not exist anymore")) {
							req.setErrorStatus("PROVISIONING_FAIL");
							req.setErrorMsg(blockTracker.getMessage());
						} else {
							this.sqlSessionTemplate.delete(deleteOssDisk, req);
						}
					}
				}
			}

			vraJsonObject res = vraServerIF.deleteVm(req.getVmUuid());
			this.sqlSessionTemplate.delete(deleteOssVm, req);
			this.sqlSessionTemplate.delete(deleteOssDiskVmUuid, req);
			this.sqlSessionTemplate.delete(deleteOssPort, req);
			if (req.getBackupNetworkFlag() == "Y") {
				if (deleteBackupIp(req, cloudVo) == true) {
					this.sqlSessionTemplate.delete(deleteOssPort, req);
				}
			}
		} catch (Exception e) {
			log.error(e.getMessage());
			req.setErrorStatus("PROVISIONING_FAIL");
			req.setErrorMsg(e.getMessage());
		}
		return req;
	}

	private CustomReqProductVO vraCreateDisk(CustomReqProductVO req, CustomOssCloudVO cloudVo) {
		vraServerIF vraServerIF = vraAbstractFactory.getServerIF(cloudVo);
		vraDiskIF vraDiskIF = vraAbstractFactory.getDiskIF(cloudVo);
		try {
			vraBlockDevice BlockDevice = new vraBlockDevice();
			BlockDevice.setCapacityInGB(req.getDiskGb());
			BlockDevice.setDeploymentId(req.getVmUuid());
			BlockDevice.setName(req.getDiskName());
			BlockDevice.setDescription(req.getDescription());
			BlockDevice.setProjectId(req.getProjectId());

			vraJsonObject res = vraDiskIF.createBlockDevice(BlockDevice);

			vraJsonObject blockTracker = vraDiskIF.blockTracker(res.getId());
			while (!blockTracker.getStatus().equals("FINISHED")) {
				blockTracker = vraDiskIF.blockTracker(res.getId());
				Thread.sleep(1500);
			}

			if (blockTracker.getMessage().equals("success")) {
				for (String id : blockTracker.getResources()) {
					String[] resIdary = id.split("/");
					String blockDiskId = resIdary[4];

					vraServer depInfo = vraServerIF.getDepInfo(req.getVmUuid());
					List<vraContent> contents = depInfo.getContent();
					for (vraContent content : contents) {
						if (content.getType().equals("Cloud.vSphere.Machine")) {
							String MachineId = content.getId();
							vraAttachDisk VraAttachDisk = new vraAttachDisk();
							VraAttachDisk.setBlockDeviceId(blockDiskId);
							VraAttachDisk.setName(req.getDiskName());
							VraAttachDisk.setDescription(req.getDescription());
							vraJsonObject res2 = vraDiskIF.attachDisk(VraAttachDisk, MachineId);

							vraJsonObject blockTracker2 = vraDiskIF.blockTracker(res2.getId());
							while (!blockTracker2.getStatus().equals("FINISHED")) {
								blockTracker2 = vraDiskIF.blockTracker(res2.getId());
								Thread.sleep(1500);
							}
							if (!blockTracker2.getMessage().equals("success")) {
								req.setErrorStatus("PROVISIONING_FAIL");
								req.setErrorMsg(blockTracker.getMessage());
							} else {
								vraBlockDevice blockDevice = vraDiskIF.getBlockDevice(blockDiskId);
								req.setStep("1");
								req.setDiskId(blockDevice.getId());
								req.setCreateDatetime(req.getOnDemandFlag().equals("N") ? req.getApplyDatetime()
										: DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss"));
								req.setVolumeType(req.getDiskType());
								this.sqlSessionTemplate.insert(insertOssDisk, req);
							}
						}
					}
				}
			} else {
				req.setErrorStatus("PROVISIONING_FAIL");
				req.setErrorMsg(blockTracker.getMessage());
			}
		} catch (Exception e) {
			log.error(e.getMessage());
			req.setErrorStatus("PROVISIONING_FAIL");
			req.setErrorMsg(e.getMessage());
		}

		return req;
	}

	private CustomReqProductVO vraChangeDisk(CustomReqProductVO req, CustomOssCloudVO cloudVo) {
		vraDiskIF vraDiskIF = vraAbstractFactory.getDiskIF(cloudVo);
		try {
			vraJsonObject res = vraDiskIF.changeDisk(req.getDiskId(), req.getDiskGb());
			vraJsonObject blockTracker = vraDiskIF.blockTracker(res.getId());
			while (!blockTracker.getStatus().equals("FINISHED")) {
				blockTracker = vraDiskIF.blockTracker(res.getId());
				Thread.sleep(1500);
			}
			if (!blockTracker.getMessage().equals("success")) {
				req.setErrorStatus("PROVISIONING_FAIL");
				req.setErrorMsg(blockTracker.getMessage());
			} else {
				this.sqlSessionTemplate.update(updateOssDisk, req);
			}
		} catch (Exception e) {
			log.error(e.getMessage());
			req.setErrorStatus("PROVISIONING_FAIL");
			req.setErrorMsg(e.getMessage());
		}
		return req;
	}

	private CustomReqProductVO vraDeleteDisk(CustomReqProductVO req, CustomOssCloudVO cloudVo) {
		vraServerIF vraServerIF = vraAbstractFactory.getServerIF(cloudVo);
		vraDiskIF vraDiskIF = vraAbstractFactory.getDiskIF(cloudVo);
		try {
			vraServer depInfo = vraServerIF.getDepInfo(req.getVmUuid());
			List<vraContent> contents = depInfo.getContent();
			for (vraContent content : contents) {
				if (content.getType().equals("Cloud.vSphere.Machine")) {
					String MachineId = content.getId();
					vraJsonObject detach = vraServerIF.detachDisk(MachineId, req.getDiskId());
					vraJsonObject blockTracker = vraDiskIF.blockTracker(detach.getId());
					while (!blockTracker.getStatus().equals("FINISHED")) {
						blockTracker = vraDiskIF.blockTracker(detach.getId());
						Thread.sleep(1500);
					}
					if (blockTracker.getMessage().equals("success")) {
						vraJsonObject deleteDisk = vraDiskIF.deleteDisk(req.getDiskId());
						vraJsonObject blockTracker2 = vraDiskIF.blockTracker(deleteDisk.getId());
						while (!blockTracker2.getStatus().equals("FINISHED")) {
							blockTracker2 = vraDiskIF.blockTracker(deleteDisk.getId());
							Thread.sleep(1500);
						}
						if (!blockTracker2.getMessage().equals("Resource does not exist anymore")) {
							req.setErrorStatus("PROVISIONING_FAIL");
							req.setErrorMsg(blockTracker.getMessage());
						} else {
							this.sqlSessionTemplate.delete(deleteOssDisk, req);
						}
					}
				}
			}
		} catch (Exception e) {
			log.error(e.getMessage());
			req.setErrorStatus("PROVISIONING_FAIL");
			req.setErrorMsg(e.getMessage());
		}
		return req;
	}

	private CustomOssProjectVO createProject(BatchProvisioningVO item) {

		CustomOssProjectVO projectVO = new CustomOssProjectVO();
		projectVO.setErrorStatus("PROVISIONING_SUCCESS");
		CustomReqProjectVO getProjectView = reqProjectService.getProjectView(item.getOrderProductSeq());
		projectVO.setRegUserId(getProjectView.getRegUserId());
		projectVO.setModUserId(getProjectView.getModUserId());
		projectVO.setCustomerId(getProjectView.getCustomerId());
		projectVO.setProjectManagerId(getProjectView.getProjectManagerId());
		projectVO.setProjectName(getProjectView.getReqProjectName());
		projectVO.setProjectAlias(getProjectView.getProjectAlias());
		projectVO.setDescription(getProjectView.getDescription());
		projectVO.setProjectDescription(getProjectView.getProjectDescription());
		projectVO.setProjectDeptCode(getProjectView.getProjectDeptCode());
		projectVO.setProjectPrice(getProjectView.getProjectPrice());
		projectVO.setProjectStartDatetime(getProjectView.getProjectStartDatetime());
		projectVO.setProjectEndDatetime(getProjectView.getProjectEndDatetime());
		projectVO.setReqProjectSeq(item.getOrderProductSeq());
		projectVO.setPaas(getProjectView.getPaas());
		projectVO.setCpuLimit(getProjectView.getCpuLimit());
		projectVO.setMemLimit(getProjectView.getMemLimit());
		projectVO.setCpuReq(getProjectView.getCpuReq());
		projectVO.setMemReq(getProjectView.getMemReq());
		projectVO.setVolumeReq(getProjectView.getVolumeReq());
		projectVO.setPodReq(getProjectView.getPodReq());
		String projectId = projectVO.getProjectId();
		String res = "";
		String sRet;

		try {

			// 신청시 선택한 클라우드  REQ_PROJECT_CLOUD  > OSS_PROJECT 테이블 데이터 생성
			List<CustomOssCloudVO> getCloudList = ossCloudService.getReqProjectCloudListByReqProjectSeqReApprove(item.getOrderProductSeq());
			String projectBoxUuid = UUID.randomUUID().toString();

			for (CustomOssCloudVO cloud : getCloudList) {
				String check = cloud.getProjectBoxId();

				if(check != null) {
					projectVO.setProjectBoxId(cloud.getProjectBoxId());
				}else {

					if( "".equals(projectVO.getProjectBoxId()) && projectVO.getProjectBoxId() == null) {
						projectVO.setProjectBoxId(projectBoxUuid);
					}

				}

				CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo(cloud.getCloudId());

				if (getProjectView.getQuotaYn().equals("Y") && cloudVo.getCloudType().equals("openshift")) {
					projectVO.setQuotaYn("Y");
				} else {
					projectVO.setQuotaYn("N");
				}

				projectVO.setCloudId(cloud.getCloudId());
				projectVO.setCloudType(cloud.getCloudType());
				if (cloudVo.getCloudType().equals("openstack")) {
					Project project = BatchProcessor.createProject(projectVO.getProjectName(), null, cloudVo);
					projectVO.setProjectId(project.getId());

					if(check == null && cloud.getSortNum().equals("1")) {
						projectVO.setProjectBoxId(project.getId());
					}

					sRet = dao.insert(projectVO) + "";
				} else if (cloudVo.getCloudType().equals("vmware")) {
					vraProjectObject project = BatchProcessor.vRaCreateProject(projectVO.getProjectName(), null,
							cloudVo);
					projectVO.setProjectId(project.getId());
					sRet = dao.insert(projectVO) + "";
				} else if (cloudVo.getCloudType().equals("openshift")) {

					String rfc1123Pattern = "[a-z0-9]([-a-z0-9]*[a-z0-9])?";
			        // 프로젝트 이름을 소문자로 변환 및 유효성 검사
			        String formattedName = projectVO.getProjectName().toLowerCase().replace('_', '-');

			        // 정규 표현식으로 검사
			        if (!formattedName.matches(rfc1123Pattern)) {
			            throw new IllegalArgumentException("Invalid project name: " + formattedName);
			        }

	                try {

	                	// 제약 사항 : dev, prod 각각 생성
                		String projectName = projectVO.getProjectName().toLowerCase();
                		Map<String, String> labels = new HashMap<>(); // label 추가

	                	for(int createCnt=0; createCnt < CodeUtil.CREATE_PAAS_ENV_PROJECT_COUNT; createCnt++) {
	                		if(createCnt != 0) {
	                			// 운영
	                			projectVO.setProjectName(projectName + CodeUtil.CREATE_PAAS_PORD_ENV);
	                			projectVO.setEnvType(CodeUtil.PROD_ENV_TYPE_CODE_ID);

								labels.put(CodeUtil.PROJECT_LABEL, CodeUtil.PROD_ENV_TYPE_CODE_ID.toLowerCase()); // (zone, prod)
	                		}else {
	                			// 개발
	                			projectVO.setProjectName(projectName + CodeUtil.CREATE_PAAS_DEV_ENV);
	                			projectVO.setEnvType(CodeUtil.DEV_ENV_TYPE_CODE_ID);

	                			labels.put(CodeUtil.PROJECT_LABEL, CodeUtil.DEV_ENV_TYPE_CODE_ID.toLowerCase()); // (zone, dev)
	                		}
	                		io.fabric8.openshift.api.model.Project project = opsApiOptionService.opsCreateProject(projectVO, null, cloudVo);

	                		CustomReqProjectVO customReqProjectVO = new CustomReqProjectVO();

	                		customReqProjectVO.setCloudId(cloudVo.getCloudId());
	                		customReqProjectVO.setReqProjectSeq(projectVO.getReqProjectSeq());

	                	// K-Cloud KEPCO CMP 포탈은 Quota 사용하지 않음.
//	   	                CustomReqProjectVO getProjectCloudQuota = reqProjectService.getReqProjectCloudQuota(customReqProjectVO);
//	   	                if(getProjectCloudQuota != null) {
//
//	   	                	if(getProjectCloudQuota.getQuotaYn().equals("Y")) {
//
//	   	                		Map<String, Quantity> quotaOptionName = new HashMap<>();
//	   	                		quotaOptionName.put( "pods", new Quantity( getProjectCloudQuota.getPodReq()));
//	   	                		quotaOptionName.put( "requests.cpu", new Quantity( getProjectCloudQuota.getCpuReq()));
//	   	                		quotaOptionName.put( "requests.memory", new Quantity( getProjectCloudQuota.getMemReq()));
//	   	                		quotaOptionName.put( "limits.cpu", new Quantity( getProjectCloudQuota.getCpuLimit()));
//	   	                		quotaOptionName.put( "limits.memory", new Quantity( getProjectCloudQuota.getMemLimit()));
////	   	                		quotaOptionName.put( "persistentvolumeclaims", new Quantity( getProjectCloudQuota.getVolumeReq()));
//
//	   	                		opsApiOptionService.createProjectQuota(cloudVo, quotaOptionName, projectVO.getProjectName());
//
//	   	                		Map<String, Quantity> addToMin = new HashMap<>();
//	   	                		Map<String, Quantity> addToMax = new HashMap<>();
//	   	                		LimitRangeItem limitRangeItem = new LimitRangeItem();
//	   	                		// Limit Pod 별
//	   	                		addToMin.put( "cpu", new Quantity(getProjectCloudQuota.getPodCpuMin()));
//	   	                		addToMax.put( "cpu", new Quantity( getProjectCloudQuota.getPodCpuMax()));
//	   	                		addToMin.put( "memory", new Quantity( getProjectCloudQuota.getPodMemMin()));
//	   	                		addToMax.put( "memory", new Quantity( getProjectCloudQuota.getPodMemMax()));
//
//	   	                		Map<String, Quantity> addLimitRangeToMin = new HashMap<>();
//	   	                		Map<String, Quantity> addLimitRangeToMax = new HashMap<>();
//	   	                		addLimitRangeToMin.put( "cpu", new Quantity( getProjectCloudQuota.getLimitRangeCpuMin()));
//	   	                		addLimitRangeToMin.put( "memory", new Quantity( getProjectCloudQuota.getLimitRangeMemMin()));
//
//	   	                		addLimitRangeToMax.put( "cpu", new Quantity( getProjectCloudQuota.getLimitRangeCpuMax()));
//	   	                		addLimitRangeToMax.put( "memory", new Quantity( getProjectCloudQuota.getLimitRangeMemMax()));
//
//	   	                		Map<String, Quantity> addLimitRangeRequest = new HashMap<>();
//	   	                		addLimitRangeRequest.put( "cpu", new Quantity( getProjectCloudQuota.getLimitRangeCpuDefaultRequest()));
//	   	                		addLimitRangeRequest.put( "memory", new Quantity( getProjectCloudQuota.getLimitRangeMemDefaultRequest()));
//
//	   	                		Map<String, Quantity> addLimitRangeRequestRatio = new HashMap<>();
//	   	                		addLimitRangeRequestRatio.put( "cpu", new Quantity( getProjectCloudQuota.getLimitRangeCpuLimitRequestRatio()));
////	   	                		addLimitRangeRequestRatio.put( "memory", new Quantity( getProjectCloudQuota.getLimitRangeMemLimitRequestRatio()));
//
//	   	                		Map<String, Quantity> addLimitRangeDefault = new HashMap<>();
//	   	                		addLimitRangeDefault.put( "cpu", new Quantity( getProjectCloudQuota.getLimitRangeCpuDefault()));
//	   	                		addLimitRangeDefault.put( "memory", new Quantity( getProjectCloudQuota.getLimitRangeMemDefault()));
//
//	   	                		opsApiOptionService.createProjectLimitRange(cloudVo, limitRangeItem, addToMax, addToMin,
//	   	                				addLimitRangeToMin, addLimitRangeToMax, addLimitRangeDefault,
//	   	                				addLimitRangeRequest, addLimitRangeRequestRatio, projectVO.getProjectName());
//	   	                	}
//	   	                }

	                		opsApiOptionService.createRoleBinding(projectVO.getProjectName(), cloudVo); //rolebinding 추가
	                		Thread.sleep(2000);
	                		opsApiOptionService.addLabelNamespace(projectVO.getProjectName(), cloudVo, labels); // label 추가

	                		projectVO.setProjectId(project.getMetadata().getUid());
	                		projectVO.setProjectName(projectName); // 원래 입력 받은 프로젝트 명으로 데이터 저장

	                		sRet = dao.insert(projectVO) + "";
	                	}
					} catch (Exception e) {
						log.error(e.getMessage());
						projectVO.setErrorStatus("PROVISIONING_FAIL");
						projectVO.setErrorMsg(e.getMessage());
					}

				} else if (cloudVo.getCloudType().equals("nutanix")) {

					CustomReqProjectVO customReqProjectVO = new CustomReqProjectVO();
					customReqProjectVO.setCloudId(cloudVo.getCloudId());
					customReqProjectVO.setReqProjectSeq(projectVO.getReqProjectSeq());
					CustomReqProjectVO getProjectCloudQuota = reqProjectService.getReqProjectCloudQuota(customReqProjectVO);
					List<CustomReqProjectVO> subnet_list= reqProjectService.getProjectSubnetList(customReqProjectVO);
					CustomReqProjectVO defaultSubnetInfo = reqProjectService.getProjectDefaultSubnet(customReqProjectVO);
					String default_subnet_uuid = defaultSubnetInfo.getSubnetId();


					String[] subnets = new String[subnet_list.size()];
					for (int i = 0; i < subnet_list.size(); i++) {
						subnets[i] = subnet_list.get(i).getSubnetId();
					}
					try {

						int vcpu_limit = Integer.valueOf(getProjectCloudQuota.getCpuReq());
						int memory_gb = Integer.valueOf(getProjectCloudQuota.getMemReq());
						int storage_gb = Integer.valueOf(getProjectCloudQuota.getStorageReq());

						NutanixObject project = NutanixUtils.createProjectBatch(cloudVo, projectVO.getProjectName(), projectVO.getProjectDescription(), default_subnet_uuid,  subnets,  vcpu_limit, memory_gb, storage_gb);

						log.info("project name : " + project.getObject("spec").getValue("name"));
						log.info("project uuid : " + project.getObject("metadata").getValue("uuid"));

						String uuid = (String) project.getObject("metadata").getValue("uuid");
						projectVO.setProjectId(uuid);
						sRet = dao.insert(projectVO) + "";

					} catch (Exception e) {
						log.error(e.getMessage());
						projectVO.setErrorStatus("PROVISIONING_FAIL");
						projectVO.setErrorMsg(e.getMessage());
					}
				}
			}

		} catch (NotConnectGatewayException | NotSupportGatewayException | InvaildOpenStackException e) {
			projectVO.setErrorStatus("PROVISIONING_FAIL");
			projectVO.setErrorMsg(e.getMessage());
		}

		// projectBoxInsert  oa망 project Id = projectBoxId 요청 변경
		int chkVal = service.projectBoxIdChk(projectVO);
		if(chkVal == 0){
			sRet = dao.boxInsert(projectVO) + "";
		}

		CustomReqProjectVO CustomReqProjectVO = new CustomReqProjectVO();
		CustomReqProjectVO.setReqProjectSeq(projectVO.getReqProjectSeq());

		reqProjectService.updateReqProjectCompeteFlag(CustomReqProjectVO);

		List<CustomReqCustomerVO> managerList = reqProjectService.reqManagerList(projectVO.getReqProjectSeq());
		for (CustomReqCustomerVO vo : managerList) {

			vo.setProjectId(projectVO.getProjectBoxId());
			try {
				res = service.insertManager(vo);
			} catch (NotSupportGatewayException e) {
				projectVO.setErrorStatus("PROVISIONING_FAIL");
				projectVO.setErrorMsg(e.getMessage());
			}
		}
		return projectVO;
	}

	private CustomReqProductVO nutanixCreateVM(CustomReqProductVO req, CustomOssCloudVO cloudVo) throws Exception {


		String marketplace_item_uuid = req.getVmImageId();
		String project_uuid = req.getProjectId();
		String vm_name = req.getHostname();
		String ipaddress = req.getDefaultNetworkIp();
		String gatewayadress = req.getGatewayIp();
		String subnet_uuid = req.getDefaultNetworkId();



		String dns1 = "";
	    String dns2 = "";

		if(!req.getDnsNameservers().equals("[]")) {

		   String dnsInfo[] = req.getDnsNameservers().split(",");

		   if(dnsInfo.length == 2) {
			   dns1 =  dnsInfo[0];
			   dns2 =  dnsInfo[1];

		   }else if(dnsInfo.length == 1) {
			   dns1 =  dnsInfo[0];
		   }
		}



		int vcpu = Integer.parseInt(req.getVcpus());

		//뉴타닉스 2코어
		int num_vcpus_nutanix = vcpu / 2;


		int mem_gb = Integer.parseInt(req.getMemGb());
		int disk_gb = Integer.parseInt(req.getDiskGb());
		int mem_mb = mem_gb * 1024;

		NutanixObject app = NutanixUtils.simpleLaunchBatch(cloudVo, marketplace_item_uuid, project_uuid, vm_name, ipaddress, gatewayadress, dns1, dns2, num_vcpus_nutanix,  mem_mb, disk_gb, subnet_uuid);


		String vm_uuid = app.getVmUuid();
		String application_uuid = app.getUuid();

		// vm 정보 get
      	NutanixObject vmdetail = NutanixUtils.getVmDetail(cloudVo, vm_uuid);
      	String host_uuid = (String) vmdetail.getValue("host_uuid");
      	String fixed_ips = (String) vmdetail.getArray("vm_nics", null).get(0).getValue("ip_address");
      	String mac_address = (String) vmdetail.getArray("vm_nics", null).get(0).getValue("mac_address");
      	String power_state = (String) vmdetail.getValue("power_state");






		try {
				CustomReqProductVO vm = new CustomReqProductVO();
				vm.setCloudId(cloudVo.getCloudId());
				vm.setVmUuid(vm_uuid);
				vm.setApplicationUuid(application_uuid);

				vm.setHostUuid(host_uuid);
				vm.setPowerState(power_state);
				vm.setProjectId(req.getProjectId());
				vm.setHostname(req.getHostname());
				vm.setHostnameAlias(req.getHostnameAlias());
				vm.setFlavorId(req.getFlavorId());
				vm.setVcpus(req.getVcpus());
				vm.setMemGb(req.getMemGb());
				vm.setDiskGb(req.getDiskGb());
				vm.setVolumeType(req.getVolumeType());
				vm.setAzName(req.getAzName());
				vm.setVmProductSeq(req.getVmProductSeq());
				vm.setOsProductSeq(req.getOsProductSeq());
				vm.setVmCatalogSeq(req.getVmCatalogSeq());
				vm.setOrderUserId(req.getOrderUserId());
				vm.setCreateDatetime(req.getOnDemandFlag().equals("N") ? req.getApplyDatetime()
						: DateFormatUtils.format(new Date(), "yyyyMMddHHmmss"));
				vm.setRegUserId(CodeUtil.SYNC_ADMIN);
				insertOssVm(vm);



				// OSS_PORT 정보저장
				BatchOssPortVO port = new BatchOssPortVO();
				String uuid = UUID.randomUUID().toString();
				port.setPortId(uuid);
				port.setPortName(ipaddress);
				port.setFixedIps(ipaddress);
				port.setDeviceId(vm_uuid);
				port.setProjectId(req.getProjectId());
				port.setNetworkId(subnet_uuid);
				port.setMacAddress(mac_address);
				insertOssPort(port);


				// OSS_VM_NETWORK 저장
				vm.setNetworkId(subnet_uuid);
				vm.setDefaultNetworkName(req.getDefaultNetworkName());
				vm.setDefaultNetworkAlias(req.getDefaultNetworkAlias());
				insertOssVmNetwork(vm);


				NutanixObject vmDiskList = vmdetail.getVDisks().get(0);


				String vmdisk_uuid  = (String) vmDiskList.getObject("disk_address").getValue("vmdisk_uuid");
				String device_uuid = (String) vmDiskList.getObject("disk_address").getValue("device_uuid");
				String device_bus = (String) vmDiskList.getObject("disk_address").getValue("device_bus");
				String storage_container_uuid = (String) vmDiskList.getValue("storage_container_uuid");

				req.setDiskId(vmdisk_uuid);
				req.setDiskName(req.getHostname()+ "-OS");
				req.setVmUuid(vm_uuid);
                req.setDeviceUuid(device_uuid);
                req.setStorageContainerUuid(storage_container_uuid);
				req.setProjectId(req.getProjectId());
				req.setDiskGb(req.getDiskGb());
				req.setOrderUserId(req.getOrderUserId());
				req.setDescription(req.getDescription());
//							req.setDiskCatalogSeq(req.getDiskCatalogSeq());
//							req.setDiskProductSeq(req.getDiskProductSeq());
				req.setCreateDatetime(req.getOnDemandFlag().equals("N") ? req.getApplyDatetime()
						: DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss"));
				req.setVolumeType(device_bus);
				this.sqlSessionTemplate.insert(insertOssDisk, req);


		} catch (Exception e) {

            logger.error("nutanixCreateVM Exception");

			req.setErrorStatus("PROVISIONING_FAIL");
			req.setErrorMsg(e.getMessage());
		}

		return req;
	}


	private CustomReqProductVO nutanixCreateDisk(CustomReqProductVO req, CustomOssCloudVO cloudVo) throws Exception {

		try {
			CustomReqProductVO res = new CustomReqProductVO();
			String vm_uuid = req.getVmUuid();
			String storage_container_uuid = null;
			long diskGb = Long.parseLong(req.getDiskGb());
			long mb_size = diskGb*1024;

			NutanixObject vmdetail = NutanixUtils.getVmDetail(cloudVo, vm_uuid);

			List<NutanixObject> vmDisk = vmdetail.getVDisks();

			for (NutanixObject nutanix : vmDisk) {
				boolean is_cdrom =   (boolean) nutanix.getValue("is_cdrom");
				if(is_cdrom == false) {
					storage_container_uuid = (String)nutanix.getValue("storage_container_uuid");
				}
                if(storage_container_uuid != null) {
                	break;
                }
			}

			NutanixObject attachDiskResult = NutanixUtils.attachDisk(cloudVo, vm_uuid, storage_container_uuid, mb_size);

			String result = (String) attachDiskResult.getValue("task_uuid");
			if (!NutanixUtils.waitSucceeded(cloudVo, result, vm_uuid)) {
				log.warn("생성시간초과시 처리 ");
			}

			Thread.sleep(30000);

			NutanixObject reSearchVmdetail = NutanixUtils.getVmDetail(cloudVo, vm_uuid);

			List<NutanixObject> vmDiskList = reSearchVmdetail.getVDisks();


			if(result != null) {
				for (NutanixObject nutanix : vmDiskList) {

					String vmdisk_uuid  = (String) nutanix.getObject("disk_address").getValue("vmdisk_uuid");
					String device_uuid = (String) nutanix.getObject("disk_address").getValue("device_uuid");
					boolean is_cdrom =   (boolean) nutanix.getValue("is_cdrom");


					res = this.sqlSessionTemplate.selectOne(getOssDiskAt, vmdisk_uuid);

					if(res == null && is_cdrom == false) {
						req.setDiskId(vmdisk_uuid);
						req.setDiskAlias(req.getDiskName());
						req.setVmUuid(vm_uuid);
                        req.setDeviceUuid(device_uuid);
                        req.setStorageContainerUuid(storage_container_uuid);
						req.setProjectId(req.getProjectId());
						req.setDiskGb(req.getDiskGb());
						req.setDiskName(req.getDiskName()) ;
						req.setOrderUserId(req.getOrderUserId());
						req.setDescription(req.getDescription());
						req.setDiskCatalogSeq(req.getDiskCatalogSeq());
						req.setDiskProductSeq(req.getDiskProductSeq());
						req.setCreateDatetime(req.getOnDemandFlag().equals("N") ? req.getApplyDatetime()
								: DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss"));
						req.setVolumeType(req.getDiskType());

						this.sqlSessionTemplate.insert(insertOssDisk, req);
					}
				 }
		 }

		} catch (Exception e) {
			log.error(e.getMessage());
			req.setErrorStatus("PROVISIONING_FAIL");
			req.setErrorMsg(e.getMessage());
		}

		return req;
	}


	private CustomReqProductVO nutanixChangeDisk(CustomReqProductVO req, CustomOssCloudVO cloudVo) {

        String vm_uuid = req.getVmUuid();
        String vmdisk_uuid = req.getDiskId();
        String device_uuid = req.getDeviceUuid();
        String storage_container_uuid = req.getStorageContainerUuid();
        long diskGb = Long.parseLong(req.getDiskGb());
		long mb_size = diskGb*1024;

		NutanixObject nutanixUpdateDiskObject;
		try {
			nutanixUpdateDiskObject = NutanixUtils.updateDisk(cloudVo, vm_uuid, vmdisk_uuid, device_uuid, storage_container_uuid, mb_size);

			if (!NutanixUtils.waitSucceeded(cloudVo, (String) nutanixUpdateDiskObject.getValue("task_uuid") , vm_uuid)) {
				log.warn("생성시간초과시 처리 ");
			}

				this.sqlSessionTemplate.update(updateOssDisk, req);

		} catch (Exception e) {
			log.error(e.getMessage());
			req.setErrorStatus("PROVISIONING_FAIL");
			req.setErrorMsg(e.getMessage());
		}
		return req;
	}


	private CustomReqProductVO nutanixDeleteDisk(CustomReqProductVO req, CustomOssCloudVO cloudVo) {

		String vm_uuid = req.getVmUuid();
		String vmdisk_uuid = req.getDiskId();
		String device_uuid = req.getDeviceUuid();
		String host_uuid = req.getHostUuid();

		try {

			NutanixObject powerStateOff = NutanixUtils.updateVmPowerState(cloudVo, vm_uuid, host_uuid, NutanixPowerState.OFF);
			if (!NutanixUtils.waitSucceeded(cloudVo, (String) powerStateOff.getValue("task_uuid") , vm_uuid)) {
				log.warn("생성시간초과시 처리 ");
			}
			Thread.sleep(10000);

			NutanixObject nutanixDetachDiskObject = NutanixUtils.detachDisk(cloudVo, vm_uuid, vmdisk_uuid, device_uuid);
			if (!NutanixUtils.waitSucceeded(cloudVo, (String) nutanixDetachDiskObject.getValue("task_uuid") , vm_uuid)) {
				log.warn("생성시간초과시 처리 ");
			}
			Thread.sleep(20000);

			this.sqlSessionTemplate.delete(deleteOssDisk, req);

			NutanixObject powerStateOn = NutanixUtils.updateVmPowerState(cloudVo, vm_uuid, host_uuid, NutanixPowerState.ON);
			if (!NutanixUtils.waitSucceeded(cloudVo, (String) powerStateOn.getValue("task_uuid") , vm_uuid)) {
				log.warn("생성시간초과시 처리 ");
			}


		} catch (Exception e) {
			log.error(e.getMessage());
			req.setErrorStatus("PROVISIONING_FAIL");
			req.setErrorMsg(e.getMessage());
		}


		return req;
	}

	private CustomReqProductVO nutanixDeleteVM(CustomReqProductVO req, CustomOssCloudVO cloudVo) {

		String app_uuid = req.getApplicationUuid();
		String host_uuid = req.getHostUuid();
		String vm_uuid = req.getVmUuid();

		try {

			NutanixObject powerStateOff = NutanixUtils.updateVmPowerState(cloudVo, vm_uuid, host_uuid, NutanixPowerState.OFF);
			if (!NutanixUtils.waitSucceeded(cloudVo, (String) powerStateOff.getValue("task_uuid") , vm_uuid)) {
				log.warn("생성시간초과시 처리 ");
			}
			Thread.sleep(10000);


			NutanixObject nutanixObject = NutanixUtils.deleteApp(cloudVo, app_uuid);
			if (!NutanixUtils.waitSucceeded(cloudVo, (String) nutanixObject.getObject("status").getValue("ergon_task_uuid") , app_uuid)) {
				log.warn("생성시간초과시 처리 ");
			}


		    	this.sqlSessionTemplate.delete(deleteOssVm, req);
		    	this.sqlSessionTemplate.delete(deleteOssDiskVmUuid, req);

		} catch (Exception e) {

			logger.error("nutanixDeleteVM Exception");

			req.setErrorStatus("PROVISIONING_FAIL");
			req.setErrorMsg(e.getMessage());
		}
		return req;
	}

	private CustomReqProductVO nutanixChangeVM(CustomReqProductVO req, CustomOssCloudVO cloudVo) {

		try {
			String vm_uuid = req.getVmUuid();
			String host_uuid = req.getHostUuid();
			int memory_gb =  Integer.parseInt(req.getMemGb());
			int memory_mb = memory_gb*1024;
			int num_vcpus =  Integer.parseInt(req.getVcpus());

			//뉴타닉스 2코어
			int num_vcpus_nutanix = num_vcpus / 2;


			NutanixObject nutanixPowerStateOff = NutanixUtils.updateVmPowerState(cloudVo, vm_uuid, host_uuid, NutanixPowerState.OFF);

			if (!NutanixUtils.waitSucceeded(cloudVo, (String) nutanixPowerStateOff.getValue("task_uuid") , vm_uuid)) {
				log.warn("생성시간초과시 처리 ");
			}

			Thread.sleep(10000);

			NutanixObject nutanixVcpus = NutanixUtils.updateVmVcpus(cloudVo, vm_uuid, num_vcpus_nutanix);

			if (!NutanixUtils.waitSucceeded(cloudVo, (String) nutanixVcpus.getValue("task_uuid") , vm_uuid)) {
				log.warn("생성시간초과시 처리 ");
			}

			Thread.sleep(10000);

			NutanixObject nutanixVmMemory = NutanixUtils.updateVmMemory(cloudVo, vm_uuid, memory_mb);

			if (!NutanixUtils.waitSucceeded(cloudVo, (String) nutanixVmMemory.getValue("task_uuid") , vm_uuid)) {
				log.warn("생성시간초과시 처리 ");
			}

			Thread.sleep(10000);

			NutanixObject nutanixPowerStateOn = NutanixUtils.updateVmPowerState(cloudVo, vm_uuid, host_uuid, NutanixPowerState.ON);
			if (!NutanixUtils.waitSucceeded(cloudVo, (String) nutanixPowerStateOn.getValue("task_uuid") , vm_uuid)) {
				log.warn("생성시간초과시 처리 ");
			}

			Thread.sleep(10000);


				this.sqlSessionTemplate.update(updateOssVm, req);

		} catch (Exception e) {
			log.error(e.getMessage());
			req.setErrorStatus("PROVISIONING_FAIL");
			req.setErrorMsg(e.getMessage());
		}
		return req;
	}

}
