package com.ivucenter.cloud.batch.billing;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.batch.item.ItemWriter;

import com.ivucenter.cloud.batch.entity.BatchBillInvoiceProjectDetailVO;

import lombok.Setter;

public class InsertBillInvoiceProjectDetailForServiceWriter implements ItemWriter<BatchBillInvoiceProjectDetailVO> {
	
	private final String batchBillingDAO = "com.ivucenter.cloud.batch.billing.BatchBillingDAO.";
	
	private final String insertBillInvoiceProjectDetail 	= batchBillingDAO + "insertBillInvoiceProjectDetail";

    
	@Setter
	private SqlSessionFactory sqlSessionFactory;
    
	@Setter
	private Map<String, Object> parameterValues;

	private SqlSessionTemplate sqlSessionTemplate;
//	private String billYM;
//    private Date baseBillStartDate;
//    private Date baseBillEndDate;

	@Override
	public void write(List<? extends BatchBillInvoiceProjectDetailVO> items) throws Exception {
		this.sqlSessionTemplate = new SqlSessionTemplate(sqlSessionFactory, ExecutorType.SIMPLE);
		
//        this.billYM = (String) this.parameterValues.get("billYM");
//        this.baseBillStartDate = (Date) this.parameterValues.get("baseBillStartDate");
//        this.baseBillEndDate = (Date) this.parameterValues.get("baseBillEndDate");

        
        for (BatchBillInvoiceProjectDetailVO item : items) {
			item.setInvoiceItem(InvoiceTemplate.SERVICE.getCode());
			item.setInvoiceItemSub("*");
			item.setInvoiceItemName(InvoiceTemplate.SERVICE.getLabel());
			item.setInvoiceItemDepth(InvoiceTemplate.SERVICE.getDepth());

			this.sqlSessionTemplate.insert(insertBillInvoiceProjectDetail, item);
        }
		
	}

}
