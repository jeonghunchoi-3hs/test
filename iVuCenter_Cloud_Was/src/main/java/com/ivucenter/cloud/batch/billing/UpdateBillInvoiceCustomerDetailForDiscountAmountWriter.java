package com.ivucenter.cloud.batch.billing;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.batch.item.ItemWriter;

import com.ivucenter.cloud.batch.entity.BatchBillInvoiceCustomerDetailVO;

import lombok.Setter;

public class UpdateBillInvoiceCustomerDetailForDiscountAmountWriter implements ItemWriter<BatchBillInvoiceCustomerDetailVO> {

	private final String batchBillingDAO = "com.ivucenter.cloud.batch.billing.BatchBillingDAO.";
	
	private final String selectCheckExistsForDiscount 		= batchBillingDAO + "selectCheckExistsForDiscount";
	private final String updateDiscountAmountForBillInvoiceCustomerDetail = batchBillingDAO + "updateDiscountAmountForBillInvoiceCustomerDetail";
	private final String insertBillInvoiceCustomerDetail 	= batchBillingDAO + "insertBillInvoiceCustomerDetail";

    
	@Setter
	private SqlSessionFactory sqlSessionFactory;
    
	@Setter
	private Map<String, Object> parameterValues;

	private SqlSessionTemplate sqlSessionTemplate;
//	private String billYM;
//    private Date baseBillStartDate;
//    private Date baseBillEndDate;

	@Override
	public void write(List<? extends BatchBillInvoiceCustomerDetailVO> items) throws Exception {
		
		this.sqlSessionTemplate = new SqlSessionTemplate(sqlSessionFactory, ExecutorType.SIMPLE);
		
//        this.billYM = (String) this.parameterValues.get("billYM");
//        this.baseBillStartDate = (Date) this.parameterValues.get("baseBillStartDate");
//        this.baseBillEndDate = (Date) this.parameterValues.get("baseBillEndDate");
        
        for (BatchBillInvoiceCustomerDetailVO item : items) {
        	
        	BatchBillInvoiceCustomerDetailVO resultSet = sqlSessionTemplate.selectOne(selectCheckExistsForDiscount, item);
        	
    		item.setInvoiceItem(InvoiceTemplate.DISCOUNT_SUM.getCode());
    		item.setInvoiceItemSub("*");
    		item.setInvoiceItemDepth(InvoiceTemplate.DISCOUNT_SUM.getDepth());
    		item.setInvoiceItemName(InvoiceTemplate.DISCOUNT_SUM.getLabel());
    		
        	if (resultSet == null) {
            	this.sqlSessionTemplate.insert(insertBillInvoiceCustomerDetail, item);
        	} else {
            	this.sqlSessionTemplate.insert(updateDiscountAmountForBillInvoiceCustomerDetail, item);
        	}        	
        }		
	}

}
