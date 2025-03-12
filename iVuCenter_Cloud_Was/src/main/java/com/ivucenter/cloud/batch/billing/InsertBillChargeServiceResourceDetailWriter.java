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
public class InsertBillChargeServiceResourceDetailWriter implements ItemWriter<List<BatchBillChargeResourceDetailVO>> {	

	private final String batchBillingDAO = "com.ivucenter.cloud.batch.billing.BatchBillingDAO.";
	
	private final String selectListBillPolicyItemPrice 			= batchBillingDAO + "selectListBillPolicyItemPrice";
	private final String insertBillChargeServiceResourceDetail 	= batchBillingDAO + "insertBillChargeServiceResourceDetail";
    
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

        /* get Price */
        Map<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.put("applyDate", this.baseBillStartDate);
                
		/* insert Resource Detail List */
        for (List<BatchBillChargeResourceDetailVO> item : items) {
        	for (BatchBillChargeResourceDetailVO detail : item) {
        		
        		//SERVICE010	서비스 상품(계정관리)	  01
        		//SERVICE011	서비스 상품(보안관제)	  02
        		//SERVICE012	서비스 상품(백업)	      03
        		//SERVICE013	서비스 상품(SW설치)	  04	
        		//SERVICE014	서비스 상품(디스크관리) 05
        		
        		if(detail.getServiceType().equals("01")) {
                    paramMap.put("itemId", "SERVICE010");
        		}else if(detail.getServiceType().equals("02")) {
                    paramMap.put("itemId", "SERVICE011");
        		}else if(detail.getServiceType().equals("03")) {
                    paramMap.put("itemId", "SERVICE012");
        		}else if(detail.getServiceType().equals("04")) {
                    paramMap.put("itemId", "SERVICE013");
        		}else if(detail.getServiceType().equals("05")) {
                    paramMap.put("itemId", "SERVICE014");
        		}
        		
        		paramMap.put("cloudId",detail.getCloudId());
        		
                BatchBillPolicyItemPriceVO itemPrice = this.sqlSessionTemplate.selectOne(selectListBillPolicyItemPrice, paramMap);
        		
    			int year = DateUtils.getYear(baseBillStartDate);
    			int month = DateUtils.getMonth(baseBillStartDate);
        		
    			log.debug("baseBillStartDate=" + baseBillStartDate + ", year=" + year + ", month=" + month);
        		
                detail = commonBillService.getChargeResourceDetail(year, month, detail, itemPrice);
                
            	//logger.debug(detail.toString());

            	this.sqlSessionTemplate.insert(insertBillChargeServiceResourceDetail, detail);
        	}        	
        }		
	}
}
