package com.ivucenter.cloud.portal.bss.batch;

public interface BssBatchService {
	
	public String bssBatchList(CustomBssBatchVO batchVo);
	
	public CustomBssBatchVO bssBatchDetail(CustomBssBatchVO batchVo);

	public String bssBatchInsert(CustomBssBatchVO batchVo);

	public String bssBatchUpdate(CustomBssBatchVO batchVo);

	public String bssBatchDelete(CustomBssBatchVO batchVo);

}
