package com.ivucenter.cloud.batch.billing;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.batch.item.ItemWriter;
import org.springframework.beans.factory.annotation.Autowired;

import com.ivucenter.cloud.batch.entity.BatchBillChargeResourceDetailVO;
import com.ivucenter.cloud.batch.entity.BatchBillPolicyItemPriceVO;
import com.ivucenter.cloud.portal.util.DateUtils;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class InsertBillChargeVmResourceDetailForOsDiskWriter implements ItemWriter<BatchBillChargeResourceDetailVO> {	

	/* MEMORY RPRICE CODE */
	private final String batchBillingDAO = "com.ivucenter.cloud.batch.billing.BatchBillingDAO.";
	
	private final String selectListBillPolicyItemPrice 		= batchBillingDAO + "selectListBillPolicyItemPrice";
	private final String insertBillChargeVmResourceDetail 	= batchBillingDAO + "insertBillChargeVmResourceDetail";
	private final String selectVolumType		= batchBillingDAO + "selectVolumType";
//	private final String selectImageType		= batchBillingDAO + "selectImageType";
	
	@Autowired
	private CommonBillService commonBillService;

	@Setter
	private SqlSessionFactory sqlSessionFactory;
	
	@Setter
	private Map<String, Object> parameterValues;

	private SqlSessionTemplate sqlSessionTemplate;
//	private String billYM;
    private Date baseBillStartDate;
//    private Date baseBillEndDate;

	@Override
	public void write(List<? extends BatchBillChargeResourceDetailVO> items) throws Exception {
		this.sqlSessionTemplate = new SqlSessionTemplate(sqlSessionFactory, ExecutorType.SIMPLE);
		
//        this.billYM = (String) this.parameterValues.get("billYM");
        this.baseBillStartDate = (Date) this.parameterValues.get("baseBillStartDate");
//        this.baseBillEndDate = (Date) this.parameterValues.get("baseBillEndDate");
        
		/* insert Resource Detail List */
        for (BatchBillChargeResourceDetailVO item : items) {
			int year = DateUtils.getYear(baseBillStartDate);
			int month = DateUtils.getMonth(baseBillStartDate);
			
			/* get Price distType */
	        Map<String, Object> paramMap = new HashMap<String, Object>();
	        paramMap.put("cloudId", item.getCloudId());
	        paramMap.put("applyDate", this.baseBillStartDate);
			// ITEMCATE_DISK_SAN	블록디스크SAN	hitachi-g900	DISK010	
	        // ITEMCATE_DISK_SAS	블록디스크SAS	ceph-sas	    DISK011	
	        // ITEMCATE_DISK_SATA	블록디스크SATA	ceph-sata	    DISK012
			paramMap.put("volumType", item.getVolumeType());
	        // 블록디스크 볼륨타입 가격코드 공통코드 code_value1 컬럼
	        BatchBillPolicyItemPriceVO volumPriceInfo = sqlSessionTemplate.selectOne(selectVolumType, paramMap);
	        paramMap.put("itemId", volumPriceInfo.getVolumPriceCode());
	        
	        BatchBillPolicyItemPriceVO itemPrice = this.sqlSessionTemplate.selectOne(selectListBillPolicyItemPrice, paramMap);
	        
	        log.debug("baseBillStartDate=" + baseBillStartDate + ", year=" + year + ", month=" + month);
	        item = commonBillService.getChargeResourceDetail(year, month, item, itemPrice);
	        
	        // oss_disk 운영체제 코드가 없으면 운영체제 비용 없음
	        if(!item.getImageItemId().equals("#")) {
	        	
	        	 /* get Price imageType*/
	        	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
	            Map<String, Object> paramImageMap = new HashMap<String, Object>();
	            paramImageMap.put("cloudId", item.getCloudId());
	            paramImageMap.put("applyDate", format.format(this.baseBillStartDate));
	        	paramImageMap.put("itemId", item.getImageItemId());
	        	BatchBillPolicyItemPriceVO itemPrice2 = this.sqlSessionTemplate.selectOne(selectListBillPolicyItemPrice, paramImageMap);
	        	// 해당 디스크에 OS 수량변경 
	        	item.setMeasureValue(1);
	        	
	        	
	        	BatchBillChargeResourceDetailVO item2 = commonBillService.getChargeResourceDetailSub(year, month, item, itemPrice2);
	        	
	        	//diskType가격 + vm 이미지 가격
	        	item.setAmount(item.getAmount() + item2.getAmountSub());
	        	item.setImageItemId(item2.getImageItemId());
	        }
    	
			this.sqlSessionTemplate.insert(insertBillChargeVmResourceDetail, item);
        }        
	}
}
