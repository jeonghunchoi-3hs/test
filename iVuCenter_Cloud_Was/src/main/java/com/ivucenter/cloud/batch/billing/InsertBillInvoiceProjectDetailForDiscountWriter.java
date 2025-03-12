package com.ivucenter.cloud.batch.billing;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.batch.item.ItemWriter;

import com.ivucenter.cloud.batch.entity.BatchBillChargeDiscountVO;
import com.ivucenter.cloud.batch.entity.BatchBillInvoiceProjectDetailVO;

import lombok.Setter;

public class InsertBillInvoiceProjectDetailForDiscountWriter implements ItemWriter<BatchBillChargeDiscountVO> {

	private final String batchBillingDAO = "com.ivucenter.cloud.batch.billing.BatchBillingDAO.";
	
	private final String batchSelectBillInvoiceProjectDetailForDiscount = batchBillingDAO + "batchSelectBillInvoiceProjectDetailForDiscount";
	private final String insertBillInvoiceProjectDetail 				= batchBillingDAO + "insertBillInvoiceProjectDetail";
    
	@Setter
	private SqlSessionFactory sqlSessionFactory;
    
	@Setter
	private Map<String, Object> parameterValues;

	private SqlSessionTemplate sqlSessionTemplate;
	private String billYM;
//    private Date baseBillStartDate;
//    private Date baseBillEndDate;

	@Override
	public void write(List<? extends BatchBillChargeDiscountVO> items) throws Exception {
		this.sqlSessionTemplate = new SqlSessionTemplate(sqlSessionFactory, ExecutorType.SIMPLE);
		
        this.billYM = (String) this.parameterValues.get("billYM");
//        this.baseBillStartDate = (Date) this.parameterValues.get("baseBillStartDate");
//        this.baseBillEndDate = (Date) this.parameterValues.get("baseBillEndDate");
        
        int discountAmount = 0;     
        Double tmpAmount;
        Double rate;
        BatchBillInvoiceProjectDetailVO paramMap;
        BatchBillInvoiceProjectDetailVO insteVo;
        
        
        for (BatchBillChargeDiscountVO item : items) {
        	
        	paramMap = new BatchBillInvoiceProjectDetailVO();
        	paramMap.setProjectId(item.getProjectId());
        	paramMap.setBillYyyymm(this.billYM);        	
        	
        	BatchBillInvoiceProjectDetailVO  vo = this.sqlSessionTemplate.selectOne(batchSelectBillInvoiceProjectDetailForDiscount, paramMap);
        	
        	
        	if(vo != null){
        		rate = Double.parseDouble(item.getDiscountRate());
        		tmpAmount = (Double) (vo.getAmount() * rate);
        		discountAmount = (int) Math.round(tmpAmount) * -1;
        		
            	insteVo = new BatchBillInvoiceProjectDetailVO();
            	insteVo.setBillYyyymm(this.billYM);
            	insteVo.setProjectId(vo.getProjectId());
            	insteVo.setCustomerId(vo.getCustomerId());
            	insteVo.setAmount(discountAmount);
            	insteVo.setInvoiceItem(InvoiceTemplate.PROJECT_DISCOUNT.getCode());
            	insteVo.setInvoiceItemSub("*");
            	insteVo.setInvoiceItemName(InvoiceTemplate.PROJECT_DISCOUNT.getLabel());
            	insteVo.setInvoiceItemDepth(InvoiceTemplate.PROJECT_DISCOUNT.getDepth());

    			this.sqlSessionTemplate.insert(insertBillInvoiceProjectDetail, insteVo);
        	}
        }	
	}

}
