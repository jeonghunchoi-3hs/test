package com.ivucenter.cloud.batch.billing;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.batch.item.ItemWriter;

import com.ivucenter.cloud.batch.entity.BatchBillInvoiceCustomerDetailVO;

import lombok.Setter;

public class InsertBillInvoiceCustomerDetailForTotalAmountWriter implements ItemWriter<BatchBillInvoiceCustomerDetailVO> {
	
	private final String batchBillingDAO = "com.ivucenter.cloud.batch.billing.BatchBillingDAO.";
	
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
        	int orgAmount = item.getAmount();
        	int newAmount = orgAmount / 10 * 10;
        	int discountAmount = newAmount - orgAmount;
        	
        	/* 총 청구금액(0000) */
        	item.setInvoiceItem(InvoiceTemplate.TOTAL_AMOUNT.getCode());
        	item.setInvoiceItemSub("*");
        	item.setInvoiceItemName(InvoiceTemplate.TOTAL_AMOUNT.getLabel());
        	item.setInvoiceItemDepth(InvoiceTemplate.TOTAL_AMOUNT.getDepth());

        	item.setAmount(newAmount);
        	
        	this.sqlSessionTemplate.insert(insertBillInvoiceCustomerDetail, item);
        	
        	/* 10원미만 절사 할인(EL00) */
        	item.setInvoiceItem(InvoiceTemplate.WON_TRIM_DISCOUNT.getCode());
        	item.setInvoiceItemSub("*");
        	item.setInvoiceItemName(InvoiceTemplate.WON_TRIM_DISCOUNT.getLabel());
        	item.setInvoiceItemDepth(InvoiceTemplate.WON_TRIM_DISCOUNT.getDepth());

        	item.setAmount(discountAmount);
        	
        	this.sqlSessionTemplate.insert(insertBillInvoiceCustomerDetail, item);        	
        }		
	}

}
