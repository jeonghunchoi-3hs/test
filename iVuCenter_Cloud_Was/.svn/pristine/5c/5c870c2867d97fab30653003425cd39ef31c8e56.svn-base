package com.ivucenter.cloud.api.vmware.interfaces;

import com.ivucenter.cloud.api.vmware.VMWareIdentity;
import com.ivucenter.cloud.api.vmware.VMWareServer;
import com.ivucenter.cloud.api.vmware.VmDataStore;
import com.ivucenter.cloud.api.vmware.VmHardwareCpu;
import com.ivucenter.cloud.api.vmware.VmHardwareMem;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;

public class VmAbstractFactory {
	public static VmIdentityIF getIdentity(String cloudId) {
		// TODO 
	      CustomOssCloudVO cloudVo = new CustomOssCloudVO(); 
	      // DB 작업하여 CustomOssClooudVO 를 가져온다. 
	      return getIdentity(cloudVo);
	}
	
	public static VmIdentityIF getIdentity(CustomOssCloudVO cloudVo) {
		return new VMWareIdentity(cloudVo);
	}
	
	public static VmServerIF getServerIF(CustomOssCloudVO cloudVo) {
		return new VMWareServer(cloudVo);
	}
	
	//vmware의 floder를 project처럼 못쓰면 값 필요없어서 필요 없을듯.
	public static VmServerIF getServerIF(String projectName, CustomOssCloudVO cloudVo) {
		return new VMWareServer(projectName,cloudVo);
	}
	
	public static VmHardwareCpuIF getVmHardwareCpuIF(CustomOssCloudVO cloudVo) {
		return new VmHardwareCpu(cloudVo);
	}
	
	public static VmHardwareMemIF getVmHardwareMemIF(String projectName, String vmId, CustomOssCloudVO cloudVo) {
		return new VmHardwareMem(projectName, vmId, cloudVo);
	}
	
	public static VmDataStoreIF getVmDataStoreIF(CustomOssCloudVO cloudVo) {
		return new VmDataStore(cloudVo);
	}
}
