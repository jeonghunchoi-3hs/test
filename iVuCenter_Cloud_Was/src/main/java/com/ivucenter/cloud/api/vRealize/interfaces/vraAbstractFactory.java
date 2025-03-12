package com.ivucenter.cloud.api.vRealize.interfaces;

import com.ivucenter.cloud.api.vRealize.vrealizeCatalogue;
import com.ivucenter.cloud.api.vRealize.vrealizeDisk;
import com.ivucenter.cloud.api.vRealize.vrealizeFlavor;
import com.ivucenter.cloud.api.vRealize.vrealizeHost;
import com.ivucenter.cloud.api.vRealize.vrealizeIdentity;
import com.ivucenter.cloud.api.vRealize.vrealizeNetwork;
import com.ivucenter.cloud.api.vRealize.vrealizeProject;
import com.ivucenter.cloud.api.vRealize.vrealizeServer;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;

public class vraAbstractFactory {
	public static vraIdentityIF getIdentity(String cloudId) {
		// TODO 
	      CustomOssCloudVO cloudVo = new CustomOssCloudVO(); 
	      // DB 작업하여 CustomOssClooudVO 를 가져온다. 
	      return getIdentity(cloudVo);
	}
	
	public static vraIdentityIF getIdentity(CustomOssCloudVO cloudVo) {
		return new vrealizeIdentity(cloudVo);
	}
	
	public static vraProjectIF getProject(CustomOssCloudVO cloudVo) {
		return new vrealizeProject(cloudVo);
	}
	public static vraServerIF getServerIF(CustomOssCloudVO cloudVo) {
		return new vrealizeServer(cloudVo);
	}
	
	public static vraDiskIF getDiskIF(CustomOssCloudVO cloudVo) {
		return new vrealizeDisk(cloudVo);
	}
	
	public static vraHostIF getHostIF(CustomOssCloudVO cloudVo) {
		return new vrealizeHost(cloudVo);
	}
	
	public static vraFlavorIF getFlavorIF(CustomOssCloudVO cloudVo) {
		return new vrealizeFlavor(cloudVo);
	}
	
	public static vraCatalogIF getCatalogueIF(CustomOssCloudVO cloudVo) {
		return new vrealizeCatalogue(cloudVo);
	}
	
	public static vraNetworkIF getNetworkIF(CustomOssCloudVO cloudVo) {
		return new vrealizeNetwork(cloudVo);
	}
	/*
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
	}*/
}
