package com.ivucenter.cloud.api.openshift.object;

import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ivucenter.cloud.api.openshift.connector.OpenShiftClientManager;
import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.api.openstack.object.OpenStackComplexQuota;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;
import com.ivucenter.cloud.portal.oss.project.CustomOssProjectVO;
import com.ivucenter.cloud.portal.req.product.CustomReqProductVO;

import io.fabric8.kubernetes.api.model.Container;
import io.fabric8.kubernetes.api.model.KubernetesList;
import io.fabric8.kubernetes.api.model.LimitRange;
import io.fabric8.kubernetes.api.model.LimitRangeItem;
import io.fabric8.kubernetes.api.model.PersistentVolume;
import io.fabric8.kubernetes.api.model.PersistentVolumeClaim;
import io.fabric8.kubernetes.api.model.PersistentVolumeClaimList;
import io.fabric8.kubernetes.api.model.PersistentVolumeList;
import io.fabric8.kubernetes.api.model.PodList;
import io.fabric8.kubernetes.api.model.Quantity;
import io.fabric8.kubernetes.api.model.ResourceQuota;
import io.fabric8.kubernetes.api.model.ServiceList;
import io.fabric8.kubernetes.api.model.ServicePort;
import io.fabric8.kubernetes.api.model.StatusDetails;
import io.fabric8.kubernetes.api.model.Volume;
import io.fabric8.kubernetes.api.model.VolumeBuilder;
import io.fabric8.kubernetes.api.model.VolumeMount;
import io.fabric8.kubernetes.api.model.VolumeMountBuilder;
import io.fabric8.kubernetes.api.model.autoscaling.v2.CrossVersionObjectReference;
import io.fabric8.kubernetes.api.model.autoscaling.v2.CrossVersionObjectReferenceBuilder;
import io.fabric8.kubernetes.api.model.autoscaling.v2.HPAScalingRulesBuilder;
import io.fabric8.kubernetes.api.model.autoscaling.v2.HorizontalPodAutoscaler;
import io.fabric8.kubernetes.api.model.autoscaling.v2.HorizontalPodAutoscalerBehavior;
import io.fabric8.kubernetes.api.model.autoscaling.v2.HorizontalPodAutoscalerBehaviorBuilder;
import io.fabric8.kubernetes.api.model.autoscaling.v2.HorizontalPodAutoscalerBuilder;
import io.fabric8.kubernetes.api.model.autoscaling.v2.MetricSpec;
import io.fabric8.kubernetes.api.model.autoscaling.v2.MetricSpecBuilder;
import io.fabric8.kubernetes.client.dsl.base.PatchContext;
import io.fabric8.kubernetes.client.dsl.base.PatchType;
import io.fabric8.openshift.api.model.BuildList;
import io.fabric8.openshift.api.model.DeploymentConfig;
import io.fabric8.openshift.api.model.DeploymentConfigList;
import io.fabric8.openshift.api.model.Project;
import io.fabric8.openshift.api.model.Route;
import io.fabric8.openshift.api.model.RouteList;
import io.fabric8.openshift.api.model.Template;
import io.fabric8.openshift.api.model.TemplateList;
import io.fabric8.openshift.api.model.monitoring.v1.PodMonitorList;
import io.fabric8.openshift.client.OpenShiftClient;
import lombok.extern.slf4j.Slf4j;


@Service
@Slf4j
public class OpsApiOptionService {

	@Autowired
	OpsMethodApiClass opsMethodApiClass;

	public void updateResourceQuota(String project_name, String project_quota, OpenStackComplexQuota req, CustomOssCloudVO cloudVo) {
		opsMethodApiClass.updateResourceQuota(project_name, project_quota, req, cloudVo);
	}

	public OpenStackComplexQuota openShiptGetNodeInfo(String project_id, CustomOssCloudVO cloudVo, CustomOssProjectVO projectVo)
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException, Exception{

		ResourceQuota res = 	opsMethodApiClass.singleProjectQuotaReturn(cloudVo, projectVo.getProjectName(), OpsNodeOptionList.quotaNickNameReturn(projectVo.getProjectName()));
		OpenStackComplexQuota openStackComplexQuota = null;

		try {
			if( res != null) {
				openStackComplexQuota = new OpenStackComplexQuota();
				openStackComplexQuota.setSpecHardLimitCpu(Integer.parseInt( ( "" + res.getSpec().getHard().get( OpsNodeOptionList.SPEC_HARD_LIMIT_CPU)))); //cpu정보
				openStackComplexQuota.setSpecHardLimitMemory(""+ res.getSpec().getHard().get( OpsNodeOptionList.SPEC_HARD_LIMIT_MEMORY)); //
				openStackComplexQuota.setSpecHardPV(Integer.parseInt( ""+ res.getSpec().getHard().get(OpsNodeOptionList.SPEC_HARD_PERSISTENTVOLUMECLAIMS))); //pv정보
				openStackComplexQuota.setSpecHardPod(Integer.parseInt( ""+ res.getSpec().getHard().get( OpsNodeOptionList.SPEC_HARD_PODS))); //pods 정보
				openStackComplexQuota.setSpecHardRequestCpu(Integer.parseInt( ""+ res.getSpec().getHard().get( OpsNodeOptionList.SPEC_HARD_REQUESTS_CPU))); //pods 정보
				openStackComplexQuota.setSpecHardRequestMemory(""+ res.getSpec().getHard().get( OpsNodeOptionList.SPEC_HARD_REQUESTS_MEMORY)); //pods 정보
				openStackComplexQuota.setStatusHardLimitCpu(Integer.parseInt( ""+ res.getStatus().getHard().get( OpsNodeOptionList.SPEC_HARD_REQUESTS_CPU)));
				openStackComplexQuota.setStatusHardLimitMemory(""+res.getStatus().getHard().get( OpsNodeOptionList.SPEC_HARD_REQUESTS_MEMORY)); // 메모리정보
				openStackComplexQuota.setStatusHardPV(Integer.parseInt( ""+res.getStatus().getHard().get( OpsNodeOptionList.STATUS_HARD_PERSISTENTVOLUMECLAIMS))); //pv정보
				openStackComplexQuota.setStatusHardPod(Integer.parseInt( ""+res.getStatus().getHard().get( OpsNodeOptionList.STATUS_HARD_PODS))); //pods 정보
				openStackComplexQuota.setStatusHardRequestCpu(Integer.parseInt( ""+res.getStatus().getHard().get( OpsNodeOptionList.STATUS_HARD_REQUESTS_CPU))); //cpu정보
				openStackComplexQuota.setStatusHardRequestMemory(""+res.getStatus().getHard().get( OpsNodeOptionList.STATUS_HARD_REQUESTS_MEMORY)); // 메모리정보
				openStackComplexQuota.setStatusUsedLimitCpu(Integer.parseInt( ""+ res.getStatus().getUsed().get(OpsNodeOptionList.STATUS_USED_LIMIT_CPU))); //cpu정보
				openStackComplexQuota.setStatusUsedLimitMemory(""+  res.getStatus().getUsed().get(OpsNodeOptionList.STATUS_USED_LIMIT_MEMORY)); // 메모리정보
				openStackComplexQuota.setStatusUsedPV(Integer.parseInt(""+  res.getStatus().getUsed().get(OpsNodeOptionList.STATUS_USED_PERSISTENTVOLUMECLAIMS))); //pv정보
				openStackComplexQuota.setStatusUsedPod(Integer.parseInt( ""+  res.getStatus().getUsed().get(OpsNodeOptionList.STATUS_USED_PODS))); //pods 정보
				openStackComplexQuota.setStatusUsedRequestCpu(Integer.parseInt( ""+ res.getStatus().getUsed().get( OpsNodeOptionList.STATUS_USED_REQUESTS_CPU))); //cpu정보
				openStackComplexQuota.setStatusUsedRequestMemory(""+ res.getStatus().getUsed().get(OpsNodeOptionList.STATUS_USED_REQUESTS_MEMORY)); // 메모리정보
			}
		} catch (NumberFormatException e) {
			log.error(e.getMessage());
		}
		return openStackComplexQuota;
	}

	public OpenStackComplexQuota openShiptGetNodeAvailable(OpenStackComplexQuota openStackComplexQuota) {

		openStackComplexQuota = opsMethodApiClass.openShiptGetNodeAvailable(openStackComplexQuota);

		return openStackComplexQuota;
	}

	//쿼터생성
	public ResourceQuota createProjectQuota( CustomOssCloudVO cloudVo, Map<String, Quantity> quotaOption, String namespace) {

		ResourceQuota req = opsMethodApiClass.createProjectQuota( cloudVo, quotaOption, namespace);
		return req;
	}

	//쿼터update
	public ResourceQuota projectQuotaUpdate( CustomOssCloudVO cloudVo, Map<String, Quantity> quotaOption, String namespace) {

		ResourceQuota req = opsMethodApiClass.projectQuotaUpdate( cloudVo, quotaOption, namespace);
		return req;
	}

	public HorizontalPodAutoscaler createHorizontalPodAutoscaler( CustomOssCloudVO cloudVo, OpsApiOptionVO opsApiOptionVO) {

		OpenShiftClient client = OpenShiftClientManager.getClient(cloudVo);

		CrossVersionObjectReference  crossVersionObjectReference = new CrossVersionObjectReferenceBuilder()
				.withApiVersion("apps.openshift.io/v1") // Ensure correct API version
	            .withKind("DeploymentConfig")
	            .withName(opsApiOptionVO.getAppName().toLowerCase())
	            .build();

	    // Define scaling rules for scale up and scale down
		HorizontalPodAutoscalerBehavior behavior = new HorizontalPodAutoscalerBehaviorBuilder()
	            .withScaleUp(new HPAScalingRulesBuilder()
	                    .addNewPolicy()
	                        .withType("Percent")
	                        .withValue(opsApiOptionVO.getHpaMax()) // Increase pods by 20%
	                        .withPeriodSeconds(opsApiOptionVO.getHpaContinue() * 60)
		                .endPolicy()
	                    .addNewPolicy()
		                    .withType("Pods")
		                    .withValue(opsApiOptionVO.getHpaIncrePod()) // Increase pods by 20%
		                    .withPeriodSeconds(opsApiOptionVO.getHpaContinue() * 60)
	                    .endPolicy()
	                    .withSelectPolicy("Max")
	                    .withStabilizationWindowSeconds(opsApiOptionVO.getHpaContinue() * 60)
	                    .build())
	            .withScaleDown(new HPAScalingRulesBuilder()
	                    .addNewPolicy()
	                        .withType("Percent")
	                        .withValue(20) 							// Decrease pods by 20%
	                        .withPeriodSeconds(opsApiOptionVO.getHpaContinue() * 60)
	                    .endPolicy()
	                    .addNewPolicy()
		                    .withType("Pods")
		                    .withValue(opsApiOptionVO.getHpaIncrePod()) // Increase pods by 20%
		                    .withPeriodSeconds(opsApiOptionVO.getHpaContinue() * 60)
	                    .endPolicy()
	                    .withSelectPolicy("Max")
	                    .withStabilizationWindowSeconds(opsApiOptionVO.getHpaContinue() * 60)
	                    .build())
	            .build();

	    // Define metrics to use for scaling
	    MetricSpec metricSpec = new MetricSpecBuilder()
	            .withType("Resource")
	            .withNewResource()
	                .withName(opsApiOptionVO.getHpaDivision())
	                .withNewTarget()
	                    .withType("Utilization")
	                    .withAverageUtilization(opsApiOptionVO.getHpaMax())
	                    .endTarget()
	                .endResource()
	            .build();

	    // Create the HPA resource
	    HorizontalPodAutoscaler hpa = new HorizontalPodAutoscalerBuilder()
	            .withNewMetadata()
	                .withName(opsApiOptionVO.getScaleOutName().toLowerCase())
	                .withNamespace(opsApiOptionVO.getNameSpace().toLowerCase())
	            .endMetadata()
	            .withNewSpec()
	                .withMinReplicas(opsApiOptionVO.getHpaMinPod())
	                .withMaxReplicas(opsApiOptionVO.getHpaMaxPod())
	                .withBehavior(behavior)
	                .addToMetrics(metricSpec)
	                .withScaleTargetRef(crossVersionObjectReference)
	            .endSpec()
	            .build();

	    HorizontalPodAutoscaler result = client.autoscaling().v2().horizontalPodAutoscalers().inNamespace(opsApiOptionVO.getNameSpace().toLowerCase()).resource(hpa).create();

		return result;
	}

//	public io.fabric8.kubernetes.api.model.autoscaling.v2beta2.HorizontalPodAutoscaler createPodAutoscalerV2( CustomOssCloudVO cloudVo, OpsApiOptionVO opsApiOptionVO) {
//
//		io.fabric8.kubernetes.api.model.autoscaling.v2beta2.HorizontalPodAutoscaler horizontalPodAutoscaler = null;
//		OpenShiftClient client = OpenShiftClientManager.getClient(cloudVo);
//
//		io.fabric8.kubernetes.api.model.autoscaling.v2beta2.CrossVersionObjectReference  CrossVersionObjectReference = new io.fabric8.kubernetes.api.model.autoscaling.v2beta2.CrossVersionObjectReference();
//		CrossVersionObjectReference.setApiVersion("apps.openshift.io/v1");
//		CrossVersionObjectReference.setKind("DeploymentConfig");
//		CrossVersionObjectReference.setName(opsApiOptionVO.getAppName());
//
//
//		HorizontalPodAutoscalerBehavior HorizontalPodAutoscalerBehavior = new HorizontalPodAutoscalerBehavior();
//		HPAScalingRules HPAScalingRulesUp = new HPAScalingRules();
//
//		HPAScalingRules HPAScalingRulesDown = new HPAScalingRules();
//
//
//		HPAScalingPolicy HPAScalingPolicyUp1 = new HPAScalingPolicy();
//		HPAScalingPolicy HPAScalingPolicyUp2 = new HPAScalingPolicy();
//
//		HPAScalingPolicyUp1.setType("Percent");
//		HPAScalingPolicyUp1.setValue(20); // 증가 pod
//		HPAScalingPolicyUp1.setPeriodSeconds(opsApiOptionVO.getHpaContinue() * 60);   //지속시간 60 1분
//
//		HPAScalingPolicyUp2.setType("Pods");
//		HPAScalingPolicyUp2.setValue(opsApiOptionVO.getHpaIncrePod()); // 증가 pod
//		HPAScalingPolicyUp2.setPeriodSeconds(opsApiOptionVO.getHpaContinue() * 60);   //지속시간 60 1분
//
//		List<HPAScalingPolicy> HPAScalingPolicyListUp = new ArrayList<HPAScalingPolicy>();
//		HPAScalingPolicyListUp.add(HPAScalingPolicyUp1);
//		HPAScalingPolicyListUp.add(HPAScalingPolicyUp2);
//		HPAScalingRulesUp.setPolicies(HPAScalingPolicyListUp);
//		HPAScalingRulesUp.setSelectPolicy("Max");
//		HPAScalingRulesUp.setStabilizationWindowSeconds(opsApiOptionVO.getHpaContinue() * 60);  //지속시간 60 1분
//		HorizontalPodAutoscalerBehavior.setScaleUp(HPAScalingRulesUp);
//
//		///////////////////////////////////////////////////////////////////////////////////////////
//		HPAScalingPolicy HPAScalingPolicyDown1 = new HPAScalingPolicy();
//		HPAScalingPolicy HPAScalingPolicyDown2 = new HPAScalingPolicy();
//
//		HPAScalingPolicyDown1.setType("Percent");
//		HPAScalingPolicyDown1.setValue(20); // 증가 pod
//		HPAScalingPolicyDown1.setPeriodSeconds(opsApiOptionVO.getHpaContinue() * 60);   //지속시간 60 1분
//
//		HPAScalingPolicyDown2.setType("Pods");
//		HPAScalingPolicyDown2.setValue(opsApiOptionVO.getHpaIncrePod()); // 증가 pod
//		HPAScalingPolicyDown2.setPeriodSeconds(opsApiOptionVO.getHpaContinue() * 60);   //지속시간 60 1분
//
//		List<HPAScalingPolicy> HPAScalingPolicyListDown = new ArrayList<HPAScalingPolicy>();
//
//		HPAScalingPolicyListDown.add(HPAScalingPolicyDown1);
//		HPAScalingPolicyListDown.add(HPAScalingPolicyDown2);
//
//		HPAScalingRulesDown.setPolicies(HPAScalingPolicyListDown);
//		HPAScalingRulesDown.setSelectPolicy("Max");
//		HPAScalingRulesDown.setStabilizationWindowSeconds(opsApiOptionVO.getHpaContinue() * 60);  //지속시간 60 1분
//		HorizontalPodAutoscalerBehavior.setScaleDown(HPAScalingRulesDown);
//
//
//		List<MetricSpec> MetricSpecList = new ArrayList<MetricSpec>();
//		MetricSpec MetricSpec = new MetricSpec();
//		ResourceMetricSource ResourceMetricSource = new ResourceMetricSource();
//		ResourceMetricSource.setName(opsApiOptionVO.getHpaDivision());
//		MetricTarget MetricTarget = new MetricTarget();
//		MetricTarget.setAverageUtilization(opsApiOptionVO.getHpaMax());
//		MetricTarget.setType("Utilization");
//		ResourceMetricSource.setTarget(MetricTarget);
//		MetricSpec.setResource(ResourceMetricSource);
//		MetricSpec.setType("Resource");
//		MetricSpecList.add(MetricSpec);
//
//		io.fabric8.kubernetes.api.model.autoscaling.v2beta2.HorizontalPodAutoscaler orizontalPodAutoscaler = new io.fabric8.kubernetes.api.model.autoscaling.v2beta2.HorizontalPodAutoscalerBuilder()
//				.withNewMetadata()
//				.withName(opsApiOptionVO.getScaleOutName().toLowerCase())
//				.withNamespace(opsApiOptionVO.getNameSpace().toLowerCase())
//				.endMetadata()
//				.withNewSpec()
//				.withMinReplicas(opsApiOptionVO.getHpaMinPod())  //최소 pod
//				.withMaxReplicas(opsApiOptionVO.getHpaMaxPod()) //최대 pod
//                .withBehavior(HorizontalPodAutoscalerBehavior)
//                .withMetrics(MetricSpecList)
//				.withScaleTargetRef(CrossVersionObjectReference)
//				.withMetrics(MetricSpec)
//				.endSpec()
//				.build();
//		 horizontalPodAutoscaler = client.autoscaling().v2beta2().horizontalPodAutoscalers().inNamespace(opsApiOptionVO.getNameSpace().toLowerCase()).create(orizontalPodAutoscaler);
//
//		return horizontalPodAutoscaler;
//	}




	//LimitRange 생성
	public LimitRange createProjectLimitRange(
			CustomOssCloudVO cloudVo, LimitRangeItem quotaOption,
			Map<String, Quantity> addToMax, Map<String, Quantity> addToMin, Map<String, Quantity> addLimitRangeToMin,
			Map<String, Quantity> addLimitRangeToMax, Map<String, Quantity> addLimitRangeDefault,
			Map<String, Quantity> addLimitRangeRequest, Map<String, Quantity> addLimitRangeRequestRatio,
			String namespace) {

		LimitRange req = opsMethodApiClass.createProjectRange( cloudVo, quotaOption, addToMax, addToMin, addLimitRangeToMin, addLimitRangeToMax, addLimitRangeDefault, addLimitRangeRequest, addLimitRangeRequestRatio, namespace);
		return req;
	}

	public Project opsCreateProject(CustomOssProjectVO projectVO, Object object, CustomOssCloudVO cloudVo)	{
		Project project = opsMethodApiClass.opsCreateProject(projectVO, object, cloudVo);
		return project;
	}

	public void createRoleBinding(String namespace, CustomOssCloudVO cloudVo)	{
		opsMethodApiClass.createRoleBinding(namespace, cloudVo);
	}

	public void addLabelNamespace(String namespace, CustomOssCloudVO cloudVo, Map<String, String> labels) {
		opsMethodApiClass.addLabelNamespace(namespace, cloudVo, labels);
	}

	public KubernetesList opsCreateApplication(CustomReqProductVO req, CustomOssCloudVO cloudVo){
		KubernetesList res = opsMethodApiClass.opsCreateApplication( req, cloudVo);
		return res;
	}

	public Map<String, Object> opsCreateApplicationMap(CustomReqProductVO req, CustomOssCloudVO cloudVo){
		Map<String, Object> res = opsMethodApiClass.opsCreateApplicationMap( req, cloudVo);
		return res;
	}

	public PersistentVolume opsCreatePersistentVolume(CustomReqProductVO req, CustomOssCloudVO cloudVo){
		PersistentVolume res = opsMethodApiClass.opsCreatePersistentVolume( req, cloudVo);
		return res;
	}

	public PersistentVolumeClaim opsCreatePersistentVolumeClaim(CustomReqProductVO req, CustomOssCloudVO cloudVo){
		PersistentVolumeClaim res = opsMethodApiClass.opsCreatePersistentVolumeClaim( req, cloudVo);
		return res;
	}

	public void opsDeletePersistentVolume(CustomReqProductVO req, CustomOssCloudVO cloudVo, String pvName){
		try {
			opsMethodApiClass.opsDeletePersistentVolume( req, cloudVo, pvName);
		} catch (Exception e) {
			log.error(e.getMessage());
		}
	}

	public void opsDeletePersistentVolumeClaim(CustomReqProductVO req, CustomOssCloudVO cloudVo, String pvName){
		try {
			opsMethodApiClass.opsDeletePersistentVolumeClaim( req, cloudVo, pvName);
		} catch (Exception e) {
			log.error(e.getMessage());
		}
	}

	public OpenStackComplexQuota nodeLimitUpdate(String project_id, CustomOssCloudVO cloudVo,
			OpenStackComplexQuota req) {

		// TODO Auto-generated method stub
		return req;
	}

	public String quotaNameReturn(String project_name) {
		String quota = opsMethodApiClass.quotaNameReturn( project_name);

		return quota;
	}

	public Template getTemplate(CustomOssCloudVO cloudVo, String templateName, String templateNameSpace) {
		// TODO Auto-generated method stub
		Template template = opsMethodApiClass.getTemplate(cloudVo, templateName, templateNameSpace);
		return template;
	}


	public TemplateList getTemplates(CustomOssCloudVO cloudVo) throws Exception{
		TemplateList templateList = null;
//		templateList = opsMethodApiClass.getTemplates(cloudVo);
//		return templateList;
		try {
			templateList = opsMethodApiClass.getTemplates(cloudVo);
			return templateList;
		} catch (Exception e) {
			log.error(e.getMessage());
			templateList = new TemplateList();
		}
		return templateList;
	}

	public DeploymentConfigList getDeploymentConfigList(CustomOssCloudVO cloudVo,String nameSpace) {
		DeploymentConfigList deploymentList = opsMethodApiClass.getDeploymentConfigList(cloudVo, nameSpace);
		return deploymentList;
	}

	public DeploymentConfig getDeploymentConfig(CustomOssCloudVO cloudVO, String nameSapce, String appName) {
		DeploymentConfig deploymentList = opsMethodApiClass.getDeploymentConfig( cloudVO, nameSapce, appName);

		return deploymentList;

	}

	public PodList getPodList(CustomOssCloudVO cloudVo,String nameSpace) {
		PodList podList = opsMethodApiClass.getPodList(cloudVo, nameSpace);
		return podList;
	}

	public PodList getPodLabelList(CustomOssCloudVO cloudVo,String nameSpace, Map<String, String> labels) {
		PodList podList = opsMethodApiClass.getPodLabelList(cloudVo, nameSpace, labels);
		return podList;
	}

	public PodList getPodListByDeploymentconfigName(CustomOssCloudVO cloudVo,String nameSpace) {
		PodList podList = opsMethodApiClass.getPodListByDeploymentconfigName(cloudVo, nameSpace);
		return podList;
	}

	public PodMonitorList getPodMonitorListName(CustomOssCloudVO cloudVo,String nameSpace) {
		PodMonitorList podMonitorList = opsMethodApiClass.getPodMonitorListName(cloudVo, nameSpace);
		return podMonitorList;
	}

	public BuildList getBuildList(CustomOssCloudVO cloudVo,String nameSpace) {
		BuildList build = opsMethodApiClass.getBuildList(cloudVo, nameSpace);
		return build;
	}

	public BuildList getBuild(CustomOssCloudVO cloudVo,String nameSpace, String name) {
		BuildList build = opsMethodApiClass.getBuild(cloudVo, nameSpace, name);
		return build;
	}

	public ServiceList getServiceList(CustomOssCloudVO cloudVo,String nameSpace) {
		ServiceList service = opsMethodApiClass.getServiceList(cloudVo, nameSpace);
		return service;
	}

	public ServiceList getService( CustomOssCloudVO cloudVo, String nameSpace, String name){
		ServiceList service = opsMethodApiClass.getService( cloudVo, nameSpace, name);
		return service;
	}

	public ServicePort getServicePort( CustomOssCloudVO cloudVo, String nameSpace, String name, int _index) {
		ServicePort servicePort = opsMethodApiClass.getServicePort(cloudVo, nameSpace, name, _index);
		return servicePort;
	}

	public RouteList getRouteList(CustomOssCloudVO cloudVo,String nameSpace) {
		RouteList route = opsMethodApiClass.getRouteList(cloudVo, nameSpace);
		return route;
	}

	public Route getRoute( CustomOssCloudVO cloudVo, String nameSpString, String name) {
		Route route = opsMethodApiClass.getRoute(cloudVo, nameSpString, name);
		return route;
	}

	public void podCountUpdate( CustomOssCloudVO cloudVo, String nameSpace, String name, int withRepli) {
		opsMethodApiClass.podCountUpdate( cloudVo, nameSpace, name, withRepli);
	}

	public void applicationUpdate( CustomOssCloudVO cloudVo, String nameSpace, String name, int podCnt, int cpuLimit, int memLimit) {
		opsMethodApiClass.applicationUpdate(cloudVo, nameSpace, name, podCnt, cpuLimit, memLimit);
	}

	public void templateDelete( CustomOssCloudVO cloudVo, String nameSpace, String name) {

		try {
			opsMethodApiClass.applicationDelete(cloudVo, nameSpace, name);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public PersistentVolumeList	getPersistentVolumeList(CustomOssCloudVO cloudVo) {
		OpenShiftClient client = OpenShiftClientManager.getClient(cloudVo);
		PersistentVolumeList persistentVolumeList = client.persistentVolumes().list();
		return persistentVolumeList;
	}

	public PersistentVolumeClaimList getPersistentVolumeClaimList(CustomOssCloudVO cloudVo, String namespace) {
        OpenShiftClient client = OpenShiftClientManager.getClient(cloudVo);

        PersistentVolumeClaimList pvcList = client.persistentVolumeClaims().inNamespace(namespace).list();
        return pvcList;
    }

	public void detachPVCFromDeploymentConfig(String namespace, String deploymentConfigName, String pvcName, CustomOssCloudVO cloudVo) throws Exception {
	    OpenShiftClient client = OpenShiftClientManager.getClient(cloudVo);

	    // 1. DeploymentConfig 조회
	    DeploymentConfig deploymentConfig = client.deploymentConfigs()
	                                              .inNamespace(namespace)
	                                              .withName(deploymentConfigName)
	                                              .get();

	    if (deploymentConfig == null) {
	        throw new Exception("DeploymentConfig " + deploymentConfigName + " not found.");
	    }

	    // 2. PVC detach: volumes와 volumeMounts에서 PVC 제거
	    List<Volume> volumes = deploymentConfig.getSpec().getTemplate().getSpec().getVolumes();
	    List<Container> containers = deploymentConfig.getSpec().getTemplate().getSpec().getContainers();

	    boolean pvcDetached = false; // detach 상태 추적

	    for (Iterator<Volume> iterator = volumes.iterator(); iterator.hasNext();) {
	        Volume volume = iterator.next();
	        if (volume.getPersistentVolumeClaim() != null && pvcName.equals(volume.getPersistentVolumeClaim().getClaimName())) {
	            iterator.remove(); // PVC가 연결되어 있으면 제거
	            pvcDetached = true;
	        }
	    }

	    for (Container container : containers) {
	        for (Iterator<VolumeMount> iterator = container.getVolumeMounts().iterator(); iterator.hasNext();) {
	            VolumeMount volumeMount = iterator.next();
	            if (pvcName.equals(volumeMount.getName())) {
	                iterator.remove(); // VolumeMount에서 제거
	                pvcDetached = true;
	            }
	        }
	    }

	    if (!pvcDetached) {
	        System.out.println("PVC " + pvcName + " was not attached to " + deploymentConfigName);
	        return; // PVC가 이미 연결되어 있지 않다면 중단
	    }

	    // 3. DeploymentConfig 업데이트
	    DeploymentConfig updatedDc = client.deploymentConfigs()
	                                       .inNamespace(namespace)
	                                       .withName(deploymentConfigName)
	                                       .patch(deploymentConfig);

	    if (updatedDc != null) {
	        System.out.println("PVC " + pvcName + " successfully detached from DeploymentConfig " + deploymentConfigName);
	    } else {
	        throw new Exception("Failed to update DeploymentConfig after detaching PVC.");
	    }
	}


	public void attachPVCToDeploymentConfig(String namespace, String deploymentConfigName, String pvcName, String mountPath, CustomOssCloudVO cloudVo) throws Exception {
	    try {

	    	OpenShiftClient client = OpenShiftClientManager.getClient(cloudVo);
	        // 1. DeploymentConfig 조회
	        DeploymentConfig deploymentConfig = client.deploymentConfigs()
	                                                  .inNamespace(namespace)
	                                                  .withName(deploymentConfigName)
	                                                  .get();

	        if (deploymentConfig == null) {
	            throw new Exception("DeploymentConfig " + deploymentConfigName + " not found.");
	        }

	        // 2. PVC attach: volumes에 PVC 추가
	        Volume pvcVolume = new VolumeBuilder()
	                .withName(pvcName)
	                .withNewPersistentVolumeClaim()
	                .withClaimName(pvcName)
	                .endPersistentVolumeClaim()
	                .build();

	        deploymentConfig.getSpec().getTemplate().getSpec().getVolumes().add(pvcVolume);

	        // 3. volumeMounts에 PVC 마운트 경로 추가
	        deploymentConfig.getSpec().getTemplate().getSpec().getContainers().forEach(container -> {
	            VolumeMount volumeMount = new VolumeMountBuilder()
	                    .withName(pvcName)
	                    .withMountPath(mountPath)
	                    .build();

	            container.getVolumeMounts().add(volumeMount);
	        });

	        // 4. DeploymentConfig 업데이트
	        client.deploymentConfigs()
	              .inNamespace(namespace)
	              .withName(deploymentConfigName)
	              .patch(deploymentConfig);

	        System.out.println("PVC " + pvcName + " attached to DeploymentConfig " + deploymentConfigName + " at " + mountPath);

	    } catch (Exception e) {
	        System.err.println("Failed to attach PVC: " + e.getMessage());
	        throw e;
	    }
	}

//	public HorizontalPodAutoscaler createPodAutoscaler( CustomOssCloudVO cloudVo, String nameSpace, String name, String appName  , int minReplicas , int maxReplicas) {
//		return opsMethodApiClass.createPodAutoscaler( cloudVo, nameSpace, name, appName,  minReplicas, maxReplicas);
//	}

	public HorizontalPodAutoscaler updatePodAutoscalerV2(
	        CustomOssCloudVO cloudVo, OpsApiOptionVO opsApiOptionVO) {

	    OpenShiftClient client = OpenShiftClientManager.getClient(cloudVo);

		CrossVersionObjectReference  crossVersionObjectReference = new CrossVersionObjectReferenceBuilder()
				.withApiVersion("apps.openshift.io/v1") // Ensure correct API version
	            .withKind("DeploymentConfig")
	            .withName(opsApiOptionVO.getAppName().toLowerCase())
	            .build();

	    // Define scaling rules for scale up and scale down
		HorizontalPodAutoscalerBehavior behavior = new HorizontalPodAutoscalerBehaviorBuilder()
	            .withScaleUp(new HPAScalingRulesBuilder()
	                    .addNewPolicy()
	                        .withType("Percent")
	                        .withValue(opsApiOptionVO.getHpaMax()) // Increase pods by 20%
	                        .withPeriodSeconds(opsApiOptionVO.getHpaContinue() * 60)
	                    .endPolicy()
	                    .addNewPolicy()
		                    .withType("Pods")
		                    .withValue(opsApiOptionVO.getHpaIncrePod()) // Increase pods by 20%
		                    .withPeriodSeconds(opsApiOptionVO.getHpaContinue() * 60)
	                    .endPolicy()
	                    .withSelectPolicy("Max")
	                    .withStabilizationWindowSeconds(opsApiOptionVO.getHpaContinue() * 60)
	                    .build())
	            .withScaleDown(new HPAScalingRulesBuilder()
	                    .addNewPolicy()
	                        .withType("Percent")
	                        .withValue(20) 							// Decrease pods by 20%
	                        .withPeriodSeconds(opsApiOptionVO.getHpaContinue() * 60)
	                    .endPolicy()
	                    .addNewPolicy()
	                        .withType("Pods")
	                        .withValue(opsApiOptionVO.getHpaIncrePod()) // Increase pods Count
	                        .withPeriodSeconds(opsApiOptionVO.getHpaContinue() * 60)
	                        .endPolicy()
	                    .withSelectPolicy("Max")
	                    .withStabilizationWindowSeconds(opsApiOptionVO.getHpaContinue() * 60)
	                    .build())
	            .build();

	    // Define metrics to use for scaling
	    MetricSpec metricSpec = new MetricSpecBuilder()
	            .withType("Resource")
	            .withNewResource()
	                .withName(opsApiOptionVO.getHpaDivision())
	                .withNewTarget()
	                    .withType("Utilization")
	                    .withAverageUtilization(opsApiOptionVO.getHpaMax())
	                    .endTarget()
	                .endResource()
	            .build();

	    HorizontalPodAutoscaler horizontalPodAutoscaler = new HorizontalPodAutoscalerBuilder()
	            .withNewMetadata()
	                .withName(opsApiOptionVO.getScaleOutName().toLowerCase())
	                .withNamespace(opsApiOptionVO.getNameSpace().toLowerCase())
	            .endMetadata()
	            .withNewSpec()
	                .withMinReplicas(opsApiOptionVO.getHpaMinPod())
	                .withMaxReplicas(opsApiOptionVO.getHpaMaxPod())
	                .withBehavior(behavior)
	                .addToMetrics(metricSpec)
	                .withScaleTargetRef(crossVersionObjectReference)
	            .endSpec()
	            .build();

	    PatchContext patchContext = PatchContext.of(PatchType.STRATEGIC_MERGE);

	    horizontalPodAutoscaler = client.autoscaling().v2().horizontalPodAutoscalers()
	            .inNamespace(opsApiOptionVO.getNameSpace().toLowerCase())
	            .withName(opsApiOptionVO.getScaleOutName().toLowerCase())
	            .patch(patchContext, horizontalPodAutoscaler);

	    return horizontalPodAutoscaler;
	}

	public Boolean deletePodAutoscalerV2( CustomOssCloudVO cloudVo, OpsApiOptionVO opsApiOptionVO) {

		OpenShiftClient client = OpenShiftClientManager.getClient(cloudVo);
//		horizontalPodAutoscaler = client.autoscaling().v2beta2().horizontalPodAutoscalers().inNamespace(opsApiOptionVO.getNameSpace().toLowerCase()).withName(opsApiOptionVO.getScaleOutName()).delete();
		List<StatusDetails> statusDetailsList = client.autoscaling().v2().horizontalPodAutoscalers()
				.inNamespace(opsApiOptionVO.getNameSpace().toLowerCase())
				.withName(opsApiOptionVO.getScaleOutName().toLowerCase())
				.delete();

        if (statusDetailsList != null && !statusDetailsList.isEmpty()) {
            // 상세 정보 출력 및 로깅
            statusDetailsList.forEach(statusDetail -> {
                log.info("Deleted HPA with details: " + statusDetail);
            });
            return true; // 삭제 성공
        } else {
        	log.info("No details returned, deletion may not have been processed.");
            return false; // 삭제 실패 또는 처리되지 않음
        }
	}
}
