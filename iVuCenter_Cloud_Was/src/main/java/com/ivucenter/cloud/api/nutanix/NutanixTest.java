
package com.ivucenter.cloud.api.nutanix;

import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;

import org.apache.commons.lang.time.DateFormatUtils;
import org.json.JSONObject;

import com.google.gson.JsonObject;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;
import com.ivucenter.cloud.portal.oss.subnet.CustomOssSubnetVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@SuppressWarnings("unused")
public class NutanixTest {

	public static void main(String[] args) throws Exception {
		CustomOssCloudVO cloudVo = new CustomOssCloudVO();

		// OA 뉴타닉스
		// Calm server
//		cloudVo.setCalmServer("https://30.1.1.194:9440");
//		cloudVo.setCalmAdminUser("admin");
//		cloudVo.setCalmAdminPassword("Kepco123/456");
        // Prism server
//		cloudVo.setApiGatewayServer("https://30.1.1.193:9440");
//		cloudVo.setAdminUsername("admin");
//		cloudVo.setAdminPassword("Kepco123456/");


		//직원모바일
		// Calm server
		cloudVo.setCalmServer("http://100.1.39.21:8000/calm");
		cloudVo.setCalmAdminUser("admin");
		cloudVo.setCalmAdminPassword("Kepco123/456");
		// Prism server
		cloudVo.setApiGatewayServer("http://100.1.39.21:8000/prism");
		cloudVo.setAdminUsername("admin");
		cloudVo.setAdminPassword("Kepco456/123");
		NutanixObject t = NutanixUtils.getBlueprintList(cloudVo);
		System.out.println(t);

		// 직원모바일(DMZ)
		// Calm server
//		cloudVo.setCalmServer("http://100.1.39.20:8000/calm");
//		cloudVo.setCalmAdminUser("admin");
//		cloudVo.setCalmAdminPassword("Kepco123/456");
	    // Prism server
//		cloudVo.setApiGatewayServer("http://100.1.39.20:8000/prism");
//		cloudVo.setAdminUsername("admin");
//		cloudVo.setAdminPassword("Kepco456/123");

		// 협력업체 모바일
		// Calm server
//		cloudVo.setCalmServer("http://100.1.40.20:8000/calm");
	//	cloudVo.setCalmAdminUser("admin");
		//cloudVo.setCalmAdminPassword("Kepco456/123");
		// Prism server
		//cloudVo.setApiGatewayServer("http://100.1.40.20:8000/prism");
		//cloudVo.setAdminUsername("admin");
		//cloudVo.setAdminPassword("Kepco456/123");

		// 협력업체 모바일
		// Calm server
//		cloudVo.setCalmServer("http://100.1.40.120:8000/calm");
//		cloudVo.setCalmAdminUser("admin");
//		cloudVo.setCalmAdminPassword("Kepco456/123");
		// Prism server
//		cloudVo.setApiGatewayServer("http://100.1.40.120:8000/prism");
//		cloudVo.setAdminUsername("admin");
//		cloudVo.setAdminPassword("Kepco456/123");


		// 프로젝트 생성 배치
//		String project_name = "TEST_PROJ2";
//		String project_description = project_name + " 설명";
//		int vcpu_limit = 14;
//		int memory_gb = 25;
//		int storage_gb = 1500;

		// change subnetlist from database
//		CustomOssSubnetVO defaultSubnet = null;;
//		ArrayList<CustomOssSubnetVO> subnets_db = new ArrayList<CustomOssSubnetVO>();
//		NutanixObject subnetlist = NutanixUtils.getSubnetList(cloudVo);
//		for (NutanixObject nobj : subnetlist.getSubnets()) {
//
//			String name = nobj.getObject("spec").getValue("name").toString();
//			String uuid = nobj.getObject("metadata").getValue("uuid").toString();
//
//			CustomOssSubnetVO subnet = new CustomOssSubnetVO();
//			subnet.setName(name);
//			subnet.setUuid(uuid);
//			if (name.equals("VLAN0")) {
//				subnet.setDefault(true);
//				defaultSubnet = subnet;
//			}
//			subnets_db.add(subnet);
//		}
//
//		String[] subnets = new String[subnets_db.size()];
//		log.info("defultSubnet : " + defaultSubnet.toString());
//		int idx = 0;
//		for (Iterator iterator = subnets_db.iterator(); iterator.hasNext();) {
//			CustomOssSubnetVO customOssSubnetVO = (CustomOssSubnetVO) iterator.next();
//			log.info("subnet list : " + customOssSubnetVO.toString());
//			subnets[idx] = customOssSubnetVO.getUuid();
//			idx++;
//		}
//		String default_subnet_uuid = defaultSubnet.getUuid();

//		NutanixObject project = NutanixUtils.createProjectBatch(cloudVo, project_name, project_description, default_subnet_uuid, subnets, vcpu_limit, memory_gb, storage_gb);
//
//		log.info("project name : " + project.getObject("spec").getValue("name"));
//		log.info("project uuid : " + project.getObject("metadata").getValue("uuid"));

//		System.out.println(NutanixUtils.getEnvironmentDefault(cloudVo));
//		NutanixObject project = NutanixUtils.createProjectByDefaultBatch(cloudVo, project_name, project_description, vcpu_limit, memory_gb, storage_gb);
//		log.info("project name : " + project.getObject("spec").getValue("name"));
//		log.info("project uuid : " + project.getObject("metadata").getValue("uuid"));
//
//
//		 getProjectList(cloudVo);

//		 NutanixUtils.deleteProject(cloudVo, "523474ff-1be4-45b3-922b-43ffcb3f2cbf");


//		 getMarketplaceItemList(cloudVo);
		// app 배포 배치
//		String project_uuid = "be1f5b58-7e4c-4a13-bc22-1fbeacaf5626";
//		String marketplace_item_uuid = "80167c81-19e5-4cad-801b-45a17c519cf6";
//		String vm_name = "new-vm-1ip";
//		int vcpu = 2;
//		int mem_mb = 2048;
//		int disk_gb = 700;
//		String ipaddress = "10.10.10.122";

//		NutanixObject app = NutanixUtils.simpleLaunchBatch(cloudVo, marketplace_item_uuid, project_uuid, vm_name, ipaddress, vcpu, mem_mb, disk_gb);

//		NutanixObject apps = NutanixUtils.getAppList(cloudVo);
//		for (NutanixObject nutanixObject : apps.getApps()) {
//			log.info("name : " + nutanixObject.getObject("metadata").getValue("name"));
//			log.info("uuid : " + nutanixObject.getObject("metadata").getValue("uuid"));
//		}

//		NutanixObject apps = NutanixUtils.getApp(cloudVo, "68b58360-1d6e-43ff-8e39-4d04dc75ef37");
//
//		log.info("vm_name : "+apps.getVmName());
//		log.info("vm_uuid : "+apps.getVmUuid());

//		System.out.println(NutanixUtils.getVmDetail(cloudVo, apps.getVmUuid()));
//
//		getVmDetail(cloudVo, "562b8d21-ff00-499e-a57e-5338ffcc54d6");//
//		System.out.println(NutanixUtils.getProject(cloudVo, project_uuid));
//		System.out.println(NutanixUtils.getEnvironment(cloudVo, "6584cd35-f8b1-4467-a55f-911d75132190"));
//
//
//
//
//		String default_project_uuid = "85c80741-cf14-4add-b455-511c24d1b585";
//
//
//		getSubnetList(cloudVo);
//
//		String subnet_uuid = "561ae2b1-1de5-40af-835c-ca8dcf082da1";
//		String cluster_uuid = "0005df59-e10a-3f80-0000-00000000c514";
////		getSubnet(cloudVo, subnet_uuid);
//
////		getAccountList(cloudVo);
//		String account_uuid = "7f172dda-a16c-4f49-bb23-53c422de8643";
////		getAccount(cloudVo, account_uuid);

//		String project_uuid = "027ec570-5cac-454a-a0c3-9ce88378ff46";
////		getEnvironmentList(cloudVo);
//		String default_env_uuid = "4ca41eec-948a-d57f-2d73-0d1b8225f5bf";
////		getEnvironment(cloudVo, env_uuid);
//
////		createEnvironment(cloudVo, default_env_uuid, project_name, project_uuid, default_subnet_uuid, default_subnet_uuid);
//
//		String env_uuid = "d869a9de-7903-4bbb-901a-69efc4ebc245";
//
////		Project 에 Environment 할당
////		attachEnvironment(cloudVo, project_uuid, env_uuid);
//
//		getMarketplaceItemList(cloudVo);
//		String marketplace_item_uuid = "0aa3d7d8-e091-4898-88fd-5224d257979b";
//
//		attachProject(cloudVo, marketplace_item_uuid, project_name, project_uuid);
//		getMarketplaceItem(cloudVo, marketplace_item_uuid);
//
////		getProject(cloudVo, project_uuid);
//
////		convertMarketplaceItemToBluePrint(cloudVo, marketplace_item_uuid, project_uuid, env_uuid);
//
//		String blueprint_uuid = "877605de-db2b-4e6a-bf65-d35e0e4d5bdf";
//
//		// * 새로 작성한 blueprint가 list에서 보이지 않음 (문의사항)
////		getBlueprint(cloudVo, blueprint_uuid);
//
////		getBlueprintRuntimeEditables(cloudVo, blueprint_uuid);
//
//		String vm_name = "TEST_HOST1";
//		int vcpu = 2;
//		int mem_mb = 2048;
//		int disk_gb = 450;
//
////		simpleLaunch(cloudVo, blueprint_uuid, vm_name, vcpu, mem_mb, disk_gb);
//
//		String request_id = "4d734545-a5a1-4799-a3d0-7633a4208d16";
////		getBlueprintStatus(cloudVo, blueprint_uuid, request_id);
//
//		// defualt project uuid
////		String default_project_uuid = "85c80741-cf14-4add-b455-511c24d1b585";
//
////		getProject(cloudVo, default_project_uuid);
//
////		getProject(cloudVo, "93f0898a-c871-440b-aa0d-7b05e246d913");
//
//		getVmList(cloudVo);
//
//		String vm_uuid = "7669b408-eed6-444d-baa7-68198a7e63cb";
//		getVmDetail(cloudVo, vm_uuid);
//
//		String vmdisk_uuid = "6e39f8aa-70f4-421c-933b-f20530b8922c";
//		String device_uuid = "c53fb07f-b426-446c-a7fd-c348fd9e1746";
//		String storage_container_uuid = "2b7cf718-a65c-45b4-81bc-33e900ab801f";
//
//		String host_uuid = "5c1d5762-6264-4d08-89b8-402c90933568";
//
////		long mb_size = 100l;
////		attachVmDisk(cloudVo, vm_uuid, storage_container_uuid, mb_size);
////		updateVmDisk(cloudVo, vm_uuid, vmdisk_uuid, device_uuid, storage_container_uuid, mb_size);
////		detachVmDisk(cloudVo, vm_uuid, vmdisk_uuid, device_uuid);
//		// 온라인 상태일때 vcpu memory를 동시에 업데이트 할수 없음
////		updateVmVcpus(cloudVo, vm_uuid, 4);
////		updateVmMemory(cloudVo, vm_uuid, 5120);
////		updateVmPowerState(cloudVo, vm_uuid, host_uuid, NutanixPowerState.OFF);
//
//		String task_uuid = "ef081deb-17d2-476e-ae77-110f25d23637";
////		getTaskStatus(cloudVo, task_uuid);
//
////		getBlueprintList(cloudVo);
//
////		String blueprint_uuid = "df6dd7fe-d4f0-6760-b0b7-1ead02a8791a";
////		getBlueprintResource(cloudVo, blueprint_uuid);
//
//		String app_profile_reference_name = "Default";
//		String app_profile_reference_uuid = "129fe488-44bb-56ce-2d19-3f01e0689196";
//		String app_profile_reference_kind = "app_profile";
//		String app_name = "TEST APP 3hs";
//		String app_description = "TEST APP 3hs API TEST";
//
////		launchBlueprint(cloudVo, blueprint_uuid, app_profile_reference_name, app_profile_reference_uuid, app_profile_reference_kind, app_name, app_description);
//
//		String app_uuid = "0ad9890f-8849-4f68-8538-658a423f0570";
////		getAppDetail(cloudVo, app_uuid);
//
//		// 해당 vm이 같이 삭제됨
////		deleteApp(cloudVo, app_uuid);
	}

	private static void getBlueprintStatus(CustomOssCloudVO cloudVo, String blueprint_uuid, String request_id)
			throws Exception {
		NutanixObject nutanixObject = NutanixUtils.getBlueprintStatus(cloudVo, blueprint_uuid, request_id);

		log.info(nutanixObject.toString());
		log.info("application_uuid : " + nutanixObject.getObject("status").getValue("application_uuid"));
		log.info("app_name : " + nutanixObject.getObject("status").getValue("app_name"));
		log.info("state : " + nutanixObject.getObject("status").getValue("state"));
		log.info("--------------------------------");
	}

	private static void getAppDetail(CustomOssCloudVO cloudVo, String app_uuid) throws Exception {
		NutanixObject nutanixObject = NutanixUtils.getAppDetail(cloudVo, app_uuid);
		log.info("application_uuid : " + nutanixObject.getObject("metadata").getValue("uuid"));
		log.info("app_name : " + nutanixObject.getObject("metadata").getValue("name"));
		log.info("state : " + nutanixObject.getObject("status").getValue("state"));
		log.info("--------------------------------");
	}

	private static void deleteApp(CustomOssCloudVO cloudVo, String app_uuid) throws Exception {
		NutanixObject nutanixObject = NutanixUtils.deleteApp(cloudVo, app_uuid);
		log.info("application_uuid : " + nutanixObject.getObject("metadata").getValue("uuid"));
		log.info("app_name : " + nutanixObject.getObject("metadata").getValue("name"));
		log.info("state : " + nutanixObject.getObject("status").getValue("state"));
		log.info("--------------------------------");
	}

	private static void launchBlueprint(CustomOssCloudVO cloudVo, String blueprint_uuid,
			String app_profile_reference_name, String app_profile_reference_uuid, String app_profile_reference_kind,
			String app_name, String app_description) throws Exception {
		NutanixObject nutanixObject = NutanixUtils.launchBlueprint(cloudVo, blueprint_uuid, app_profile_reference_name,
				app_profile_reference_uuid, app_profile_reference_kind, app_name, app_description);

		log.info(nutanixObject.getObject("status").getValue("request_id").toString());
		log.info("--------------------------------");
	}

	private static void getBlueprint(CustomOssCloudVO cloudVo, String blueprint_uuid) throws Exception {
		NutanixObject blueprint = NutanixUtils.getBlueprint(cloudVo, blueprint_uuid);

		log.info("name : " + blueprint.getObject("spec").getValue("name"));
		log.info("state : " + blueprint.getObject("status").getValue("state"));

	}

	private static void getBlueprintRuntimeEditables(CustomOssCloudVO cloudVo, String blueprint_uuid) throws Exception {
		NutanixObject blueprint = NutanixUtils.getBlueprintRuntimeEditables(cloudVo, blueprint_uuid);

		log.info(blueprint.toString());
//		log.info("name : "+blueprint.getObject("spec").getValue("name"));
//		log.info("state : "+blueprint.getObject("status").getValue("state"));

	}

	private static void getBlueprintResource(CustomOssCloudVO cloudVo, String blueprint_uuid) throws Exception {
		NutanixObject blueprintResourceList = NutanixUtils.getBlueprintRuntimeEditables(cloudVo, blueprint_uuid);

		for (NutanixObject nutanixObject : blueprintResourceList.getBlueprintResources()) {
			log.info("app_profile_reference name : "
					+ nutanixObject.getObject("app_profile_reference").getValue("name"));
			log.info("app_profile_reference uuid : "
					+ nutanixObject.getObject("app_profile_reference").getValue("uuid"));
			log.info("app_profile_reference kind : "
					+ nutanixObject.getObject("app_profile_reference").getValue("kind"));
		}
	}

	private static void getBlueprintList(CustomOssCloudVO cloudVo) throws Exception {
		NutanixObject blueprintList = NutanixUtils.getBlueprintList(cloudVo);

		for (NutanixObject nutanixObject : blueprintList.getBlueprints()) {
			log.info("name : " + nutanixObject.getObject("metadata").getValue("name"));
			log.info("uuid : " + nutanixObject.getObject("metadata").getValue("uuid"));
			log.info("spec_version : " + nutanixObject.getObject("metadata").getValue("spec_version"));
			log.info("project_reference name : "
					+ nutanixObject.getObject("metadata").getObject("project_reference").getValue("name"));
			log.info("project_reference uuid : "
					+ nutanixObject.getObject("metadata").getObject("project_reference").getValue("uuid"));
			log.info("project_reference AppFamily : "
					+ nutanixObject.getObject("metadata").getObject("categories").getValue("AppFamily"));
			log.info("state : " + nutanixObject.getObject("status").getValue("state"));
		}
	}

	private static void getTaskStatus(CustomOssCloudVO cloudVo, String task_uuid) throws Exception {
		NutanixObject nutanixObject = NutanixUtils.getTaskStatus(cloudVo, task_uuid);

		log.info("operation_type : " + nutanixObject.getValue("operation_type"));
		log.info("error_code : " + nutanixObject.getObject("meta_response").getValue("error_code"));
		log.info("percentage_complete : " + nutanixObject.getValue("percentage_complete"));
		log.info("progress_status : " + nutanixObject.getValue("progress_status"));
	}

	private static void attachVmDisk(CustomOssCloudVO cloudVo, String vm_uuid, String storage_container_uuid,
			long mb_size) throws Exception {
		NutanixObject nutanixObject = NutanixUtils.attachDisk(cloudVo, vm_uuid, storage_container_uuid, mb_size);
		log.info("task_uuid : " + nutanixObject.getValue("task_uuid"));
	}

	private static void updateVmDisk(CustomOssCloudVO cloudVo, String vm_uuid, String vmdisk_uuid, String device_uuid,
			String storage_container_uuid, long mb_size) throws Exception {
		NutanixObject nutanixObject = NutanixUtils.updateDisk(cloudVo, vm_uuid, vmdisk_uuid, device_uuid,
				storage_container_uuid, mb_size);
		log.info("task_uuid : " + nutanixObject.getValue("task_uuid"));
	}

	private static void updateVmVcpus(CustomOssCloudVO cloudVo, String vm_uuid, int num_vcpus) throws Exception {
		NutanixObject nutanixObject = NutanixUtils.updateVmVcpus(cloudVo, vm_uuid, num_vcpus);
		log.info("task_uuid : " + nutanixObject.getValue("task_uuid"));
	}

	private static void updateVmMemory(CustomOssCloudVO cloudVo, String vm_uuid, int memory_mb) throws Exception {
		NutanixObject nutanixObject = NutanixUtils.updateVmMemory(cloudVo, vm_uuid, memory_mb);
		log.info("task_uuid : " + nutanixObject.getValue("task_uuid"));
	}

	private static void updateVmPowerState(CustomOssCloudVO cloudVo, String vm_uuid, String host_uuid,
			NutanixPowerState power_state) throws Exception {
		NutanixObject nutanixObject = NutanixUtils.updateVmPowerState(cloudVo, vm_uuid, host_uuid, power_state);
		log.info("task_uuid : " + nutanixObject.getValue("task_uuid"));
	}

	private static void detachVmDisk(CustomOssCloudVO cloudVo, String vm_uuid, String vmdisk_uuid, String device_uuid)
			throws Exception {
		NutanixObject nutanixObject = NutanixUtils.detachDisk(cloudVo, vm_uuid, vmdisk_uuid, device_uuid);
		log.info("task_uuid : " + nutanixObject.getValue("task_uuid"));
	}

	private static void getVmDetail(CustomOssCloudVO cloudVo, String vm_uuid) throws Exception {
		NutanixObject vmdetail = NutanixUtils.getVmDetail(cloudVo, vm_uuid);
		log.info("name : " + vmdetail.getValue("name"));
		log.info("uuid : " + vmdetail.getValue("uuid"));
		log.info("host_uuid : " + vmdetail.getValue("host_uuid"));
		log.info("memory_mb : " + vmdetail.getValue("memory_mb"));
		log.info("num_vcpus : " + vmdetail.getValue("num_vcpus"));
		log.info("power_state : " + vmdetail.getValue("power_state"));

		List<NutanixObject> vmDiskList = vmdetail.getVDisks();
		for (NutanixObject nutanixObject : vmDiskList) {
			log.info("vm_uuid : " + vmdetail.getValue("uuid"));
			log.info("vmdisk_uuid : " + nutanixObject.getObject("disk_address").getValue("vmdisk_uuid"));
			log.info("is_cdrom : " + nutanixObject.getValue("is_cdrom"));
			log.info("device_uuid : " + nutanixObject.getObject("disk_address").getValue("device_uuid"));
			log.info("storage_container_uuid : " + nutanixObject.getValue("storage_container_uuid"));
			log.info("size : " + nutanixObject.getValue("size"));
		}

		List<NutanixObject> vmNicList = vmdetail.getVNics();
		for (NutanixObject nutanixObject : vmNicList) {
			log.info("mac_address : " + nutanixObject.getValue("mac_address"));
			log.info("network_uuid : " + nutanixObject.getValue("network_uuid"));
			log.info("vlan_mode : " + nutanixObject.getValue("vlan_mode"));
		}
	}

	private static void getVmList(CustomOssCloudVO cloudVo) throws Exception {
		NutanixObject nObj = NutanixUtils.getVmList(cloudVo);

		for (NutanixObject nutanixObject : nObj.getVMs()) {
			log.info("name : " + nutanixObject.getValue("name"));
			log.info("uuid : " + nutanixObject.getValue("uuid"));
			log.info("num_vcpus : " + nutanixObject.getValue("num_vcpus"));
			log.info("uefi_boot : " + nutanixObject.getObject("boot").getValue("uefi_boot"));
			log.info("VGA_CONSOLE : " + nutanixObject.getObject("vm_features").getValue("VGA_CONSOLE"));
		}
	}

	private static void getProjectList(CustomOssCloudVO cloudVo) throws Exception {
		NutanixObject nObj = NutanixUtils.getProjectList(cloudVo);

		for (NutanixObject nutanixObject : nObj.getProjects()) {
			log.info("project name : " + nutanixObject.getObject("spec").getValue("name"));
			log.info("project uuid : " + nutanixObject.getObject("metadata").getValue("uuid"));
//			for (NutanixObject account : nutanixObject.getAccountReferences()) {
//				log.info("kind : "+account.getValue("kind"));
//				log.info("account uuid : "+account.getValue("uuid"));
//			}
//
//			NutanixObject defaultSubnet = nutanixObject.getDefaultSubnetReference();
//			log.info("default subnet kind : "+defaultSubnet.getValue("kind"));
//			log.info("default subnet uuid : "+defaultSubnet.getValue("uuid"));
//
//			for (NutanixObject subnet : nutanixObject.getSubnetReferences()) {
//				log.info("kind : "+subnet.getValue("kind"));
//				log.info("name : "+subnet.getValue("name"));
//				log.info("account uuid : "+subnet.getValue("uuid"));
//			}

		}
	}

	private static void getProject(CustomOssCloudVO cloudVo, String project_uuid) throws Exception {
		NutanixObject nutanixObject = NutanixUtils.getProject(cloudVo, project_uuid);
		log.info("project name : " + nutanixObject.getObject("spec").getValue("name"));
		log.info("project uuid : " + nutanixObject.getObject("metadata").getValue("uuid"));
		for (NutanixObject account : nutanixObject.getAccountReferences()) {
			log.info("kind : " + account.getValue("kind"));
			log.info("account uuid : " + account.getValue("uuid"));
		}

		NutanixObject defaultSubnet = nutanixObject.getDefaultSubnetReference();
		log.info("default subnet kind : " + defaultSubnet.getValue("kind"));
		log.info("default subnet uuid : " + defaultSubnet.getValue("uuid"));

		for (NutanixObject subnet : nutanixObject.getSubnetReferences()) {
			log.info("kind : " + subnet.getValue("kind"));
			log.info("name : " + subnet.getValue("name"));
			log.info("account uuid : " + subnet.getValue("uuid"));
		}

		log.info("environment uuid : " + nutanixObject.getObject("spec").getObject("resources")
				.getObject("default_environment_reference").getValue("uuid"));

	}

	private static void createProject(CustomOssCloudVO cloudVo, String name, String description, int vCpu, int memory,
			int storage, String account_uuid, String default_subnet_uuid, String subnet_uuid, String cluster_uuid)
			throws Exception {
		NutanixObject nutanixObject = NutanixUtils.createProject(cloudVo, name, description, vCpu, memory, storage,
				account_uuid, default_subnet_uuid, subnet_uuid, cluster_uuid);

		log.info("state : " + nutanixObject.getObject("status").getValue("state"));
		log.info("uuid : " + nutanixObject.getObject("metadata").getValue("uuid"));
		log.info("--------------------------------");
	}

	private static void getEnvironmentList(CustomOssCloudVO cloudVo) throws Exception {
		NutanixObject nutanixObject = NutanixUtils.getEnvironmentList(cloudVo);
		for (NutanixObject nobj : nutanixObject.getSubnets()) {
			log.info("environment name : " + nobj.getObject("metadata").getValue("name"));
			log.info("environment uuid : " + nobj.getObject("metadata").getValue("uuid"));
			log.info("--------------------------------");
		}
	}

	private static void getEnvironment(CustomOssCloudVO cloudVo, String env_uuid) throws Exception {
		NutanixObject nobj = NutanixUtils.getEnvironment(cloudVo, env_uuid);
		log.info("environment name : " + nobj.getObject("metadata").getValue("name"));
		log.info("environment uuid : " + nobj.getObject("metadata").getValue("uuid"));
		log.info("--------------------------------");
	}

	private static void createEnvironment(CustomOssCloudVO cloudVo, String default_env_uuid, String project_name,
			String project_uuid, String default_subnet_uuid, String[] subnets) throws Exception {
		NutanixObject nobj = NutanixUtils.createEnvironment(cloudVo, default_env_uuid, project_name, project_uuid,
				default_subnet_uuid, subnets);

		log.info("env name : " + nobj.getObject("spec").getValue("name"));
		log.info("default subnet name : " + nobj.getObject("spec").getObject("resources")
				.getArray("infra_inclusion_list").get(0).getObject("default_subnet_reference").getValue("uuid"));
		log.info("subnet name : " + nobj.getObject("spec").getObject("resources").getArray("infra_inclusion_list")
				.get(0).getArray("subnet_references").get(0).getValue("uuid"));
		log.info("vm nic subnet : " + nobj.getObject("spec").getObject("resources")
				.getArray("substrate_definition_list").get(0).getObject("create_spec").getObject("resources")
				.getArray("nic_list").get(0).getObject("subnet_reference").getValue("uuid"));
		log.info("BP UUID : " + nobj.getObject("spec").getObject("resources").getArray("substrate_definition_list")
				.get(0).getValue("uuid"));
		log.info("BP UUID : " + nobj.getObject("spec").getObject("resources").getArray("substrate_definition_list")
				.get(1).getValue("uuid"));
		log.info("Credential UUID : " + nobj.getObject("spec").getObject("resources")
				.getArray("credential_definition_list").get(0).getValue("uuid"));
		log.info("--------------------------------");
	}

	private static void attachEnvironment(CustomOssCloudVO cloudVo, String project_uuid, String env_uuid)
			throws Exception {
		NutanixObject nobj = NutanixUtils.attachEnvironment(cloudVo, project_uuid, env_uuid);

		log.info("state : " + nobj.getObject("status").getValue("state"));
		log.info("task_uuid : " + nobj.getObject("status").getObject("execution_context").getValue("task_uuid"));
		log.info("--------------------------------");
	}

	private static void attachProject(CustomOssCloudVO cloudVo, String marketplace_item_uuid, String project_name,
			String project_uuid) throws Exception {
		NutanixObject nobj = NutanixUtils.attachProjectMarketPlaceItem(cloudVo, marketplace_item_uuid, project_name, project_uuid);

		log.info("marketplace_item name : " + nobj.getObject("metadata").getValue("name"));
		log.info("marketplace_item uuid : " + nobj.getObject("metadata").getValue("uuid"));
		log.info("marketplace_item app_state : "
				+ nobj.getObject("status").getObject("resources").getValue("app_state"));
		log.info("marketplace_item version : " + nobj.getObject("status").getObject("resources").getValue("version"));
		for (NutanixObject account : nobj.getPeojectReferences()) {
			log.info("ref project name : " + account.getValue("name"));
			log.info("ref project uuid : " + account.getValue("uuid"));
		}
		log.info("--------------------------------");
	}

	private static void convertMarketplaceItemToBluePrint(CustomOssCloudVO cloudVo, String marketplace_item_uuid,
			String project_uuid, String env_uuid) throws Exception {
		NutanixObject nobj = NutanixUtils.convertMarketplaceItemToBluePrint(cloudVo, marketplace_item_uuid,
				project_uuid, env_uuid);

		log.info("status : " + nobj.getObject("status").getValue("state"));
		log.info("name : " + nobj.getObject("metadata").getValue("name"));
		log.info("uuid : " + nobj.getObject("metadata").getValue("uuid"));
		log.info("--------------------------------");
	}

	private static void getSubnetList(CustomOssCloudVO cloudVo) throws Exception {
		NutanixObject nutanixObject = NutanixUtils.getSubnetList(cloudVo);
		for (NutanixObject nobj : nutanixObject.getSubnets()) {
			log.info("subnet name : " + nobj.getObject("spec").getValue("name"));
			log.info("subnet uuid : " + nobj.getObject("metadata").getValue("uuid"));
			log.info("cluster_reference name : "
					+ nobj.getObject("spec").getObject("cluster_reference").getValue("name"));
			log.info("cluster_reference uuid : "
					+ nobj.getObject("spec").getObject("cluster_reference").getValue("uuid"));
			log.info("--------------------------------");
		}
	}

	private static void getSubnet(CustomOssCloudVO cloudVo, String uuid) throws Exception {
		NutanixObject nobj = NutanixUtils.getSubnet(cloudVo, uuid);
		log.info("subnet name : " + nobj.getObject("spec").getValue("name"));
		log.info("subnet uuid : " + nobj.getObject("metadata").getValue("uuid"));
		log.info("cluster_reference name : " + nobj.getObject("spec").getObject("cluster_reference").getValue("name"));
		log.info("cluster_reference uuid : " + nobj.getObject("spec").getObject("cluster_reference").getValue("uuid"));
		log.info("--------------------------------");
	}

	private static void getAccountList(CustomOssCloudVO cloudVo) throws Exception {
		NutanixObject nutanixObject = NutanixUtils.getAccountList(cloudVo);
		for (NutanixObject nobj : nutanixObject.getAccounts()) {
			log.info("account name : " + nobj.getObject("metadata").getValue("name"));
			log.info("account uuid : " + nobj.getObject("metadata").getValue("uuid"));
			log.info("--------------------------------");
		}
	}

	private static void getAccount(CustomOssCloudVO cloudVo, String uuid) throws Exception {
		NutanixObject nobj = NutanixUtils.getAccount(cloudVo, uuid);
		log.info("account name : " + nobj.getObject("metadata").getValue("name"));
		log.info("account uuid : " + nobj.getObject("metadata").getValue("uuid"));
		log.info("--------------------------------");
	}

	private static void getMarketplaceItemList(CustomOssCloudVO cloudVo) throws Exception {
		NutanixObject nutanixObject = NutanixUtils.getMarketplaceItemList(cloudVo);
		for (NutanixObject nobj : nutanixObject.getMarketplaceItems()) {
			log.info("marketplace_item name : " + nobj.getObject("metadata").getValue("name"));
			log.info("marketplace_item uuid : " + nobj.getObject("metadata").getValue("uuid"));
			log.info("marketplace_item app_state : " + nobj.getObject("status").getValue("app_state"));
			log.info("marketplace_item version : " + nobj.getObject("status").getValue("version"));
			log.info("--------------------------------");
		}
	}

	private static void getMarketplaceItem(CustomOssCloudVO cloudVo, String uuid) throws Exception {
		NutanixObject nobj = NutanixUtils.getMarketplaceItem(cloudVo, uuid);
		log.info("marketplace_item name : " + nobj.getObject("metadata").getValue("name"));
		log.info("marketplace_item uuid : " + nobj.getObject("metadata").getValue("uuid"));
		log.info("marketplace_item app_state : "
				+ nobj.getObject("status").getObject("resources").getValue("app_state"));
		log.info("marketplace_item version : " + nobj.getObject("status").getObject("resources").getValue("version"));
		for (NutanixObject account : nobj.getPeojectReferences()) {
			log.info("ref project name : " + account.getValue("name"));
			log.info("ref project uuid : " + account.getValue("uuid"));
		}
		log.info("--------------------------------");
	}

	private static void getBlueprintRuntimeEditable(CustomOssCloudVO cloudVo, String uuid) throws Exception {
		NutanixObject nobj = NutanixUtils.getAccount(cloudVo, uuid);
		log.info("account name : " + nobj.getObject("metadata").getValue("name"));
		log.info("account uuid : " + nobj.getObject("metadata").getValue("uuid"));
		log.info("--------------------------------");
	}

	private static void simpleLaunch(CustomOssCloudVO cloudVo, String blueprint_uuid, String vm_name, String ipaddress, String gatewayadress, String dns1, String dns2, int vcpu,
			int mem_mb, int disk_gb, String subnet_uuid) throws Exception {
		NutanixObject nutanixObject = NutanixUtils.simpleLaunch(cloudVo, blueprint_uuid, vm_name, ipaddress, gatewayadress, dns1, dns2, vcpu, mem_mb,
				disk_gb, subnet_uuid);

		log.info(nutanixObject.getObject("status").getValue("request_id").toString());
		log.info("--------------------------------");
	}
}
