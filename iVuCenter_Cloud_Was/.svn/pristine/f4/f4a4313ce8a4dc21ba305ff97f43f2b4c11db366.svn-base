package com.ivucenter.cloud.api;

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
import com.ivucenter.cloud.api.openstack.interfaces.AlarmIF;
import com.ivucenter.cloud.api.openstack.interfaces.CustomIF;
import com.ivucenter.cloud.api.openstack.interfaces.FlavorIF;
import com.ivucenter.cloud.api.openstack.interfaces.FloatingipIF;
import com.ivucenter.cloud.api.openstack.interfaces.HypervisorIF;
import com.ivucenter.cloud.api.openstack.interfaces.IdentityIF;
import com.ivucenter.cloud.api.openstack.interfaces.ImageIF;
import com.ivucenter.cloud.api.openstack.interfaces.ListenerIF;
import com.ivucenter.cloud.api.openstack.interfaces.LoadbalancerIF;
import com.ivucenter.cloud.api.openstack.interfaces.MemberIF;
import com.ivucenter.cloud.api.openstack.interfaces.MetricIF;
import com.ivucenter.cloud.api.openstack.interfaces.NetworkIF;
import com.ivucenter.cloud.api.openstack.interfaces.NetworkQuotaIF;
import com.ivucenter.cloud.api.openstack.interfaces.PoolIF;
import com.ivucenter.cloud.api.openstack.interfaces.PortIF;
import com.ivucenter.cloud.api.openstack.interfaces.ProjectIF;
import com.ivucenter.cloud.api.openstack.interfaces.RoleIF;
import com.ivucenter.cloud.api.openstack.interfaces.RouterIF;
import com.ivucenter.cloud.api.openstack.interfaces.SecurityGroupIF;
import com.ivucenter.cloud.api.openstack.interfaces.SecurityGroupRuleIF;
import com.ivucenter.cloud.api.openstack.interfaces.ServerIF;
import com.ivucenter.cloud.api.openstack.interfaces.ServerQuotaIF;
import com.ivucenter.cloud.api.openstack.interfaces.SubnetIF;
import com.ivucenter.cloud.api.openstack.interfaces.UserIF;
import com.ivucenter.cloud.api.openstack.interfaces.VolumeIF;
import com.ivucenter.cloud.api.vmware.IdentityVmware;
import com.ivucenter.cloud.api.vmware.VmwareLibraries;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;

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
	
		public static IdentityVmware getIdentityVmware(CustomOssCloudVO cloudVo) {
	          return new IdentityVmware(cloudVo);
		}
	
	public static VmwareLibraries getLibraryVmware(CustomOssCloudVO cloudVo){
        return new VmwareLibraries(cloudVo);
	}
	
	public static ProjectIF getProject(CustomOssCloudVO cloudVo) {
		if(cloudVo.getCloudType().equals("vmware")) {
			return null;
		}
		return new OpenStackProject(cloudVo);
	}
	
	public static NetworkIF getNetworkIF(String projectName,CustomOssCloudVO cloudVo) {
		if(cloudVo.getCloudType().equals("vmware")) {
			return null;
		}
		return new OpenStackNetwork(projectName,cloudVo);
	}

	public static SubnetIF getSubnetIF(String projectName,CustomOssCloudVO cloudVo) {
		if(cloudVo.getCloudType().equals("vmware")) {
			return null;
		}
		return new OpenStackSubnet(projectName,cloudVo);
	}	
	
	public static ServerIF getServerIF(String projectName,CustomOssCloudVO cloudVo) {
		if(cloudVo.getCloudType().equals("vmware")) {
			return null;
		}
		return new OpenStackServer(projectName,cloudVo);
	}	
	
	public static FlavorIF getFlavorIF(CustomOssCloudVO cloudVo) {
		if(cloudVo.getCloudType().equals("vmware")) {
			return null;
		}
		return new OpenStackFlavor(cloudVo);
	}
	
	public static PortIF getPortIF(CustomOssCloudVO cloudVo) {
		if(cloudVo.getCloudType().equals("vmware")) {
			return null;
		}
		return new OpenStackPort(cloudVo);
	}	
	
	public static RouterIF getRouterIF(String projectName,CustomOssCloudVO cloudVo) {
		if(cloudVo.getCloudType().equals("vmware")) {
			return null;
		}
		return new OpenStackRouter(projectName,cloudVo);
	}
	
	
	public static FloatingipIF getFloatingipIF(String projectName,CustomOssCloudVO cloudVo) {
		if(cloudVo.getCloudType().equals("vmware")) {
			return null;
		}
		return new OpenStackFloatingip(projectName,cloudVo);
	}
	
	public static NetworkQuotaIF getQuotaIF(CustomOssCloudVO cloudVo) {
		if(cloudVo.getCloudType().equals("vmware")) {
			return null;
		}
		return new OpenStackNetworkQuota(cloudVo);
	}   
	
	public static ServerQuotaIF getServerQuotaIF(CustomOssCloudVO cloudVo) {
		if(cloudVo.getCloudType().equals("vmware")) {
			return null;
		}
		return new OpenStackServerQuota(cloudVo);
	}
	
	public static VolumeIF getVolumeIF(String projectName,CustomOssCloudVO cloudVo) {
		if(cloudVo.getCloudType().equals("vmware")) {
			return null;
		}
		return new OpenStackVolume(projectName,cloudVo);
	}	
	
	public static VolumeIF getVolumeIF(CustomOssCloudVO cloudVo) {
		if(cloudVo.getCloudType().equals("vmware")) {
			return null;
		}
		return new OpenStackVolume(cloudVo);
	}
	
	public static ImageIF getImageIF(CustomOssCloudVO cloudVo) {
		if(cloudVo.getCloudType().equals("vmware")) {
			return null;
		}
		return new OpenStackImage(cloudVo);
	}

	
	public static MetricIF getMetricIF(CustomOssCloudVO cloudVo) {
		if(cloudVo.getCloudType().equals("vmware")) {
			return null;
		}
		return new OpenStackMetric(cloudVo);
	}

	
	public static SecurityGroupIF getSecurityGroupIF(String projectName,CustomOssCloudVO cloudVo) {
		if(cloudVo.getCloudType().equals("vmware")) {
			return null;
		}
		return new OpenStackSecurityGroup(projectName,cloudVo);
	}
	
	public static UserIF getUserIF(CustomOssCloudVO cloudVo) {
		if(cloudVo.getCloudType().equals("vmware")) {
			return null;
		}
		return new OpenStackUser(cloudVo);
	}

	public static RoleIF getRoleIF(CustomOssCloudVO cloudVo) {
		if(cloudVo.getCloudType().equals("vmware")) {
			return null;
		}
		return new OpenStackRole(cloudVo);
	}
	
	public static LoadbalancerIF getLoadBalancerIF(String projectName,CustomOssCloudVO cloudVo) {
		if(cloudVo.getCloudType().equals("vmware")) {
			return null;
		}
		return getLoadBalancerIF("openstack", projectName,cloudVo);
	}

	public static LoadbalancerIF getLoadBalancerIF(String provider, String projectName,CustomOssCloudVO cloudVo) {
		if(cloudVo.getCloudType().equals("vmware")) {
			return null;
		}
		return new OpenStackLoadbalancer(projectName,cloudVo);
	}
	
	public static ListenerIF getListenerIF(String projectName,CustomOssCloudVO cloudVo) {
		if(cloudVo.getCloudType().equals("vmware")) {
			return null;
		}
		return new OpenStackListener(projectName,cloudVo);
	}	
	
	public static MemberIF getMemberIF(String projectName,CustomOssCloudVO cloudVo) {
		if(cloudVo.getCloudType().equals("vmware")) {
			return null;
		}
		return new OpenStackMember(projectName,cloudVo);
	}
	
	public static PoolIF getPoolIF(String projectName,CustomOssCloudVO cloudVo) {
		if(cloudVo.getCloudType().equals("vmware")) {
			return null;
		}
		return new OpenStackPool(projectName,cloudVo);
	}
	
	public static AlarmIF getAlarmIF(String projectName,CustomOssCloudVO cloudVo) {
		if(cloudVo.getCloudType().equals("vmware")) {
			return null;
		}
		return new OpenStackAlarm(projectName,cloudVo);
	}
	
	public static CustomIF getCustomIF(CustomOssCloudVO cloudVo) {
		if(cloudVo.getCloudType().equals("vmware")) {
			return null;
		}
		return new OpenStackCustom(cloudVo);
	}	
	
	public static HypervisorIF getHypervisorIF(CustomOssCloudVO cloudVo) {
		if(cloudVo.getCloudType().equals("vmware")) {
			return null;
		}
		return new OpenStackHypervisor(cloudVo);
	}

	public static SecurityGroupRuleIF getSecurityGroupRuleIF(String projectName,CustomOssCloudVO cloudVo) {
		if(cloudVo.getCloudType().equals("vmware")) {
			return null;
		}
		return new OpenStackSecurityGroupRule(projectName,cloudVo);
	}
}
