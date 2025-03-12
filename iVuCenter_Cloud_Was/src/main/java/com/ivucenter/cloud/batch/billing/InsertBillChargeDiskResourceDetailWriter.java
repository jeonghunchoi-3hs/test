package com.ivucenter.cloud.batch.billing;

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
public class InsertBillChargeDiskResourceDetailWriter implements ItemWriter<List<BatchBillChargeResourceDetailVO>> {

	/* CPU RPRICE CODE */
	private final String batchBillingDAO = "com.ivucenter.cloud.batch.billing.BatchBillingDAO.";
	
	private final String selectListBillPolicyItemPrice 		= batchBillingDAO + "selectListBillPolicyItemPrice";
	private final String selectVolumType					= batchBillingDAO + "selectVolumType";
	private final String insertBillChargeDiskResourceDetail = batchBillingDAO + "insertBillChargeDiskResourceDetail";
    
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
	public void write(List<? extends List<BatchBillChargeResourceDetailVO>> items) throws Exception {
		this.sqlSessionTemplate = new SqlSessionTemplate(sqlSessionFactory, ExecutorType.SIMPLE);
		
//        this.billYM = (String) this.parameterValues.get("billYM");
        this.baseBillStartDate = (Date) this.parameterValues.get("baseBillStartDate");
//        this.baseBillEndDate = (Date) this.parameterValues.get("baseBillEndDate");

        /* insert Resource Detail List */
        for (List<BatchBillChargeResourceDetailVO> item : items) {
        	for (BatchBillChargeResourceDetailVO detail : item) {
    			/* get Price */
    	        Map<String, Object> paramMap = new HashMap<String, Object>();
    	        paramMap.put("cloudId", detail.getCloudId());
    	        paramMap.put("applyDate", this.baseBillStartDate);
    			// ITEMCATE_DISK_SAN	블록디스크SAN	hitachi-g900	DISK010	
    	        // ITEMCATE_DISK_SAS	블록디스크SAS	ceph-sas	    DISK011	
    	        // ITEMCATE_DISK_SATA	블록디스크SATA	ceph-sata	    DISK012
    			paramMap.put("volumType", detail.getVolumeType());
    	        // 블록디스크 볼륨타입 가격코드 공통코드 code_value1 컬럼
    	        BatchBillPolicyItemPriceVO volumPriceInfo = this.sqlSessionTemplate.selectOne(selectVolumType, paramMap);
    	        paramMap.put("itemId", volumPriceInfo.getVolumPriceCode());
    	        
    	        BatchBillPolicyItemPriceVO itemPrice = this.sqlSessionTemplate.selectOne(selectListBillPolicyItemPrice, paramMap);
        		    	        
    	        int year = DateUtils.getYear(baseBillStartDate);
    			int month = DateUtils.getMonth(baseBillStartDate);
    			log.debug("baseBillStartDate=" + baseBillStartDate + ", year=" + year + ", month=" + month);        		
                
    			detail = commonBillService.getChargeResourceDetail(year, month, detail, itemPrice);
            	this.sqlSessionTemplate.insert(insertBillChargeDiskResourceDetail, detail);
        	}        	
        }		
	}
}
