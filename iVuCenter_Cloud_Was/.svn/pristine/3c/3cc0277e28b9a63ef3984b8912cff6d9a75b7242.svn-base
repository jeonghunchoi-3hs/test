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

public class InsertBillInvoiceProjectDetailForAdjustmentitemWriter implements ItemWriter<BatchBillChargeAdjustmentVO> {
	
	private final String batchBillingDAO = "com.ivucenter.cloud.batch.billing.BatchBillingDAO.";
	
	private final String insertBillInvoiceProjectDetail 			= batchBillingDAO + "insertBillInvoiceProjectDetail";
	private final String updateAdjustmentitemBillFlag 				= batchBillingDAO + "updateAdjustmentitemBillFlag";
	private final String selectBillInvoiceProjectDetailCloudProduct	= batchBillingDAO + "selectBillInvoiceProjectDetailCloudProduct";
   
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
        BatchBillInvoiceProjectDetailVO vo;
        String amount;
        BatchBillInvoiceProjectDetailVO result;
        
        for (BatchBillChargeAdjustmentVO item : items) {
        	
        	insertVO = new BatchBillInvoiceProjectDetailVO(); 
        	insertVO.setBillYyyymm(this.billYM);
        	insertVO.setCustomerId(item.getCustomerId());
        	insertVO.setProjectId(item.getProjectId());
        	insertVO.setInvoiceItem(InvoiceTemplate.ADJUST_ITEM.getCode());
        	insertVO.setInvoiceItemSub(item.getAdjustSeq());
        	insertVO.setInvoiceItemName(item.getAdjustContents());
        	insertVO.setInvoiceItemDepth(InvoiceTemplate.ADJUST_ITEM.getDepth());
        	        	
        	vo = new BatchBillInvoiceProjectDetailVO();
        	vo.setBillYyyymm(this.billYM);
        	vo.setProjectId(item.getProjectId());
        	
        	amount = item.getAdjustAmount();
        	
        	if(amount.indexOf("-") > -1){
        		
        		if(amount.indexOf("%") > -1){
        			result = this.sqlSessionTemplate.selectOne(selectBillInvoiceProjectDetailCloudProduct, vo);
        			int result_amount = 0;
        			if (result != null) {
        				result_amount = result.getAmount();
        			}
        			amount = amount.replace("%", "");
        			amount = amount.replace("-", "");
        			insertVO.setAmount( (int)Math.abs(result_amount * Double.parseDouble(amount) / 100 ) * -1);
        		}else{
        			insertVO.setAmount(Integer.parseInt(item.getAdjustAmount()));
        		}
        		
        	}else if(amount.indexOf("+") > -1){
        		
        		if(amount.indexOf("%") > -1){
        			result = this.sqlSessionTemplate.selectOne(selectBillInvoiceProjectDetailCloudProduct, vo);     
        			int result_amount = 0;
        			if (result != null) {
        				result_amount = result.getAmount();
        			}
        			amount = amount.replace("%", "");
        			amount = amount.replace("+", "");
        			insertVO.setAmount( (int)Math.abs(result_amount * Double.parseDouble(amount) / 100 ));
        		}else{
        			insertVO.setAmount(Integer.parseInt(item.getAdjustAmount()));
        		}
        	}

			this.sqlSessionTemplate.insert(insertBillInvoiceProjectDetail, insertVO);
			this.sqlSessionTemplate.update(updateAdjustmentitemBillFlag, item);			
        }		
	}

}
