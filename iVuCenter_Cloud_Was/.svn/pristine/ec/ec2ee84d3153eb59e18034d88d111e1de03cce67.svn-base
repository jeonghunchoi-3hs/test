package com.ivucenter.cloud.api.openshift.object;

import java.util.List;
import java.util.Map;

import com.ivucenter.cloud.api.openstack.object.OpenStackComplexQuota;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;
import com.ivucenter.cloud.portal.oss.project.CustomOssProjectVO;
import com.ivucenter.cloud.portal.req.product.CustomReqProductVO;

import io.fabric8.kubernetes.api.model.KubernetesList;
import io.fabric8.kubernetes.api.model.LimitRange;
import io.fabric8.kubernetes.api.model.LimitRangeItem;
import io.fabric8.kubernetes.api.model.PodList;
import io.fabric8.kubernetes.api.model.Quantity;
import io.fabric8.kubernetes.api.model.ResourceQuota;
import io.fabric8.kubernetes.api.model.ServiceList;
import io.fabric8.kubernetes.api.model.ServicePort;
import io.fabric8.kubernetes.api.model.autoscaling.v1.HorizontalPodAutoscaler;
import io.fabric8.openshift.api.model.BuildList;
import io.fabric8.openshift.api.model.DeploymentConfig;
import io.fabric8.openshift.api.model.DeploymentConfigList;
import io.fabric8.openshift.api.model.Project;
import io.fabric8.openshift.api.model.Route;
import io.fabric8.openshift.api.model.RouteList;
import io.fabric8.openshift.api.model.Template;
import io.fabric8.openshift.api.model.TemplateList;
import io.fabric8.openshift.api.model.monitoring.v1.PodMonitorList;

public interface OpsMethodApiInter {
	//삭제
	public void deleteProjectQuota(CustomOssCloudVO cloudVo, String namespace, String quotaName);

	//리스트
	public List listProjectQuota(CustomOssCloudVO cloudVo, String namespace);

	//단일
	public ResourceQuota singleProjectQuotaReturn(CustomOssCloudVO cloudVo, String namespace, String quotaName);

	//수정
	public void replaceProjectQuota(CustomOssCloudVO cloudVo,Map<String, Quantity> quotaOption, String namespace, String quotaName);

	//생성
	public ResourceQuota createProjectQuota(CustomOssCloudVO cloudVo, Map<String, Quantity> quotaOption, String namespace);


	public String quotaNameReturn( String project_name);

	public OpenStackComplexQuota nodeLimitUpdate(String project_id, CustomOssCloudVO cloudVo,
				OpenStackComplexQuota req);
	/**
	 *
	 * @title openShiptNode[Application]createApplication
	 * @developer smhong
	 * @param req
	 * @param cloudVo
	 * @return
	 */
	public KubernetesList opsCreateApplication(CustomReqProductVO req, CustomOssCloudVO cloudVo);

	public Map opsCreateApplicationMap(CustomReqProductVO req, CustomOssCloudVO cloudVo);

	/**
	 *
	 * @title openShiptNode[Project]createProject
	 * @developer smhong
	 * @param projectVO
	 * @param object
	 * @param cloudVo
	 * @return
	 */
	public Project opsCreateProject(CustomOssProjectVO projectVO, Object object, CustomOssCloudVO cloudVo);

	public OpenStackComplexQuota openShiptGetNodeAvailable(OpenStackComplexQuota openStackComplexQuota);

	public void updateResourceQuota(String project_name, String project_quota, OpenStackComplexQuota req, CustomOssCloudVO cloudVo);
	/**
	 *
	 * @title openShiptNode[Template]getTemplate
	 * @developer smhong
	 * @param cloudVo
	 * @param templateName
	 * @param templateNameSpace
	 * @return
	 */
	public Template getTemplate(CustomOssCloudVO cloudVo, String templateName, String templateNameSpace);
	/**
	 *
	 * @title openShiptNode[Template]getTemplates
	 * @developer smhong
	 * @date 2021. 07. 01
	 * @param cloudVo
	 * @return
	 * @throws Exception
	 *
	 */
	public TemplateList getTemplates(CustomOssCloudVO cloudVo) throws Exception;

	/**
	 * @title openShiptNode[Pod]getPodList
	 * @developer smhong
	 * @date 2021. 07. 09
	 * @param cloudVo
	 * @param nameSpace
	 * @return
	 */
	public DeploymentConfigList getDeploymentConfigList(CustomOssCloudVO cloudVo, String nameSpace);

	/**
	 * @title openShiptNode[Pod]getPodList
	 * @developer smhong
	 * @date 2021. 07. 01
	 * @param cloudVo
	 * @param nameSpace
	 * @param name
	 * @return
	 */
	public PodList getPodList(CustomOssCloudVO cloudVo, String nameSpace);

	/**
	 * @title openShiptNode[Build]getBuildList
	 * @developer smhong
	 * @date 2021. 07. 01
	 * @param cloudVo
	 * @param nameSpace
	 * @param name
	 * @return
	 */
	public BuildList getBuildList(CustomOssCloudVO cloudVo, String nameSpace);

	/**
	 * @title openShiptNode[Service]getServiceList
	 * @developer smhong
	 * @date 2021. 07. 05
	 * @param cloudVo
	 * @param nameSpace
	 * @param name
	 * @return
	 */
	public ServiceList getServiceList(CustomOssCloudVO cloudVo, String nameSpace);

	/**
	 * @title openShiptNode[Route]getRouteList
	 * @developer smhong
	 * @date 2021. 07. 05
	 * @param cloudVo
	 * @param nameSpace
	 * @param name
	 * @return
	 */
	public RouteList getRouteList(CustomOssCloudVO cloudVo, String nameSpace);

	public DeploymentConfig getDeploymentConfig(CustomOssCloudVO cloudVo, String nameSpace, String appName);

	public void applicationDelete(CustomOssCloudVO cloudVo, String nameString, String name) throws Exception;

	public Route getRoute(CustomOssCloudVO cloudVo, String nameSpace, String name);

	public ServiceList getService(CustomOssCloudVO cloudVo, String nameSpace, String name);

	public ServicePort getServicePort(CustomOssCloudVO cloudVo, String nameSpace, String name, int _index);

	public void podCountUpdate(CustomOssCloudVO cloudVo, String nameSpace, String name,  int withRepli);

	public void templateDelete(CustomOssCloudVO cloudVo, String nameSpace, String name) throws Exception;

	public BuildList getBuild(CustomOssCloudVO cloudVo, String nameSpace, String name);

	public PodList getPodListByDeploymentconfigName(CustomOssCloudVO cloudVo, String nameSpace);

	public HorizontalPodAutoscaler createPodAutoscaler(CustomOssCloudVO cloudVo, String nameSpace, String name, String appName, int minReplicas , int maxReplicas);

	public PodMonitorList getPodMonitorListName(CustomOssCloudVO cloudVo, String nameSpace);

	public LimitRange createProjectRange(CustomOssCloudVO cloudVo, LimitRangeItem quotaOption, Map<String, Quantity> addToMax,
			Map<String, Quantity> addToMin, Map<String, Quantity> addLimitRangeToMin,
			Map<String, Quantity> addLimitRangeToMax, Map<String, Quantity> addLimitRangeDefault,
			Map<String, Quantity> addLimitRangeRequest, Map<String, Quantity> addLimitRangeRequestRatio,
			String namespace);

	public ResourceQuota projectQuotaUpdate(CustomOssCloudVO cloudVo, Map<String, Quantity> quotaOption, String namespace);

	void applicationUpdate(CustomOssCloudVO cloudVo, String nameSpace, String name, int podCnt, int cpuReq,
			int memReq);

	public PodList getPodLabelList(CustomOssCloudVO cloudVo, String nameSpace, Map<String, String> labels);


}
