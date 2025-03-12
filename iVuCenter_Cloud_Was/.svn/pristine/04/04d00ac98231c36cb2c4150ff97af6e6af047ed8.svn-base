package com.ivucenter.cloud.api.common.batch;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

import com.ivucenter.cloud.api.common.utils.SystemCalculatorInfo;
import com.ivucenter.cloud.api.openstack.OpenStackUsage;
import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.api.openstack.interfaces.AbstractFactory;
import com.ivucenter.cloud.api.openstack.interfaces.AlarmIF;
import com.ivucenter.cloud.api.openstack.interfaces.FlavorIF;
import com.ivucenter.cloud.api.openstack.interfaces.HypervisorIF;
import com.ivucenter.cloud.api.openstack.interfaces.NetworkQuotaIF;
import com.ivucenter.cloud.api.openstack.interfaces.ProjectIF;
import com.ivucenter.cloud.api.openstack.interfaces.RoleIF;
import com.ivucenter.cloud.api.openstack.interfaces.SecurityGroupIF;
import com.ivucenter.cloud.api.openstack.interfaces.SecurityGroupRuleIF;
import com.ivucenter.cloud.api.openstack.interfaces.ServerIF;
import com.ivucenter.cloud.api.openstack.interfaces.ServerQuotaIF;
import com.ivucenter.cloud.api.openstack.interfaces.UserIF;
import com.ivucenter.cloud.api.openstack.interfaces.VolumeIF;
import com.ivucenter.cloud.api.openstack.object.Alarm;
import com.ivucenter.cloud.api.openstack.object.BlockDeviceStorageMapping;
import com.ivucenter.cloud.api.openstack.object.Flavor;
import com.ivucenter.cloud.api.openstack.object.Hypervisor;
import com.ivucenter.cloud.api.openstack.object.NetworkQuota;
import com.ivucenter.cloud.api.openstack.object.OpenStackComplexQuota;
import com.ivucenter.cloud.api.openstack.object.Project;
import com.ivucenter.cloud.api.openstack.object.QuotaSet;
import com.ivucenter.cloud.api.openstack.object.Role;
import com.ivucenter.cloud.api.openstack.object.SecurityGroup;
import com.ivucenter.cloud.api.openstack.object.SecurityGroupRule;
import com.ivucenter.cloud.api.openstack.object.Server;
import com.ivucenter.cloud.api.openstack.object.StoragePool;
import com.ivucenter.cloud.api.openstack.object.StoragePoolCapabilities;
import com.ivucenter.cloud.api.openstack.object.User;
import com.ivucenter.cloud.api.openstack.object.Volume;
import com.ivucenter.cloud.api.vRealize.interfaces.vraAbstractFactory;
import com.ivucenter.cloud.api.vRealize.interfaces.vraDiskIF;
import com.ivucenter.cloud.api.vRealize.interfaces.vraHostIF;
import com.ivucenter.cloud.api.vRealize.interfaces.vraProjectIF;
import com.ivucenter.cloud.api.vRealize.interfaces.vraServerIF;
import com.ivucenter.cloud.api.vRealize.object.vraAdministrators;
import com.ivucenter.cloud.api.vRealize.object.vraBlockDevice;
import com.ivucenter.cloud.api.vRealize.object.vraDefinition;
import com.ivucenter.cloud.api.vRealize.object.vraEntitlementsObject;
import com.ivucenter.cloud.api.vRealize.object.vraHostContent;
import com.ivucenter.cloud.api.vRealize.object.vraJsonObject;
import com.ivucenter.cloud.api.vRealize.object.vraMachine;
import com.ivucenter.cloud.api.vRealize.object.vraProjectObject;
import com.ivucenter.cloud.api.vRealize.object.vraZone;
import com.ivucenter.cloud.api.vRealize.object.vraZoneAssignmentConfigurations;
import com.ivucenter.cloud.api.vRealize.object.vraZones;
import com.ivucenter.cloud.api.vmware.interfaces.VmAbstractFactory;
import com.ivucenter.cloud.api.vmware.interfaces.VmDataStoreIF;
import com.ivucenter.cloud.api.vmware.object.VmDataStoreObject;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;
import com.ivucenter.cloud.portal.oss.disk.CustomStorageVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class BatchProcessor {

	public static List<OpenStackUsage> getCloudUsage(CustomOssCloudVO cloudVo)
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {

		HypervisorIF apiIF = AbstractFactory.getHypervisorIF(cloudVo);
		VolumeIF apiVolumeIF = AbstractFactory.getVolumeIF(cloudVo);

		Map<String, OpenStackUsage> openStackUsages = new HashMap<String, OpenStackUsage>();
		List<Hypervisor> list = apiIF.getHypervisors();
		OpenStackUsage totalUsage = new OpenStackUsage();
		totalUsage.setProjectName("ALL");
		totalUsage.setProjectId("ALL");
		int hypervisor_gb = 0;
		int memory_mb = 0;
		int memory_mb_used = 0;
		int vcpus = 0;
		int vcpus_used = 0;
		int tmpVmTotal = 0;
		int hypervisorCnt = 0;
		SystemCalculatorInfo systemCalculatorInfo = new SystemCalculatorInfo();
		double memoryCalculator = 0;
		double cpuCalculator = 0;
		int vmCalculator = 0;
		if(systemCalculatorInfo.getMemoryCalculator().replaceAll("[^0-9]","") != null) {
			memoryCalculator = Double.parseDouble(systemCalculatorInfo.getMemoryCalculator());
		} else {
			memoryCalculator = 2;
		}
		if(systemCalculatorInfo.getCpuCalculator().replaceAll("[^0-9]","") != null) {
			cpuCalculator = Double.parseDouble(systemCalculatorInfo.getCpuCalculator());
		} else {
			cpuCalculator = 2;
		}
		if(systemCalculatorInfo.getVmCalculator().replaceAll("[^0-9]","") != null) {
			vmCalculator = Integer.parseInt(systemCalculatorInfo.getVmCalculator());
		} else {
			vmCalculator = 4096;
		}
		for (Hypervisor obj : list) {
			//hypervisor_gb = obj.getLocal_gb();
			memory_mb += obj.getMemory_mb();
			memory_mb_used += obj.getMemory_mb_used();
			vcpus += obj.getVcpus();
			vcpus_used += obj.getVcpus_used();
			// 기본적으로 Hypervisor는 4096 메모리를 사용 : 이에 따른 메모리 보정이 필요
//			if (++hypervisorCnt == list.size()) {
//				memory_mb_used -= (4096 * hypervisorCnt);
//			}
		}
		// DISK는 스토리지 이용으로 별도 수집
		List<CustomStorageVO> storageList = new ArrayList();
		List<StoragePool> storagePoolList = apiVolumeIF.getStoregPools();
		for (StoragePool obj : storagePoolList) {
				StoragePoolCapabilities tmp = obj.getCapabilities();
				hypervisor_gb += tmp.getTotalCapacityGb();
				CustomStorageVO storage = new CustomStorageVO();
				storage.setCloudId(cloudVo.getCloudId());
				storage.setStorageId(obj.getName());
				storage.setStorageType(tmp.getVolumeBackendName());
				storage.setUsedSpace(tmp.getAllocatedCapacityGb());
				storage.setTotalSpace(tmp.getTotalCapacityGb());
				storageList.add(storage);
		}

		// 하이퍼바이져 단위의 전체 가용량
		totalUsage.setDiskTotal(hypervisor_gb);
		totalUsage.setMemTotal((int)(memory_mb));
		totalUsage.setMemUsed(memory_mb_used);
		totalUsage.setMemAvail(totalUsage.getMemTotal() - totalUsage.getMemUsed());
		// 메모리 총 용량에서 4G 가상서버 만들었을때를 가정하여 VM 갯수
		int tmpMemVmTotal = (totalUsage.getMemTotal()) / vmCalculator;
		totalUsage.setVCpuTotal(vcpus * 8);
		totalUsage.setVCpuUsed(vcpus_used);
		totalUsage.setVCpuAvail(totalUsage.getVCpuTotal() - totalUsage.getVCpuUsed());

		// CPU 여유용량에서 2Core 가상서버 만들었을때를 가정하여 VM 갯수
		int tmpCpuVmTotal = (int)((totalUsage.getVCpuTotal()) / cpuCalculator);

		// CPU 와 메모리의 VM 갯수에서 더 적은 것을 입력
		tmpVmTotal = tmpMemVmTotal;

		if ( tmpMemVmTotal > tmpCpuVmTotal ) {
			tmpVmTotal = tmpCpuVmTotal;
		}


		String projectName = "admin";
		VolumeIF volumeIF = AbstractFactory.getVolumeIF(projectName,cloudVo);

		ServerQuotaIF serverQuotaIF = AbstractFactory.getServerQuotaIF(cloudVo);
		ProjectIF projectIF = AbstractFactory.getProject(cloudVo);
		String adminProjectId = "";
		List<Project> projects = projectIF.getProjects();
		for (Project project : projects) {
			if (project.getName().equalsIgnoreCase("admin"))
				adminProjectId = project.getId();
		}
		for (Project project : projects) {
			OpenStackUsage projectdUsage = new OpenStackUsage();
			projectdUsage.setCloudId(cloudVo.getCloudId());
			projectdUsage.setProjectId(project.getId());
			projectdUsage.setProjectName(project.getName());
			openStackUsages.put(projectdUsage.getProjectId(), projectdUsage);
			QuotaSet quota = serverQuotaIF.getServerQuota(project.getId());
			projectdUsage.setVmTotal(quota.getInstances());
			projectdUsage.setVCpuTotal(quota.getCores());
			projectdUsage.setMemTotal(quota.getRam());
			QuotaSet vquota = volumeIF.getVolumeQuota(adminProjectId, project.getId());
			projectdUsage.setDiskTotal(vquota.getGigabytes());
		}

		List<Volume> volumes = volumeIF.getAllVolumes("");
		for (Volume volume : volumes) {
			OpenStackUsage osu = openStackUsages.get(volume.getOs_vol_tenant_attr_tenant_id());
			if (osu == null) continue;
			osu.setDiskUsed(osu.getDiskUsed()+volume.getSize());
			totalUsage.setDiskUsed(totalUsage.getDiskUsed()+volume.getSize());
		}

		totalUsage.setDiskAvail(totalUsage.getDiskTotal() - totalUsage.getDiskUsed());

		int tmpDiskVmTotal = (totalUsage.getDiskTotal()) / 50 ;

		if ( tmpVmTotal > tmpDiskVmTotal ) {
			tmpVmTotal = tmpDiskVmTotal;
		}

		totalUsage.setVmTotal(tmpVmTotal);

		FlavorIF flaverIF = AbstractFactory.getFlavorIF(cloudVo);
		List<Flavor> flavors = flaverIF.getFlavors();
		Map<String, Flavor> flavorMap = new HashMap<String, Flavor>();
		for (Flavor flavor : flavors) {
			flavorMap.put(flavor.getId(), flavor);
		}

		ServerIF serverIF = AbstractFactory.getServerIF(projectName,cloudVo);
		List<Server> servers = serverIF.getAllServers("");
		totalUsage.setVmUsed(servers.size());
		totalUsage.setVmAvail(totalUsage.getVmTotal()-totalUsage.getVmUsed());
		totalUsage.setCloudId(cloudVo.getCloudId());
		openStackUsages.put(totalUsage.getProjectId(), totalUsage);
		for (Server server : servers) {
			OpenStackUsage osu = openStackUsages.get(server.getTenant_id());
			osu.setVmUsed(osu.getVmUsed()+1);
			Flavor tmpflavor = flavorMap.get(server.getFlavor().getId());
			osu.setVCpuUsed(osu.getVCpuUsed()+tmpflavor.getVcpus());
			osu.setMemUsed(osu.getMemUsed()+tmpflavor.getRam());
//			osu.setDiskUsed(osu.getDiskUsed()+tmpflavor.getDisk());
		}

		for (String key : openStackUsages.keySet()) {
			OpenStackUsage osus = openStackUsages.get(key);
			if (!osus.getProjectId().equals("ALL")) {
				osus.setVmAvail(osus.getVmTotal()-osus.getVmUsed());
				osus.setVCpuAvail(osus.getVCpuTotal()-osus.getVCpuUsed());
				if (osus.getVCpuAvail() > totalUsage.getVCpuAvail())
					osus.setVCpuAvail(totalUsage.getVCpuAvail());
				osus.setMemAvail(osus.getMemTotal()-osus.getMemUsed());
				if (osus.getMemAvail() > totalUsage.getMemAvail())
					osus.setMemAvail(totalUsage.getMemAvail());
				osus.setDiskAvail(osus.getDiskTotal()-osus.getDiskUsed());
				if (osus.getDiskAvail() > totalUsage.getDiskAvail())
					osus.setDiskAvail(totalUsage.getDiskAvail());
			} else {
				osus.setStorageList(storageList);
			}
		}

		List<OpenStackUsage> usageList = new LinkedList<OpenStackUsage>();
		for (String key : openStackUsages.keySet()) {
			usageList.add(openStackUsages.get(key));
		}

		return usageList;
	}

	public static OpenStackComplexQuota getQuota(String project_id, CustomOssCloudVO cloudVo)
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		OpenStackComplexQuota quota = new OpenStackComplexQuota();

		ProjectIF projectIF = AbstractFactory.getProject(cloudVo);
		Project project = projectIF.getProject(project_id);

		String adminProjectId = "";
		List<Project> projects = projectIF.getProjects();

		for (Project project1 : projects) {
			if (project1.getName().equals("admin"))
				adminProjectId = project1.getId();
		}


		ServerQuotaIF apiIF = AbstractFactory.getServerQuotaIF(cloudVo);
		QuotaSet serverQuotaSet = apiIF.getServerQuota(project_id);

		quota.setMetadata_items(serverQuotaSet.getMetadata_items());
		quota.setCores(serverQuotaSet.getCores());
		quota.setInstances(serverQuotaSet.getInstances());
		quota.setInjected_files(serverQuotaSet.getInjected_files());
		quota.setInjected_file_content_bytes(serverQuotaSet.getInjected_file_content_bytes());
		quota.setRam(serverQuotaSet.getRam());

		NetworkQuotaIF netIF = AbstractFactory.getQuotaIF(cloudVo);
		NetworkQuota networkQuota = netIF.getNetworkQuota(project_id);

		quota.setSecurity_group(networkQuota.getSecurity_group());
		quota.setSecurity_group_rule(networkQuota.getSecurity_group_rule());
		quota.setFloatingip(networkQuota.getFloatingip());
		quota.setNetwork(networkQuota.getNetwork());
		quota.setPort(networkQuota.getPort());
		quota.setRouter(networkQuota.getRouter());
		quota.setSubnet(networkQuota.getSubnet());

		VolumeIF volumeIF = AbstractFactory.getVolumeIF(project.getName(),cloudVo);
		QuotaSet volumeQuotaSet = volumeIF.getVolumeQuota(adminProjectId, project_id);

		quota.setVolumes(volumeQuotaSet.getVolumes());
		quota.setSnapshots(volumeQuotaSet.getSnapshots());
		quota.setGigabytes(volumeQuotaSet.getGigabytes());

		return quota;
	}

	public static OpenStackComplexQuota updateQuota(String project_id, OpenStackComplexQuota quota, CustomOssCloudVO cloudVo)
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		if (quota.getMetadata_items() != null
				|| quota.getCores() != null
				|| quota.getInstances() != null
				|| quota.getInjected_files() != null
				|| quota.getInjected_file_content_bytes() != null
				|| quota.getRam() != null) {

			QuotaSet serverQuotaSet = new QuotaSet();
			serverQuotaSet.setMetadata_items(quota.getMetadata_items());
			serverQuotaSet.setCores(quota.getCores());
			serverQuotaSet.setInstances(quota.getInstances());
			serverQuotaSet.setInjected_files(quota.getInjected_files());
			serverQuotaSet.setInjected_file_path_bytes(quota.getInjected_file_content_bytes());
			serverQuotaSet.setRam(quota.getRam());

			ServerQuotaIF apiIF = AbstractFactory.getServerQuotaIF(cloudVo);
			apiIF.updateServerQuota(project_id, serverQuotaSet);
		}

		if (quota.getSecurity_group() != null
				|| quota.getSecurity_group_rule() != null
				|| quota.getFloatingip() != null
				|| quota.getNetwork() != null
				|| quota.getPort() != null
				|| quota.getRouter() != null
				|| quota.getSubnet() != null) {

			NetworkQuota networkQuota = new NetworkQuota();
			networkQuota.setSecurity_group(quota.getSecurity_group());
			networkQuota.setSecurity_group_rule(quota.getSecurity_group_rule());
			networkQuota.setFloatingip(quota.getFloatingip());
			networkQuota.setNetwork(quota.getNetwork());
			networkQuota.setPort(quota.getPort());
			networkQuota.setRouter(quota.getRouter());
			networkQuota.setSubnet(quota.getSubnet());

			NetworkQuotaIF netIF = AbstractFactory.getQuotaIF(cloudVo);
			netIF.updateNetworkQuota(project_id, networkQuota);
		}

		if (quota.getVolumes() != null
				|| quota.getSnapshots() != null
				|| quota.getGigabytes() != null) {

			ProjectIF projectIF = AbstractFactory.getProject(cloudVo);
			Project project = projectIF.getProject(project_id);

			QuotaSet volumeQuotaSet = new QuotaSet();
			volumeQuotaSet.setVolumes(quota.getVolumes());
			volumeQuotaSet.setSnapshots(quota.getSnapshots());
			volumeQuotaSet.setGigabytes(quota.getGigabytes());

			VolumeIF volumeIF = AbstractFactory.getVolumeIF(project.getName(),cloudVo);
			volumeIF.updateVolumeQuota(project_id, project_id, volumeQuotaSet);

		}

		return getQuota(project_id,cloudVo);
	}

	public static Project createProject(String name, String description,CustomOssCloudVO cloudVo)
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		ProjectIF projectIF = AbstractFactory.getProject(cloudVo);

		Project create_project = new Project();
		create_project.setName(name);
		create_project.setDescription(description);

		Project project = projectIF.createProject(create_project);
		String DefaultSecId = "";

		if (project.getId() != null) {
			UserIF userIF = AbstractFactory.getUserIF(cloudVo);
			User member_user = userIF.getUserByName("clop");
			User admin_user = userIF.getUserByName("admin");

			// get role _member_ & admin
			RoleIF roleIF = AbstractFactory.getRoleIF(cloudVo);
			Role member_role = roleIF.getRoleByName("admin");
			Role admin_role = roleIF.getRoleByName("admin");

			// project user assign new project - _member_
			userIF.assignUserRole(project.getId(), member_user.getId(), member_role.getId());
			userIF.assignUserRole(project.getId(), admin_user.getId(), admin_role.getId());

			// Default Security Group ID 가져오기

			SecurityGroupIF secuGrpIF = AbstractFactory.getSecurityGroupIF(project.getName(),cloudVo);
			List<SecurityGroup> secuGrps = secuGrpIF.getSecurityGroup(project.getId(),cloudVo);

			for(SecurityGroup secuGrp : secuGrps) {
				if (secuGrp.getName().equalsIgnoreCase("default")) {
					DefaultSecId = secuGrp.getId();
				}
			}

			// Security Group Rule  추가  ICMP, ALL TCP, ALL UDP

			SecurityGroupRuleIF secuRuleIF = AbstractFactory.getSecurityGroupRuleIF(project.getName(),cloudVo);

			//  Egress ICMP Protocol  추가
			SecurityGroupRule new_rule1 = new SecurityGroupRule();

			new_rule1.setDirection("egress");
			new_rule1.setEthertype("IPv4");
			new_rule1.setProtocol("icmp");
			new_rule1.setRemote_ip_prefix("0.0.0.0/0");
			new_rule1.setProject_id(project.getId());
			new_rule1.setSecurity_group_id(DefaultSecId);

//			SecurityGroupRule securityGroupRule1  = secuRuleIF.createSecurityGroupRule(new_rule1,cloudVo);
			secuRuleIF.createSecurityGroupRule(new_rule1,cloudVo);

			//  Igress ICMP Protocol  추가
			SecurityGroupRule new_rule2 = new SecurityGroupRule();

			new_rule2.setDirection("ingress");
			new_rule2.setEthertype("IPv4");
			new_rule2.setProtocol("icmp");
			new_rule2.setRemote_ip_prefix("0.0.0.0/0");
			new_rule2.setProject_id(project.getId());
			new_rule2.setSecurity_group_id(DefaultSecId);

//			SecurityGroupRule securityGroupRule2  = secuRuleIF.createSecurityGroupRule(new_rule2,cloudVo);
			secuRuleIF.createSecurityGroupRule(new_rule2,cloudVo);

			//  Egress ALL TCP Protocol  추가
			SecurityGroupRule new_rule3 = new SecurityGroupRule();

			new_rule3.setDirection("egress");
			new_rule3.setEthertype("IPv4");
			new_rule3.setProtocol("tcp");
			new_rule3.setRemote_ip_prefix("0.0.0.0/0");
			new_rule3.setPort_range_min("1");
			new_rule3.setPort_range_max("65535");
			new_rule3.setProject_id(project.getId());
			new_rule3.setSecurity_group_id(DefaultSecId);

//			SecurityGroupRule securityGroupRule3  = secuRuleIF.createSecurityGroupRule(new_rule3,cloudVo);
			secuRuleIF.createSecurityGroupRule(new_rule3,cloudVo);

			//  Ingress ALL TCP Protocol  추가
			SecurityGroupRule new_rule4 = new SecurityGroupRule();

			new_rule4.setDirection("ingress");
			new_rule4.setEthertype("IPv4");
			new_rule4.setProtocol("tcp");
			new_rule4.setRemote_ip_prefix("0.0.0.0/0");
			new_rule4.setPort_range_min("1");
			new_rule4.setPort_range_max("65535");
			new_rule4.setProject_id(project.getId());
			new_rule4.setSecurity_group_id(DefaultSecId);

//			SecurityGroupRule securityGroupRule4  = secuRuleIF.createSecurityGroupRule(new_rule4,cloudVo);
			secuRuleIF.createSecurityGroupRule(new_rule4,cloudVo);

			//  Egress ALL UDP Protocol  추가
			SecurityGroupRule new_rule5 = new SecurityGroupRule();

			new_rule5.setDirection("egress");
  		    new_rule5.setEthertype("IPv4");
			new_rule5.setProtocol("udp");
			new_rule5.setRemote_ip_prefix("0.0.0.0/0");
			new_rule5.setPort_range_min("1");
			new_rule5.setPort_range_max("65535");
		    new_rule5.setProject_id(project.getId());
			new_rule5.setSecurity_group_id(DefaultSecId);

//			SecurityGroupRule securityGroupRule5  = secuRuleIF.createSecurityGroupRule(new_rule5,cloudVo);
			secuRuleIF.createSecurityGroupRule(new_rule5,cloudVo);

			//  Ingress ALL UDP Protocol  추가
			SecurityGroupRule new_rule6 = new SecurityGroupRule();

			new_rule6.setDirection("ingress");
			new_rule6.setEthertype("IPv4");
			new_rule6.setProtocol("udp");
			new_rule6.setRemote_ip_prefix("0.0.0.0/0");
			new_rule6.setPort_range_min("1");
			new_rule6.setPort_range_max("65535");
			new_rule6.setProject_id(project.getId());
			new_rule6.setSecurity_group_id(DefaultSecId);

//			SecurityGroupRule securityGroupRule6  = secuRuleIF.createSecurityGroupRule(new_rule6,cloudVo);
			secuRuleIF.createSecurityGroupRule(new_rule6,cloudVo);

		}
		return project;
	}


	public static Server createServer(String project_name, Server server,CustomOssCloudVO cloudVo)
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		FlavorIF flavorIF = AbstractFactory.getFlavorIF(cloudVo);
//		Flavor flavor = flavorIF.getFlavor(server.getFlavorRef(),cloudVo);
		flavorIF.getFlavor(server.getFlavorRef());

		server.setOS_DCF_diskConfig("AUTO");

		List<BlockDeviceStorageMapping> block_device_mapping_v2 = new LinkedList<BlockDeviceStorageMapping>();
		BlockDeviceStorageMapping blockDeviceStorageMapping = new BlockDeviceStorageMapping();
		blockDeviceStorageMapping.setBoot_index("0");
		blockDeviceStorageMapping.setUuid(server.getImageRef());
		blockDeviceStorageMapping.setDelete_on_termination(false);
		blockDeviceStorageMapping.setDestination_type("volume");
		blockDeviceStorageMapping.setSource_type("volume");
		//blockDeviceStorageMapping.setVolume_size(flavor.getDisk().toString()=="0"?"1":flavor.getDisk().toString());
		block_device_mapping_v2.add(blockDeviceStorageMapping);
		server.setBlock_device_mapping_v2(block_device_mapping_v2);

		server.setImageRef(null);

		ServerIF serverIF = AbstractFactory.getServerIF(project_name,cloudVo);
		Server createServer = serverIF.createServer(server);

		/*
		 * 오픈스택 Alarm 기능 비활성화 비작동기능 임시주석 2019.11.18 장중일
		 */
		/*
		Runnable r = new CreateAlarm(project_name, createServer.getId());
		Thread t = new Thread(r);
		t.start();
		*/

		return createServer;
	}

	static class CreateAlarm implements Runnable {
		private String project_name;
		private String server_id;

		private SqlSessionTemplate sqlSessionTemplate;

		private final String cmmCloudDao ="com.ivucenter.cloud.portal.cmm.cloud.OssCloudDAO.";
		private final String getCloudList = cmmCloudDao + "getCloudList";

		public CreateAlarm(String project_name, String server_id) {
			this.project_name = project_name;
			this.server_id = server_id;
		}

		@Override
		public void run() {

	        List<CustomOssCloudVO> lists = sqlSessionTemplate.selectList(getCloudList);
	        for (CustomOssCloudVO cloudVo : lists) {

	        	if(cloudVo.getCloudType().equals("openstack")) {
					try {

						ServerIF serverIF = AbstractFactory.getServerIF(project_name,cloudVo);

						while (true) {
							Thread.sleep(300);
							
							synchronized(this) {
							Server server = serverIF.getServer(server_id);
							log.debug(server.getStatus()+":"+server.getOS_EXT_STS_vm_state()+":"+server.getOS_EXT_STS_task_state());

							if(server.getStatus().equals("ERROR")) {
								return;
							}

							if (server.getStatus().equals("ACTIVE")) {
								AlarmIF alarmIF = AbstractFactory.getAlarmIF(project_name,cloudVo);

								Alarm alarmCpu = new Alarm();
								alarmCpu.setDefaultCpuUtil(server.getId());
								alarmIF.createAlarm(alarmCpu);

								Alarm alarmMem = new Alarm();
								alarmMem.setDefaultMemUtil(server.getId());
								alarmIF.createAlarm(alarmMem);
								break;
							}
						}
					}
					} catch (NotConnectGatewayException|NotSupportGatewayException|InvaildOpenStackException|InterruptedException e) {
						log.error(e.getMessage());
					}
	        	} // end of openstack
	        }
		}
	}

	public static synchronized boolean deleteServer(String project_name, String server_id,CustomOssCloudVO cloudVo)
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		ServerIF serverIF = AbstractFactory.getServerIF(project_name,cloudVo);

//		AlarmIF alarmIF = AbstractFactory.getAlarmIF(project_name,cloudVo);

		// 알림기능 미사용 2019.12.02
		/*
		List<Alarm> alarms = alarmIF.getAlarms();
		for (Alarm alarm : alarms) {
			if (alarm.getGnocchi_resources_threshold_rule().getResource_id().equals(server_id)) {
				alarmIF.deleteAlarm(alarm.getAlarm_id());
			}
		}
		*/

		return serverIF.actionServer(server_id, "forceDelete");
	}

	
	public static synchronized boolean deleteVolume(String project_name, String disk_id,CustomOssCloudVO cloudVo)
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		
		VolumeIF volumeIF = AbstractFactory.getVolumeIF(project_name,cloudVo);
		
		
		return volumeIF.deleteVolume(disk_id);
	}
	
	public static vraProjectObject vRaCreateProject(String name, String description,CustomOssCloudVO cloudVo)
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		vraProjectIF projectIF = vraAbstractFactory.getProject(cloudVo);

		vraProjectObject create_project = new vraProjectObject();
		List<vraZoneAssignmentConfigurations> listZone = new ArrayList<vraZoneAssignmentConfigurations>();
		List<vraAdministrators> administrators = new ArrayList<vraAdministrators>();

		vraAdministrators administrator = new vraAdministrators();
		create_project.setName(name);
		create_project.setDescription(description);

		//추후 작업-김성진
		create_project.setSharedResources("true");
		create_project.setMachineNamingTemplate("${resource.name}");
		create_project.setOperationTimeout("0");

		vraServerIF serverIF = vraAbstractFactory.getServerIF(cloudVo);
		List<vraZone> zones = serverIF.getZones().getContent();
		for(vraZone zone : zones) {
			vraZoneAssignmentConfigurations zoneAssign = new vraZoneAssignmentConfigurations();
			zoneAssign.setStorageLimitGB(1000);
			zoneAssign.setCpuLimit(20480);
			zoneAssign.setMemoryLimitMB(51200);
			zoneAssign.setZoneId(zone.getId());
			zoneAssign.setMaxNumberInstances(10);
			zoneAssign.setPriority(0);
			listZone.add(zoneAssign);
		}

		administrator.setEmail(cloudVo.getAdminUsername());
		administrators.add(administrator);

		create_project.setZoneAssignmentConfigurations(listZone);
		create_project.setAdministrators(administrators);

		vraProjectObject project = projectIF.createProject(create_project);

		vraEntitlementsObject EntitlementsObject = new vraEntitlementsObject();
		vraDefinition Definition = new vraDefinition();
		Definition.setId(cloudVo.getAlarmOcurredUrl());
		Definition.setType(cloudVo.getAlarmClearUrl());
		EntitlementsObject.setId(cloudVo.getApiAlarmServer());

		EntitlementsObject.setProjectId(project.getId());
		EntitlementsObject.setDefinition(Definition);

		vraJsonObject jsonObject = projectIF.setEntitlements(EntitlementsObject);

		return project;
	}

	public static List<OpenStackUsage> vraGetCloudUsage(CustomOssCloudVO cloudVo)
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {

		vraHostIF hostIF = vraAbstractFactory.getHostIF(cloudVo);
		vraDiskIF diskIF = vraAbstractFactory.getDiskIF(cloudVo);
		Map<String, OpenStackUsage> openStackUsages = new HashMap<String, OpenStackUsage>();

		vraHostContent list = hostIF.getHosts();
		List<vraHostContent> hostContents = list.getContent();
		OpenStackUsage totalUsage = new OpenStackUsage();

		totalUsage.setProjectName("ALL");
		totalUsage.setProjectId("ALL");
		int hypervisor_gb = 0;
		int memory_mb = 0;
		int memory_mb_used = 0;
		int vcpus = 0;
		int vcpus_used = 0;
		int tmpVmTotal = 0;
		int hypervisorCnt = 0;
		SystemCalculatorInfo systemCalculatorInfo = new SystemCalculatorInfo();
		double memoryCalculator = 0;
		double cpuCalculator = 0;
		int vmCalculator = 0;
		if(systemCalculatorInfo.getMemoryCalculator().replaceAll("[^0-9]","") != null) {
			memoryCalculator = Double.parseDouble(systemCalculatorInfo.getMemoryCalculator());
		} else {
			memoryCalculator = 2;
		}
		if(systemCalculatorInfo.getCpuCalculator().replaceAll("[^0-9]","") != null) {
			cpuCalculator = Double.parseDouble(systemCalculatorInfo.getCpuCalculator());
		} else {
			cpuCalculator = 2;
		}
		if(systemCalculatorInfo.getVmCalculator().replaceAll("[^0-9]","") != null) {
			vmCalculator = Integer.parseInt(systemCalculatorInfo.getVmCalculator());
		} else {
			vmCalculator = 4096;
		}
		long mega = 1024L * 1024L;
		for(vraHostContent content : hostContents) {
			memory_mb += content.getCustomProperties().getMemoryAvailableBytes() / mega;
			vcpus += content.getCustomProperties().getMaxVCPUperInstance() * 2;
			//vcpus_used += obj.getVcpus_used();
		}
		VmDataStoreIF vmDataStore = VmAbstractFactory.getVmDataStoreIF(cloudVo);
		VmDataStoreObject vmDataStoreValue = vmDataStore.getDataStore();
		List<VmDataStoreObject> vmDataStoreList = vmDataStoreValue.getValue();
		List<CustomStorageVO> storageList = new ArrayList();
		for (VmDataStoreObject vmDataStores : vmDataStoreList) {
			if(vmDataStores.getName().equals("OA-SAN-DS01") || vmDataStores.getName().equals("OA-SAN-DS02")) {
				Long datastoreGB = vmDataStores.getCapacity() / 1073741824L;
				Long usedSpaceGB = (vmDataStores.getCapacity() / 1073741824L) - (vmDataStores.getFree_space() / 1073741824L);
				hypervisor_gb += Math.floor(datastoreGB.intValue());
				CustomStorageVO storage = new CustomStorageVO();
				storage.setCloudId(cloudVo.getCloudId());
				storage.setStorageId(vmDataStores.getDatastore());
				storage.setStorageType("hitachi-g900");
				storage.setUsedSpace(usedSpaceGB.intValue());
				storage.setTotalSpace(datastoreGB.intValue());
				storageList.add(storage);
			}

		}

		totalUsage.setDiskTotal(hypervisor_gb);
		//totalUsage.setMemTotal((int)(memory_mb * memoryCalculator));
		totalUsage.setMemTotal((int)(memory_mb));


		int tmpMemVmTotal = (totalUsage.getMemTotal()) / vmCalculator;
		totalUsage.setVCpuTotal(vcpus * 8);
		totalUsage.setVCpuUsed(vcpus_used);
		totalUsage.setVCpuAvail(totalUsage.getVCpuTotal() - totalUsage.getVCpuUsed());

		// CPU 여유용량에서 2Core 가상서버 만들었을때를 가정하여 VM 갯수
		int tmpCpuVmTotal = (totalUsage.getVCpuTotal())/ 2;

		// CPU 와 메모리의 VM 갯수에서 더 적은 것을 입력
		tmpVmTotal = tmpMemVmTotal;

		if ( tmpMemVmTotal > tmpCpuVmTotal ) {
			tmpVmTotal = tmpCpuVmTotal;
		}

		vraProjectIF projectIF = vraAbstractFactory.getProject(cloudVo);
		vraProjectObject projects = projectIF.getProjects();
		List<vraProjectObject> projectObjects = projects.getContent();
		for (vraProjectObject project : projectObjects) {
			OpenStackUsage projectdUsage = new OpenStackUsage();
			projectdUsage.setCloudId(cloudVo.getCloudId());
			projectdUsage.setProjectId(project.getId());
			projectdUsage.setProjectName(project.getName());
			List<vraZones> zones = project.getZones();
			for(vraZones zone : zones) {
				projectdUsage.setVmTotal(zone.getMaxNumberInstances());
				projectdUsage.setVCpuTotal(zone.getCpuLimit() / 1024);
				Long pMemTotal =Long.parseLong(zone.getMemoryLimitMB());
				projectdUsage.setMemTotal(pMemTotal.intValue());
				projectdUsage.setDiskTotal(Integer.parseInt(zone.getStorageLimitGB()));
			}
			openStackUsages.put(projectdUsage.getProjectId(), projectdUsage);
		}

		vraBlockDevice blockDevice = diskIF.getBlockDevice("");
		List<vraBlockDevice> blocks = blockDevice.getContent();
		for (vraBlockDevice block : blocks) {
			OpenStackUsage osu = openStackUsages.get(block.getProjectId());
			if (!block.getType().equals("HDD")) continue;
			totalUsage.setDiskUsed(totalUsage.getDiskUsed()+Integer.parseInt(block.getCapacityInGB()));
			if (osu == null) continue;
			osu.setDiskUsed(osu.getDiskUsed()+Integer.parseInt(block.getCapacityInGB()));

		}

		totalUsage.setDiskAvail(totalUsage.getDiskTotal() - totalUsage.getDiskUsed());

		int tmpDiskVmTotal = (totalUsage.getDiskTotal()) / 50 ;

		if ( tmpVmTotal > tmpDiskVmTotal ) {
			tmpVmTotal = tmpDiskVmTotal;
		}

		totalUsage.setVmTotal(tmpVmTotal);

		vraServerIF serverIF = vraAbstractFactory.getServerIF(cloudVo);
		vraMachine machineContent = serverIF.getMachine("");
		List<vraMachine> machineList = machineContent.getContent();
		totalUsage.setVmUsed(machineContent.getTotalElements());
		totalUsage.setVmAvail(totalUsage.getVmTotal()-totalUsage.getVmUsed());
		totalUsage.setCloudId(cloudVo.getCloudId());
		openStackUsages.put(totalUsage.getProjectId(), totalUsage);
		for (vraMachine machine : machineList) {
			OpenStackUsage osu = openStackUsages.get(machine.getProjectId());
			totalUsage.setVCpuUsed(totalUsage.getVCpuUsed() + machine.getCustomProperties().getCpuCount());
			totalUsage.setMemUsed(totalUsage.getMemUsed() + machine.getCustomProperties().getMemoryInMB());
			if (osu == null) continue;
			osu.setVmUsed(osu.getVmUsed()+1);
			osu.setVCpuUsed(osu.getVCpuUsed()+machine.getCustomProperties().getCpuCount());
			osu.setMemUsed(osu.getMemUsed()+machine.getCustomProperties().getMemoryInMB());
		}

		for (String key : openStackUsages.keySet()) {
			OpenStackUsage osus = openStackUsages.get(key);
			if (!osus.getProjectId().equals("ALL")) {
				osus.setVmAvail(osus.getVmTotal()-osus.getVmUsed());
				osus.setVCpuAvail(osus.getVCpuTotal()-osus.getVCpuUsed());
				if (osus.getVCpuAvail() > totalUsage.getVCpuAvail())
					osus.setVCpuAvail(totalUsage.getVCpuAvail());
				osus.setMemAvail(osus.getMemTotal()-osus.getMemUsed());
				if (osus.getMemAvail() > totalUsage.getMemAvail())
					osus.setMemAvail(totalUsage.getMemAvail());
				osus.setDiskAvail(osus.getDiskTotal()-osus.getDiskUsed());
				if (osus.getDiskAvail() > totalUsage.getDiskAvail())
					osus.setDiskAvail(totalUsage.getDiskAvail());
			} else {
				osus.setStorageList(storageList);
			}
		}

		totalUsage.setVCpuAvail(totalUsage.getVCpuTotal() - totalUsage.getVCpuUsed());
		totalUsage.setMemAvail(totalUsage.getMemTotal() - totalUsage.getMemUsed());

		List<OpenStackUsage> usageList = new LinkedList<OpenStackUsage>();
		for (String key : openStackUsages.keySet()) {
			usageList.add(openStackUsages.get(key));
		}
		return usageList;
	}

	public static OpenStackComplexQuota vraGetQuota(String project_id, CustomOssCloudVO cloudVo)
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		OpenStackComplexQuota quota = new OpenStackComplexQuota();

		vraProjectIF projectIF = vraAbstractFactory.getProject(cloudVo);
		vraProjectObject projects = projectIF.getProject(project_id);

		//quota.setMetadata_items(serverQuotaSet.getMetadata_items());
		quota.setCores(projects.getZones().get(0).getCpuLimit() / 1024);
		quota.setInstances(projects.getZones().get(0).getMaxNumberInstances());
		//quota.setInjected_files(serverQuotaSet.getInjected_files());
		//quota.setInjected_file_content_bytes(serverQuotaSet.getInjected_file_content_bytes());
		quota.setRam(Integer.parseInt(projects.getZones().get(0).getMemoryLimitMB()));

		//quota.setSecurity_group(networkQuota.getSecurity_group());
		//quota.setSecurity_group_rule(networkQuota.getSecurity_group_rule());
		//quota.setFloatingip(networkQuota.getFloatingip());
		//quota.setNetwork(networkQuota.getNetwork());
		//quota.setPort(networkQuota.getPort());
		//quota.setRouter(networkQuota.getRouter());
		//quota.setSubnet(networkQuota.getSubnet());

		//quota.setVolumes(Integer.parseInt(projects.getZones().get(0).getStorageLimitGB()));
		//quota.setSnapshots(volumeQuotaSet.getSnapshots());
		quota.setGigabytes(Integer.parseInt(projects.getZones().get(0).getStorageLimitGB()));

		return quota;
	}

	public static OpenStackComplexQuota vraUpdateQuota(String project_id, OpenStackComplexQuota quota, CustomOssCloudVO cloudVo)
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		vraProjectIF projectIF = vraAbstractFactory.getProject(cloudVo);

		vraProjectObject getProject = projectIF.getProject(quota.getProjectId());
		vraProjectObject object = new vraProjectObject();
		List<vraZoneAssignmentConfigurations> configList = new ArrayList<vraZoneAssignmentConfigurations>();
		vraZoneAssignmentConfigurations config = new vraZoneAssignmentConfigurations();
		config.setStorageLimitGB(quota.getGigabytes());
		config.setMaxNumberInstances(quota.getInstances());
		config.setMemoryLimitMB(quota.getRam());
		config.setCpuLimit(quota.getCores() * 1024);
		config.setZoneId(getProject.getZones().get(0).getZoneId());
		configList.add(config);
		object.setName(quota.getProjectName());
		object.setZoneAssignmentConfigurations(configList);
		vraProjectObject res = projectIF.updateQuota(object, project_id);


		return vraGetQuota(project_id,cloudVo);
	}

}
