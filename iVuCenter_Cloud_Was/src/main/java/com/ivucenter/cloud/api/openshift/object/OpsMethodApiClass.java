package com.ivucenter.cloud.api.openshift.object;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.ivucenter.cloud.api.common.utils.SystemCalculatorInfo;
import com.ivucenter.cloud.api.openshift.connector.OpenShiftClientManager;
import com.ivucenter.cloud.api.openstack.object.OpenStackComplexQuota;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;
import com.ivucenter.cloud.portal.oss.project.CustomOssProjectVO;
import com.ivucenter.cloud.portal.req.product.CustomReqProductVO;

import io.fabric8.kubernetes.api.model.EnvVar;
import io.fabric8.kubernetes.api.model.KubernetesList;
import io.fabric8.kubernetes.api.model.LimitRange;
import io.fabric8.kubernetes.api.model.LimitRangeBuilder;
import io.fabric8.kubernetes.api.model.LimitRangeItem;
import io.fabric8.kubernetes.api.model.Namespace;
import io.fabric8.kubernetes.api.model.NamespaceBuilder;
import io.fabric8.kubernetes.api.model.PersistentVolume;
import io.fabric8.kubernetes.api.model.PersistentVolumeBuilder;
import io.fabric8.kubernetes.api.model.PersistentVolumeClaim;
import io.fabric8.kubernetes.api.model.PersistentVolumeClaimBuilder;
import io.fabric8.kubernetes.api.model.PersistentVolumeClaimList;
import io.fabric8.kubernetes.api.model.PersistentVolumeList;
import io.fabric8.kubernetes.api.model.PodList;
import io.fabric8.kubernetes.api.model.Quantity;
import io.fabric8.kubernetes.api.model.ResourceQuota;
import io.fabric8.kubernetes.api.model.ResourceQuotaBuilder;
import io.fabric8.kubernetes.api.model.Secret;
import io.fabric8.kubernetes.api.model.SecretBuilder;
import io.fabric8.kubernetes.api.model.Service;
import io.fabric8.kubernetes.api.model.ServiceBuilder;
import io.fabric8.kubernetes.api.model.ServiceList;
import io.fabric8.kubernetes.api.model.ServicePort;
import io.fabric8.kubernetes.api.model.StatusDetails;
import io.fabric8.kubernetes.api.model.Volume;
import io.fabric8.kubernetes.api.model.VolumeBuilder;
import io.fabric8.kubernetes.api.model.VolumeMount;
import io.fabric8.kubernetes.api.model.VolumeMountBuilder;
import io.fabric8.kubernetes.api.model.autoscaling.v1.CrossVersionObjectReference;
import io.fabric8.kubernetes.api.model.autoscaling.v1.HorizontalPodAutoscaler;
import io.fabric8.kubernetes.api.model.autoscaling.v1.HorizontalPodAutoscalerBuilder;
import io.fabric8.kubernetes.api.model.rbac.RoleBinding;
import io.fabric8.kubernetes.api.model.rbac.RoleBindingBuilder;
import io.fabric8.kubernetes.api.model.rbac.RoleRefBuilder;
import io.fabric8.kubernetes.api.model.rbac.SubjectBuilder;
import io.fabric8.openshift.api.model.Build;
import io.fabric8.openshift.api.model.BuildConfig;
import io.fabric8.openshift.api.model.BuildConfigBuilder;
import io.fabric8.openshift.api.model.BuildList;
import io.fabric8.openshift.api.model.DeploymentConfig;
import io.fabric8.openshift.api.model.DeploymentConfigBuilder;
import io.fabric8.openshift.api.model.DeploymentConfigList;
import io.fabric8.openshift.api.model.ImageStream;
import io.fabric8.openshift.api.model.ImageStreamBuilder;
import io.fabric8.openshift.api.model.ImageStreamList;
import io.fabric8.openshift.api.model.Parameter;
import io.fabric8.openshift.api.model.Project;
import io.fabric8.openshift.api.model.ProjectBuilder;
import io.fabric8.openshift.api.model.Route;
import io.fabric8.openshift.api.model.RouteBuilder;
import io.fabric8.openshift.api.model.RouteList;
import io.fabric8.openshift.api.model.Template;
import io.fabric8.openshift.api.model.TemplateList;
import io.fabric8.openshift.api.model.monitoring.v1.PodMonitorList;
import io.fabric8.openshift.client.OpenShiftClient;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@org.springframework.stereotype.Service
public class OpsMethodApiClass implements OpsMethodApiInter {


    private static final Logger logger = LoggerFactory.getLogger(OpsMethodApiClass.class);


	@Override
	public void deleteProjectQuota(CustomOssCloudVO cloudVo, String namespace, String quotaName) {
		OpenShiftClient client = OpenShiftClientManager.getClient(cloudVo);
		// TODO Auto-generated method stub
		client.resourceQuotas().inNamespace( namespace).delete(
				new
				ResourceQuotaBuilder()
				.withNewMetadata()
				.withName(quotaName)
				.endMetadata()
				.build());
	}

	@Override
	public List<ResourceQuota> listProjectQuota(CustomOssCloudVO cloudVo, String namespace) {
		 OpenShiftClient client = OpenShiftClientManager.getClient(cloudVo);
		 List<ResourceQuota> quotaList =
				 client.resourceQuotas().inNamespace( namespace).list().getItems();

		 return quotaList;
	}

	@Override
	public ResourceQuota singleProjectQuotaReturn(CustomOssCloudVO cloudVo, String namespace, String quotaName) {
		OpenShiftClient client = OpenShiftClientManager.getClient(cloudVo);
		String toLowerCaseProjectName = namespace.toLowerCase(); //소문자 치환
		quotaName = quotaName.toLowerCase(); //소문자 치환
		ResourceQuota rq  = client.resourceQuotas().inNamespace( toLowerCaseProjectName).withName(quotaName).get();
		return rq;
	}

	@Override
	public void replaceProjectQuota(CustomOssCloudVO cloudVo, Map<String, Quantity> quotaOption, String namespace, String quotaName) {
		OpenShiftClient client = OpenShiftClientManager.getClient(cloudVo);

		client.resourceQuotas().inNamespace(namespace).replace( new
		ResourceQuotaBuilder()
		.withNewMetadata().withName(quotaName).endMetadata()
		.withNewSpec().addToHard(
				quotaOption
		).endSpec().build());

	}

	@Override
	public ResourceQuota createProjectQuota(CustomOssCloudVO cloudVo, Map<String, Quantity> quotaOption, String namespace) {
		ResourceQuota quota = null;
		try {
			if( namespace == null || "".equals( namespace) || namespace == "") {
				throw new Exception( OpsNodeOptionList.NOT_CODE_NAMESPACE);
			}
			namespace = namespace.toLowerCase();
			String quotaName = namespace + OpsNodeOptionList.QUOTANAME;
			OpenShiftClient client = OpenShiftClientManager.getClient(cloudVo);
			quota =	 client.resourceQuotas().inNamespace( namespace).resource(
					new ResourceQuotaBuilder()
						.withNewMetadata()
						.withName( quotaName)
						.endMetadata()
						.withNewSpec()
						.addToHard(quotaOption)
						.endSpec().build()
					).create();
		}catch (Exception e) {
            logger.error("JSON 처리 중 오류 발생");
		}
		return quota;
	 }


	@Override
	public ResourceQuota projectQuotaUpdate(CustomOssCloudVO cloudVo, Map<String, Quantity> quotaOption, String namespace) {
		ResourceQuota quota = null;
		try {
			if( namespace == null || "".equals( namespace) || namespace == "") {
				throw new Exception( OpsNodeOptionList.NOT_CODE_NAMESPACE);
			}
			namespace = namespace.toLowerCase();
			String quotaName = namespace + OpsNodeOptionList.QUOTANAME;
			OpenShiftClient client = OpenShiftClientManager.getClient(cloudVo);
			quota =	 client.resourceQuotas().inNamespace( namespace).replace( new
					ResourceQuotaBuilder()
					.withNewMetadata().withName(quotaName).endMetadata()
					.withNewSpec().addToHard(
							quotaOption
					).endSpec().build());

		}catch (Exception e) {

            logger.error("projectQuotaUpdate Exception");

		}
		return quota;
	 }


	@Override
	public LimitRange createProjectRange(
		CustomOssCloudVO cloudVo, LimitRangeItem quotaOption,
								Map<String, Quantity> addToMax, Map<String, Quantity> addToMin, Map<String, Quantity> addLimitRangeToMin,
								Map<String, Quantity> addLimitRangeToMax, Map<String, Quantity> addLimitRangeDefault,
								Map<String, Quantity> addLimitRangeRequest, Map<String, Quantity> addLimitRangeRequestRatio,
								String namespace) {

		LimitRange LimitRangeBuilder = null;
		try {
			if( namespace == null || "".equals( namespace) || namespace == "") {
				throw new Exception( OpsNodeOptionList.NOT_CODE_NAMESPACE);
			}

			//POD Limit Range Set
			quotaOption.setType("Pod");
			quotaOption.setMin(addToMin);
			quotaOption.setMax(addToMax);

			//Container Limit Range Set
			LimitRangeItem limitRangeItem = new LimitRangeItem();

			limitRangeItem.setType("Container");
			limitRangeItem.setMin(addLimitRangeToMin);
			limitRangeItem.setMax(addLimitRangeToMax);
			limitRangeItem.setDefault(addLimitRangeDefault);
			limitRangeItem.setDefaultRequest(addLimitRangeRequest);
			//limitRangeItem.setMaxLimitRequestRatio(addLimitRangeRequestRatio);

			namespace = namespace.toLowerCase();
			String LimitRangeBuilderName = namespace + OpsNodeOptionList.LIMITRANGEBULDER;

			OpenShiftClient client = OpenShiftClientManager.getClient(cloudVo);

			LimitRangeBuilder = new LimitRangeBuilder()
					.withApiVersion("v1")
					.withKind("LimitRange")
					.withNewMetadata()
					.withName(LimitRangeBuilderName)
					.withNamespace(namespace)
					.endMetadata()
					.withNewSpec()
					.addToLimits(quotaOption)
					.addToLimits(limitRangeItem)
					.endSpec()
					.build();
			LimitRangeBuilder = client.limitRanges().inNamespace(namespace).resource(LimitRangeBuilder).create();


		}catch (Exception e) {
            logger.error("오류 발생");
		}
		return LimitRangeBuilder;
	}

	@Override
	public String quotaNameReturn(String project_name) {
		String quota = null;
		quota = project_name + OpsNodeOptionList.QUOTANAME;

		return quota;
	}

	@Override
	public KubernetesList opsCreateApplication(CustomReqProductVO req, CustomOssCloudVO cloudVo) {
		OpenShiftClient client = OpenShiftClientManager.getClient(cloudVo);
		Map<String, String> param = new HashMap<>();
		String []arrParam = req.getParams().split("&");
		for(int i = 0; i < arrParam.length; i++){
			String []val = arrParam[i].split("=");
			if(val.length == 2) {
				param.put(val[0],val[1]);
			} else {
				param.put(val[0],"");
			}
		}
		KubernetesList template = client.templates()
				.inNamespace(req.getTemplateNameSpace())
				.withName(req.getTemplateName())
				.processLocally(param);

//		KubernetesList build = client.lists().inNamespace(req.getProjectName().toLowerCase()).resource(template).create();

		return template;

	}

	@Override
	public Map<String, Object> opsCreateApplicationMap(CustomReqProductVO req, CustomOssCloudVO cloudVo){
		// DeploymentConfig 정보 Pods, CPU, MEM
				String cpuLimit = Integer.toString(req.getCpuReq());
				String memLimit = Integer.toString(req.getMemReq()) + "Gi";
				String cpuReq = Integer.toString(req.getCpuReq());
				String memReq = Integer.toString(req.getMemReq()) + "Gi";
				int podCnt = req.getPodCnt();
				// PersistentVolumeClaim 정보 PVC Volume
				String volume = Integer.toString(req.getVolume()) + "Gi";
				String pvcYn = req.getPvcYn();

				String templateName =  req.getVmImageId();
				String templateNameSpace = req.getVmImageName();

				Map<String, Object> returnMap = new HashMap<>();
				OpenShiftClient client = OpenShiftClientManager.getClient(cloudVo);
				String brokerXml = "";
				String loggingProperties = "";

				Map<String, String> param = new HashMap<>();
				String []arrParam = req.getParams().split("&");

				Template template = getTemplate(cloudVo, templateName, templateNameSpace);

				for(int i = 0; i < arrParam.length; i++){
					String []val = arrParam[i].split("=");

					if(val.length == 2) {
						if(val[0].contains("XML") || val[0].contains("PROPERTIES")) {
							for(Parameter tempParam : template.getParameters()) {
								if(val[0].equals(tempParam.getName())) {
									if(val[0].contains("XML"))  brokerXml = "|- "+ tempParam.getValue();
									else 						loggingProperties = ">- "+ tempParam.getValue();

									param.put(val[0], "");
								}
							}
						}else {
							param.put(val[0], val[1]);
						}
						for(Parameter tempParam : template.getParameters()) {
							if(val[0].equals(tempParam.getName()) && (!val[0].contains("XML") && !val[0].contains("PROPERTIES"))) {
								tempParam.setValue(val[1]);
							}
						}
					} else {
						param.put(val[0],"");
					}
				}

				Map<String, String> labelsMap_tm = new HashMap<>();
				labelsMap_tm.put("template", req.getImageId().toLowerCase());
				labelsMap_tm.put("app", req.getAppName().toLowerCase());
				labelsMap_tm.put("application_name", req.getAppName().toLowerCase());

				KubernetesList templateList = client.templates()
						.inNamespace(req.getVmImageName().toLowerCase())
						.withName(req.getImageId().toLowerCase())
						.processLocally(param);
				returnMap.put("template", template);

				String itemKind = "";
				for(int i =0; i< templateList.getItems().size(); ++i) {

					itemKind = templateList.getItems().get( i).getKind();
					switch (itemKind) {

					case "Secret":
						Secret tempSecret = (Secret) templateList.getItems().get(i);
						Secret fromSecret = new SecretBuilder(tempSecret)
								.editOrNewMetadata()
								.addToLabels(labelsMap_tm)
							.endMetadata()
							.build();
						client.secrets().inNamespace(req.getProjectName().toLowerCase()).resource(fromSecret).create();
						break;
					case "Service":
						Service tempService = (Service) templateList.getItems().get( i);
						Service fromServerService = new ServiceBuilder(tempService)
								.editOrNewMetadata()
									.addToLabels(labelsMap_tm)
								.endMetadata()
								.build();
						client.services().inNamespace( req.getProjectName().toLowerCase()).resource(fromServerService).create();
						break;

					case "PersistentVolumeClaim":
						// PVC 여부에 따라 PersistentVolumeClaim 작성
						if (pvcYn.equals("N")) {
							break;
						}else {
							PersistentVolumeClaim tempPersistentVolumeClaim = (PersistentVolumeClaim) templateList.getItems().get(i);
							PersistentVolumeClaim fromServerPersistentVolumeClaim = new PersistentVolumeClaimBuilder(tempPersistentVolumeClaim)
									.editOrNewMetadata()
										.addToLabels(labelsMap_tm)
									.endMetadata()
									.editOrNewSpec()
										.editOrNewResources()
											.addToRequests("storage", new Quantity(volume))
										.endResources()
									.endSpec()
									.build();
							client.persistentVolumeClaims().inNamespace(req.getProjectName().toLowerCase()).resource(fromServerPersistentVolumeClaim).create();
						}
						break;

					case "Route":
						Route tempRoute = (Route) templateList.getItems().get( i);
						Route fromServerRoute =  new RouteBuilder( tempRoute)
								.editOrNewMetadata()
									.addToLabels(labelsMap_tm)
								.endMetadata()
								.build();
						client.routes().inNamespace( req.getProjectName().toLowerCase()).resource(fromServerRoute).create();
						break;

					case "ImageStream":
						ImageStream tempImgeStream = (ImageStream) templateList.getItems().get( i);
						ImageStream fromServerImgeStream =  new ImageStreamBuilder( tempImgeStream)
								.editOrNewMetadata()
									.addToLabels(labelsMap_tm)
								.endMetadata()
								.build();
						client.imageStreams().inNamespace( req.getProjectName().toLowerCase()).resource(fromServerImgeStream).create();
						break;

					case "BuildConfig":
						BuildConfig tempBuildConfig = (BuildConfig) templateList.getItems().get( i);
						BuildConfig fromServerBuildConfig =  new BuildConfigBuilder( tempBuildConfig)
								.editOrNewMetadata()
									.addToLabels(labelsMap_tm)
								.endMetadata()
								.build();
						client.buildConfigs().inNamespace( req.getProjectName().toLowerCase()).resource(fromServerBuildConfig).create();
						break;

					case "DeploymentConfig":
						DeploymentConfig tempDeploymentConfig = (DeploymentConfig) templateList.getItems().get( i);
						List<EnvVar> envList = tempDeploymentConfig.getSpec().getTemplate().getSpec().getContainers().get(0).getEnv();

						// 메시지 큐 Xml, Properties 처리
						for(EnvVar env : envList) {
							if(env.getName().equals("BROKER_XML")) {
								env.setValue(brokerXml);
							}else if(env.getName().equals("LOGGING_PROPERTIES")) {
								env.setValue(loggingProperties);
							}
						}

						DeploymentConfig fromServerDeploymentConfig =  new DeploymentConfigBuilder(tempDeploymentConfig)
								.editOrNewMetadata()
								.addToLabels(labelsMap_tm)
								.endMetadata()
								.editOrNewSpec()
									.withReplicas(podCnt) 										// pods
									.editOrNewTemplate()
									.editOrNewSpec()
										.editFirstContainer()
										.editOrNewResources()
											.addToLimits("memory", new Quantity(memLimit)) 		// 범위
											.addToLimits("cpu", new Quantity(cpuLimit))			// 범위
											.addToRequests("memory", new Quantity(memReq)) 		// 요청
											.addToRequests("cpu", new Quantity(cpuReq))	  		// 요청
										.endResources()
										.endContainer()
									.endSpec()
									.endTemplate()
								.endSpec()
								.build();

						DeploymentConfig dp = client.deploymentConfigs().inNamespace( req.getProjectName().toLowerCase()).resource(fromServerDeploymentConfig).create();
						returnMap.put("deploymentConfig", dp);
						break;

					default :
						break;
					}
				}

				return returnMap;
	}

	@Override
	public Project opsCreateProject(CustomOssProjectVO projectVO, Object object, CustomOssCloudVO cloudVo) throws IllegalArgumentException {

		OpenShiftClient client = OpenShiftClientManager.getClient(cloudVo);
		Map<String, String> annotations = new HashMap<>();
//		if (projectVO.getProjectAlias() != null) {
//			annotations.put(OpsNodeOptionList.PROJECT_DISPLAY_NAME_ANNOTATION, projectVO.getProjectAlias());
//		}
		if (projectVO.getProjectDescription() != null) {
			annotations.put(OpsNodeOptionList.PROJECT_DESCRIPTION_ANNOTATION, projectVO.getProjectDescription());
		}

		Project project = new ProjectBuilder()
				.withNewMetadata()
				.withName(projectVO.getProjectName().toLowerCase())
				.withAnnotations(annotations)
				.endMetadata()
				.build();

		return client.projects().resource(project).create();
	}

	public void createRoleBinding(String namespace, CustomOssCloudVO cloudVo) {
		OpenShiftClient client = OpenShiftClientManager.getClient(cloudVo);

		RoleBinding roleBinding = new RoleBindingBuilder()
			.withNewMetadata()
				.withName("system:openshift:scc:anyuid")
				.withNamespace(namespace)
			.endMetadata()
			.withSubjects(new SubjectBuilder()
				.withKind("ServiceAccount")
				.withName("default")
				.withNamespace(namespace)
				.build())
			.withRoleRef(new RoleRefBuilder()
				.withKind("ClusterRole")
				.withApiGroup("rbac.authorization.k8s.io")
				.withName("system:openshift:scc:anyuid")
				.build())
			.build();

		client.rbac().roleBindings().inNamespace(namespace).resource(roleBinding).create();
	}

	public void addLabelNamespace(String namespace, CustomOssCloudVO cloudVo, Map<String, String> labels) {
		OpenShiftClient client = OpenShiftClientManager.getClient(cloudVo);

		Namespace namespace1 = client.namespaces().withName(namespace).get();

		Namespace namespace2 = new NamespaceBuilder(namespace1)
				.editOrNewMetadata()
					.addToLabels(labels)
				.endMetadata()
				.build();

		client.namespaces().withName(namespace).patch(namespace2);
	}

	@Override
	public OpenStackComplexQuota openShiptGetNodeAvailable(OpenStackComplexQuota openStackComplexQuota) {
		// TODO Auto-generated method stub
		/*
		 * try { //spec.hard - status.used //숫자만 str.replaceAll("[^0-9]",""); String
		 * specHardMemoryStr = openStackComplexQuota.getSpecHardLimitMemory(); Integer
		 * specHardMemory = Integer.parseInt(
		 * specHardMemoryStr.replaceAll("[^0-9]",""));
		 *
		 * String statusUsedMemoryStr =
		 * openStackComplexQuota.getStatusUsedLimitMemory(); Integer statusUsedMemory =
		 * Integer.parseInt( statusUsedMemoryStr.replaceAll("[^0-9]",""));
		 *
		 * Integer cpu = openStackComplexQuota.getSpecHardLimitCpu() -
		 * openStackComplexQuota.getStatusUsedLimitCpu(); Integer memory =
		 * specHardMemory - statusUsedMemory;
		 *
		 * Integer volume = openStackComplexQuota.getSpecHardPV() -
		 * openStackComplexQuota.getStatusUsedPV(); Integer pod =
		 * openStackComplexQuota.getSpecHardPod() -
		 * openStackComplexQuota.getStatusUsedPod();
		 *
		 * openStackComplexQuota.setResultLimitCpu( cpu);
		 * openStackComplexQuota.setResultLimitMemory( (""+memory)+"Gi" );
		 *
		 * openStackComplexQuota.setResultPV( volume);
		 * openStackComplexQuota.setResultPod( pod );
		 *
		 * }catch (Exception e) { logger.error("오류 발생"); }
		 */
		return openStackComplexQuota;
	}


	@Override
	public void updateResourceQuota(String project_name, String project_quota, OpenStackComplexQuota req,
			CustomOssCloudVO cloudVo) {
	}

	@Override
	public Template getTemplate(CustomOssCloudVO cloudVo, String templateName, String templateNameSpace) {

		OpenShiftClient client = OpenShiftClientManager.getClient(cloudVo);
		Template template = client.templates().inNamespace(templateNameSpace).withName( templateName).get();
		return template;
	}

	@Override
	public TemplateList getTemplates(CustomOssCloudVO cloudVo) throws Exception{

		OpenShiftClient client = OpenShiftClientManager.getClient(cloudVo);

		//TemplateList templateList = client.templates().inNamespace("3hs-dev").list();
		TemplateList templateList = client.templates().list();
		return templateList;
	}

	public ImageStreamList getImageStreams(CustomOssCloudVO cloudVo) throws Exception{
		OpenShiftClient client = OpenShiftClientManager.getClient(cloudVo);
		ImageStreamList imageStreamList = client.imageStreams().list();
		return imageStreamList;
	}

	@Override
	public DeploymentConfigList getDeploymentConfigList(CustomOssCloudVO cloudVo, String nameSpace) {
		OpenShiftClient client = OpenShiftClientManager.getClient(cloudVo);
		DeploymentConfigList deploymentConfigList = client.deploymentConfigs().inNamespace(nameSpace).list();
		return deploymentConfigList;
	}

	@Override
	public DeploymentConfig getDeploymentConfig( CustomOssCloudVO cloudVO, String nameSapce, String appName) {
		OpenShiftClient client = OpenShiftClientManager.getClient(cloudVO);
		DeploymentConfig deploymentConfigList = client.deploymentConfigs().inNamespace( nameSapce).withName( appName).get();
		return deploymentConfigList;
	}


	@Override
	public PodList getPodList(CustomOssCloudVO cloudVo,String nameSpace) {
		OpenShiftClient client = OpenShiftClientManager.getClient(cloudVo);
		PodList podList = client.pods().inNamespace(nameSpace).list();
		return podList;
	}

	@Override
	public PodList getPodLabelList(CustomOssCloudVO cloudVo,String nameSpace, Map<String, String> labels) {
		OpenShiftClient client = OpenShiftClientManager.getClient(cloudVo);
		PodList podList = client.pods().inNamespace(nameSpace).withLabels(labels).list();
		return podList;
	}

	@Override
	public PodList getPodListByDeploymentconfigName(CustomOssCloudVO cloudVo,String nameSpace) {
		OpenShiftClient client = OpenShiftClientManager.getClient(cloudVo);
		PodList podList = client.pods().inNamespace(nameSpace.toLowerCase()).list();

		return podList;
	}


	@Override
	public PodMonitorList getPodMonitorListName(CustomOssCloudVO cloudVo,String nameSpace) {
		OpenShiftClient client = OpenShiftClientManager.getClient(cloudVo);
		PodMonitorList podMonitorList = client.monitoring().podMonitors().list();
		return podMonitorList;
	}




	@Override
	public BuildList getBuildList(CustomOssCloudVO cloudVo,String nameSpace) {
		OpenShiftClient client = OpenShiftClientManager.getClient(cloudVo);
		BuildList build = client.builds().inNamespace(nameSpace.toLowerCase()).list();
		return build;
	}

	@Override
	public BuildList getBuild(CustomOssCloudVO cloudVo,String nameSpace,String name) {
		OpenShiftClient client = OpenShiftClientManager.getClient(cloudVo);
		BuildList build = client.builds().inNamespace(nameSpace.toLowerCase()).withLabel("application",name).list();
		return build;
	}

	@Override
	public ServiceList getServiceList(CustomOssCloudVO cloudVo,String nameSpace) {
		OpenShiftClient client = OpenShiftClientManager.getClient(cloudVo);
		ServiceList service = client.services().inNamespace(nameSpace.toLowerCase()).list();
		return service;
	}

	@Override
	public ServiceList getService( CustomOssCloudVO cloudVo, String nameSpace, String name){
		OpenShiftClient client = OpenShiftClientManager.getClient(cloudVo);
		ServiceList service = client.services().inNamespace(nameSpace).withLabel("application",name).list();
		return service;
	}

	@Override
	public ServicePort getServicePort( CustomOssCloudVO cloudVo, String nameSpace, String name, int _index) {
		OpenShiftClient client = OpenShiftClientManager.getClient(cloudVo);
		ServicePort servicePort = client.services().inNamespace( nameSpace).withName( name).get().getSpec().getPorts().get(_index);
		return servicePort;
	}

	@Override
	public RouteList getRouteList(CustomOssCloudVO cloudVo,String nameSpace) {
		OpenShiftClient client = OpenShiftClientManager.getClient(cloudVo);
		RouteList route = client.routes().inNamespace(nameSpace.toLowerCase()).list();
		return route;
	}

//	@Override
//	public PodList getPodList(CustomOssCloudVO cloudVo,String nameSpace,String name) {
//		OpenShiftClient client = OpenShiftClientManager.getClient(cloudVo);
//		PodList podList = client.pods().inNamespace(nameSpace).withLabel("deploymentconfig",name).list();
//		return podList;
//	}

//	@Override
//	public BuildList getBuildList(CustomOssCloudVO cloudVo,String nameSpace,String name) {
//		OpenShiftClient client = OpenShiftClientManager.getClient(cloudVo);
//		BuildList build = client.builds().inNamespace(nameSpace).withLabel("application",name).list();
//		return build;
//	}

//	@Override
//	public ServiceList getServiceList(CustomOssCloudVO cloudVo,String nameSpace,String name) {
//		OpenShiftClient client = OpenShiftClientManager.getClient(cloudVo);
//		ServiceList service = client.services().inNamespace(nameSpace).withLabel("application",name).list();
//		return service;
//	}

//	@Override
//	public RouteList getRouteList(CustomOssCloudVO cloudVo,String nameSpace,String name) {
//		OpenShiftClient client = OpenShiftClientManager.getClient(cloudVo);
//		RouteList route = client.routes().inNamespace(nameSpace).withLabel("app",name).list();
//		return route;
//	}

	@Override
	public Route getRoute( CustomOssCloudVO cloudVo, String nameSpace, String name) {
		OpenShiftClient client = OpenShiftClientManager.getClient(cloudVo);
		Route route = client.routes().inNamespace( nameSpace).withName( name).get();
		return route;
	}



	@Override
	public void applicationUpdate( CustomOssCloudVO cloudVo, String nameSpace, String name, int podCnt, int cpuReq, int memReq) {
		OpenShiftClient client = OpenShiftClientManager.getClient(cloudVo);

//		String updateCpuLimit = Integer.toString(cpuLimit);
//		String updateMemLimit = Integer.toString(memLimit) + "Gi";
		String updateCpuReq = Integer.toString(cpuReq);
		String updateMemReq = Integer.toString(memReq) + "Gi";

		client.deploymentConfigs().inNamespace( nameSpace).withName( name).edit(
				dc -> new DeploymentConfigBuilder(dc)
						.editOrNewSpec()
							.withReplicas(podCnt)
							.editOrNewTemplate()
							.editOrNewSpec()
								.editFirstContainer()
								.editOrNewResources()
//									.addToLimits("memory", new Quantity(updateMemLimit))
//									.addToLimits("cpu", new Quantity(updateCpuLimit))
									.addToRequests("memory", new Quantity(updateCpuReq))
									.addToRequests("cpu", new Quantity(updateMemReq))
								.endResources()
								.endContainer()
							.endSpec()
							.endTemplate()
						.endSpec().build()
				);
	}

	private void checkDeletion(List<StatusDetails> details, String resourceType) throws Exception {
	    if (details.isEmpty()) {
	        log.info(resourceType + " deleted successfully.");
	    } else {
	        details.forEach(detail -> log.error("Error deleting " + resourceType + ": " + detail.toString()));
	        throw new Exception("Error deleting " + resourceType);
	    }
	}

	@Override
	public void applicationDelete(CustomOssCloudVO cloudVo, String nameSpace, String name) throws Exception {
		try {
			OpenShiftClient client = OpenShiftClientManager.getClient(cloudVo);
			Map<String, String> map = new HashMap<>();

			map.put("app", name.toLowerCase());

			List<Build> list = client.builds().inNamespace( nameSpace.toLowerCase()).list().getItems();
//			Build returnNode = null;
			String podBuildNameReturn = null;

			Loop1 : for (Build node : list) {
				String _configName = node.getMetadata().getAnnotations().get("openshift.io/build-config.name");
				String _buildPodName = node.getMetadata().getAnnotations().get("openshift.io/build.pod-name");

				if( name.equals( _configName)) {
//					returnNode = node;
					podBuildNameReturn = _buildPodName;
					break Loop1;
				}
			}

			checkDeletion(client.services().inNamespace(nameSpace.toLowerCase()).withLabels(map).delete(), "isService");
			checkDeletion(client.routes().inNamespace(nameSpace.toLowerCase()).withLabels(map).delete(), "isRouters");
			checkDeletion(client.imageStreams().inNamespace(nameSpace.toLowerCase()).withLabels(map).delete(), "isImageStreams");
			checkDeletion(client.buildConfigs().inNamespace(nameSpace.toLowerCase()).withLabels(map).delete(), "isBuildConfigs");
			checkDeletion(client.builds().inNamespace(nameSpace.toLowerCase()).withLabels(map).delete(), "isBuild");
			checkDeletion(client.deploymentConfigs().inNamespace(nameSpace.toLowerCase()).withName(name.toLowerCase()).delete(), "isDeploymentConfigs");
			checkDeletion(client.pods().inNamespace(nameSpace.toLowerCase()).withName( podBuildNameReturn).delete(), "isPod");

			if( podBuildNameReturn != null) {
				boolean isPod = client.pods().inNamespace(nameSpace.toLowerCase()).withName( podBuildNameReturn).delete().size() == 1;
				if(!isPod) {
					throw new Exception("isPod Delete Faile");
				}
			}

		}catch (Exception e) {
			throw e;
		}
	}

	@Override
	public void podCountUpdate(CustomOssCloudVO cloudVo, String nameSpace, String name, int withRepli) {
		OpenShiftClient client = OpenShiftClientManager.getClient(cloudVo);
		// TODO Auto-generated method stub
		client.deploymentConfigs().inNamespace( nameSpace).withName( name).edit(
				  dc -> new DeploymentConfigBuilder(dc).editSpec().withReplicas( withRepli).endSpec().build()
		);
	}

	@Override
	public void templateDelete( CustomOssCloudVO cloudVo, String nameSpace, String name) throws Exception {
		try {
			OpenShiftClient client = OpenShiftClientManager.getClient(cloudVo);
			Map<String, String> map = new HashMap<>();
			map.put("app", name.toLowerCase());

			//project Name >> nameSpace
			List<Build> list = client.builds().inNamespace(nameSpace.toLowerCase()).list().getItems();
//			Build returnNode = null;
			String podBuildNameReturn = null;

			Loop1 : for (Build node : list) {
				String _configName = node.getMetadata().getAnnotations().get("openshift.io/build-config.name");
				String _buildPodName = node.getMetadata().getAnnotations().get("openshift.io/build.pod-name");

				if( name.equals( _configName)) {
//					returnNode = node;
					podBuildNameReturn = _buildPodName;
					break Loop1;
				}
			}

			checkDeletion(client.services().inNamespace(nameSpace.toLowerCase()).withLabels(map).delete(), "isService");
			checkDeletion(client.routes().inNamespace(nameSpace.toLowerCase()).withLabels(map).delete(), "isRouters");
			checkDeletion(client.imageStreams().inNamespace(nameSpace.toLowerCase()).withLabels(map).delete(), "isImageStreams");
			checkDeletion(client.buildConfigs().inNamespace(nameSpace.toLowerCase()).withLabels(map).delete(), "isBuildConfigs");
			checkDeletion(client.builds().inNamespace(nameSpace.toLowerCase()).withLabels(map).delete(), "isBuild");
			checkDeletion(client.deploymentConfigs().inNamespace(nameSpace.toLowerCase()).withName(name.toLowerCase()).delete(), "isDeploymentConfigs");
			checkDeletion(client.pods().inNamespace(nameSpace.toLowerCase()).withName( podBuildNameReturn).delete(), "isPod");

			if( podBuildNameReturn != null) {
				boolean isPod = client.pods().inNamespace(nameSpace.toLowerCase()).withName( podBuildNameReturn).delete().size() == 1;
				if(!isPod) {
					throw new Exception("isPod Delete Faile");
				}
			}
//			boolean isService = client.services().inNamespace(nameSpace.toLowerCase()).withLabels(map).delete();
//			boolean isRouters = client.routes().inNamespace(nameSpace.toLowerCase()).withLabels(map).delete();
//			boolean isImageStreams = client.imageStreams().inNamespace(nameSpace.toLowerCase()).withLabels(map).delete();
//			boolean isBuildConfigs = client.buildConfigs().inNamespace(nameSpace.toLowerCase()).withLabels(map).delete();
//			boolean isBuild = client.builds().inNamespace(nameSpace.toLowerCase()).withLabels(map).delete();
//			boolean isDeploymentConfigs = client.deploymentConfigs().inNamespace(nameSpace.toLowerCase()).withName(name.toLowerCase()).delete();
//
//			if( podBuildNameReturn != null) {
//				boolean isPod = client.pods().inNamespace(nameSpace.toLowerCase()).withName( podBuildNameReturn).delete();
//			}

		}catch (Exception e) {
			throw e;
		}
	}


	@Override
	public HorizontalPodAutoscaler createPodAutoscaler(CustomOssCloudVO cloudVo,String nameSpace, String name, String appName, int minReplicas , int maxReplicas) {

		HorizontalPodAutoscaler horizontalPodAutoscaler = null;
		OpenShiftClient client = OpenShiftClientManager.getClient(cloudVo);

		CrossVersionObjectReference crossVersionObjectReference = new CrossVersionObjectReference();
		crossVersionObjectReference.setApiVersion("apps/v1");
		crossVersionObjectReference.setKind("Deployment");
		crossVersionObjectReference.setName(appName);
		HorizontalPodAutoscaler orizontalPodAutoscaler = new HorizontalPodAutoscalerBuilder()
				.withNewMetadata()
				.withName(name)
				.withNamespace(nameSpace)
				.endMetadata()
				.withNewSpec()
				.withMinReplicas(minReplicas)
				.withMaxReplicas(maxReplicas)
				.withScaleTargetRef(crossVersionObjectReference)
				.endSpec()
				.build();
		 horizontalPodAutoscaler = client.autoscaling().v1().horizontalPodAutoscalers().inNamespace(nameSpace.toLowerCase()).resource(orizontalPodAutoscaler).create();

		return horizontalPodAutoscaler;
	}

	@Override
	public OpenStackComplexQuota nodeLimitUpdate(String project_id, CustomOssCloudVO cloudVo,
			OpenStackComplexQuota req) {
		// TODO Auto-generated method stub
		return null;
	}
	// 오픈시프트 PV 생성
	public PersistentVolume opsCreatePersistentVolume(CustomReqProductVO req, CustomOssCloudVO cloudVo) {

	    SystemCalculatorInfo systemCalculatorInfo = new SystemCalculatorInfo();
	    String nasName = req.getNasName().toLowerCase() + "-pv";   	// NAS Name + '-pv'
	    String nasProviderIp = systemCalculatorInfo.getNasProviderIp();
	    String nasGb = Integer.toString(req.getNasGb())+"Gi";
	    String nasPath = req.getNasFileSystemPath().toLowerCase();

	    PersistentVolume opsPv = null;
	    try {

	    	OpenShiftClient client = OpenShiftClientManager.getClient(cloudVo);
	    	opsPv = new PersistentVolumeBuilder()
	    			.withApiVersion("v1")
	    			.withKind("PersistentVolume")
	    			.withNewMetadata()
	    				.withName(nasName).endMetadata()
	    			.withNewSpec()
	    				.addToCapacity(Collections.singletonMap("storage", new Quantity(nasGb)))
	    				.addToMountOptions("vers=3")
	    				.withAccessModes("ReadWriteMany")
	    				.withPersistentVolumeReclaimPolicy("Recycle")
	    				.withNewNfs()
			    			.withPath(nasPath)
			    			.withServer(nasProviderIp) // 90.1.1.231
			    		.endNfs()
	    			.endSpec()
	    			.build();
	    	opsPv = client.persistentVolumes().resource(opsPv).create();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return opsPv;
	}

	// 오픈시프트 PVC 생성
	public PersistentVolumeClaim opsCreatePersistentVolumeClaim(CustomReqProductVO req, CustomOssCloudVO cloudVo) {
		String projectNameSpace = req.getProjectName().toLowerCase(); 	// Project Name + dev/prod
		String nasName = req.getNasName().toLowerCase();
		String nasPvcName = nasName + "-pvc";			  	// NAS Name + '-pvc'
		String nasGb = Integer.toString(req.getNasGb())+"Gi";			// requests > storage + Gi
		String nasPvName = nasName + "-pv";
		PersistentVolumeClaim opsPvc = null;
		try {

			if( projectNameSpace == null || "".equals( projectNameSpace) || projectNameSpace == "") {
				throw new Exception(OpsNodeOptionList.NOT_CODE_NAMESPACE);
			}
			OpenShiftClient client = OpenShiftClientManager.getClient(cloudVo);
			opsPvc = new PersistentVolumeClaimBuilder()
					.withApiVersion("v1")
					.withKind("PersistentVolumeClaim")
					.withNewMetadata().withName(nasPvcName).withNamespace(projectNameSpace).endMetadata()
					.withNewSpec()
						.withAccessModes("ReadWriteMany")
						.withVolumeName(nasPvName)
						.withNewResources()
						.addToRequests("storage", new Quantity(nasGb))
						.endResources()
					.endSpec()
					.build();
			opsPvc = client.persistentVolumeClaims().resource(opsPvc).create();

		}catch (Exception e) {
			e.printStackTrace();
		}
		return opsPvc;
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

	// 오픈시프트 PV 삭제
	public void opsDeletePersistentVolume(CustomReqProductVO req, CustomOssCloudVO cloudVo, String pvName) throws Exception {

		try {
			OpenShiftClient client = OpenShiftClientManager.getClient(cloudVo);
			Boolean isPersistentVolume = client.persistentVolumes().withName(pvName).delete().size() == 1;


			if(isPersistentVolume) {
				log.info("Persistent Volume " + pvName + " was successfully deleted.");
			}else {
				Exception e = new Exception("fail deleted");
				throw e;
			}
		} catch (Exception e) {
			throw e;
		}
	}

	// 오픈시프트 PVC 삭제
	public void opsDeletePersistentVolumeClaim(CustomReqProductVO req, CustomOssCloudVO cloudVo, String pvcName) throws Exception {

		String nameSpace = req.getProjectName().toLowerCase();
		try {
			OpenShiftClient client = OpenShiftClientManager.getClient(cloudVo);
			boolean isPersistentVolumeClaim = client.persistentVolumeClaims().inNamespace(nameSpace).withName(pvcName).delete().size() == 1;

			if(isPersistentVolumeClaim) {
				log.info("Persistent Volume Claim " + pvcName + " was successfully deleted.");
			}else {
				Exception e = new Exception("fail deleted");
				throw e;
			}
		} catch (Exception e) {
			throw e;
		}
	}

	public void opsDetachPersistentVolumeClaim(CustomReqProductVO req, CustomOssCloudVO cloudVo, String pvcName) throws Exception {

	    String namespace = req.getProjectName().toLowerCase();
	    String deploymentConfigName = req.getAppName();

	    try {
	        // OpenShift 클라이언트 생성
	        OpenShiftClient client = OpenShiftClientManager.getClient(cloudVo);

	        // 해당 DeploymentConfig 가져오기
	        DeploymentConfig deploymentConfig = client.deploymentConfigs()
	                                                  .inNamespace(namespace)
	                                                  .withName(deploymentConfigName)
	                                                  .get();

	        if (deploymentConfig == null) {
	            throw new Exception("DeploymentConfig " + deploymentConfigName + " not found.");
	        }

	        // 볼륨 및 볼륨 마운트에서 PVC 제거
	        deploymentConfig.getSpec().getTemplate().getSpec().getVolumes().removeIf(volume ->
	            pvcName.equals(volume.getPersistentVolumeClaim().getClaimName())
	        );

	        deploymentConfig.getSpec().getTemplate().getSpec().getContainers().forEach(container -> {
	            container.getVolumeMounts().removeIf(volumeMount ->
	                pvcName.equals(volumeMount.getName())
	            );
	        });

	        // 업데이트된 DeploymentConfig로 패치
	        client.deploymentConfigs()
	              .inNamespace(namespace)
	              .withName(deploymentConfigName)
	              .patch(deploymentConfig);

	        log.info("PVC " + pvcName + " was successfully detached from DeploymentConfig " + deploymentConfigName);

	    } catch (Exception e) {
	        log.error("Failed to detach PVC " + pvcName + " from DeploymentConfig " + deploymentConfigName, e);
	        throw e;
	    }
	}

	public void detachPVCFromDeploymentConfig(String namespace, String deploymentConfigName, String pvcName, CustomOssCloudVO cloudVo) throws Exception {
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

	        // 2. PVC detach: volumes와 volumeMounts에서 PVC 제거
	        deploymentConfig.getSpec().getTemplate().getSpec().getVolumes().removeIf(volume ->
	            pvcName.equals(volume.getPersistentVolumeClaim().getClaimName())
	        );

	        deploymentConfig.getSpec().getTemplate().getSpec().getContainers().forEach(container -> {
	            container.getVolumeMounts().removeIf(volumeMount ->
	                pvcName.equals(volumeMount.getName())
	            );
	        });

	        // 3. DeploymentConfig 업데이트
	        client.deploymentConfigs()
	              .inNamespace(namespace)
	              .withName(deploymentConfigName)
	              .patch(deploymentConfig);

	        System.out.println("PVC " + pvcName + " detached from DeploymentConfig " + deploymentConfigName);

	    } catch (Exception e) {
	        System.err.println("Failed to detach PVC: " + e.getMessage());
	        throw e;
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


	public static void main(String[] args) throws Exception {
		String masterUrl = "https://api.ocp4.3hs.com:6443";
		String username = "kubeadmin";
		String password = "h2bKF-aPjuS-koSxs-KDkQK";

		CustomOssCloudVO cloudVo = new CustomOssCloudVO();
		cloudVo.setApiGatewayServer(masterUrl);
		cloudVo.setAdminUsername(username);
		cloudVo.setAdminPassword(password);

		OpsMethodApiClass ap = new OpsMethodApiClass();
		TemplateList tp = ap.getTemplates(cloudVo);

		System.out.println(tp.getKind());
	}

}
