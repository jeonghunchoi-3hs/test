package com.ivucenter.cloud.batch.billing;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.batch.item.ItemWriter;

import com.ivucenter.cloud.batch.entity.BatchBillInvoiceCustomerVO;
import com.ivucenter.cloud.portal.util.DateUtils;

import lombok.Setter;

public class InsertBillInvoiceCustomerWriter implements ItemWriter<BatchBillInvoiceCustomerVO> {
	
	private final String batchBillingDAO = "com.ivucenter.cloud.batch.billing.BatchBillingDAO.";
	
	private final String insertBillInvoiceCustomer 		= batchBillingDAO + "insertBillInvoiceCustomer";

    @Setter
	private SqlSessionFactory sqlSessionFactory;
    
    @Setter
	private Map<String, Object> parameterValues;
	
	private String billYM;
	private SqlSessionTemplate sqlSessionTemplate;
    private Date baseBillStartDate;
    private Date baseBillEndDate;
    
	@Override
	public void write(List<? extends BatchBillInvoiceCustomerVO> items) throws Exception {
		this.sqlSessionTemplate = new SqlSessionTemplate(sqlSessionFactory, ExecutorType.BATCH);
		
        this.billYM = (String) this.parameterValues.get("billYM");

        baseBillEndDate = DateUtils.convertStringToDate(billYM + "01", "Asia/Seoul", "yyyyMMdd");
        baseBillStartDate = DateUtils.addMonths(baseBillEndDate, -1);
        baseBillEndDate = DateUtils.addDays(baseBillEndDate, -1);
        
		for (BatchBillInvoiceCustomerVO item : items) {
	    	item.setBillYyyymm(billYM);
	    	item.setBillStartDatetime(baseBillStartDate);
	    	item.setBillEndDatetime(baseBillEndDate);
	    	this.sqlSessionTemplate.insert(insertBillInvoiceCustomer, item);
		}		
	}

}
