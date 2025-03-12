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
import org.springframework.util.Assert;

import com.ivucenter.cloud.batch.entity.BatchBillChargeResourceDetailVO;
import com.ivucenter.cloud.batch.entity.BatchBillPolicyItemPriceVO;
import com.ivucenter.cloud.portal.util.DateUtils;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class InsertBillChargeVmResourceDetailCpuWriter implements ItemWriter<List<BatchBillChargeResourceDetailVO>> {	

	private final String ITEM_PRICE_CODE = "CPU010";

	private final String batchBillingDAO = "com.ivucenter.cloud.batch.billing.BatchBillingDAO.";
	
	private final String selectListBillPolicyItemPrice 		= batchBillingDAO + "selectListBillPolicyItemPrice";
	private final String insertBillChargeVmResourceDetail 	= batchBillingDAO + "insertBillChargeVmResourceDetail";

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
        		Assert.notNull(detail, "ddd");
        		 /* get Price */
                Map<String, Object> paramMap = new HashMap<String, Object>();
                paramMap.put("cloudId", detail.getCloudId());
                paramMap.put("applyDate", this.baseBillStartDate);
                paramMap.put("itemId", this.ITEM_PRICE_CODE);
                
                BatchBillPolicyItemPriceVO itemPrice = this.sqlSessionTemplate.selectOne(selectListBillPolicyItemPrice, paramMap);
                
    			int year = DateUtils.getYear(baseBillStartDate);
    			int month = DateUtils.getMonth(baseBillStartDate);
        		
    			log.debug("baseBillStartDate=" + baseBillStartDate + ", year=" + year + ", month=" + month);
        		
                detail = commonBillService.getChargeResourceDetail(year, month, detail, itemPrice);
                
                Assert.notNull(detail, "ddd");
            	//log.debug(detail.toString());

            	this.sqlSessionTemplate.insert(insertBillChargeVmResourceDetail, detail);
        	}        	
        }		
	}
}
