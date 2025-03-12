package com.ivucenter.cloud.portal.project.quota;


import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;
import com.ivucenter.cloud.api.common.batch.BatchProcessor;
import com.ivucenter.cloud.api.openshift.object.OpsApiOptionService;
import com.ivucenter.cloud.api.openstack.OpenStackUsage;
import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.api.openstack.object.OpenStackComplexQuota;
import com.ivucenter.cloud.entity.OssAvailabilityVO;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;
import com.ivucenter.cloud.portal.cmm.cloud.OssCloudService;
import com.ivucenter.cloud.portal.oss.project.CustomOssProjectVO;
import com.ivucenter.cloud.portal.oss.project.OssProjectService;
import com.ivucenter.cloud.portal.req.project.CustomReqProjectVO;
import com.ivucenter.cloud.portal.req.project.ReqProjectService;

import io.fabric8.kubernetes.api.model.Quantity;
import lombok.extern.slf4j.Slf4j;


/**
 * @author 박진우
 */
@Slf4j
@Service
public class ProjectQuotaService{

    private static final Logger logger = LoggerFactory.getLogger(ProjectQuotaService.class);

	@Autowired
	private ProjectQuotaDAO dao;

	@Autowired
	private OssCloudService ossCloudService;

	@Autowired
	private ReqProjectService reqProjectService;

	@Autowired
	OssProjectService ossProjectService;

	@Autowired
	OpsApiOptionService opsApiOptionService;


	public OpenStackComplexQuota detail(CustomQuotaVO req) {
		Assert.notNull(req.getProjectId(), "Proejct ID is null");
		Assert.notNull(req.getCloudId(), "cloud ID is null");

		OpenStackComplexQuota res = new OpenStackComplexQuota();
		try {
			CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo(req.getCloudId());

			if(cloudVo.getCloudType().equals("openstack")) {
				res = BatchProcessor.getQuota(req.getProjectId(),cloudVo);
			}else if(cloudVo.getCloudType().equals("vmware")) {
				res = BatchProcessor.vraGetQuota(req.getProjectId(),cloudVo);
			}else if(cloudVo.getCloudType().equals("openshift")) {
				try {
					CustomOssProjectVO customOssProjectVO = new CustomOssProjectVO();
					customOssProjectVO.setProjectId( req.getProjectId());
					customOssProjectVO = ossProjectService.getOssProjectName(customOssProjectVO);
					res = opsApiOptionService.openShiptGetNodeInfo(req.getProjectId(), cloudVo, customOssProjectVO);
					res = opsApiOptionService.openShiptGetNodeAvailable( res);

				}catch (Exception e) {
					logger.error("JSON 처리 중 오류 발생");
				}
			}
		} catch (NotConnectGatewayException | NotSupportGatewayException | InvaildOpenStackException e) {
			log.error(e.getMessage());
			res.setErrorMsg(e.getMessage());
		}
	    return res;
	}

	public String cloudDetail(CustomQuotaVO req) {
		Assert.notNull(req.getProjectBoxId(), "Proejct BoxID is null");

		List<OpenStackComplexQuota> res = new LinkedList<OpenStackComplexQuota>();
		CustomOssProjectVO project = new CustomOssProjectVO();

		project.setProjectBoxId(req.getProjectBoxId());
		project.setCloudType( req.getCloudType());


		List<CustomOssProjectVO> cloudProjectInfo = reqProjectService.cloudProjectInfo(project);
		for(CustomOssProjectVO projectVo : cloudProjectInfo) {
			try {
				CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo(projectVo.getCloudId());
				OpenStackComplexQuota response = new OpenStackComplexQuota();
				if(cloudVo.getCloudType().equals("openstack")) {
					response = BatchProcessor.getQuota(projectVo.getProjectId(),cloudVo);
				}else if(cloudVo.getCloudType().equals("vmware")) {
					response = BatchProcessor.vraGetQuota(projectVo.getProjectId(),cloudVo);
				}else if( cloudVo.getCloudType().equals("openshift")) {
					try {
						response = opsApiOptionService.openShiptGetNodeInfo(projectVo.getProjectId(), cloudVo, projectVo);
					}catch (Exception e) {
						logger.error("opsApiOptionService.openShiptGetNodeInfo Exception");
					}
				}else if(cloudVo.getCloudType().equals("nutanix")) {
					CustomReqProjectVO CustomReqProjectVO  = new CustomReqProjectVO();


					CustomReqProjectVO.setProjectId(projectVo.getProjectId());
					CustomReqProjectVO.setCloudId(projectVo.getCloudId());

					CustomReqProjectVO   = reqProjectService.getReqProjectQuota(CustomReqProjectVO);

					response.setRam(Integer.parseInt(CustomReqProjectVO.getMemReq()));
					response.setCores(Integer.parseInt(CustomReqProjectVO.getCpuReq()));
					response.setGigabytes(Integer.parseInt(CustomReqProjectVO.getStorageReq()));

				}

				if( response != null) {

					response.setProjectId(projectVo.getProjectId());
					response.setCloudId(projectVo.getCloudId());
					response.setCloudName(projectVo.getCloudName());
					response.setCloudType(projectVo.getCloudType());

					res.add(response);
				}
			} catch (NotConnectGatewayException | NotSupportGatewayException | InvaildOpenStackException e) {
				log.error(e.getMessage());
			}
		}
		int recordsTotal = cloudProjectInfo.size();
    	int recordsFiltered = recordsTotal;
    	JsonObject jsonResponse = new JsonObject();
        Gson gson = new Gson();

        jsonResponse.addProperty("draw", req.getDraw());
        jsonResponse.addProperty("recordsTotal", recordsTotal);
        jsonResponse.addProperty("recordsFiltered", recordsFiltered);
        jsonResponse.add("data", gson.toJsonTree(res));

        return jsonResponse.toString();
	}

	public CustomQuotaVO getDetaildb(CustomQuotaVO req) {
		CustomQuotaVO res = dao.getDetail(req);
	    return res;
	}


	public OpenStackComplexQuota update(OpenStackComplexQuota req) {

		OpenStackComplexQuota res = new OpenStackComplexQuota();
		try {
			CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo(req.getCloudId());
			if(cloudVo.getCloudType().equals("openstack")) {
				req.setRam(req.getRam()*1024);

				res = BatchProcessor.updateQuota(req.getProjectId(), req,cloudVo);
			} else if( cloudVo.getCloudType().equals("vmware")) {
				req.setRam(req.getRam()*1024);

				res = BatchProcessor.vraUpdateQuota(req.getProjectId(), req,cloudVo);
			} else if( cloudVo.getCloudType().equals("openshift")) {

				Map<String, Quantity> quotaOptionName = new HashMap();

				quotaOptionName.put( "limits.memory", new Quantity( req.getParamLimitMemory()));
				quotaOptionName.put( "limits.cpu", new Quantity( req.getParamLimitCpu()));
				quotaOptionName.put( "persistentvolumeclaims", new Quantity( req.getParamPv()));
				quotaOptionName.put( "pods", new Quantity( req.getParamPod()));
				quotaOptionName.put( "requests.cpu", new Quantity( req.getParamRequestCpu()));
				quotaOptionName.put( "requests.memory", new Quantity( req.getParamRequestMemory()));


				opsApiOptionService.projectQuotaUpdate(cloudVo, quotaOptionName, req.getProjectName());



			}




			res.setErrorMsg("1");
		} catch (NotConnectGatewayException | NotSupportGatewayException | InvaildOpenStackException e) {
			log.error(e.getMessage());
			res.setErrorMsg(e.getMessage());
		}
	    return res;
	}

	public String list(CustomQuotaVO req) {

		List<CustomQuotaVO> list = dao.getQuotaList(req);

		int recordsTotal = dao.listTot(req);
		int recordsFiltered = recordsTotal;

		try {
			JsonObject jsonResponse = new JsonObject();
			Gson gson = new Gson();

			jsonResponse.addProperty("length",req.getDraw());
			jsonResponse.add("data", gson.toJsonTree(list));
			jsonResponse.addProperty("recordsTotal", recordsTotal);
			jsonResponse.addProperty("recordsFiltered", recordsFiltered);
			return jsonResponse.toString();
		} catch (JsonIOException e) {
			log.error(e.getMessage());
		}

		return "";

	}

	public List<CustomQuotaVO> excel(CustomQuotaVO req) {
		List<CustomQuotaVO> list = dao.listTotExcel(req);
		return list;
	}

	public CustomQuotaVO getQuota(CustomQuotaVO req){
		CustomQuotaVO list = dao.getQuota(req);
		return list;
	}

	public String batchDeleteOssAvailability(CustomOssCloudVO req) {
		return dao.batchDeleteOssAvailability(req)+"";
	}

	public String batchInsertOssAvailability(OssAvailabilityVO availVO) {
		return dao.batchInsertOssAvailability(availVO)+"";
	}


	public List<OpenStackUsage> openshftOssOpenshiftAvailability(CustomOssCloudVO cloud){
		List<OpenStackUsage> list = dao.openshftOssOpenshiftAvailability(cloud);
		return list;
	}
	public List<OpenStackUsage> openshftOssNutanixAvailability(CustomOssCloudVO cloud){
		List<OpenStackUsage> list = dao.openshftOssNutanixAvailability(cloud);
		return list;
	}

}
