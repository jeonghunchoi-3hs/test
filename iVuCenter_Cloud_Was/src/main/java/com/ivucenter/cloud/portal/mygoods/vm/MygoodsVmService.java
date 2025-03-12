package com.ivucenter.cloud.portal.mygoods.vm;

public interface MygoodsVmService {
	
	public String list(CustomMygoodsVmVO req);
	
	public CustomMygoodsVmVO detail(CustomMygoodsVmVO req);
	
	public CustomMygoodsVmVO insert(CustomMygoodsVmVO req);

	public CustomMygoodsVmVO update(CustomMygoodsVmVO req);
	
	public CustomMygoodsVmVO delete(CustomMygoodsVmVO req);
}
