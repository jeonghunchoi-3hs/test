package com.ivucenter.cloud.api.openstack.interfaces;

import com.ivucenter.cloud.api.openstack.OpenStackAlarm;
import com.ivucenter.cloud.api.openstack.OpenStackCustom;
import com.ivucenter.cloud.api.openstack.OpenStackFlavor;
import com.ivucenter.cloud.api.openstack.OpenStackFloatingip;
import com.ivucenter.cloud.api.openstack.OpenStackHypervisor;
import com.ivucenter.cloud.api.openstack.OpenStackIdentity;
import com.ivucenter.cloud.api.openstack.OpenStackImage;
import com.ivucenter.cloud.api.openstack.OpenStackListener;
import com.ivucenter.cloud.api.openstack.OpenStackLoadbalancer;
import com.ivucenter.cloud.api.openstack.OpenStackMember;
import com.ivucenter.cloud.api.openstack.OpenStackMetric;
import com.ivucenter.cloud.api.openstack.OpenStackNetwork;
import com.ivucenter.cloud.api.openstack.OpenStackNetworkQuota;
import com.ivucenter.cloud.api.openstack.OpenStackPool;
import com.ivucenter.cloud.api.openstack.OpenStackPort;
import com.ivucenter.cloud.api.openstack.OpenStackProject;
import com.ivucenter.cloud.api.openstack.OpenStackRole;
import com.ivucenter.cloud.api.openstack.OpenStackRouter;
import com.ivucenter.cloud.api.openstack.OpenStackSecurityGroup;
import com.ivucenter.cloud.api.openstack.OpenStackSecurityGroupRule;
import com.ivucenter.cloud.api.openstack.OpenStackServer;
import com.ivucenter.cloud.api.openstack.OpenStackServerQuota;
import com.ivucenter.cloud.api.openstack.OpenStackSubnet;
import com.ivucenter.cloud.api.openstack.OpenStackUser;
import com.ivucenter.cloud.api.openstack.OpenStackVolume;
import com.ivucenter.cloud.api.vmware.VMWareDisk;
import com.ivucenter.cloud.api.vmware.VmwareLibraries;
import com.ivucenter.cloud.api.vmware.interfaces.VmDiskIF;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;
import com.ivucenter.cloud.portal.req.product.CustomReqProductVO;

public class AbstractFactory  {

	public static IdentityIF getIdentity(String cloudId) {
		// TODO 
	      CustomOssCloudVO cloudVo = new CustomOssCloudVO(); 
	      // DB 작업하여 CustomOssClooudVO 를 가져온다. 
	      return getIdentity(cloudVo);
	}
	
	public static IdentityIF getIdentity(CustomOssCloudVO cloudVo) {
		return new OpenStackIdentity(cloudVo);
	}
	
	public static VmwareLibraries getLibraryVmware(CustomOssCloudVO cloudVo){
        return new VmwareLibraries(cloudVo);
	}
	
	public static VmDiskIF getDiskVmware(CustomReqProductVO req,CustomOssCloudVO cloudVo) {
		return new VMWareDisk(req,cloudVo);
	}	
	
	public static ProjectIF getProject(CustomOssCloudVO cloudVo) {
		return new OpenStackProject(cloudVo);
	}
	
	public static NetworkIF getNetworkIF(String projectName,CustomOssCloudVO cloudVo) {
		return new OpenStackNetwork(projectName,cloudVo);
	}

	public static SubnetIF getSubnetIF(String projectName,CustomOssCloudVO cloudVo) {
		return new OpenStackSubnet(projectName,cloudVo);
	}	
	
	public static ServerIF getServerIF(String projectName,CustomOssCloudVO cloudVo) {
		return new OpenStackServer(projectName,cloudVo);
	}	
	
	public static FlavorIF getFlavorIF(CustomOssCloudVO cloudVo) {
		return new OpenStackFlavor(cloudVo);
	}
	
	public static PortIF getPortIF(CustomOssCloudVO cloudVo) {
		return new OpenStackPort(cloudVo);
	}	
	
	public static RouterIF getRouterIF(String projectName,CustomOssCloudVO cloudVo) {
		return new OpenStackRouter(projectName,cloudVo);
	}
	
	
	public static FloatingipIF getFloatingipIF(String projectName,CustomOssCloudVO cloudVo) {
		return new OpenStackFloatingip(projectName,cloudVo);
	}
	
	public static NetworkQuotaIF getQuotaIF(CustomOssCloudVO cloudVo) {
		return new OpenStackNetworkQuota(cloudVo);
	}   
	
	public static ServerQuotaIF getServerQuotaIF(CustomOssCloudVO cloudVo) {
		return new OpenStackServerQuota(cloudVo);
	}
	
	public static VolumeIF getVolumeIF(String projectName,CustomOssCloudVO cloudVo) {
		return new OpenStackVolume(projectName,cloudVo);
	}	
	
	public static VolumeIF getVolumeIF(CustomOssCloudVO cloudVo) {
		return new OpenStackVolume(cloudVo);
	}
	
	public static ImageIF getImageIF(CustomOssCloudVO cloudVo) {
		return new OpenStackImage(cloudVo);
	}

	
	public static MetricIF getMetricIF(CustomOssCloudVO cloudVo) {
		return new OpenStackMetric(cloudVo);
	}

	
	public static SecurityGroupIF getSecurityGroupIF(String projectName,CustomOssCloudVO cloudVo) {
		return new OpenStackSecurityGroup(projectName,cloudVo);
	}
	
	public static UserIF getUserIF(CustomOssCloudVO cloudVo) {
		return new OpenStackUser(cloudVo);
	}

	public static RoleIF getRoleIF(CustomOssCloudVO cloudVo) {
		return new OpenStackRole(cloudVo);
	}
	
	public static LoadbalancerIF getLoadBalancerIF(String projectName,CustomOssCloudVO cloudVo) {
		return getLoadBalancerIF("openstack", projectName,cloudVo);
	}

	public static LoadbalancerIF getLoadBalancerIF(String provider, String projectName,CustomOssCloudVO cloudVo) {
		return new OpenStackLoadbalancer(projectName,cloudVo);
	}
	
	public static ListenerIF getListenerIF(String projectName,CustomOssCloudVO cloudVo) {
		return new OpenStackListener(projectName,cloudVo);
	}	
	
	public static MemberIF getMemberIF(String projectName,CustomOssCloudVO cloudVo) {
		return new OpenStackMember(projectName,cloudVo);
	}
	
	public static PoolIF getPoolIF(String projectName,CustomOssCloudVO cloudVo) {
		return new OpenStackPool(projectName,cloudVo);
	}
	
	public static AlarmIF getAlarmIF(String projectName,CustomOssCloudVO cloudVo) {
		return new OpenStackAlarm(projectName,cloudVo);
	}
	
	public static CustomIF getCustomIF(CustomOssCloudVO cloudVo) {
		return new OpenStackCustom(cloudVo);
	}	
	
	public static HypervisorIF getHypervisorIF(CustomOssCloudVO cloudVo) {
		return new OpenStackHypervisor(cloudVo);
	}

	public static SecurityGroupRuleIF getSecurityGroupRuleIF(String projectName,CustomOssCloudVO cloudVo) {
		return new OpenStackSecurityGroupRule(projectName,cloudVo);
	}
}
