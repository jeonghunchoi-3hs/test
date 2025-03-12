package com.ivucenter.cloud.batch.billing;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.batch.item.ItemWriter;

import com.ivucenter.cloud.batch.entity.BatchBillInvoiceCustomerDetailVO;

import lombok.Setter;

public class InsertBillInvoiceCustomerDetailForVatWriter implements ItemWriter<BatchBillInvoiceCustomerDetailVO> {
	
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
        	int vatRate = item.getVatRate();
        	int vatAmount = (int)((double)item.getAmount() * ((double)vatRate / 100d));
        	
        	/* 부가가치세(LA00) */
        	item.setInvoiceItem(InvoiceTemplate.VAT_ITEM.getCode());
        	item.setInvoiceItemSub("*");
        	item.setInvoiceItemName(InvoiceTemplate.VAT_ITEM.getLabel());
        	item.setInvoiceItemDepth(InvoiceTemplate.VAT_ITEM.getDepth());
        	
        	item.setAmount(vatAmount);
        	
        	this.sqlSessionTemplate.insert(insertBillInvoiceCustomerDetail, item);
        	
        	/* 부가가치세(L000) */
        	item.setInvoiceItem(InvoiceTemplate.VAT_SUM.getCode());
        	item.setInvoiceItemSub("*");
        	item.setInvoiceItemName(InvoiceTemplate.VAT_SUM.getLabel());
        	item.setInvoiceItemDepth(InvoiceTemplate.VAT_SUM.getDepth());

        	item.setAmount(vatAmount);
        	
        	this.sqlSessionTemplate.insert(insertBillInvoiceCustomerDetail, item);        	
        }		
	}

}
