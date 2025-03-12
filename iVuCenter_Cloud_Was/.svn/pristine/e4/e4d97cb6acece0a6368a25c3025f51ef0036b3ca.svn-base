package com.ivucenter.cloud.portal.mng.req.work;

import java.util.List;

import com.ivucenter.cloud.portal.req.catalogue.CustomReqOrderVO;

public interface MngReqWorkService {

	List<CustomReqOrderVO> excel(CustomMngReqWorkVO req);
	
	/* req_work */
	String getReqWorkList(CustomMngReqWorkVO req);
	CustomMngReqWorkVO getReqWorkView(CustomMngReqWorkVO req);
	CustomMngReqWorkVO getReqLoadWorkView(CustomMngReqWorkVO req);
	CustomMngReqWorkVO getReqSnapWorkView(CustomMngReqWorkVO req);
	List<CustomReqOrderVO> getVmList(CustomMngReqWorkVO req);
	
	CustomMngReqWorkVO getReqWorkchk(String orderProductSeq);
	String setWorkComplete(CustomMngReqWorkVO req);	
	String setWorkChkOk(CustomMngReqWorkVO req);	
	String setWorkReadUpdate(CustomMngReqWorkVO setOssnas);
	
	/* order */
	// bss_order
	List<CustomMngReqWorkVO> getOrderWorkList(CustomMngReqWorkVO req);
	// bss_order_product
	List<CustomMngReqWorkVO> workUserId(String requestSeq);
		
	/* NAS */
	// bss_order_product_nas 
	CustomReqOrderVO orderNasSelect(CustomMngReqWorkVO req);
	// oss_nas 
	String setOssNasInsert(CustomMngOssVo nasValue);
	String setOssNasUpdate(CustomMngOssVo setOssnas);
	String setOssNasChgUpdate(CustomMngOssVo setOssnas);
	String setOssNasHistoryInsert(CustomMngOssVo setOssnas);	
	
	/* LoadBalancer */
	// bss_order_product_loadbalancer 
	CustomReqOrderVO orderLbSelect(CustomMngReqWorkVO req);
	/* oss_loadbalancer */
	String setOssLbInsert(CustomMngOssVo lbValue);
	String setOssLbUpdate(CustomMngOssVo setOsslb);
	String setOssSnUpdate(CustomMngReqWorkVO setOssSn);
	
	/* snapShot */
	CustomReqOrderVO orderSnSelect(CustomMngReqWorkVO req);
	String setOssSnInsert(CustomMngOssVo lbValue);
	// bss_order_product_loadbalancer_vm 
	List<CustomReqOrderVO> orderLbVmSelect(CustomMngReqWorkVO req);
	// oss_loadbalancer_vm 
	String setOssLbVmInsert(CustomMngOssVo lbVmValue);
	
	/* public IP */
	// bss_order_product_publicip
	CustomReqOrderVO orderIpSelect(CustomMngReqWorkVO req);
	// oss_publicip 
	String setOssIpInsert(CustomMngOssVo ipValue);
	String setOssIpUpdate(CustomMngOssVo setOssip);	

	/* Service */
	// bss_order_product_service
	CustomReqOrderVO orderServiceSelect(CustomMngReqWorkVO req);
	String setReqServiceInsert(CustomMngReqWorkVO req);	
	// oss_service
	String setOssServiceInsert(CustomMngOssVo bakValue);	
	String setOssServiceUpdate(CustomMngOssVo setOssback);
	String setOssServiceVmUpdate(CustomMngReqWorkVO req);
	
	String setOssScailOutInsert(CustomMngReqWorkVO req);
	
//	CustomReqOrderVO orderBakSelect(CustomMngReqWorkVO req);
//	String setOssBakInsert(CustomMngOssVo bakValue);
//	CustomReqOrderVO orderMcaSelect(CustomMngReqWorkVO req);
//	String setOssMcaInsert(CustomMngOssVo mcaValue);
//	CustomReqOrderVO orderScmSelect(CustomMngReqWorkVO req);
//	String setOssScmInsert(CustomMngOssVo scmValue);
//	CustomReqOrderVO orderScrSelect(CustomMngReqWorkVO req);
//	String setOssScrInsert(CustomMngOssVo scrValue);
//	List<CustomReqOrderVO> orderBackupVmSelect(CustomMngReqWorkVO req);
//	String setOssBackupVmInsert(CustomMngOssVo backupVmValue);
//	String setOssBakUpdate(CustomMngOssVo setOssback);
//	String setOssMcaUpdate(CustomMngOssVo setOssmca);
//	String setOssScmUpdate(CustomMngOssVo setOssscm);
//	String setOssScrUpdate(CustomMngOssVo setOssscr);
}
