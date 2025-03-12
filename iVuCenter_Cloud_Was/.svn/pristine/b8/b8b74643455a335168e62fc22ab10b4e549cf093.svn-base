package com.ivucenter.cloud.batch.billing;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.batch.item.ItemWriter;

import com.ivucenter.cloud.batch.entity.BatchBillChargeAdjustmentVO;
import com.ivucenter.cloud.batch.entity.BatchBillInvoiceProjectDetailVO;

import lombok.Setter;

public class InsertBillInvoiceProjectDetailForAdjustmentsumWriter implements ItemWriter<BatchBillChargeAdjustmentVO> {
	
	private final String batchBillingDAO = "com.ivucenter.cloud.batch.billing.BatchBillingDAO.";
	
	private final String insertBillInvoiceProjectDetail 	= batchBillingDAO + "insertBillInvoiceProjectDetail";
    
	@Setter
	private SqlSessionFactory sqlSessionFactory;
    
	@Setter
	private Map<String, Object> parameterValues;

	private SqlSessionTemplate sqlSessionTemplate;
	private String billYM;
//    private Date baseBillStartDate;
//    private Date baseBillEndDate;

	@Override
	public void write(List<? extends BatchBillChargeAdjustmentVO> items) throws Exception {
		this.sqlSessionTemplate = new SqlSessionTemplate(sqlSessionFactory, ExecutorType.SIMPLE);
		
        this.billYM = (String) this.parameterValues.get("billYM");
//        this.baseBillStartDate = (Date) this.parameterValues.get("baseBillStartDate");
//        this.baseBillEndDate = (Date) this.parameterValues.get("baseBillEndDate");
        BatchBillInvoiceProjectDetailVO insertVO;
              
        for (BatchBillChargeAdjustmentVO item : items) {
        	
        	insertVO = new BatchBillInvoiceProjectDetailVO(); 
        	insertVO.setBillYyyymm(this.billYM);
        	insertVO.setCustomerId(item.getCustomerId());
        	insertVO.setProjectId(item.getProjectId());
        	insertVO.setInvoiceItem(InvoiceTemplate.ADJUST_SUM.getCode());
        	insertVO.setInvoiceItemSub("*");        	
        	insertVO.setInvoiceItemName(InvoiceTemplate.ADJUST_SUM.getLabel());
        	insertVO.setInvoiceItemDepth(InvoiceTemplate.ADJUST_SUM.getDepth());
        	insertVO.setAmount(Integer.parseInt(String.valueOf(item.getAdjustAmount()))); 

			this.sqlSessionTemplate.insert(insertBillInvoiceProjectDetail, insertVO);
        }		
	}

}
